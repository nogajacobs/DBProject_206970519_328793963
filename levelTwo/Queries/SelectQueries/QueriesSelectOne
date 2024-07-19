-- 1. Retrieve the total number of registrations per month and per daycare
SELECT d.Daycare_Name, 
       EXTRACT(YEAR FROM r.Date) AS Year, 
       EXTRACT(MONTH FROM r.Date) AS Month, 
       COUNT(r.Registation_ID) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
GROUP BY d.Daycare_Name, EXTRACT(YEAR FROM r.Date), EXTRACT(MONTH FROM r.Date)
ORDER BY Year, Month, d.Daycare_Name;
