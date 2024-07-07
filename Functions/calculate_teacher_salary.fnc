CREATE OR REPLACE FUNCTION calculate_teacher_salary(
    p_teacher_id INT
) RETURN NUMBER IS
    v_hourly_wage NUMBER;
    v_num_children INT := 0;
    v_extra_bonus NUMBER := 0;
    v_total_salary NUMBER;
    v_seniority VARCHAR2(20);
    v_daycare_id INT;
    v_opening_hours Date;
    v_closing_hours Date;
    v_hours_per_week Number;
    v_hours_per_day Number;

    CURSOR c_children IS
        SELECT COUNT(Child_ID) AS child_count
        FROM Registration
        WHERE D_ID = v_daycare_id;
    child_count_rec c_children%ROWTYPE;

BEGIN
    -- Get the teacher's seniority and daycare ID
    SELECT t.Seniority, t.D_ID, d.open_time, d.close_time
    INTO v_seniority, v_daycare_id, v_opening_hours, v_closing_hours
    FROM Teacher t
    join Daycare d On t.D_id=d.d_id
    WHERE t.T_ID = p_teacher_id;

    -- Determine the hourly wage based on seniority
    CASE v_seniority
        WHEN 'Novice' THEN v_hourly_wage := 35;
        WHEN 'Junior' THEN v_hourly_wage := 40;
        WHEN 'Intermediate' THEN v_hourly_wage := 45;
        WHEN 'Experienced' THEN v_hourly_wage := 50;
        WHEN 'Senior' THEN v_hourly_wage := 55;
        ELSE RAISE_APPLICATION_ERROR(-20001, 'Invalid seniority level');
    END CASE;

--calculate hours worked per day and per week
    v_hours_per_day:=TO_NUMBER(TO_CHAR( v_closing_hours, 'HH24'))-TO_NUMBER(TO_CHAR( v_opening_hours, 'HH24'));
    v_hours_per_week:=v_hours_per_day*5;
    
    -- Use cursor to count the number of children in the teacher's daycare
    OPEN c_children;
    FETCH c_children INTO child_count_rec;
    CLOSE c_children;

    v_num_children := child_count_rec.child_count;

    -- Calculate the bonus for extra children (if more than 3)
    IF v_num_children > 3 THEN
        v_extra_bonus := (v_num_children - 3) * 3 * v_hours_per_week;
    ELSE
        v_extra_bonus := 0;
    END IF;

    -- Calculate the total salary
    v_total_salary := (v_hourly_wage * v_hours_per_week*4) + v_extra_bonus;

    RETURN v_total_salary;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'No children found for the teacher''s daycare');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred: ' || SQLERRM);
END;
/
