% Clase 13: Functores y polimorfismo
% Enunciado: trabajadores y tareas

% De cada trabajador sabemos su profesión y que herramienta posee:
% Migue es maestro cocinero y su herramienta es una olla Essen.
% Carla es maestra alquimista y su herramienta es un mechero.
% Feche es aprendiz de mecánico y su herramienta es una llave inglesa.
% Aye es oficial alquimista y su herramienta es una piedra filosofal.

% trabajador/3
trabajador(migue, profesion(maestro, cocina), ollaEssen).
trabajador(carla, profesion(maestro, alquimia), mechero).
trabajador(feche, profesion(aprendiz, mecanica), llaveInglesa).
trabajador(aye, profesion(oficial, alquimia), piedraFilosofal).
trabajador(juan, profesion(aprendiz, alquimia), mechero).
trabajador(manu, profesion(maestro, alquimia), piedraFilosofal).

% rango/2 (relaciona al trabajador con su rango)
rango(Trabajador, Rango) :-
    % pattern matching sobre el functor
    trabajador(Trabajador, profesion(Rango, _), _).

% Queremos saber quiénes son camaradas:
% son aquellas personas que trabajan en la misma área

camaradas(UnTrabajador, OtroTrabajador) :-
    trabajador(UnTrabajador, profesion(_, Area), _),
    trabajador(OtroTrabajador, profesion(_, Area), _),
    OtroTrabajador \= UnTrabajador.

% Queremos saber quiénes pueden entrenar a quiénes:
% deben ser camaradas y quien entrena tiene que tener más experiencia.
% Un oficial tiene más experiencia que un aprendiz,
% y un maestro, más que un oficial.

% aprendiz < oficial < experto < maestro
rangoInmediatamenteSuperior(maestro, experto).
rangoInmediatamenteSuperior(experto, oficial).
rangoInmediatamenteSuperior(oficial, aprendiz).

% usar recursividad para implementar relaciones transitivas
rangoSuperior(RangoSuperior, RangoInferior) :-
    rangoInmediatamenteSuperior(RangoSuperior, RangoInferior).

rangoSuperior(RangoSuperior, RangoInferior) :-
    rangoInmediatamenteSuperior(RangoIntermedio, RangoInferior),
    rangoSuperior(RangoSuperior, RangoIntermedio).

masExperiencia(UnTrabajador, OtroTrabajador) :-
    rango(UnTrabajador, UnRango),
    rango(OtroTrabajador, OtroRango),
    rangoSuperior(UnRango, OtroRango).

puedeEntrenarA(Entrenador, Entrenado) :-
    camaradas(Entrenador, Entrenado),
    masExperiencia(Entrenador, Entrenado).


% Agregamos el rango de experiencia "experto", entre oficial y maestro.
% ¿Qué problemas presenta la implementación original?


:- begin_tests(clase_13_parte_1).


test("Dos trabajadores son camaradas si comparten área") :-
    camaradas(carla, aye).

test("Dos trabajadores no son camaradas si sus áreas son distintas") :-
    not(camaradas(migue, carla)).

test("Un trabajador puede entrenar a otro si son camaradas y quien entrena tiene más experiencia") :-
    puedeEntrenarA(carla, aye).

test("Un trabajador no puede entrenar a otro si, siendo camaradas, quien entrena tiene menos experiencia") :-
    not(puedeEntrenarA(aye, carla)).

test("Un trabajador no puede entrenar a otro si no son camaradas") :-
    not(puedeEntrenarA(migue, carla)).

:- end_tests(clase_13_parte_1).

% Queremos representar las tareas que pueden hacer estos trabajadores,
% y saber exactamente quiénes de ellos pueden llevarlas a cabo.

% puedeHacer/2
% trabajador - tarea

% Cocinar milanesas con puré: puede hacerlo cualquier cocinero.

puedeHacer(Trabajador, cocinarMilanesasConPure) :-
    trabajador(Trabajador, profesion(_, cocina), _).

% Recalentar comida: puede hacerlo cualquier cocinero, o cualquiera que tenga un mechero.

puedeHacer(Trabajador, recalentarComida) :-
    trabajador(Trabajador, profesion(_, cocina), _).
puedeHacer(Trabajador, recalentarComida) :-
    trabajador(Trabajador, _, mechero).

% Producir cierta cantidad de medicina:
% alquimistas aprendices y oficiales pueden hacer solo hasta 100 gramos;
% alquimistas de grado más alto pueden hacer cualquier cantidad.

puedeHacer(Trabajador, producirMedicina(Gramos)) :-
    between(1, 100, Gramos),
    trabajador(Trabajador, profesion(Rango, alquimia), _),
    esOficialOAprendiz(Rango).

puedeHacer(Trabajador, producirMedicina(Gramos)) :-
    trabajador(Trabajador, profesion(Rango, alquimia), _),
    rangoSuperior(Rango, oficial),
    between(1, inf, Gramos).

esOficialOAprendiz(oficial).
esOficialOAprendiz(aprendiz).

% Reparar un aparato: para cada aparato sabemos con qué herramienta se puede arreglar.
% Y solo puede ser arreglado por alguien que trabaje en mecánica y tenga esa herramienta.
% Además, Migue se da maña arreglando cualquier cosa así que siempre puede reparar lo que sea.

puedeHacer(Trabajador, repararAparato(Herramienta)) :-
    trabajador(Trabajador, profesion(_, mecanica), Herramienta).
puedeHacer(migue, repararAparato(Herramienta)) :-
    trabajador(_, _, Herramienta).

% Crear obra maestra de un área: donde el área podría ser alquimia, cocina, mecánica, etc.
% Sólo puede ser hecha por una persona que tenga maestría en ese área.
% Además, en el caso de la alquimia cualquiera con una piedra filosofal puede crear una obra maestra.

puedeHacer(Trabajador, crearObraMaestra(Area)) :-
    trabajador(Trabajador, profesion(maestro, Area), _).
puedeHacer(Trabajador, crearObraMaestra(alquimia)) :-
    trabajador(Trabajador, _, piedraFilosofal).

% Una persona puede cubrir a otra en cierta tarea
% si ambas pueden hacerla.

% puedeCubrir/3
puedeCubrir(UnTrabajador, OtroTrabajador, Tarea) :-
    puedeHacer(UnTrabajador, Tarea),
    puedeHacer(OtroTrabajador, Tarea),
    UnTrabajador \= OtroTrabajador.

% Una persona es irreemplazable para una tarea
% si nadie puede cubrirla para la misma.

esIrreemplazable(Persona, Tarea) :-
    puedeHacer(Persona, Tarea),
    not(puedeCubrir(_, Persona, Tarea)).

% Decimos que una persona es un comodín
% si puede realizar todas las tareas conocidas.

comodin(Persona) :-
    trabajador(Persona, _, _),
    forall(puedeHacer(_, Tarea), puedeHacer(Persona, Tarea)).
