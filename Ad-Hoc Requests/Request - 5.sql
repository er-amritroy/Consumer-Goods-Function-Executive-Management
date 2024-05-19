/*Request-5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields --> product_code, product, manufacturing_cost*/
WITH max_min_cost AS
	(SELECT MAX(manufacturing_cost) AS highest_cost, MIN(manufacturing_cost) AS lowest_cost
    FROM fact_manufacturing_cost)
SELECT dp.product_code, dp.product, mc.manufacturing_cost
FROM fact_manufacturing_cost AS mc
INNER JOIN dim_product AS dp
ON mc.product_code = dp.product_code
CROSS JOIN max_min_cost
WHERE mc.manufacturing_cost IN (highest_cost, lowest_cost)
ORDER BY mc.manufacturing_cost DESC;