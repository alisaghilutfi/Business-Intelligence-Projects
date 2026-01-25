-- ============================================
-- Q1: Customer Segmentation Based on LTV
-- ============================================

-- Step 1: Calculate total lifetime value (LTV) per customer
WITH CTE_customer_ltv AS (
    SELECT 
        customerkey,
        cleaned_name,
        SUM(total_net_revenue) AS total_ltv
    FROM cohort_analysis
    GROUP BY
        customerkey,
        cleaned_name 
),

-- Step 2: Compute LTV percentiles for segmentation thresholds
CTE_customer_segments AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_percentile,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_percentile
    FROM CTE_customer_ltv
),

-- Step 3: Assign each customer to a value-based segment
CTE_segment_values AS (
    SELECT
        cte_cltv.*,
        CASE 
            WHEN cte_cltv.total_ltv < cte_cs.ltv_25th_percentile THEN '1 - Low-Value'
            WHEN cte_cltv.total_ltv <= cte_cs.ltv_75th_percentile THEN '2 - Mid-Value'
            ELSE '3 - High-Value'
        END AS customer_segment
    FROM 
        CTE_customer_ltv cte_cltv
        CROSS JOIN CTE_customer_segments cte_cs
)

-- Step 4: Aggregate metrics by customer segment
SELECT  
    customer_segment,
    SUM(total_ltv) AS total_ltv,
    COUNT(customerkey) AS num_customers,
    ROUND(SUM(total_ltv) / COUNT(customerkey)::NUMERIC, 2) AS avg_ltv
FROM CTE_segment_values
GROUP BY customer_segment
ORDER BY customer_segment;