select 
    season,
    team,
    sum(goals_scored) as total_goals_scored,
    rank() over (order by sum(goals_scored) desc) as goals_scored_ranking 
from {{ ref('fct_ranking') }}
group by season, team
order by sum(goals_scored) desc