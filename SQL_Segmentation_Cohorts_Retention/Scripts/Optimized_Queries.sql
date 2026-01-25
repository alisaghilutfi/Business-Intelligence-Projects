-- Using LIMIT
EXPLAIN ANALYZE
SELECT *
FROM sales
LIMIT 10


-- Avoid using SELECT *, instead use the wanting columns
EXPLAIN ANALYZE
SELECT
	customerkey
FROM sales


-- Using WHERE comand instead of HAVING
EXPLAIN ANALYZE
SELECT 
	customerkey,
	SUM(quantity * netprice * exchangerate) AS net_revenue
FROM sales 
WHERE orderdate >= '2024-01-01'
GROUP BY customerkey

EXPLAIN ANALYZE
SELECT 
	customerkey,
	SUM(quantity * netprice * exchangerate) AS net_revenue
FROM sales 
GROUP BY customerkey
HAVING SUM(quantity * netprice * exchangerate) > 1000;


-- Minimize GROUP BY usage
EXPLAIN ANALYZE 
SELECT 
	customerkey,
	orderdate,
	orderkey,
	--linenumber,
	SUM(quantity * netprice * exchangerate) AS net_revenue
FROM sales 
GROUP BY
	customerkey,
	orderdate,
	orderkey
	--linenumber
	

-- Reduce JOIN when its possible
EXPLAIN ANALYZE 
SELECT 
	c.customerkey,
	c.givenname,
	c.surname,
	p.productname,
	s.orderdate,
	s.orderkey,
	d.YEAR
FROM sales s 
	INNER JOIN customer c ON s.customerkey = c.customerkey
	INNER JOIN product p ON s.productkey = p.productkey
	INNER JOIN date d ON s.orderdate = d.date

EXPLAIN ANALYZE 
SELECT 
	c.customerkey,
	c.givenname,
	c.surname,
	p.productname,
	s.orderdate,
	s.orderkey,
	EXTRACT(YEAR FROM s.orderdate) AS year
FROM sales s 
	INNER JOIN customer c ON s.customerkey = c.customerkey
	INNER JOIN product p ON s.productkey = p.productkey

	
-- Optimize with ORDER BY
EXPLAIN ANALYZE 
SELECT 
	customerkey,
	orderdate,
	orderkey,
	SUM(quantity * netprice * exchangerate) AS net_revenue
FROM sales 
GROUP BY
	customerkey,
	orderdate,
	orderkey
ORDER BY
	--net_revenue DESC,
	customerkey,
	orderdate,
	orderkey

	
-- Optimizing the cohort_analysis VIEW
EXPLAIN ANALYZE
/*DROP VIEW cohort_analysis;
CREATE OR REPLACE VIEW cohort_analysis AS*/
WITH cte_customer_revenue AS (
	SELECT
		s.customerkey,
		s.orderdate,
		count(s.orderkey) AS num_orders,
		round(sum(s.quantity::double PRECISION * s.netprice * s.exchangerate)::NUMERIC, 2) AS total_net_revenue,
		MAX(c.countryfull) AS countryfull,
		MAX(c.age) AS age,
		MAX(c.givenname) AS givenname,
		MAX(c.surname) AS surname
	FROM
		sales s
	--LEFT JOIN customer c ON s.customerkey = c.customerkey
	INNER JOIN customer c ON s.customerkey = c.customerkey
	GROUP BY
		s.customerkey,
		s.orderdate
		/*,c.countryfull,
		c.age,
		c.givenname,
		c.surname*/
)
 SELECT
	customerkey,
	orderdate,
	num_orders,
	total_net_revenue,
	countryfull,
	age,
	concat(TRIM(BOTH FROM givenname), ' ', TRIM(BOTH FROM surname)) AS cleaned_name,
	min(orderdate) OVER (
		PARTITION BY customerkey
	) AS first_purchase_date,
	EXTRACT(YEAR FROM min(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
FROM
	cte_customer_revenue
	
	

	





















