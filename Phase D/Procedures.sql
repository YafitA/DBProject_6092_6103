-- ================================================
-- פרוצדורה 1: ניהול פרויקטים - הקצאה והסרה אוטומטית
-- ================================================
CREATE OR REPLACE PROCEDURE manage_volunteer_projects(
    IN action_type VARCHAR,
    IN p_volunteer_id INTEGER,
    IN p_project_id INTEGER DEFAULT NULL
) AS $$
DECLARE
    vol_rec RECORD;
    proj_rec RECORD;
    current_projects INTEGER;
    suitable_projects INTEGER[];
    selected_project INTEGER;
    i INTEGER;
BEGIN
    -- בדיקת קיום המתנדב
    SELECT v.*, p.first_name, p.last_name, p.email_address
    INTO vol_rec
    FROM volunteer v
    JOIN person p ON v.volunteer_id = p.id
    WHERE v.volunteer_id = p_volunteer_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Volunteer with ID % not found', p_volunteer_id;
    END IF;

    -- בדיקת סוג הפעולה
    IF action_type = 'ADD' THEN
        -- הוספת מתנדב לפרויקט
        IF p_project_id IS NULL THEN
            -- בחירה אוטומטית של פרויקט מתאים
            SELECT COUNT(*) INTO current_projects
            FROM volunteerProject
            WHERE volunteer_id = p_volunteer_id;

            -- אם למתנדב יש פחות מ-3 פרויקטים, חפש פרויקט מתאים
            IF current_projects < 3 THEN
                -- מציאת פרויקטים פעילים שהמתנדב לא משתתף בהם
                SELECT ARRAY_AGG(pr.project_id) INTO suitable_projects
                FROM project pr
                WHERE pr.end_date > CURRENT_DATE
                AND pr.project_id NOT IN (
                    SELECT vp.project_id
                    FROM volunteerProject vp
                    WHERE vp.volunteer_id = p_volunteer_id
                );

                IF array_length(suitable_projects, 1) > 0 THEN
                    selected_project := suitable_projects[1];

                    INSERT INTO volunteerProject (volunteer_id, project_id)
                    VALUES (p_volunteer_id, selected_project);

                    RAISE NOTICE 'Volunteer % was assigned to project %', vol_rec.first_name || ' ' || vol_rec.last_name, selected_project;
                ELSE
                    RAISE NOTICE 'o suitable projects found for volunteer %', vol_rec.first_name;
                END IF;
            ELSE
                RAISE NOTICE 'Volunteer % is already assigned to % projects (maximum is 3)', vol_rec.first_name, current_projects;
            END IF;
        ELSE
            -- הוספה לפרויקט ספציפי
            SELECT * INTO proj_rec FROM project WHERE project_id = p_project_id;

            IF NOT FOUND THEN
                RAISE EXCEPTION 'Project with ID % not found', p_project_id;
            END IF;

            INSERT INTO volunteerProject (volunteer_id, project_id)
            VALUES (p_volunteer_id, p_project_id)
            ON CONFLICT DO NOTHING;

            RAISE NOTICE 'Volunteer % was assigned to project %', vol_rec.first_name, proj_rec.project_name;
        END IF;

    ELSIF action_type = 'REMOVE' THEN
        -- הסרת מתנדב מפרויקט
        IF p_project_id IS NULL THEN
            -- הסרה מכל הפרויקטים
            DELETE FROM volunteerProject WHERE volunteer_id = p_volunteer_id;
            RAISE NOTICE 'Volunteer % was removed from all projects', vol_rec.first_name;
        ELSE
            -- הסרה מפרויקט ספציפי
            DELETE FROM volunteerProject
            WHERE volunteer_id = p_volunteer_id AND project_id = p_project_id;
            RAISE NOTICE 'Volunteer % was removed from project %', vol_rec.first_name, p_project_id;
        END IF;

    ELSE
        RAISE EXCEPTION 'Invalid action type: %. Use ADD or REMOVE', action_type;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'Error in project management: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;



-- ================================================
-- פרוצדורה 2: עדכון סטטוס ציוד רפואי עם דוח מפורט
-- ================================================
CREATE OR REPLACE PROCEDURE update_equipment_status_report(
    OUT updated_count INTEGER,
    OUT report_text TEXT,
    IN equipment_age_threshold INTEGER DEFAULT 5
) AS $$
DECLARE
    equip_rec RECORD;
    equip_cursor CURSOR FOR
        SELECT equipment_id, equipment_name, destination_age, status
        FROM medicalEquipment
        WHERE destination_age >= equipment_age_threshold;
    old_status VARCHAR;
    new_status VARCHAR;
    usage_count INTEGER;
    report_lines TEXT[] := ARRAY[]::TEXT[];
    total_updated INTEGER := 0;
BEGIN
    report_lines := array_append(report_lines, '=== Medical Equipment Status Update Report ===');
    report_lines := array_append(report_lines, 'Date: ' || CURRENT_DATE);
    report_lines := array_append(report_lines, 'Minimum Age for Examination: ' || equipment_age_threshold || ' Years');
    report_lines := array_append(report_lines, '');

    -- לולאה על כל פריט ציוד
    FOR equip_rec IN equip_cursor LOOP
        old_status := equip_rec.status;

        -- בדיקת שימוש בציוד
        SELECT COUNT(*) INTO usage_count
        FROM useEquipment
        WHERE equipment_id = equip_rec.equipment_id;

        -- קביעת סטטוס חדש לפי גיל ושימוש
        IF equip_rec.destination_age >= 10 THEN
            IF usage_count > 5 THEN
                new_status := 'Urgent';
            ELSE
                new_status := 'For Check';
            END IF;
        ELSIF equip_rec.destination_age >= 7 THEN
            new_status := 'Maintenance';
        ELSE
            new_status := 'Active';
        END IF;

        -- עדכון הסטטוס אם השתנה
        IF old_status IS DISTINCT FROM new_status THEN
            UPDATE medicalEquipment
            SET status = new_status
            WHERE equipment_id = equip_rec.equipment_id;

            total_updated := total_updated + 1;

            report_lines := array_append(report_lines,
                'Equipment: ' || equip_rec.equipment_name ||
                ' (ID: ' || equip_rec.equipment_id || ')' ||
                ' - Age: ' || equip_rec.destination_age ||
                ' - Usages: ' || usage_count ||
                ' - Status Extended From-"' || COALESCE(old_status, 'NULL') ||
                '" to-"' || new_status || '"');
        END IF;
    END LOOP;

    updated_count := total_updated;

    IF total_updated = 0 THEN
        report_lines := array_append(report_lines, 'No Updates Required.');
    ELSE
        report_lines := array_append(report_lines, '');
        report_lines := array_append(report_lines, 'Total Updated Equipment Items: ' || total_updated);
    END IF;

    report_text := array_to_string(report_lines, E'\n');

EXCEPTION
    WHEN OTHERS THEN
        updated_count := -1;
        report_text := 'Equipment Status Update Error: ' || SQLERRM;
        ROLLBACK;
END;
$$ LANGUAGE plpgsql;