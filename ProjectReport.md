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
Works in(Teacher, Daycare) 
יחיד לרבים, כיון שגננת יכולה ללמד רק בצהרון אחד, ואילו כמה גננות יכולות ללמד באותה צהרון.
Uses (Daycare, Catering)
יחיד לרבים, כיון שצהרון משתמש רק בקייטרינג אחד, ואילו קיטרינג אחד יכול לעבוד בשביל כמה צהרונים.
Belongs to (Daycare, Registration)
יחיד לרבים, כיון שכל רישום שייך לצהרון אחד, אבל צהרון יכול לקבל כמה רישומים
Registers (Daycare, Catering)
יחיד ליחיד, כיון שבכל רישום יש ילד אחד, וכל ילד יכול להרשם פעם אחת
Daycare Activities(Daycare, Activities)
רבים לרבים, כיון שצהרון משתמש בכמה פעילויות, ופעילות יכול להתקיים בכמה צהרונים


תרשים ERD:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/328daa84-77e5-4027-9e70-0d68f6265a23)
תרשים DSD:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/0361df78-f53b-4b6b-96f4-5e2e52ff3c8f)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/72e5ac58-072b-4dcf-8e47-8ca0fe3debb0)

יצירת הטבלאות:
```SQL
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
```
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/72c34823-f73a-47f0-bab0-37fcbc5f5a16)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/66a47412-54f7-45ad-a8ff-43684ddc0ca7)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/ca6bba04-7348-4b05-8d1b-3e6cab8a3306)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/a429507a-2cb4-4271-8a32-12b88d81ea91)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/62b32e25-623a-4b20-99ac-b59ebfe15dff)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/460d0ea1-5706-417c-924f-fdd99a287f91)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/a542ed5d-2cdd-4ce2-ab61-6b298ff2ac62)

הכנסה באמצעות SQL:
```SQL
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
```

insert by excel:
insert to Child:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/a7f575cf-e51e-490b-a97b-7c7bf610cbe7)

insert to Activities:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/819d8267-8e8b-44a6-ad81-317969b22303)


insert to Daycare Activities:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/56af1536-3871-4edf-a232-db38c34da02e)

insert to catering:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/fa11dcc9-23f3-40bd-8a89-6c5ac673f0b6)

insert to Registration:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/95ffeb9c-f2ad-4b53-97f5-645cb4b0fdce)

insert by TXT:
insert to Child:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/7c913cee-7762-48fe-8abe-4521c6f2f5a6)

insert to Daycare:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/279ede42-e75d-4bb7-8935-0b3da84c4d2e)

insert to Activities:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/e720e249-ca2b-48ba-a95d-1ef97129c552)

insert to Daycare Activities:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/63915a98-2b79-499d-83a0-a022fef1189c)

insert to Catering:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2e76cb75-dc43-495a-b1c9-5814bef92248)

insert to Registration:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/9f74152e-485e-4f22-abc1-012087b480a0)

insert to Teacher:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/ce2e3c93-3c1f-4cc0-bf4e-8843bf260173)

insert by Data Generator:
insert to Child:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/8094c324-edc4-4cfd-89b2-9b691a278c9f)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/82d018b7-7eaf-4a61-80b7-c9dacb5793c3)

insert to Daycare Activities:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/cb0fe24b-3659-402e-a44e-145bf1265bd9)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/747e40f8-5dbb-4186-9e93-dd5dcce7ab96)

insert by Data Generator:
insert to Child:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/a99e32d3-93c7-4a89-b123-0e9b5166a5f9)

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/5b2eae51-4e66-4725-a990-7a53e76bd07a)

insert to Daycare Activities
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/531a34e3-b716-446f-9574-847128d48238)


פה שמנו לב שיש טעות בקשר בין Catering, Daycare.
אז ביצענו: drop table catering

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/0d5cf5a7-6671-4f16-be5a-54c756a27850)

יצרנו מחדש את הטבלה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/dd914cde-a430-4ee5-b20a-0ddd3232475a)

עדכנו את הטבלה של Daycare:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/7f98fdfd-419a-4024-8996-d36f3c115860)

והכנסנו נתונים חדשים:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/0d1c94c7-8982-4019-bddf-9194daa50b9e)

