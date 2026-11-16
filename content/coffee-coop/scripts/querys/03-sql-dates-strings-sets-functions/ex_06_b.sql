-- Exercise 06 - b
-- One sentence per collection point of Norte de Santander: '<point> recibe café en <municipality>'
SELECT
    CONCAT(T1.point_name, ' recibe café en ', T2.municipality_name) AS description
FROM buy.collection_points AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
ORDER BY T1.point_name ASC;

/*
                      description
--------------------------------------------------------
 Punto de Compra Bochalema 1 recibe café en Bochalema
 Punto de Compra Chinßcota 1 recibe café en Chinßcota
 Punto de Compra Convenci¾n 1 recibe café en Convenci¾n
 Punto de Compra El Carmen 1 recibe café en El Carmen
 Punto de Compra El Carmen 2 recibe café en El Carmen
 Punto de Compra El Zulia 1 recibe café en El Zulia
 Punto de Compra Herrßn 1 recibe café en Herrßn
 Punto de Compra Herrßn 2 recibe café en Herrßn
 Punto de Compra Oca±a 1 recibe café en Oca±a
 Punto de Compra Sardinata 1 recibe café en Sardinata
*/
