-- ================================================
-- טריגר 1: בדיקת ניגודי עניינים בהקצאת מתנדבים לפרויקטים
-- ================================================
CREATE OR REPLACE FUNCTION check_volunteer_project_conflicts()
RETURNS TRIGGER AS $$
DECLARE
    vol_rec RECORD;
    project_rec RECORD;
    existing_projects INTEGER;
    manager_conflict BOOLEAN := FALSE;
    date_overlap_count INTEGER := 0;
    vol_skill VARCHAR;
    required_skill VARCHAR;
BEGIN
    -- שליפת פרטי המתנדב
    SELECT v.volunteer_id, v.skill, v.manager_id, p.first_name, p.last_name
    INTO vol_rec
    FROM volunteer v
    JOIN person p ON v.volunteer_id = p.id
    WHERE v.volunteer_id = NEW.volunteer_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Volunteer with ID % not found in system', NEW.volunteer_id;
    END IF;

    -- שליפת פרטי הפרויקט
    SELECT project_id, project_name, description, start_date, end_date, manager_id
    INTO project_rec
    FROM project
    WHERE project_id = NEW.project_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Project with ID % not found in system', NEW.project_id;
    END IF;

    -- בדיקה 1: האם הפרויקט עדיין פעיל?
    IF project_rec.end_date < CURRENT_DATE THEN
        RAISE EXCEPTION 'Cannot assign volunteer % to project % - project ended on %',
                        vol_rec.first_name || ' ' || vol_rec.last_name,
                        project_rec.project_name,
                        project_rec.end_date;
    END IF;

    -- בדיקה 2: מספר פרויקטים מקסימלי למתנדב (5 פרויקטים)
    SELECT COUNT(*) INTO existing_projects
    FROM volunteerProject vp
    JOIN project pr ON vp.project_id = pr.project_id
    WHERE vp.volunteer_id = NEW.volunteer_id
    AND pr.end_date >= CURRENT_DATE;

    IF existing_projects >= 5 THEN
        RAISE EXCEPTION 'Volunteer % already participates in % active projects (maximum 5)',
                        vol_rec.first_name, existing_projects;
    END IF;

    -- בדיקה 3: חפיפה בתאריכי פרויקטים - בדיקת עומס זמן
    SELECT COUNT(*) INTO date_overlap_count
    FROM volunteerProject vp
    JOIN project pr ON vp.project_id = pr.project_id
    WHERE vp.volunteer_id = NEW.volunteer_id
    AND pr.project_id != NEW.project_id
    AND (
        (pr.start_date BETWEEN project_rec.start_date AND project_rec.end_date) OR
        (pr.end_date BETWEEN project_rec.start_date AND project_rec.end_date) OR
        (project_rec.start_date BETWEEN pr.start_date AND pr.end_date)
    );

    IF date_overlap_count >= 3 THEN
        RAISE EXCEPTION 'Volunteer % already participates in % overlapping projects with project % - excessive time load',
                        vol_rec.first_name, date_overlap_count, project_rec.project_name;
    ELSIF date_overlap_count >= 2 THEN
        RAISE NOTICE 'Warning: volunteer % participates in % additional overlapping projects',
                     vol_rec.first_name, date_overlap_count;
    END IF;

    -- רישום הקצאה מוצלחת
    RAISE NOTICE 'Volunteer % successfully assigned to project % (period: % to %)',
                vol_rec.first_name || ' ' || vol_rec.last_name,
                project_rec.project_name,
                project_rec.start_date,
                project_rec.end_date;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_check_volunteer_project_conflicts
    BEFORE INSERT OR UPDATE ON volunteerProject
    FOR EACH ROW
    EXECUTE FUNCTION check_volunteer_project_conflicts();