-- שאילתה זו מחזירה מידע מפורט על כל ילד במגזר 'דתי',
-- כולל גן הילדים ושירות ההסעדה המשויך.

-- שליפת מזהה הילד, שם הילד, שם גן הילדים, מיקום, מגזר, שם הגננת, שם ההסעדה ורמת הכשרות
SELECT 
    c.Child_ID, -- מזהה הילד
    c.Child_Name, -- שם הילד
    d.Daycare_Name, -- שם גן הילדים
    d.Location, -- מיקום גן הילדים
    d.Sector, -- מגזר גן הילדים
    t.Teacher_Name, -- שם הגננת
    ct.Catering_Name, -- שם שירות ההסעדה
    ct.Kashrut -- רמת הכשרות

-- מתוך הטבלה Child עם כינוי 'c'
FROM Child c

-- הצטרפות לטבלת Registration עם כינוי 'r' לפי עמודת Child_ID
JOIN Registration r ON c.Child_ID = r.Child_ID

-- הצטרפות לטבלת Daycare עם כינוי 'd' לפי עמודת D_ID
JOIN Daycare d ON r.D_ID = d.D_ID

-- הצטרפות לטבלת Teacher עם כינוי 't' לפי עמודת D_ID
JOIN Teacher t ON d.D_ID = t.D_ID

-- הצטרפות שמאלית לטבלת Catering עם כינוי 'ct' לפי עמודת C_ID
LEFT JOIN Catering ct ON d.C_ID = ct.C_ID

-- סינון התוצאות כך שיכללו רק רשומות שבהן מגזר גן הילדים הוא 'דתי'
WHERE d.Sector = 'DATI' AND d.D_ID IN (
    -- תת-שאילתה לבחירת גני הילדים במגזר 'דתי'
    SELECT D_ID
    FROM Daycare
    WHERE Sector = 'DATI'
);