הכנסנו עוד נתונים ע"י TXT לטבלה Daycare: 
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/cda109e3-225c-48b0-864c-4d7d5ea7eb11)


Backup:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/4d83d949-09e1-4a11-91b7-eb7c83c9942d)

Drop script:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/55cda756-7c2f-4964-93dc-c65e1e373a2f)


Restore:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/4523d210-858d-4426-b23b-81ef22171969)

part b:
שאילתות:
שאילתא Select 1:
```SQL
SELECT d.Daycare_Name, d.d_id,
       EXTRACT(YEAR FROM r.Registration_Date) AS Year, 
       COUNT(r.Registration_id) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
GROUP BY d.Daycare_Name, EXTRACT(YEAR FROM r.Registration_Date),d.d_id
ORDER BY Year,d.Daycare_Name;
```

השאילתה מוציאה את שמות הגנים, מזהי הגנים, שנת הרישום, ומספר הרישומים הכולל עבור כל גן בשנה מסוימת, ממסד הנתונים. היא מציגה את התוצאות בסדר כרונולוגי לפי שנה ולאחר מכן לפי שם הגן.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/3b3355cb-1740-442f-bf8a-ff7ffd723d96)


שאילתא Select 2:
```SQL
SELECT  c.Child_ID, c.Child_Name,  d.Daycare_Name,  d.Location ,  d.Sector, 
        t.Teacher_Name, ct.Catering_Name, ct.Kashrut
FROM Child c  JOIN Registration r ON c.Child_ID = r.Child_ID
JOIN Daycare d ON r.D_ID = d.D_ID JOIN Teacher t ON d.D_ID = t.D_ID
LEFT JOIN Catering ct ON d.C_ID = ct.C_ID
WHERE d.Sector = 'DATI' or d.Sector='CHAREDI' AND d.D_ID
 IN ( SELECT D_ID
      FROM Daycare
      WHERE Sector = 'DATI' or d.Sector= 'CHARERDI');
```
השאילתה מוציאה פרטים על ילדים, גנים, מורים ושירותי הסעדה עבור גנים בסקטור דתי או חרדי. היא עושה זאת על ידי ביצוע צירוף של מספר טבלאות עם סינון על פי תנאי הסקטור בגנים.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/f45f1523-f85a-447f-ae0b-cb0f82601c5d)


שאילתא Select 3:
```SQL
Select ct.Catering_name,
(  
    Select Count( distinct r1.child_id)
    from Registration r1
    Join daycare d1 on r1.d_id=d1.d_id
    where d1.c_id=ct.c_id
          and Extract (year from r1.registration_date)=Extract(year from current_date)
 ) As Number_of_children
 from Catering ct
 order by  Number_of_children desc;
```
השאילתה מוציאה את שמות שירותי ההסעדה ומספר הילדים הייחודי שנרשמו לגנים שמשתמשים בשירות ההסעדה הנוכחי בשנה הנוכחית. התוצאות ממוינות לפי מספר הילדים בסדר יורד.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2ea0dd28-8819-4298-a4b2-1776cb761bb6)

שאילתא Select 4:

```SQL
SELECT t.Teacher_Name, d.Daycare_Name,(SELECT COUNT(r2.Child_ID)
        FROM Registration r2
        WHERE r2.D_ID = d.D_ID
          AND EXTRACT(YEAR FROM r2.registration_date) = EXTRACT(YEAR FROM current_date)  ) AS Number_of_Children
FROM Teacher t JOIN Daycare d ON t.D_ID = d.D_ID
WHERE d.D_ID IN ( SELECT r.D_ID
                  FROM Registration r
                   WHERE EXTRACT(YEAR FROM r.registration_date) = EXTRACT(YEAR FROM current_date)
                   GROUP BY r.D_ID
                    HAVING COUNT(r.Child_ID) > ( SELECT AVG(Child_Count)
                    FROM (SELECT COUNT(r2.Child_ID) AS Child_Count
                          FROM Registration r2
                          WHERE EXTRACT(YEAR FROM r2.registration_date) = EXTRACT(YEAR FROM current_date)
                          GROUP BY r2.D_ID   )  ));
```
השאילתה מוציאה את שמות המורים ושמות הגנים יחד עם מספר הילדים שנרשמו בשנה הנוכחית עבור גנים שיש להם יותר ממספר הילדים הממוצע הנרשם לגנים בשנה הנוכחית. היא עושה זאת על ידי ביצוע צירוף של טבלת המורים וטבלת הגנים עם סינון על פי תנאי הממוצע בגנים.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/e1fc270c-c1d0-487a-889d-827c66054ac1)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/672e118b-7e71-4b41-8cd7-e89af7a07681)

