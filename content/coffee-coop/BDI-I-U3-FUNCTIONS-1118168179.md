# Taller 3 — Fechas, Cadenas, Operaciones de Conjunto y Funciones en PostgreSQL

**Universidad de Pamplona** — Facultad de Ingenierías y Arquitectura — Programa de Ingeniería de Sistemas
**Asignatura:** Bases de Datos I 2026-2 — Prof. Juan Alejandro Carrillo Jaimes
**Estudiante:** [NOMBRE] — **Código:** [CODIGO]
**Base de datos:** `coffee_coop_db` — **Fecha de corte:** 30 de septiembre de 2026

---

## Notas de desarrollo

- El código de departamento de Norte de Santander es `54` (DANE), por eso se filtra con `T2.department_code = '54'` o con `municipality_code LIKE '54%'` cuando solo se usan tablas sin `geo.municipalities`.
- En el Ejercicio 5 se compara el nombre del departamento con `UPPER` en ambos lados.
- Los ejercicios 10 b) y c) usan la función creada en 10 a): ejecute primero ese archivo.

---


## Parte A — Manejo de fechas


### Ejercicio 1. CURRENT_DATE, NOW y AGE — Antigüedad de los asociados

#### Literal a)

*Archivo: `ex_01_a.sql`*

```sql
-- Exercise 01 - a
-- Farmers of Pamplona (54518): seniority in days up to today (CURRENT_DATE), oldest first
SELECT
    T1.document_number AS document,
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    T1.membership_date AS membership_date,
    CURRENT_DATE - T1.membership_date AS membership_days
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
ORDER BY T1.membership_date ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_01_b.sql`*

```sql
-- Exercise 01 - b
-- Top 10 oldest farmers of Pamplona (54518): seniority at 2026-09-30 with AGE and only the years with DATE_PART
SELECT
    T1.document_number AS document,
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    AGE(DATE '2026-09-30', T1.membership_date) AS membership_age,
    DATE_PART('year', AGE(DATE '2026-09-30', T1.membership_date)) AS membership_years
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
ORDER BY T1.membership_date ASC
LIMIT 10;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_01_c.sql`*

```sql
-- Exercise 01 - c
-- One row, no table: NOW() (timestamp) and CURRENT_DATE (date)
SELECT
    NOW() AS now_ts,
    CURRENT_DATE AS today;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación

**Diferencia entre `NOW()` y `CURRENT_DATE`.** `NOW()` devuelve un `timestamp with time zone`: la fecha *y* la hora del instante en que empezó la transacción. `CURRENT_DATE` devuelve solo la fecha (tipo `date`), sin hora.

**Por qué el literal a) cambia cada día y el b) no.** En el literal a) la antigüedad se calcula con `CURRENT_DATE - membership_date`, y `CURRENT_DATE` es la fecha del día en que se ejecuta la consulta: cada día que pasa, la resta da un día más. En el literal b) la antigüedad se calcula contra una fecha fija (`DATE '2026-09-30'`), que no depende de cuándo se ejecute, así que el resultado es siempre el mismo.


### Ejercicio 2. DATE_PART y GROUP BY — Edad de los asociados

#### Literal a)

*Archivo: `ex_02_a.sql`*

```sql
-- Exercise 02 - a
-- Top 10 oldest farmers of Pamplona (54518), age at 2026-09-30
SELECT
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    T1.birth_date AS birth_date,
    DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date)) AS age_years
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
ORDER BY T1.birth_date ASC
LIMIT 10;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_02_b.sql`*

```sql
-- Exercise 02 - b
-- Pamplona (54518): number of farmers and average age (years, 2 decimals) per gender, age at 2026-09-30
SELECT
    T1.gender AS gender,
    COUNT(T1.farmer_id) AS farmers_count,
    ROUND(AVG(DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date)))::NUMERIC, 2) AS avg_age_years
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
GROUP BY T1.gender
ORDER BY T1.gender ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_02_c.sql`*

```sql
-- Exercise 02 - c
-- Norte de Santander (department code 54): farmers and average age per municipality,
-- only municipalities whose average age is above 51 years (age at 2026-09-30)
SELECT
    T2.municipality_name AS municipality,
    COUNT(T1.farmer_id) AS farmers_count,
    ROUND(AVG(DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date)))::NUMERIC, 2) AS avg_age_years
