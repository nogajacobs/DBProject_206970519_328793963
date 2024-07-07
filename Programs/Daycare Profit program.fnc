
DECLARE
    v_total_income NUMBER;
    v_total_salary NUMBER;
BEGIN
    FOR daycare_rec IN (SELECT * FROM Daycare) LOOP
        -- Initialize totals for each daycare
        v_total_income := 0;
        v_total_salary := 0;

        -- Calculate total income (sum of registration prices)
        SELECT NVL(SUM(r.Price), 0)
        INTO v_total_income
        FROM Registration r
        WHERE r.D_ID = daycare_rec.D_ID
          AND EXTRACT(YEAR FROM r.Registation_Date) = EXTRACT(YEAR FROM SYSDATE);

        -- Calculate total salary (sum of all teachers' salaries)
        SELECT NVL(SUM(t.Salary), 0)
        INTO v_total_salary
        FROM Teacher t
        WHERE t.D_ID = daycare_rec.D_ID;

        -- Calculate profit (income - salary)
        DBMS_OUTPUT.PUT_LINE('Daycare ' || daycare_rec.Daycare_Name || ' profit for year ' || EXTRACT(YEAR FROM SYSDATE) ||
                             ': ' || (v_total_income - v_total_salary));
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
/
