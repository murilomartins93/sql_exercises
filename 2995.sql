--2995
SELECT r.temperature, COUNT(r.temperature) AS number_of_records
FROM records r
GROUP BY r.temperature, r.mark
ORDER BY r.mark