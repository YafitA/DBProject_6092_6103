-- ================================================
-- טריגר 1: בדיקת תקינות נתונים בהקצאת מתנדבים לטיפול
-- ================================================
CREATE OR REPLACE FUNCTION validate_volunteer_treatment_assignment()
RETURNS TRIGGER AS $$
DECLARE
    vol_type_name VARCHAR;
    treatment_exists BOOLEAN;
BEGIN
    -- בדיקת קיום המתנדב
    IF NOT EXISTS (SELECT 1 FROM volunteer WHERE volunteer_id = NEW.volunteer_id) THEN
        RAISE EXCEPTION 'Volunteer with ID % does not exist in the system.', NEW.volunteer_id;
    END IF;

    -- בדיקת קיום המטופל
    IF NOT EXISTS (SELECT 1 FROM patient WHERE patient_id = NEW.patient_id) THEN
        RAISE EXCEPTION 'Patient with ID % does not exist in the system.', NEW.patient_id;
    END IF;

    -- בדיקת סוג הטיפול - ודא שקיים עבור המטופל הזה
    -- (נניח שיש טבלת treatmentPlan, אבל נעשה זאת באופן פשוט)
    SELECT COUNT(*) > 0 INTO treatment_exists
    FROM volunteerType v  -- בהנחה שזו טבלת תוכניות טיפול
    WHERE v.patient_id = NEW.patient_id;

    IF NOT treatment_exists THEN
        RAISE NOTICE 'No treatment plan found for patient %.', NEW.patient_id;
    END IF;

    -- בדיקת מספר מתנדבים מקסימלי לכל מטופל (נניח מקסימום 3)
    IF (SELECT COUNT(*) FROM volunteerInTreatPlan
        WHERE patient_id = NEW.patient_id) >= 3 THEN
        RAISE EXCEPTION 'Patient % is already assigned the maximum number of volunteers (3).', NEW.patient_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_volunteer_treatment
    BEFORE INSERT OR UPDATE ON volunteerInTreatPlan
    FOR EACH ROW
    EXECUTE FUNCTION validate_volunteer_treatment_assignment();