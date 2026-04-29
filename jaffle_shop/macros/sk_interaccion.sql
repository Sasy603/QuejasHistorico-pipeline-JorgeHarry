{% macro sk_interaccion(tipo, estado, canal, fecha, consejeria, unidad, tema, subtema) %}
    {{ dbt_utils.generate_surrogate_key([
        tipo, estado, canal, fecha, consejeria, unidad, tema, subtema
    ]) }}
{% endmacro %}
