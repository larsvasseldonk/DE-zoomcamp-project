select 
    season, 
    concat(HomeTeam, " vs " ,AwayTeam) as match, 
    concat(FullTimeHomeTeamGoals, "-", FullTimeAwayTeamGoals) as match_result, 
    abs(FullTimeHomeTeamGoals-FullTimeAwayTeamGoals) as goal_margin 
from {{ source('zoomcamp', 'premierleague_dataset') }} 
    order by goal_margin desc