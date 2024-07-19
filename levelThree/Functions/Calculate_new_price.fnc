CREATE OR REPLACE FUNCTION calculate_new_price(
    p_registration_id INT,
    P_discount Float
) RETURN VARCHAR2 IS
    v_old_price Float;
    v_new_price Float;
BEGIN
    -- Retrieve the old price based on the registration ID
    SELECT Price INTO v_old_price FROM Registration WHERE Registration_ID = p_registration_id;
    
    -- Calculate the new price as half of the old price
    v_new_price := v_old_price*p_discount;
    
    -- Return both old and new prices as a formatted string
    RETURN v_new_price;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Registration ID not found');
END calculate_new_price;
/
