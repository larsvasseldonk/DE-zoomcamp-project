{% macro dropped_points_away(FullTimeResult) %}
  
  case 
    when {{ FullTimeResult }}='D' then 2 
    when {{ FullTimeResult }}='H' then 3 
  end

{% endmacro %}