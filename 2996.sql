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