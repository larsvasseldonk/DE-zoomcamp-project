{{ config(materialized='table') }}

SELECT * FROM {{ source('project_zoomcamp', 'premierleague_dataset') }}
where season = '2023/24'
ORDER BY date