--2.
--Parents can use this query to find daycares in specific locations that offer catering services with 
--a particular kashrut level and belong to a specific sector.

-- Parameters: :p_locations (List of Locations), :p_kashrut (Kashrut Level), :p_sector (Sector)
SELECT 
    d.Daycare_Name,
    d.Location,
    cat.Catering_Name,
    cat.Kashrut
FROM 
    Daycare d
JOIN 
    Catering cat ON d.C_ID = cat.C_ID
WHERE 
    d.Location IN (:p_locations)
    AND cat.Kashrut = :p_kashrut
    AND d.Sector = :p_sector;
