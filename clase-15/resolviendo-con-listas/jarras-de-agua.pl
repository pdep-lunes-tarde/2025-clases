%% Este problema aparece en una pelicula de la saga de Duro de Matar
% https://www.youtube.com/watch?v=6cAbgAaEOVE

%% Contamos con 2 jarrones de agua, uno de 5 litros y otro de 3, y tenemos una fuente a disposicion
%% con la cual podemos llenar las jarras o vaciarlas.
%% Necesitamos conseguir exactamente 4 litros de agua.

%% Representamos el estado del problema, empezamos con ambos jarrones vacios, es decir,
%% con 0 litros cada uno.

capacidadJarron(grande(5)).
capacidadJarron(chico(3)).

problema(jarrones(grande(0), chico(0))).

%% representamos las acciones posibles:

accion_posible(vaciarJarronGrande).
accion_posible(vaciarJarronChico).
accion_posible(llenarJarronGrande).
accion_posible(llenarJarronChico).
accion_posible(servirDeJarronGrandeAJarronChico).
accion_posible(servirDeJarronChicoAJarronGrande).

%% representamos que pasa al hacer cada accion:

% realizar_accion(Accion, EstadoInicial, EstadoFinal)
realizar_accion(vaciarJarronGrande, jarrones(_, JarronChico), jarrones(grande(0), JarronChico)).
realizar_accion(vaciarJarronChico, jarrones(JarronGrande, _), jarrones(JarronGrande, chico(0))).
realizar_accion(llenarJarronGrande, jarrones(_, JarronChico), jarrones(grande(Capacidad), JarronChico)):-
    capacidadJarron(grande(Capacidad)).
realizar_accion(llenarJarronChico, jarrones(JarronGrande, _), jarrones(JarronGrande, chico(Capacidad))):-
    capacidadJarron(chico(Capacidad)).
realizar_accion(
    servirDeJarronGrandeAJarronChico,
    jarrones(grande(LitrosJarronGrande), chico(LitrosJarronChico)),
    jarrones(grande(LitrosJarronGrandeFinal), chico(LitrosJarronChicoFinal))
    ):-
        % servimos del jarron de 5 litros en el de 3 litros hasta llenar el jarron chico
        capacidadJarron(chico(CapacidadJarronChico)),
        between(0, CapacidadJarronChico, LitrosJarronChico),
        LitrosJarronChicoFinal is min(CapacidadJarronChico, LitrosJarronChico + LitrosJarronGrande),
        LitrosJarronGrandeFinal is LitrosJarronGrande - (LitrosJarronChicoFinal - LitrosJarronChico).
realizar_accion(
    servirDeJarronChicoAJarronGrande,
    jarrones(grande(LitrosJarronGrande), chico(LitrosJarronChico)),
    jarrones(grande(LitrosJarronGrandeFinal), chico(LitrosJarronChicoFinal))
    ):-
        capacidadJarron(grande(CapacidadJarronGrande)),
        between(0, CapacidadJarronGrande, LitrosJarronGrande),
        LitrosJarronGrandeFinal is min(CapacidadJarronGrande, LitrosJarronChico + LitrosJarronGrande),
        LitrosJarronChicoFinal is LitrosJarronChico - (LitrosJarronGrandeFinal - LitrosJarronGrande).

dar_un_paso(Accion, ProblemaInicial, ProblemaSiguiente):-
    accion_posible(Accion),
    realizar_accion(Accion, ProblemaInicial, ProblemaSiguiente).

resuelto(jarrones(grande(LitrosJarronGrande), chico(LitrosJarronChico))):-
    4 is LitrosJarronGrande + LitrosJarronChico.

solucion(Estado, Acciones):-
    solucion(Estado, Acciones, []).

solucion(Estado, [Accion], _):-
    dar_un_paso(Accion, Estado, EstadoResuelto),
    resuelto(EstadoResuelto).
solucion(Estado, [Accion | Acciones], EstadosPrevios):-
    dar_un_paso(Accion, Estado, EstadoSiguiente),
    not(member(EstadoSiguiente, EstadosPrevios)),
    Estado \= EstadoSiguiente,
    not(resuelto(EstadoSiguiente)),
    solucion(EstadoSiguiente, Acciones, [ Estado | EstadosPrevios ]).

%% Solucion por fuerza bruta
%% Generamos todas las combinaciones posibles de acciones, y luego validamos si alguno de ellos nos lleva al problema resuelto
%% Le ponemos un LimiteDeAcciones para que no se quede buscando infinitos resultados y en algun momento termine.

solucion_fuerza_bruta(Estado, Acciones, LimiteDeAcciones):-
    between(0, LimiteDeAcciones, CantidadDeAcciones),
    length(Acciones, CantidadDeAcciones),
    serie_de_acciones_posibles(Acciones),
    aplicar_acciones(Acciones, Estado, EstadoFinal),
    resuelto(EstadoFinal).

aplicar_acciones([], Estado, Estado).
aplicar_acciones([Accion | Acciones], Estado, EstadoFinal):-
    dar_un_paso(Accion, Estado, EstadoSiguiente),
    aplicar_acciones(Acciones, EstadoSiguiente, EstadoFinal).

serie_de_acciones_posibles(Acciones):-
    length(Acciones, _),
    todos_son_acciones_posibles(Acciones).

todos_son_acciones_posibles([]).
todos_son_acciones_posibles([Accion | Acciones]):-
    accion_posible(Accion),
    todos_son_acciones_posibles(Acciones).

%% Para visualizar:
%% writeln escribe al stdout.

resolver_y_dibujar(Problema):-
    solucion(Problema, Pasos),
    dibujar_jarrones(Problema),
    writeln("----------"),
    dibujar_pasos(Pasos, Problema).

dibujar_pasos([], _).
dibujar_pasos([Paso | Pasos], Estado):-
    writeln(Paso),
    realizar_accion(Paso, Estado, EstadoSiguiente),
    dibujar_jarrones(EstadoSiguiente),
    writeln("----------"),
    dibujar_pasos(Pasos, EstadoSiguiente).

dibujar_jarrones(Jarrones):-
    dibujar_altura(5, Jarrones),
    dibujar_altura(4, Jarrones),
    dibujar_altura(3, Jarrones),
    dibujar_altura(2, Jarrones),
    dibujar_altura(1, Jarrones),
    dibujar_numeros(Jarrones).

dibujar_numeros(jarrones(grande(LitrosGrande), chico(LitrosChico))):-
    write('   '), write(LitrosGrande), write('      '), write(LitrosChico), writeln('   ').

dibujar_altura(Altura, jarrones(grande(LitrosGrande), _)):-
    string_jarron_a_altura(Altura, LitrosGrande, StringJarronGrande),
    capacidadJarron(chico(CapacidadChico)),
    Altura > CapacidadChico,
    writeln(StringJarronGrande).
dibujar_altura(Altura, jarrones(grande(LitrosGrande), chico(LitrosChico))):-
    string_jarron_a_altura(Altura, LitrosGrande, StringJarronGrande),
    string_jarron_a_altura(Altura, LitrosChico, StringJarronChico),
    capacidadJarron(chico(CapacidadChico)),
    Altura =< CapacidadChico,
    write(StringJarronGrande), write("  "), write(StringJarronChico), writeln("").

string_jarron_a_altura(Altura, Litros, '|////|'):-
    Litros >= Altura.
string_jarron_a_altura(Altura, Litros, '|    |'):-
    Litros < Altura.


