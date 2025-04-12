with 
    previous_away as 
        (select 
            team, 
            date, 
            away_result, 
            lag(away_result,1) over (partition by team order by date) as previous_away_result 
        from {{ ref('stg_away_streak') }}), 
    indicator as 
        (select *, 
            case when away_result<>previous_away_result then 1 else 0 end as change_indicator 
        from previous_away),
    streak as 
        (select *, 
            sum(change_indicator) over (partition by team order by date) as streak_identifier 
        from indicator)
    select 
        team, 
        min(date) as unbeaten_start_date, 
        max(date) as unbeaten_end_date, 
        count(streak_identifier) as unbeaten_match_count 
    from streak
    where away_result='Unbeaten'
    group by team,streak_identifier 
    order by count(streak_identifier) desc