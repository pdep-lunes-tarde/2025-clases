:- module(cargaDeDatos, [salario/3, ipc/2]). % se exportan los predicados salario/3 e ipc/2
:- use_module(library(csv)).

cargar_salarios_de_csv(RutaAlArchivo, Anio):-
	csv_read_file(RutaAlArchivo, [Encabezado|Filas]),
	% csv_read_file/2 espera una ruta a un archivo y una lista, liga la lista con una de longitud
	% igual a la cantidad de lineas del csv, y donde cada elemento es un functor
	% con nombre row y aridad igual a la cantidad de columnas del csv.
	forall((member(Fila, Filas),
			salario_en_fila(Anio,
				Encabezado,
				Fila,
				salario(Cargo, Fecha, Salario))),
		assert_if_new(salario(Cargo, Fecha, Salario))). 
        % assert_if_new agrega una cláusula a un predicado, en este caso, agrega una cláusula al predicado salario/3

salario_en_fila(Anio, Encabezado, Fila, salario(cargo(Dedicacion, Categoria), fecha(Anio, NumeroDeMes), Salario)):-
	Encabezado =.. [row, _, _|NombresDeMes],
	% =.. liga un functor con una lista
	% por ej: row('CATEGORIA', 'DEDICACION', 'ENERO', 'FEBRERO') =.. Lista
	% liga Lista a
	% [row, 'CATEGORIA', 'DEDICACION', 'ENERO', 'FEBRERO']
	Fila =.. [row, Dedicacion, CategoriaComoString|SalariosPorMes],
	string_a_categoria(CategoriaComoString, Categoria),
	nth1(IndiceDeMes, NombresDeMes, Mes),
	mes(Mes, NumeroDeMes),
	nth1(IndiceDeMes, SalariosPorMes, Salario).

string_a_categoria('Titular', titular).
string_a_categoria('Asociado', asociado).
string_a_categoria('Adjunto', adjunto).
string_a_categoria('JTP', jtp).
string_a_categoria('Ayudante de 1era', ayudante_1era).
string_a_categoria('Ayudante de 2da', ayudante_2da).

nombresDeMes(['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE']).
nombresDeMes([ene, feb, mar, abr, may, jun, jul, ago, sept, oct, nov, dic]).

mes(NombreDeMes, NumeroDeMes):-
	nombresDeMes(NombresDeMes),
	nth1(NumeroDeMes, NombresDeMes, NombreDeMes).

%% Predicados auxiliares

assert_if_new(Term):-
	functor(Term, Name, Arity),
	% functor(functor(Param1, Param2), functor, 2) -> lo que hace es ligar un functor a su nombre y aridad
	not(current_predicate(Name/Arity)),
	% current_predicate chequea si un cierto predicado existe.
	assertz(Term).
	% assertz agrega un functor como una cláusula de un predicado
assert_if_new(Term):-
    ignore((
		% ignore realiza una consulta, y siempre es true sin importar el valor de verdad de la consulta.
        functor(Term, Name, Arity),
        current_predicate(Name/Arity),
        not(Term),
        assertz(Term)
    )).


%% string_mm_aa_a_fecha("mar-22", fecha(2022, 3)).
string_mmm_aa_a_fecha(String, fecha(Anio, NumeroDeMes)):-
	split_string(String, "-", "", [AbreviacionMesComoString, UltimosDosDigitosAnioComoString]),
	string_to_atom(AbreviacionMesComoString, AbreviacionMes),
	string_to_atom(UltimosDosDigitosAnioComoString, UltimosDosDigitosAnioComoAtomo),
	mes(AbreviacionMes, NumeroDeMes),
	atom_number(UltimosDosDigitosAnioComoAtomo, UltimosDosDigitosAnio),
	Anio is UltimosDosDigitosAnio + 2000.

%% CARGA DE DATOS a predicados

:- cargar_salarios_de_csv("salarios_2022.csv", 2022).
:- cargar_salarios_de_csv("salarios_2023.csv", 2023).
:- cargar_salarios_de_csv("salarios_2024.csv", 2024).
:- cargar_salarios_de_csv("salarios_2025.csv", 2025).

% calculador ipc https://www.indec.gob.ar/indec/web/Institucional-Indec-calculadora_variaciones_IPC
% datos obtenidos de: https://www.indec.gob.ar/ftp/cuadros/economia/sh_ipc_07_25.xls    
:- csv_read_file('indice-ipc.csv', [FilaMeses, FilaIPCs]),
    FilaMeses =.. [row | Meses],
    FilaIPCs =.. [row | IPCs],
    forall((nth1(I, Meses, MesComoString), nth1(I, IPCs, IPC)), (string_mmm_aa_a_fecha(MesComoString, Fecha), assert_if_new(ipc(Fecha, IPC)))).