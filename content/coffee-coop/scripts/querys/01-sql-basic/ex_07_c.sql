-- Exercise 07 c
-- Farms of Pamplona (54518) without coordinates (latitude or longitude null)

SELECT
    T1.farm_name AS farm,
    T1.rural_district AS rural_district,
    T1.latitude AS latitude,
    T1.longitude AS longitude
FROM farm.farms AS T1
WHERE T1.municipality_code = '54518'
AND (T1.latitude IS NULL OR T1.longitude IS NULL);

/**
    farm       |    rural_district    | latitude | longitude
------------------+----------------------+----------+-----------
 El Recuerdo      | Alto Grande          |          |
 La Esperanza     | El Palchal           |          |
 Las Delicias     | Caima                |          |
 Los Arrayanes    | Cabecera Municipal   |          |
 El Brillante     | Pe├▒as                |          |
 El Porvenir      | Fontib├│n             |          |
 La Florida       | Pe├▒as                |          |
 Los Arrayanes    | Navarro              |          |
 El Guayabo       | San Francisco        |          |
 El Encanto       | Fontib├│n             |          |
 Cafetal Viejo    | San Jos├® De Tonchala |          |
 El Vergel        | Cabecera Municipal   |          |
 El Higuer├│n      | Caima                |          |
 Bella Vista Alta | El Rosal             |          |
 El Horizonte     | San Jos├® De Tonchala |          |
 La Esperanza     | Pe├▒as                |          |
 El Mes├│n         | Iscaligua            |          |
 Las Mercedes     | Llano Castro         |          |
 Las Orqu├¡deas    | Sabaneta Baja        |          |
 La Uni├│n         | La Legua             |          |
 San Antonio      | Jurado               |          |
 San Luis         | Sabaneta Alta        |          |
 El Danubio       | Garc├¡a               |          |
 Tierra Linda     | Lengua               |          |
 Tierra Linda     | Iscaligua            |          |
 Los Laureles     | Pe├▒as                |          |
 Bella Vista Alta | Sabaneta Baja        |          |
 **/