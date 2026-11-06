-- Exercise 03 - a
-- All collection points with their deliveries of 2026-09-30


SELECT
    T2.point_name AS collection_point,
    T1.delivery_id           AS delivery,
    T1.gross_weight_kg       AS gross_weight_kg
FROM buy.deliveries AS T1
RIGHT JOIN buy.collection_points AS T2
    ON T1.collection_point_id = T2.collection_point_id
   AND T1.delivery_id LIKE 'DLV-20260930-%';

   /**
     collection_point               |      delivery       | gross_weight_kg
----------------------------------------------+---------------------+-----------------
 Punto de Compra Salgar 1                     | DLV-20260930-000002 |          124.98
 Punto de Compra Cajib├¡o 3                    | DLV-20260930-000003 |          112.33
 Punto de Compra Venecia 1                    | DLV-20260930-000004 |          138.29
 Punto de Compra El Banco 1                   | DLV-20260930-000005 |          256.42
 Punto de Compra Convenci├│n 1                 | DLV-20260930-000006 |          139.81
 Punto de Compra Ap├¡a 2                       | DLV-20260930-000007 |          404.97
 Punto de Compra El Tambo 1                   | DLV-20260930-000008 |          175.92
 Punto de Compra Anserma 1                    | DLV-20260930-000009 |           56.80

**/

/**
si la condición de fecha se pone en el WHERE, se ejecuta después del join y elimina las filas
donde T1.delivery_id es NULL. El RIGHT JOIN se comporta entonces como un INNER JOIN y los 
puntos de compra sin actividad desaparecen. En el ON, a fecha solo decide qué entregas se 
emparejan, y los puntos sin coincidencia se conservan con NULL.
**/
