# DatabaseProject
part b:
שאילתות:
שאילתא Select 1:
```SQL
SELECT d.Daycare_Name, d.d_id,
       EXTRACT(YEAR FROM r.Registration_Date) AS Year, 
       COUNT(r.Registration_id) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
GROUP BY d.Daycare_Name, EXTRACT(YEAR FROM r.Registration_Date),d.d_id
ORDER BY Year,d.Daycare_Name;
```

השאילתה מוציאה את שמות הגנים, מזהי הגנים, שנת הרישום, ומספר הרישומים הכולל עבור כל גן בשנה מסוימת, ממסד הנתונים. היא מציגה את התוצאות בסדר כרונולוגי לפי שנה ולאחר מכן לפי שם הגן.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/3b3355cb-1740-442f-bf8a-ff7ffd723d96)


שאילתא Select 2:
```SQL
SELECT  c.Child_ID, c.Child_Name,  d.Daycare_Name,  d.Location ,  d.Sector, 
        t.Teacher_Name, ct.Catering_Name, ct.Kashrut
FROM Child c  JOIN Registration r ON c.Child_ID = r.Child_ID
JOIN Daycare d ON r.D_ID = d.D_ID JOIN Teacher t ON d.D_ID = t.D_ID
LEFT JOIN Catering ct ON d.C_ID = ct.C_ID
WHERE d.Sector = 'DATI' or d.Sector='CHAREDI' AND d.D_ID
 IN ( SELECT D_ID
      FROM Daycare
      WHERE Sector = 'DATI' or d.Sector= 'CHARERDI');
```
השאילתה מוציאה פרטים על ילדים, גנים, מורים ושירותי הסעדה עבור גנים בסקטור דתי או חרדי. היא עושה זאת על ידי ביצוע צירוף של מספר טבלאות עם סינון על פי תנאי הסקטור בגנים.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/f45f1523-f85a-447f-ae0b-cb0f82601c5d)


שאילתא Select 3:
```SQL
Select ct.Catering_name,
(  
    Select Count( distinct r1.child_id)
    from Registration r1
    Join daycare d1 on r1.d_id=d1.d_id
    where d1.c_id=ct.c_id
          and Extract (year from r1.registration_date)=Extract(year from current_date)
 ) As Number_of_children
 from Catering ct
 order by  Number_of_children desc;
```
השאילתה מוציאה את שמות שירותי ההסעדה ומספר הילדים הייחודי שנרשמו לגנים שמשתמשים בשירות ההסעדה הנוכחי בשנה הנוכחית. התוצאות ממוינות לפי מספר הילדים בסדר יורד.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2ea0dd28-8819-4298-a4b2-1776cb761bb6)

שאילתא Select 4:

```SQL
SELECT t.Teacher_Name, d.Daycare_Name,(SELECT COUNT(r2.Child_ID)
        FROM Registration r2
        WHERE r2.D_ID = d.D_ID
          AND EXTRACT(YEAR FROM r2.registration_date) = EXTRACT(YEAR FROM current_date)  ) AS Number_of_Children
FROM Teacher t JOIN Daycare d ON t.D_ID = d.D_ID
WHERE d.D_ID IN ( SELECT r.D_ID
                  FROM Registration r
                   WHERE EXTRACT(YEAR FROM r.registration_date) = EXTRACT(YEAR FROM current_date)
                   GROUP BY r.D_ID
                    HAVING COUNT(r.Child_ID) > ( SELECT AVG(Child_Count)
                    FROM (SELECT COUNT(r2.Child_ID) AS Child_Count
                          FROM Registration r2
                          WHERE EXTRACT(YEAR FROM r2.registration_date) = EXTRACT(YEAR FROM current_date)
                          GROUP BY r2.D_ID   )  ));
```
השאילתה מוציאה את שמות המורים ושמות הגנים יחד עם מספר הילדים שנרשמו בשנה הנוכחית עבור גנים שיש להם יותר ממספר הילדים הממוצע הנרשם לגנים בשנה הנוכחית. היא עושה זאת על ידי ביצוע צירוף של טבלת המורים וטבלת הגנים עם סינון על פי תנאי הממוצע בגנים.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/e1fc270c-c1d0-487a-889d-827c66054ac1)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/672e118b-7e71-4b41-8cd7-e89af7a07681)

