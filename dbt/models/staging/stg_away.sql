select 
    season, 
    date, 
    AwayTeam as team, 
    "Away" as side, 
    FullTimeAwayTeamGoals as goals_scored, 
    FullTimeHomeTeamGoals as goals_conceded,
    {{ away_match_result('FullTimeHomeTeamGoals', 'FullTimeAwayTeamGoals') }} as result
from
    {{ source('staging', 'premierleague_dataset') }}