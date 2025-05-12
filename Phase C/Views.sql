--טבלא של פרטי המתנדב כולל שם מנהל, מספר מספר ההכשרות שעבר, מספר פרויקטים שהוא שותף בהם, ומספר תוכניות שיקום שהוא מסייע בהן
CREATE VIEW VolunteerFullSummary AS
SELECT
   v.volunteer_id,
   CONCAT(p.first_name, ' ', p.last_name) AS volunteer_name,
   p.phone_number,
   v.skill,
   CONCAT(mp.first_name, ' ', mp.last_name) AS manager_name,
   COUNT(DISTINCT vt.training_id) AS training_count,
   COUNT(DISTINCT vp.project_id) AS project_count,
   COUNT(DISTINCT vtp.patient_id) AS treatment_plan_count
FROM volunteer v
JOIN person p ON v.volunteer_id = p.id
LEFT JOIN worker m ON v.manager_id = m.worker_id
LEFT JOIN person mp ON m.worker_id = mp.id
LEFT JOIN volunteerTraining vt ON v.volunteer_id = vt.volunteer_id
LEFT JOIN volunteerProject vp ON v.volunteer_id = vp.volunteer_id
LEFT JOIN volunteerInTreatPlan vtp ON v.volunteer_id = vtp.volunteer_id
GROUP BY v.volunteer_id, volunteer_name, p.phone_number, p.email_address, v.skill, manager_name;

--המתנדבים שלא עברו כלל הכשרה + פרטי קשר
SELECT
    volunteer_id,
    volunteer_name,
    phone_number,
    manager_name
FROM VolunteerFullSummary
WHERE training_count = 0;

--טופ 10 מתנדבים שסייעו בהכי הרבה פרויקטים
SELECT
    volunteer_id,
    volunteer_name,
    project_count
FROM VolunteerFullSummary
ORDER BY project_count DESC
LIMIT 10;

--מספר פציינט ופרטי תוכנית השיקום שלו
CREATE VIEW PatientTreatmentOverview AS
SELECT
    p.patient_id,
    tp.treatment_type,
    tp.start_date,
    tp.end_date,
    tp.sessions_per_week,
    me.equipment_name,
    v.volunteer_id,
    per.first_name || ' ' || per.last_name AS volunteer_name
FROM patient p
JOIN treatmentplan tp ON p.patient_id = tp.patient_id
LEFT JOIN useEquipment ue ON p.patient_id = ue.patient_id AND tp.treatment_type = ue.treatment_type
LEFT JOIN medicalEquipment me ON ue.equipment_id = me.equipment_id
LEFT JOIN volunteerInTreatPlan vitp ON p.patient_id = vitp.patient_id AND tp.treatment_type = vitp.treatment_type
LEFT JOIN volunteer v ON vitp.volunteer_id = v.volunteer_id
LEFT JOIN person per ON v.volunteer_id = per.id;

--תוכנית שיקום ומס' פציינט ללא מתנדב
SELECT patient_id,
    treatment_type,
    start_date,
    end_date,
    sessions_per_week
FROM PatientTreatmentOverview
WHERE volunteer_id is NULL;

--כמה מפגשים שבועיים מתוכננים לכל סוג טיפול
SELECT treatment_type, SUM(sessions_per_week) AS total_sessions
FROM PatientTreatmentOverview
GROUP BY treatment_type;