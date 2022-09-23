--2625
SELECT SUBSTRING(cpf FROM 1 FOR 3) || '.' || 
	   SUBSTRING(cpf FROM 4 FOR 3) || '.' || 
	   SUBSTRING(cpf FROM 7 FOR 3) || '-' ||
       SUBSTRING(cpf FROM 10 FOR 2) AS Cpf 
FROM natural_person;

		 -- OR
		 
SELECT CONCAT(SUBSTRING(cpf FROM 1 FOR 3), '.', 
			  SUBSTRING(cpf FROM 4 FOR 3), '.',
			  SUBSTRING(cpf FROM 7 FOR 3), '-',
			  SUBSTRING(cpf FROM 10 FOR 2)) AS Cpf
FROM natural_person;