:- use_module(cargaDeDatos).

writelnColored(Color, Texto):-
    ansi_format([bg(Color)], Texto, []),
    writeln("").

ayuda:-
    writeln("#######################################"),
    writeln("Calculadora de IPC de sueldos docentes"),
    writeln("#######################################"),
    writeln(""),
    writeln("Podes saber cual es el salario basico de un docente de la UTN en un mes en particular consultando:"),
    writelnColored(green, "salario(cargo(Dedicacion, Categoria), fecha(Anio, Mes), Salario)."),
    writeln(""),
    writeln("Por ejemplo:"),
    writelnColored(green, "salario(cargo(exclusiva, titular), fecha(2025, 5), Salario)."),
    writeln(""),
    writeln("Tambien se puede usar el predicado diferencia_entre_salario_real_e_ipc para calcular"),
    writeln("como evoluciono un salario desde una fecha hasta otra comparado con el indice de precios al consumidor"),
    writeln("la consulta se podria ver asi:"),
    writelnColored(green, "diferencia_entre_salario_real_e_ipc(porcentual, cargo(exclusiva, titular), fecha(2023, 11), fecha(2025, 5), DiferenciaPorcentual)."),
    writeln("^ eso muestra como vario el poder adquisitivo entre noviembre de 2023 y mayo de 2025, en porcentaje"),
    writeln(""),
    writeln("Podes volver a mostrar este texto con la siguiente consulta:"),
    writelnColored(green, "ayuda."),
    writeln("").

:- ayuda.

% Estos predicados son definidos en cargadedatos.pl, y se pueden usar acá:
% salario(cargo(Dedicacion, Categoria), fecha(Anio, Mes), Salario).
% ipc(fecha(Anio, Mes), Indice).

cargo(Cargo):-
	distinct(Cargo, salario(Cargo, _, _)).

% Se calcula cuál debería ser el valor ajustado haciendo esta cuenta:
% (salario en fecha inicial) / (ipc en fecha inicial) * (ipc en fecha final)
salario_ajustado_por_ipc(Cargo, FechaInicial, FechaFinal, SalarioInicial, SalarioAjustado):-
	distinct(salario(Cargo, FechaInicial, SalarioInicial)),
	ipc(FechaInicial, IPCInicial),
	ipc(FechaFinal, IPCFinal),
	SalarioAjustado is SalarioInicial/IPCInicial*IPCFinal.

comparativa_salarios(Cargo, FechaInicial, FechaFinal, SalarioReal, SalarioAjustadoPorIPC):-
	salario_ajustado_por_ipc(Cargo, FechaInicial, FechaFinal, _, SalarioAjustadoPorIPC),
	salario(Cargo, FechaFinal, SalarioReal).

diferencia_entre_salario_real_e_ipc(absoluta, Cargo, FechaInicial, FechaFinal, Diferencia):-
	comparativa_salarios(Cargo, FechaInicial, FechaFinal, SalarioReal, SalarioAjustado),
	Diferencia is SalarioReal - SalarioAjustado.

diferencia_entre_salario_real_e_ipc(porcentual, Cargo, FechaInicial, FechaFinal, DiferenciaPorcentual):-
	diferencia_entre_salario_real_e_ipc(absoluta, Cargo, FechaInicial, FechaFinal, DiferenciaAbsoluta),
	salario(Cargo, FechaFinal, SalarioReal),
	DiferenciaPorcentual is DiferenciaAbsoluta/SalarioReal*100.

