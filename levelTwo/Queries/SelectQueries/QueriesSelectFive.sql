-- Retrieve all columns for children who meet specific criteria
SELECT * 
FROM Child 
WHERE Child_ID IN (
    -- Subquery to find Child_IDs from Registration table
    SELECT Child_ID 
    FROM Registration 
    WHERE price > 1500 
      -- Only include registrations where the price is greater than 1500
      AND D_ID IN (
          -- Subquery to find D_IDs from Daycare table
          SELECT D_ID 
          FROM Daycare 
          WHERE location = 'Holon'
          -- Only include daycares located in 'Holon'
      )
);
