{% macro clean_string(value, default='DESCONOCIDO') %}
    UPPER(TRIM(COALESCE({{ value }}, '{{ default }}')))
{% endmacro %}
