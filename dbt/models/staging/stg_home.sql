select 
    season, 
    date, 
    HomeTeam as team, 
    "Home" as side, 
    FullTimeHomeTeamGoals as goals_scored, 
    FullTimeAwayTeamGoals as goals_conceded,
    {{ home_match_result('FullTimeHomeTeamGoals', 'FullTimeAwayTeamGoals') }} as result
from
    `capstone-455515.capstone_dataset_2025.premierleague_dataset`
    
/*{{ source('staging', 'premierleague_dataset') }}*/