# 📊 Resumen funcional del modelo dbt  
### *Análisis mensual de interacciones ciudadanas por consejería y unidad*

## 🎯 Objetivo del modelo
Este modelo dbt tiene como propósito **agregar, clasificar y evaluar** las interacciones ciudadanas registradas por cada *consejería* y *unidad administrativa*, generando métricas clave que permiten analizar:

- Volumen total de interacciones.
- Proporción de quejas respecto al total.
- Proporción de quejas dentro del conjunto de quejas + sugerencias.
- Tasa de quejas rechazadas.
- Tiempos de respuesta.
- Incumplimientos de plazos (más de 30 días).

El resultado es una tabla mensual que sirve como base para **cuadros de mando**, **indicadores de calidad**, y **seguimiento del desempeño institucional**.

---

## 🧱 Fuente de datos
El modelo se alimenta de:

```
int_interacciones_ciudadanas
```

que contiene registros individuales de interacciones con campos como:

- `consejeria`
- `unidad_descripcion`
- `fecha_entrada`
- `fecha_contestacion`
- `tipo` (queja, sugerencia, etc.)
- `estado` (incluye valores como “rechazada”)

---

## 🧮 Métricas calculadas

### 1. **Total de interacciones**
Cuenta todas las interacciones registradas en el mes.

### 2. **Total de quejas**
Cuenta únicamente las interacciones cuyo tipo es `QUEJA`.

### 3. **Porcentaje de quejas sobre el total**
\[
\text{pct\_quejas} = \frac{\text{quejas}}{\text{interacciones\_totales}}
\]

### 4. **Porcentaje de quejas sobre (quejas + sugerencias)**
\[
\text{pct\_quejas\_sugerencias} = \frac{\text{quejas}}{\text{quejas + sugerencias}}
\]

### 5. **Quejas rechazadas**
Cuenta las quejas cuyo estado contiene “rechazada”.

### 6. **Porcentaje de quejas rechazadas**
\[
\text{pct\_quejas\_rechazadas} = \frac{\text{quejas\_rechazadas}}{\text{quejas}}
\]

### 7. **Tiempo medio de respuesta**
Promedio de días entre `fecha_entrada` y `fecha_contestacion`.

### 8. **Porcentaje fuera de plazo (>30 días)**
\[
\text{pct\_fuera\_plazo} = \frac{\text{interacciones\_con\_respuesta\_>30d}}{\text{interacciones\_totales}}
\]

---

## 📅 Nivel de agregación
Los datos se agrupan por:

- **Consejería**
- **Unidad**
- **Mes** (`DATE_TRUNC(month, fecha_entrada)`)

Esto permite un análisis temporal consistente y comparable.

---

## 📈 Utilidad del modelo
Este modelo es clave para:

- **Monitorizar la calidad del servicio** de atención ciudadana.
- **Detectar unidades con altos niveles de quejas o rechazos**.
- **Evaluar tiempos de respuesta y cumplimiento de plazos**.
- **Generar KPIs institucionales** para informes mensuales o dashboards.
- **Identificar tendencias y anomalías** en la relación con la ciudadanía.

---

## 🧩 Rol dentro del proyecto dbt
Dentro del ecosistema dbt, este modelo probablemente actúa como:

- **Modelo intermedio o mart analítico**, consolidando datos limpios y transformados.
- **Base para modelos aguas abajo**, como dashboards en Power BI, Looker, Tableau, etc.
- **Pieza clave en la capa de métricas**, ya que estandariza definiciones como “queja”, “rechazada”, “fuera de plazo”.

