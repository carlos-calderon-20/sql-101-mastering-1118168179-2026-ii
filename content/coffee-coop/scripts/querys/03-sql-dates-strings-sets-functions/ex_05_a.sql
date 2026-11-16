-- Exercise 05 - a
-- Coffee varieties: name in upper case, species in lower case and name length, longest first
SELECT
    UPPER(T1.variety_name) AS variety_upper,
    LOWER(T1.species) AS species,
    LENGTH(T1.variety_name) AS name_length
FROM farm.coffee_varieties AS T1
ORDER BY name_length DESC, T1.variety_name ASC;

/*
 variety_upper | species | name_length
---------------+---------+-------------
 BORBËN ROSADO | arabica |          13
 CENICAF╔ 1    | arabica |          10
 MARAGOGIPE    | arabica |          10
 CASTILLO      | arabica |           8
 COLOMBIA      | arabica |           8
 PACAMARA      | arabica |           8
 CATURRA       | arabica |           7
 ROBUSTA       | robusta |           7
 BORBËN        | arabica |           6
 GEISHA        | arabica |           6
 T═PICA        | arabica |           6
 TABI          | arabica |           4
*/
