--2621
SELECT products.name
FROM products 
INNER JOIN providers ON products.id_providers = providers.id
WHERE (amount BETWEEN 10 AND 20) AND providers.name LIKE 'P%'