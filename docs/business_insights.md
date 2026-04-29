#  **Business Insight – Calidad de Servicio y Gestión de Quejas (Dic 2025)**

## **1. Problema estructural: tiempos de respuesta negativos**
Muchas unidades presentan **AVG_TIEMPO_RESPUESTA negativo** (p. ej. -46.000, -27.000, -18.000).  
Esto indica **errores de registro**, **cargas mal calculadas** o **fechas invertidas**.

--> *Insight:* Antes de analizar desempeño, es imprescindible **corregir la calidad del dato**.  
Estas inconsistencias afectan a más del **40% de las unidades**.

---

## **2. Altísima proporción de quejas en la mayoría de unidades**
En la mayoría de consejerías, el **PCT_QUEJAS está entre 0.8 y 1.0**, incluso en unidades con pocas interacciones.

Esto significa que:
- O bien **la interacción registrada es casi siempre una queja**,  
- O el sistema **solo recoge interacciones cuando hay incidencias**.

--> *Insight:* El modelo de medición está sesgado hacia la queja.  

---

## **3. Casi ninguna queja es rechazada**
El campo **PCT_QUEJAS_RECHAZADAS = 0.0** en prácticamente todas las unidades.

Esto puede interpretarse como:
- Las quejas están **bien fundamentadas**, o  
- No existe un proceso claro de **evaluación y rechazo**.

--> *Insight:* Falta un mecanismo de clasificación y depuración de quejas.  
Esto impide distinguir entre **quejas legítimas** y **ruido administrativo**.

---

## **4. Unidades con mayor presión por volumen**
Las unidades con más interacciones y quejas (≥40) son:

| Consejería | Unidad | Interacciones | % Quejas |
|------------|--------|---------------|----------|
| Familia, Juventud y Asuntos Sociales | Agencia Madrileña de Atención Social | 46 | 0.89 |
| Familia, Juventud y Asuntos Sociales | DG Atención al Mayor y Dependencia | 107 | 0.93 |
| Sanidad | DG Humanización y Seguridad del Paciente | 73 | 0.93 |
| Educación | Área Territorial Madrid Capital | 30 | 0.93 |

--> *Insight:* Estas unidades concentran la mayor carga y deberían ser **prioridad en planes de mejora**.

---

## **5. Unidades con mejor desempeño relativo**
Pocas unidades muestran:
- **0% quejas**
- **0% fuera de plazo**
- **tiempos de respuesta positivos**

Ejemplos:
- DG Educación Infantil y Primaria (14.0, 0% quejas)
- Dirección de Ordenación y Control del Juego (49.0, 0% quejas)
- Secretaría General Técnica (Educación) (25.0, 0% quejas)

--> *Insight:* Estas unidades pueden servir como **benchmark interno** para procesos de atención.

---

## **6. Fuera de plazo: señales de saturación**
Unidades con **PCT_FUERA_PLAZO ≥ 0.4**:

- Cultura – Deportes (0.46)
- Familia – Infancia y Natalidad (0.5)
- Familia – Servicios Sociales (0.24–0.5)
- Medio Ambiente – Agricultura (0.4)
- Presidencia – Servicio 012 (0.5)
- Educación – Madrid Oeste (0.6)

--> *Insight:* Estas áreas muestran **riesgo operativo** 

---

# **Conclusión Ejecutiva**
    Los datos muestran un sistema de atención con **tres grandes retos estructurales**:

### **1. Calidad del dato insuficiente**
    Tiempos negativos y campos nulos impiden análisis fiable.

### **2. Sistema sesgado hacia la queja**
    La mayoría de interacciones registradas son quejas → falta visión completa del servicio.

### **3. Alta presión en unidades sociales, sanitarias y educativas**
    Las áreas con mayor impacto ciudadano son las más saturadas.

