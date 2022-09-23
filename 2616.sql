--2616
SELECT customers.id, customers.name
FROM customers
WHERE id
NOT IN (
	SELECT id_customers
	FROM locations
	INNER JOIN customers ON locations.id_customers = customers.id
)