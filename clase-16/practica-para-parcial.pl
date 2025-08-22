vistas(0, 2500).
vistas(1, 1800).
vistas(2, 1200).
vistas(3, 900).
vistas(4, 750).
vistas(5, 600).
vistas(6, 800).
vistas(7, 1500).
vistas(8, 3200).
vistas(9, 5800).
vistas(10, 8500).
vistas(11, 11200).
vistas(12, 13800).
vistas(13, 15200).
vistas(14, 16800).
vistas(15, 18500).
vistas(16, 10000).
vistas(17, 12000).
vistas(18, 12000).
vistas(19, 12000).
vistas(20, 12000).
vistas(21, 12000).
vistas(22, 12000).
vistas(23, 12000).

descubrimiento(a1, pulpo, [extremidades(8), luminisciencia], 3400, 07, observado).
descubrimiento(a2, pulpo, [extremidades(8), color(azul)], 3150, 08, observado).
descubrimiento(b1, estrella, [extremidades(5), color(naranja), culona], 3400, 12, observado).
descubrimiento(c1, pepino_de_mar, [color(violeta)], 1900, 14, observado).
descubrimiento(d1, anemona, [extremidades(30)], 1900, 15, recolectado).
descubrimiento(d2, anemona, [extremidades(35)], 2200, 16, recolectado).
descubrimiento(c2, pepino_pelagico, [transparente, luminisciencia], 2800, 17, recolectado).
descubrimiento(e1, pez_linterna, [luminisciencia, color(rojo)], 3200, 19, observado).
descubrimiento(a3, pulpo_de_cristal, [transparente, fragil], 3800, 21, recolectado).
descubrimiento(a4, pulpo_dumbo, [extremidades(10), color(gris)], 3900, 23, observado).

%% 1
%% Implementar un predicado que nos permita
%% relacionar una profunidad en metros con
%% la zona oceánica correspondiente.

zona_oceanica(fotica).
zona_oceanica(batial).
zona_oceanica(abisal).
zona_oceanica(hadal).

zona(Profundidad, fotica):- between(0, 610, Profundidad).
zona(Profundidad, batial):- between(1000, 3999, Profundidad).
zona(Profundidad, abisal):- between(4000, 5999, Profundidad).
zona(Profundidad, hadal):- Profundidad >= 6000.

%% 2 
%% Queremos saber cuál especie fue la favorita del público.
%% Es decir, cuál o cuáles especies fueron descubiertas en
%% la hora en la que más vistas hubo en el stream.

favorita_del_publico(Especie):-
    descubrimiento(_, Especie, _, _, Hora, _),
    hora_con_mas_vistas(Hora).

hora_con_mas_vistas(Hora):-
    vistas(Hora, VistasMaximas),
    forall((vistas(OtraHora, OtrasVistas), OtraHora \= Hora),
            VistasMaximas >= OtrasVistas).

%% 3. Especies por zona

%% a)
%% Se requiere conocer en qué zonas oceánicas fue descubierta una especie.

descubierta_en(Especie, Zona):-
    descubrimiento(_, Especie, _, Profundidad, _, _),
    zona(Profundidad, Zona).

%% b)
%% También, queremos saber cuál fue la zona oceánica en la
%% que mas descubrimientos se realizaron.

zona_de_mas_descubrimientos(Zona):-
    cantidad_de_descubrimientos(Zona, Cantidad),
    forall(
        (cantidad_de_descubrimientos(OtraZona, OtraCantidad), Zona \= OtraZona),
        OtraCantidad < Cantidad
    ).

cantidad_de_descubrimientos(Zona, Cantidad):-
    zona_oceanica(Zona),
    findall(Zona, descubierta_en(_, Zona), Zonas),
    length(Zonas, Cantidad).

%% 4. Promedio de vistas

promedio_de_vistas(Promedio):-
    findall(Cantidad, vistas(_, Cantidad), Cantidades),
    sum_list(Cantidades, TotalDeVistas),
    length(Cantidades, CantidadDeHoras),
    Promedio is TotalDeVistas / CantidadDeHoras.
    

