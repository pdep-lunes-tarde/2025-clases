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

% leGusta/2

% animalDificil/1: si nadie lo tiene, o bien si una sola persona tiene uno solo.

% estaFeliz/1: si le gustan todos los animales que tiene.

% tieneTodosDe/2: si la persona tiene todos los animales de ese medio o clase.

% completoLaColeccion/1: si la persona tiene todos los animales.

% delQueMasTiene/2: si la persona tiene más de este animal que del resto.