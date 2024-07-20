-- נעדכן את שעות הפתיחה של גני הילדים בהתבסס על גיל ממוצע של הילדים הרשומים בכל גן ילדים.
-- הרעיון כאן הוא להתאים את שעות הפתיחה של גני הילדים כך שיתאימו לצרכים של קבוצות גיל שונות של ילדים.

UPDATE Daycare
SET Opening_Hours = CASE
                        WHEN AVG_YEAR < 3 THEN '07:00'  -- שעות פתיחה עבור גני ילדים עם גיל ממוצע מתחת ל-3
                        WHEN AVG_YEAR >= 3 AND AVG_YEAR < 6 THEN '07:30'  -- שעות פתיחה עבור גני ילדים עם גיל ממוצע בין 3 ל-6
                        ELSE '08:00'  -- שעות פתיחה ברירת מחדל עבור גני ילדים עם גיל ממוצע של 6 או יותר
                    END
FROM (
    -- תת-שאילתה לחישוב גיל ממוצע של הילדים בכל גן ילדים
    SELECT d.D_ID, 
           AVG(EXTRACT(YEAR FROM CURRENT_DATE) - c.Child_D.O.B) AS AVG_YEAR -- גיל ממוצע של הילדים בגן הילדים
    FROM Daycare d
    JOIN Registration r ON d.D_ID = r.D_ID -- הצטרפות לטבלת Registration לפי מזהה גן הילדים
    JOIN Child c ON r.Child_ID = c.Child_ID -- הצטרפות לטבלת Child לפי מזהה הילד
    GROUP BY d.D_ID -- קיבוץ לפי מזהה גן הילדים
) AS AvgAgePerDaycare; -- שם זמני לתת-השאילתה
