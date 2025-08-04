naturalOCero(Natural):-
    between(0, inf, Natural).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Posible implementación sin between (avanzado, se puede ignorar)
%
% predicado recursivo auxiliar
%
% naturalOCeroAux(0).
% naturalOCeroAux(Natural):-
%     naturalOCeroAux(Anterior),
%     Natural is Anterior + 1.
%
% naturalOCero(N):-
%     var(N), % Solo entra si la variable N está libre (sin ligar)
%     naturalOCeroAux(N).
% naturalOCero(N):-
%     ground(N), % Solo entra si la variable N está ligada
%     naturalOCeroAux(N),
%     !. % ! le indica a prolog que no siga buscando soluciones si llegó acá.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

factorial(0, 1).
factorial(Numero, Factorial):-
    naturalOCero(Numero),
    Numero > 0,
    Predecesor is Numero - 1,
    factorial(Predecesor, FactorialAnterior),
    Factorial is Numero * FactorialAnterior.

% haskell:
% vacia [] = True
% vacia _ = False
vacia([]).

% haskell:
% primerElemento (primero : _) = primero
primerElemento([Primero | _], Primero).

segundoElemento([_, Segundo | _], Segundo).

% [Elemento] es una lista de un solo elemento que llamamos
% Elemento
ultimoElemento([Elemento], Elemento).
ultimoElemento([_ | Cola], Elemento):-
    ultimoElemento(Cola, Elemento).

longitud([], 0).
longitud([_ | Cola], Longitud):-
    longitud(Cola, LongitudCola),
    Longitud is LongitudCola + 1.

contiene([Elemento | _], Elemento).
contiene([_ | Cola], Elemento):-
    contiene(Cola, Elemento).

siguiente(Lista, Elemento, Siguiente):-
    nth0(Indice, Lista, Elemento),
    IndiceSiguiente is Indice + 1,
    nth0(IndiceSiguiente, Lista, Siguiente).

%% TEG

jugador(amarillo).
jugador(magenta).
jugador(azul).
jugador(verde).
jugador(negro).
jugador(rojo).

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).
continente(europa).
continente(africa).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelSur, peru).
estaEn(americaDelSur, colombia).

estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(americaDelNorte, nuevaYork).
estaEn(americaDelNorte, terranova).
estaEn(americaDelNorte, labrador).
estaEn(americaDelNorte, mexico).
estaEn(americaDelNorte, groenlandia).
estaEn(americaDelNorte, california).

estaEn(europa, islandia).
estaEn(europa, granBretania).
estaEn(europa, suecia).
estaEn(europa, rusia).
estaEn(europa, polonia).
estaEn(europa, alemania).
estaEn(europa, italia).
estaEn(europa, francia).
estaEn(europa, espania).

