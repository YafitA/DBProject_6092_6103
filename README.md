

# **Hospital Volunteer Management System**  

**פרויקט מסד נתונים – ניהול מתנדבים בבית חולים**  
**הוגש על ידי: אביטל חזן ויפית אטון**  

---

## **תוכן עניינים**  
- [שלב א': עיצוב, בנייה ואכלוס נתונים וגיבוי](#שלב-א-עיצוב-בנייה-ואכלוס-נתונים-וגיבוי)  
  - [מבוא](#מבוא)  
  - [ERD - תרשים ישויות וקשרים](#erd---תרשים-ישויות-וקשרים)  
  - [DSD - תרשים מבנה נתונים](#dsd---תרשים-מבנה-נתונים)  
  - [קבצי SQL](#קבצי-sql)  
  - [אכלוס נתונים בשלוש שיטות](#אכלוס-נתונים-בשלוש-שיטות)  
  - [גיבוי ושחזור](#גיבוי-ושחזור)  
- [שלב ב': אינטגרציה ובדיקות](#שלב-ב-אינטגרציה-ובדיקות)  

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

### **ERD - תרשים ישויות וקשרים**  
![PhaseA/ERDAndDSTFiles/ERD.png](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/ERDAndDSTFiles/ERD.png?raw=true)

---

### **DSD - תרשים מבנה נתונים**  
![DSD Diagram](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/ERDAndDSTFiles/DSD.png?raw=true).

---
### **קבצי SQL**  
הסקריפטים SQL הבאים זמינים ב-repository:

- **Create Tables Script** - הסקריפט ליצירת הטבלאות בבסיס הנתונים נמצא ב-repository:  
📜 [View create_tables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/createTables.sql)

- **Insert Data Script** - הסקריפט להכנסת נתונים לטבלאות בבסיס הנתונים נמצא ב-repository:  
📜 [View insert_tables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/insertTables.sql)

- **Drop Tables Script** - הסקריפט למחיקת הטבלאות נמצא ב-repository:  
📜 [View drop_tables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/dropTables.sql)

- **Select All Data Script** - הסקריפט לבחירת כל הנתונים מהטבלאות נמצא ב-repository:  
📜 [View selectAll_tables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/selectAll.sql)


### 

📜 **[יצירת טבלאות - `createTables.sql`](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/createTables.sql)**  
📜 **[הכנסת נתונים ראשונית - `insertTables.sql`](Phase1/scripts/insertTables.sql)**  
📜 **[מחיקת טבלאות - `dropTables.sql`](Phase1/scripts/dropTables.sql)**  
📜 **[שליפת כל הנתונים - `selectAll.sql`](Phase1/scripts/selectAll.sql)**  

---

### **אכלוס נתונים בשלוש שיטות**  

#### **שיטה 1: שימוש ב-Mockaroo (לטבלאות ללא FK)**
נוצרו קובצי CSV עם נתונים לטבלאות הבאות:  
📌 **[סוגי התנדבות (`VolunteerType.csv`)](Phase1/mockData/VolunteerType.csv)**  
📌 **[משמרות (`Shift.csv`)](Phase1/mockData/Shift.csv)**  
📌 **[הכשרות (`Training.csv`)](Phase1/mockData/Training.csv)**  

---

#### **שיטה 2: שימוש ב-Excel (לטבלאות עם FK, אך בעלות סדר מסוים)**
📌 **[מתנדבים (`Volunteer.csv`)](Phase1/excelData/Volunteer.csv)**  
📌 **[מנהלים (`Manager.csv`)](Phase1/excelData/Manager.csv)**  
📌 **[פרויקטים (`Project.csv`)](Phase1/excelData/Project.csv)**  

> ⚠️ הוכנסו מפתחות זרים בצורה עקבית בהתאם לטבלאות שנוצרו ב-Mockaroo.

---

#### **שיטה 3: שימוש ב-Python (לטבלאות עם קשרים מורכבים)**
📌 **[קשרים בין מתנדבים למשמרות (`WorksIn.csv`)](Phase1/pythonData/WorksIn.csv)**  
📌 **[שיבוץ מתנדבים לפרויקטים (`AssignedTo.csv`)](Phase1/pythonData/AssignedTo.csv)**  
📌 **[מעקב הכשרות (`Trained.csv`)](Phase1/pythonData/Trained.csv)**  

> 🔧 **סקריפט Python נכתב כדי לייצר קשרים אמינים בין ה-FK וה-PK בטבלאות השונות.**

---

### **גיבוי ושחזור**  
📌 **[תיקיית גיבויים](Phase1/Backup)**  

✅ גובו כל הנתונים ונבדק שחזור על מחשב אחר.  

---

## **שלב ב': אינטגרציה ובדיקות**  
(יושלם בהמשך)  

---