FROM farm.farmers AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
GROUP BY T2.municipality_name
HAVING AVG(DATE_PART('year', AGE(DATE '2026-09-30', T1.birth_date))) > 51
ORDER BY T2.municipality_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*


### Ejercicio 3. EXTRACT — El calendario de las entregas

#### Literal a)

*Archivo: `ex_03_a.sql`*

```sql
-- Exercise 03 - a
-- September 2026 deliveries: count and gross weight per day of the week (0 = Sunday ... 6 = Saturday)
SELECT
    EXTRACT(dow FROM T1.delivered_at) AS day_of_week,
    COUNT(T1.delivery_id) AS deliveries_count,
    SUM(T1.gross_weight_kg) AS total_gross_kg
FROM buy.deliveries AS T1
WHERE EXTRACT(year FROM T1.delivered_at) = 2026
  AND EXTRACT(month FROM T1.delivered_at) = 9
GROUP BY EXTRACT(dow FROM T1.delivered_at)
ORDER BY EXTRACT(dow FROM T1.delivered_at) ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_03_b.sql`*

```sql
-- Exercise 03 - b
-- 2026 deliveries: count and gross weight per month
SELECT
    EXTRACT(month FROM T1.delivered_at) AS month_number,
    COUNT(T1.delivery_id) AS deliveries_count,
    SUM(T1.gross_weight_kg) AS total_gross_kg
FROM buy.deliveries AS T1
WHERE EXTRACT(year FROM T1.delivered_at) = 2026
GROUP BY EXTRACT(month FROM T1.delivered_at)
ORDER BY EXTRACT(month FROM T1.delivered_at) ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_03_c.sql`*

```sql
-- Exercise 03 - c
-- Deliveries of 2026-09-30: top 10 with the most hours between reception and analysis
SELECT
    T1.delivery_id AS delivery,
    T1.delivered_at AS delivered_at,
    T2.analyzed_at AS analyzed_at,
    ROUND((EXTRACT(epoch FROM (T2.analyzed_at - T1.delivered_at)) / 3600)::NUMERIC, 2) AS hours_to_analysis
FROM buy.deliveries AS T1
INNER JOIN buy.quality_analyses AS T2
    ON T1.delivery_id = T2.delivery_id
WHERE T1.delivered_at::DATE = DATE '2026-09-30'
ORDER BY hours_to_analysis DESC
LIMIT 10;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación (literal b)

> **Completar con el resultado obtenido en el literal b).**

- Meses con mayor peso bruto recibido en 2026: **[COMPLETAR según su salida]**.
- Relación con las cosechas: el café en la región se concentra en la **cosecha principal** (segundo semestre del año) y en la **mitaca** (cosecha secundaria, hacia el primer semestre). Compare los meses con más kilos de su salida con esos periodos y explique si coinciden. Recuerde que los datos llegan solo hasta el 30 de septiembre de 2026, por lo que octubre a diciembre no aparecen.


### Ejercicio 4. Fechas combinadas — Vigencia de las certificaciones

#### Literal a)

*Archivo: `ex_04_a.sql`*

```sql
-- Exercise 04 - a
-- Farms of Pamplona (54518): top 10 longest closed certification periods (end_date not null)
SELECT
    T3.farm_name AS farm,
    T2.certification_name AS certification,
    T1.start_date AS start_date,
    T1.end_date AS end_date,
    T1.end_date - T1.start_date AS duration_days,
    AGE(T1.end_date, T1.start_date) AS duration
FROM farm.farm_certifications AS T1
INNER JOIN farm.certifications AS T2
    ON T1.certification_id = T2.certification_id
INNER JOIN farm.farms AS T3
    ON T1.farm_id = T3.farm_id
WHERE T3.municipality_code = '54518'
  AND T1.end_date IS NOT NULL
ORDER BY duration_days DESC
LIMIT 10;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_04_b.sql`*

```sql
-- Exercise 04 - b
-- Farms of Pamplona (54518): active certifications (end_date null) with 2 or more years at 2026-09-30
SELECT
    T3.farm_name AS farm,
    T2.certification_name AS certification,
    T1.start_date AS start_date,
    DATE_PART('year', AGE(DATE '2026-09-30', T1.start_date)) AS years_active
FROM farm.farm_certifications AS T1
INNER JOIN farm.certifications AS T2
    ON T1.certification_id = T2.certification_id
