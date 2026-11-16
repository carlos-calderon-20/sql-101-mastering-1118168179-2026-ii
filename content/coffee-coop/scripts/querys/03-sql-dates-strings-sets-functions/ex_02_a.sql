-- Exercise 02 - a
-- Top 10 oldest farmers of Pamplona (54518), age at 2026-09-30
SELECT
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    T1.birth_date AS birth_date,
    DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date)) AS age_years
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
ORDER BY T1.birth_date ASC
LIMIT 10;

/*
-- PEGAR AQUI EL RESULTADO
(10 rows)
*/
