--Testing the feasibility of preparing gluten-free meals
DECLARE
    v_celiac_kids_count NUMBER := 0; -- משתנה לאחסון תוצאת הפונקציה

BEGIN
    -- לולאה שמעבור על כל ה-Catering בפרויקט
    FOR c_rec IN (SELECT C_ID FROM "NOREN"."DAYCARE") LOOP
        -- קריאה לפונקציה ואחסון התוצאה במשתנה
        v_celiac_kids_count := count_celiac_kids_per_catering(c_rec.C_ID);

        -- בדיקה אם יש מעל ל-2 ילדים עם צליאק ב-Catering נוכחי
        IF v_celiac_kids_count > 2 THEN
            -- הדפסת הודעה שמשתלמת להכין ארוחות ללא גלוטן ב-Catering זה
            DBMS_OUTPUT.PUT_LINE('It is worthwhile to prepare gluten-free meals for Catering number ' || c_rec.C_ID);
        END IF;
    END LOOP;
END;