INNER JOIN farm.farms AS T3
    ON T1.farm_id = T3.farm_id
WHERE T3.municipality_code = '54518'
  AND T1.end_date IS NULL
  AND DATE_PART('year', AGE(DATE '2026-09-30', T1.start_date)) >= 2
ORDER BY years_active DESC, T3.farm_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_04_c.sql`*

```sql
-- Exercise 04 - c
-- 2026 deliveries of weeks 36 to 40: count and first/last day of the year (doy) with data per week
SELECT
    EXTRACT(week FROM T1.delivered_at) AS week_number,
    COUNT(T1.delivery_id) AS deliveries_count,
    MIN(EXTRACT(doy FROM T1.delivered_at)) AS first_day_of_year,
    MAX(EXTRACT(doy FROM T1.delivered_at)) AS last_day_of_year
FROM buy.deliveries AS T1
WHERE EXTRACT(year FROM T1.delivered_at) = 2026
  AND EXTRACT(week FROM T1.delivered_at) BETWEEN 36 AND 40
GROUP BY EXTRACT(week FROM T1.delivered_at)
ORDER BY EXTRACT(week FROM T1.delivered_at) ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación

**Literal a) — duración de los certificados.** > **Completar con lo que observe en su salida** (por ejemplo: rango de duraciones en días y años, si varían mucho entre certificaciones, si las más largas coinciden con alguna certificación en particular, y qué dice la columna `duration` de `AGE` frente a `duration_days`).

**Literal c) — por qué la semana 40 tiene menos entregas.** La semana 40 de 2026 (semana ISO) va del lunes 28 de septiembre al domingo 4 de octubre, pero la base de datos solo tiene datos hasta el **30 de septiembre de 2026**. Por eso la semana 40 solo incluye tres días con datos (28, 29 y 30 de septiembre; días del año 271 a 273), mientras que las semanas 36 a 39 tienen sus siete días completos. Menos días con datos implica menos entregas.


## Parte B — Manejo de cadenas


### Ejercicio 5. UPPER, LOWER y LENGTH — Catálogos y búsquedas

#### Literal a)

*Archivo: `ex_05_a.sql`*

```sql
-- Exercise 05 - a
-- Coffee varieties: name in upper case, species in lower case and name length, longest first
SELECT
    UPPER(T1.variety_name) AS variety_upper,
    LOWER(T1.species) AS species,
    LENGTH(T1.variety_name) AS name_length
FROM farm.coffee_varieties AS T1
ORDER BY name_length DESC, T1.variety_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_05_b.sql`*

```sql
-- Exercise 05 - b
-- Municipality of Norte de Santander with the longest name (ties: first alphabetically)
-- UPPER on both sides because the department name may be stored in another case (see 05 - c)
SELECT
    T1.municipality_name AS municipality,
    LENGTH(T1.municipality_name) AS name_length
FROM geo.municipalities AS T1
INNER JOIN geo.departments AS T2
    ON T1.department_code = T2.department_code
WHERE UPPER(T2.department_name) = UPPER('Norte de Santander')
ORDER BY name_length DESC, T1.municipality_name ASC
LIMIT 1;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_05_c.sql`*

```sql
-- Exercise 05 - c
-- Department code and name, first comparing with the exact text 'Norte de Santander'
-- and then comparing both sides in upper case.

-- Query 1: exact comparison
SELECT
    T1.department_code AS code,
    T1.department_name AS department
FROM geo.departments AS T1
WHERE T1.department_name = 'Norte de Santander';


-- Query 2: case-insensitive comparison
SELECT
    T1.department_code AS code,
    T1.department_name AS department
FROM geo.departments AS T1
WHERE UPPER(T1.department_name) = UPPER('Norte de Santander');
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación (literal c)

La primera consulta no devuelve filas porque el operador `=` en PostgreSQL compara los textos **respetando mayúsculas y minúsculas**: el texto `'Norte de Santander'` no es igual a como está guardado el nombre en la tabla (por ejemplo, `'NORTE DE SANTANDER'`). La segunda consulta sí devuelve la fila porque `UPPER()` convierte **ambos lados** a mayúscula antes de comparar, por lo que la comparación ya no depende de cómo se escribió el texto.

> Verifique con su salida real cómo está guardado el nombre del departamento.


### Ejercicio 6. CONCAT y SUBSTRING — Armar y desarmar textos

#### Literal a)

*Archivo: `ex_06_a.sql`*

```sql
-- Exercise 06 - a
-- Women farmers (gender = 'F') of Pamplona (54518): short name (initial + '. ' + last names) and phone
SELECT
    CONCAT(SUBSTRING(T1.first_name FROM 1 FOR 1), '. ', T1.last_name) AS short_name,
    T1.phone_number AS phone
