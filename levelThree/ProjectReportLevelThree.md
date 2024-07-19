# DatabaseProject

פונקציה 1:
פונקציה זו מחשבת את המחיר החדש לרישום בהתאם להנחה שניתנה ומחזירה את המחיר החדש:
```	SQL
CREATE OR REPLACE FUNCTION calculate_new_price(
    p_registration_id INT,
    P_discount Float
) RETURN VARCHAR2 IS
    v_old_price Float;
    v_new_price Float;

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
```
לפני ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/cf50bf54-21cb-4c63-855e-2355d818d3f6)
אחרי ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/7798490a-14df-4af0-84c2-a3e259242063)

זריקת חריגה:

![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/61f9bfc2-45c4-4cea-8e82-7bbf9699cb22)


פונקציה 2:
יצא חוק חדש ששכר הגננות יהיה אישי לכל לפי מספר השעות, כמות נסיון, וכמות ילדים שהיא מלמדת. 
 פונקציה זו מחשבת את השכר הכולל של מורה בגן הילדים בהתאם למספר הילדים שנרשמים אליו. השכר הכולל נקבע על פי שעות העבודה השבועיות והשעתיות של המורה, תוך כדי ניתוח של רמת הנסיון שלו. תוספת נוספת מחושבת עבור ילדים נוספים מעבר למספר שלושה.
 ```SQL

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


```
תוצאת ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/15c62ff9-10a7-45da-8d77-2802a1312e26)
זריקת חריגה:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/69aa12fc-ff2f-4cc6-a802-a9891db28231)

פונקציה 3:
פונקציה זו מחזירה את המיקום של גן הילדים בהתאם למספר הזיהוי שלו.
```SQL
CREATE OR REPLACE FUNCTION get_daycare_location(p_daycare_id INT) RETURN VARCHAR2 IS
    v_location VARCHAR2(100);
BEGIN
    SELECT Location INTO v_location FROM Daycare WHERE D_ID = p_daycare_id;
    RETURN v_location;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Daycare not found');
END get_daycare_location;
```
תוצאת ריצה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/45a0e8a6-f2b6-438c-a9e3-80aaee7ac876)

זריקת חריגה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/dffcfbcd-9d6a-4d9b-9c00-658962f7d023)

פונקציה 4:
```SQL
CREATE OR REPLACE FUNCTION count_celiac_kids_per_catering(p_catering_number IN NUMBER)
RETURN NUMBER IS
    v_celiac_kids_count NUMBER := 0;
    v_catering_exists NUMBER := 0;
BEGIN
    -- Check if the catering number exists
    SELECT COUNT(*)
    INTO v_catering_exists
    FROM Catering
    WHERE C_ID = p_catering_number;

    IF v_catering_exists = 0 THEN
        -- Raise an exception if the catering number does not exist
        RAISE_APPLICATION_ERROR(-20001, 'Catering number ' || p_catering_number || ' does not exist.');
    END IF;

    -- Query to count celiac kids per caterer
    SELECT COUNT(c.Child_ID)
    INTO v_celiac_kids_count
    FROM Child c
    JOIN Registration r ON c.Child_ID = r.Child_ID
    JOIN Daycare d ON r.D_ID = d.D_ID
    WHERE d.C_ID = p_catering_number
      AND c.Celiac = 'YES';

    -- Return the count of celiac kids
    RETURN v_celiac_kids_count;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case when no data is found
        RAISE_APPLICATION_ERROR(-20010, 'No data found for catering number ' || p_catering_number);
        RETURN 0; -- Return 0 if no data is found
    WHEN OTHERS THEN
        -- Handle any other exceptions
        RAISE_APPLICATION_ERROR(-20009, 'An error occurred: ' || SQLERRM);
        RETURN -1; -- Return -1 to indicate an error occurred
END count_celiac_kids_per_catering;
```

![image](https://github.com/user-attachments/assets/302d0177-9c6c-4d5c-92ba-9fef8564cc11)

זריקת חריגה:
![image](https://github.com/user-attachments/assets/39cb5832-7ac4-432a-b3ee-d6ba0cbe2f79)

בשביל 2 מהפרוצדורת היהו צרכיות להוסיף לטבלה של גננת שדה של משכורת:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/ea78ee53-a039-400d-b85f-b0e0caf08719)

פורצודורה 1:
בצהרון play and learn הייתה מקרה של אלימות מהמורה, לכן הערייה העבירה את כל הילדים לצהרון אחר בעיר, ונתנה הנחה של 50% לרישום החדש, ומעדכנת את השכר של הגננת החדשה בהתאם:
```SQL

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
```

פלט הפרוצודורה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/bc79eb8b-2b3d-4941-8c91-27aca877963d)
לפני ריצה - אפשר לראות שהילדים רשומים לצהרון מס 4:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/61276149-cc76-4e73-a473-713b2f191500)

אחרי הריצה ניתן לראות שהם עברו לגן מספר 177:
![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/6c7d2153-705e-4e2e-8e27-5cdca25c8fe4)



זריקת חריגה:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/cc4422d6-0257-4730-8f95-f7e7e5e56a34)

פרוצודורה 2:
העריה העבירה חוק שכל מוסדי החינוך צריכים לדאוג למנות ללא גלוטן עבור הילדים עם ציליאק.
לשם כך הוספנו לטבלאות של ילד  וקיטרינג שדה של ציליאק:
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/6410455b-40d9-4ca1-a5fb-97d9e0206c64)
![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/a323fb1d-d077-4f03-bea8-9c4e89a16d84)
וכן יצרנו פרוצודורה שעוברת על הילדים ואם הילד ציליאקי מוצא עבורו קייטרינג עם אופציה של ציליאק:
```SQL
CREATE OR REPLACE PROCEDURE match_child_catering AS
BEGIN
    FOR child_rec IN (SELECT * FROM "CHILD" WHERE CELIAC = 'YES') LOOP
        FOR catering_rec IN (SELECT * FROM "CATERING" WHERE CELIAC = 'YES') LOOP
            -- Logic to match child and catering service (example: printing the match)
            DBMS_OUTPUT.PUT_LINE('Child ' || child_rec.CHILD_NAME || ' can be matched with catering ' || catering_rec.CATERING_NAME);
        END LOOP;
    END LOOP;
END match_child_catering;
```


פלט התכנית:

![image](https://github.com/nogajacobs/DatabaseProject/assets/80648050/888d60ec-3f76-4d44-bfde-62520c39431a)


תכנית 1:

תכנית זו מחשבת את הרווח של כל גן הילדים בשנה הנוכחית, על ידי חישוב ההכנסות הכוללות (סכום מחירי הרישום) וחישוב השכר הכולל של כל המורים.
```SQL
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

```

פלט התכנית:

![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/4f4a8275-19e7-453e-b014-f09f523816e3)

תכנית 2

תכנית זו סופרת את מספר הילדים הסליאקים בכל קייטרינג, על פי מספר הזיהוי שלו.
```




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


```
פלט  התכנית:

![image](https://github.com/nogajacobs/DatabaseProject/assets/73253528/3f983f27-24b3-476f-b83b-5507503a4d26)



