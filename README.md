

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

## **שלב ב': אינטגרציה ובדיקות**  
(יושלם בהמשך)  

---
