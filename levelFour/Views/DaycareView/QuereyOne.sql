-------List all teachers whose salary is above the average salary of all teachers.

SELECT 
    Teacher_Name,
    Salary,
    Daycare_Name,
FROM 
    View_Teachers_Daycare_Details
WHERE 
    Salary > (SELECT AVG(Salary) FROM View_Teachers_Daycare_Details);
