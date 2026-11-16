-- Exercise 02 - b
-- Pamplona (54518): number of farmers and average age (years, 2 decimals) per gender, age at 2026-09-30
SELECT
    T1.gender AS gender,
    COUNT(T1.farmer_id) AS farmers_count,
    ROUND(AVG(DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date)))::NUMERIC, 2) AS avg_age_years
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
GROUP BY T1.gender
ORDER BY T1.gender ASC;

/*
-- PEGAR AQUI EL RESULTADO
*/