%% 5. Variación de Profundidad del Submarino
%% Dadas dos horas, queremos conocer cual
%% fue la variación de profundidad del submarino SuBastian.

%% **Nota**: Solo tenemos datos de profundidad respecto de los
%% animales descubiertos, por lo que la profundidad del submarino
%% en cada hora corresponde a la profundidad de los descubrimientos realizados en esa hora.

variacion_de_profundidad(rango(HoraInicial, HoraFinal), Variacion):-
    descubrimiento(_, _, _, ProfundidadInicial, HoraInicial, _),
    descubrimiento(_, _, _, ProfundidadFinal, HoraFinal, _),
    HoraInicial < HoraFinal,
    Variacion is ProfundidadFinal - ProfundidadInicial.

%% 5. Descenso Más Rápido

%% Queremos saber en cual rango de horas el submarino realizó el descenso más rápido.
%% La velocidad del descenso es la variación de profundidad dividido el tiempo transcurrido.

velocidad_de_descenso(rango(HoraInicial, HoraFinal), VelocidadDeDescenso):-
    variacion_de_profundidad(rango(HoraInicial, HoraFinal), VariacionDeProfundidad),
    DiferenciaDeHoras is HoraFinal - HoraInicial,
    VelocidadDeDescenso is VariacionDeProfundidad / DiferenciaDeHoras.

descenso_mas_rapido(RangoDeHoras, VelocidadMaxima):-
    velocidad_de_descenso(RangoDeHoras, VelocidadMaxima),
    forall((velocidad_de_descenso(OtroRangoDeHoras, OtraVelocidad),
            RangoDeHoras \= OtroRangoDeHoras),
            VelocidadMaxima >= OtraVelocidad).

%% ### 6. Nivel de Novedad

%% Queremos conocer el nivel de novedad de un descubrimiento,
%% lo cual se calcula como la sumatoria de unidades de
%% conocimiento que proporciona cada característica observada.

%% Unidades de conocimiento que aporta cada característica:
%% - `luminisciencia`: 5 unidades
%% - `extremidades`: 1 por cada extremidad
%% - `color`: si de un color que indica peligro, 5 unidades, si no 3.
%%     - los colores que indican peligro son el rojo y el amarillo.
%% - Cualquier característica no registrada: 10 unidades

%% Además, si el animal fue **recolectado**,
%% el nivel de novedad es un **50% más** que si hubiese sido solo **observado**.

% unidades_de_conocimiento(Caracteristica, UnidadesDeConocimiento).
unidades_de_conocimiento(Caracteristica, UnidadesDeConocimiento):-
    caracteristica_registrada(Caracteristica, UnidadesDeConocimiento).
unidades_de_conocimiento(Caracteristica, 10):-
    not(caracteristica_registrada(Caracteristica, _)).

% caracteristica_registrada(Caracteristica, UnidadesDeConocimiento).
caracteristica_registrada(luminisciencia, 5).
caracteristica_registrada(extremidades(Cantidad), Cantidad).
caracteristica_registrada(color(Color), 5):-
    color_peligroso(Color).
caracteristica_registrada(color(Color), 3):-
    not(color_peligroso(Color)).

color_peligroso(rojo).
color_peligroso(amarillo).

% nivel_de_novedad(Descubrimiento, NivelDeNovedad)
nivel_de_novedad(Descubrimiento, NivelDeNovedad):-
    descubrimiento(Descubrimiento, _Especie, Caracteristicas, _Profundidad, _Hora, TipoDeDescubrimiento),
    total_de_unidades_de_conocimiento_por_caracteristicas(Caracteristicas, UnidadesTotalesDeConocimiento),
    multiplicador_por_tipo_de_descubrimiento(TipoDeDescubrimiento, Multiplicador),
    NivelDeNovedad is UnidadesTotalesDeConocimiento * Multiplicador.

total_de_unidades_de_conocimiento_por_caracteristicas(Caracteristicas, UnidadesTotales):-
    findall(Unidades, (member(Caracteristica, Caracteristicas), unidades_de_conocimiento(Caracteristica, Unidades)), TodasLasUnidades),
    sum_list(TodasLasUnidades, UnidadesTotales).