שאילתא Select 5:
```SQL
-- Retrieve all columns for children who meet specific criteria
SELECT * 
FROM Child 
WHERE Child_ID IN (
    -- Subquery to find Child_IDs from Registration table
    SELECT Child_ID 
    FROM Registration 
    WHERE price > 1500 
      -- Only include registrations where the price is greater than 1500
      AND D_ID IN (
          -- Subquery to find D_IDs from Daycare table
          SELECT D_ID 
          FROM Daycare 
          WHERE location = 'Holon'
          -- Only include daycares located in 'Holon'
      )
);
```
השאילתא מחזירה את כל פרטי הילדים שנרשמו למסגרת יום (דיי-קר) שנמצאת בחולון ובמחיר הרשמה גבוה מ-1500.



השאילתה החיצונית שואבת את כל העמודות מטבלת הילד עבור אותם ילדים בעלי רישום בהם המחיר עולה על 1500 והמעון המשויך נמצא ב'חולון'.
השאילתות המשנה הפנימיות משמשות תחילה לזהות רישומים רלוונטיים בהתבסס על מיקום המעון והמחיר, ולאחר מכן להשתמש ברישומים אלה כדי לסנן את טבלת הילד.


שאילתא update 1:
```SQL
UPDATE Registration
SET Price = Price * 1.10
WHERE D_ID = (
  SELECT D_ID
  FROM Daycare 
  WHERE D_id = 5;
  and Extract (year from registration_date)='2024';
```
השאילתה מבצעת עדכון לטבלת Registration על מנת להעלות ב-10% את המחירים (Price) של רישומים בגנים שהם בעלי מזהה (D_ID) של 5 ובנוסף, התאריך של הרישום הוא בשנת 2024.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2c8b3b64-ad1a-4cc8-99a0-965632f86d86)

לפני עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/2c513c6a-7597-4516-ad20-169de08c2bbc)

אחרי עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/4bfa4168-f02c-49c6-a828-f5d0c44175d3)



שאילתא update 2:
```SQL
update registration r
set r.price = r.price * 1.05
WHERE EXTRACT(YEAR FROM r.registration_date) = 2024
AND r.D_ID IN (
    SELECT da.D_ID
    FROM Daycare_Activities da
    GROUP BY da.D_ID
    HAVING COUNT(da.Operator_Name) >= 2
```
השאילתה מבצעת עדכון לטבלת Registration על מנת להעלות ב-5% את המחירים (Price) של רישומים בגנים שהם תחת פעילויות בהם יש לפחות שני אופרטורים (Operator_Name), ובנוסף, התאריך של הרישום הוא בשנת 2024.

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/6e6b9f60-7ad2-41b9-a5c8-9b81aed64137)

לפני עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/60d3e980-969c-4199-a0b1-33546e5084ff)

אחרי עדכון:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/1e1fca33-d5e3-431b-ad96-97533d30cde3)

שאילתא delete 1:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/67fa1a4c-5493-41e2-8eb1-b03599e1fab5)

השאילתה מבצעת מחיקת רישומים מטבלת Registration בהתאם לתנאים הבאים:

מחיקת רישומים שהתאריך שלהם (registration_date) קטן משנת 2022.
הרישום שיושמץ לא יכיל את הילדים שלא משתתפים בפעילויות של הגן על פי הקריטריונים הבאים:
ילדים שלהם היה הרשמה (Registration) לאותו גן (D_ID) שבו יש פעילות (Daycare_Activities).
בגישה קצרה, השאילתה מבצעת מחיקת רישומים ישנים של ילדים שלא משתתפים בפעילויות של הגן משנת 2022 והלאה.

לפני מחיקה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/ce4bcb9e-b0e8-4119-bb60-a10c44b7c288)

אחרי מחיקה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/53cd22cb-7bc5-4cf9-bcc5-97bbd9edab60)