FROM farm.farmers AS T1
WHERE T1.gender = 'F'
  AND T1.municipality_code = '54518'
ORDER BY T1.last_name ASC, T1.first_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_06_b.sql`*

```sql
-- Exercise 06 - b
-- One sentence per collection point of Norte de Santander: '<point> recibe café en <municipality>'
SELECT
    CONCAT(T1.point_name, ' recibe café en ', T2.municipality_name) AS description
FROM buy.collection_points AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
ORDER BY T1.point_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_06_c.sql`*

```sql
-- Exercise 06 - c
-- Deliveries of 2026-09-30 at Punto de Compra Bochalema 1 (collection_point_id = 163):
-- full code and its parts (prefix, date, sequence) extracted with SUBSTRING. Code format: DLV-YYYYMMDD-NNNNNN
SELECT
    T1.delivery_id AS delivery,
    SUBSTRING(T1.delivery_id FROM 1 FOR 3) AS prefix,
    SUBSTRING(T1.delivery_id FROM 5 FOR 8) AS date_code,
    SUBSTRING(T1.delivery_id FROM 14 FOR 6) AS sequence_code,
    T1.delivered_at AS delivered_at
FROM buy.deliveries AS T1
WHERE T1.collection_point_id = 163
  AND T1.delivered_at::DATE = DATE '2026-09-30'
ORDER BY T1.delivery_id ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*


## Parte C — Operaciones de conjunto


### Ejercicio 7. UNION y UNION ALL — Directorio de contactos

#### Literal a)

*Archivo: `ex_07_a.sql`*

```sql
-- Exercise 07 - a
-- Single phone directory: farmers of Pamplona (54518) + collection points of Norte de Santander with a phone.
-- Norte de Santander = municipality codes starting with the department code 54.
SELECT
    'farmer' AS contact_type,
    CONCAT(T1.first_name, ' ', T1.last_name) AS contact_name,
    T1.phone_number AS phone
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
UNION
SELECT
    'collection_point',
    T2.point_name,
    T2.phone_number
FROM buy.collection_points AS T2
WHERE T2.phone_number IS NOT NULL
  AND T2.municipality_code LIKE '54%'
ORDER BY contact_type ASC, contact_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_07_b.sql`*

```sql
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
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación (literal b)

> **Completar el número de filas reales de cada versión.**

| Versión | Filas reportadas |
|---|---|
| `UNION` | **[N1]** |
| `UNION ALL` | **[N2]** |

`UNION` elimina los duplicados: devuelve cada código de municipio **una sola vez**, aunque varios asociados o varias fincas estén en el mismo municipio, y aunque el código aparezca en las dos consultas. `UNION ALL` conserva todos los registros: devuelve una fila por cada asociado más una fila por cada finca de Norte de Santander, con los códigos repetidos. Por eso `UNION ALL` tiene muchas más filas (N2 es la suma de los asociados y las fincas; N1 es el número de municipios distintos). La diferencia (N2 − N1) es el número de duplicados que `UNION` eliminó.


### Ejercicio 8. INTERSECT y EXCEPT — Comparar conjuntos

#### Literal a)

*Archivo: `ex_08_a.sql`*

```sql
-- Exercise 08 - a
-- Municipalities of Norte de Santander that have farms AND a collection point (INTERSECT)
SELECT
    T1.municipality_code AS municipality_code,
    T2.municipality_name AS municipality
FROM farm.farms AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
INTERSECT
SELECT
    T3.municipality_code,
    T4.municipality_name
FROM buy.collection_points AS T3
INNER JOIN geo.municipalities AS T4
    ON T3.municipality_code = T4.municipality_code
WHERE T4.department_code = '54'
ORDER BY municipality ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_08_b.sql`*

```sql
-- Exercise 08 - b
-- Municipalities of Norte de Santander with farms but WITHOUT a collection point (EXCEPT):
-- candidates to open new collection points
SELECT
    T1.municipality_code AS municipality_code,
    T2.municipality_name AS municipality
