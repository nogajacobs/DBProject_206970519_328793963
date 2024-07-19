-- Select Queries

-- 1. Retrieve the total number of registrations per month and per daycare
SELECT d.Daycare_Name, 
       EXTRACT(YEAR FROM r.Date) AS Year, 
       EXTRACT(MONTH FROM r.Date) AS Month, 
       COUNT(r.Registation_ID) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
GROUP BY d.Daycare_Name, EXTRACT(YEAR FROM r.Date), EXTRACT(MONTH FROM r.Date)
ORDER BY Year, Month, d.Daycare_Name;

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





--3.all kids who are in Jerusalem and attend a daycare that offers a specific activity
--Purpose: To identify children participating in specific activities in Jerusalem for targeted communication and program adjustments.

SELECT c.Child_Name, c.Child_D.O.B
FROM Child c
JOIN Registration r ON c.Child_ID = r.Child_ID
JOIN Daycare d ON r.D_ID = d.D_ID
WHERE d.Location = 'Jerusalem' AND d.D_ID IN (
  SELECT da.D_ID
  FROM Daycare_Activities da
  JOIN Activities a ON da.Operator_Name = a.Operator_Name
  WHERE a.Type = 'Specific_Activity' -- Replace 'Specific_Activity' with the actual activity type
);



--4. find the daycares located in a specific area and the catering services they use, 
--including the Kashrut level:
 --To help parents identify daycare centers that meet their specific location and dietary requirements for their children.

SELECT d.Daycare_Name, c.Catering_Name, c.Kashrut
FROM Daycare d
JOIN Catering c ON d.C_ID = c.C_ID
WHERE d.Location = 123 AND c.C_ID IN (
  SELECT d.C_ID
  FROM Daycare d
  WHERE d.Location = 123
);

--Suppose a daycare administrator wants to identify daycares that have more than a certain number of registrations in any month of the current year. 
--This information can help in understanding which daycares are experiencing high demand and might require additional resources or support.--
SELECT 
    d.Daycare_Name, 
    EXTRACT(YEAR FROM r.Date) AS Year, 
    EXTRACT(MONTH FROM r.Date) AS Month, 
    COUNT(r.Registration_ID) AS Total_Registrations
FROM 
    Registration r
JOIN 
    Daycare d ON r.D_ID = d.D_ID
WHERE 
    EXTRACT(YEAR FROM r.Date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 
    d.Daycare_Name, 
    EXTRACT(YEAR FROM r.Date), 
    EXTRACT(MONTH FROM r.Date)
HAVING 
    COUNT(r.Registration_ID) > (
        SELECT AVG(Total_Registrations) + 10
        FROM (
            SELECT 
                COUNT(r1.Registration_ID) AS Total_Registrations
            FROM 
                Registration r1
            JOIN 
                Daycare d1 ON r1.D_ID = d1.D_ID
            WHERE 
                EXTRACT(YEAR FROM r1.Date) = EXTRACT(YEAR FROM CURRENT_DATE)
            GROUP BY 
                d1.Daycare_Name, 
                EXTRACT(YEAR FROM r1.Date), 
                EXTRACT(MONTH FROM r1.Date)
        ) AS Monthly_Registrations
    )
ORDER BY 
    Total_Registrations DESC;



-- Query 2: Increase the price of registration for all registrations in a specific daycare by 10%
UPDATE Registration
SET Price = Price * 1.10
WHERE D_ID = (
	SELECT D_ID
	FROM Daycare 
	WHERE Daycare_Name = 'Daycare_B'
);
--Let's consider a scenario where the daycare administrator wants to update the opening hours of daycares based 
--on the average age of the children enrolled in each daycare.
-- The idea here is to adjust the daycare hours to better suit the needs of children of different age groups.
UPDATE Daycare
SET Opening_Hours = CASE
                        WHEN AVG_YEAR < 3 THEN '07:00'  -- Opening hours for daycare with average age under 3
                        WHEN AVG_YEAR >= 3 AND AVG_YEAR < 6 THEN '07:30'  -- Opening hours for daycare with average age between 3 and 6
                        ELSE '08:00'  -- Default opening hours for daycare with average age 6 or older
                    END
FROM (
    SELECT d.D_ID, AVG(EXTRACT(YEAR FROM CURRENT_DATE) - c.Child_D.O.B) AS AVG_YEAR
    FROM Daycare d
    JOIN Registration r ON d.D_ID = r.D_ID
    JOIN Child c ON r.Child_ID = c.Child_ID
    GROUP BY d.D_ID
) AS AvgAgePerDaycare;

 

--The daycare system needs to remove registration records for children who registered
-- more than three years ago during the summer months (June, July, and August).
 --This helps in maintaining a cleaner and more relevant database, focusing on current
-- and recent registrations.
DELETE FROM Registration
WHERE 
    EXTRACT(YEAR FROM Date) < EXTRACT(YEAR FROM CURRENT_DATE) - 3
    AND EXTRACT(MONTH FROM Date) IN (6, 7, 8)
    AND Child_ID NOT IN (
        SELECT DISTINCT Child_ID
        FROM Daycare_Activities da
        JOIN Registration r ON da.D_ID = r.D_ID
    );

--The daycare administrator wants to delete all registrations of children
 --who are registered in daycares with fewer than a certain number of teachers.
 --This helps in maintaining quality by removing registrations from under-staffed daycares.
 DELETE FROM Registration
WHERE D_ID IN (
    SELECT D_ID
    FROM (
        SELECT d.D_ID, COUNT(t.T_ID) AS TeacherCount
        FROM Daycare d
        LEFT JOIN Teacher t ON d.D_ID = t.D_ID
        GROUP BY d.D_ID
        HAVING COUNT(t.T_ID) < 3  -- Specify the minimum number of teachers
    ) AS UnderStaffedDaycares
);
	--PARAMATERS:

--1.	
-- Daycare administrators can use this query to assess the financial performance 
--of their daycare by calculating the total monthly revenue from registrations.
	-- Parameters: :p_daycare_id (Daycare ID), :p_month (Month), :p_year (Year)
SELECT 
    d.Daycare_Name,
    SUM(r.Price) AS Total_Revenue,
    EXTRACT(MONTH FROM r.Date) AS Month,
    EXTRACT(YEAR FROM r.Date) AS Year
FROM 
    Registration r
JOIN 
    Daycare d ON r.D_ID = d.D_ID
WHERE 
    r.D_ID = :p_daycare_id
    AND EXTRACT(MONTH FROM r.Date) = :p_month
    AND EXTRACT(YEAR FROM r.Date) = :p_year
GROUP BY 
    d.Daycare_Name, 
    EXTRACT(MONTH FROM r.Date), 
    EXTRACT(YEAR FROM r.Date);

]

