CREATE OR REPLACE PROCEDURE switch_registered_children(
    p_abusive_tchr_id INT,
    p_new_dc_id INT,
    p_discount FLOAT
) IS
    v_old_dc_id INT;
    v_old_loc VARCHAR2(100);
    v_new_loc VARCHAR2(100);
    v_num_children INT := 0;
    v_cursor SYS_REFCURSOR;
    v_child_id INT;
    v_child_name VARCHAR2(100);
    v_reg_id INT;
    v_old_price NUMBER;
    v_new_price NUMBER;
    v_new_tchr_id INT;
    v_new_salary NUMBER;
    v_next_reg_id INT; -- Variable to hold the next registration ID
    v_old_daycare_name VARCHAR2(100);
    v_new_daycare_name VARCHAR2(100);
BEGIN
    -- Get the old daycare ID and location of the abusive teacher
    BEGIN
        SELECT t.D_ID, d.Daycare_Name INTO v_old_dc_id, v_old_daycare_name
        FROM Teacher t
        JOIN Daycare d ON t.D_ID = d.D_ID
        WHERE t.T_ID = p_abusive_tchr_id;
        
        v_old_loc := get_daycare_location(v_old_dc_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'Teacher or daycare not found');
    END;

    -- Get the location and name of the new daycare
    BEGIN
        v_new_loc := get_daycare_location(p_new_dc_id);
        SELECT Daycare_Name INTO v_new_daycare_name FROM Daycare WHERE D_ID = p_new_dc_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20007, 'New daycare not found');
    END;

    -- Check if the new daycare is in the same location
    IF v_old_loc != v_new_loc THEN
        RAISE_APPLICATION_ERROR(-20001, 'New daycare is not in the same location');
    END IF;

    -- Open a cursor to select all children from the old daycare for the current year
    OPEN v_cursor FOR
        SELECT c.Child_ID, c.Child_Name, r.Registration_ID, r.Price
        FROM Registration r
        JOIN Child c ON r.Child_ID = c.Child_ID
        WHERE r.D_ID = v_old_dc_id
          AND EXTRACT(YEAR FROM r.REGISTRATION_DATE) = EXTRACT(YEAR FROM SYSDATE);

    LOOP
        -- Fetch each child record
        FETCH v_cursor INTO v_child_id, v_child_name, v_reg_id, v_old_price;
        EXIT WHEN v_cursor%NOTFOUND;

        BEGIN
            -- Calculate the new price using the function with discount
            v_new_price := calculate_new_price(v_reg_id, p_discount);
            
            -- Get the next registration ID
            SELECT NVL(MAX(Registration_ID), 0) + 1 INTO v_next_reg_id FROM Registration;
            
            -- Insert new registration with the new price
            INSERT INTO Registration (Registration_ID, Price, REGISTRATION_DATE, D_ID, Child_ID)
            VALUES (v_next_reg_id, v_new_price, SYSDATE, p_new_dc_id, v_child_id);

            -- Remove old registration
            DELETE FROM Registration
            WHERE Registration_ID = v_reg_id;

            -- Log the transfer of each child
            DBMS_OUTPUT.PUT_LINE('Child ' || v_child_name || ' transferred from daycare ' || v_old_daycare_name || ' to daycare ' || v_new_daycare_name);

            -- Increment child count for the new daycare
            v_num_children := v_num_children + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error transferring child with ID: ' || v_child_id || ' Error: ' || SQLERRM);
        END;
    END LOOP;

    -- Close the cursor
    CLOSE v_cursor;

    -- Get the ID of a teacher in the new daycare
    SELECT T_ID INTO v_new_tchr_id FROM Teacher WHERE D_ID = p_new_dc_id AND ROWNUM = 1;

    -- Calculate the new salary for the new teacher based on the updated number of children
    v_new_salary := calculate_teacher_salary(v_new_tchr_id);

    -- Update the salary for the new teacher
    UPDATE Teacher
    SET Salary = v_new_salary
    WHERE T_ID = v_new_tchr_id;

    -- Log the transfer and new teacher's salary update
    DBMS_OUTPUT.PUT_LINE('Children transferred from daycare ' || v_old_dc_id || ' to daycare ' || p_new_dc_id);
    DBMS_OUTPUT.PUT_LINE('New teacher ID ' || v_new_tchr_id || ' salary updated to ' || v_new_salary);
END switch_registered_children;
/
