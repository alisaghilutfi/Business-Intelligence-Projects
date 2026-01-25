-- ============================================
-- Q2: Cohort Analysis & Revenue Benchmarking
-- ============================================

-- Part A: Revenue performance at cohort acquisition
SELECT
    cohort_year,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) AS total_revenue,
    SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS customer_revenue
FROM cohort_analysis
WHERE orderdate = first_purchase_date
GROUP BY cohort_year;


-- Part B: Spending comparison between purchasers and all customers

-- Step 1: Aggregate total net revenue per customer
WITH CTE_net_revenue AS (
    SELECT
        customerkey,
        SUM(quantity * netprice * exchangerate) AS net_revenue
    FROM sales
    GROUP BY customerkey
)

-- Step 2: Compare average revenue metrics
SELECT
    AVG(cte_nr.net_revenue) AS spending_customers_avg_net_revenue,
    AVG(COALESCE(cte_nr.net_revenue, 0)) AS all_customers_avg_net_revenue
FROM customer c
LEFT JOIN CTE_net_revenue cte_nr ON c.customerkey = cte_nr.customerkey;
