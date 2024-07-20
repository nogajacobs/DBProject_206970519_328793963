-- שליפת כל העמודות עבור ילדים העונים על קריטריונים ספציפיים
SELECT * 
FROM Child 
WHERE Child_ID IN (
    -- תת-שאילתה למציאת מזהי ילדים מטבלת Registration
    SELECT Child_ID 
    FROM Registration 
    WHERE price > 1500 
      -- כלול רק הרשמות שבהן המחיר גבוה מ-1500
      AND D_ID IN (
          -- תת-שאילתה למציאת מזהי גני ילדים מטבלת Daycare
          SELECT D_ID 
          FROM Daycare 
          WHERE location = 'Holon'
          -- כלול רק גני ילדים הממוקמים ב'חולון'
      )
);
