% Registramos las características de las lechuzas de la zona (nombre, sospechosidad y nobleza)
% con un predicado lechuza/3.

% lechuza(Lechuza, Sospechosidad, Nobleza)
lechuza(duo, 10, 2).
lechuza(prolog, 10, 51).
lechuza(noctowl, 20, 42).
lechuza(coo, 80, 55).

violencia(Lechuza, Violencia):-
    lechuza(Lechuza, Sospechosidad, Nobleza),
    Violencia is 5 * Sospechosidad + 42 / Nobleza.
% Necesitamos saber:
% ¿Qué tan violenta es una lechuza?
% Se calcula como 5 * sospechosidad + 42 / nobleza.
vengativa(Lechuza):-
    violencia(Lechuza, Violencia),
    Violencia > 100.
% Si una lechuza es vengativa. Lo es si su violencia es mayor a 100.

esBuenaGente(Lechuza):-
    lechuza(Lechuza, _, Nobleza),
    not(vengativa(Lechuza)),
    Nobleza > 50.

esMafiosa(Lechuza):-
    lechuza(Lechuza, _, _),
    not(esBuenaGente(Lechuza)).

esMafiosa(Lechuza):-
    lechuza(Lechuza, Sospechosidad, _),
    Sospechosidad >= 75.

% Si una lechuza es mafiosa, que se cumple si
% - no es buena gente o
% - su sospechosidad es al menos 75.

% Decimos que es buena gente si
% - no es vengativa y
% - su nobleza es mayor a 50.

:- begin_tests(lechuzas).

test("la violencia de una lechuza es 5 * sospechosidad + 42 / nobleza"):-
    violencia(duo, 71).

test("una lechuza es vengativa si su violencia es mayor a 100"):-
    vengativa(noctowl).

test("una lechuza no es vengativa si su violencia es menor a 100"):-
    not(vengativa(prolog)).

test("una lechuza no es buena gente si es vengativa"):-
    not(esBuenaGente(noctowl)).

test("una lechuza no es buena gente si su nobleza es menor a 50"):-
    not(esBuenaGente(duo)).

test("una lechuza es buena gente si su nobleza es mayor a 50 y no es vengativa"):-
    esBuenaGente(prolog).

test("una lechuza es mafiosa si no es buena gente", nondet):-
    esMafiosa(noctowl).

test("una lechuza es mafiosa si su sospechosidad es mayor a 75", nondet):-
    esMafiosa(coo).

test("una lechuza NO es mafiosa si su sospechosidad es menor a 75 y aparte es buena gente", nondet):-
    not(esMafiosa(prolog)).

:- end_tests(lechuzas).
