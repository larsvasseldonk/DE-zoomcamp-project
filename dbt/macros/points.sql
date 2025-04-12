{% macro points() %}
  case when result="Win" then 3 when result="Draw" then 1 end
{% endmacro %}