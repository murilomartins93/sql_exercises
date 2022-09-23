--2743
SELECT name, CHAR_LENGTH(name) AS length
FROM people
ORDER BY length DESC