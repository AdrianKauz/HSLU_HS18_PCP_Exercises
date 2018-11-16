female(mary). female(liz). female(mia). female(tina). female(ann). female(sue).
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).
parent(mary, mia). parent(mary, fred). parent(mary, tina).
parent(mike, mia). parent(mike, fred). parent(mike, tina).
parent(liz, tom). parent(liz, joe).
parent(jack, tom). parent(jack, joe).
parent(mia, ann).
parent(tina, sue). parent(tina, jim).
parent(tom, sue). parent(tom, jim).

mother(X, Y) :-
	parent(X, Y),
	female(X).

father(X, Y) :-
	parent(X, Y),
	male(X).

sibling(X, Y) :-
	parent(Z, X),
	parent(Z, Y).

grandmother(X, Y) :-
	parent(Z, Y),
	mother(X, Z).

grandfather(X, Y) :-
	parent(Z, Y),
	father(X, Z).

offspring(X, Y) :- parent(Y, X).
offspring(X, Y) :- parent(Z, X),
	parent(Z, Y).

:- use_module(library(clpfd)).

sudoku(Rows) :-
    append(Rows, Vs), Vs ins 1..9, % Fast alle Zeilen zusammen und setzt Wertebereich 1-9
    maplist(all_distinct, Rows),   % Jede Ziffer darf nur einmal pro Zeile vorkommen
    transpose(Rows, Columns),      % Transponiert Liste in Spalten
    maplist(all_distinct, Columns),% Auch in den Spalten darf jede ziffer nur einmal existieren
    Rows = [A, B, C, D, E, F, G, H, I], % Zuweisung der Zeilen zu den neun Variablen
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I),
    maplist(label, Rows). % Durch "label" werden den Variablen von Rows Werte zugewiesen

blocks([], [], []).
blocks([A, B, C|Bs1], [D, E, F|Bs2], [G, H, I|Bs3]) :-
    all_distinct([A, B, C, D, E, F, G, H, I]),
    blocks(Bs1, Bs2, Bs3).

:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).

% Aus Ilias. Sollte selbsterklärend sein. Objekt-Definitionen
:- json_object relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom).
:- json_object sudoku(problemKey:integer, sudoku:list).
:- json_object solution(solution:atomic, problemKey:integer).
:- json_object sudoku_solution(problemKey:integer, solution:list).

solve(relationship, Id) :-
	atom_concat('http://localhost:16316/problem/relationship/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, relationship(Problemkey, Relationship, FirstPerson, SecondPerson)),
	call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson).

solve(sudoku, Id) :-
	atom_concat('http://localhost:16316/problem/sudoku/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, sudoku(ProblemKey, NewSudoku)),
	maplist(replace_zeroes, NewSudoku, CurrSudoku), % List brauchts 2x um an die einzelnen Elemente ranzukommen
	CurrSudoku = [A, B, C, D, E, F, G, H, I],
	sudoku([A, B, C, D, E, F, G, H, I]),
	prolog_to_json(sudoku_solution(ProblemKey, CurrSudoku), Json_Post),
	% http_post(Url, Data, Reply, Options)
	http_post('http://localhost:16316/problem/sudoku', json(Json_Post), _,[]).

call_relationship(ProblemKey, Relationship, FirstPerson, SecondPerson) :-
	\+ call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(false, ProblemKey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _,[]),
	!.

call_relationship(ProblemKey, Relationship, FirstPerson, SecondPerson) :-
	call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(true, ProblemKey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _, []),
	!.

replace_zeroes(List1, List2) :-
	maplist(replace_value, List1, List2),
	!.
replace_value(0, _). % Replace "0" with "_"
replace_value(X, X). % Otherwise keep value


