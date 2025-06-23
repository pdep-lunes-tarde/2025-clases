:- discontiguous puede_ser/2.
:- discontiguous formado_por/2.

formado_por(base_de_conocimientos, predicado).
formado_por(predicado, clausula).

puede_ser(clausula, hecho).
puede_ser(clausula, regla).

formado_por(hecho, cabeza).

formado_por(regla, cabeza).
formado_por(regla, cuerpo).

formado_por(cabeza, nombre).
formado_por(cabeza, parametro).

puede_ser(parametro, individuo).
puede_ser(parametro, variable).

puede_ser(individuo, atomo).
puede_ser(individuo, int).
puede_ser(individuo, float).

formado_por(cuerpo, consulta).

puede_ser(consulta, consulta_existencial).
puede_ser(consulta, consulta_individual).

usa(consulta_existencial, variable).
usa(consulta_individual, individuo).

se_hace_sobre(consulta, predicado).

relacionado(Concepto, Concepto, Relacion, OtroConcepto):-
    se_relaciona(Concepto, Relacion, OtroConcepto).
relacionado(Concepto, OtroConcepto, Relacion, Concepto):-
    se_relaciona(OtroConcepto, Relacion, Concepto).

se_relaciona(Parte, es_parte_de, Concepto):-
    formado_por(Concepto, Parte).
se_relaciona(A, es_un, B):-
    puede_ser(B, A).
se_relaciona(A, hace_uso_de, B):-
    usa(A, B).
se_relaciona(A, se_hace_sobre, B):-
    se_hace_sobre(A, B).
