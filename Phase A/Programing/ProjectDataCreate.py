import csv
import random
from datetime import datetime, timedelta

# רשימה של שמות פרויקטים להתנדבות בבית חולים
project_names = [
    "Pediatric Playtime", "Elderly Companionship", "Therapy Dog Visits", "Hospital Greeter Program",
    "Cancer Support Group", "Emergency Room Assistance", "Mental Health Awareness",
    "Blood Donation Drive", "Child Life Volunteer Program", "Patient Transport Services",
    "Music Therapy Sessions", "Reading to Patients", "NICU Baby Cuddler", "Post-Surgery Assistance",
    "Art Therapy for Patients", "Support for Families", "Hospital Fundraising Team",
    "Medical Supply Organization", "Wheelchair Assistance", "Language Interpretation for Patients"
]

# יצירת 400 פרויקטים עם תאריכים ותיאורים אקראיים
projects = []
start_date_base = datetime(2024, 1, 1)
end_date_base = datetime(2025, 12, 31)

for i in range(1, 401):
    project_name = random.choice(project_names) + f" #{i}"  # מוסיף מזהה ייחודי
    description = "Project For " + project_name # יוצר תיאור קצר לפרויקט
    start_date = start_date_base + timedelta(days=random.randint(0, 365))
    end_date = start_date + timedelta(days=random.randint(30, 180))  # הפרויקט נמשך בין חודש לחצי שנה
    manager_id = random.randint(1, 50)  # נניח שיש 50 מנהלים

    projects.append(
        [i, project_name, description, start_date.strftime('%Y-%m-%d'), end_date.strftime('%Y-%m-%d'), manager_id])

# כתיבת הנתונים לקובץ CSV
csv_filename = "Project.csv"
with open(csv_filename, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow(["ProjectID", "ProjectName", "Description", "StartDate", "EndDate", "ManagerID"])  # כותרות
    writer.writerows(projects)

print(f"CSV file '{csv_filename}' created successfully.")
