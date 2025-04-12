SELECT 
    date,
    team,
    {{ streak('result') }} as home_result 
FROM {{ ref('stg_home') }}