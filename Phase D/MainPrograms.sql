-- ================================================
-- תוכנית ראשית 1: דוח מתנדבים כולל ניהול פרויקטים
-- ================================================
DO $$
DECLARE
    workload_cursor REFCURSOR;
    workload_rec RECORD;
    high_workload_volunteers INTEGER[] := ARRAY[]::INTEGER[];
    vol_id INTEGER;
BEGIN
    RAISE NOTICE '=== Starting Volunteer Report ===';

    -- קריאה לפונקציה לחישוב עומס עבודה
    RAISE NOTICE 'Calculating workload for all volunteers...';

    FOR workload_rec IN
        SELECT * FROM calculate_volunteer_workload()
        ORDER BY workload_score DESC
    LOOP
        RAISE NOTICE 'Volunteer: % | Workload Score: % | Category: % | Projects: % | Shifts: %',
            workload_rec.volunteer_name,
            workload_rec.workload_score,
            workload_rec.workload_category,
            workload_rec.projects_count,
            workload_rec.shifts_count;

        -- איסוף מתנדבים עם עומס גבוה
        IF workload_rec.workload_category = 'עומס גבוה' THEN
            high_workload_volunteers := array_append(high_workload_volunteers, workload_rec.volunteer_id);
        END IF;
    END LOOP;

    -- ניהול פרויקטים למתנדבים עם עומס נמוך
    RAISE NOTICE E'\n=== Managing Project Assignments ===';

    -- הוספת מתנדבים עם עומס נמוך לפרויקטים נוספים
    FOR workload_rec IN
        SELECT * FROM calculate_volunteer_workload()
        WHERE workload_category IN ('Minimal workload', 'Low workload')
        LIMIT 3
    LOOP
        CALL manage_volunteer_projects('ADD', workload_rec.volunteer_id);
    END LOOP;

    RAISE NOTICE '=== End of Volunteer Report ===';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in main program: %', SQLERRM;
END;
$$;




-- ================================================
-- תוכנית ראשית 2: דוח מטופלים ועדכון ציוד רפואי
-- ================================================
DO $$
DECLARE
    patients_cursor REFCURSOR;
    patient_rec RECORD;
    equipment_updated_count INTEGER;
    equipment_report TEXT;
BEGIN
    RAISE NOTICE '=== Start of Patient and Medical Equipment Report ===';

    -- קריאה לפונקציה שמחזירה REF CURSOR
    SELECT get_active_patients_cursor() INTO patients_cursor;

    IF patients_cursor IS NOT NULL THEN
        RAISE NOTICE E'\n--- Active Patients ---';

        LOOP
            FETCH patients_cursor INTO patient_rec;
            EXIT WHEN NOT FOUND;

            RAISE NOTICE 'Patient: % | Injury Severity: % | Injury Cause: % | Volunteers: % | Treatments: %',
                patient_rec.patient_name,
                patient_rec.severity_of_injury,
                patient_rec.cause_of_injury,
                patient_rec.volunteer_count,
                patient_rec.treatments;
        END LOOP;

        CLOSE patients_cursor;
    END IF;

    -- קריאה לפרוצדורה לעדכון ציוד רפואי
    RAISE NOTICE E'\n--- Medical Equipment Status Update ---';

    CALL update_equipment_status_report(equipment_updated_count, equipment_report, 6);

    RAISE NOTICE E'\n%', equipment_report;
    RAISE NOTICE E'\nTotal Updated Equipment Items: %', equipment_updated_count;

    RAISE NOTICE E'\n=== End of Patient and Medical Equipment Report ===';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in Main Program: %', SQLERRM;
END;
$$;