-- Create or replace a function named count_celiac_kids_per_catering
-- The function takes a catering number as an input parameter and returns the count of celiac kids
CREATE OR REPLACE FUNCTION count_celiac_kids_per_catering(p_catering_number IN NUMBER) RETURN NUMBER IS
    -- Variable to store the count of celiac kids
    v_celiac_kids_count NUMBER := 0;
BEGIN
    -- Query to count celiac kids per caterer
    SELECT COUNT(c.Child_ID)
    INTO v_celiac_kids_count
    FROM Child c
    -- Join with the Registration table based on Child_ID
    JOIN Registration r ON c.Child_ID = r.Child_ID
    -- Join with the Daycare table based on D_ID
    JOIN Daycare d ON r.D_ID = d.D_ID
    -- Condition to filter by catering number
    WHERE d.C_ID = p_catering_number
      -- Condition to filter celiac kids
      AND c.Celiac = 'YES';

    -- Return the count of celiac kids
    RETURN v_celiac_kids_count;
END count_celiac_kids_per_catering;
