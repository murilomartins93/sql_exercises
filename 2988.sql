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