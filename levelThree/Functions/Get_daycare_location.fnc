CREATE OR REPLACE FUNCTION get_daycare_location(p_daycare_id INT) RETURN VARCHAR2 IS
    v_location VARCHAR2(100);
BEGIN
    SELECT Location INTO v_location FROM Daycare WHERE D_ID = p_daycare_id;
    RETURN v_location;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Daycare not found');
END get_daycare_location;
/
