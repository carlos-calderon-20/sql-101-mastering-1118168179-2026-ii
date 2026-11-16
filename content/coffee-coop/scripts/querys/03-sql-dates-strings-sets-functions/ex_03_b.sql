-- Exercise 03 - b
-- 2026 deliveries: count and gross weight per month
SELECT
    EXTRACT(month FROM T1.delivered_at) AS month_number,
    COUNT(T1.delivery_id) AS deliveries_count,
    SUM(T1.gross_weight_kg) AS total_gross_kg
FROM buy.deliveries AS T1
WHERE EXTRACT(year FROM T1.delivered_at) = 2026
GROUP BY EXTRACT(month FROM T1.delivered_at)
ORDER BY EXTRACT(month FROM T1.delivered_at) ASC;

/*
-- PEGAR AQUI EL RESULTADO
*/
