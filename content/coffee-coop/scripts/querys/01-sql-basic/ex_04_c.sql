-- Exercise 04 
-- Municipalities in the whole country whose name contains Pamplona (ILIKE)

SELECT
T1.municipality_code AS municipality_code,
T1.municipality_name AS municipality
FROM geo.municipalities AS T1
WHERE T1.municipality_name ILIKE '%pamplona%';

/**
 municipality_code | municipality
-------------------+--------------
 54518             | Pamplona
 **/