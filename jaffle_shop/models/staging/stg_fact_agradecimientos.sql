{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='id_registro'
) }}

WITH base AS (
    SELECT
        {{ clean_string('TIPO', 'DESCONOCIDO') }} AS tipo,
        {{ clean_string('ESTADO', 'DESCONOCIDO') }} AS estado,
        {{ clean_string('CANAL_ENTRADA', 'NO ESPECIFICADO') }} AS canal_entrada,

        COALESCE(FECHA_ENTRADA, '1900-01-01') AS fecha_entrada,
        COALESCE(FECHA_CONTESTACION, '1900-01-01') AS fecha_contestacion,

        {{ clean_string('CONSEJERIA', 'SIN CONSEJERIA') }} AS consejeria,
        {{ clean_string('UNIDAD_DESCRIPCION', 'SIN UNIDAD') }} AS unidad_descripcion,
        {{ clean_string('TEMA', 'SIN TEMA') }} AS tema,
        {{ clean_string('SUBTEMA', 'SIN SUBTEMA') }} AS subtema,

        ROW_NUMBER() OVER (
            PARTITION BY 
                {{ clean_string('TIPO') }},
                {{ clean_string('ESTADO') }},
                {{ clean_string('CANAL_ENTRADA') }},
                FECHA_ENTRADA,
                {{ clean_string('CONSEJERIA') }},
                {{ clean_string('UNIDAD_DESCRIPCION') }},
                {{ clean_string('TEMA') }},
                {{ clean_string('SUBTEMA') }}
            ORDER BY FECHA_ENTRADA DESC
        ) AS rn

    FROM {{ source('raw', 'FACT_AGRADECIMIENTOS') }}
)

SELECT
    *,
    {{ sk_interaccion(
        'tipo', 'estado', 'canal_entrada', 'fecha_entrada',
        'consejeria', 'unidad_descripcion', 'tema', 'subtema'
    ) }} AS id_registro

FROM base
WHERE rn = 1

{% if is_incremental() %}
  AND fecha_entrada >= {{ get_max_loaded_date(this, 'fecha_entrada') }}
{% endif %}
