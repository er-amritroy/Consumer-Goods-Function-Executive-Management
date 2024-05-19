/*Request-9. Which channel helped to bring more gross sales in the fiscal year 2021 and parcentage of contribution?
The final output contains these fields --> channel, gross_sales_mln, parcentage */
WITH cte AS	
    (SELECT dc.channel, ROUND(SUM(gp.gross_price*sm.sold_quantity)/1000000,2) AS gross_sales_mln
	FROM fact_sales_monthly AS sm
	JOIN fact_gross_price AS gp
	ON sm.product_code = gp.product_code
	JOIN dim_customer AS dc
	ON sm.customer_code = dc.customer_code
	WHERE sm.fiscal_year = 2021
	GROUP BY dc.channel)
SELECT channel, gross_sales_mln, ROUND((gross_sales_mln/total)*100 ,2) AS parcentage
FROM(
	(SELECT SUM(gross_sales_mln) AS total FROM cte) x,
    (SELECT * FROM cte) y
    )
ORDER BY parcentage DESC;