FROM farm.farms AS T1
INNER JOIN geo.municipalities AS T2
    ON T1.municipality_code = T2.municipality_code
WHERE T2.department_code = '54'
EXCEPT
SELECT
    T3.municipality_code,
    T4.municipality_name
FROM buy.collection_points AS T3
INNER JOIN geo.municipalities AS T4
    ON T3.municipality_code = T4.municipality_code
WHERE T4.department_code = '54'
ORDER BY municipality ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_08_c.sql`*

```sql
-- Exercise 08 - c
-- Farms of Pamplona (54518) that delivered coffee in 2025 but not in 2026 (EXCEPT)
SELECT
    T1.farm_name AS farm,
    T1.rural_district AS rural_district
FROM farm.farms AS T1
INNER JOIN buy.deliveries AS T2
    ON T1.farm_id = T2.farm_id
WHERE T1.municipality_code = '54518'
  AND EXTRACT(year FROM T2.delivered_at) = 2025
EXCEPT
SELECT
    T3.farm_name,
    T3.rural_district
FROM farm.farms AS T3
INNER JOIN buy.deliveries AS T4
    ON T3.farm_id = T4.farm_id
WHERE T3.municipality_code = '54518'
  AND EXTRACT(year FROM T4.delivered_at) = 2026
ORDER BY farm ASC, rural_district ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación (literal c)

`EXCEPT` **no es conmutativo**: devuelve lo que está en la primera consulta y no en la segunda. Si se invierte el orden, la consulta responde otra pregunta: en vez de las fincas que entregaron en 2025 pero no en 2026 (fincas que dejaron de entregar), devolvería las fincas que entregaron en 2026 pero no en 2025 (fincas nuevas o que regresaron). Los conjuntos resultantes son distintos.


## Parte D — Funciones definidas por el usuario (PL/pgSQL)


### Ejercicio 9. CREATE FUNCTION — Encapsular lógica reutilizable

#### Literal a)

*Archivo: `ex_09_a.sql`*

```sql
-- Exercise 09 - a
-- Function buy.fn_count_deliveries: number of deliveries received by a collection point (by name) on a date

CREATE OR REPLACE FUNCTION buy.fn_count_deliveries(p_point_name VARCHAR, p_date DATE)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM buy.deliveries AS T1
    INNER JOIN buy.collection_points AS T2
        ON T1.collection_point_id = T2.collection_point_id
    WHERE T2.point_name = p_point_name
      AND T1.delivered_at::DATE = p_date;
    RETURN v_total;
END;
$$;

-- Test: Punto de Compra Bochalema 1 on 2026-09-30
SELECT buy.fn_count_deliveries('Punto de Compra Bochalema 1', DATE '2026-09-30') AS deliveries_count;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_09_b.sql`*

```sql
-- Exercise 09 - b
-- Function farm.fn_age_years: age in whole years between two dates.
-- Top 10 farmers of Pamplona (54518) who joined youngest: age at 2026-09-30 and age at membership.

CREATE OR REPLACE FUNCTION farm.fn_age_years(p_birth_date DATE, p_reference_date DATE)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_age INT;
BEGIN
    SELECT DATE_PART('year', AGE(p_reference_date, p_birth_date)) INTO v_age;
    RETURN v_age;
END;
$$;

SELECT
    T1.document_number AS document,
    T1.first_name AS first_name,
    T1.last_name AS last_name,
    farm.fn_age_years(T1.birth_date, DATE '2026-09-30') AS age_years,
    farm.fn_age_years(T1.birth_date, T1.membership_date) AS age_at_membership
FROM farm.farmers AS T1
WHERE T1.municipality_code = '54518'
ORDER BY age_at_membership ASC
LIMIT 10;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_09_c.sql`*

