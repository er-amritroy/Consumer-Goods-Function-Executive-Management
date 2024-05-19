/*Request-8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these 
fields--> Quarter, total_sold_quantity (sorted by the total_sold_quantity) FY start from September month */
SELECT
	CASE
		WHEN date BETWEEN '2019-09-01' AND '2019-11-01' THEN "Q1"
        WHEN date BETWEEN '2019-12-01' AND '2020-02-01' THEN "Q2"
        WHEN date BETWEEN '2020-03-01' AND '2020-05-01' THEN "Q3"
        WHEN date BETWEEN '2020-06-01' AND '2020-08-01' THEN "Q4"
        END AS Quarters,
        SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarters
ORDER BY total_sold_quantity DESC;