estaEn(asia, aral).
estaEn(asia, tartaria).
estaEn(asia, taimir).
estaEn(asia, kamchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(asia, mongolia).
estaEn(asia, iran).
estaEn(asia, gobi).
estaEn(asia, india).
estaEn(asia, malasia).
estaEn(asia, turquia).
estaEn(asia, israel).
estaEn(asia, arabia).

estaEn(oceania, australia).
estaEn(oceania, sumatra).
estaEn(oceania, java).
estaEn(oceania, borneo).

estaEn(africa, sahara).
estaEn(africa, egipto).
estaEn(africa, etiopia).
estaEn(africa, madagascar).
estaEn(africa, sudafrica).
estaEn(africa, zaire).

ocupa(aral, magenta).

ocupa(alaska, amarillo).
ocupa(yukon, amarillo).
ocupa(oregon, amarillo).
ocupa(canada, amarillo).
ocupa(groenlandia, amarillo).
ocupa(labrador, amarillo).
ocupa(terranova, amarillo).
ocupa(nuevaYork, amarillo).
ocupa(california, amarillo).
ocupa(mexico, amarillo).

ocupa(islandia, amarillo).
ocupa(suecia, amarillo).
ocupa(rusia, amarillo).
ocupa(polonia, amarillo).

ocupa(turquia, amarillo).

ocupa(sahara, amarillo).
ocupa(egipto, amarillo).
ocupa(etiopia, amarillo).
ocupa(zaire, amarillo).
ocupa(madagascar, amarillo).
ocupa(sudafrica, amarillo).

ocupa(argentina, azul).
ocupa(chile, azul).
ocupa(uruguay, azul).

ocupa(china, azul).
ocupa(japon, azul).
ocupa(iran, azul).
ocupa(india, azul).
ocupa(malasia, azul).
ocupa(gobi, azul).

ocupa(australia, azul).
ocupa(borneo, azul).
ocupa(java, azul).
ocupa(sumatra, azul).

ocupa(israel, negro).
ocupa(arabia, negro).

ocupa(mongolia, verde).
ocupa(taimir, verde).
ocupa(tartaria, verde).
ocupa(siberia, verde).
ocupa(kamchatka, verde).

ocupa(italia, verde).

ocupa(brasil, verde).
ocupa(colombia, verde).
ocupa(peru, verde).

ocupa(francia, rojo).
ocupa(granBretania, rojo).
ocupa(espania, rojo).
ocupa(alemania, rojo).

% la mitad de los países que ocupa (se redondea para abajo), ó 3 si no llega a los 6 países 
% lo que corresponda por cada continente ocupado por completo:
% Asia . . . . . . . . . . . . . . . . .. . . .7 ejércitos 
% Europa . . . . . . . .. . . . . . . . . . . 5 ejércitos 
% America del Norte . . . . . . . . . . . . . 5 ejércitos 
% America del Sur  . . . . . . . . . . . . . .3 ejércitos 
% Africa . . . . . . . . . . . . . . . . . . 3 ejércitos 
% Oceania .  . . . . . . . . . . . . . . . . 2 ejércitos

correspondenUnidades(asia, 7).
correspondenUnidades(europa, 5).
correspondenUnidades(americaDelNorte, 5).
correspondenUnidades(americaDelSur, 3).
correspondenUnidades(africa, 3).
correspondenUnidades(oceania, 2).

ocupaContinente(Jugador, Continente):-
    jugador(Jugador),
    continente(Continente),
    forall(estaEn(Continente, Pais),
            ocupa(Pais, Jugador)).

unidadesTotalesPorContinentes(Jugador, UnidadesTotales):-
    jugador(Jugador),
    findall(Cantidad, unidadesQueLeTocanPorContinenteCompleto(Jugador, _, Cantidad),
    Cantidades),
    sum_list(Cantidades, UnidadesTotales).

unidadesQueLeTocanPorContinenteCompleto(Jugador, Continente, Unidades):-
    ocupaContinente(Jugador, Continente),
    correspondenUnidades(Continente, Unidades).
    
% findall(Pais, ocupa(Pais, azul), Paises).
%         VALOR       CONSULTA      LISTA
%        QUE SE
%         LIGA

unidadesCorrespondientesPorPaises(Jugador, Unidades):-
    cantidadDePaisesOcupados(Jugador, CantidadPaises),
    Unidades is CantidadPaises // 2,
    CantidadPaises >= 6.
unidadesCorrespondientesPorPaises(Jugador, 3):-
    cantidadDePaisesOcupados(Jugador, CantidadPaises),
    CantidadPaises < 6.

cantidadDePaisesOcupados(Jugador, Cantidad):-
    jugador(Jugador),
    findall(Pais, ocupa(Pais, Jugador), Paises),
    length(Paises, Cantidad).

unidadesQueIncorpora(Jugador, Unidades):-
    unidadesCorrespondientesPorPaises(Jugador, UnidadesPorPaises),
    unidadesTotalesPorContinentes(Jugador, UnidadesPorContinentes),
    Unidades is UnidadesPorPaises + UnidadesPorContinentes.
