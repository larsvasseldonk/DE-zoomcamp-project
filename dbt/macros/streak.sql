{% macro streak(result) %}
  case when result<>"Lose" then "Unbeaten" else "Loss" end
{% endmacro %}