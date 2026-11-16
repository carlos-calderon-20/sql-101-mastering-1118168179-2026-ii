-- Exercise 08 - b
-- Municipalities of Norte de Santander with farms but WITHOUT a collection point (EXCEPT):
-- candidates to open new collection points
SELECT
    T1.municipality_code AS municipality_code,
    T2.municipality_name AS municipality
FROM farm.farms AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
EXCEPT
SELECT
    T3.municipality_code,
    T4.municipality_name
FROM buy.collection_points AS T3
INNER JOIN geo.municipalities AS T4
    ON T3.municipality_code = T4.municipality_code
WHERE T4.department_code = '54'
ORDER BY municipality ASC;

/*
 municipality_code |   municipality
-------------------+-------------------
 54003             | ┴brego
 54051             | Arboledas
 54109             | Bucarasica
 54128             | Cßchira
 54125             | Cßcota
 54174             | Chitagß
 54001             | C·cuta
 54223             | Cucutilla
 54239             | Durania
 54250             | El Tarra
*/
