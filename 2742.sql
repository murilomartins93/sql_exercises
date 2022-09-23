--2742
SELECT *
FROM 
	(SELECT life_registry.name, ROUND(omega * 1.618, 3) AS The_N_Factor
 	FROM dimensions
	INNER JOIN life_registry ON dimensions.id = life_registry.dimensions_id
	WHERE dimensions.name LIKE 'C774' OR dimensions.name LIKE 'C875') AS sub
WHERE UPPER(name) LIKE 'RICHARD%'