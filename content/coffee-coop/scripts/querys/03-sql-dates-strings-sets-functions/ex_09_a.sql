-- Exercise 09 - a
-- Function buy.fn_count_deliveries: number of deliveries received by a collection point (by name) on a date

CREATE OR REPLACE FUNCTION buy.fn_count_deliveries(p_point_name VARCHAR, p_date DATE)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM buy.deliveries AS T1
    INNER JOIN buy.collection_points AS T2
        ON T1.collection_point_id = T2.collection_point_id
    WHERE T2.point_name = p_point_name
      AND T1.delivered_at::DATE = p_date;
    RETURN v_total;
END;
$$;

-- Test: Punto de Compra Bochalema 1 on 2026-09-30
SELECT buy.fn_count_deliveries('Punto de Compra Bochalema 1', DATE '2026-09-30') AS deliveries_count;

/*
 deliveries_count
------------------
                4
*/
