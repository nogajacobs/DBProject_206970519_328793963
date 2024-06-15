# DatabaseProject
מיני פרויקט בבסיסי נתונים

שם הארגון: עיריית ירושלים

שם המחלקה: צהרונים

מגישות: 
נגה גיקובס 206970519 orog1234@gmail.com
עדינה אינגבער 328793963 adina.ck.2000@gmail.com


הארגון עיריית ירושלים:

עיריית ירושלים היא גוף השלטון המקומי, במעמד של עירייה, האחראי לניהולה השוטף של העיר ירושלים. 
ככל רשות מקומית, עוסקת עיריית ירושלים בעניינים מוניציפליים מסוג הסדרת שירותי חינוך, תרבות, רווחה, תשתיות, ניקיון, תברואה וכדומה...

מחלקת חינוך וצהרונים:

מנהל חינוך ירושלים (מנח"י) – גוף משותף לעיריית ירושלים ולמשרד החינוך, העוסק בתכנון וניהול מערכת החינוך בעיר.

פירוט הישויות: 

	מחלקת חינוך וצהרונים מטפלת ברישום ילדים לצהרונים, עוסק בענייני מחירים, תאריך הרשמה ותאריכי חופשות. 
Registration (▁(Registation_ID), Price, Date)

	המחלקה מחזיקה רשימה של צהרונים שהיא מתפעלת אשר לכל צהרון יש מיקום, שעות פעילות, שם ומגזר.
Daycare ( ▁(D_ID), OPEN_TIME, CLOSE_TIME, Location, Name, Sector, Seniority)

	החלקה מכילה שירות של פעילויות לכל צהרון כאשר יש לכל פעילות שם מפעיל, סוג ומס' טלפון ליצור קשר.
Activities (▁(A_ID), Type, Contact_Number, Operator_Name)

	המחלקה נעזרת בקייטרינג בשביל ארוחת צהרים לילדים של הצהרון, לכל קייטרינג יש מיקום איש קשר והכשר.
Catering (▁(C_ID), Kashrut, Contact_Number, Name, Location)

	המחלקה מכילה רשימה של ילדים שנמצאים בצהרון לכל ילד יש שם מלא, תאריך לידה ו ID.
Child (▁(Child _ID), Name, D.O.B)

	המחלקה צורכת גננות שיתפעלו את הצהרונים לכל גננת יש שם, תואר, וותק, מס' פלאפון ו ID.
Teacher (▁(T_ID), D_ID, Name, D.O.B, Degree, Phone, Seniority)

פירוט הקשרים: 
TO DO!! 

תרשים ERD:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/328daa84-77e5-4027-9e70-0d68f6265a23)
תרשים DSD:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/0361df78-f53b-4b6b-96f4-5e2e52ff3c8f)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/72e5ac58-072b-4dcf-8e47-8ca0fe3debb0)

יצירת הטבלאות:

CREATE TABLE Child 
(
  Child_ID INT NOT NULL,
  Child_DOB DATE NOT NULL,
  Child_Name VARCHAR2 (100) NOT NULL,
  PRIMARY KEY (Child_ID)
);

CREATE TABLE Daycare
(
  Sector VARCHAR2 (100) NOT NULL,
  Daycare_Name VARCHAR2 (100) NOT NULL,
  Location VARCHAR2 (100) NOT NULL,
  Open_Time TIMESTAMP NOT NULL,
  Close_Time TIMESTAMP NOT NULL,
  D_ID INT NOT NULL,
  PRIMARY KEY (D_ID)
);

CREATE TABLE Catering
(
  Phone_Number VARCHAR2 (20) NOT NULL,
  Kashrut VARCHAR2 (50) NOT NULL,
  Catering_Name VARCHAR2 (100) NOT NULL,
  Location VARCHAR2 (100) NOT NULL,
  C_ID INT NOT NULL,
  D_ID INT NOT NULL,
  PRIMARY KEY (C_ID),
  PRIMARY KEY (D_ID) REFERENCES Daycare (D_ID)
);

CREATE TABLE Activities
(
  Contact_Number VARCHAR2 (20) NOT NULL,
  Activity_Type VARCHAR2 (100) NOT NULL,
  Operator_Name VARCHAR2 (100) NOT NULL,
  RIMARY KEY (Contact_Number),
  UNIQUE (Operator_Name)
);

CREATE TABLE Daycare_Activities
(
  D_ID INT NOT NULL,
  Contact_Number VARCHAR2 (20) NOT NULL,
  RIMARY KEY (D_ID, Contact_Number),
  FOREIGN KEY (D_ID) REFERENCES Daycare (D_ID),
  FOREIGN KEY (Contact_Number) REFERENCES Activities
);

CREATE TABLE Teacher 
(
  T_ID INT NOT NULL,
  Teacher_Name VARCHAR2 (100) NOT NULL,
  Teacher_DOB DATE NOT NULL,
  Degree VARCHAR2 (100) NOT NULL,
  Teacher_Phone VARCHAR2 (20) NOT NULL,
  Seniority VARCHAR2 (50) NOT NULL,
  D_ID INT NOT NULL,
  PRIMARY KEY (T_ID),
  FOREIGN KEY (D_ID) REFERENCES Daycare (D_ID),
);

CREATE TABLE Registration
(
  Price INT NOT NULL,
  Registration_ID INT NOT NULL,
  Registration_Date DATE NOT NULL,
  D_ID INT NOT NULL,
  Child_ID INT NOT NULL,
  PRIMARY KEY (Registration_ID, D_ID),
  FOREIGN KEY (D_ID) REFERENCES Daycare (D_ID),
  FOREIGN KEY (Child_ID) REFERENCES Child (Child_ID)
);

- להוסיף תמונות של CREATE !! TO DO!!

5. להכניס נתונים לחלק מהטבלאות בעזרת אחת השיטות

לשם המטלות הללו עליכן:

לקרוא על הארגון (אגף) שבחרתן ולהבין מה יש שם

לשמוע את 3 הסרטונים הראשונים המופיעים אצלי בשלב הראשון

לעבור על המצגת של משה גולדשטיין שנמצאת אצלי בשלב הראשון ומפרשת את ההבדלים בין המודל של אולמן שלמדנו בהרצאה לבין המודל של התוכנה ERDPlus

What I'm asking for next week:

A. Installing the software we need this semester (oracle, plsqldeveloper git) installation videos are in my model or alternatively decide on remote work, check that you know how to log in, that it works and manage to remotely connect to the oracle server.

B. Creating a Google Docs/README document that will be the basis of your report.

The document should be for next week

1. A half page description of the organization you have chosen

2. On the next page you will enter the ERD of the organization after you have created it with the help of the ERDPlus software

3 Produce DSD of the organization

4. Produce a script to create the tables

5. Insert data into some of the tables using one of the methods



For these tasks you have to:



Read about the organization (department) you have chosen and understand what is there

Listen to the first 3 videos that appear in my first step

Go through Moshe Goldstein's presentation that I have in the first stage and explains the differences between the Ullman model we learned in the lecture and the model of the ERDPlus software

Questions can be contacted by email

milston@g.jct.ac.il
