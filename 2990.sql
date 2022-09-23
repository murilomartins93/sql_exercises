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