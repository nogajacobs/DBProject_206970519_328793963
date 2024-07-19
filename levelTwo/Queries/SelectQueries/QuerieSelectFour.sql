--4. find the daycares located in a specific area and the catering services they use, 
--including the Kashrut level:
 --To help parents identify daycare centers that meet their specific location and dietary requirements for their children.

SELECT d.Daycare_Name, c.Catering_Name, c.Kashrut
FROM Daycare d
JOIN Catering c ON d.C_ID = c.C_ID
WHERE d.Location = 123 AND c.C_ID IN (
  SELECT d.C_ID
  FROM Daycare d
  WHERE d.Location = 123
);
