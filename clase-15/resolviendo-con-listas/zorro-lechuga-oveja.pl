% El desafío es cruzar un río con un zorro, una oveja y una lechuga,
% utilizando una barca que solo puede llevar al granjero y uno de los tres elementos a la vez.
% La dificultad radica en que el zorro se comerá la oveja si se quedan solos,
% y la oveja se comerá la lechuga si están juntos sin el granjero.

problema([granjero, zorro, oveja, lechuga]-rio-[]).

se_come_a(zorro, oveja).
se_come_a(oveja, lechuga).

accion_posible(llevar(zorro)).
accion_posible(llevar(oveja)).
accion_posible(llevar(lechuga)).
accion_posible(ir_solo).
accion_posible(traer(zorro)).
accion_posible(traer(oveja)).
accion_posible(traer(lechuga)).
accion_posible(volver_solo).

sin(Elemento, Lista, ListaSinElemento):-
	nth0(_, Lista, Elemento, ListaSinElemento).
con(Elemento, Lista, ListaConElemento):-
	nth0(_, ListaConElemento, Elemento, Lista).

mover(Elemento, LadoOrigen, LadoDestino, NuevoLadoOrigen, NuevoLadoDestino):-
	sin(granjero, LadoOrigen, LadoOrigenSinGranjero),
	sin(Elemento, LadoOrigenSinGranjero, NuevoLadoOrigen),
    nadie_se_come_a_nadie(NuevoLadoOrigen),

	con(granjero, LadoDestino, LadoDestinoConGranjero),
	con(Elemento, LadoDestinoConGranjero, NuevoLadoDestino),
	nadie_se_come_a_nadie(NuevoLadoDestino).

realizar_accion(ir_solo, LadoA-rio-LadoB, NuevoLadoA-rio-NuevoLadoB):-
    sin(granjero, LadoA, NuevoLadoA),
    con(granjero, LadoB, NuevoLadoB),
    nadie_se_come_a_nadie(NuevoLadoA),
    nadie_se_come_a_nadie(NuevoLadoB).
realizar_accion(volver_solo, LadoA-rio-LadoB, NuevoLadoA-rio-NuevoLadoB):-
    sin(granjero, LadoB, NuevoLadoB),
    con(granjero, LadoA, NuevoLadoA),
    nadie_se_come_a_nadie(NuevoLadoA),
    nadie_se_come_a_nadie(NuevoLadoB).
realizar_accion(llevar(Cosa), LadoA-rio-LadoB, NuevoLadoA-rio-NuevoLadoB):-
	mover(Cosa, LadoA, LadoB, NuevoLadoA, NuevoLadoB).
realizar_accion(traer(Cosa), LadoA-rio-LadoB, NuevoLadoA-rio-NuevoLadoB):-
	mover(Cosa, LadoB, LadoA, NuevoLadoB, NuevoLadoA).

nadie_se_come_a_nadie(Cosas):-
    member(granjero, Cosas).
nadie_se_come_a_nadie(Cosas):-
	not((se_come_a(Depredador, Presa),
			member(Depredador, Cosas),
			member(Presa, Cosas))).

resuelto([]-rio-Cosas):-
    member(zorro, Cosas),
    member(oveja, Cosas),
    member(lechuga, Cosas).

dar_un_paso(Paso, Problema, ProblemaSiguiente):-
    accion_posible(Paso),
    realizar_accion(Paso, Problema, ProblemaSiguiente).
solucion(Problema, Pasos):-
    solucion(Problema, Pasos, []),
    writeln(Pasos).

solucion(Problema, [Paso], _):-
    dar_un_paso(Paso, Problema, ProblemaResuelto),
    resuelto(ProblemaResuelto).
solucion(Problema, [Paso | SiguientesPasos], ProblemasPrevios):-
    dar_un_paso(Paso, Problema, ProblemaEnProgreso),
    % si esta resuelto no necesitamos seguir recorriendo
    not(resuelto(ProblemaEnProgreso)),
    % descartamos el problema si ya habiamos pasado por un estado equivalente
    % se agrega equivalentes\2 ademas de hacer solo member porque por ejemplo:
    % [zorro, lechuga]-rio-[granjero, oveja] es lo mismo que [lechuga, zorro]-rio-[granjero, oveja]
    not((member(ProblemaPrevio, ProblemasPrevios), equivalentes(ProblemaEnProgreso, ProblemaPrevio))),
    solucion(ProblemaEnProgreso, SiguientesPasos, [Problema | ProblemasPrevios]).

equivalentes(LadoA-rio-LadoB, OtroLadoA-rio-OtroLadoB):-
    intersection(LadoA, OtroLadoA, LadoA),
    intersection(LadoB, OtroLadoB, LadoB).