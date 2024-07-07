CREATE OR REPLACE PROCEDURE match_child_catering AS
BEGIN
    FOR child_rec IN (SELECT * FROM "CHILD" WHERE CELIAC = 'YES') LOOP
        FOR catering_rec IN (SELECT * FROM "CATERING" WHERE CELIAC = 'YES') LOOP
            -- Logic to match child and catering service (example: printing the match)
            DBMS_OUTPUT.PUT_LINE('Child ' || child_rec.CHILD_NAME || ' can be matched with catering ' || catering_rec.CATERING_NAME);
        END LOOP;
    END LOOP;
END match_child_catering;
/
