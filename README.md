

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
📜 [יצירת טבלאות - createTables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/createTables.sql)  
📜 [הכנסת נתונים ראשונית - insertTables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/insertTables.sql)  
📜 [מחיקת טבלאות - dropTables.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/dropTables.sql)  
📜 [שליפת כל הנתונים - selectAll.sql](https://github.com/YafitA/DBProject_6092_6103-/blob/main/Phase%20A/SQLFiles/selectAll.sql) 

---

### **אכלוס נתונים בשלוש שיטות**  



#### **שיטה 1: שימוש ב-[Mockaroo](https://www.mockaroo.com/)**
נוצרו קובצי CSV עם נתונים לטבלאות הבאות:  
📌 **[סוגי התנדבות (`VolunteerType.csv`)](Phase1/mockData/VolunteerType.csv)**  
📌 **[משמרות (`Shift.csv`)](Phase1/mockData/Shift.csv)**  
📌 **[הכשרות (`Training.csv`)](Phase1/mockData/Training.csv)**  
📌 **[עבודה במחלקות (`WorksIn.csv`)](Phase1/mockData/WorksIn.csv)**  

---

#### **שיטה 2: שימוש ב-[GenerateData](https://generatedata.com/)**
📌 **[מתנדבים (`Volunteer.csv`)](Phase1/excelData/Volunteer.csv)**  
📌 **[מנהלים (`Manager.csv`)](Phase1/excelData/Manager.csv)**  
📌 **[פרויקטים (`Project.csv`)](Phase1/excelData/Project.csv)**  



---

#### **שיטה 3: שימוש בקוד Python**
📌 **[קשרים בין מתנדבים למשמרות (`WorksIn.csv`)](Phase1/pythonData/WorksIn.csv)**  
📌 **[שיבוץ מתנדבים לפרויקטים (`AssignedTo.csv`)](Phase1/pythonData/AssignedTo.csv)**  


## **תהליך העבודה**

### 📌 **שלב 1: יצירת הנתונים (שונה לכל שיטה)**

#### **שיטה 1: Mockaroo**
> כך נראה המסך בעת יצירת הנתונים ב-Mockaroo:  
![יצירת נתונים ב-Mockaroo](https://github.com/user-attachments/assets/0eb27539-6192-446f-bd4b-fc9fac418558)

#### **שיטה 2: GenerateData**
> כך נראה המסך בעת יצירת הנתונים ב-GenerateData:  
![יצירת נתונים ב-GenerateData](https://github.com/user-attachments/assets/da904d4b-27ce-4b7d-99d3-4ead3259cdbc)

#### **שיטה 3: Python**
> קובצי ה-Python הופעלו והפיקו את הנתונים הבאים:  
![הרצת קובץ Python](נתיב_לתמונה_בפרויקט)

---

### 📌 **שלב 2: העלאת הנתונים למסד הנתונים**
> כך נראים הנתונים לאחר שהועלו למסד הנתונים:  
![העלאת הנתונים למסד הנתונים](https://github.com/user-attachments/assets/72541cef-719f-49af-8280-9f6446522b26)

---

### 📌 **שלב 3: אימות הנתונים במסד הנתונים**
> כך נראה המסך לאחר שהנתונים אומתו בהצלחה:  
![אימות הנתונים במסד הנתונים](https://github.com/user-attachments/assets/b89e7e89-6da2-4889-a979-59973e221ae0)
---

### **גיבוי ושחזור**  
📌 **[תיקיית גיבויים](Phase1/Backup)**  

✅ גובו כל הנתונים ונבדק שחזור על מחשב אחר.  

---

## **שלב ב': אינטגרציה ובדיקות**  
(יושלם בהמשך)  

---
