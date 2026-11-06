-- Exercise 03  b
-- Collection points with no deliveries on 2026-09-30


SELECT
    T2.point_name AS collection_point,
    T1.delivery_id           AS delivery,
    T1.gross_weight_kg       AS gross_weight_kg
FROM buy.deliveries AS T1
RIGHT JOIN buy.collection_points AS T2
    ON T1.collection_point_id = T2.collection_point_id
   AND T1.delivery_id LIKE 'DLV-20260930-%'
WHERE T1.delivery_id IS NULL;


/**
 collection_point           | delivery | gross_weight_kg
--------------------------------------+----------+-----------------
 Punto de Compra Tesalia 3            |          |
 Punto de Compra Marulanda 1          |          |
 Punto de Compra Gu├ítica 2            |          |
 Punto de Compra Chin├ícota 1          |          |
 Punto de Compra El Tambo 2           |          |
 Punto de Compra La Argentina 1       |          |
 Punto de Compra Hobo 1               |          |
 **/
 