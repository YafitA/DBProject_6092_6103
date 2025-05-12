

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
  - [תרשים ERD משותף](#תרשים-erd-משותף)
  - [תרשים DSD לאחר אינטגרציה](#תרשים-dsd-לאחר-אינטגרציה)
  - [החלטות עיצוב באינטגרציה](#החלטות-עיצוב-באינטגרציה)

  



---

## **שלב א': עיצוב, בנייה ואכלוס נתונים וגיבוי**  

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

## **שלב ב': שאילתות**

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
## שלב ג': אינטגרציה ומבטים

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
### ✅ החלטות עיצוב באינטגרציה
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
  שונו שמות של מספר טבלאות לשמות ברורים ואחידים:
  - `m_record` → `MedicalRecord`
  - `m_equipment` → `MedicalEquipment`
  - `treat_plan` → `TreatmentPlan`
  - `WorksIn` → `VolunteerShift`
  - `Trained` → `VolunteerTraining`
  - `AssignedTo` → `VolunteerProject`
  - `use` → `use_equipment`
  שונו שמות של מספר לשדות ברורים ואחידים - לדוגמא:
  - `equip_id` → `equipment_id`
  - `patientid` → `patient_id`
  - `family_s` → `family_status`
  - `patientid` → `patient_id`
  - `date` → `appointment_date`

---


