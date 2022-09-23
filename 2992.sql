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