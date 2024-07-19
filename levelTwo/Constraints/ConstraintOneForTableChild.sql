--Check Constraint on Child's Date of Birth
--Ensure that the child's date of birth is not a future date.

ALTER TABLE Child
ADD CONSTRAINT check_child_dob
CHECK (Child_DOB <= SYSDATE);
