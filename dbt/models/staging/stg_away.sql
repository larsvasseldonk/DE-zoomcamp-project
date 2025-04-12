select 
    season, 
    date, 
    AwayTeam as team, 
    "Away" as side, 
    FullTimeAwayTeamGoals as goals_scored, 
    FullTimeHomeTeamGoals as goals_conceded,
    {{ away_match_result('FullTimeHomeTeamGoals', 'FullTimeAwayTeamGoals') }} as result
from
    {{ source('project_zoomcamp', 'premierleague_dataset') }}