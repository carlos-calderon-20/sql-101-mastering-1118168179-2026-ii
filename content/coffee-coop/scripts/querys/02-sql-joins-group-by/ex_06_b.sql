-- Exercise 06 - b
-- Pairs of farmers of 54518 with the same last name


SELECT
    T1.last_name AS last_name,
    T1.first_name || ' ' || T1.last_name AS farmer_a,
    T2.first_name || ' ' || T2.last_name AS farmer_b
FROM farm.farmers AS T1
INNER JOIN farm.farmers AS T2
    ON T1.last_name = T2.last_name
   AND T1.farmer_id < T2.farmer_id
WHERE T1.municipality_code = '54518'
  AND T2.municipality_code = '54518'
ORDER BY T1.last_name;

/**
 last_name          |            farmer_a            |          farmer_b
--------------------+--------------------------------+----------------------------
 Bastidas Rodr├¡guez | Alberto Bastidas Rodr├¡guez   | Antonio Bastidas Rodr├¡guez
 D├¡az Cu├®llar     | In├®s Luc├¡a D├¡az Cu├®llar    | Fabio D├¡az Cu├®llar
 Fl├│rez Gonz├ílez  | M├│nica Claudia Fl├│rez Gonz├ílez | Myriam Fl├│rez Gonz├ílez
 Mej├¡a Vera        | Nelson Samuel Mej├¡a Vera      | Elsa Mej├¡a Vera
 Valencia Moreno    | Teresa Adriana Valencia Moreno | Myriam Valencia Moreno
 **//
