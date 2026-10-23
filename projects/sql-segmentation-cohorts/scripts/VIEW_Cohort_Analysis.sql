-- ============================================
-- View: cohort_analysis
-- Purpose: Analytical abstraction layer for customer-level cohort analytics
-- ============================================

CREATE OR REPLACE VIEW public.cohort_analysis AS

-- Step 1: Aggregate revenue per customer per order date
WITH cte_customer_revenue AS (
    SELECT
        s.customerkey,
        s.orderdate,
        COUNT(s.orderkey) AS num_orders,
        ROUND(
            SUM(s.quantity::DOUBLE PRECISION * s.netprice * s.exchangerate)::NUMERIC,
            2
        ) AS total_net_revenue,
        MAX(c.countryfull) AS countryfull,
        MAX(c.age) AS age,
        MAX(c.givenname) AS givenname,
        MAX(c.surname) AS surname
    FROM sales s
    JOIN customer c 
        ON s.customerkey = c.customerkey
    GROUP BY s.customerkey, s.orderdate
)

-- Step 2: Enrich with cohort attributes
SELECT
    customerkey,
    orderdate,
    num_orders,
    total_net_revenue,
    countryfull,
    age,
    CONCAT(
        TRIM(givenname), ' ', TRIM(surname)
    ) AS cleaned_name,
    MIN(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date,
    EXTRACT(
        YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)
    ) AS cohort_year
FROM cte_customer_revenue;
