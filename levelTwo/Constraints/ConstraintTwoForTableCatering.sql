--Unique Constraint on Catering Name
--Ensure that each catering company has a unique name to prevent duplication.
ALTER TABLE Catering
ADD CONSTRAINT unique_catering_name UNIQUE (Catering_Name);
