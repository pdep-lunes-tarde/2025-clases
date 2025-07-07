% Clase 13: Functores y polimorfismo
% Enunciado: trabajadores y tareas

% De cada trabajador sabemos su profesión y que herramienta posee:
% Migue es maestro cocinero y su herramienta es una olla Essen.
% Carla es maestra alquimista y su herramienta es un mechero.
% Feche es aprendiz de mecánico y su herramienta es una llave inglesa.
% Aye es oficial alquimista y su herramienta es una piedra filosofal.


% Queremos saber quiénes son camaradas:
% son aquellas personas que trabajan en la misma área


% Queremos saber quiénes pueden entrenar a quiénes:
% deben ser camaradas y quien entrena tiene que tener más experiencia.
% Un oficial tiene más experiencia que un aprendiz,
% y un maestro, más que un oficial.


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

:- end_tests.

% Queremos representar las tareas que pueden hacer estos trabajadores,
% y saber exactamente quiénes de ellos pueden llevarlas a cabo.

% Cocinar milanesas con puré: puede hacerlo cualquier cocinero.


% Recalentar comida: puede hacerlo cualquier cocinero, o cualquiera que tenga un mechero.


% Producir cierta cantidad de medicina:
% alquimistas aprendices y oficiales pueden hacer solo hasta 100 gramos;
% alquimistas de grado más alto pueden hacer cualquier cantidad.


% Reparar un aparato: para cada aparato sabemos con qué herramienta se puede arreglar.
% Y solo puede ser arreglado por alguien que trabaje en mecánica y tenga esa herramienta.
% Además, Migue se da maña arreglando cualquier cosa así que siempre puede reparar lo que sea.


% Crear obra maestra de un área: donde el área podría ser alquimia, cocina, mecánica, etc.
% Sólo puede ser hecha por una persona que tenga maestría en ese área.
% Además, en el caso de la alquimia cualquiera con una piedra filosofal puede crear una obra maestra.


% Una persona puede cubrir a otra en cierta tarea si ambas pueden hacerla.


% Una persona es irreemplazable para una tarea si nadie puede cubrirla para la misma.


% Decimos que una persona es un comodín si puede realizar todas las tareas conocidas.
