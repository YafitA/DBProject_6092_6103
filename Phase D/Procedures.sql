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

