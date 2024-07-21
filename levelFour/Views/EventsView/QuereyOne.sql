--------List events that have more than a specified number of participants.
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
    Number_of_Participants > 10;  -- Replace 10 with the desired number of participants.
