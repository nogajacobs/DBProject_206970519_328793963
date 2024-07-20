-- שאילתה 1: העלאת מחיר ההרשמה לכל ההרשמות בגן ילדים ספציפי ב-10%
UPDATE Registration
SET Price = Price * 1.10 -- עדכון מחיר ההרשמה להגדלה של 10%
WHERE D_ID = (
    -- תת-שאילתה למציאת מזהה גן הילדים לפי שם הגן
    SELECT D_ID
    FROM Daycare 
    WHERE Daycare_Name = 'Daycare_B' -- שם גן הילדים שבו יבוצע עדכון המחיר
);