שאילתא update 1:
```SQL
UPDATE Registration
SET Price = Price * 1.10
WHERE D_ID = (
  SELECT D_ID
  FROM Daycare 
  WHERE D_id = 5;
  and Extract (year from registration_date)='2024';
```
השאילתה מבצעת עדכון לטבלת Registration על מנת להעלות ב-10% את המחירים (Price) של רישומים בגנים שהם בעלי מזהה (D_ID) של 5 ובנוסף, התאריך של הרישום הוא בשנת 2024.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2c8b3b64-ad1a-4cc8-99a0-965632f86d86)

לפני עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2c513c6a-7597-4516-ad20-169de08c2bbc)

אחרי עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/4bfa4168-f02c-49c6-a828-f5d0c44175d3)



שאילתא update 2:
```SQL
update registration r
set r.price = r.price * 1.05
WHERE EXTRACT(YEAR FROM r.registration_date) = 2024
AND r.D_ID IN (
    SELECT da.D_ID
    FROM Daycare_Activities da
    GROUP BY da.D_ID
    HAVING COUNT(da.Operator_Name) >= 2
```
השאילתה מבצעת עדכון לטבלת Registration על מנת להעלות ב-5% את המחירים (Price) של רישומים בגנים שהם תחת פעילויות בהם יש לפחות שני אופרטורים (Operator_Name), ובנוסף, התאריך של הרישום הוא בשנת 2024.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/6e6b9f60-7ad2-41b9-a5c8-9b81aed64137)

לפני עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/60d3e980-969c-4199-a0b1-33546e5084ff)

אחרי עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/1e1fca33-d5e3-431b-ad96-97533d30cde3)

שאילתא delete 1:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/67fa1a4c-5493-41e2-8eb1-b03599e1fab5)

השאילתה מבצעת מחיקת רישומים מטבלת Registration בהתאם לתנאים הבאים:

מחיקת רישומים שהתאריך שלהם (registration_date) קטן משנת 2022.
הרישום שיושמץ לא יכיל את הילדים שלא משתתפים בפעילויות של הגן על פי הקריטריונים הבאים:
ילדים שלהם היה הרשמה (Registration) לאותו גן (D_ID) שבו יש פעילות (Daycare_Activities).
בגישה קצרה, השאילתה מבצעת מחיקת רישומים ישנים של ילדים שלא משתתפים בפעילויות של הגן משנת 2022 והלאה.

לפני מחיקה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/ce4bcb9e-b0e8-4119-bb60-a10c44b7c288)

אחרי מחיקה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/53cd22cb-7bc5-4cf9-bcc5-97bbd9edab60)

שאילתא delete 2:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/e71d53d2-f1e9-429b-b2be-c7670ebe99a7)

השאילתה מבצעת מחיקת רישומים מטבלת Registration בהתאם לתנאים הבאים:

מחיקת רישומים שמקיימים את התנאים הבאים:
המזהה של הגן (D_ID) והמזהה של הילד (Child_ID) שמופיעים בתוך התוצאה של השאילתה המקוננת:
בשאילתה הפנימית, מבוצעת חישוב של כמות הרישומים לכל גן (D_ID).
הרישומים שמקיימים את התנאי שיש לפחות 4 ילדים בכל גן (D_ID) נמחקים מהטבלה.
בגישה קצרה, השאילתה מבצעת מחיקת רישומים לגנים שבהם יש פחות מ-4 ילדים רשומים.
לפני מחיקה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/882d0c84-15ac-40eb-ae46-362e74ebfef7)

אחרי המחיקה

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/5bc8c4cb-c45e-4b3a-9d1e-e9820d857234)

שאילתות עם פרמטרים:

