/*Request-4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020?
The final output contains these fields --> segment, product_count_2020, product_count_2021, difference*/
WITH cte1 AS
	(SELECT dp.segment, COUNT(DISTINCT sm.product_code) AS product_count_2020
    FROM fact_sales_monthly AS sm
    INNER JOIN dim_product AS dp
    ON sm.product_code = dp.product_code
    WHERE sm.fiscal_year = 2020
    GROUP BY dp.segment),
cte2 AS
	(SELECT dp.segment, COUNT(DISTINCT sm.product_code) AS product_count_2021
    FROM fact_sales_monthly AS sm
    INNER JOIN dim_product AS dp
    ON sm.product_code = dp.product_code
    WHERE sm.fiscal_year = 2021
    GROUP BY dp.segment)
SELECT cte1.segment, cte1.product_count_2020, cte2.product_count_2021,
	(cte2.product_count_2021 - cte1.product_count_2020) AS difference
FROM cte1
INNER JOIN cte2
ON cte1.segment = cte2.segment
ORDER BY difference DESC;