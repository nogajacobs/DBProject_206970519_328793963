CREATE VIEW View_Teachers_Daycare_Details AS
SELECT 
    t.Teacher_Name,
    t.Salary,
    d.Daycare_Name,
    COUNT(r.Child_ID) AS Number_of_Children,
    c.Catering_Name
FROM 
    Teacher t
JOIN 
    Daycare d ON t.D_ID = d.D_ID
LEFT JOIN 
    Registration r ON d.D_ID = r.D_ID
JOIN 
    Catering c ON d.C_ID = c.C_ID
GROUP BY 
    t.Teacher_Name, t.Salary, d.Daycare_Name, c.Catering_Name;

