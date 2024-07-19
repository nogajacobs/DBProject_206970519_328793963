--heck Constraint on Daycare Opening and Closing Hours
--Ensure that the Closing_Hours are always later than the 
--Opening_Hours in the Daycare table.

ALTER TABLE Daycare
ADD CONSTRAINT check_opening_closing_hours
CHECK (Closing_Hours > Opening_Hours);