multiplicador_por_tipo_de_descubrimiento(observado, 1.0).
multiplicador_por_tipo_de_descubrimiento(recolectado, 1.5).


:- begin_tests(practica_parcial).

test(entre_0_y_610_metros_de_profundidad_es_zona_fotica, nondet):-
    zona(0, fotica),
    zona(300, fotica),
    zona(610, fotica).
test(mas_de_610_metros_de_profundidad_no_es_zona_fotica):-
    not(zona(611, fotica)).

test(menos_de_1000_metros_de_profundidad_no_es_zona_batial):-
    not(zona(999, batial)).
test(entre_1000_y_4000_metros_de_profundidad_es_zona_batial, nondet):-
    zona(1000, batial),
    zona(2222, batial),
    zona(3999, batial).
test(a_4000_metros_o_mas_de_profundidad_no_es_zona_batial):-
    not(zona(4000, batial)).

test(menos_de_4000_no_es_zona_abisal):-
    not(zona(3999, abisal)).
test(entre_4000_y_6000_es_zona_abisal, nondet):-
    zona(4000, abisal),
    zona(4500, abisal),
    zona(5999, abisal).
test(a_6000_metros_o_mas_de_profundidad_no_es_zona_abisal):-
    not(zona(6000, abisal)).

test(menos_de_6000_metros_de_profundidad_no_es_zona_hadal):-
    not(zona(5999, hadal)).
test(a_mas_de_6000_metros_o_mas_es_zona_hadal):-
    zona(6001, hadal),
    zona(7000, hadal).

test(la_especie_favorita_del_publico_es_aquella_que_fue_descubierta_cuando_habia_mas_vistas, nondet):-
    favorita_del_publico(anemona).

test(la_zona_en_que_fue_descubierta_una_especie_depende_de_la_profundidad_en_la_que_se_descubrio, nondet):-
    descubierta_en(estrella, batial).

test(la_variacion_de_profundidad_del_submarino_entre_dos_horas_es_cuantos_metros_bajo_entre_esas_horas):-
    variacion_de_profundidad(rango(07, 21), 400).

test(la_velocidad_de_descenso_del_submarino_entre_dos_horas_es_cuantos_metros_bajo_entre_esas_horas_dividido_por_la_diferencia_de_horas):-
    velocidad_de_descenso(rango(07, 21), 28.571428571428573).

test(el_promedio_de_vistas_es_la_suma_de_todas_las_vistas_por_hora_dividido_la_cantidad_de_horas_que_duro_el_stream):-
    promedio_de_vistas(8210.416666666666).

test(el_descenso_mas_rapido_es_aquel_en_el_que_se_descendieron_mas_metros_en_menos_tiempo):-
    descenso_mas_rapido(rango(16, 17), 600).

test(la_luminisciencia_da_5_unidades_de_conocimiento, nondet):-
    unidades_de_conocimiento(luminisciencia, 5).
test(las_extremidades_dan_1_unidad_de_conocimiento_por_extremidad, nondet):-
    unidades_de_conocimiento(extremidades(4), 4).
test(el_color_da_5_unidades_de_conocimiento_si_indica_peligro, nondet):-
    unidades_de_conocimiento(color(rojo), 5).
test(el_color_da_3_unidades_de_conocimiento_si_no_indica_peligro, nondet):-
    unidades_de_conocimiento(color(verde), 3).
test(una_caracteristica_no_registrada_da_10_unidades_de_conocimiento):-
    unidades_de_conocimiento(transparente, 10).

test(el_nivel_de_novedad_es_la_sumatoria_de_unidades_de_conocimiento):-
    nivel_de_novedad(a1, 13.0).
test("si_el_descubrimiento_es_recolectado_el_nivel_de_novedad_es_la_sumatoria_de_unidades_de_conocimiento_por_1.5"):-
    nivel_de_novedad(a3, 30.0).


:- end_tests(practica_parcial).

