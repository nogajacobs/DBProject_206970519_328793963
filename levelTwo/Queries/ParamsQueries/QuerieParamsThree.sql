-- 2.
-- הורים יכולים להשתמש בשאילתה זו כדי למצוא גני ילדים במיקומים ספציפיים המציעים שירותי הסעדה
-- עם רמת כשרות מסוימת ושייכים למגזר מסוים.

-- פרמטרים: :p_locations (רשימת מיקומים), :p_kashrut (רמת כשרות), :p_sector (מגזר)

SELECT 
    d.Daycare_Name, -- שם גן הילדים
    d.Location, -- מיקום גן הילדים
    cat.Catering_Name, -- שם שירות ההסעדה
    cat.Kashrut -- רמת הכשרות של שירות ההסעדה
FROM 
    Daycare d
JOIN 
    Catering cat ON d.C_ID = cat.C_ID -- הצטרפות לטבלת Catering לפי מזהה שירות ההסעדה
WHERE 
    d.Location IN (:p_locations) -- סינון לפי רשימת מיקומים (פרמטר)
    AND cat.Kashrut = :p_kashrut -- סינון לפי רמת הכשרות של שירות ההסעדה (פרמטר)
    AND d.Sector = :p_sector; -- סינון לפי מגזר (פרמטר)
