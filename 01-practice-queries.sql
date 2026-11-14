
/*
============================================================
SQL Toolbox - Examples of applied solutions


### Environment Best Practices and code examples:
1. T-SQL code examples 
	1.001: active units machines selection
	1.002: ranked retail unit with largest turnover selection
2. Training: Hands on challenge with "stratascratch.com" sql path, progress: (67% completed)
    - # direct link to the training
    - https://www.stratascratch.com/learn/comprehensive-sql
============================================================
*/
   /* 
   ============================================================================
   SQL STUDY LOG & QUERY PROGRESS RECORD 
   ============================================================================
   STRATASCRATCH INDEX (NEWEST LESSONS FIRST)
   ----------------------------------------------------------------------------
   Course Lessons:
   - 2.025 : Multiple CTEs (Chained CTE Pipeline)
   - 2.024 : Common Table Expressions (Single CTE)
   - 2.019 : Multiple Joins & Hierarchy Aggregation
   - 2.018 : Self-Join (Comparing Rows Within Same Table)
   - 2.017 : Anti-Join (LEFT JOIN + WHERE IS NULL)
   - 2.016 : Multi-Key JOIN & UNION vs UNION ALL
   - 2.013 : Query Building Sequence & Decimal Averaging
   - 2.012 : Conditional Aggregation (CASE WHEN) & NULLIF / Division
   - 2.011 : HAVING & SQL Execution Order
   - 2.010 : GROUP BY & ORDER BY Rules
   - 2.009 : Aggregate Functions
   - 2.008 : LIMIT, TOP, FETCH & OFFSET (Dialect Differences)
   - 2.007 : ORDER BY, String Length & NULL Sorting
   - 2.006 : NULL Handling, Three-Valued Logic & COALESCE
   - 2.005 : LIKE Wildcards, IN / NOT IN & Date Ranges (BETWEEN)
   - 2.004 : Logical Operator Precedence (AND vs OR)

   Other Hands-On Examples:
   - 1.002 : Top 10 Vending Locations by Turnover (Chained CTEs + DENSE_RANK)
   - 1.001 : Active Retail Unit Utilization by City (Single CTE + INNER JOIN)

============================================================================ */


-- ============================================================================
-- 2.025 — Multiple CTEs (Chained CTE Pipeline)
-- ============================================================================
-- Core Concept: Break complex multi-step transformations into sequential,
-- readable blocks using a single WITH keyword and comma-separated CTEs.
-- Gotchas:
--   * Use ONLY ONE "WITH" keyword at the very start; separate CTEs with commas.
--   * Order matters: a CTE can reference any CTE defined before it, never after.

-- Generic multi-CTE template:
/*
WITH first_cte AS (      -- 1. What data do I need first?
    SELECT ...
),
second_cte AS (          -- 2. What calculation depends on that?
    SELECT ...
    FROM first_cte
),
third_cte AS (           -- 3. What filtering or joining comes next?
    SELECT ...
    FROM second_cte
)
SELECT *                 -- 4. What is the final output?
FROM third_cte;
*/

-- Exercise: Total compensation (salary + bonus) by title and gender
WITH tot_bonus AS (
    SELECT
        b.worker_ref_id AS ref_id,
        SUM(b.bonus) AS tot_bonus
    FROM sf_bonus b
    GROUP BY b.worker_ref_id
),
E_w_tot_bonus AS (
    SELECT
        e.id,
        e.employee_title AS title,
        e.salary,
        e.sex AS gender,
        tb.tot_bonus
    FROM sf_employee e
    INNER JOIN tot_bonus tb
        ON e.id = tb.ref_id
),
avg_tot AS (
    SELECT
        title,
        gender,
        COUNT(id) AS empl_count,
        SUM(COALESCE(salary, 0) + COALESCE(tot_bonus, 0)) AS grand_tot
    FROM E_w_tot_bonus
    GROUP BY title, gender
)
SELECT
    title,
    gender,
    grand_tot / empl_count AS avg_sal
FROM avg_tot;


-- ============================================================================
-- 2.024 — Common Table Expressions (Single CTE)
-- ============================================================================
-- Core Concept: Define a temporary named result set before the main SELECT.
-- Gotchas:
--   * CTEs exist only for the duration of a single statement.
--   * Use descriptive names (e.g., dept_totals, max_dep_salary).

WITH dept_totals AS (
    SELECT
        department,
        SUM(salary) AS total_salary
    FROM employee
    GROUP BY department
)
SELECT
    department,
    total_salary
