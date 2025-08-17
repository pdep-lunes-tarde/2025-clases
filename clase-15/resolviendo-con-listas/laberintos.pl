% Construimos un laberinto a resolver, en este caso
% usamos // para las paredes,
% .. para los caminos,
% <> para la salida del laberinto, y
% @- para la posicion en la que estamos
pared(//).
libre(..).
llegada(<>).
jugador(@-).

% El laberinto esta representado como una matriz, y esta matriz
% a su vez la representamos con una lista de listas.

% No es la única forma de representar el problema. Por ejemplo, podríamos
% tener por un lado el laberinto (paredes y caminos) y por fuera de eso
% la posición inicial y/o la final.
problema([
    [//, //, .., <>],
    [//, //, .., //],
    [//, .., .., //],
    [.., .., //, //],
    [@-, //, //, //]
    ]).
% la solucion debería ser:
%   // //  ↑  →
%   // //  ↑ //
%   //  ↑  → //
%    ↑  → // //
%   @- // // //
% es decir: ↑ → ↑ → ↑ ↑ → , en ese orden

% Definimos cuales son los movimientos posibles
accion_posible(arriba).
accion_posible(abajo).
accion_posible(izquierda).
accion_posible(derecha).

realizar_accion(Accion, LaberintoActual, LaberintoResultado):-
    % obtenemos la posicion actual
    posicion_actual(LaberintoActual, Posicion),
    % calculamos la posicion segun el movimiento
    posicion_tras_moverse(Posicion, Accion, NuevaPosicion),
    % % si la posicion es valida (no es pared ni se va de los limites), seguimos
    % posicion_es_valida(NuevaPosicion, LaberintoActual),
    % generamos un nuevo laberinto moviendo el @- de la posicion actual a la nueva
    mover_pieza(Posicion, NuevaPosicion, LaberintoActual, LaberintoResultado).

dar_un_paso(Accion, LaberintoActual, LaberintoSiguiente):-
    accion_posible(Accion),
    realizar_accion(Accion, LaberintoActual, LaberintoSiguiente).

resuelto(LaberintoInicial, LaberintoActual):-
    posicion_llegada(LaberintoInicial, Posicion),
    posicion_actual(LaberintoActual, Posicion).
    
posicion_llegada(Laberinto, Posicion):-
    llegada(Llegada),
    nth0_matrix(Posicion, Laberinto, Llegada).

posicion_actual(Laberinto, Posicion):-
    jugador(Jugador),
    nth0_matrix(Posicion, Laberinto, Jugador).

nth0_matrix(posicion(X, Y), Matrix, Element):-
    nth0(Y, Matrix, Row),
    nth0(X, Row, Element).

nth0_matrix(posicion(X, Y), Matrix, Element, MatrixWithoutElement):-
    % nth0\4 lanza un error si el indice es negativo, asi que me aseguro que X e Y pertenezcan a la matriz
    nth0_matrix(posicion(X, Y), Matrix, _),
    % dejando como incognita la cuarta variable, se liga la matriz sin esa fila
    nth0(Y, Matrix, Row, MatrixWithoutRow),
    % dejando como incognita la cuarta variable, se liga la fila en si sin ese elemento
    nth0(X, Row, Element, RowWithoutElement),
    %                            ^----------------------------------------------------------V
    % dejando como incognita esta vez la segunda variable, se liga una nueva matriz con la fila sin el elemento
    nth0(Y, MatrixWithoutElement, RowWithoutElement, MatrixWithoutRow). %

reemplazar_en_matriz(Posicion, Matriz, ViejoElemento, NuevoElemento, NuevaMatriz):-
    % el ViejoElemento no es necesario para poder hacer este reemplazo, pero sirve como validacion,
    % si la matriz no tuviese ese elemento, esta consulta daria false
    nth0_matrix(Posicion, Matriz, ViejoElemento, MatrizSinViejoElemento),
    nth0_matrix(Posicion, NuevaMatriz, NuevoElemento, MatrizSinViejoElemento).

posicion_tras_moverse(posicion(X, Y), arriba, posicion(X, NuevaY)):- NuevaY is Y - 1.
posicion_tras_moverse(posicion(X, Y), abajo, posicion(X, NuevaY)):- NuevaY is Y + 1.
posicion_tras_moverse(posicion(X, Y), izquierda, posicion(NuevaX, Y)):- NuevaX is X - 1.
posicion_tras_moverse(posicion(X, Y), derecha, posicion(NuevaX, Y)):- NuevaX is X + 1.

posicion_es_valida(Posicion, Laberinto):-
    nth0_matrix(Posicion, Laberinto, Elemento), % solo es verdad si la posicion esta dentro del laberinto
    not(pared(Elemento)).

mover_pieza(Posicion, NuevaPosicion, Laberinto, LaberintoResultado):-
    jugador(Jugador),
    libre(CaminoLibre),
    % reemplazamos el @- en el laberinto por un ..
    reemplazar_en_matriz(Posicion, Laberinto, Jugador, CaminoLibre, LaberintoSinJugador),
    % en la posicion a la que se movio, reemplazamos el .. por @-
    reemplazar_en_matriz(NuevaPosicion, LaberintoSinJugador, CaminoLibre, Jugador, LaberintoResultado).
mover_pieza(Posicion, NuevaPosicion, Laberinto, LaberintoResultado):-
    jugador(Jugador),
    llegada(Llegada),
    libre(CaminoLibre),
    reemplazar_en_matriz(Posicion, Laberinto, Jugador, CaminoLibre, LaberintoSinJugador),
    reemplazar_en_matriz(NuevaPosicion, LaberintoSinJugador, Llegada, Jugador, LaberintoResultado).

%% Hasta acá es simple, la parte complicada es no caer en bucles
%% Solucion naive (no funciona)
% solucion(Laberinto, [Paso]):-
%     dar_un_paso(Paso, Laberinto, LaberintoResuelto),
%     resuelto(Laberinto, LaberintoResuelto).
% solucion(Laberinto, [Paso | SiguientesPasos]):-
%     dar_un_paso(Paso, Laberinto, LaberintoEnProgreso),
%     % si esta resuelto no necesitamos seguir recorriendo
%     not(resuelto(Laberinto, LaberintoEnProgreso)),
%     solucion(LaberintoEnProgreso, SiguientesPasos).
%
%% Esa solución no siempre funciona, puede quedar en un bucle al ir y venir entre las mismas posiciones
%% Para solucionar eso, podemos pasar una lista de cuales fueron los estados del laberinto ya recorridos,
%% como para asegurarnos que no estemos pasando 2 veces por un laberinto conocido.

solucion(Laberinto, Pasos):-
    solucion(Laberinto, Pasos, []).

% solucion(Laberinto, PasosDeLaSolucion, LaberintosPrevios)
% necesitamos los LaberintosPrevios para asegurarnos que un paso no nos vuelva a llevar a un laberinto ya explorado,
% porque entrariamos en un bucle.
solucion(Laberinto, [Paso], _):-
    dar_un_paso(Paso, Laberinto, LaberintoResuelto),
    resuelto(Laberinto, LaberintoResuelto).
solucion(Laberinto, [Paso | SiguientesPasos], LaberintosPrevios):-
    dar_un_paso(Paso, Laberinto, LaberintoEnProgreso),
    % si esta resuelto no necesitamos seguir recorriendo
    not(resuelto(Laberinto, LaberintoEnProgreso)),
    % descartamos el camino si ya pasamos por acá
    not(member(LaberintoEnProgreso, LaberintosPrevios)),
    solucion(LaberintoEnProgreso, SiguientesPasos, [Laberinto | LaberintosPrevios]).

%% Solucion por fuerza bruta
%% Generamos todas las combinaciones posibles de movimientos, y luego validamos si alguno de ellos nos lleva a un laberinto resuelto
%% Le ponemos un LimiteDeAcciones para que no se quede buscando infinitos resultados y en algun momento termine.
solucion_fuerza_bruta(Laberinto, Acciones, LimiteDeAcciones):-
    between(0, LimiteDeAcciones, CantidadDeAcciones),
    length(Acciones, CantidadDeAcciones),
    serie_de_acciones_posibles(Acciones),
    aplicar_acciones(Acciones, Laberinto, LaberintoFinal),
    resuelto(Laberinto, LaberintoFinal).

aplicar_acciones([], Laberinto, Laberinto).
aplicar_acciones([Accion | Acciones], Laberinto, LaberintoFinal):-
    dar_un_paso(Laberinto, Accion, LaberintoSiguiente),
    aplicar_acciones(Acciones, LaberintoSiguiente, LaberintoFinal).

serie_de_acciones_posibles(Acciones):-
    length(Acciones, _),
    todos_son_acciones_posibles(Acciones).

todos_son_acciones_posibles([]).
todos_son_acciones_posibles([Accion | Acciones]):-
    accion_posible(Accion),
    todos_son_acciones_posibles(Acciones).

%% Para visualizar:
%% writeln escribe al stdout.

resolver_y_dibujar(Laberinto):-
    solucion(Laberinto, Pasos),
    dibujar_solucion(Laberinto, Pasos).

dibujar_laberinto(Laberinto):-
    forall(member(Fila, Laberinto),
            (forall(member(Elemento, Fila), write(Elemento)), writeln(""))).

dibujar_solucion(Laberinto, Pasos):-
    writeln("Laberinto Inicial"),
    writeln("-----------------"),
    dibujar_laberinto(Laberinto),
    writeln("-----------------"),
    dibujar_pasos(Pasos, Laberinto).

dibujar_pasos([], _).
dibujar_pasos([Paso | Pasos], Laberinto):-
    writeln(Paso),
    realizar_accion(Paso, Laberinto, LaberintoDespues),
    dibujar_laberinto(LaberintoDespues),
    writeln("----------"),
    dibujar_pasos(Pasos, LaberintoDespues).
