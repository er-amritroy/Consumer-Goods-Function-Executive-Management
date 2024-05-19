/* Request-10. Get the Top 3 products in each division that give a high total_sold_quantity in the fiscal year 2021?
The final output contains these fields --> division, product_code, product, total_sold_qty, rank_order */
WITH cte1 AS
	(SELECT p.division, p.product_code, p.product, SUM(sm.sold_quantity) AS total_sold_qty
    FROM dim_product AS p
    JOIN fact_sales_monthly AS sm
    ON p.product_code = sm.product_code
    WHERE sm.fiscal_year = 2021
    GROUP BY p.division, p.product_code, p.product),
cte2 AS
	(SELECT division, product_code, product, total_sold_qty,
    RANK() OVER(PARTITION BY division ORDER BY total_sold_qty DESC) AS rank_order
    FROM cte1)
SELECT cte1.division, cte1.product_code, cte1.product, cte1.total_sold_qty, cte2.rank_order
FROM cte1
JOIN cte2
ON cte1.product_code = cte2.product_code
WHERE rank_order IN (1,2,3);