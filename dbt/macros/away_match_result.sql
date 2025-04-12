{% macro away_match_result(FullTimeHomeTeamGoals, FullTimeAwayTeamGoals) %}
  case 
    when {{ FullTimeHomeTeamGoals }} = {{ FullTimeAwayTeamGoals }} then "Draw"
    when {{ FullTimeHomeTeamGoals }} > {{ FullTimeAwayTeamGoals }} then "Lose" 
    else "Win" 
  end 

{% endmacro %}