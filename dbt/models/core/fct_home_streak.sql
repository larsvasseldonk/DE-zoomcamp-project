with 
    previous_home as 
        (select 
            team, 
            date, 
            home_result, 
            lag(home_result,1) over (partition by team order by date) as previous_home_result 
        from {{ ref('stg_home_streak') }}), 
    indicator as 
        (select *, 
            case when home_result<>previous_home_result then 1 else 0 end as change_indicator 
        from previous_home),
    streak as 
        (select *, 
            sum(change_indicator) over (partition by team order by date) as streak_identifier 
        from indicator)
    select 
        team, 
        min(date) as unbeaten_start_date, 
        max(date) as unbeaten_end_date, 
        concat("From ", min(date), " to ", max(date)) as unbeaten_period,
        count(streak_identifier) as unbeaten_match_count,
        rank() over (order by count(streak_identifier) desc) as home_streak_ranking 
    from streak
    where home_result='Unbeaten'
    group by team,streak_identifier 
    order by count(streak_identifier) desc