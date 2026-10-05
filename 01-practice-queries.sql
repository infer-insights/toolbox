
/*
============================================================
SQL Toolbox - Examples of applied solutions


### Environment Best Practices and code examples:
1. T-SQL code examples 
	1.001: active units machines selection
	1.002: ranked retail unit with largest turnover selection
2. Training: Hands on challenge with "stratascratch.com" sql path, progress: (33% completed)
    - # direct link to the training
    - https://www.stratascratch.com/learn/comprehensive-sql
============================================================
*/

1.001: 
	-- retail unit utilization limited to machines with turnover in selected city
		use BCOverview_VENDING;
		WITH VOL_COUNT_DIS AS
		(
		SELECT
			VEND_ID,
			COUNT(DISTINCT LP) AS VOLUME_DIS
		FROM
			UTILIZATION
		GROUP BY
			VEND_ID
		)
		SELECT
			p.VEND_ID,
			COUNT (DISTINCT p.VEND_ID) AS VEND_AUTO_ACTIVE_COUNT,
			v.VOLUME_DIS
		FROM	
			VEND_TABLE p
		INNER JOIN
			VOL_COUNT_DIS v ON p.VEND_ID = v.VEND_ID
		WHERE
			p.NETWORK_TYPE = 'DUAL_PAYMENT' AND 
			v.VOLUME_DIS > 0 AND
			p.CITY = 'Example_City'
		GROUP BY
			p.VEND_ID,
			v.VOLUME_DIS
		ORDER BY
			v.VOLUME_DIS DESC;

1.002: 
	--most popular (top 10) vending machines locations utilization,
	--limited to selected year, network, city and service type
		use BCOverview_VENDING;
		WITH VOL_COUNT_DIS AS
		(
		SELECT
			VEND_ID,
			COUNT(DISTINCT LP) AS VOLUME_DIS,
			LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4) AS YEAR
		FROM
			UTILIZATION
		WHERE
			STATUS = 'FILLED' AND								
			LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4) = '2025'
			GROUP BY
				VEND_ID, LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4)
		),
	--rank calculation 
		RANKED_VEND AS
		(
		SELECT
			v.VEND_ID,
			v.VOLUME_DIS,
			CONCAT (p.CITY,', ',p.STREET) AS LOCATION_DET,
			DENSE_RANK() OVER (ORDER BY v.VOLUME_DIS DESC) AS VEND_RANK
		FROM	
			VEND_DB p
		INNER JOIN
			VOL_COUNT_DIS v ON p.VEND_ID = v.VEND_ID
		WHERE
			p.NETWORK_TYPE = 'SINGLE_PAYMENT'
		)
		--summary table display top 10 selection
		SELECT 
			p.VEND_RANK AS RANK,
			p.VEND_ID AS ID,
			p.LOCATION_DET AS LOCATION,
			p.VOLUME_DIS AS 'FILLED VOL'
		FROM
			RANKED_VEND p
		WHERE
			VEND_RANK <= 10;

2.004:
	--when mix AND and OR, SQL evaluates AND first, parenthesis override
2.005:
	--LIKE, wildcards
	--'%' any character sequence incl. none, '_' exactly one
	--TRIM(col_name) LIKE '___x' when data format exceeds expected character count
	--LOWER(col_name) LIKE 'ab%' when case sensitive
	--IN, NOT IN ('string1','string2'), work with txt and numbers
	--carefull wtih NOT IN and NULLs - no rows if any contains NULL
	--BETWEEN, NOT BETWEEN lower '>=' AND larger '=<'
	--PostgreSQL BETWEEN '2019-03-01' AND '2019-04-01'::DATE - INTERVAL '1 day'
	--	   MySQL BETWEEN '2019-03-01' AND DATE_SUB('2019-04-01', INTERVAL 1 DAY);
	--	   T-SQL BETWEEN '2019-03-01' AND DATEADD(day, -1, '2019-04-01') - used in ex.
	-- timestamp safer: date_col >= '2019-03-01' AND date_col < '2019-04-01'
	-- AND/OR to mix the above		
2.006:
	--NULL handling
	--0 - zero, "" - empty, NULL - not known what it is
	--NULL = NULL  -- Returns NULL (not true!)
	--NULL <> NULL -- Returns NULL (not true!)
	--NULL > 5     -- Returns NULL
	--NULL = 'text'-- Returns NULL
	--!='string' OR column IS NULL - to include null in search
	--NULL three val logic AND, OR
		COALESCE(col1, col2, 'string') AS user_name - fills NULL wit string
	--True and Unknown AND False = UNKNOWN will display nothing
		WHERE requires TRUE, if NULL included - FALSE
2.007:
	--ORDER BY col_name or col number ASC - default, DESC
	--col number relates to the list below SELECT, not table col. idx
	--LENGTH() - Postgre, MySQL, Oracle, LEN() - T-SQL
	--NULLs in ASC: first - MySQL, T-SQL, last - Postgre, Oracle
	--Postgre control: ORDER BY col_name ASC NULLS FIRST/LAST
2.008:
	--LIMIT 
	--SELECT TOP 10 (start) - T-SQL	
	--LIMIT (end) 10 at the end of query- Postgre/MsSQL
	--FETCH FIRST 10 ROWS ONLY (end) - after ORDER BY, Oracle
	--OFFSET - skip rows
		LIMIT 5 OFFSET 5 - PostgreSQL/MySQL
		OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY Oracle/T-SQL
2.009:
	--Aggregate 
	--COUNT(col) -not null rows
	--COUNT(*) #counts including null rows
	--COUUNT(DISTINCT col)	#counts column records
	--SUM, AVG - ignores NULLs, MIN, MAX 
2.010:
	--GROUP BY, ORDER BY 
	-- every column in SELECT must be either in GROUP BY or aggregate function
2.011:
	--HAVING
	--WHERE filters rows - before GROUP BY, HAVING filters aggregations after	 
	--#EXECUTION ORDER
		1. FROM: Get the table  
		2. WHERE: Filter individual rows  
		3. GROUP BY: Create groups from remaining rows
		4. HAVING: Filter groups  
		5. SELECT: Calculate and choose columns  
		6. ORDER BY: Sort the results
	-- HAVING - does not accept column aliases (except MySQL)
2.024:
	--CTE syntax:
	--CTE location before main query w. SELECT
		WITH cte_name AS (
  		SELECT ...
  			FROM ...
  			WHERE ...
		)
		SELECT *
		FROM cte_name;
	--CTEs exist only within their statement. Once the query finishes, they’re gone.
	--descriptive names recommended ex. max_dep_salary
	--ex. with condition applied
		WITH dept_totals AS (
    	SELECT
    		department,
    		sum(salary) AS total_salary
		FROM
			employee
		GROUP BY department
		)
		SELECT
			department,
			total_salary
		FROM dept_totals
		WHERE total_salary > 150000 --condition applied
		;
2.025:
	--multiple CTE syntax:
	--separated by commas, !only one! "WITH" keyword at the beginning
		WITH first_cte AS ( --what data do i need first
			SELECT ...
		),
		second_cte AS (	--what calculation depends on that
			SELECT ...
			FROM first_cte
			...
		),
		third_cte AS (	--what filtering or joining comes next
			SELECT ...
			FROM second_cte
		...
		)
			SELECT *	--whats the final output
		FROM third_cte;
	--each CTE can reference any CTE defined before it, but not after. Order matters.
