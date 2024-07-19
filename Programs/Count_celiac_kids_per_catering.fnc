DECLARE
    v_caterer_name VARCHAR2(100);
    v_celiac_kids_count NUMBER;
BEGIN
    FOR caterer_rec IN (SELECT Catering_Name, C_ID FROM Catering) LOOP
        v_celiac_kids_count := 0;

        -- Query to count celiac kids per caterer
        SELECT COUNT(c.Child_ID)
        INTO v_celiac_kids_count
        FROM Child c
        JOIN Registration r ON c.Child_ID = r.Child_ID
        JOIN Daycare d ON r.D_ID = d.D_ID
        WHERE d.C_ID = caterer_rec.C_ID
          AND c.Celiac = 'YES';

        -- Output the count for each caterer
        DBMS_OUTPUT.PUT_LINE('Caterer ' || caterer_rec.Catering_Name || ' has ' || v_celiac_kids_count || ' celiac kids.');
    END LOOP;
END;
/
