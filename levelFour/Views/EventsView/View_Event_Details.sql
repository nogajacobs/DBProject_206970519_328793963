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
