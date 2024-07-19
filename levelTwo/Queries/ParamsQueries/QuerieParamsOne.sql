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
