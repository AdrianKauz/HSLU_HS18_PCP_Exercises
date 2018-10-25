% http://www.swi-prolog.org/pldoc/man?predicate=member/2
% Head | Tail

% set_difference([a, b, c, d], [b, d, e, f], [a, c]). --> true

% Wenn N bei beiden Listen identisch ist, dann darf N kein Element von
% Set2 sein. Falls doch, dann "false".
% Wichtig: Listen müssen geordnet sein!
set_difference([N | Set1], Set2, [N | SetDifference]) :-
    \+ member(N, Set2),
    set_difference(Set1, Set2, SetDifference).

% Wenn N nur im Set1 bekannt ist, dann muss N ein Element von Set2 sein.
set_difference([N | Set1], Set2, SetDifference) :-
    member(N, Set2),
    set_difference(Set1, Set2, SetDifference).

% Wenn es von Set1 und von SetDifference der Inhalt leer ist, so gibt's
% nichts mehr zu suchen und fertig.
set_difference([], _, []).
