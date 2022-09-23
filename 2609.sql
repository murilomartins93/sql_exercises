--2609
SELECT categories.name, SUM(amount)
FROM products
INNER JOIN categories ON products.id_categories = categories.id
GROUP BY categories.namew