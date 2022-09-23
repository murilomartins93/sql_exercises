--2994
SELECT d.name,
ROUND(SUM(att.hours * 150 * (1 + ws.bonus / 100)), 1) AS salary
FROM doctors d 
INNER JOIN attendances att ON att.id_doctor = d.id
INNER JOIN work_shifts ws ON ws.id = att.id_work_shift
GROUP BY d.name
ORDER BY salary DESC