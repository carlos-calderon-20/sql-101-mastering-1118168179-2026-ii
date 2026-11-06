-- Exercise 02 - a
-- All farmers of 54518, including those without a farm


SELECT
    T1.document_number AS document,
    T1.first_name      AS first_name,
    T1.last_name       AS last_name,
    T2.farm_name       AS farm
FROM farm.farmers T1
LEFT JOIN farm.farms AS T2
    ON T1.farmer_id = T2.farmer_id
WHERE T1.municipality_code = '54518';


/**
 document  |    first_name     |     last_name      |       farm
------------+-------------------+--------------------+------------------
 1061690671 | Guillermo Pedro   | Arias Rodr├¡guez    | La Selva
 712758473  | Wilson            | L├│pez Villamizar   | El Silencio
 134410171  | Orlando           | Salazar Berm├║dez   | El Diamante
 870240973  | Jairo             | Molina Pab├│n       | El Recuerdo
 727945493  | Gloria            | Mar├¡n Rivera       | La Esperanza
 549054771  | Mar├¡a             | Burbano Duarte     | El Nogal
 549054771  | Mar├¡a             | Burbano Duarte     | La Divisa
 622105662  | Alejandra         | Molina Torres      | La Carolina
 622105662  | Alejandra         | Molina Torres      | La Cristalina
 **/
 