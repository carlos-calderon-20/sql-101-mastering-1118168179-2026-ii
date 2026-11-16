-- Exercise 06 - a
-- Women farmers (gender = 'F') of Pamplona (54518): short name (initial + '. ' + last names) and phone
SELECT
    CONCAT(SUBSTRING(T1.first_name FROM 1 FOR 1), '. ', T1.last_name) AS short_name,
    T1.phone_number AS phone
FROM farm.farmers AS T1
WHERE T1.gender = 'F'
  AND T1.municipality_code = '54518'
ORDER BY T1.last_name ASC, T1.first_name ASC;

/*
 short_name      |   phone
----------------------+------------
 M. Agudelo Sandoval  | 3242280898
 E. ┴lvarez Bonilla   | 3236902029
 R. ┴lvarez Cßrdenas  | 3047898372
 M. ┴lvarez Carrillo  | 3059237130
 M. ┴lvarez Correa    | 3232410671
 M. Arango Narvßez    | 3178267449
 E. Arias ┴lvarez     | 3213658326
 V. Arias RamÝrez     | 3204850778
 I. Barrera Cabrera   | 3041744702
*/
