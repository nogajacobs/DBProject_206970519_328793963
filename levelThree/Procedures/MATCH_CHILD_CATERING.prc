-- יצירה או החלפה של פרוצדורה בשם MATCH_CHILD_CATERING
CREATE OR REPLACE PROCEDURE MATCH_CHILD_CATERING AS
BEGIN
    -- לולאה על מנת למצוא את כל הילדים הצליאקים
    FOR child_rec IN (SELECT * FROM "NOREN"."CHILD" WHERE CELIAC = 'YES') LOOP
        -- לולאה על מנת למצוא את המעון לילד הנוכחי
        FOR reg_rec IN (
            SELECT d.D_ID, d.LOCATION, d.DAYCARE_NAME 
            FROM "NOREN"."REGISTRATION" r
            -- חיבור לטבלת DAYCARE על פי D_ID
            JOIN "NOREN"."DAYCARE" d ON r.D_ID = d.D_ID
            -- סינון לפי CHILD_ID של הילד הנוכחי
            WHERE r.CHILD_ID = child_rec.CHILD_ID
        ) LOOP
            -- הדפסת המידע על הילד והמעון
            DBMS_OUTPUT.PUT_LINE('Child ' || child_rec.CHILD_NAME || ' is registered at daycare ' || reg_rec.DAYCARE_NAME || ' located at ' || reg_rec.LOCATION);

            -- לולאה על מנת למצוא את שתי השירותי הקייטרינג המתאימים לילד הנוכחי
            FOR catering_rec IN ( 
                SELECT * 
                FROM (
                    -- בחירת כל הקייטרינגים שמתאימים לילדים צליאקים
                    SELECT c.*
                    FROM "NOREN"."CATERING" c
                    WHERE c.CELIAC = 'YES'
                    -- סידור רשימת הקייטרינג בצורה אקראית
                    ORDER BY dbms_random.value
                ) 
                -- בחירה של שתי הקייטרינגים הראשונים
                WHERE ROWNUM <= 2
            ) LOOP
                -- הדפסת המידע על הילד והשירותי הקייטרינג המתאימים
                DBMS_OUTPUT.PUT_LINE('Child ' || child_rec.CHILD_NAME || ' can be matched with catering ' || catering_rec.CATERING_NAME);
            END LOOP; -- סיום לולאת הקייטרינג
        END LOOP; -- סיום לולאת המעון
    END LOOP; -- סיום לולאת הילדים
END MATCH_CHILD_CATERING; -- סיום הפרוצדורה
