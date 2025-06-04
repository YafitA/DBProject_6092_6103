

# **Hospital Volunteer Management System**  

**פרויקט מסד נתונים – ניהול מתנדבים בבית חולים**  
**הוגש על ידי: אביטל חזן ויפית אטון**  

---

## **תוכן עניינים**  
- [שלב א': עיצוב, בנייה ואכלוס נתונים וגיבוי](#שלב-א-עיצוב-בנייה-ואכלוס-נתונים-וגיבוי)  
  - [מבוא](#מבוא)  
  - [תרשים ERD](#תרשים-erd)  
  - [תרשים DSD](#תרשים-dsd)  
  - [קבצי SQL](#קבצי-sql)  
  - [אכלוס נתונים בשלוש שיטות](#יצירת-נתונים-בשלוש-שיטות)  
  - [גיבוי ושחזור](#גיבוי-ושחזור)  
- [שלב ב': שאילתות](#שלב-ב-שאילתות)
  - [8 שאילתות SELECT](#8-שאילתות-SELECT)
  - [3 שאילתות DELETE](#3-שאילתות-DELETE)
  - [3 שאילתות UPDATE](#3-שאילתות-UPDATE)
  - [אילוצים בטבלאות (Constraints)](#אילוצים-בטבלאות-constraints)
  - [הדגמת ROLLBACK](#הדגמת-ROLLBACK)
  - [הדגמת COMMIT](#הדגמת-COMMIT)
- [שלב ג': אינטגרציה ומבטים](#שלב-ג-אינטגרציה-ומבטים)
  - [אלגוריתם הינדוס לאחור](#אלגוריתם-הינדוס-לאחור)
    - [שלב א: ניתוח טבלאות](#שלב-א-ניתוח-טבלאות)
    - [שלב ב: יצירת-dsd](#שלב-ב-יצירת-dsd)
    - [שלב ג: המרה-ל־erd](#שלב-ג-המרה-ל־erd)
  - [תרשים DSD של האגף החדש](#תרשים-dsd-של-האגף-החדש)
  - [תרשים ERD של האגף החדש](#תרשים-erd-של-האגף-החדש)
  - [תרשים ERD לאחר אינטגרציה](#תרשים-erd-לאחר-אינטגרציה)
  - [תרשים DSD לאחר אינטגרציה](#תרשים-dsd-לאחר-אינטגרציה)
  - [תיאור תהליך האינטגרציה במסד הנתונים](#תיאור-תהליך-האינטגרציה-במסד-הנתונים)
  - [החלטות עיצוב באינטגרציה](#החלטות-עיצוב-באינטגרציה)
  - [מבטים](#מבטים)
- [שלב ד': תכנות](#שלב-ד-תכנות)
- [📊 פונקציות](#פונקציות)

  



---

# **שלב א': עיצוב, בנייה ואכלוס נתונים וגיבוי**  

### **מבוא**  

מערכת זו נועדה לנהל את פעילות המתנדבים **בבית חולים שיבא**, ולספק מענה לארגון ושיבוץ נכון של מתנדבים לפי כישוריהם והתאמה לפרויקטים.  

#### **מטרות מסד הנתונים**  
- **ניהול מתנדבים** – שמירת נתונים אישיים, סוגי התנדבות והתאמה לפרויקטים.  
- **ניהול מנהלים** – לכל פרויקט יש מנהל האחראי על מתנדבים ושיבוץ למשמרות.  
- **תכנון ושיבוץ משמרות** – שיבוץ מתנדבים למשמרות בבית החולים.  
- **מעקב אחר הכשרות** – אילו מתנדבים עברו אילו הכשרות.  
- **תיעוד סוגי התנדבות** – סוגים שונים של התנדבות כגון ליווי חולים, הפעלת פעילויות לילדים וכו'.  

---

### **תרשים ERD**  
![PhaseA/ERDAndDSTFiles/ERD.png](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/ERDAndDSTFiles/ERD.png?raw=true)

---

### **תרשים DSD**  
![DSD Diagram](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/ERDAndDSTFiles/DSD.png?raw=true).

---
### **קבצי SQL**  
📜 [יצירת טבלאות - createTables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/createTables.sql)  
📜 [הכנסת נתונים ראשונית - insertTables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/insertTables.sql)  
📜 [מחיקת טבלאות - dropTables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/dropTables.sql)  
📜 [שליפת כל הנתונים - selectAll.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/selectAll.sql) 

---

### **יצירת נתונים בשלוש שיטות**  



#### **שיטה 1: שימוש ב-[Mockaroo](https://www.mockaroo.com/)**
נוצרו קובצי CSV עם נתונים לטבלאות הבאות: 
📌 **[מתנדבים (`Volunteer.csv`)](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/mockarooFiles/Volunteer.csv)**  
📌 **[סוגי התנדבות (`VolunteerType.csv`)](Phase1/mockData/VolunteerType.csv)**  



**כך נראה המסך בעת יצירת הנתונים ב-Mockaroo:** 
![יצירת נתונים ב-Mockaroo](https://github.com/user-attachments/assets/0eb27539-6192-446f-bd4b-fc9fac418558)

---

#### **שיטה 2: שימוש ב-[GenerateData](https://generatedata.com/)**
📌 **[מנהלים (`Manager.csv`)](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Generatedata/Manager.csv)**  
  

**כך נראה המסך בעת יצירת הנתונים ב-GenerateData:**  
![יצירת נתונים ב-GenerateData](https://github.com/user-attachments/assets/da904d4b-27ce-4b7d-99d3-4ead3259cdbc)



---

### **שיטה 3: שימוש בקוד Python**
🖥 **קבצי הקוד ליצירת הנתונים:**
- [**יצירת נתוני משמרות (ShiftDataCreate.py)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/ShiftDataCreate.py)
- [**יצירת נתוני הכשרות (TrainingDataCreate.py)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/TrainingDataCreate.py)
- [**יצירת נתוני פרויקטים (ProjectDataCreate.py)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/ProjectDataCreate.py)
- [**יצירת נתוני משימות (AssignedToCreateData.py)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/AssignedToCreateData.py)
- [**יצירת נתוני עבודה (WorksInCreateData.py)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/WorksInCreateData.py)

📂 **קובצי הנתונים שנוצרו:**
- [**נתוני משמרות (Shift.csv)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/Shift.csv)
- [**נתוני הכשרות (Training.csv)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/Training.csv)
- [**נתוני פרויקטים (Project.csv)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/Project.csv)
- [**נתוני משימות (AssignedTo.csv)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/AssignedTo.csv)
- [**נתוני עבודה (WorksIn.csv)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/WorksIn.csv)
- [**נתוני הכשרה (Trained.csv)**](https://github.com/YafitA/DBProject_6092_6103/blob/main/Phase%20A/Programing/Trained.csv)

#### **העלאת הנתונים למסד הנתונים**

![העלאת הנתונים למסד הנתונים](https://github.com/user-attachments/assets/72541cef-719f-49af-8280-9f6446522b26)

![אימות הנתונים במסד הנתונים](https://github.com/user-attachments/assets/b89e7e89-6da2-4889-a979-59973e221ae0)
---

### **גיבוי ושחזור**  
📌 **[תיקיית גיבויים](https://github.com/YafitA/DBProject_6092_6103/tree/main/Phase%20A/Backup)**  

✅ גובו כל הנתונים ונבדק שחזור על מחשב אחר.  

---

# **שלב ב': שאילתות**

### 8 שאילתות SELECT

#### 1. 📋 רשימת מתנדבים
**English:** List of volunteers including name, type of volunteering, name of manager, and number of projects assigned.  
**עברית:** הצגת מתנדבים עם שמם המלא, סוג ההתנדבות, שם המנהל ומספר הפרויקטים אליהם הם שובצו.  
🖼️ ![Query 1](https://github.com/user-attachments/assets/d61dc736-dc5d-4c23-a9d8-39f146ea5422)

```sql
SELECT
    v.VolunteerID,
    v.FirstName || ' ' || v.LastName AS FullName,
    vt.TypeName AS VolunteerType,
    m.FirstName || ' ' || m.LastName AS ManagerName,
    COUNT(p.ProjectID) AS NumOfProjects
FROM Volunteer v
JOIN VolunteerType vt ON v.VolunteerTypeID = vt.VolunteerTypeID
JOIN Manager m ON v.ManagerID = m.ManagerID
LEFT JOIN AssignedTo a ON v.VolunteerID = a.VolunteerID
LEFT JOIN Project p ON a.ProjectID = p.ProjectID
GROUP BY v.VolunteerID, v.FirstName, v.LastName, vt.TypeName, m.FirstName, m.LastName
ORDER BY v.VolunteerID;
```

---

#### 2. 🧮 מספר מתנדבים פר תחום
**English:** Number of volunteers in each volunteer type.  
**עברית:** כמות מתנדבים בכל סוג של התנדבות.  
🖼️ ![Query 2](https://github.com/user-attachments/assets/d6f8fd58-e60c-465f-b7d8-b4ca729a6183)

```sql
SELECT
    vt.TypeName AS VolunteerType,
    COUNT(v.VolunteerID) AS VolunteerCount
FROM Volunteer v
JOIN VolunteerType vt ON v.VolunteerTypeID = vt.VolunteerTypeID
GROUP BY vt.TypeName
ORDER BY VolunteerCount DESC;
```

---

#### 3. 🚫 מתנדבים ללא הכשרה
**English:** Volunteers who never had any training and their manager's name.  
**עברית:** הצגת מתנדבים שמעולם לא עברו הכשרה, כולל פרטי המנהל שלהם.  
🖼️ ![Query 3](https://github.com/user-attachments/assets/69f07dd4-c1a3-4603-9d0e-315e592981a4)

```sql
SELECT
    V.VolunteerID,
    V.FirstName,
    V.LastName,
    M.FirstName || ' ' || M.LastName AS ManagerName,
    M.Email AS ManagerEmail,
    M.PhoneNumber AS ManagerPhoneNumber
FROM Volunteer V
JOIN Manager M ON V.ManagerID = M.ManagerID
WHERE NOT EXISTS (
    SELECT 1 FROM Trained T WHERE T.VolunteerID = V.VolunteerID
);
```

---

#### 4. 📅 מתנדבים בפרוייקטים פתוחים
**English:** Volunteers who are currently assigned to open projects (projects ending in the future).  
**עברית:** הצגת מתנדבים שובצו לפרויקטים שעדיין פעילים.  
🖼️ ![Query 4](https://github.com/user-attachments/assets/f6548dc4-788b-49c3-b804-27482aedc6f6)

```sql
SELECT
    v.FirstName,
    v.LastName,
    p.ProjectName,
    p.EndDate
FROM Volunteer v
JOIN AssignedTo a ON v.VolunteerID = a.VolunteerID
JOIN Project p ON a.ProjectID = p.ProjectID
WHERE p.EndDate > CURRENT_DATE
ORDER BY p.EndDate;
```

---

#### 5. 🗂️ פרטי פרוייקטים
**English:** Details about each project: manager, duration, volunteer count, and current status.  
**עברית:** פרטים על כל פרויקט כולל שם המנהל, תיאור, תאריכים, משך, סטטוס ומספר מתנדבים.  
🖼️ ![Query 5](https://github.com/user-attachments/assets/96c5b746-13ae-4d6c-a09d-aaab3f89571d)

```sql
SELECT
    p.ProjectName,
    p.Description,
    m.FirstName || ' ' || m.LastName AS ManagerName,
    p.StartDate,
    p.EndDate,
    (p.EndDate - p.StartDate) AS DurationDays,
    CASE
        WHEN CURRENT_DATE < p.StartDate THEN 'Not Started'
        WHEN CURRENT_DATE BETWEEN p.StartDate AND p.EndDate THEN 'Active'
        ELSE 'Closed'
    END AS Status,
    COUNT(a.VolunteerID) AS VolunteerCount
FROM Project p
JOIN Manager m ON p.ManagerID = m.ManagerID
LEFT JOIN AssignedTo a ON p.ProjectID = a.ProjectID
GROUP BY
    p.ProjectID, p.ProjectName, p.Description, p.StartDate, p.EndDate, m.FirstName, m.LastName
ORDER BY p.StartDate DESC;
```

---

#### 6. ⏱️ שעות התנדבות חודשיות 
**English:** Total hours volunteered per volunteer per month (based on shift durations).  
**עברית:** חישוב שעות ההתנדבות החודשיות לפי משמרות.  
🖼️ ![Query 6](https://github.com/user-attachments/assets/9c56faec-70d8-4bb1-8704-d3c523a98c92)

```sql
SELECT
    v.FirstName || ' ' || v.LastName AS VolunteerName,
    EXTRACT(YEAR FROM s.ShiftDate) AS Year,
    EXTRACT(MONTH FROM s.ShiftDate) AS Month,
    SUM(EXTRACT(EPOCH FROM (s.EndTime - s.StartTime)) / 3600) AS TotalHours
FROM Volunteer v
JOIN WorksIn w ON v.VolunteerID = w.VolunteerID
JOIN Shift s ON w.ShiftID = s.ShiftID
GROUP BY v.VolunteerID, Year, Month
ORDER BY v.VolunteerID, Year, Month;
```

---

#### 7. 🧠 מתנדבים עם מספר הכשרות
**English:** Volunteers who participated in more than 2 different trainings.  
**עברית:** מתנדבים שעברו יותר משתי הכשרות.  
🖼️ ![Query 7](https://github.com/user-attachments/assets/f2b872d0-0484-4706-b708-a9d377ebfa52)

```sql
SELECT
    v.VolunteerID,
    v.FirstName || ' ' || v.LastName AS VolunteerName,
    COUNT(t.TrainingID) AS TrainingCount
FROM Volunteer v
JOIN Trained t ON v.VolunteerID = t.VolunteerID
GROUP BY v.VolunteerID, v.FirstName, v.LastName
HAVING COUNT(t.TrainingID) > 2
ORDER BY TrainingCount DESC;
```

---

#### 8. 📚 הצעות הכשרה למתנדבים ללא הכשרה כלל 
**English:** Suggest trainings for volunteers who never had any training, only if the training:  
- Is today or in the future  
- Doesn't overlap with any project assigned to the volunteer  

**עברית:** הצעת הכשרות עתידיות למתנדבים שלא עברו שום הכשרה, כל עוד אין חפיפה לפרויקטים שלהם.  
🖼️ ![Query 8](https://github.com/user-attachments/assets/b6a8f9c3-7593-4825-a94c-9909d4b76c1f)

```sql
SELECT
    v.VolunteerID,
    v.FirstName || ' ' || v.LastName AS VolunteerName,
    t.TrainingID,
    t.TrainingName,
    t.TrainingDate
FROM Volunteer v
CROSS JOIN Training t
WHERE NOT EXISTS (
    SELECT 1
    FROM Trained tr
    WHERE tr.VolunteerID = v.VolunteerID
)
AND NOT EXISTS (
    SELECT 1
    FROM AssignedTo a
    JOIN Project p ON a.ProjectID = p.ProjectID
    WHERE a.VolunteerID = v.VolunteerID
      AND t.TrainingDate BETWEEN p.StartDate AND p.EndDate
)
AND t.TrainingDate >= CURRENT_DATE
ORDER BY v.VolunteerID, t.TrainingDate;
```
---
### 3 שאילתות DELETE
#### 1. מחיקת מתנדבים שלא עברו אף הכשרה במשך שנה שלמה אחרונה 


![photo_5764772063687591304_y](https://github.com/user-attachments/assets/d9e179d2-3d85-45ec-a59a-7117564571ce)

#### 2. מחיקה של פרויקטים בתיאורם מופיעה המילה "Post-Surgery Assistance" 
![photo_5764772063687591306_y](https://github.com/user-attachments/assets/5a1dcb48-83ed-4962-aa60-e73e8ef02c4a)

#### 3.  מחיקה של משמרות בפברואר שלא שובץ אליהן אף מתנדב 
![photo_5764772063687591307_y](https://github.com/user-attachments/assets/bac05ff9-a022-4f32-94b8-439d61eee583)

---
### 3 שאילתות UPDATE

#### 1. הארכת פרוייקטים פתוחים ב-30 יום
לפני העדכון:
![עדכוןלפני1](https://github.com/user-attachments/assets/c8ce0447-09a0-44b3-8073-a36c47615e7d)

לאחר העדכון:
![עדכוןאחרי1](https://github.com/user-attachments/assets/b4d32b14-fc9c-42d8-a77f-9f7726adf744)

#### 2. הוספת תגית "[CLOSED]" לשדה התיאור של פרוייקטים סגורים.
לפני העדכון:
![עדכוןלפני2](https://github.com/user-attachments/assets/de06c1e0-87e3-4ce6-afd0-2dad3addc210)

לאחר העדכון:
![עדכוןאחרי2](https://github.com/user-attachments/assets/2c6b24a1-d9c2-4843-8c09-efb820c0133c)

#### 3. הוספת תגית "[Experienced]" לשדה הכישורים של מתנדבים שהשתתפו ביותר מ־3 פרויקטים.
לפני העדכון:
![עדכוןלפני3](https://github.com/user-attachments/assets/2405be3b-5b76-4058-aa67-80026b699bc7)

לאחר העדכון:
![עדכוןאחרי3](https://github.com/user-attachments/assets/ca7c9235-f238-40f1-a497-f2c8150296ca)

---
### אילוצים בטבלאות (Constraints)

#### 1. אילוץ UNIQUE על טבלת Shift

תיאור האילוץ:  
הגדרנו אילוץ מסוג UNIQUE על שילוב השדות ShiftDate, StartTime, EndTime כדי למנוע מצב של משמרות כפולות באותו תאריך וזמן.
```sql
ALTER TABLE Shift
ADD CONSTRAINT uniq_shift_datetime
UNIQUE (ShiftDate, StartTime, EndTime);
```

בדיקת תקינות האילוץ (הדגמת שגיאה):
```sql

-- הכנסה תקינה
INSERT INTO Shift (ShiftID, StartTime, EndTime, ShiftDate)
VALUES (401, '09:00', '17:00', '2025-04-16');

-- הכנסה סותרת את האילוץ
INSERT INTO Shift (ShiftID, StartTime, EndTime, ShiftDate)
VALUES (402, '09:00', '17:00', '2025-04-16');
```

הרצה:
![1](https://github.com/user-attachments/assets/e0f24073-2747-4042-b3f4-73847e819ca5)


---

#### 2. אילוץ CHECK על אורך מספר טלפון בטבלת Volunteer

תיאור האילוץ:  
הוספנו אילוץ מסוג CHECK אשר מוודא שמספר הטלפון כולל לפחות 9 תווים, כדי להבטיח תקינות של נתוני יצירת קשר.
```sql
ALTER TABLE Volunteer
ADD CONSTRAINT chk_phone_length
CHECK (LENGTH(PhoneNumber) >= 9);
```

בדיקת תקינות האילוץ (הדגמת שגיאה):
```sql


INSERT INTO Volunteer (VolunteerID, FirstName, LastName, PhoneNumber, Email, Skill, ManagerID, VolunteerTypeID)
VALUES (401, 'Jane', 'Smith', '12345678', 'jane.smith@email.com', 'Skills', 1, 1);

```

הרצה:
![2](https://github.com/user-attachments/assets/c3ac02b1-d4e4-4029-8beb-ee0466e1e54f)

---

#### 3. אילוץ DEFAULT על שדה StartDate בטבלת Project

תיאור האילוץ:  
הוגדר ערך ברירת מחדל (DEFAULT) לעמודת StartDate, כך שאם לא יוזן תאריך התחלה, יוזן אוטומטית תאריך היום (CURRENT_DATE).
```sql

ALTER TABLE Project
ALTER COLUMN StartDate
SET DEFAULT CURRENT_DATE;
```


בדיקת תקינות האילוץ (הדגמה):
```sql

-- הכנסה מבלי לציין תאריך התחלה (StartDate)
INSERT INTO Project (ProjectID, ProjectName, Description, EndDate, ManagerID)
VALUES (401, 'Project A', 'Description A', '2025-05-01', 1);

-- בדיקה שהתאריך שנקלט הוא אכן תאריך היום
SELECT * FROM Project WHERE ProjectID = 401;

```
הרצה:
![3](https://github.com/user-attachments/assets/b8968dc1-c03c-4301-b512-23e0e0556a5e)


---
### הדגמת ROLLBACK
#### 1. פקודת BEGIN והצגת המסד נתונים לפני עדכון
![image](https://github.com/user-attachments/assets/75111493-99b3-454a-8e9f-1c0fd78d7ccf)

#### 2. עדכון מסד הנתונים והצגתו
![image](https://github.com/user-attachments/assets/57a9b7e0-9074-46dc-ba5f-a9c0c46ddc81)

#### 3. ביצוע פקודת ROLLBACK והצגת מסד נתונים (העדכון הוסר)
![image](https://github.com/user-attachments/assets/fa01eab8-57b1-4f4e-8278-9b925ae542c8)
---



### הדגמת COMMIT
#### 1. עדכון מסד הנתונים והצגתו
![image](https://github.com/user-attachments/assets/c2bf9528-4827-4188-8d48-2237c4c291b1)

#### 2. ביצוע פקודת ROLLBACK והצגת מסד נתונים (העדכון נכנס לתוקף)
![image](https://github.com/user-attachments/assets/1297ce44-0b30-4121-87ca-66de76ab64fc)

---
# שלב ג': אינטגרציה ומבטים

### אלגוריתם הינדוס לאחור

#### שלב א: ניתוח טבלאות

א. נזהה כל טבלה כישות פוטנציאלית:  
- שם הטבלה יהפוך לשם הישות.  
- העמודות יהפכו למאפיינים.

ב. נזהה את המפתח הראשי (Primary Key).

ג. נזהה מפתחות זרים (Foreign Keys):  
- מהם נגזרים הקשרים (Relationships) בין הישויות.

ד. נבחן שמות של טבלאות שעשויות לייצג קשרים בעצמן:  
- אם טבלה מורכבת רק ממפתחות זרים לשתי טבלאות אחרות – ייתכן שהיא מייצגת קשר מסוג רבים־לרבים.

#### שלב ב: יצירת DSD

א. ניצור כל טבלה כמלבן עם שם ושדות:  
- הדגשה של המפתח הראשי.  
- סימון של מפתחות זרים.

ב. נסמן קשרים בין הטבלאות על סמך המפתחות הזרים:  
- כל מפתח זר יוצר חץ מהטבלה שבה הוא נמצא אל הטבלה שאליה הוא מקשר.

#### שלב ג: המרה ל־ERD

א. נהפוך כל טבלה עצמאית לישות (Entity).

ב. נהפוך טבלאות־קשר ל־Relationships:  
- לדוגמה: הטבלה `Volunteer_Project (volunteer_id, project_id)` מייצגת קשר בין `Volunteer` ל־`Project`.

ג. נסמן את סוג הקשר לפי מאפייני ה־FK:
- אם FK הוא גם PK → הקשר הוא 1:1.  
- אם FK אינו PK ואינו ייחודי → הקשר הוא 1:N או M:N.

ד. נסמן השתתפות (Participation):  
- אם FK הוא `NOT NULL` → מדובר בקשר חובה (Mandatory).

ה. זיהוי ירושה (Generalization):  
- כאשר מספר ישויות חולקות מאפיינים משותפים, יוצרים ישות־על (Superclass) ותתי־ישויות (Subclasses).

ו. זיהוי ישות חלשה (Weak Entity):  
- ישות ללא מפתח ראשי עצמאי, התלויה בישות אחרת (לרוב באמצעות FK כחלק מהמפתח הראשי).  
- מיוצגת במלבן כפול, עם קשר מזהה והשתתפות מלאה בקשר.
---

### תרשים DSD של האגף החדש
![imageDSD רקישנ](https://github.com/user-attachments/assets/802af66e-a319-43bb-98ec-29827616e06d)

### תרשים ERD של האגף החדש

![imageDSDNON](https://github.com/user-attachments/assets/9724f28b-b3f4-4a52-9050-b84f95b569cd)
---

### תרשים ERD לאחר האינטגרציה

![ERDDDDDDDDDDDDDDDDDD](https://github.com/user-attachments/assets/fdb93739-0c0d-40d5-a2c5-dae11e0e6690)

### תרשים DSD לאחר אינטגרציה

![DSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS](https://github.com/user-attachments/assets/fd65ef3d-c382-47bb-b006-7461610e9165)

---
### **תיאור תהליך האינטגרציה במסד הנתונים**

במסגרת תהליך אינטגרציית הנתונים במסד הנתונים של מערכת ניהול מתנדבים בבית חולים, ביצענו מספר שלבים משמעותיים שמטרתם לאחד ישויות שונות, לפשט את המודל ולשפר את היכולת לנהל ולתחזק את המידע. להלן הסבר מילולי של השלבים והפקודות שבוצעו:

### 1. יצירת ישות מאוחדת: Person

מכיוון שיש לנו מספר ישויות שונות המייצגות בני אדם (כמו מתנדבים, מנהלים, מטופלים, אנשי צוות), החלטנו ליצור ישות אחת בשם `Person` שתכיל את כל המידע הבסיסי המשותף לכל אדם (שם, אימייל, טלפון, כתובת, תאריך לידה וכו’):

```sql
CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    birthday DATE,
    gender VARCHAR(10)
);
```

### 2. העברת נתונים ל-`Person`

ביצענו העברה של הנתונים מתוך הטבלאות הישנות (`Manager`, `Volunteer`, `Patient`, `Staff_Member`) לישות החדשה `Person`:

```sql
-- Insert from Manager
INSERT INTO Person (id, FirstName, LastName, email, phone)
SELECT ManagerID, FirstName, LastName, Email, PhoneNumber FROM Manager;

-- Insert from Volunteer
INSERT INTO Person (id, FirstName, LastName, email, phone)
SELECT VolunteerID, FirstName, LastName, Email, PhoneNumber FROM Volunteer;

-- Insert from Patient
INSERT INTO Person (...)
-- כולל פיצול שם מלא לשם פרטי ומשפחה

-- Insert from Staff_Member
INSERT INTO Person (...)
-- כולל יצירת אימייל וטלפון רנדומליים
```

### 3. יצירת ישות `Worker` לאיחוד עובדים (מנהלים + אנשי צוות)

```sql
CREATE TABLE Worker (
  W_id SERIAL PRIMARY KEY,
  Role VARCHAR(50) NOT NULL,
  FOREIGN KEY (W_id) REFERENCES Person(id)
);
```

לאחר מכן העברנו את המנהלים ואנשי הצוות לישות זו:

```sql
INSERT INTO Worker (W_id, Role)
SELECT ManagerID, 'Manager' FROM Manager;

INSERT INTO Worker (W_id, Role)
SELECT id, role FROM Staff_Member;
```

### 4. עדכון קשרים לטבלאות אחרות

שינינו את מפתחות הזרים בטבלאות שתלויות במנהל או איש צוות כך שיפנו ל-`Worker` במקום ל-`Manager` או `Staff_Member`:

```sql
ALTER TABLE Volunteer DROP CONSTRAINT ... ADD CONSTRAINT ... REFERENCES Worker;
ALTER TABLE Project DROP CONSTRAINT ... ADD CONSTRAINT ... REFERENCES Worker;
ALTER TABLE Appointment DROP CONSTRAINT ... ADD CONSTRAINT ... REFERENCES Worker;
```

### 5. יצירת טבלה חדשה: `VolunteerInTreatPlan`

הוספנו טבלה שמייצגת את הקשר בין מתנדב לתוכנית טיפול:

```sql
CREATE TABLE VolunteerInTreatPlan (
    VolunteerID INT NOT NULL,
    TreatType VARCHAR(50) NOT NULL,
    PatientID INT NOT NULL,
    PRIMARY KEY (VolunteerID, TreatType, PatientID),
    FOREIGN KEY (...) REFERENCES ...
);
```

והכנסנו לתוכה רשומות רנדומליות:

```sql
INSERT INTO VolunteerInTreatPlan (...)
SELECT ... FROM Volunteer CROSS JOIN TreatmentPlan ORDER BY RANDOM() LIMIT 100;
```

### 6. עדכון מפתח ראשי ב-m\_record

```sql
ALTER TABLE m_record ADD COLUMN RecordID SERIAL PRIMARY KEY;
ALTER TABLE m_record DROP CONSTRAINT m_record_pkey;
ALTER TABLE m_record ADD CONSTRAINT m_record_pkey PRIMARY KEY (RecordID, patient_id);
ALTER TABLE m_record ADD CONSTRAINT unique_patient_record UNIQUE (patient_id);
```

### 7. מחיקת טבלאות ישנות

```sql
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Staff_Member;
```

### 8. טיהור טבלאות קיימות

ביצענו הסרה של עמודות כפולות שכבר הועברו ל-`Person`, והוספת קשרים לישות `Person`:

```sql
-- Volunteer
ALTER TABLE Volunteer ADD CONSTRAINT ... FOREIGN KEY REFERENCES Person;
ALTER TABLE Volunteer DROP COLUMN FirstName, ...;

-- Patient
ALTER TABLE Patient ADD CONSTRAINT ... FOREIGN KEY REFERENCES Person;
ALTER TABLE Patient DROP COLUMN name, address, ...;
```

### 9. שינוי שמות טבלאות

שינינו שמות טבלאות כך שישקפו טוב יותר את התוכן שלהן:

```sql
ALTER TABLE use RENAME TO useEquipment;
ALTER TABLE m_equipment RENAME TO MedicalEquipment;
...
```

### 10. שינוי שמות עמודות

שינינו שמות עמודות כך שיהיו תואמות לקונבנציות של snake\_case ולשמות ברורים ואחידים:

```sql
ALTER TABLE person RENAME COLUMN firstname TO first_name;
ALTER TABLE worker RENAME COLUMN w_id TO worker_id;
...
```

---

### החלטות עיצוב באינטגרציה
בשלב האינטגרציה של בסיס הנתונים, בוצעו מספר החלטות מבניות מהותיות שנועדו לפשט את המודל, למנוע כפילויות, ולוודא עקביות לוגית בין הישויות. להלן פירוט ההחלטות המרכזיות:

א. **טבלת־על Person:**  
  נוצרה טבלה חדשה בשם `Person` הכוללת את כל המידע האישי הבסיסי המשותף למנהלים, מתנדבים, מטופלים ועובדים.  
  שדות לדוגמה: `FirstName`, `LastName`, `email`, `phone`, `address`, `birthday`, `gender`.  
  כל ישות המקושרת לאדם משתמשת ב־`Person` כבסיס ומתחברת אליו בעזרת מפתח זר.

ב. **מיזוג Manager ו־Staff_Member ל־Worker:**  
  נוצרה ישות אחת בשם `Worker` הכוללת את כל העובדים, כאשר תפקידו של כל עובד נשמר בשדה `Role`.  
  לדוגמה: מנהל מוגדר כעובד עם `Role = 'Manager'`.  
  ה־`W_id` הוא גם מפתח ראשי וגם מפתח זר ל־`Person`.  
  כל האילוצים והקשרים שכוונו ל־`Manager` ו־`Staff_Member` עודכנו שיפנו ל־`Worker`.

ג. **הסרת כפילויות ושמירה על עקרון נורמליזציה:**  
  הוסרו עמודות כפולות של מידע אישי (שם, טלפון, אימייל וכו') מהטבלאות `Volunteer`, `Patient` ו־`Staff_Member`, וכל המידע הזה נשמר מעתה בטבלת `Person`.  
  נעשתה התאמה של מפתחות זרים בהתאם.

ד. **שדרוג טבלת רשומות רפואיות (`MedicalRecord`):**  
  נוספה עמודת מפתח חדש `RecordID` מסוג `SERIAL`.  
  הוגדר מפתח ראשי משולב: `(RecordID, patient_id)` יחד עם אילוץ ייחודי על `patient_id` כדי למנוע ריבוי רשומות עבור אותו מטופל.

ה. **הפיכת `Appointment` מיישות חלשה לקשר ישיר:**  
  במקום שתהיה ישות נפרדת, `Appointment` הפכה לקשר בין `Patient` ל־`Worker` עם מפתח זר לכל אחת מהטבלאות.  
  זה מייצג בצורה נכונה יותר את העובדה שמדובר באירוע המתרחש בין שני גורמים קיימים.

ו. **יצירת קשר בין מתנדבים לתוכניות טיפול (`VolunteerInTreatPlan`):**  
  נוצר קשר חדש שמתעד את הקשר בין מתנדבים לתוכניות טיפול של מטופלים.  
  הקשר כולל שלושה שדות כמפתח ראשי: `VolunteerID`, `TreatType`, `PatientID`.  
  מאפשר לדעת אילו מתנדבים מעורבים באילו תוכניות ובאילו מטופלים.

ז. **שינוי שמות טבלאות ושדות לצורך אחידות ובהירות:**  
  שונו שמות של מספר טבלאות ומספר שדות לשמות ברורים ואחידים:
  - `m_record` → `MedicalRecord`
  - `m_equipment` → `MedicalEquipment`
  - `treat_plan` → `TreatmentPlan`
  - `WorksIn` → `VolunteerShift`
  - `Trained` → `VolunteerTraining`
  - `AssignedTo` → `VolunteerProject`
  - `use` → `use_equipment`
  - `date` → `appointment_date`
  - `family_s` → `family_status`
  - `patientid` → `patient_id`
  

---
### ****מבטים****
### **מבט ראשון - מחלקת מתנדבים**
 ```sql
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
``` 
מבט שמציג את סיכום כל מתנדב כולל פרטיו שם המנהל, כישורים, וספירות של הכשרות, פרויקטים ותוכניות שיקום. 

הרצה:
![image](https://github.com/user-attachments/assets/094bfe8a-1516-40a9-8df8-0f4c8c4d4aab)


#### **שאילתא ראשונה**
```sql
SELECT 
    volunteer_id,
    volunteer_name,
    phone_number,
    manager_name
FROM VolunteerFullSummary
WHERE training_count = 0;
``` 
מציג את כל המתנדבים שלא עברו אף הכשרה, כולל פרטי קשר ומנהל בכדי לקבוע עבורם הכשרה.

הרצה:

![image](https://github.com/user-attachments/assets/31a2bd26-5bdd-4e9d-b58f-4353eb3f8aba)

#### **שאילתא שנייה**
```sql
SELECT 
    volunteer_id,
    volunteer_name,
    project_count
FROM VolunteerFullSummary
ORDER BY project_count DESC
LIMIT 10;
``` 
מציג את 10 המתנדבים שהשתתפו במספר הפרויקטים הגבוה ביותר עבור הענקת אות הצטיינות.

הרצה:

![image](https://github.com/user-attachments/assets/eb043ca3-46dc-4c40-912f-506e34d01e64)

---
### **מבט שני - מחלקת שיקום**

```sql
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
``` 
מציג מידע על המטופלים, תוכנית הטיפול שלהם, הציוד שבו הם משתמשים, והמתנדבים שמעורבים.

הרצה:

![image](https://github.com/user-attachments/assets/e7e76745-87c9-4147-8da8-4ce76d908860)


#### **שאילתא ראשונה**
```sql
SELECT patient_id,
    treatment_type,
    start_date,
    end_date,
    sessions_per_week
FROM PatientTreatmentOverview
WHERE volunteer_id is NULL;
``` 
מציג תוכניות שיקופ שהן ללא מתנדב, בכדי לבדוק אופציות שיבוץ למתנדבים. 

הרצה:

![image](https://github.com/user-attachments/assets/5e165c94-58d9-4d67-9f58-12ae47e0a57e)


#### **שאילתא שנייה**
```sql
SELECT treatment_type, SUM(sessions_per_week) AS total_sessions
FROM PatientTreatmentOverview
GROUP BY treatment_type;
``` 
כמה מפגשים שבועיים מתוכננים לכל סוג טיפול, לצורך איסוף נתונים סטטיסטיים.

הרצה:


![image](https://github.com/user-attachments/assets/f4dfb622-2a2f-4002-8295-b115952b8b9f)

---

# **שלב ד': תכנות**  

## 📊 פונקציות

### פונקציה 1: חישוב עומס עבודה של מתנדבים

**תיאור מילולי:**
פונקציה זו מחשבת את עומס העבודה של כל מתנדב במערכת על בסיס מספר הפרויקטים, המשמרות וההכשרות שלו. הפונקציה משתמשת ב-Cursor מפורש לעיבור כל המתנדבים, מחשבת ציון עומס משוקלל, ומסווגת כל מתנדב לקטגוריית עומס מתאימה. הפונקציה מחזירה טבלה עם פרטי העומס של כל מתנדב.

**הקוד:**
```sql
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
            category := 'High Load';
        ELSIF score >= 10 THEN
            category := 'Medium Load';
        ELSIF score >= 5 THEN
            category := 'Low Load';
        ELSE
            category := 'Minimal Load';
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
        RAISE NOTICE 'Error calculating workload: %', SQLERRM;
        RETURN;
END;
$$ LANGUAGE plpgsql;
```

הרצה:
![photo_5906829537226902241_y](https://github.com/user-attachments/assets/c29ed832-daae-43f2-a42d-abdbdb29de1b)


### פונקציה 2: החזרת REF CURSOR למטופלים פעילים

**תיאור מילולי:**
פונקציה זו מחזירה REF CURSOR המכיל מידע על מטופלים פעילים במערכת. הפונקציה בודקת תחילה שקיימים מטופלים במערכת, ואז פותחת cursor עם שאילתה מורכבת הכוללת מידע רפואי ופרטי טיפול. הנתונים כוללים שם המטופל, חומרת הפציעה, סיבת הפציעה, מספר המתנדבים המטפלים וסוגי הטיפולים.

**הקוד:**
```sql
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
        RAISE EXCEPTION 'No patients found in system';
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
        RAISE NOTICE 'Error returning cursor: %', SQLERRM;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```
הרצה


![image](https://github.com/user-attachments/assets/2872e0b4-3b6c-4e23-9b87-2fac3cc9d1dd)

---

## 🔧 פרוצדורות

### פרוצדורה 1: ניהול פרויקטים - הקצאה והסרה אוטומטית

**תיאור מילולי:**
פרוצדורה מתקדמת לניהול הקצאות מתנדבים לפרויקטים. הפרוצדורה מקבלת פרמטרים לסוג הפעולה (הוספה/הסרה), מזהה מתנדב ומזהה פרויקט אופציונלי. במקרה של הוספה ללא פרויקט ספציפי, הפרוצדורה מוצאת אוטומטית פרויקט מתאים. הפרוצדורה כוללת בדיקות תקינות, הגבלת מספר פרויקטים למתנדב, וניהול שגיאות מתקדם.

**הקוד:**
```sql
-- ================================================
-- פרוצדורה 1: ניהול פרויקטים - הקצאה והסרה אוטומטית
-- ================================================
CREATE OR REPLACE PROCEDURE manage_volunteer_projects(
    IN action_type VARCHAR,
    IN p_volunteer_id INTEGER,
![Uploading photo_5906829537226902246_y.jpg…]()
    IN p_project_id INTEGER DEFAULT NULL
) AS $$![Uploading photo_5906829537226902246_y.jpg…]()

DECLARE![Uploading photo_5906829537226902246_y.jpg…]()

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
                    
                    RAISE NOTICE 'Volunteer % assigned to project %', vol_rec.first_name || ' ' || vol_rec.last_name, selected_project;
                ELSE
                    RAISE NOTICE 'No suitable projects found for volunteer %', vol_rec.first_name;
                END IF;
            ELSE
                RAISE NOTICE 'Volunteer % already participates in % projects (maximum 3)', vol_rec.first_name, current_projects;
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
            
            RAISE NOTICE 'Volunteer % assigned to project %', vol_rec.first_name, proj_rec.project_name;
        END IF;
        
    ELSIF action_type = 'REMOVE' THEN
        -- הסרת מתנדב מפרויקט
        IF p_project_id IS NULL THEN
            -- הסרה מכל הפרויקטים
            DELETE FROM volunteerProject WHERE volunteer_id = p_volunteer_id;
            RAISE NOTICE 'Volunteer % removed from all projects', vol_rec.first_name;
        ELSE
            -- הסרה מפרויקט ספציפי
            DELETE FROM volunteerProject 
            WHERE volunteer_id = p_volunteer_id AND project_id = p_project_id;
            RAISE NOTICE 'Volunteer % removed from project %', vol_rec.first_name, p_project_id;
        END IF;
        
    ELSE
        RAISE EXCEPTION 'Invalid action type: %. Use ADD or REMOVE', action_type;
    END IF;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'Error in project management: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;
```
הרצה עם ADD:
![image](https://github.com/user-attachments/assets/05dbcb31-9ac9-4fe2-a14c-7e891b8c8e46)

הרצה עם REMOVE:
![image](https://github.com/user-attachments/assets/ad657ac7-e576-4c5b-ac95-37242a13a297)



### פרוצדורה 2: עדכון סטטוס ציוד רפואי עם דוח מפורט

**תיאור מילולי:**
פרוצדורה מתקדמת לעדכון אוטומטי של סטטוס ציוד רפואי על בסיס גיל הציוד ותדירות השימוש. הפרוצדורה מקבלת פרמטר עבור גיל מינימלי לבדיקה, עוברת על כל פריטי הציוד באמצעות Cursor, מחשבת סטטוס חדש לפי אלגוריתם מתוחכם, ומייצרת דוח מפורט של כל השינויים שבוצעו.

**הקוד:**
```sql
-- ================================================
-- פרוצדורה 2: עדכון סטטוס ציוד רפואי עם דוח מפורט
-- ================================================
CREATE OR REPLACE PROCEDURE update_equipment_status_report(
    IN equipment_age_threshold INTEGER DEFAULT 5,
    OUT updated_count INTEGER,
    OUT report_text TEXT
) AS $$
DECLARE
    equip_rec RECORD;
    equip_cursor CURSOR FOR
        SELECT equipment_id, equipment_name, destination_age, status
        FROM medicalEquipment
        WHERE destination_age >= equipment_age_threshold;
    old_status VARCHAR;
    new_status VARCHAR;
    usage_count INTEGER;
    report_lines TEXT[] := ARRAY[]::TEXT[];
    total_updated INTEGER := 0;
BEGIN
    report_lines := array_append(report_lines, '=== Medical Equipment Status Update Report ===');
    report_lines := array_append(report_lines, 'Date: ' || CURRENT_DATE);
    report_lines := array_append(report_lines, 'Minimum age for inspection: ' || equipment_age_threshold || ' years');
    report_lines := array_append(report_lines, '');
    
    -- לולאה על כל פריט ציוד
    FOR equip_rec IN equip_cursor LOOP
        old_status := equip_rec.status;
        
        -- בדיקת שימוש בציוד
        SELECT COUNT(*) INTO usage_count
        FROM useEquipment
        WHERE equipment_id = equip_rec.equipment_id;
        
        -- קביעת סטטוס חדש לפי גיל ושימוש
        IF equip_rec.destination_age >= 10 THEN
            IF usage_count > 5 THEN
                new_status := 'Urgent Maintenance Required';
            ELSE
                new_status := 'For Inspection';
            END IF;
        ELSIF equip_rec.destination_age >= 7 THEN
            new_status := 'Preventive Maintenance';
        ELSE
            new_status := 'Active';
        END IF;
        
        -- עדכון הסטטוס אם השתנה
        IF old_status IS DISTINCT FROM new_status THEN
            UPDATE medicalEquipment 
            SET status = new_status 
            WHERE equipment_id = equip_rec.equipment_id;
            
            total_updated := total_updated + 1;
            
            report_lines := array_append(report_lines, 
                'Equipment: ' || equip_rec.equipment_name || 
                ' (ID: ' || equip_rec.equipment_id || ')' ||
                ' - Age: ' || equip_rec.destination_age || 
                ' - Usage: ' || usage_count ||
                ' - Status changed from "' || COALESCE(old_status, 'NULL') || 
                '" to "' || new_status || '"');
        END IF;
    END LOOP;
    
    updated_count := total_updated;
    
    IF total_updated = 0 THEN
        report_lines := array_append(report_lines, 'No updates required.');
    ELSE
        report_lines := array_append(report_lines, '');
        report_lines := array_append(report_lines, 'Total equipment items updated: ' || total_updated);
    END IF;
    
    report_text := array_to_string(report_lines, E'\n');
    
EXCEPTION
    WHEN OTHERS THEN
        updated_count := -1;
        report_text := 'Error updating equipment status: ' || SQLERRM;
        ROLLBACK;
END;
$$ LANGUAGE plpgsql;
```

---

## 🚨 טריגרים

### טריגר 1: בדיקות בהקצאת מתנדבים לפרויקטים

**תיאור מילולי:**
טריגר מתקדם הפועל לפני הוספה או עדכון בטבלת volunteerProject. הטריגר בודק ניגודי עניינים פוטנציאליים כמו השמה לפרוייקטים לא פעילים, עומס יתר של פרויקטים, חפיפות זמן בין פרויקטים. הטריגר מספק אזהרות למצבים פחות קריטיים וחוסם פעולות במצבים שעלולים לגרום לבעיות.

**הקוד:**
```sql
-- ================================================
-- טריגר 1: בדיקות בהקצאת מתנדבים לפרויקטים
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
```
הרצה - נסיון השמה לפרוייקט שהסתים:
![image](https://github.com/user-attachments/assets/a5f08ff4-12d2-4bc4-a4eb-5ba497711f6e)

הרצה - נסיון השמה מתנדב עם עומס:
![image](https://github.com/user-attachments/assets/317628bf-61b2-440b-b91a-91ba85616d4a)


 

### טריגר 2: רישום היסטוריה של שינויים במידע מטופלים

**תיאור מילולי:**
טריגר מקיף הפועל אחרי כל פעולת הוספה, עדכון או מחיקה בטבלת medicalRecord. הטריגר רושם את כל השינויים בטבלת היסטוריה נפרדת, כולל ערכים ישנים וחדשים. הטריגר גם מספק אזהרות אוטומטיות כאשר חומרת הפציעה של מטופל גדלה משמעותית, מה שעשוי לדרוש התערבות רפואית מיידית.

**הקוד:**
```sql
-- ================================================
-- טריגר 2: רישום היסטוריה של שינויים במידע מטופלים
-- ================================================

-- יצירת טבלת היסטוריה (ללא שינוי הטבלאות הקיימות)
CREATE TABLE IF NOT EXISTS medical_record_history (
    history_id SERIAL PRIMARY KEY,
    record_id INTEGER,
    patient_id INTEGER,
    old_severity INTEGER,
    new_severity INTEGER,
    old_cause VARCHAR,
    new_cause VARCHAR,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    change_type VARCHAR
);

CREATE OR REPLACE FUNCTION log_medical_record_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        -- רישום שינויים
        INSERT INTO medical_record_history (
            record_id, patient_id, old_severity, new_severity,
            old_cause, new_cause, change_type
        ) VALUES (
            OLD.record_id, OLD.patient_id, OLD.severity_of_injury, NEW.severity_of_injury,
            OLD.cause_of_injury, NEW.cause_of_injury, 'UPDATE'
        );
        
        -- בדיקת שינוי משמעותי בחומרת הפציעה
        IF NEW.severity_of_injury > OLD.severity_of_injury + 2 THEN
            RAISE NOTICE 'Warning: injury severity for patient % increased significantly from % to %', 
                        OLD.patient_id, OLD.severity_of_injury, NEW.severity_of_injury;
        END IF;
        
        RETURN NEW;
        
    ELSIF TG_OP = 'INSERT' THEN
        INSERT INTO medical_record_history (
            record_id, patient_id, new_severity, new_cause, change_type
        ) VALUES (
            NEW.record_id, NEW.patient_id, NEW.severity_of_injury, 
            NEW.cause_of_injury, 'INSERT'
        );
        
        RETURN NEW;
        
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO medical_record_history (
            record_id, patient_id, old_severity, old_cause, change_type
        ) VALUES (
            OLD.record_id, OLD.patient_id, OLD.severity_of_injury, 
            OLD.cause_of_injury, 'DELETE'
        );
        
        RETURN OLD;
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_medical_record_history
    AFTER INSERT OR UPDATE OR DELETE ON medicalRecord
    FOR EACH ROW
    EXECUTE FUNCTION log_medical_record_changes();
```

---

## 🔄 תוכניות ראשיות

### תוכנית ראשית 1: דוח מתנדבים כולל ניהול פרויקטים

**תיאור מילולי:**
תוכנית ראשית מקיפה המבצעת ניתוח מלא של עומסי העבודה של מתנדבים וניהול אוטומטי של הקצאות פרויקטים. התוכנית קוראת לפונקציית חישוב עומס העבודה, מציגה דוח מפורט על כל המתנדבים, מזהה מתנדבים עם עומס גבוה, ומבצעת הקצאות אוטומטיות של פרויקטים נוספים למתנדבים עם עומס נמוך. התוכנית כוללת ניהול שגיאות מתקדם והדפסות מידעיות מפורטות.

**הקוד:**
```sql
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
```
הרצה - לוג דיווח מתנדבים:
![image](https://github.com/user-attachments/assets/7ac644c7-e90e-4fe4-b90c-c4df808940a7)
הרצה - לוג ניהול הקצאות מתנדים לפרוייקטים:
![image](https://github.com/user-attachments/assets/1ab8f194-81e1-423b-962a-95ba506abe51)



