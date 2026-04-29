{% macro get_max_loaded_date(table_ref, date_column) %}
    (
        SELECT COALESCE(MAX({{ date_column }}), '1900-01-01')
        FROM {{ table_ref }}
    )
{% endmacro %}
