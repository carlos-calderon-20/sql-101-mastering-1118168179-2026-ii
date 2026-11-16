-- Exercise 03 - c
-- Deliveries of 2026-09-30: top 10 with the most hours between reception and analysis
SELECT
    T1.delivery_id AS delivery,
    T1.delivered_at AS delivered_at,
    T2.analyzed_at AS analyzed_at,
    ROUND((EXTRACT(epoch FROM (T2.analyzed_at - T1.delivered_at)) / 3600)::NUMERIC, 2) AS hours_to_analysis
FROM buy.deliveries AS T1
INNER JOIN buy.quality_analyses AS T2
    ON T1.delivery_id = T2.delivery_id
WHERE T1.delivered_at::DATE = DATE '2026-09-30'
ORDER BY hours_to_analysis DESC
LIMIT 10;

/*
-- PEGAR AQUI EL RESULTADO
(10 rows)
*/
