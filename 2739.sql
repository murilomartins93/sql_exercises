--2602
SELECT name FROM customers WHERE state = 'RS';

--2603
SELECT name, street
FROM customers
WHERE city = 'Porto Alegre'

--2604
SELECT id, name
FROM products 
WHERE price > 100

--2605
SELECT products.name, providers.name FROM products
INNER JOIN providers ON products.id_providers = providers.id
WHERE products.id_categories = 6

--2606
SELECT products.id, products.name
FROM products
INNER JOIN categories ON products.id_categories = categories.id
WHERE UPPER(categories.name) LIKE 'SUPER%'

--2607
SELECT city
FROM providers
GROUP BY city
ORDER BY city ASC

--2608
SELECT MAX(price), MIN(price)
FROM products

--2609
SELECT categories.name, SUM(amount)
FROM products
INNER JOIN categories ON products.id_categories = categories.id
GROUP BY categories.name

--2610
SELECT ROUND(AVG(price),2)
FROM products

--2611
SELECT movies.id, movies.name
FROM movies 
INNER JOIN genres ON movies.id_genres = genres.id
WHERE description = 'Action'

--2613
SELECT movies.id, movies.name
FROM movies
INNER JOIN prices ON movies.id_prices = prices.id
WHERE prices.value < 2.00

--2614
SELECT customers.name, rentals.rentals_date 
FROM customers
INNER JOIN rentals ON customers.id = rentals.id_customers
WHERE EXTRACT(MONTH FROM rentals_date) = 9

--2615
SELECT city
FROM customers
GROUP BY city

--2616
SELECT customers.id, customers.name
FROM customers
WHERE id
NOT IN (
	SELECT id_customers
	FROM locations
	INNER JOIN customers ON locations.id_customers = customers.id
)

--2617
SELECT products.name, providers.name
FROM products
INNER JOIN providers ON products.id_providers = providers.id
WHERE UPPER(providers.name) = 'AJAX SA'

--2618
SELECT products.name, providers.name, categories.name
FROM (products
INNER JOIN providers ON products.id_providers = providers.id) 
INNER JOIN categories ON products.id_categories = categories.id
WHERE UPPER(categories.name) = 'IMPORTED' 
AND UPPER(providers.name) = 'SANSUL SA'

--2619
SELECT products.name, providers.name, products.price
FROM (products 
INNER JOIN providers ON products.id_providers = providers.id) 
INNER JOIN categories ON products.id_categories = categories.id
WHERE price > 1000 AND UPPER(categories.name) = 'SUPER LUXURY'

--2620
SELECT customers.name, orders.id
FROM customers 
INNER JOIN orders ON customers.id = orders.id_customers
WHERE EXTRACT(MONTH FROM orders.orders_date) 
BETWEEN 1 AND 6

--2621
SELECT products.name
FROM products 
INNER JOIN providers ON products.id_providers = providers.id
WHERE (amount BETWEEN 10 AND 20) AND providers.name LIKE 'P%'
  
--2622
SELECT customers.name 
FROM customers
INNER JOIN legal_person ON customers.id = legal_person.id_customers

--2623
SELECT products.name, categories.name
FROM products
INNER JOIN categories ON products.id_categories = categories.id
WHERE amount > 100 AND categories.id IN (1, 2, 3, 6, 9)
ORDER BY categories.id ASC

--2624
SELECT COUNT(city)
FROM customers
GROUP BY city
  /*  Execute this query to drop the tables */
  -- DROP TABLE customers; -- 

--2625
SELECT SUBSTRING(cpf FROM 1 FOR 3) || '.' || 
	   SUBSTRING(cpf FROM 4 FOR 3) || '.' || 
	   SUBSTRING(cpf FROM 7 FOR 3) || '-' ||
       SUBSTRING(cpf FROM 10 FOR 2) AS Cpf 
FROM natural_person;

		 -- OU
		 
SELECT CONCAT(SUBSTRING(cpf FROM 1 FOR 3), '.', 
			  SUBSTRING(cpf FROM 4 FOR 3), '.',
			  SUBSTRING(cpf FROM 7 FOR 3), '-',
			  SUBSTRING(cpf FROM 10 FOR 2)) AS Cpf
FROM natural_person;

--2737
SELECT name, customers_number
FROM lawyers
WHERE customers_number = 
	(SELECT MAX(customers_number)
	FROM lawyers) 
UNION ALL
SELECT name, customers_number
FROM lawyers
WHERE customers_number = 
	(SELECT MIN(customers_number)
	FROM lawyers) 
UNION ALL
SELECT COALESCE('Average'), ROUND(AVG(customers_number))
FROM lawyers

--2738
SELECT name, ROUND(((score.math * 2 + score.specific * 3 + score.project_plan * 5)/10.0), 2) AS avg
FROM score
INNER JOIN candidate ON score.candidate_id = candidate.id 
ORDER BY avg DESC

--2739
SELECT name, CAST(EXTRACT(DAY FROM payday) AS INTEGER) AS day
FROM loan

