
שלב 4:

DSD של האגף החדש

![image](https://github.com/user-attachments/assets/296ed4c5-1449-4a40-840e-b39ad4a88418)



ERD אגף חדש

![image](https://github.com/user-attachments/assets/1306d6c6-8545-475f-a386-4ed17e6af803)


יצירת טבלאות ושינויי סכמה:


```SQL

---------------------ORDERS<->dAYCARE----------------
create table ORDERS
(
  orderid      INTEGER not null, -- מזהה ההזמנה (Primary Key)
  ticketamount INTEGER not null, -- כמות הכרטיסים
  ticketcost   INTEGER not null, -- עלות הכרטיס
  orderdate    DATE not null, -- תאריך ההזמנה
  eventid      INTEGER not null, -- מזהה האירוע (Foreign Key)
  d_id         INTEGER -- מזהה הגן
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
```

תיאור: פקודת SQL זו יוצרת טבלה בשם ORDERS המאגדת מידע על הזמנות. הטבלה כוללת מזהה הזמנה, כמות כרטיסים, עלות כרטיס, תאריך ההזמנה, מזהה האירוע, ומזהה גן (אם קיים). הגדרת הטבלה כוללת פרמטרים כמו אחוז חופש וזיכרון התחלתי.

הוספת מפתח ראשי בטבלת ORDERS:

```SQL
-- Create/Recreate primary, unique and foreign key constraints 
alter table ORDERS
  add primary key (ORDERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

```
תיאור: פקודה זו מוסיפה מפתח ראשי לטבלה ORDERS על עמודת ORDERID. המפתח הראשי מבטיח שלכל רשומה בטבלה יהיה מזהה ייחודי.

הוספת מפתח זר בטבלת ORDERS:
```SQL

alter table ORDERS
  add foreign key (EVENTID)
  references EVENT (EVENTID);
```  
תיאור: פקודה זו מוסיפה מפתח זר לטבלה ORDERS שמצביע על EVENTID בטבלה EVENT. זה מבטיח שכל ערך בעמודת EVENTID בטבלה ORDERS ימצא גם בטבלה EVENT.

הוספת עמודת locationId בטבלת Daycare:

```SQL
-------------------------------DAYCARE<->LOCATIONS---------------------------------------------------

ALTER TABLE daycare ADD locationId int;
```

תיאור: פקודה זו מוסיפה עמודה חדשה בשם locationId לטבלה Daycare שתשמש לאחסון מזהה המיקום.

עדכון ערכי locationId בטבלת Daycare:

```SQL

UPDATE Daycare d
SET d.locationId = (
  SELECT c.locationId
  FROM Catering c
  WHERE c.C_ID = d.C_ID
)
WHERE EXISTS (
  SELECT 1
  FROM Catering c
  WHERE c.C_ID = d.C_ID
);

```

תיאור: פקודה זו מעדכנת את עמודת locationId בטבלת Daycare לפי הערכים מעמודת locationId בטבלת Catering, בהתבסס על התאמה בין C_ID בשתי הטבלאות.

הסרת עמודת Location בטבלת Daycare:

```SQL

ALTER TABLE daycare DROP COLUMN Location;

```

תיאור: פקודה זו מסירה את עמודת Location מהטבלה Daycare לאחר שהנתונים הועברו לעמודת locationId.

הוספת מפתח זר בטבלת Daycare:

```SQL

ALTER TABLE daycare
ADD CONSTRAINT FK_daycare_Location FOREIGN KEY (locationId) REFERENCES Locations(locationId);

```

תיאור: פקודה זו מוסיפה מפתח זר לטבלה Daycare המצביע על locationId בטבלת Locations. זה מבטיח שכל ערך בעמודת locationId בטבלה Daycare ימצא גם בטבלה Locations.

הוספת עמודת locationId לטבלת Catering:

```SQL


-------------------------------CATERING<->LOCATIONS-------------------------------------------------
ALTER TABLE Catering ADD locationId;

```

תיאור: פקודה זו מוסיפה עמודה חדשה בשם locationId לטבלה Catering.

הסרת עמודת Location בטבלת Catering:

```SQL

ALTER TABLE Catering DROP COLUMN Location;

```

תיאור: פקודה זו מסירה את עמודת Location מהטבלה Catering לאחר שהנתונים הועברו לעמודת locationId.

הוספת מפתח זר בטבלת Catering:
```SQL

ALTER TABLE Catering
ADD CONSTRAINT FK_Catering_Location FOREIGN KEY (locationId) REFERENCES Locations(locationId);

```

תיאור: פקודה זו מוסיפה מפתח זר לטבלה Catering המצביע על locationId בטבלת Locations.

הוספת זיהוי מיקום למעונות יום וקייטרינג:

סיבה: עמודת המיקום המקורית הן בטבלאות מעונות יום והן בטבלאות קייטרינג הכילה נתוני מחרוזת המייצגים שמות מיקומים. כדי להבטיח עקביות וליצור קשר עם טבלת המיקומים, נוסף עמודה שלם חדשה של locationId. עמודה זו תשמור את המזהה הייחודי למיקומים, מה שיקל על הניהול והקישור של מיקומים בין טבלאות.
עדכון זיהוי מיקום במעונות יום וקייטרינג:

סיבה: ה-locationId במעון עודכן על סמך ה-locationId מטבלת הקייטרינג. זה נעשה כדי להבטיח שטבלת מעונות היום מתייחסת בצורה נכונה לטבלת המיקומים באמצעות locationId. שלב זה מיישר את טבלת מעונות היום עם העמודה ה-locationId החדשה שנוספה, ומשקפת את המיקום בפועל שבו נעשה שימוש.
ביטול עמודות המיקום הישנות:

סיבה: לאחר המעבר ל-locationId, עמודות המיקום הישנות נשמטו. זה עוזר לנקות את הסכימה על ידי הסרת עמודות מיותרות שלא היו נחוצות עוד לאחר יצירת הקשר החדש עם מיקומים.
אילוצי מפתח זרים:

סיבה: אילוצי מפתח זרים נוספו לטבלאות מעונות היום והקייטרינג כדי לאכוף יושרה התייחסותית. אילוצים אלה מבטיחים שה-locationId בשתי הטבלאות מפנה בצורה נכונה לרשומה קיימת בטבלת המיקומים, מונעת הזנת נתונים לא חוקיים ושומרת על עקביות הנתונים.

DSD לאחר אינטגרציה:

![DSD_Joint](https://github.com/user-attachments/assets/07039775-601a-4b77-979e-9eaf6326a172)


ERD לאחר אינטגרציה:

![image](https://github.com/user-attachments/assets/7710ec17-f5ca-4c54-b7ea-d740f2be3ec0)


מבט ראשון: פרטי מורים וגני ילדים

יצירת המבט View_Teachers_Daycare_Details:


```SQL

CREATE VIEW View_Teachers_Daycare_Details AS
SELECT 
    t.Teacher_Name,
    t.Salary,
    d.Daycare_Name,
    COUNT(r.Child_ID) AS Number_of_Children,
    c.Catering_Name
FROM 
    Teacher t
JOIN 
    Daycare d ON t.D_ID = d.D_ID
LEFT JOIN 
    Registration r ON d.D_ID = r.D_ID
JOIN 
    Catering c ON d.C_ID = c.C_ID
GROUP BY 
    t.Teacher_Name, t.Salary, d.Daycare_Name, c.Catering_Name;


```

תיאור: פקודה זו יוצרת מבט (view) בשם View_Teachers_Daycare_Details
המאגד מידע על מורים, גני ילדים, מספר הילדים בכל גן, ושם הקייטרינג הנלווה לכל גן. 
המבט משתמש בחיבור בין הטבלאות Teacher, Daycare, Registration, ו-Catering 
ומבצע קיבוץ של הנתונים לפי שם המורה, שכרו, שם גן הילדים, ושם הקייטרינג.

שאילתות על מבט ראשון:

רשימת מורים עם שכר מעל הממוצע:

```SQL

SELECT 
    Teacher_Name,
    Salary,
    Daycare_Name
FROM 
    View_Teachers_Daycare_Details
WHERE 
    Salary > (SELECT AVG(Salary) FROM View_Teachers_Daycare_Details);

```

תיאור: פקודה זו מחפשת את כל המורים שיש להם שכר גבוה מהממוצע של כל המורים במבט View_Teachers_Daycare_Details.

מספר הילדים הכולל בכל גן ילדים:

```SQL
SELECT 
    Daycare_Name,
    SUM(Number_of_Children) AS Total_Children
FROM 
    View_Teachers_Daycare_Details
GROUP BY 
    Daycare_Name;
```

תיאור: פקודה זו סוכמת את מספר הילדים בכל גן ילדים במבט View_Teachers_Daycare_Details ומציגה את המספר הכולל עבור כל גן.
מבט שני: פרטי אירועים
יצירת המבט View_Event_Details:

```SQL
CREATE VIEW View_Event_Details AS
SELECT 
    e.eventID,             -- מזהה האירוע מטבלת Event
    e.eventName,           -- שם האירוע מטבלת Event
    e.eventDate,           -- תאריך האירוע מטבלת Event
    e.eventDescribe,       -- תיאור האירוע מטבלת Event
    o.organizerName,       -- שם המארגן מטבלת Organizer
    et.eventType,          -- סוג האירוע מטבלת EventType
    l.locationName,        -- שם המיקום מטבלת Locations
    COUNT(mo.participantID) AS Number_of_Participants  -- ספירת מספר המשתתפים באירוע באמצעות ספירת participantID מטבלת MakeOrder
FROM 
    Event e
JOIN 
    Organizer o ON e.organizerId = o.organizerId
JOIN 
    EventType et ON e.eventTypeId = et.eventTypeId
JOIN 
    Locations l ON e.locationId = l.locationId
LEFT JOIN 
    Orders ord ON e.eventID = ord.eventID
LEFT JOIN 
    MakeOrder mo ON ord.orderID = mo.orderID
GROUP BY 
    e.eventID, e.eventName, e.eventDate, e.eventDescribe, o.organizerName, et.eventType, l.locationName;
```

תיאור: פקודה זו יוצרת מבט בשם View_Event_Details 
המאגד מידע על אירועים, כולל מזהה האירוע, שם האירוע, תאריך האירוע, תיאור האירוע, שם המארגן, סוג האירוע, שם המיקום, ומספר המשתתפים בכל אירוע. 
המבט משתמש בחיבורים בין הטבלאות Event, Organizer, EventType, Locations, Orders, ו-MakeOrder.

שאילתות על מבט שני:

רשימת אירועים עם יותר ממספר מסוים של משתתפים:

```SQL
SELECT 
    eventID,
    eventName,
    eventDate,
    eventDescribe,
    organizerName,
    eventType,
    locationName,
    Number_of_Participants
FROM 
    View_Event_Details
WHERE 
    Number_of_Participants > 10;
```

תיאור: פקודה זו מחפשת אירועים שבהם מספר המשתתפים גדול מ-10 במבט View_Event_Details.

אירועים שאורגנו על ידי מארגן מסוים:

```SQL
SELECT 
    eventID,
    eventName,
    eventDate,
    eventDescribe,
    eventType,
    locationName,
    Number_of_Participants
FROM 
    View_Event_Details
WHERE 
    organizerName = 'Organizer Name';

```

תיאור: פקודה זו מחפשת אירועים שאורגנו על ידי מארגן עם שם מסוים במבט View_Event_Details.