FROM dept_totals
WHERE total_salary > 150000;


-- ============================================================================
-- 2.019 — Multiple Joins & Hierarchy Aggregation
-- ============================================================================
-- Core Concept: Join the same dimension table multiple times under different
-- aliases to compare manager and employee attributes.

SELECT
    eh.manager_empl_id AS mgr_id,
    mgr.salary AS mgr_salary,
    AVG(emp.salary) AS avg_emp_salary
FROM map_employee_hierarchy eh
INNER JOIN dim_employee mgr
    ON eh.manager_empl_id = mgr.empl_id
INNER JOIN dim_employee emp
    ON eh.empl_id = emp.empl_id
GROUP BY
    eh.manager_empl_id,
    mgr.salary
HAVING mgr.salary < (AVG(emp.salary) * 2);


-- ============================================================================
-- 2.018 — Self-Join (Comparing Rows Within Same Table)
-- ============================================================================
-- Core Concept: Join a table to itself using distinct aliases (f1, f2) to find
-- matching pairs of rows.
-- Gotchas:
--   * Include f1.id <> f2.id to avoid pairing a row with itself.

SELECT
    f1.id AS f1_emp_id,
    f2.id AS f2_emp_id
FROM facebook_employees f1
INNER JOIN facebook_employees f2
    ON f1.location = f2.location
WHERE f1.gender = f2.gender
  AND f1.id <> f2.id
  AND f1.age <> f2.age
  AND f1.is_senior <> f2.is_senior;


-- ============================================================================
-- 2.017 — Anti-Join (LEFT JOIN + WHERE IS NULL)
-- ============================================================================
-- Core Concept: Find records in the left table that have no matching record
-- in the right table.

SELECT
    c.id,
    -- o.cust_id,
    c.first_name,
    c.city
FROM customers c
LEFT JOIN orders o
    ON c.id = o.cust_id
WHERE o.cust_id IS NULL;
-- ORDER BY c.id ASC;


-- ============================================================================
-- 2.016 — Multi-Key JOIN & UNION vs UNION ALL
-- ============================================================================
-- Core Concept: Join on multiple columns directly instead of concatenating
-- strings, or stack datasets vertically using UNION / UNION ALL.
-- Gotchas:
--   * UNION removes duplicates (slower); UNION ALL keeps all rows (preferred).
--   * Both SELECTs in a UNION must have the same column count and compatible
--     types; output column names come from the FIRST SELECT.
--   * Place ORDER BY at the very end to sort the combined UNION result.
--   * Add a literal source column (e.g., 'source_a' AS source) to track origin.

-- Multi-key INNER JOIN (cleaner & faster than string concatenation):
SELECT DISTINCT
    h.host_id,
    g.guest_id
FROM airbnb_hosts h
INNER JOIN airbnb_guests g
    ON h.gender = g.gender
   AND h.nationality = g.nationality
ORDER BY h.host_id;


-- ============================================================================
-- 2.013 — Query Building Sequence & Decimal Averaging
-- ============================================================================
-- Core Concept: Build queries incrementally and test after each clause:
--   1. SELECT + FROM
--   2. WHERE (filter individual rows)
--   3. GROUP BY (segment rows)
--   4. HAVING (filter aggregated groups)
--   5. ORDER BY (sort final output)
-- Gotchas:
--   * Multiply by 1.0 inside AVG() to prevent integer truncation.

SELECT
    department,
    ROUND(AVG(salary * 1.0), 2) AS avg_salary
FROM employee
GROUP BY department
ORDER BY avg_salary DESC;


-- ============================================================================
-- 2.012 — Conditional Aggregation (CASE WHEN) & NULLIF / Division
-- ============================================================================
-- Core Concept: Compute conditional counts, sums, and ratios (CTR, CVR) in a
-- single pass while guarding against integer division and division by zero.
-- Gotchas:
--   * Integer division: 3 / 4 = 0. Use 100.0 * x or CAST(x AS DECIMAL) / 4 -> 0.75.
--   * Division by zero: Wrap denominators in NULLIF(denominator, 0).
--   * Aggregates on empty sets return NULL (except COUNT, which returns 0).
--   * NULL values form their own group in GROUP BY.
--   * In CASE WHEN, unmatched rows/NULLs fall through to ELSE. Use
--     "WHEN salary IS NULL THEN NULL" if you want to exclude them completely.

