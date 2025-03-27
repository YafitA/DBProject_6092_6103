import csv
import random
from datetime import datetime, timedelta

# פונקציה ליצירת שעה רנדומלית עגולה או חצי
def random_time():
    hour = random.randint(0, 23)  # שעה בין 00:00 ל-23:00
    minute = random.choice([0, 30])  # דקות: 00 או 30
    return f"{hour:02d}:{minute:02d}:00"  # פורמט HH:MM:SS

# פונקציה ליצירת תאריך רנדומלי בין 2024 ל-2025
def random_date():
    start_date = datetime(2024, 1, 1)
    end_date = datetime(2025, 12, 31)
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return (start_date + timedelta(days=random_days)).strftime("%Y-%m-%d")

# יצירת רשומות
shift_data = []
for shift_id in range(1, 401):  # IDs מ-1 עד 400
    shift_date = random_date()
    start_time = random_time()

    # יצירת משך משמרת בין 2 ל-8 שעות
    duration = random.randint(2, 8)

    # חישוב זמן סיום
    start_hour, start_minute, _ = map(int, start_time.split(":"))
    end_hour = (start_hour + duration) % 24  # מניעת חריגה ליום הבא
    end_time = f"{end_hour:02d}:{start_minute:02d}:00"

    shift_data.append([shift_id, start_time, end_time, shift_date])

# כתיבת הנתונים לקובץ CSV
csv_filename = "shifts.csv"
with open(csv_filename, mode="w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["ShiftID", "StartTime", "EndTime", "ShiftDate"])  # כותרות
    writer.writerows(shift_data)

print(f" shifts {csv_filename} created successfuly")
