-- Exercise 09 - b
-- Function farm.fn_age_years: age in whole years between two dates.
-- Top 10 farmers of Pamplona (54518) who joined youngest: age at 2026-09-30 and age at membership.

CREATE OR REPLACE FUNCTION farm.fn_age_years(p_birth_date DATE, p_reference_date DATE)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_age INT;
BEGIN
    SELECT DATE_PART('year', AGE(p_reference_date, p_birth_date)) INTO v_age;
    RETURN v_age;
END;
$$;

SELECT
    T1.document_number AS document,
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    farm.fn_age_years(T1.birth_date, DATE '2026-09-30') AS age_years,
    farm.fn_age_years(T1.birth_date, T1.membership_date) AS age_at_membership
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
ORDER BY age_at_membership ASC
LIMIT 10;

/*
 document  |   first_name   |     last_name     | age_years | age_at_membership
------------+----------------+-------------------+-----------+-------------------
 92240743   | Mario          | R├¡os Ibarra       |        27 |                18
 1180237528 | ├üngela Beatriz | Sandoval Berm├║dez |        29 |                18
 571748382  | Marleny        | Pinz├│n Delgado    |        35 |                18
 333176982  | Edilma         | Rivera Rivera     |        30 |                18
 1090968710 | Ruth           | Rodr├¡guez P├®rez   |        34 |                18
 455264704  | Valentina      | Mora Rangel       |        26 |                18
 211924295  | ├ülvaro         | Valencia Rivera   |        30 |                18
 700421194  | Teresa         | Torres Giraldo    |        27 |                18
 463842401  | Roc├¡o          | ├ülvarez C├írdenas  |        26 |                18
 1196615388 | Fernando       | Burbano Fl├│rez    |        27 |                18
*/
