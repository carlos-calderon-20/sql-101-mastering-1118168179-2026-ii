-- Exercise 09  a


SELECT
    T1.department_name AS department,
    COUNT(*) AS municipalities_count
FROM geo.departments AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.department_code = T2.department_code
GROUP BY T1.department_name
HAVING COUNT(*) > 40
ORDER BY municipalities_count DESC;

/**
 department    | municipalities_count
-----------------+----------------------
 Antioquia       |                  125
 Boyac├í          |                  123
 Cundinamarca    |                  116
 Santander       |                   87
 Nari├▒o          |                   64
 Tolima          |                   47
 Bol├¡var         |                   46
 Cauca           |                   42
 Valle Del Cauca |                   42
 **/