שאילתא 1:
```SQL
SELECT d.Daycare_Name, d.d_id,
    EXTRACT(YEAR FROM r.Registration_Date) AS Year,
    COUNT(r.Registration_id) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
WHERE d.daycare_name = '&<name = "daycare_name" list = "select daycare_Name from daycare">'
      AND r.registration_date  between &<name= "date_from" type= "date" hint="Use dd/m/yyyy format">
      and &<name= "date_to" type= "date"  hint="Use dd/m/yyyy format">
GROUP BY d.Daycare_Name, d.d_id, EXTRACT(YEAR FROM r.Registration_Date);
```

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/14f0b07e-5843-457b-9bce-7ef0e6b1c079)

שאילתא 2:
```SQL
SELECT d.Daycare_Name,d.sector,  d.Location,  cat.Catering_Name, cat.Kashrut
FROM  Daycare d
JOIN Catering cat ON d.C_ID = cat.C_ID
WHERE 
    d.Location ='&<name="location" list="select location from daycare">'
    AND cat.Kashrut = '&<name="kashrut" list="select kashrut  from catering">'
    AND d.Sector = '&<name="sector" list="select sector  from daycare">';
```

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/0db6ec11-3381-40d9-9bc7-e618542aaed5)

שאילתא 3:

```SQL
SELECT t.Teacher_Name, ch.Child_Name, ch.Child_DOB, d.Daycare_Name
FROM Teacher t
JOIN Daycare d ON t.D_ID = d.D_ID
JOIN Registration r ON d.D_ID = r.D_ID
JOIN Child ch ON r.Child_ID = ch.Child_ID
WHERE 
    t.Teacher_Name = '&<name="teachers name" list="select teacher_name  from teacher">'
    and r.registration_date between &<name="from_date" type="date">
    and &<name="to_date" type="date">
ORDER BY   ch.Child_Name;
```

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/5b0036e4-ef35-4942-b391-f6dbd7e62502)

שאילתא 4:

```SQL
SELECT  d.Daycare_Name,
    d.Location,
    a.ACTIVITY_TYPE ,
    da.Operator_Name
FROM Daycare d
JOIN  Daycare_Activities da ON d.D_ID = da.D_ID
JOIN  Activities a ON da.Operator_Name = a.Operator_Name
WHERE  d.Location ='&<name="location" list="select location from daycare">'
    AND a.ACTIVITY_TYPE  = '&<name="activity_type" list="select activity_type  from Activities">'
```
    
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/59abb4ce-6d0c-4c73-b240-ea855becfb65)

אילוצים:

אילוץ 1:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/da744c8f-7ce7-4f47-a6cb-3b575265beb9)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/383161c2-d4c5-457e-92d3-a17e0c837e13)


אילוץ 2:


![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/bf8428cd-5ef4-4121-b5ef-7a6023f5b999)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/9fc6e7b6-d654-4ef2-95c0-d8c213456149)

אילוץ 3:


![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/50518a70-35af-42a7-88b7-ba945b5a3c91)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/4f27df40-53f3-4b58-b5b4-cab21bf1ae3c)


פונקציה 1:
פונקציה זו מחשבת את המחיר החדש לרישום בהתאם להנחה שניתנה ומחזירה את המחיר החדש:
```	SQL
CREATE OR REPLACE FUNCTION calculate_new_price(
    p_registration_id INT,
    P_discount Float
) RETURN VARCHAR2 IS
    v_old_price Float;
    v_new_price Float;

    -- Retrieve the old price based on the registration ID
    SELECT Price INTO v_old_price FROM Registration WHERE Registration_ID = p_registration_id;
    
    -- Calculate the new price as half of the old price
    v_new_price := v_old_price*p_discount;
    
    -- Return both old and new prices as a formatted string
    RETURN v_new_price;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Registration ID not found');
END calculate_new_price;
```
לפני ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/cf50bf54-21cb-4c63-855e-2355d818d3f6)
אחרי ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/7798490a-14df-4af0-84c2-a3e259242063)

זריקת חריגה:

![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/61f9bfc2-45c4-4cea-8e82-7bbf9699cb22)


