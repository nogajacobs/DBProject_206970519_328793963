-- 1. שליפת מספר הרשמות לכל חודש ולכל גן ילדים
SELECT 
    d.Daycare_Name, -- שם גן הילדים
    EXTRACT(YEAR FROM r.Date) AS Year, -- שנת ההרשמה
    EXTRACT(MONTH FROM r.Date) AS Month, -- חודש ההרשמה
    COUNT(r.Registation_ID) AS Total_Registrations -- סך כל ההרשמות
FROM 
    Registration r
    JOIN Daycare d ON r.D_ID = d.D_ID -- הצטרפות לטבלת גני הילדים לפי מזהה הגן
GROUP BY 
    d.Daycare_Name, -- קיבוץ לפי שם גן הילדים
    EXTRACT(YEAR FROM r.Date), -- קיבוץ לפי שנת ההרשמה
    EXTRACT(MONTH FROM r.Date) -- קיבוץ לפי חודש ההרשמה
ORDER BY 
    Year, -- מיון לפי שנה
    Month, -- מיון לפי חודש
    d.Daycare_Name; -- מיון לפי שם גן הילדים
