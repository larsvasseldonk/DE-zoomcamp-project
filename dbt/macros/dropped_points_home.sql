{% macro dropped_points_home(FullTimeResult) %}
  
  case 
    when {{ FullTimeResult }}='D' then 2 
    when {{ FullTimeResult }}='A' then 3 
  end

{% endmacro %}