פונקציה 2:
יצא חוק חדש ששכר הגננות יהיה אישי לכל לפי מספר השעות, כמות נסיון, וכמות ילדים שהיא מלמדת. 
 פונקציה זו מחשבת את השכר הכולל של מורה בגן הילדים בהתאם למספר הילדים שנרשמים אליו. השכר הכולל נקבע על פי שעות העבודה השבועיות והשעתיות של המורה, תוך כדי ניתוח של רמת הנסיון שלו. תוספת נוספת מחושבת עבור ילדים נוספים מעבר למספר שלושה.
 ```SQL

CREATE OR REPLACE FUNCTION calculate_teacher_salary(
    p_teacher_id INT
) RETURN NUMBER IS
    v_hourly_wage NUMBER;
    v_num_children INT := 0;
    v_extra_bonus NUMBER := 0;
    v_total_salary NUMBER;
    v_seniority VARCHAR2(20);
    v_daycare_id INT;
    v_opening_hours Date;
    v_closing_hours Date;
    v_hours_per_week Number;
    v_hours_per_day Number;

    CURSOR c_children IS
        SELECT COUNT(Child_ID) AS child_count
        FROM Registration
        WHERE D_ID = v_daycare_id;
    child_count_rec c_children%ROWTYPE;

BEGIN
    -- Get the teacher's seniority and daycare ID
    SELECT t.Seniority, t.D_ID, d.open_time, d.close_time
    INTO v_seniority, v_daycare_id, v_opening_hours, v_closing_hours
    FROM Teacher t
    join Daycare d On t.D_id=d.d_id
    WHERE t.T_ID = p_teacher_id;

    -- Determine the hourly wage based on seniority
    CASE v_seniority
        WHEN 'Novice' THEN v_hourly_wage := 35;
        WHEN 'Junior' THEN v_hourly_wage := 40;
        WHEN 'Intermediate' THEN v_hourly_wage := 45;
        WHEN 'Experienced' THEN v_hourly_wage := 50;
        WHEN 'Senior' THEN v_hourly_wage := 55;
        ELSE RAISE_APPLICATION_ERROR(-20001, 'Invalid seniority level');

    END CASE;

--calculate hours worked per day and per week
    v_hours_per_day:=TO_NUMBER(TO_CHAR( v_closing_hours, 'HH24'))-TO_NUMBER(TO_CHAR( v_opening_hours, 'HH24'));
    v_hours_per_week:=v_hours_per_day*5;
    
    -- Use cursor to count the number of children in the teacher's daycare
    OPEN c_children;
    FETCH c_children INTO child_count_rec;
    CLOSE c_children;

    v_num_children := child_count_rec.child_count;

    -- Calculate the bonus for extra children (if more than 3)
    IF v_num_children > 3 THEN
        v_extra_bonus := (v_num_children - 3) * 3 * v_hours_per_week;
    ELSE
        v_extra_bonus := 0;
    END IF;

    -- Calculate the total salary
    v_total_salary := (v_hourly_wage * v_hours_per_week*4) + v_extra_bonus;

    RETURN v_total_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'No children found for the teacher''s daycare');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);

END;


```
תוצאת ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/15c62ff9-10a7-45da-8d77-2802a1312e26)
זריקת חריגה:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/69aa12fc-ff2f-4cc6-a802-a9891db28231)

פונקציה 3:
פונקציה זו מחזירה את המיקום של גן הילדים בהתאם למספר הזיהוי שלו.
```SQL
CREATE OR REPLACE FUNCTION get_daycare_location(p_daycare_id INT) RETURN VARCHAR2 IS
    v_location VARCHAR2(100);
BEGIN
    SELECT Location INTO v_location FROM Daycare WHERE D_ID = p_daycare_id;
    RETURN v_location;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Daycare not found');
END get_daycare_location;
```
תוצאת ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/45a0e8a6-f2b6-438c-a9e3-80aaee7ac876)

זריקת חריגה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/dffcfbcd-9d6a-4d9b-9c00-658962f7d023)

בשביל 2 מהפרוצדורת היהו צרכיות להוסיף לטבלה של גננת שדה של משכורת:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/ea78ee53-a039-400d-b85f-b0e0caf08719)

