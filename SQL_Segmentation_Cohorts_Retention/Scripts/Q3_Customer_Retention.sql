-- ============================================
-- Q3: Customer Retention & Churn Analysis
-- ============================================

-- Step 1: Identify last purchase per customer
WITH CTE_last_purchase AS (
    SELECT
        customerkey,
        cleaned_name,
        orderdate,
        ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
        first_purchase_date,
        cohort_year
    FROM cohort_analysis
),

-- Step 2: Classify customer status
CTE_customer_status AS (
    SELECT
        customerkey,
        cleaned_name,
        first_purchase_date,
        orderdate AS last_purchase_date,
        CASE 
            WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
            ELSE 'Active'
        END AS customer_status,
        cohort_year
    FROM CTE_last_purchase
    WHERE rn = 1 
    	AND first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
)

-- Step 3: Aggregate retention metrics by cohort
SELECT 
    cohort_year,
    customer_status,
    COUNT(customerkey) AS num_customers,
    SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year) AS total_customers,
    ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year), 2) AS status_percentage
FROM CTE_customer_status
GROUP BY cohort_year, customer_status;
