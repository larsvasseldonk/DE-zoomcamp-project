select 
    season,
    team,
    sum(goals_scored) as total_goals_scored 
from {{ ref('fct_ranking') }}
group by season,AwayTeam
order by sum(goals_scored) desc