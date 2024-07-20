-- This query returns detailed information about each child in the 'DATI' sector,
-- including their daycare and the associated catering service.

-- Select the child ID, child name, daycare name, location, sector, teacher name, catering name, and kashrut level
SELECT 
    c.Child_ID, 
    c.Child_Name, 
    d.Daycare_Name, 
    d.Location, 
    d.Sector, 
    t.Teacher_Name, 
    ct.Catering_Name, 
    ct.Kashrut

-- From the Child table alias 'c'
FROM Child c

-- Join the Registration table alias 'r' on the common column Child_ID
JOIN Registration r ON c.Child_ID = r.Child_ID

-- Join the Daycare table alias 'd' on the common column D_ID
JOIN Daycare d ON r.D_ID = d.D_ID

-- Join the Teacher table alias 't' on the common column D_ID
JOIN Teacher t ON d.D_ID = t.D_ID

-- Left join the Catering table alias 'ct' on the common column C_ID
LEFT JOIN Catering ct ON d.C_ID = ct.C_ID

-- Filter the results to include only records where the daycare sector is 'DATI'
WHERE d.Sector = 'DATI' AND d.D_ID IN (
    -- Subquery to select daycares in the 'DATI' sector
    SELECT D_ID
    FROM Daycare
    WHERE Sector = 'DATI'
);
