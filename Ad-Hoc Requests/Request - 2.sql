/* Request-2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields --> unique_products_2020, unique_products_2021, percentage_chg*/
WITH product_counts AS
	(SELECT fiscal_year, COUNT(DISTINCT product_code) AS unique_products
    FROM fact_sales_monthly
    GROUP BY fiscal_year)
SELECT x.unique_products AS unique_products_2020,
	   y.unique_products AS unique_products_2021,
       CONCAT(ROUND(((y.unique_products - x.unique_products)/x.unique_products)*100 ,2),"%") AS percentage_chg
FROM product_counts AS x
INNER JOIN product_counts AS y
ON x.fiscal_year = 2020 AND y.fiscal_year = 2021;