select 
    season,
    team,
    sum(goals_conceded) as total_goals_conceded
    from {{ ref('fct_ranking') }}
group by season, team
order by sum(goals_conceded)