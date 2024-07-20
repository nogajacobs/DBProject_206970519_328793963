-- שאילתה זו מאפשרת למנהלי גני הילדים למצוא את כל הילדים הרשומים תחת טיפול של גננת מסוימת,
-- מסוננת לפי שם ומזהה הגננת.
-- פרמטרים: :p_teacher_name (שם הגננת), :p_teacher_id (מזהה הגננת)

SELECT 
    t.Teacher_Name, -- שם הגננת
    ch.Child_Name, -- שם הילד
    ch.Child_D.O.B, -- תאריך לידה של הילד
    d.Daycare_Name -- שם גן הילדים
FROM 
    Teacher t
JOIN 
    Daycare d ON t.D_ID = d.D_ID -- הצטרפות לטבלת Daycare לפי מזהה גן הילדים
JOIN 
    Registration r ON d.D_ID = r.D_ID -- הצטרפות לטבלת Registration לפי מזהה גן הילדים
JOIN 
    Child ch ON r.Child_ID = ch.Child_ID -- הצטרפות לטבלת Child לפי מזהה הילד
WHERE 
    t.Teacher_Name = :p_teacher_name -- סינון לפי שם הגננת (פרמטר)
    AND t.T_ID = :p_teacher_id -- סינון לפי מזהה הגננת (פרמטר)
ORDER BY 
    ch.Child_Name; -- מיון לפי שם הילד
