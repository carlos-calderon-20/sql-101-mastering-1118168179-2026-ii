-- Exercise 05 - b
-- Incomplete rows: analysis without settlement or settlement without analysis

SELECT
    T1.analysis_id AS analysis,
    T1.is_accepted AS accepted,
    T2.settlement_id AS settlement,
    T2.status AS settlement_status
FROM buy.quality_analyses AS T1
FULL JOIN pay.settlements AS T2
    ON T1.delivery_id = T2.delivery_id
WHERE (T1.delivery_id LIKE 'DLV-20260930-%'
   OR T2.delivery_id LIKE 'DLV-20260930-%')
  AND (T1.analysis_id IS NULL OR T2.settlement_id IS NULL);

  /**

analysis      | accepted       | settlement | settlement_status
--------------------+----------+------------+-------------------
 QA-20260930-000020 | t        |            |
 QA-20260930-000054 | t        |            |
 QA-20260930-000025 | f        |            |
 QA-20260930-000095 | t        |            |
 QA-20260930-000101 | t        |            |
 QA-20260930-000090 | t        |            |
 QA-20260930-000071 | t        |            |
 QA-20260930-000135 | t        |            |

**/

/**
las filas con análisis y sin liquidación tienen sentido cuando el análisis 
no fue aceptado (is_accepted = false): si el café se rechaza, no hay nada 
que pagar y por eso no se genera liquidación. En cambio, un análisis aceptado 
sin liquidación sería una anomalía, y una liquidación sin análisis previo 
siempre sería una inconsistencia, porque no se debería pagar café sin haberlo analizado
**/