פורצודורה 1:
בצהרון play and learn הייתה מקרה של אלימות מהמורה, לכן הערייה העבירה את כל הילדים לצהרון אחר בעיר, ונתנה הנחה של 50% לרישום החדש, ומעדכנת את השכר של הגננת החדשה בהתאם:
```SQL

CREATE OR REPLACE PROCEDURE switch_registered_children(
    p_abusive_tchr_id INT,
    p_new_dc_id INT,
    p_discount FLOAT
) IS
    v_old_dc_id INT;
    v_old_loc VARCHAR2(100);
    v_new_loc VARCHAR2(100);
    v_num_children INT := 0;
    v_cursor SYS_REFCURSOR;
    v_child_id INT;
    v_child_name VARCHAR2(100);
    v_reg_id INT;
    v_old_price NUMBER;
    v_new_price NUMBER;
    v_new_tchr_id INT;
    v_new_salary NUMBER;
    v_next_reg_id INT; -- Variable to hold the next registration ID
    v_old_daycare_name VARCHAR2(100);
    v_new_daycare_name VARCHAR2(100);
BEGIN
    -- Get the old daycare ID and location of the abusive teacher
    BEGIN
        SELECT t.D_ID, d.Daycare_Name INTO v_old_dc_id, v_old_daycare_name
        FROM Teacher t
        JOIN Daycare d ON t.D_ID = d.D_ID
        WHERE t.T_ID = p_abusive_tchr_id;
        
        v_old_loc := get_daycare_location(v_old_dc_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'Teacher or daycare not found');
    END;

    -- Get the location and name of the new daycare
    BEGIN
        v_new_loc := get_daycare_location(p_new_dc_id);
        SELECT Daycare_Name INTO v_new_daycare_name FROM Daycare WHERE D_ID = p_new_dc_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20007, 'New daycare not found');
    END;

    -- Check if the new daycare is in the same location
    IF v_old_loc != v_new_loc THEN
        RAISE_APPLICATION_ERROR(-20001, 'New daycare is not in the same location');
    END IF;

    -- Open a cursor to select all children from the old daycare for the current year
    OPEN v_cursor FOR
        SELECT c.Child_ID, c.Child_Name, r.Registration_ID, r.Price
        FROM Registration r
        JOIN Child c ON r.Child_ID = c.Child_ID
        WHERE r.D_ID = v_old_dc_id
          AND EXTRACT(YEAR FROM r.REGISTRATION_DATE) = EXTRACT(YEAR FROM SYSDATE);

    LOOP
        -- Fetch each child record
        FETCH v_cursor INTO v_child_id, v_child_name, v_reg_id, v_old_price;
        EXIT WHEN v_cursor%NOTFOUND;

        BEGIN
            -- Calculate the new price using the function with discount
            v_new_price := calculate_new_price(v_reg_id, p_discount);
            
            -- Get the next registration ID
            SELECT NVL(MAX(Registration_ID), 0) + 1 INTO v_next_reg_id FROM Registration;
            
            -- Insert new registration with the new price
            INSERT INTO Registration (Registration_ID, Price, REGISTRATION_DATE, D_ID, Child_ID)
            VALUES (v_next_reg_id, v_new_price, SYSDATE, p_new_dc_id, v_child_id);

            -- Remove old registration
            DELETE FROM Registration
            WHERE Registration_ID = v_reg_id;

            -- Log the transfer of each child
            DBMS_OUTPUT.PUT_LINE('Child ' || v_child_name || ' transferred from daycare ' || v_old_daycare_name || ' to daycare ' || v_new_daycare_name);

            -- Increment child count for the new daycare
            v_num_children := v_num_children + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error transferring child with ID: ' || v_child_id || ' Error: ' || SQLERRM);
        END;
    END LOOP;

    -- Close the cursor
    CLOSE v_cursor;

    -- Get the ID of a teacher in the new daycare
    SELECT T_ID INTO v_new_tchr_id FROM Teacher WHERE D_ID = p_new_dc_id AND ROWNUM = 1;

    -- Calculate the new salary for the new teacher based on the updated number of children
    v_new_salary := calculate_teacher_salary(v_new_tchr_id);

    -- Update the salary for the new teacher
    UPDATE Teacher
    SET Salary = v_new_salary
    WHERE T_ID = v_new_tchr_id;

    -- Log the transfer and new teacher's salary update
    DBMS_OUTPUT.PUT_LINE('Children transferred from daycare ' || v_old_dc_id || ' to daycare ' || p_new_dc_id);
    DBMS_OUTPUT.PUT_LINE('New teacher ID ' || v_new_tchr_id || ' salary updated to ' || v_new_salary);
END switch_registered_children;
```

פלט הפרוצודורה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/bc79eb8b-2b3d-4941-8c91-27aca877963d)
לפני ריצה - אפשר לראות שהילדים רשומים לצהרון מס 4:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/61276149-cc76-4e73-a473-713b2f191500)