SELECT
    ROUND(
        100.0 * SUM(CASE WHEN status = 'open' AND country = 'USA' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(name), 0),
        2
    ) AS active_rate
FROM fb_active_users AS fa;
-- ============================================================================
-- 2.011 — HAVING & SQL Execution Order
-- ============================================================================
-- Core Concept: WHERE filters raw rows BEFORE grouping; HAVING filters
-- aggregated groups AFTER GROUP BY.
-- Gotchas:
--   * Combine multiple HAVING conditions with AND.
--   * HAVING does not accept SELECT column aliases (except in MySQL).

SELECT
    department,
    COUNT(*) AS emp_count
FROM employee
WHERE status = 'active'
GROUP BY department
HAVING COUNT(*) >= 5
   AND AVG(salary) > 60000;


-- ============================================================================
-- 2.010 — GROUP BY & ORDER BY Rules
-- ============================================================================
-- Core Concept: Every non-aggregated column in SELECT must appear in GROUP BY.

SELECT
    department,
    role,
    COUNT(*) AS headcount
FROM employee
GROUP BY department, role
ORDER BY headcount DESC;


-- ============================================================================
-- 2.009 — Aggregate Functions
-- ============================================================================
-- Core Concept: Summarize multiple rows into single values.
-- Gotchas:
--   * COUNT(*) counts ALL rows including NULLs.
--   * COUNT(col), SUM(col), AVG(col), MIN(col), MAX(col) ignore NULLs.
--   * COUNT(DISTINCT col) counts unique non-NULL values.

SELECT
    COUNT(*) AS total_rows,
    COUNT(bonus) AS non_null_bonuses,
    COUNT(DISTINCT department) AS unique_depts,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employee;


-- ============================================================================
-- 2.008 — LIMIT, TOP, FETCH & OFFSET (Dialect Differences)
-- ============================================================================
-- Core Concept: Restrict the number of returned rows and paginate results.
-- Dialect Syntax:
--   * PostgreSQL / MySQL : LIMIT 5 OFFSET 5 (at the end of query)
--   * T-SQL (SQL Server) : SELECT TOP 10 ... OR OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY
--   * Oracle             : FETCH FIRST 10 ROWS ONLY / OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY

SELECT *
FROM employee
ORDER BY salary DESC
LIMIT 5 OFFSET 5;


-- ============================================================================
-- 2.007 — ORDER BY, String Length & NULL Sorting
-- ============================================================================
-- Core Concept: Sort output ascending (ASC, default) or descending (DESC).
-- Gotchas:
--   * Positional numbers (ORDER BY 2) refer to SELECT list position, not table schema.
--   * String length function: LENGTH(col) in PostgreSQL/MySQL/Oracle; LEN(col) in T-SQL.
--   * Default NULLs in ASC: FIRST in MySQL & T-SQL; LAST in PostgreSQL & Oracle.
--   * PostgreSQL explicit control: ORDER BY col_name ASC NULLS FIRST / LAST.

SELECT
    first_name,
    LENGTH(first_name) AS name_len
FROM employee
ORDER BY name_len DESC, first_name ASC;


-- ============================================================================
-- 2.006 — NULL Handling, Three-Valued Logic & COALESCE
-- ============================================================================
-- Core Concept: Handle unknown (NULL) values safely in filters and outputs.
-- Gotchas:
--   * 0 is zero, '' is empty string, NULL is unknown.
--   * NULL = NULL, NULL <> NULL, NULL > 5, and NULL = 'text' all return UNKNOWN (NULL).
--   * WHERE requires TRUE; UNKNOWN rows are filtered out.
--   * To include NULLs in negative checks, write: col <> 'string' OR col IS NULL.

SELECT
    COALESCE(nickname, first_name, 'Anonymous') AS user_name
FROM users
WHERE status <> 'banned' OR status IS NULL;


-- ============================================================================
-- 2.005 — LIKE Wildcards, IN / NOT IN & Date Ranges (BETWEEN)
-- ============================================================================
-- Core Concept: Match text patterns, check list membership, and filter ranges.
-- Gotchas:
--   * LIKE wildcards: '%' = zero or more chars; '_' = exactly one char.
--   * Use TRIM(col) LIKE '___x' for padded strings, LOWER(col) LIKE 'ab%' for case-insensitivity.
--   * CRITICAL: NOT IN (val1, val2) returns ZERO ROWS if the list/subquery contains any NULL!
--   * BETWEEN is inclusive (>= lower AND <= upper). For timestamps, prefer half-open intervals:
--     date_col >= '2019-03-01' AND date_col < '2019-04-01'
--   * Date subtraction by dialect:
--     - PostgreSQL : '2019-04-01'::DATE - INTERVAL '1 day'
--     - MySQL      : DATE_SUB('2019-04-01', INTERVAL 1 DAY)
--     - T-SQL      : DATEADD(day, -1, '2019-04-01')

