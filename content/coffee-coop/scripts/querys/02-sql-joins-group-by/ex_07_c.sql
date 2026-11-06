-- Exercise 07 - c


SELECT
    COUNT(*) AS total_farmers,
    COUNT(T1.email) AS farmers_with_email
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518';

/**
 total_farmers | farmers_with_email
---------------+--------------------
           230 |                165
**/

/**
COUNT(*) cuenta todas las filas del grupo, 
sin importar su contenido, mientras que 
COUNT(columna) cuenta solo las filas donde esa 
columna no es NULL. Los dos conteos difieren porque 
hay asociados sin correo registrado (email es NULL)
**/
