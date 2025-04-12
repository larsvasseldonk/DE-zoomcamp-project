SELECT 
    date,
    team,
    {{ streak('result') }} as home_result 
FROM {{ ref('stg_home') }}


SELECT date,team,case when result<>"Lose" then "Unbeaten" else "Loss" end as away_result FROM `capstone-455515.capstone_dataset_2025.premierleague_awaydata`
where side="Away";