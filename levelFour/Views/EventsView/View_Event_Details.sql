CREATE VIEW View_Event_Details AS
SELECT 
    e.eventID,             -- מזהה האירוע מטבלת Event
    e.eventName,           -- שם האירוע מטבלת Event
    e.eventDate,           -- תאריך האירוע מטבלת Event
    e.eventDescribe,       -- תיאור האירוע מטבלת Event
    o.organizerName,       -- שם המארגן מטבלת Organizer
    et.eventType,          -- סוג האירוע מטבלת EventType
    l.locationName,        -- שם המיקום מטבלת Locations
    COUNT(mo.participantID) AS Number_of_Participants  -- ספירת מספר המשתתפים באירוע באמצעות ספירת participantID מטבלת MakeOrder; שם השדה הזה יהיה Number_of_Participants
FROM 
    Event e                -- הטבלה הראשית המכילה פרטי אירועים, מקצרים אותה כ e
JOIN 
    Organizer o ON e.organizerId = o.organizerId  -- מצטרף לטבלת Organizer עם טבלת Event על בסיס עמודת organizerId (מזהה המארגן)
JOIN 
    EventType et ON e.eventTypeId = et.eventTypeId  -- מצטרף לטבלת EventType עם טבלת Event על בסיס עמודת eventTypeId (מזהה סוג האירוע)
JOIN 
    Locations l ON e.locationId = l.locationId  -- מצטרף לטבלת Locations עם טבלת Event על בסיס עמודת locationId (מזהה המיקום)
LEFT JOIN 
    Orders ord ON e.eventID = ord.eventID  -- מצטרף שמאלי לטבלת Orders עם טבלת Event על בסיס עמודת eventID; הצטרפות זו מבטיחה שאירועים ללא הזמנות עדיין יופיעו בתוצאה עם ספירה של 0
LEFT JOIN 
    MakeOrder mo ON ord.orderID = mo.orderID  -- מצטרף שמאלי לטבלת MakeOrder עם טבלת Orders על בסיס עמודת orderID; הצטרפות זו מבטיחה שספירת המשתתפים תכלול גם אירועים ללא משתתפים רשומים
GROUP BY 
    e.eventID, e.eventName, e.eventDate, e.eventDescribe, o.organizerName, et.eventType, l.locationName;  -- מבטיח שהנתונים יקובצו לפי מזהה האירוע, שם האירוע, תאריך האירוע, תיאור האירוע, שם המארגן, סוג האירוע ושם המיקום
