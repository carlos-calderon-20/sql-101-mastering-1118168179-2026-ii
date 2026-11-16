-- Exercise 09 - c
-- Function farm.fn_short_name: initial (upper case) + '. ' + last names.
-- Men farmers (gender = 'M') of Pamplona (54518) with short name and phone.

CREATE OR REPLACE FUNCTION farm.fn_short_name(p_first_name VARCHAR, p_last_name VARCHAR)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    v_short_name VARCHAR;
BEGIN
    SELECT CONCAT(UPPER(SUBSTRING(p_first_name FROM 1 FOR 1)), '. ', p_last_name) INTO v_short_name;
    RETURN v_short_name;
END;
$$;

SELECT
    farm.fn_short_name(T1.first_name, T1.last_name) AS short_name,
    T1.phone_number AS phone
FROM farm.farmers AS T1
WHERE T1.gender = 'M'
  AND T1.municipality_code = '54518'
ORDER BY T1.last_name ASC, T1.first_name ASC;

/*
 short_name       |   phone
-----------------------+------------
 M. Agudelo Jim├®nez    | 3219718862
 A. ├ülvarez Villamizar | 3025342853
 A. Arango Silva       | 3053453318
 C. Arias Mora         | 3045535545
 G. Arias Rodr├¡guez    | 3131845672
 R. Barrera Villamizar | 3056539829
 A. Bastidas Rodr├¡guez | 3145736315
 A. Bastidas Rodr├¡guez | 3508682050
 N. Bedoya V├®lez       | 3194564518
 I. Berm├║dez Fl├│rez    | 3139698870
 R. Berm├║dez Mu├▒oz     | 3051351571
 E. Berm├║dez Rojas     | 3142064892
*/
