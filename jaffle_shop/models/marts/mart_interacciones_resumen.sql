SELECT
    consejeria,
    
    unidad_descripcion AS unidad,
    DATE_TRUNC(month, fecha_entrada) AS mes,

    COUNT(*) AS total_interacciones,

    SUM(CASE WHEN UPPER(tipo) = 'QUEJA' THEN 1 END) AS total_quejas,

    coalesce(
        SUM(CASE WHEN UPPER(tipo) = 'QUEJA' THEN 1 END) 
        / NULLIF(COUNT(*), 0),
        0
    ) AS pct_quejas,

    coalesce(
        SUM(CASE WHEN UPPER(tipo) = 'QUEJA' THEN 1 END) 
        / NULLIF(SUM(CASE WHEN UPPER(tipo) IN ('QUEJA', 'SUGERENCIA') THEN 1 END), 0),
        0
    ) AS pct_quejas_sugerencias,

    coalesce(
    SUM(
        CASE 
            WHEN UPPER(tipo) = 'QUEJA'
             AND estado ILIKE '%RECHAZADA%'
            THEN 1 
        END
    ) ,0 ) AS quejas_rechazadas,

    coalesce(
    SUM(
        CASE 
            WHEN UPPER(tipo) = 'QUEJA'
             AND UPPER(estado) ILIKE '%RECHAZADA%'
            THEN 1 
        END
    )
    / NULLIF(
        SUM(CASE WHEN UPPER(tipo) = 'QUEJA' THEN 1 END),
        0
    ),0 ) AS pct_quejas_rechazadas,

    coalesce(
    AVG(DATEDIFF(day, fecha_entrada, fecha_contestacion)),0 ) AS avg_tiempo_respuesta,

    coalesce(
    SUM(CASE WHEN DATEDIFF(day, fecha_entrada, fecha_contestacion) > 30 THEN 1 END)
        / COUNT(*), 0 ) AS pct_fuera_plazo

FROM {{ ref('int_interacciones_ciudadanas') }}
GROUP BY 1,2,3
ORDER BY mes DESC, consejeria, unidad