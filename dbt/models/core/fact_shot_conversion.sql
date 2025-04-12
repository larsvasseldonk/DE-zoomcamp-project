with cte as 
    (select 
        season, 
        team, 
        sum(goals_scored) as goals_scored, 
        sum(shots_on_target) as shots_on_target from {{ ref('stg_shot_conversion')  }}
    group by season,team) 
select *, 
    cast(goals_scored/shots_on_target*100 as numeric) as conversion_rate 
from cte 
order by season,conversion_rate desc