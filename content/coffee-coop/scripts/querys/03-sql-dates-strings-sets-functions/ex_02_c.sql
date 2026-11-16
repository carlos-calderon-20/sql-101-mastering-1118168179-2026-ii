-- Exercise 02 - c
-- Norte de Santander (department code 54): farmers and average age per municipality,
-- only municipalities whose average age is above 51 years (age at 2026-09-30)
SELECT
    T2.municipality_name AS municipality,
    COUNT(T1.farmer_id) AS farmers_count,
    ROUND(AVG(DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date)))::NUMERIC, 2) AS avg_age_years
FROM farm.farmers AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
GROUP BY T2.municipality_name
HAVING AVG(DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date))) > 51
ORDER BY T2.municipality_name ASC;

/*
-- PEGAR AQUI EL RESULTADO (primeras 10 filas) E INDICAR EL TOTAL: (N rows)
*/
