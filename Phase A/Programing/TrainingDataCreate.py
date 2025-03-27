import random
from datetime import datetime, timedelta
import csv


# פונקציה ליצירת תאריך אקראי בין 2024-2025
def generate_random_date():
    start_date = datetime(2024, 1, 1)
    end_date = datetime(2025, 12, 31)
    return start_date + timedelta(days=random.randint(0, (end_date - start_date).days))


# שמות מותאמים אישית של הכשרות בתחום הבריאות
training_names = [
    "CPR and First Aid Certification", "Emergency Response Training", "X-ray Technician Certification",
    "Medical Record Keeping", "Nursing Assistant Skills", "Advanced Life Support (ALS) Training",
    "Pharmacy Assistant Training", "Surgical Support Training", "Patient Care Assistant Certification",
    "Infection Control Training", "Wound Care Management", "Medical Equipment Handling",
    "Clinical Laboratory Technician Training", "Cardiopulmonary Resuscitation (CPR) for Healthcare Workers",
    "Pediatric Nursing Care", "Geriatric Care Training", "Blood Transfusion Safety and Procedures",
    "Orthopedic Care Assistant", "Respiratory Therapy Certification", "Mental Health First Aid",
    "Hospital Administration Skills", "Phlebotomy Technician Training", "Patient Transportation Training",
    "Sterile Processing Technician Certification", "Radiology Safety Procedures", "Rehabilitation Assistant Training",
    "Physical Therapy Aide Training", "Medical Billing and Coding", "Nutrition for Healthcare Workers",
    "Emergency Medical Technician (EMT) Training", "Critical Care Nursing", "Pain Management Techniques",
    "Audiology Assistant Training", "Optometry Technician Certification", "Palliative Care Training",
    "Diabetes Management for Healthcare Providers", "Emergency Room (ER) Procedures", "Advanced Nursing Practices",
    "Childbirth Education for Healthcare Workers", "Healthcare Leadership and Management Training",
    "Laboratory Safety and Procedures", "Medical Ethics and Legal Responsibilities", "Patient Safety Training",
    "Hygiene and Infection Control in Healthcare", "Behavioral Health Training", "Trauma Care and Management",
    "Health and Wellness Coaching", "End-of-Life Care Training", "Pediatric First Aid and CPR",
    "Medical Research Assistant Training", "Healthcare Quality Assurance", "Clinical Trials Management",
    "Cardiac Rehabilitation Training", "Injury Prevention and Safety in Healthcare",
    "Healthcare IT and Data Management",
    "Pain and Symptom Management for Healthcare Workers", "Community Health Training", "Surgical Assistant Training",
    "Healthcare Communication Skills", "Mental Health Support in Healthcare", "Health Information Management",
    "Emergency Disaster Management", "Personal Protective Equipment (PPE) Training", "Radiation Safety and Protection",
    "Anesthesia Technician Certification", "Patient Advocacy Training", "Chronic Disease Management Training",
    "Gastroenterology Assistant Training", "Dermatology Assistant Certification", "Laboratory Technician Skills",
    "Ambulance Driving and Safety Training", "Clinical Research Assistant Skills", "Maternity Care Assistant Training",
    "Allergy and Immunology Assistant Training", "Speech and Language Pathology Assistant",
    "Neurology Assistant Training",
    "Cardiology Technician Certification", "Obstetric Assistant Training", "Veterinary Health Assistant Training",
    "Medical Photography Training", "Genetics Counseling Certification", "Pharmacology for Healthcare Workers",
    "Medical Transcription Skills", "Healthcare Legal Compliance Training", "Inpatient Care Management",
    "Outpatient Services Training", "Geriatric Social Work Skills", "Hematology Technician Training",
    "Biotechnology for Healthcare Workers", "Emergency Medical Dispatching", "Clinical Microbiology Skills",
    "Cytology Technician Certification", "Endoscopy Technician Training", "Advanced Patient Care Certification",
    "Nutrition Counseling for Healthcare Providers", "Oncology Nursing Care", "Advanced Cardiac Life Support (ACLS)",
    "Burn Care Management", "Wound Dressing and Care", "Post-Operative Care Certification",
    "Medical Social Worker Training",
    "Clinical Nursing Education", "Medical Assistant Skills", "Orthotics and Prosthetics Assistant",
    "Family Medicine Assistant Training", "Radiation Oncology Certification", "Reproductive Health Assistant Training",
    "Healthcare Marketing and PR Training", "Health Insurance for Healthcare Workers", "Medical Coding and Billing",
    "Clinical Decision Making for Healthcare", "Laboratory Management Skills", "Public Health Assistant Certification",
    "Human Resources for Healthcare Organizations", "Neonatal Nursing Care", "Substance Abuse Counseling in Healthcare",
    "Medical Device Sales Training", "Alternative Medicine Practices in Healthcare", "Healthcare Financial Management",
    "Chronic Pain Management", "Physical Rehabilitation Techniques", "Pediatric Respiratory Therapy",
    "Hearing Aid Technician Certification", "Nutrition Assistant in Healthcare",
    "Healthcare Compliance and Regulations",
    "Long-Term Care Assistant Certification", "Behavioral Health Assistant Training",
    "Nutrition Therapy for Healthcare Workers",
    "Psychiatric Nursing Care", "Nurse Practitioner Skills", "Healthcare Project Management",
    "Pharmacy Technician Training",
    "Orthopedic Nursing Assistant", "Emergency Care Procedures in Rural Healthcare",
    "Eye Care Technician Certification",
    "Respiratory Disease Management", "Dialysis Technician Training", "Hematology Assistant Skills",
    "Physical Therapy Assistant",
    "Health and Safety for Healthcare Workers", "Family Medicine Nursing", "Radiology Technician Skills",
    "Clinical Pharmacist Assistant", "Environmental Health and Safety in Healthcare", "Medical Research Skills",
    "Healthcare Fraud Prevention", "Geriatric Psychiatry Training", "Acute Care Nurse Practitioner Certification",
    "Elderly Patient Care Techniques", "Healthcare Facility Management", "Patient Assessment and Diagnosis",
    "Trauma Nursing Care", "Pathology Technician Certification", "Clinical Data Analysis for Healthcare",
    "Emergency Medical Response Training", "Healthcare Marketing Skills", "Medical Equipment Maintenance",
    "Neonatal Intensive Care Unit (NICU) Training", "Healthcare Robotics Training", "Veterinary Surgery Assistant",
    "Mental Health Counseling Certification", "Pharmaceutical Research and Development"
]

# לוודא שהרשימה מכילה בדיוק 400 שמות
training_names = training_names * (400 // len(training_names)) + training_names[:(400 % len(training_names))]

# כותרות לעמודות
fields = ['TrainingID', 'TrainingName', 'TrainingDate', 'Description']

# יצירת קובץ CSV עם שמות מותאמים אישית
with open('Training.csv', mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(fields)

    for i in range(1, 401):
        training_name = training_names[i - 1]
        training_date = generate_random_date().strftime('%Y-%m-%d')
        description = f"{training_name} description for healthcare purposes."

        # כתיבת הנתונים
        writer.writerow([i, training_name, training_date, description])

print("קובץ ה-CSV נוצר בהצלחה!")
