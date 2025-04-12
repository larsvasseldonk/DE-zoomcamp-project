SELECT 
    date,
    team,
    {{ streak('result') }} as away_result 
FROM {{ ref('stg_away') }}