שאילתא delete 2:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/e71d53d2-f1e9-429b-b2be-c7670ebe99a7)

השאילתה מבצעת מחיקת רישומים מטבלת Registration בהתאם לתנאים הבאים:

מחיקת רישומים שמקיימים את התנאים הבאים:
המזהה של הגן (D_ID) והמזהה של הילד (Child_ID) שמופיעים בתוך התוצאה של השאילתה המקוננת:
בשאילתה הפנימית, מבוצעת חישוב של כמות הרישומים לכל גן (D_ID).
הרישומים שמקיימים את התנאי שיש לפחות 4 ילדים בכל גן (D_ID) נמחקים מהטבלה.
בגישה קצרה, השאילתה מבצעת מחיקת רישומים לגנים שבהם יש פחות מ-4 ילדים רשומים.
לפני מחיקה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/882d0c84-15ac-40eb-ae46-362e74ebfef7)

אחרי המחיקה

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/5bc8c4cb-c45e-4b3a-9d1e-e9820d857234)

שאילתות עם פרמטרים:

שאילתא 1:
```SQL
SELECT d.Daycare_Name, d.d_id,
    EXTRACT(YEAR FROM r.Registration_Date) AS Year,
    COUNT(r.Registration_id) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
WHERE d.daycare_name = '&<name = "daycare_name" list = "select daycare_Name from daycare">'
      AND r.registration_date  between &<name= "date_from" type= "date" hint="Use dd/m/yyyy format">
      and &<name= "date_to" type= "date"  hint="Use dd/m/yyyy format">
GROUP BY d.Daycare_Name, d.d_id, EXTRACT(YEAR FROM r.Registration_Date);
```

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/14f0b07e-5843-457b-9bce-7ef0e6b1c079)

שאילתא 2:
```SQL
SELECT d.Daycare_Name,d.sector,  d.Location,  cat.Catering_Name, cat.Kashrut
FROM  Daycare d
JOIN Catering cat ON d.C_ID = cat.C_ID
WHERE 
    d.Location ='&<name="location" list="select location from daycare">'
    AND cat.Kashrut = '&<name="kashrut" list="select kashrut  from catering">'
    AND d.Sector = '&<name="sector" list="select sector  from daycare">';
```

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/0db6ec11-3381-40d9-9bc7-e618542aaed5)

שאילתא 3:

```SQL
SELECT t.Teacher_Name, ch.Child_Name, ch.Child_DOB, d.Daycare_Name
FROM Teacher t
JOIN Daycare d ON t.D_ID = d.D_ID
JOIN Registration r ON d.D_ID = r.D_ID
JOIN Child ch ON r.Child_ID = ch.Child_ID
WHERE 
    t.Teacher_Name = '&<name="teachers name" list="select teacher_name  from teacher">'
    and r.registration_date between &<name="from_date" type="date">
    and &<name="to_date" type="date">
ORDER BY   ch.Child_Name;
```

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/5b0036e4-ef35-4942-b391-f6dbd7e62502)

שאילתא 4:

```SQL
SELECT  d.Daycare_Name,
    d.Location,
    a.ACTIVITY_TYPE ,
    da.Operator_Name
FROM Daycare d
JOIN  Daycare_Activities da ON d.D_ID = da.D_ID
JOIN  Activities a ON da.Operator_Name = a.Operator_Name
WHERE  d.Location ='&<name="location" list="select location from daycare">'
    AND a.ACTIVITY_TYPE  = '&<name="activity_type" list="select activity_type  from Activities">'
```
    
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/59abb4ce-6d0c-4c73-b240-ea855becfb65)

אילוצים:

אילוץ 1:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/da744c8f-7ce7-4f47-a6cb-3b575265beb9)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/383161c2-d4c5-457e-92d3-a17e0c837e13)


אילוץ 2:


![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/bf8428cd-5ef4-4121-b5ef-7a6023f5b999)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/9fc6e7b6-d654-4ef2-95c0-d8c213456149)

אילוץ 3:


![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/50518a70-35af-42a7-88b7-ba945b5a3c91)
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/4f27df40-53f3-4b58-b5b4-cab21bf1ae3c)