--2740
SELECT CONCAT('Podium: ', team) AS name
FROM league 
WHERE position <= 3
UNION ALL
SELECT CONCAT('Demoted: ', team) AS name 
FROM league 
WHERE position >= 14

--2741
SELECT CONCAT('Approved: ', name), grade
FROM students
WHERE grade >= 7
ORDER BY grade DESC

--2742
SELECT *
FROM 
	(SELECT life_registry.name, ROUND(omega * 1.618, 3) AS The_N_Factor
 	FROM dimensions
	INNER JOIN life_registry ON dimensions.id = life_registry.dimensions_id
	WHERE dimensions.name LIKE 'C774' OR dimensions.name LIKE 'C875') AS sub
WHERE UPPER(name) LIKE 'RICHARD%'

--2743
SELECT name, CHAR_LENGTH(name) AS length
FROM people
ORDER BY length DESC

--2744
SELECT id, password, MD5(password)
FROM account

--2745
SELECT name, ROUND((salary * 0.1), 2) AS tax
FROM people
WHERE salary > 3000
  
--2746
SELECT REPLACE(name, 'H1', 'X')
FROM virus

--2988
SELECT teams.name, 
	COUNT(
		CASE 
			WHEN team_1 = teams.id THEN team_1
			WHEN team_2 = teams.id THEN team_2
		END
	) AS matches, 
	SUM(
		CASE
			WHEN team_1_goals > team_2_goals AND team_1 = teams.id 
			OR team_2_goals > team_1_goals AND team_2 = teams.id 
			THEN 1
			ELSE 0
		END
	) AS victories,
	SUM(
		CASE
			WHEN team_1_goals < team_2_goals AND team_1 = teams.id 
			OR team_2_goals < team_1_goals AND team_2 = teams.id 
			THEN 1
			ELSE 0
		END
	) AS defeats, 
	SUM(
		CASE
			WHEN team_1_goals = team_2_goals AND team_1 = teams.id 
			OR team_1_goals = team_2_goals AND team_2 = teams.id 
			THEN 1
			ELSE 0
		END
	) AS draws,
	SUM(
		CASE
			WHEN team_1_goals > team_2_goals AND team_1 = teams.id 
			OR team_2_goals > team_1_goals AND team_2 = teams.id 
			THEN 3
			WHEN team_1_goals = team_2_goals AND team_1 = teams.id 
			OR team_1_goals = team_2_goals AND team_2 = teams.id
			THEN 1
			ELSE 0
		END
	) AS score	
FROM matches, teams
GROUP BY name
ORDER BY score DESC

--2989
SELECT departamento.nome, 
	   divisao.nome, 
	   ROUND(AVG(vencimento_total.salario - desconto_total.descontos), 2) AS media, 
	   ROUND(MAX(vencimento_total.salario - desconto_total.descontos), 2) AS maior
FROM departamento
	INNER JOIN divisao ON departamento.cod_dep = divisao.cod_dep
	INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
	INNER JOIN
		(SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS salario
		FROM empregado
		LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr) 
	AS vencimento_total ON vencimento_total.matr = empregado.matr
	INNER JOIN 
		(SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS descontos
		FROM empregado
		LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
		LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
		GROUP BY empregado.matr) 
	AS desconto_total ON empregado.matr = desconto_total.matr
GROUP BY departamento.nome, divisao.nome
ORDER BY media DESC

--2990
SELECT empregados.cpf, empregados.enome, departamentos.dnome
FROM empregados
INNER JOIN departamentos ON empregados.dnumero = departamentos.dnumero
WHERE empregados.cpf NOT IN (
	SELECT trabalha.cpf_emp
	FROM trabalha 
	INNER JOIN projetos ON trabalha.pnumero = projetos.pnumero
)
ORDER BY empregados.cpf

--2991
SELECT departamento.nome AS "Nome Departamento", 
	COUNT(empregado.matr) AS "Numero de Empregados",
	ROUND(AVG(vencimento_total.salario - desconto_total.descontos), 2) AS "Media Salarial",
	ROUND(MAX(vencimento_total.salario - desconto_total.descontos), 2) AS "Maior Salario",
	(CASE
		WHEN ROUND(MIN(vencimento_total.salario - desconto_total.descontos), 2) = 0 
	 	THEN '0'
	 	ELSE ROUND(MIN(vencimento_total.salario - desconto_total.descontos), 2)
	END) AS "Menor Salario"
FROM departamento
INNER JOIN divisao ON departamento.cod_dep = divisao.cod_dep
	INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
	INNER JOIN
		(SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS salario
		FROM empregado
		LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr) 
	AS vencimento_total ON vencimento_total.matr = empregado.matr
	INNER JOIN 
		(SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS descontos
		FROM empregado
		LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
		LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
		GROUP BY empregado.matr) 
	AS desconto_total ON empregado.matr = desconto_total.matr
GROUP BY departamento.nome
ORDER BY "Media Salarial" DESC

