select 
    season, 
    team, 
    sum(points_dropped) as total_points_dropped
from {{ ref('stg_points_dropped') }} 
group by season, team