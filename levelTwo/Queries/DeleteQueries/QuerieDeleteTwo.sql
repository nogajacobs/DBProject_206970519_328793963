-- המנהל של גני הילדים רוצה למחוק את כל ההרשמות של ילדים
-- שנרשמו בגני ילדים עם פחות ממספר מסוים של מורים.
-- זה עוזר בשמירה על איכות על ידי הסרת הרשמות מגני ילדים עם צוות מצומצם מדי.

DELETE FROM Registration
WHERE D_ID IN (
    -- תת-שאילתה למציאת מזהי גני הילדים עם פחות ממספר מינימלי של מורים
    SELECT D_ID
    FROM (
        -- תת-שאילתה פנימית לספירת המורים בכל גן ילדים
        SELECT d.D_ID, COUNT(t.T_ID) AS TeacherCount
        FROM Daycare d
        LEFT JOIN Teacher t ON d.D_ID = t.D_ID -- הצטרפות לטבלת Teacher לפי מזהה גן הילדים
        GROUP BY d.D_ID -- קיבוץ לפי מזהה גן הילדים
        HAVING COUNT(t.T_ID) < 3 -- ציון מספר המורים המינימלי (3)
    ) AS UnderStaffedDaycares -- שמירה על התוצאות בגבול של צוות מצומצם
);
