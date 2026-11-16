-- Exercise 05 - b
-- Municipality of Norte de Santander with the longest name (ties: first alphabetically)
-- UPPER on both sides because the department name may be stored in another case (see 05 - c)
SELECT
    T1.municipality_name AS municipality,
    LENGTH(T1.municipality_name) AS name_length
FROM geo.municipalities AS T1
INNER JOIN geo.departments AS T2
    ON T1.department_code = T2.department_code
WHERE UPPER(T2.department_name) = UPPER('Norte de Santander')
ORDER BY name_length DESC, T1.municipality_name ASC
LIMIT 1;

/*
municipality    | name_length
-------------------+-------------
 Villa Del Rosario |          17
*/