--2.
--Parents can use this query to find daycares in specific locations that offer catering services with 
--a particular kashrut level and belong to a specific sector.

-- Parameters: :p_locations (List of Locations), :p_kashrut (Kashrut Level), :p_sector (Sector)
SELECT 
    d.Daycare_Name,
    d.Location,
    cat.Catering_Name,
    cat.Kashrut
FROM 
    Daycare d
JOIN 
    Catering cat ON d.C_ID = cat.C_ID
WHERE 
    d.Location IN (:p_locations)
    AND cat.Kashrut = :p_kashrut
    AND d.Sector = :p_sector;

--3.
--This query helps parents find the best daycares in a specific sector by identifying those with the most experienced teachers, 
--the number of activities offered, and the catering services provided.
-- Parameters: :p_sector (Sector)
SELECT 
    d.Daycare_Name,
    d.Location,
    AVG(t.Seniority) AS Average_Teacher_Seniority,
    COUNT(DISTINCT da.Operator_Name) AS Number_Of_Activities,
    cat.Catering_Name,
    cat.Kashrut
FROM 
    Daycare d
JOIN 
    Teacher t ON d.D_ID = t.D_ID
LEFT JOIN 
    Daycare_Activities da ON d.D_ID = da.D_ID
LEFT JOIN 
    Catering cat ON d.C_ID = cat.C_ID
WHERE 
    d.Sector = :p_sector
GROUP BY 
    d.Daycare_Name,
    d.Location,
    cat.Catering_Name,
    cat.Kashrut
ORDER BY 
    Average_Teacher_Seniority DESC
FETCH FIRST 5 ROWS ONLY;


--4.
--This query allows daycare administrators to find all children registered under a specific teacher's care, 
--filtered by both the teacher's name and ID.
-- Parameters: :p_teacher_name (Teacher Name), :p_teacher_id (Teacher ID)
SELECT 
    t.Teacher_Name,
    ch.Child_Name,
    ch.Child_D.O.B,
    d.Daycare_Name
FROM 
    Teacher t
JOIN 
    Daycare d ON t.D_ID = d.D_ID
JOIN 
    Registration r ON d.D_ID = r.D_ID
JOIN 
    Child ch ON r.Child_ID = ch.Child_ID
WHERE 
    t.Teacher_Name = :p_teacher_name
    AND t.T_ID = :p_teacher_id
ORDER BY 
    ch.Child_Name;
