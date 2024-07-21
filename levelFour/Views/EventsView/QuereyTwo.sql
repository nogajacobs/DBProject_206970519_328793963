------------Find events organized by a specific organizer.


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
    organizerName = 'Organizer Name';  -- Replace 'Organizer Name' with the actual organizer name.
