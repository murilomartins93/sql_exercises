--2998 -- Window Functions
SELECT DISTINCT ON (clients.name) clients.name, 
	clients.investment, 
	sum_by_month.month, 
	SUM(sum_by_month.cumulative - clients.investment)
FROM clients
INNER JOIN
	(SELECT client_id, month, 
		SUM(profit) OVER (
			PARTITION BY client_id
			ORDER BY month
		) AS cumulative
	FROM operations
	) AS sum_by_month ON sum_by_month.client_id = clients.id
WHERE (sum_by_month.cumulative - clients.investment) >= 0
GROUP BY clients.name, clients.investment, sum_by_month.month
ORDER BY clients.name, sum_by_month.month