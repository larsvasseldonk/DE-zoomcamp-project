select 
    season,
    team,
    sum(goals_conceded) as total_goals_conceded,
    rank() over (order by sum(goals_conceded)) as goals_ranking 
    from {{ ref('fct_ranking') }}
group by season, team
order by sum(goals_conceded)