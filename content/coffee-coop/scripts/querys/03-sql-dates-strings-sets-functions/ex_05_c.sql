-- Exercise 05 - c
-- Department code and name, first comparing with the exact text 'Norte de Santander'
-- and then comparing both sides in upper case.

-- Query 1: exact comparison
SELECT
    T1.department_code AS code,
    T1.department_name AS department
FROM geo.departments AS T1
WHERE T1.department_name = 'Norte de Santander';

/*
 code | department
------+------------
*/

-- Query 2: case-insensitive comparison
SELECT
    T1.department_code AS code,
    T1.department_name AS department
FROM geo.departments AS T1
WHERE UPPER(T1.department_name) = UPPER('Norte de Santander');

/*
code |     department
------+--------------------
 54   | Norte De Santander
*/
