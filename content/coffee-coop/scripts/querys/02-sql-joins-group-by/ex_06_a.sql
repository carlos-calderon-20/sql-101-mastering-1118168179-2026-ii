-- Exercise 06 - a
-- Pairs of farms in the same rural district (municipality 54518)


SELECT
    T1.rural_district AS rural_district,
    T1.farm_name AS farm_a,
    T2.farm_name AS farm_b
FROM farm.farms AS T1
INNER JOIN farm.farms AS T2
    ON T1.rural_district = T2.rural_district
   AND T1.farm_id < T2.farm_id
WHERE T1.municipality_code = '54518'
  AND T2.municipality_code = '54518'
ORDER BY T1.rural_district;

/**
 rural_district    |      farm_a      |      farm_b
----------------------+------------------+------------------
 Alcaparral           | Monte Alto       | La Granja
 Alcaparral           | La Floresta      | Buenavista
 Alcaparral           | La Floresta      | San Jos├®
 Alcaparral           | Miraflores       | Monte Alto
 Alcaparral           | Miraflores       | La Granja
 Alcaparral           | Buenavista       | Los Pinos
 Alcaparral           | Buenavista       | San Jos├®
 Alcaparral           | San Jos├®         | La Granja
 Alcaparral           | San Jos├®         | Monte Alto
 **/
