-- Exercise 01 b
-- Farms of municipality 54518 with municipality and farmer names


SELECT
    T1.farm_name AS farm,
    T1.rural_district AS rural_district,
    T2.municipality_name AS municipality,
    T3.first_name AS first_name,
    T3.last_name AS last_name
FROM farm.farms T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
INNER JOIN farm.farmers AS T3
    ON T1.farmer_id = T3.farmer_id
WHERE T1.municipality_code = '54518'
ORDER BY T3.last_name;


/**
farm       |    rural_district    | municipality |     first_name     |      last_name
------------------+----------------------+--------------+--------------------+---------------------
 El Jard├¡n        | El Escorial          | Pamplona     | Manuel             | Agudelo Jim├®nez
 La Selva         | Pe├▒as                | Pamplona     | Manuel             | Agudelo Jim├®nez
 El Diamante      | El Alizal            | Pamplona     | Marleny            | Agudelo Sandoval
 El Encanto       | Fontib├│n             | Pamplona     | Roc├¡o              | ├ülvarez C├írdenas
 Bellavista       | Alto Grande          | Pamplona     | Roc├¡o              | ├ülvarez C├írdenas
 La Caba├▒a        | Lengua               | Pamplona     | M├│nica             | ├ülvarez Carrillo
 Monteverde       | Lengua               | Pamplona     | M├│nica             | ├ülvarez Carrillo
 El Array├ín       | Navarro              | Pamplona     | Marleny            | ├ülvarez Correa
 El Mango         | La Legua             | Pamplona     | Alberto            | ├ülvarez Villamizar
 Monteverde       | La Legua             | Pamplona     | Myriam Yuliana     | Arango Narv├íez
 El Recuerdo      | La Legua             | Pamplona     | Anc├¡zar            | Arango Silva
 El Rosal         | Navarro              | Pamplona     | Edilma Gabriela    | Arias ├ülvarez
 Monteverde       | El Palchal           | Pamplona     | Edilma Gabriela    | Arias ├ülvarez
 Las Delicias     | Sabagua              | Pamplona     | Camilo             | Arias Mora
 La Quebrada      | Navarro              | Pamplona     | Viviana            | Arias Ram├¡rez
 **/