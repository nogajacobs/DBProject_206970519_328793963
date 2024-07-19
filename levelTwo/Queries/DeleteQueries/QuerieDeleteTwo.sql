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
