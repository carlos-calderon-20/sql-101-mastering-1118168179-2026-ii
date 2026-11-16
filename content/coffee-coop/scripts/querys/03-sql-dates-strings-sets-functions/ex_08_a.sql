-- Exercise 08 - a
-- Municipalities of Norte de Santander that have farms AND a collection point (INTERSECT)
SELECT
    T1.municipality_code AS municipality_code,
    T2.municipality_name AS municipality
FROM farm.farms AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
INTERSECT
SELECT
    T3.municipality_code,
    T4.municipality_name
FROM buy.collection_points AS T3
INNER JOIN geo.municipalities AS T4
    ON T3.municipality_code = T4.municipality_code
WHERE T4.department_code = '54'
ORDER BY municipality ASC;

/*
 municipality_code | municipality
-------------------+--------------
 54099             | Bochalema
 54172             | Chinßcota
 54206             | Convenci¾n
 54245             | El Carmen
 54261             | El Zulia
 54347             | Herrßn
 54498             | Oca±a
 54720             | Sardinata
 */
