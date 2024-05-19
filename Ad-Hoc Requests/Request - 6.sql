/*Request-6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market.
The final output contains these fields --> customer_code, customer, average_discount_percentage*/
WITH avg_discount AS	
    (SELECT customer_code, AVG(pre_invoice_discount_pct) AS average_discount_pct
	FROM fact_pre_invoice_deductions
	WHERE fiscal_year = 2021
	GROUP BY customer_code),
cust AS
	(SELECT customer_code, customer
    FROM dim_customer
    WHERE market = "India")
SELECT cust.customer_code, cust.customer,
	CONCAT(ROUND((average_discount_pct)*100, 2),'%') AS average_discount_percentage
FROM avg_discount
INNER JOIN cust
ON avg_discount.customer_code = cust.customer_code
ORDER BY average_discount_pct DESC
LIMIT 5;