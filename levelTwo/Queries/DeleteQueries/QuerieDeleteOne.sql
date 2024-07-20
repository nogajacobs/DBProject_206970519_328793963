-- מערכת גני הילדים צריכה למחוק רישומים עבור ילדים שנרשמו
-- לפני יותר משלוש שנים במהלך חודשי הקיץ (יוני, יולי ואוגוסט).
-- זה מסייע בשמירה על בסיס נתונים נקי ורלוונטי יותר, תוך מיקוד ברשומות נוכחיות וחדשות.

DELETE FROM Registration
WHERE 
    EXTRACT(YEAR FROM Date) < EXTRACT(YEAR FROM CURRENT_DATE) - 3 -- מחיקת רישומים שהיו לפני יותר משלוש שנים
    AND EXTRACT(MONTH FROM Date) IN (6, 7, 8) -- מחיקת רישומים שהתבצעו בחודשי הקיץ (יוני, יולי ואוגוסט)
    AND Child_ID NOT IN (
        -- תת-שאילתה למציאת Child_IDs שלא נרשמו לפעילויות גן ילדים
        SELECT DISTINCT Child_ID
        FROM Daycare_Activities da
        JOIN Registration r ON da.D_ID = r.D_ID
    );
