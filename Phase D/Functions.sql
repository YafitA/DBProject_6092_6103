-- ================================================
-- פונקציה 1: חישוב עומס עבודה של מתנדבים עם סטטיסטיקות
-- ================================================
CREATE OR REPLACE FUNCTION calculate_volunteer_workload()
RETURNS TABLE (
    volunteer_id INTEGER,
    volunteer_name VARCHAR,
    projects_count INTEGER,
    shifts_count INTEGER,
    training_count INTEGER,
    workload_score NUMERIC,
    workload_category VARCHAR
) AS $$
DECLARE
    vol_rec RECORD;
    vol_cursor CURSOR FOR
        SELECT v.volunteer_id, p.first_name, p.last_name, v.skill
        FROM volunteer v
        JOIN person p ON v.volunteer_id = p.id;
    proj_count INTEGER;
    shift_count INTEGER;
    train_count INTEGER;
    score NUMERIC;
    category VARCHAR;
BEGIN
    -- פתיחת cursor מפורש
    OPEN vol_cursor;

    LOOP
        FETCH vol_cursor INTO vol_rec;
        EXIT WHEN NOT FOUND;

        -- חישוב מספר פרויקטים
        SELECT COUNT(*) INTO proj_count
        FROM volunteerProject vp
        WHERE vp.volunteer_id = vol_rec.volunteer_id;

        -- חישוב מספר משמרות
        SELECT COUNT(*) INTO shift_count
        FROM volunteerShift vs
        WHERE vs.volunteer_id = vol_rec.volunteer_id;

        -- חישוב מספר הכשרות
        SELECT COUNT(*) INTO train_count
        FROM volunteerTraining vt
        WHERE vt.volunteer_id = vol_rec.volunteer_id;

        -- חישוב ציון עומס עבודה
        score := (proj_count * 3.0) + (shift_count * 2.0) + (train_count * 1.5);

        -- קביעת קטגוריית עומס עבודה
        IF score >= 20 THEN
            category := 'High workload';
        ELSIF score >= 10 THEN
            category := 'Medium workload';
        ELSIF score >= 5 THEN
            category := 'Low workload';
        ELSE
            category := 'Minimal workload';
        END IF;

        -- החזרת השורה
        volunteer_id := vol_rec.volunteer_id;
        volunteer_name := vol_rec.first_name || ' ' || vol_rec.last_name;
        projects_count := proj_count;
        shifts_count := shift_count;
        training_count := train_count;
        workload_score := score;
        workload_category := category;

        RETURN NEXT;
    END LOOP;

    CLOSE vol_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in workload calculation: %', SQLERRM;
        RETURN;
END;
$$ LANGUAGE plpgsql;




-- ================================================
-- פונקציה 2: החזרת REF CURSOR למטופלים פעילים
-- ================================================
CREATE OR REPLACE FUNCTION get_active_patients_cursor()
RETURNS REFCURSOR AS $$
DECLARE
    patient_cursor REFCURSOR := 'active_patients_cur';
    patient_count INTEGER;
BEGIN
    -- בדיקת מספר מטופלים
    SELECT COUNT(*) INTO patient_count FROM patient;

    IF patient_count = 0 THEN
        RAISE EXCEPTION 'no patients found';
    END IF;

    -- פתיחת cursor
    OPEN patient_cursor FOR
        SELECT DISTINCT
            p.patient_id,
            per.first_name || ' ' || per.last_name as patient_name,
            mr.severity_of_injury,
            mr.cause_of_injury,
            COUNT(vtp.volunteer_id) as volunteer_count,
            STRING_AGG(DISTINCT vtp.treatment_type, ', ') as treatments
        FROM patient p
        LEFT JOIN person per ON p.patient_id = per.id
        LEFT JOIN medicalRecord mr ON p.patient_id = mr.patient_id
        LEFT JOIN volunteerInTreatPlan vtp ON p.patient_id = vtp.patient_id
        GROUP BY p.patient_id, per.first_name, per.last_name, mr.severity_of_injury, mr.cause_of_injury
        HAVING COUNT(vtp.volunteer_id) > 0
        ORDER BY mr.severity_of_injury DESC;

    RETURN patient_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'error in returned cursor: %', SQLERRM;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
