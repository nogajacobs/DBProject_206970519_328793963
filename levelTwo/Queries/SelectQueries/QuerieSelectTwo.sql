--2.This query returns detailed information about each child in the 'DATI' sector, 
--including their daycare and the associated catering service.

SELECT 
    c.Child_ID, 
    c.Child_Name, 
    d.Daycare_Name, 
    d.Location , 
    d.Sector, 
    t.Teacher_Name, 
    ct.Catering_Name, 
    ct.Kashrut
FROM Child c
JOIN Registration r ON c.Child_ID = r.Child_ID
JOIN Daycare d ON r.D_ID = d.D_ID
JOIN Teacher t ON d.D_ID = t.D_ID
LEFT JOIN Catering ct ON d.C_ID = ct.C_ID
WHERE d.Sector = 'DATI' AND d.D_ID IN (
    SELECT D_ID
    FROM Daycare
    WHERE Sector = 'DATI'
);
