select 
    season, 
    date, 
    HomeTeam as team, 
    "Home" as side, 
    FullTimeHomeTeamGoals as goals_scored, 
    FullTimeAwayTeamGoals as goals_conceded,
    {{ home_match_result('FullTimeHomeTeamGoals', 'FullTimeAwayTeamGoals') }} as result
from
    {{ source('project_zoomcamp', 'premierleague_dataset') }}