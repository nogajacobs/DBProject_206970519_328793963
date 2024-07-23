ALTER TABLE Registration
ADD CONSTRAINT check_registration_price
CHECK (Price>0);



--Unique Constraint on Catering Name
--Ensure that each catering company has a unique name to prevent duplication.
ALTER TABLE Catering
ADD CONSTRAINT unique_catering_name UNIQUE (Catering_Name);

--heck Constraint on Daycare Opening and Closing Hours
--Ensure that the Closing_Hours are always later than the 
--Opening_Hours in the Daycare table.

ALTER TABLE Daycare
ADD CONSTRAINT check_opening_closing_hours
CHECK (Closing_Hours > Opening_Hours);
