% Base de conocimientos
% Predicado humano\1
% Nombre del predicado
%  |
%  |   Individuo
%  |     |
%  v     v
humano(luca).
humano(socrates). % Hecho

% Predicado perro\1
perro(fatiga).

% Predicado hombrePerro\1
hombrePerro(Alguien):- humano(Alguien), perro(Alguien).

% Predicado mortal\1
% Vx. humano(x) => mortal(x)
mortal(Persona):- humano(Persona). % regla
%              <=
mortal(fatiga).

% Predicado: formado por uno o mas hechos o reglas.

% Nahuel programa en JavaScript
% Juan programa en Haskell y Ruby
% Caro programa en Haskell y Scala
% Tito no programa en ningún lenguaje

lenguaje(javascript).
lenguaje(haskell).
lenguaje(ruby).
lenguaje(scala).
lenguaje(python).

% programaEn\2
programador(nahuel).
programador(juan).
programador(caro).
programador(tito).
programador(manu).


programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, ruby).
programaEn(caro, haskell).
programaEn(caro, scala).
% programaEn(manu, _). <-- no es inversible respecto del lenguaje. O sea, no puedo hacer consultas donde el lenguaje quede como una incognita porque no me va a dar el resultado esperado. 
programaEn(manu, Lenguaje):-
    lenguaje(Lenguaje).

% Sabemos que dos personas son colegas si programan en un mismo lenguaje.
% Queremos saber:
% 1. si Juan y Caro son colegas,
% 2. quiénes son colegas.
sonColegas(UnaPersona, OtraPersona):-
    programaEn(UnaPersona, UnLenguaje),
    programaEn(OtraPersona, UnLenguaje),
    UnaPersona \= OtraPersona.

compartenLenguaje(UnaPersona, OtraPersona, UnLenguaje):-
    programaEn(UnaPersona, UnLenguaje),
    programaEn(OtraPersona, UnLenguaje),
    UnaPersona \= OtraPersona.

% Queremos implementar si una persona puede aprender un lenguaje de otra. Esto se cumple cuando la primera no programa en ese lenguaje y la segunda sí.

% ¿poner el lenguaje como parametro?
puedeAprenderLenguajeDe(Aprendiz, QuienEnsenia, Lenguaje):-
    % Existe un QuienEnsenia y un Lenguaje TAL QUE
    programaEn(QuienEnsenia, Lenguaje),
    % Existe un Aprendiz TAL QUE
    programador(Aprendiz),
    % Aprendiz no programa en Lenguaje
    not(programaEn(Aprendiz, Lenguaje)).

% Version con problemas de inversibilidad:
% puedeAprenderLenguajeDe(Aprendiz, QuienEnsenia, Lenguaje):-
    % Existe un QuienEnsenia y un Lenguaje TAL QUE
    % programaEn(QuienEnsenia, Lenguaje),
    % Para todo Aprendiz, no programa en un lenguaje
    % not(programaEn(Aprendiz, Lenguaje)).

:- begin_tests(clase1).

test(si_alguien_es_humano_entonces_es_mortal):-
    mortal(socrates).

test(si_alguien_no_es_humano_ni_fatiga_no_es_mortal):-
    not(mortal(chatgpt)).

:- end_tests(clase1).

lenguajeExclusivo(UnaPersona, OtraPersona, Lenguaje):-
    programaEn(UnaPersona, Lenguaje),
    not(programaEn(OtraPersona, Lenguaje)).
lenguajeExclusivo(UnaPersona, OtraPersona, Lenguaje):-
    programaEn(OtraPersona, Lenguaje),
    not(programaEn(UnaPersona, Lenguaje)).

% es la unica persona que programa en lenguaje
irreemplazable(UnaPersona, Lenguaje):-
    programaEn(UnaPersona, Lenguaje),
    not(
        compartenLenguaje(UnaPersona, _, Lenguaje)
    ).
