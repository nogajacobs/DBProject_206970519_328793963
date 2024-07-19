-- Query 1: Increase the price of registration for all registrations in a specific daycare by 10%
UPDATE Registration
SET Price = Price * 1.10
WHERE D_ID = (
	SELECT D_ID
	FROM Daycare 
	WHERE Daycare_Name = 'Daycare_B'
);