SELECT *
FROM orders
WHERE LOWER(customer_name) LIKE 'ab%'
  AND status NOT IN ('cancelled', 'refunded')
  AND order_date >= '2019-03-01'
  AND order_date < '2019-04-01';


-- ============================================================================
-- 2.004 — Logical Operator Precedence (AND vs OR)
-- ============================================================================
-- Core Concept: SQL evaluates AND before OR. Always wrap OR conditions in
-- parentheses when combining them with AND.

SELECT *
FROM orders
WHERE status = 'shipped'
  AND (country = 'USA' OR country = 'Canada');
/* ============================================================================
   OTHER HANDS-ON EXAMPLES (REAL-WORLD T-SQL PRACTICE)
   ============================================================================ */

-- ============================================================================
-- 1.002 — Top 10 Vending Locations by Turnover (Chained CTEs + DENSE_RANK)
-- ============================================================================
-- Core Concept: Calculate distinct filled volume for a target year, join with
-- location metadata, rank with DENSE_RANK(), and filter to the top 10.
-- Techniques Used:
--   * T-SQL ISO date extraction: LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4)
--   * Window ranking without gaps: DENSE_RANK() OVER (ORDER BY ... DESC)
--   * Chained CTE pipeline: VOL_COUNT_DIS -> RANKED_VEND -> Final Top 10 SELECT

USE BCOverview_VENDING;

WITH VOL_COUNT_DIS AS (
    SELECT
        VEND_ID,
        COUNT(DISTINCT LP) AS VOLUME_DIS,
        LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4) AS YEAR
    FROM UTILIZATION
    WHERE STATUS = 'FILLED'
      AND LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4) = '2025'
    GROUP BY
        VEND_ID,
        LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4)
),
-- Rank calculation
RANKED_VEND AS (
    SELECT
        v.VEND_ID,
        v.VOLUME_DIS,
        CONCAT(p.CITY, ', ', p.STREET) AS LOCATION_DET,
        DENSE_RANK() OVER (ORDER BY v.VOLUME_DIS DESC) AS VEND_RANK
    FROM VEND_DB p
    INNER JOIN VOL_COUNT_DIS v
        ON p.VEND_ID = v.VEND_ID
    WHERE p.NETWORK_TYPE = 'SINGLE_PAYMENT'
)
-- Summary table display: top 10 selection
SELECT
    p.VEND_RANK AS RANK,
    p.VEND_ID AS ID,
    p.LOCATION_DET AS LOCATION,
    p.VOLUME_DIS AS 'FILLED VOL'
FROM RANKED_VEND p
WHERE VEND_RANK <= 10;


-- ============================================================================
-- 1.001 — Active Retail Unit Utilization by City (Single CTE + INNER JOIN)
-- ============================================================================
-- Core Concept: Pre-aggregate distinct turnover volume per vending machine in a
-- CTE, then join to the master machine table to filter by city and network.
-- Techniques Used:
--   * Pre-aggregation CTE (COUNT(DISTINCT LP)) before joining master metadata
--   * Multi-condition WHERE filtering across both joined tables

USE BCOverview_VENDING;

WITH VOL_COUNT_DIS AS (
    SELECT
        VEND_ID,
        COUNT(DISTINCT LP) AS VOLUME_DIS
    FROM UTILIZATION
    GROUP BY VEND_ID
)
SELECT
    p.VEND_ID,
    COUNT(DISTINCT p.VEND_ID) AS VEND_AUTO_ACTIVE_COUNT,
    v.VOLUME_DIS
FROM VEND_TABLE p
INNER JOIN VOL_COUNT_DIS v
    ON p.VEND_ID = v.VEND_ID
WHERE p.NETWORK_TYPE = 'DUAL_PAYMENT'
  AND v.VOLUME_DIS > 0
  AND p.CITY = 'Example_City'
GROUP BY
    p.VEND_ID,
    v.VOLUME_DIS
ORDER BY v.VOLUME_DIS DESC;
