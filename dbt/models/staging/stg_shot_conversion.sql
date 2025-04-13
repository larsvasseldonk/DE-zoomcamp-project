with cte as (select 
    season, 
    HomeTeam as team, 
    "Home" as side, 
    sum(FullTimeHomeTeamGoals) as goals_scored, 
    sum(HomeTeamShotsOnTarget) as shots_on_target 
from 
    {{ source('zoomcamp', 'premierleague_dataset') }}
group by season, HomeTeam
union all
select 
    season, 
    AwayTeam as team,
    "Away" as side, 
    sum(FullTimeAwayTeamGoals) as goals_scored, 
    sum(AwayTeamShotsOnTarget) as shots_on_target 
from
     {{ source('zoomcamp', 'premierleague_dataset') }}
group by season, AwayTeam)
select*from cte