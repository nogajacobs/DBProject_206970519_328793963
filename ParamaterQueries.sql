--1.
SELECT d.Daycare_Name, d.d_id,
    EXTRACT(YEAR FROM r.Registration_Date) AS Year,
    COUNT(r.Registration_id) AS Total_Registrations
FROM Registration r
JOIN Daycare d ON r.D_ID = d.D_ID
WHERE d.daycare_name = '&<name = "daycare_name" list = "select daycare_Name from daycare">'
      AND r.registration_date  between &<name= "date_from" type= "date" hint="Use dd/m/yyyy format">
      and &<name= "date_to" type= "date"  hint="Use dd/m/yyyy format">
GROUP BY d.Daycare_Name, d.d_id, EXTRACT(YEAR FROM r.Registration_Date);

--2.
SELECT d.Daycare_Name,d.sector,  d.Location,  cat.Catering_Name, cat.Kashrut
FROM  Daycare d
JOIN Catering cat ON d.C_ID = cat.C_ID
WHERE 
    d.Location ='&<name="location" list="select location from daycare">'
    AND cat.Kashrut = '&<name="kashrut" list="select kashrut  from catering">'
    AND d.Sector = '&<name="sector" list="select sector  from daycare">';

--3.
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

--4.
SELECT  d.Daycare_Name,
    d.Location,
    a.ACTIVITY_TYPE ,
    da.Operator_Name
FROM Daycare d
JOIN  Daycare_Activities da ON d.D_ID = da.D_ID
JOIN  Activities a ON da.Operator_Name = a.Operator_Name
WHERE  d.Location ='&<name="location" list="select location from daycare">'
    AND a.ACTIVITY_TYPE  = '&<name="activity_type" list="select activity_type  from Activities">'
    