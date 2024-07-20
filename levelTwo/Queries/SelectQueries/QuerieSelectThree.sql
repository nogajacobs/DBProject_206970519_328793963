-- שליפת כל הילדים בירושלים שנמצאים בגן ילדים המציע פעילות מסוימת
-- מטרה: לזהות ילדים המשתתפים בפעילויות מסוימות בירושלים לצורך תקשורת ממוקדת והתאמות בתכניות.

SELECT 
    c.Child_Name, -- שם הילד
    c.Child_D.O.B -- תאריך לידה של הילד
FROM 
    Child c
JOIN 
    Registration r ON c.Child_ID = r.Child_ID -- הצטרפות לטבלת Registration לפי מזהה הילד
JOIN 
    Daycare d ON r.D_ID = d.D_ID -- הצטרפות לטבלת Daycare לפי מזהה גן הילדים
WHERE 
    d.Location = 'Jerusalem' -- סינון לפי מיקום גן הילדים בירושלים
    AND d.D_ID IN (
        -- תת-שאילתה לבחירת גני הילדים המציעים פעילות מסוימת
        SELECT 
            da.D_ID -- מזהה גן הילדים
        FROM 
            Daycare_Activities da
        JOIN 
            Activities a ON da.Operator_Name = a.Operator_Name -- הצטרפות לטבלת Activities לפי שם המפעיל
        WHERE 
            a.Type = 'Specific_Activity' -- החלף 'Specific_Activity' בסוג הפעילות הרצוי
    );
