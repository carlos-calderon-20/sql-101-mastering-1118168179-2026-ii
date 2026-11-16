-- Exercise 03 - a
-- September 2026 deliveries: count and gross weight per day of the week (0 = Sunday ... 6 = Saturday)
SELECT
    EXTRACT(dow FROM T1.delivered_at) AS day_of_week,
    COUNT(T1.delivery_id) AS deliveries_count,
    SUM(T1.gross_weight_kg) AS total_gross_kg
FROM buy.deliveries AS T1
WHERE EXTRACT(year FROM T1.delivered_at) = 2026
  AND EXTRACT(month FROM T1.delivered_at) = 9
GROUP BY EXTRACT(dow FROM T1.delivered_at)
ORDER BY EXTRACT(dow FROM T1.delivered_at) ASC;

/*
-- PEGAR AQUI EL RESULTADO
*/
