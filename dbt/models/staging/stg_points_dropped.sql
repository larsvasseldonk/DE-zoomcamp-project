select 
    season, 
    date, 
    HomeTeam as team, 
    'Home' as side, 
    HalfTimeResult, 
    FullTimeResult, 
    {{ dropped_points_home('FullTimeResult') }} as points_dropped
from {{ source('zoomcamp', 'premierleague_dataset') }} 
where HalfTimeResult="H" and FullTimeResult <> "H"

union all

select 
    season,
    date,
    AwayTeam as team, 
    'Away' as side, 
    HalfTimeResult, 
    FullTimeResult, 
    {{ dropped_points_away('FullTimeResult') }} as points_dropped
from {{ source('zoomcamp', 'premierleague_dataset') }} 
where HalfTimeResult="A" and FullTimeResult <> "A"