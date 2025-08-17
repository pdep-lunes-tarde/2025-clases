# Calculadora de IPC de Sueldos Docentes UTN

La idea de este proyecto es poder analizar la evolución de los salarios docentes de la Universidad Tecnológica Nacional (UTN) en comparación con el Índice de Precios al Consumidor (IPC) argentino.

## ¿Cómo lo pruebo?

Necesitas tener instalado [swi prolog](https://www.pdep.com.ar/software/swi-prolog).

Estando en la raíz del proyecto, corré:
```bash
swipl salarios.pl
```

## ¿Qué puedo consultar?

### `salario/3`
Consulta el salario básico de un docente en una fecha específica.

**Sintaxis:**
```prolog
salario(cargo(Dedicacion, Categoria), fecha(Anio, Mes), Salario).
```

**Ejemplo:**
```prolog
?- salario(cargo(exclusiva, titular), fecha(2025, 5), Salario).
Salario = 1327629.98.
```

### `diferencia_entre_salario_real_e_ipc/5`
Calcula la diferencia entre el salario real y el ajustado por IPC entre dos fechas.

**Sintaxis:**
```prolog
diferencia_entre_salario_real_e_ipc(Tipo, Cargo, FechaInicial, FechaFinal, Diferencia).
```

Donde `Tipo` puede ser:
- `absoluta`: Diferencia en pesos
- `porcentual`: Diferencia en porcentaje

**Ejemplo:**
```prolog
?- diferencia_entre_salario_real_e_ipc(porcentual, cargo(exclusiva, titular), fecha(2023, 11), fecha(2025, 5), DiferenciaPorcentual).
DiferenciaPorcentual = -38.98.
```

## ¿De donde vienen los datos?

Los datos de los sueldos provienen de estas tablas realizadas por SIDUT:
- https://www.sidut.org.ar/images/Documentos/Salarios_2022.pdf
- https://www.sidut.org.ar/images/Documentos/Salarios_2023.pdf
- https://www.sidut.org.ar/images/Documentos/Salarios_2024.pdf
- https://www.sidut.org.ar/images/Documentos/Salarios_2025.pdf

y los del ipc los armé a partir de este archivo de la página del INDEC:
- https://www.indec.gob.ar/indec/web/Institucional-Indec-calculadora_variaciones_IPC

## ¿Cómo extiendo esto?

Hay algunos datos faltantes, como los salarios en algunos meses que no estoy seguro si no estaban porque se mantenían del mes anterior, pero para no asumir nada no se están cargando a la base de conocimientos y consultar sobre esos meses va a dar `false`.
Si tenés esos datos y queres completarlos, o, si queres agregar cualquier otra funcionalidad (cómo otros predicados que puedan ser interesantes), mandá un PR nomás :).
