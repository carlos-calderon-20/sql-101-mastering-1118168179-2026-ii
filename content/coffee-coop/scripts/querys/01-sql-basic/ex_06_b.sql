-- Exercise 06 b
-- Farmers of Pamplona (54518) without email

SELECT
    T1.document_number AS document,
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    T1.email AS email
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
AND T1.email IS NULL;

/**
document  |    first_name    |     last_name      | email
------------+------------------+--------------------+-------
 712758473  | Wilson           | L¾pez Villamizar   |
 727945493  | Gloria           | MarÝn Rivera       |
 549054771  | MarÝa            | Burbano Duarte     |
 24999630   | Esperanza        | Romero Betancur    |
 914044314  | AncÝzar Cristian | PolanÝa Delgado    |
 343256743  | Dora             | Hernßndez Correa   |
 1148351420 | InÚs             | JimÚnez Jaimes     |
 1117597835 | Cecilia Lorena   | DÝaz GarcÝa        |
 749444168  | Emilio           | Delgado Molina     |
 940051048  | David Germßn     | Romero Bonilla     |
 548464915  | Yuliana          | RodrÝguez Vargas   |
 554620706  | Nelson Samuel    | MejÝa Vera         |
 59388780   | Juan             | Ortega Zapata      |
 1171130241 | Elsa             | MejÝa Vera         |
 824422301  | Hernando         | Montoya Agudelo    |
 21358854   | Manuela Yolanda  | Benavides Delgado  |
 1185523747 | Elsa             | Ibarra Molina      |
 131166207  | Jaime            | MarÝn Hernßndez    |
 35147265   | Carlos           | GutiÚrrez Pab¾n    |
 712500733  | Esperanza        | Valencia Ortiz     |
 922724022  | Esteban          | Salazar Parra      |
 1135293825 | Abelardo         | PÚrez Castro       |
 939635303  | Marleny          | ┴lvarez Correa     |
 549847293  | Wilmer           | PÚrez Chamorro     |
 1189704117 | Mariana          | Ortiz Ruiz         |
 599185252  | EfraÝn           | Pinz¾n Cabrera     |
 33787285   | RubÚn            | Ramos Chamorro     |
 **/