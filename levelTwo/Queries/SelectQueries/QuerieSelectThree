--3.all kids who are in Jerusalem and attend a daycare that offers a specific activity
--Purpose: To identify children participating in specific activities in Jerusalem for targeted communication and program adjustments.

SELECT c.Child_Name, c.Child_D.O.B
FROM Child c
JOIN Registration r ON c.Child_ID = r.Child_ID
JOIN Daycare d ON r.D_ID = d.D_ID
WHERE d.Location = 'Jerusalem' AND d.D_ID IN (
  SELECT da.D_ID
  FROM Daycare_Activities da
  JOIN Activities a ON da.Operator_Name = a.Operator_Name
  WHERE a.Type = 'Specific_Activity' -- Replace 'Specific_Activity' with the actual activity type
);
