-------: Find the total number of children taught in each daycare.
SELECT 
    Daycare_Name,
    SUM(Number_of_Children) AS Total_Children
FROM 
    View_Teachers_Daycare_Details
GROUP BY 
    Daycare_Name;