--2992
SELECT * FROM 
(SELECT DISTINCT ON (departamento.nome) departamento.nome AS departamento, 
	divisao.nome AS divisao,
	ROUND(AVG(vencimento_total.salario - desconto_total.descontos), 2) AS media
FROM departamento
INNER JOIN divisao ON departamento.cod_dep = divisao.cod_dep
	INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
	INNER JOIN
		(SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS salario
		FROM empregado
		LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr) 
	AS vencimento_total ON vencimento_total.matr = empregado.matr
	INNER JOIN 
		(SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS descontos
		FROM empregado
		LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
		LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
		GROUP BY empregado.matr) 
	AS desconto_total ON empregado.matr = desconto_total.matr
GROUP BY departamento.nome, divisao.nome
ORDER BY departamento.nome, media DESC) AS total_results
ORDER BY media DESC

--2993
SELECT amount AS most_frequent_value
FROM value_table
GROUP BY amount
ORDER BY COUNT(amount) DESC
LIMIT 1

--2994
SELECT d.name,
ROUND(SUM(att.hours * 150 * (1 + ws.bonus / 100)), 1) AS salary
FROM doctors d 
INNER JOIN attendances att ON att.id_doctor = d.id
INNER JOIN work_shifts ws ON ws.id = att.id_work_shift
GROUP BY d.name
ORDER BY salary DESC

--2995
SELECT r.temperature, COUNT(r.temperature) AS number_of_records
FROM records r
GROUP BY r.temperature, r.mark
ORDER BY r.mark

--2996
SELECT packages.year, sender.name AS sender, receiver.name AS receiver
FROM packages
INNER JOIN
	(SELECT packages.id_package, users.name
	FROM packages
 	INNER JOIN users ON packages.id_user_sender = users.id
	WHERE users.address NOT LIKE 'Taiwan'
	) AS sender ON packages.id_package = sender.id_package
INNER JOIN
	(SELECT packages.id_package, users.name
	FROM users 
 	INNER JOIN packages ON packages.id_user_receiver = users.id
	WHERE users.address NOT LIKE 'Taiwan'
	) AS receiver ON packages.id_package = receiver.id_package
WHERE packages.color = 'blue' OR packages.year = 2015 
ORDER BY packages.year DESC, packages.id_package DESC


--2997
SELECT departamento.nome AS "Departamento", 
	empregado.nome AS "Empregado",
	(CASE 
		WHEN SUM(vencimento_total.salario) = 0  
		THEN 0
		ELSE ROUND(SUM(vencimento_total.salario), 2)
		END) AS "Salario Bruto",
	(CASE 
		WHEN SUM(desconto_total.descontos) = 0  
		THEN 0
		ELSE ROUND(SUM(desconto_total.descontos), 2)
		END) AS "Total Desconto",
	(CASE 
		WHEN SUM(vencimento_total.salario - desconto_total.descontos) = 0  
		THEN 0
		ELSE ROUND(SUM(vencimento_total.salario - desconto_total.descontos), 2)
		END) AS "Salario Liquidoaws"
FROM departamento
INNER JOIN divisao ON divisao.cod_dep = departamento.cod_dep
INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
INNER JOIN
	(SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS salario
	FROM empregado
	LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
	LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
	GROUP BY empregado.matr) AS vencimento_total ON vencimento_total.matr = empregado.matr
INNER JOIN 
	(SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS descontos
	FROM empregado
	LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
	LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
	GROUP BY empregado.matr) AS desconto_total ON empregado.matr = desconto_total.matr
GROUP BY departamento.nome, empregado.nome, divisao.nome
ORDER BY "Salario Liquidoaws" DESC


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


--2999
SELECT empregado.nome,
	(CASE 
		WHEN SUM(vencimento_total.salario - desconto_total.descontos) = 0  
		THEN 0
		ELSE ROUND(SUM(vencimento_total.salario - desconto_total.descontos), 2)
		END) AS salario_total
FROM departamento
INNER JOIN divisao ON divisao.cod_dep = departamento.cod_dep
INNER JOIN empregado ON divisao.cod_divisao = empregado.lotacao_div
INNER JOIN
	(SELECT empregado.matr, COALESCE(SUM(vencimento.valor), 0) AS salario
	FROM empregado
	LEFT JOIN emp_venc ON empregado.matr = emp_venc.matr
	LEFT JOIN vencimento ON emp_venc.cod_venc = vencimento.cod_venc
	GROUP BY empregado.matr) AS vencimento_total ON vencimento_total.matr = empregado.matr
INNER JOIN 
	(SELECT empregado.matr, COALESCE(SUM(desconto.valor), 0) AS descontos
	FROM empregado
	LEFT JOIN emp_desc ON empregado.matr = emp_desc.matr
	LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
	GROUP BY empregado.matr) AS desconto_total ON empregado.matr = desconto_total.matr
WHERE (vencimento_total.salario - desconto_total.descontos) >= 8000.0
GROUP BY empregado.nome, empregado.lotacao_div
ORDER BY empregado.lotacao_div

--3001
SELECT 
	p.name, 
	CASE 
		WHEN p.type = 'A' THEN 20.0
	 	WHEN p.type = 'B' THEN 70.0
	 	ELSE 530.5 
	END AS price
FROM products p
ORDER BY price, p.id DESC





