/*animal(Nombre,Clase, Medio)*/
animal(ballena,mamifero,acuatico).
animal(tiburon,pez,acuatico).
animal(lemur,mamifero,terrestre).
animal(golondrina,ave,aereo).
animal(tarantula,insecto,terrestre).
animal(lechuza,ave,aereo).
animal(orangutan,mamifero,terrestre).
animal(tucan,ave,aereo).
animal(puma,mamifero,terrestre).
animal(abeja,insecto,aereo).
animal(leon,mamifero,terrestre).
animal(lagartija,reptil,terrestre).

/* tiene(Quien, Que, Cuantos)*/
tiene(nico, ballena, 1).
tiene(nico, lemur, 2).
tiene(maiu, lemur, 1).
tiene(maiu, tarantula, 1).
tiene(juanDS, golondrina, 1).
tiene(juanDS, lechuza, 1).
tiene(juanR, tiburon, 2).
tiene(nico, golondrina, 1).
tiene(juanDS, puma, 1).
tiene(maiu, tucan, 1).
tiene(juanR, orangutan,1).
tiene(maiu,leon,2).
tiene(juanDS,lagartija,1).
tiene(feche,tiburon,1).

% animalDificil/1: si nadie lo tiene, o bien si una sola persona tiene uno solo.

animalDificil(Animal):-
    animal(Animal, _, _),
    not(tiene(_, Animal, _)).

animalDificil(Animal):-
    tiene(Persona, Animal, 1),
    not((
        tiene(OtraPersona, Animal, _),
        Persona \= OtraPersona)).

% leGusta/2

leGusta(nico, Animal):-
    animal(Animal, _, terrestre),
    Animal \= lemur.
% leGusta(maiu, Animal):-
%     animal(Animal, _, _),
%     not((
%         animal(Animal, insecto, _),
%         Animal \= abeja)).
leGusta(maiu, Animal):-
    animal(Animal, Clase, _),
    Clase \= insecto.
leGusta(maiu, abeja).
leGusta(juanDS, Animal):-
    animal(Animal, _, acuatico).
leGusta(juanDS, Animal):-
    animal(Animal, ave, _).
leGusta(juanR, Animal):-
    tiene(juanR, Animal, _).
leGusta(feche, lechuza).


% estaFeliz/1: si le gustan todos los animales que tiene.
% == no tiene ningun animal que no le gusta
% estaFeliz(Persona):-
%     tiene(Persona, _, _),
%     not(tieneUnAnimalQueNoLeGusta(Persona)).

% tieneUnAnimalQueNoLeGusta(Persona):-
%     tiene(Persona, Animal, _),
%     not(leGusta(Persona, Animal)).

estaFeliz(Persona):-
    tiene(Persona, _, _),
    forall(
        tiene(Persona, Animal, _),
        leGusta(Persona, Animal)
    ).

% tieneTodosDe/2: si la persona tiene todos los animales de ese medio o clase.

esDeClaseOMedio(Animal, Medio):-
    animal(Animal, _, Medio).
esDeClaseOMedio(Animal, Clase):-
    animal(Animal, Clase, _).

tieneTodosDe(Persona, ClaseOMedio):-
    tiene(Persona, _, _),
    esDeClaseOMedio(_, ClaseOMedio),
    forall(
        tiene(Persona, Animal, _),
        esDeClaseOMedio(Animal, ClaseOMedio)
    ).

% completoLaColeccion/1: si la persona tiene todos los animales.

completoLaColeccion(Persona):-
    tiene(Persona, _, _),
    forall(animal(Animal, _, _),
            tiene(Persona, Animal, _)).
    % not(animal(Animal, _, _),
    %        not(tiene(Persona, Animal, _))).

% delQueMasTiene/2: si la persona tiene más de este animal que del resto.

delQueMasTiene(Persona, Animal):-
    tiene(Persona, Animal, Cantidad),
    forall(
        (tiene(Persona, OtroAnimal, OtraCantidad),
        OtroAnimal \= Animal),
        Cantidad > OtraCantidad
    ).

% tieneParaIntercambiar/2 una persona, siendo estos aquellos que tenga la persona y que no le guste o que tenga más de uno. Además, juanR puede intercambiar los que tiene juanDS porque no tiene códigos.

tieneParaIntercambiar(Persona, Animal):-
    tiene(Persona, Animal, _),
    not(leGusta(Persona, Animal)).
tieneParaIntercambiar(Persona, Animal):-
    tiene(Persona, Animal, Cantidad),
    Cantidad > 1.
tieneParaIntercambiar(juanR, Animal):-
    tiene(juanDS, Animal, _).

% Ahora queremos saber si tieneParaOfrecerle/2 una persona a otra: esto se cumple si la primera persona tiene para intercambiar animales que le gustan a la segunda y que la segunda no tiene.
tieneParaOfrecerle(Persona, OtraPersona):-
    tieneParaIntercambiar(Persona, Animal),
    leGusta(OtraPersona, Animal),
    not(tiene(OtraPersona, Animal, _)).

% puedenNegociar/2: sabiendo que pueden negociar 2 personas si ambas tienen para ofrecerse mutuamente.
puedenNegociar(Persona, OtraPersona):-
    tieneParaOfrecerle(Persona, OtraPersona),
    tieneParaOfrecerle(OtraPersona, Persona).

manejaElMercado(Persona):-
    tiene(Persona, _, _),
    forall(
        (tiene(OtraPersona, _, _), Persona \= OtraPersona),
        tieneParaOfrecerle(Persona, OtraPersona)
    ).

    

