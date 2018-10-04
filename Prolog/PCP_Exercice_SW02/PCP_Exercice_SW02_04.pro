% Definiere Farbe, welche nebeneinander sein dürfen
n(gelb, gruen).
n(gelb, rot).
n(gruen, gelb).
n(gruen, rot).
n(rot, gelb).
n(rot, gruen).

colors(LU, NW, OW, SZ, UR, ZG) :-
    UR = gelb,                                   % Uri soll gelb sein
    SZ = rot,                                    % Schwyz soll rot sein
    n(LU, NW), n(LU, OW), n(LU, ZG), n(LU, SZ),  % Nachbarn vom Kt. Luzern (*)
    n(OW, NW), n(OW, UR),                        % Nachbarn vom Kt. Obwalden (*)
    n(NW, SZ), n(NW, UR),                        % Nachbarn vom Kt. Nidwalden (*)
    n(UR, SZ),                                   % Nachbarn vom Kt. Uri (*)
    n(SZ, ZG).                                   % Nachbarn vom Kt. Schwyz (*)
                                                 % Nachbarn vom Kt. Zug (*)
                                                 % (*) = Ausser die schon erwähnten