```sql
-- Exercise 09 - c
-- Function farm.fn_short_name: initial (upper case) + '. ' + last names.
-- Men farmers (gender = 'M') of Pamplona (54518) with short name and phone.

CREATE OR REPLACE FUNCTION farm.fn_short_name(p_first_name VARCHAR, p_last_name VARCHAR)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    v_short_name VARCHAR;
BEGIN
    SELECT CONCAT(UPPER(SUBSTRING(p_first_name FROM 1 FOR 1)), '. ', p_last_name) INTO v_short_name;
    RETURN v_short_name;
END;
$$;

SELECT
    farm.fn_short_name(T1.first_name, T1.last_name) AS short_name,
    T1.phone_number AS phone
FROM farm.farmers AS T1
WHERE T1.gender = 'M'
  AND T1.municipality_code = '54518'
ORDER BY T1.last_name ASC, T1.first_name ASC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*


### Ejercicio 10. Integrador — Saldo pendiente de las liquidaciones

#### Literal a)

*Archivo: `ex_10_a.sql`*

```sql
-- Exercise 10 - a
-- Function pay.fn_settlement_balance: net amount of a settlement minus the sum of its payments.
-- A settlement without payments has as balance its whole net amount (COALESCE).

CREATE OR REPLACE FUNCTION pay.fn_settlement_balance(p_settlement_id VARCHAR)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    v_net NUMERIC;
    v_paid NUMERIC;
BEGIN
    SELECT T1.net_amount INTO v_net
    FROM pay.settlements AS T1
    WHERE T1.settlement_id = p_settlement_id;

    SELECT SUM(T1.amount) INTO v_paid
    FROM pay.payments AS T1
    WHERE T1.settlement_id = p_settlement_id;

    RETURN v_net - COALESCE(v_paid, 0);
END;
$$;

-- Test: settlement STL-20261001-000040
SELECT pay.fn_settlement_balance('STL-20261001-000040') AS balance_cop;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal b)

*Archivo: `ex_10_b.sql`*

```sql
-- Exercise 10 - b
-- Settlements of deliveries of 2026-09-30 that are not cancelled and still have a balance greater than 0,
-- using pay.fn_settlement_balance (created in ex_10_a.sql; run that file first)
SELECT
    T1.settlement_id AS settlement,
    T1.delivery_id AS delivery,
    T1.status AS settlement_status,
    T1.net_amount AS net_cop,
    pay.fn_settlement_balance(T1.settlement_id) AS balance_cop
FROM pay.settlements AS T1
INNER JOIN buy.deliveries AS T2
    ON T1.delivery_id = T2.delivery_id
WHERE T2.delivered_at::DATE = DATE '2026-09-30'
  AND T1.status <> 'cancelled'
  AND pay.fn_settlement_balance(T1.settlement_id) > 0
ORDER BY balance_cop DESC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

#### Literal c)

*Archivo: `ex_10_c.sql`*

```sql
-- Exercise 10 - c
-- Per collection point: number of non-cancelled settlements of deliveries of 2026-09-30 and total pending
-- balance (function inside SUM), only points with balance > 0 (function created in ex_10_a.sql)
SELECT
    T3.point_name AS collection_point,
    COUNT(T1.settlement_id) AS settlements_count,
    SUM(pay.fn_settlement_balance(T1.settlement_id)) AS total_balance_cop
FROM pay.settlements AS T1
INNER JOIN buy.deliveries AS T2
    ON T1.delivery_id = T2.delivery_id
INNER JOIN buy.collection_points AS T3
    ON T2.collection_point_id = T3.collection_point_id
WHERE T2.delivered_at::DATE = DATE '2026-09-30'
  AND T1.status <> 'cancelled'
GROUP BY T3.point_name
HAVING SUM(pay.fn_settlement_balance(T1.settlement_id)) > 0
ORDER BY total_balance_cop DESC;
```

**Salida en PostgreSQL:**

> *[Pegar aquí el screenshot de la salida]*

### Explicación

**Sin `COALESCE`.** Si una liquidación no tiene pagos, `SUM(T1.amount)` no encuentra filas y devuelve `NULL`, de modo que `v_paid` queda en `NULL`. Cualquier operación aritmética con `NULL` da `NULL`, así que `v_net - v_paid` devolvería `NULL` en lugar del valor neto completo. `COALESCE(v_paid, 0)` cambia ese `NULL` por 0 y la función devuelve correctamente `v_net`.

**Ejecutar dos veces el mismo `CREATE OR REPLACE FUNCTION`.** No genera error: la segunda ejecución **reemplaza** la definición existente por la misma, de modo que queda una sola función con ese nombre y esa firma. Esa es la diferencia con `CREATE FUNCTION` (sin `OR REPLACE`), que fallaría porque la función ya existe. Si se cambian el tipo de retorno o los tipos de los parámetros, PostgreSQL no lo permite con `OR REPLACE` y hay que usar antes `DROP FUNCTION`.
