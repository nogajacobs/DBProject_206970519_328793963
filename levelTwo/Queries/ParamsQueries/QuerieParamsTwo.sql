
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
