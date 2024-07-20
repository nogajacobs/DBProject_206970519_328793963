6. פקודות ליצירת מבטים ושאילתות על המבטים בקובץ Views.sql
View 1: View_Event_Details
תיאור המבט:


קוד SQL ליצירת המבט:
```SQL
-- שאילתה זו משמשת לשליפת פרטי אירועים מאחת התצוגות
-- עבור אירועים המאורגנים על ידי אדם בשם 'John Doe'.

SELECT
  eventID, -- מזהה האירוע
  eventName, -- שם האירוע
  eventDate, -- תאריך האירוע
  eventDescribe, -- תיאור האירוע
  eventType, -- סוג האירוע
  locationName, -- שם המקום שבו מתקיים האירוע
  Number_of_Participants -- מספר המשתתפים באירוע
FROM
  View_Event_Details -- תצוגת פרטי האירועים
WHERE
  organizerName = 'John Doe'; -- סינון לפי שם המארגן, רק אירועים שאורגנו על ידי 'John Doe'

```
תיאור השאילתה:
השאילתה מחזירה את פרטי כל האירועים המאורגנים על ידי 'John Doe'. השאילתה כוללת את מזהה האירוע, שם האירוע, תאריך האירוע, תיאור האירוע, סוג האירוע, שם המקום שבו מתקיים האירוע, ומספר המשתתפים באירוע.

```SQL
SELECT
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
  Number_of_Participants > 4;
```

תיאור השאילתה:
השאילתה מחזירה את פרטי כל האירועים שבהם מספר המשתתפים הוא יותר מ-4. השאילתה כוללת את שם האירוע, תאריך האירוע, תיאור האירוע, שם המארגן, סוג האירוע, שם המקום שבו מתקיים האירוע, ומספר המשתתפים.
