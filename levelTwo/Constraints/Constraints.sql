--Check Constraint on Child's Date of Birth
--Ensure that the child's date of birth is not a future date.

ALTER TABLE Child
ADD CONSTRAINT check_child_dob
CHECK (Child_DOB <= SYSDATE);

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
