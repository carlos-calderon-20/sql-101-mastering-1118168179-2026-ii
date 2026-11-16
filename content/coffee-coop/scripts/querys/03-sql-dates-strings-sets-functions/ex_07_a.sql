-- Exercise 07 - a
-- Single phone directory: farmers of Pamplona (54518) + collection points of Norte de Santander with a phone.
-- Norte de Santander = municipality codes starting with the department code 54.
SELECT
    'farmer' AS contact_type,
    CONCAT(T1.first_name, ' ', T1.last_name) AS contact_name,
    T1.phone_number AS phone
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
UNION
SELECT
    'collection_point',
    T2.point_name,
    T2.phone_number
FROM buy.collection_points AS T2
WHERE T2.phone_number IS NOT NULL
  AND T2.municipality_code LIKE '54%'
ORDER BY contact_type ASC, contact_name ASC;

/*
-- PEGAR AQUI EL RESULTADO (primeras 10 filas) E INDICAR EL TOTAL: (N rows)
*/
