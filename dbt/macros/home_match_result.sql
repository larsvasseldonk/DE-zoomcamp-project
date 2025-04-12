{% macro home_match_result(FullTimeHomeTeamGoals, FullTimeAwayTeamGoals) %}
  case 
    when {{ FullTimeHomeTeamGoals }} = {{ FullTimeAwayTeamGoals }} then "Draw"
    when {{ FullTimeHomeTeamGoals }} > {{ FullTimeAwayTeamGoals }} then "Win" 
    else "Lose" 
  end 

{% endmacro %}