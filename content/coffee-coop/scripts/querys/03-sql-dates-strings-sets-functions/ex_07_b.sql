-- Exercise 07 - b
-- Municipality codes of Norte de Santander where a farmer lives, joined with the codes where a farm is.
-- Written twice: UNION (removes duplicates) and UNION ALL (keeps them).

-- Query 1: UNION
SELECT
    T1.municipality_code AS municipality_code
FROM farm.farmers AS T1
WHERE T1.municipality_code LIKE '54%'
UNION
SELECT
    T2.municipality_code
FROM farm.farms AS T2
WHERE T2.municipality_code LIKE '54%'
ORDER BY municipality_code ASC;

/*
 municipality_code
-------------------
 54001
 54003
 54051
 54099
 54109
 54125
 54128
*/

-- Query 2: UNION ALL
SELECT
    T1.municipality_code AS municipality_code
FROM farm.farmers AS T1
WHERE T1.municipality_code LIKE '54%'
UNION ALL
SELECT
    T2.municipality_code
FROM farm.farms AS T2
WHERE T2.municipality_code LIKE '54%'
ORDER BY municipality_code ASC;

/*
municipality_code
-------------------
 54001
 54001
 54001
 54001
 54001
 54001
*/
