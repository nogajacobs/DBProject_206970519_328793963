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
