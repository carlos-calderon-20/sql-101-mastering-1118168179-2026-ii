-- Exercise 05 - a
-- Analyses vs settlements for deliveries of 2026-09-30


SELECT
    T1.analysis_id       AS analysis,
    T1.is_accepted       AS accepted,
    T2.settlement_id     AS settlement,
    T2.status            AS settlement_status
FROM buy.quality_analyses AS T1
FULL JOIN pay.settlements AS T2
    ON T1.delivery_id = T2.delivery_id
WHERE T1.delivery_id LIKE 'DLV-20260930-%'
   OR T2.delivery_id LIKE 'DLV-20260930-%';

/**
 analysis      | accepted |     settlement      | settlement_status
--------------------+----------+---------------------+-------------------
 QA-20260930-000007 | t        | STL-20261002-000005 | paid
 QA-20260930-000013 | t        |                     |
 QA-20260930-000023 | t        |                     |
 QA-20260930-000049 | t        |                     |
 QA-20260930-000011 | t        |                     |
 QA-20260930-000066 | t        | STL-20261001-000041 | cancelled
 QA-20260930-000081 | t        |                     |
 QA-20260930-000062 | t        | STL-20261001-000057 | pending
 **/
 