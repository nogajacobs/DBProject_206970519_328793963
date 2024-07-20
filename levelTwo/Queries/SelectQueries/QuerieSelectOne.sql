-- Select the name of the daycare, the year and month of each registration, and the total number of registrations
SELECT d.Daycare_Name, 

       -- Extract the year from the registration date and give it the alias 'Year'
       EXTRACT(YEAR FROM r.Date) AS Year, 

       -- Extract the month from the registration date and give it the alias 'Month'
       EXTRACT(MONTH FROM r.Date) AS Month, 

       -- Count the number of registrations and give it the alias 'Total_Registrations'
       COUNT(r.Registration_ID) AS Total_Registrations

-- From the Registration table alias 'r'
FROM Registration r

-- Join the Daycare table alias 'd' on the common column D_ID
JOIN Daycare d ON r.D_ID = d.D_ID

-- Group the results by the daycare name, year, and month
GROUP BY d.Daycare_Name, EXTRACT(YEAR FROM r.Date), EXTRACT(MONTH FROM r.Date)

-- Order the results by year, month, and daycare name
ORDER BY Year, Month, d.Daycare_Name;
