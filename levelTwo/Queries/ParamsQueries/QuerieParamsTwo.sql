-- 1. 
-- מנהלי גני הילדים יכולים להשתמש בשאילתה זו כדי להעריך את הביצועים הכלכליים של גן הילדים
-- על ידי חישוב סך ההכנסות החודשיות מהרשמות.
-- פרמטרים: :p_daycare_id (מזהה גן הילדים), :p_month (חודש), :p_year (שנה)

SELECT 
    d.Daycare_Name, -- שם גן הילדים
    SUM(r.Price) AS Total_Revenue, -- סך ההכנסות מחודש ההרשמות
    EXTRACT(MONTH FROM r.Date) AS Month, -- חודש ההרשמות
    EXTRACT(YEAR FROM r.Date) AS Year -- שנה ההרשמות
FROM 
    Registration r
JOIN 
    Daycare d ON r.D_ID = d.D_ID -- הצטרפות לטבלת Daycare לפי מזהה גן הילדים
WHERE 
    r.D_ID = :p_daycare_id -- סינון לפי מזהה גן הילדים (פרמטר)
    AND EXTRACT(MONTH FROM r.Date) = :p_month -- סינון לפי חודש ההרשמות (פרמטר)
    AND EXTRACT(YEAR FROM r.Date) = :p_year -- סינון לפי שנה ההרשמות (פרמטר)
GROUP BY 
    d.Daycare_Name, -- קיבוץ לפי שם גן הילדים
    EXTRACT(MONTH FROM r.Date), -- קיבוץ לפי חודש ההרשמות
    EXTRACT(YEAR FROM r.Date); -- קיבוץ לפי שנה ההרשמות
