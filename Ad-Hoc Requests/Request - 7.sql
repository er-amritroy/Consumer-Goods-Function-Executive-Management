/*Request-7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month.
This analysis helps to get an idea of low and high-performing months and take strategic decisions.
The final report contains these columns: Month, Year, Gross sales Amount*/
SELECT MONTHNAME(sm.date) AS months, year(sm.date) AS years,
	ROUND(SUM(gp.gross_price*sm.sold_quantity)/1000000, 2) AS Gross_sales_Amount_mln
FROM fact_sales_monthly AS sm
INNER JOIN fact_gross_price AS gp
ON sm.product_code = gp.product_code
INNER JOIN dim_customer AS dp
ON sm.customer_code = dp.customer_code
WHERE dp.customer = "Atliq Exclusive"
GROUP BY months, years
ORDER BY years;