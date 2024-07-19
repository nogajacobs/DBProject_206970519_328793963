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
