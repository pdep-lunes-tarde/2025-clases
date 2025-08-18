# Práctica para el parcial

## Expedición del Conicet al cañón submarino de Mar del Plata

Contamos con los primeros datos de la expedición que se realizó en el cañón submarino de Mar del Plata y queremos modelarlos en Prolog para realizar ciertas consultas sobre los mismos. 

Todos los predicados principales deben ser completamente inversibles.

## Modelo de Datos

Todos los datos pertenecen a solo un día de la expedición, por lo que simplificaremos un poco el modelado para que solo tenga en cuenta la hora del día.

### Vistas del Stream

Contamos con los datos de cuantas vistas hubo en el stream a lo largo de las horas, en la forma del predicado `vistas\2`, que relaciona una hora con la cantidad de vistas en el stream.

```prolog
vistas(15, 18500).  % A las 15hs hubo 18.500 espectadores
vistas(22, 12000).  % A las 22hs hubo 12.000 espectadores
```

### Descubrimientos Marinos

Queremos representar los distintos descubrimientos que se hicieron. Llamaremos descubrimiento a cada vez que se observó o recolectó un animal durante la expedición. Los datos con los que contamos de cada descubrimiento son:
- Un identificador del descubrimiento, para poder diferenciar distintos descubrimientos de la misma especie de animal.
- La especie del animal.
- Una serie de características observadas.
- A que profundidad fue encontrado.
- A que hora del día se realizó el descubrimiento.
- Si fue solo observado o si también fue recolectado.

Contamos con estos datos:

| Descubrimiento | Especie | Características | Profundidad (m) | Hora | Tipo |
|---------|------------------|-----------------|------|------|------|
| a1 | pulpo | extremidades: 8, luminisciencia | 3400 | 07 | observado |
| a2 | pulpo | extremidades: 8, color(azul) | 3150 | 08 | observado |
| b1 | estrella | extremidades: 5, color: naranja, culona | 3400 | 12 | observado |
| c1 | pepino_de_mar | color: violeta | 1900 | 14 | observado |
| d1 | anemona | extremidades: 30 | 1900 | 15 | recolectado |
| d2 | anemona | extremidades: 35 | 2200 | 16 | recolectado |
| c2 | pepino_pelagico | transparente, luminisciencia | 2800 | 17 | recolectado |
| e1 | pez_linterna | luminisciencia, color: rojo | 3200 | 19 | observado |
| a2 | pulpo_de_cristal | transparente, fragil | 3800 | 21 | recolectado |
| a3 | pulpo_dumbo | extremidades: 10, color: gris | 3900 | 23 | observado |

### Clasificación de Zonas Oceánicas

Las profundidades del océano se clasifican en diferentes zonas según la siguiente tabla:

- **Zona fótica**: hasta los 610 metros
- **Zona batial**: entre los 1.000 y los 4.000 metros
- **Zona abisal**: entre los 4.000 y los 6.000 metros
- **Zona hadal**: más de 6.000 metros

## Requerimientos

### 1. Zonas oceánicas

Implementar un predicado que nos permita relacionar una profunidad en metros con la zona oceánica correspondiente.

### 2. Favorita del Público

Queremos saber cuál especie fue la favorita del público. Es decir, cuál o cuáles especies fueron descubiertas en la hora en la que más vistas hubo en el stream.

### 3. Especies por zona

- a) Se requiere conocer en qué zonas oceánicas fue descubierta una especie.
- b) También, queremos saber cuál fue la zona oceánica en la que mas descubrimientos se realizaron.

### 4. Promedio de vistas

Se pide calcular cual fue el promedio de visualizaciones por hora del stream de la expedición. 

### 5. Variación de Profundidad del Submarino

Dadas dos horas, queremos conocer cual fue la variación de profundidad del submarino SuBastian.

**Nota**: Solo tenemos datos de profundidad respecto de los animales descubiertos, por lo que la profundidad del submarino en cada hora corresponde a la profundidad de los descubrimientos realizados en esa hora.

### 6. Descenso Más Rápido

Queremos saber en cual rango de 2 horas el submarino realizó el descenso más rápido.
La velocidad del descenso es la variación de profundidad dividido el tiempo transcurrido.

### 7. Nivel de Novedad

Queremos conocer el nivel de novedad de un descubrimiento, lo cual se calcula como la sumatoria de unidades de conocimiento que proporciona cada característica observada.

Unidades de conocimiento que aporta cada característica:
- `luminisciencia`: 5 unidades
- `extremidades`: 1 por cada extremidad
- `color`: si de un color que indica peligro, 5 unidades, si no 3.
    - los colores que indican peligro son el rojo y el amarillo.
- Cualquier característica no registrada: 10 unidades

Además, si el animal fue **recolectado**, el nivel de novedad es un **50% más** que si hubiese sido solo **observado**.
