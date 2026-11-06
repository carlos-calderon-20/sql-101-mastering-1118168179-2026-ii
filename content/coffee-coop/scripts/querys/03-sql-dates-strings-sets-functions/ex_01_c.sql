-- Exercise 01 - c
-- NOW() vs CURRENT_DATE


SELECT
    NOW() AS now_ts,
    CURRENT_DATE AS today;

/**
            now_ts             |   today
-------------------------------+------------
 2026-11-05 23:52:00.011421-05 | 2026-11-05

 **/

 /**
 NOW() devuelve un TIMESTAMP WITH TIME ZONE: la
  fecha y la hora exactas del momento en que se
  ejecuta la consulta. CURRENT_DATE devuelve solo 
  la fecha (tipo DATE), sin hora. El literal a) 
  cambia cada día porque resta la fecha de hoy 
  (CURRENT_DATE) a la fecha de afiliación: cada 
  día que pasa suma un día más de antigüedad. El literal b) 
  no cambia porque calcula la antigüedad contra una fecha fija 
  (DATE '2026-09-30'), que no depende del momento de ejecución.
  **/
  