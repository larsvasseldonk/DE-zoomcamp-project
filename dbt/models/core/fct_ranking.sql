SELECT 
    season,
    team, 
    sum({{ points('result') }}) as points, 
    sum(goals_scored) as goals_scored, 
    sum(goals_conceded) as goals_conceded, 
    sum(goals_scored) - sum(goals_conceded) as goal_difference 
FROM {{ ref('stg_ranking') }}
group by season, team 
order by season, points desc, goal_difference desc, goals_scored desc;