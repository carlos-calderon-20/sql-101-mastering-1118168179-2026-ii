-- Exercise 09 b
-- Quality analyses of 2026-09-30 with moisture outside the 10%-12% range

SELECT
    T1.analysis_id AS analysis,
    T1.delivery_id AS delivery,
    T1.moisture_pct AS moisture_pct,
    T1.analyst_name AS analyst_name,
    T1.observations AS observations
FROM buy.quality_analyses AS T1
WHERE T1.analysis_id LIKE 'QA-20260930-%'
AND T1.moisture_pct NOT BETWEEN 10 AND 12;

/**
  analysis      |      delivery       | moisture_pct |    analyst_name    |                          observations
--------------------+---------------------+--------------+--------------------+-----------------------------------------------------------------
 QA-20260930-000023 | DLV-20260930-000046 |        12.23 | Alejandra Torres   | Caf├® de buena presentaci├│n, sin olores extra├▒os.
 QA-20260930-000026 | DLV-20260930-000005 |        12.19 | Wilson Galvis      |
 QA-20260930-000018 | DLV-20260930-000006 |        17.24 | Nicol├ís Serrano    | Caf├® con humedad alta, requiere m├ís secado.
 QA-20260930-000017 | DLV-20260930-000012 |        12.15 | Natalia Trujillo   |
 QA-20260930-000033 | DLV-20260930-000027 |        12.41 | Sara S├ínchez       |
 QA-20260930-000013 | DLV-20260930-000038 |        12.28 | Adriana Losada     |
 QA-20260930-000005 | DLV-20260930-000040 |        12.22 | Iv├ín Castro        |
 QA-20260930-000027 | DLV-20260930-000043 |        12.07 | Germ├ín Gonz├ílez    | Caficultor solicita contramuestra.
 QA-20260930-000102 | DLV-20260930-000155 |        12.31 | Adriana Losada     |
 QA-20260930-000085 | DLV-20260930-000161 |        12.03 | Carlos Ospina      | Muestra limpia, color homog├®neo.
 QA-20260930-000068 | DLV-20260930-000165 |        16.13 | Germ├ín Pe├▒a        | Muestra tomada por duplicado.
 QA-20260930-000093 | DLV-20260930-000178 |        12.11 | Nicol├ís Serrano    | Humedad en el l├¡mite superior, se recomienda mejorar el secado.
 QA-20260930-000121 | DLV-20260930-000200 |        12.38 | Guillermo Acevedo  |
 QA-20260930-000104 | DLV-20260930-000214 |        17.68 | Carolina Rodr├¡guez | Olor a fermento en la muestra.
 QA-20260930-000113 | DLV-20260930-000223 |         9.57 | Reinaldo Berm├║dez  | Caf├® sobresecado, grano quebradizo.
 QA-20260930-000094 | DLV-20260930-000227 |        12.43 | Ruth Polan├¡a       |
 QA-20260930-000134 | DLV-20260930-000236 |        12.48 | Gloria Restrepo    |
 QA-20260930-000119 | DLV-20260930-000253 |         8.39 | An├¡bal Pab├│n       | Exceso de impurezas y pasilla.
 QA-20260930-000105 | DLV-20260930-000260 |        12.01 | Daniel Betancur    |
 QA-20260930-000109 | DLV-20260930-000272 |        12.18 | Jaime Ortega       |
 QA-20260930-000145 | DLV-20260930-000277 |        12.27 | Reinaldo Berm├║dez  | Muestra tomada por duplicado.
 QA-20260930-000149 | DLV-20260930-000286 |        12.28 | Germ├ín Pe├▒a        |
 **/