-- בדיקת פונקציה 1
SELECT * FROM calculate_volunteer_workload();

-- בדיקת פונקציה 2
SELECT get_active_patients_cursor();
FETCH ALL FROM active_patients_cur;


-- בדיקת פרוצדורה 1
CALL manage_volunteer_projects('ADD', 1);

-- בדיקת פרוצדורה 2:
DO $$
DECLARE
    updated_count INTEGER;
    report_text TEXT;
BEGIN
    CALL update_equipment_status_report(updated_count, report_text, 4);

    RAISE NOTICE 'num of opdated items: %', updated_count;
    RAISE NOTICE 'report: %', report_text;
END;
$$;

-- בדיקת טריגר 1:




-- בדיקת טריגר 2:
-- הוספת מטופל לדוגמה
INSERT INTO patient (patient_id) VALUES (100);

-- הוספת רשומה רפואית ראשונית
INSERT INTO medicalRecord (record_id, patient_id, severity_of_injury, family_status, cause_of_injury, allergies)
VALUES (1, 100, 3, 2,'Car Accident', 'None');

-- בדוק שהטריגר רשם את ההוספה
SELECT * FROM medical_record_history
WHERE patient_id = 100 AND change_type = 'INSERT';



-- עדכון רגיל - שינוי קטן בחומרה
UPDATE medicalRecord
SET severity_of_injury = 4, cause_of_injury = 'תאונת דרכים חמורה'
WHERE patient_id = 100;

-- בדיקה
SELECT * FROM medical_record_history
WHERE patient_id = 100 AND change_type = 'UPDATE';



-- מחיקת הרשומה
DELETE FROM medicalRecord WHERE patient_id = 100;

-- בדיקה
SELECT * FROM medical_record_history
WHERE patient_id = 100 AND change_type = 'DELETE';