אחרי הריצה ניתן לראות שהם עברו לגן מספר 177:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/6c7d2153-705e-4e2e-8e27-5cdca25c8fe4)



זריקת חריגה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/cc4422d6-0257-4730-8f95-f7e7e5e56a34)

פרוצודורה 2:
העריה העבירה חוק שכל מוסדי החינוך צריכים לדאוג למנות ללא גלוטן עבור הילדים עם ציליאק.
לשם כך הוספנו לטבלאות של ילד  וקיטרינג שדה של ציליאק:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/6410455b-40d9-4ca1-a5fb-97d9e0206c64)
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/a323fb1d-d077-4f03-bea8-9c4e89a16d84)
וכן יצרנו פרוצודורה שעוברת על הילדים ואם הילד ציליאקי מוצא עבורו קייטרינג עם אופציה של ציליאק:
```SQL
CREATE OR REPLACE PROCEDURE match_child_catering AS
BEGIN
    FOR child_rec IN (SELECT * FROM "CHILD" WHERE CELIAC = 'YES') LOOP
        FOR catering_rec IN (SELECT * FROM "CATERING" WHERE CELIAC = 'YES') LOOP
            -- Logic to match child and catering service (example: printing the match)
            DBMS_OUTPUT.PUT_LINE('Child ' || child_rec.CHILD_NAME || ' can be matched with catering ' || catering_rec.CATERING_NAME);
        END LOOP;
    END LOOP;
END match_child_catering;
```

פלט התכנית:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/888d60ec-3f76-4d44-bfde-62520c39431a)


תכנית 1:

תכנית זו מחשבת את הרווח של כל גן הילדים בשנה הנוכחית, על ידי חישוב ההכנסות הכוללות (סכום מחירי הרישום) וחישוב השכר הכולל של כל המורים.
```SQL
DECLARE
    v_total_income NUMBER;
    v_total_salary NUMBER;
BEGIN
    FOR daycare_rec IN (SELECT * FROM Daycare) LOOP
        -- Initialize totals for each daycare
        v_total_income := 0;
        v_total_salary := 0;

        -- Calculate total income (sum of registration prices)
        SELECT NVL(SUM(r.Price), 0)
        INTO v_total_income
        FROM Registration r
        WHERE r.D_ID = daycare_rec.D_ID
          AND EXTRACT(YEAR FROM r.Registation_Date) = EXTRACT(YEAR FROM SYSDATE);

        -- Calculate total salary (sum of all teachers' salaries)
        SELECT NVL(SUM(t.Salary), 0)
        INTO v_total_salary
        FROM Teacher t
        WHERE t.D_ID = daycare_rec.D_ID;

        -- Calculate profit (income - salary)
        DBMS_OUTPUT.PUT_LINE('Daycare ' || daycare_rec.Daycare_Name || ' profit for year ' || EXTRACT(YEAR FROM SYSDATE) ||
                             ': ' || (v_total_income - v_total_salary));
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

```

פלט התכנית:

![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/4f4a8275-19e7-453e-b014-f09f523816e3)

תכנית 2

תכנית זו סופרת את מספר הילדים הסליאקים בכל קייטרינג, על פי מספר הזיהוי שלו.
```




DECLARE
    v_caterer_name VARCHAR2(100);
    v_celiac_kids_count NUMBER;
BEGIN
    FOR caterer_rec IN (SELECT Catering_Name, C_ID FROM Catering) LOOP
        v_celiac_kids_count := 0;

        -- Query to count celiac kids per caterer
        SELECT COUNT(c.Child_ID)
        INTO v_celiac_kids_count
        FROM Child c
        JOIN Registration r ON c.Child_ID = r.Child_ID
        JOIN Daycare d ON r.D_ID = d.D_ID
        WHERE d.C_ID = caterer_rec.C_ID
          AND c.Celiac = 'YES';

        -- Output the count for each caterer
        DBMS_OUTPUT.PUT_LINE('Caterer ' || caterer_rec.Catering_Name || ' has ' || v_celiac_kids_count || ' celiac kids.');
    END LOOP;
END;


```
פלט  התכנית:

![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/3f983f27-24b3-476f-b83b-5507503a4d26)



