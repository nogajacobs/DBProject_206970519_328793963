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

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/72c34823-f73a-47f0-bab0-37fcbc5f5a16)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/66a47412-54f7-45ad-a8ff-43684ddc0ca7)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/ca6bba04-7348-4b05-8d1b-3e6cab8a3306)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/a429507a-2cb4-4271-8a32-12b88d81ea91)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/62b32e25-623a-4b20-99ac-b59ebfe15dff)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/460d0ea1-5706-417c-924f-fdd99a287f91)

![Uploading image.png…]()

הכנסה באמצעות SQL:
insert by SQL:
insert to Child:
insert into Child ( Child_Name, Child_DOB, Child_ID ) values ('Matan Oren', TO_DATE('2020-06-01', 'YYYY-MM-DD'), 11);
insert into Child ( Child_Name, Child_DOB, Child_ID ) values ('Dvir Lavi', TO_DATE('2020-05-01', 'YYYY-MM-DD'), 12);
insert into Child ( Child_Name, Child_DOB, Child_ID ) values ('Ori Cohen', TO_DATE('2020-03-01', 'YYYY-MM-DD'), 13);

insert to Daycare:
insert into Daycare (Open_Time, Close_Time, Location, Daycare_Name, Sector, D_ID ) values ( TO_TIMESTAMP('2024-01-09 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-09 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Jaffa St 99, Jerusalem', 'Happy Kids', 'Charedi', 21); 
insert into Daycare (Open_Time, Close_Time, Location, Daycare_Name, Sector, D_ID ) values ( TO_TIMESTAMP('2024-01-09 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-09 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Hebron Rd 26, Jerusalem', 'Little Star', 'Dati', 22); 
insert into Daycare (Open_Time, Close_Time, Location, Daycare_Name, Sector, D_ID ) values ( TO_TIMESTAMP('2024-01-09 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-09 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'King George St 22, Jerusalem', 'Tiny Tots', 'Dati', 23); 

insert to Activities:
insert into Activities ( Operator_Name, Activities_Type, Contact_Number) values ('TO DO!!', 'Music', '0526377886');  
insert into Activities ( Operator_Name, Activities_Type, Contact_Number) values ('TO DO!!', 'Art', '0526377999'); 
insert into Activities ( Operator_Name, Activities_Type, Contact_Number) values ('TO DO!!', 'Sports', '0526388899'); 

insert to Daycare Activities:
insert into Daycare_Activities ( D_Activities_D_ID, D_Activities_Operator_Name ) values ( 21, TO DO!! );
insert into Daycare_Activities ( D_Activities_D_ID, D_Activities_Operator_Name ) values ( 22, TO DO!! );
insert into Daycare_Activities ( D_Activities_D_ID, D_Activities_Operator_Name ) values ( 23, TO DO!! );

insert to teacher:
insert into Teacher ( T_ID, Teacher_Name, Teacher_DOB, Degree, Teacher_Phone, Seniority, D_ID ) values ( 31, 'Yael Cohen', TO_DATE('2015-06-01', 'YYYY-MM-DD'), 'Bachelor', '0536666555', 'Experienced', 21);
insert into Teacher ( T_ID, Teacher_Name, Teacher_DOB, Degree, Teacher_Phone, Seniority, D_ID ) values ( 32, 'Maya Levi', TO_DATE('2014-06-01', 'YYYY-MM-DD'), 'Master', '0536666556', 'Experienced', 22);
insert into Teacher ( T_ID, Teacher_Name, Teacher_DOB, Degree, Teacher_Phone, Seniority, D_ID ) values ( 33, 'Noa Cohen', TO_DATE('2013-06-01', 'YYYY-MM-DD'), 'Master', '0536666557', 'Experienced', 23);

insert to Catering:
insert into Catering ( Phone_Number, Kashrut, Location, C_ID, Catering_Name, D_ID ) values ( '0545888666', 'Rubin', 'Catering Cohen', 21 );
insert into Catering ( Phone_Number, Kashrut, Location, C_ID, Catering_Name, D_ID ) values ( '0545888667', 'Bet Yosef', 'Catering Kids', 22 );
insert into Catering ( Phone_Number, Kashrut, Location, C_ID, Catering_Name, D_ID ) values ( '0545888668', 'Rubin', 'Healthy Catering', 23 );

insert to Registration:
insert into Registration ( Price, Registration_Date, Registration_ID, Registration_D_ID, Registration_Child_ID ) values ( 500,  TO_DATE('2023-02-01', 'YYYY-MM-DD'), 41, 21, 11);
insert into Registration ( Price, Registration_Date, Registration_ID, Registration_D_ID, Registration_Child_ID ) values ( 500,  TO_DATE('2023-02-01', 'YYYY-MM-DD'), 42, 22, 12);
insert into Registration ( Price, Registration_Date, Registration_ID, Registration_D_ID, Registration_Child_ID ) values ( 500,  TO_DATE('2023-02-01', 'YYYY-MM-DD'), 43, 23, 13);
