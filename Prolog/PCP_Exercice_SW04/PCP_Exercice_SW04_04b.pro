:- use_module(library(clpfd)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json_convert)).

/*
=============
 Relationship
=============
*/
female(mary). female(liz). female(mia). female(tina). female(ann). female(sue). % all females
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).            % all males
parent(mary, mia). parent(mary, fred). parent(mary, tina).                      % all childern of mary
parent(mike, mia). parent(mike, fred). parent(mike, tina).                      % all children of mike
parent(liz, tom). parent(liz, joe).                                             % allchildern of liz
parent(jack, tom). parent(jack, joe).                                           % all childern of jack
parent(mia, ann).                                                               % all childern of mia
parent(tina, sue). parent(tina, jim).                                           % all childern of tina
parent(tom, sue). parent(tom, jim).                                             % all childern of tom

mother(PARENT, CHILD) :-
    parent(PARENT, CHILD),
    female(PARENT).

father(PARENT, CHILD) :-
    parent(PARENT, CHILD),
    male(PARENT).

sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X\= Y.

% Grossmutter = G, Erzeuger = E, Kind = K
grandmother(G, K) :-
    parent(E, K),
    parent(G, E),
    female(G).

% Grossvater = G, Erzeuger = E, Kind = K
grandfather(G, K) :-
    parent(E, K),
    parent(G, E),
    male(G).

% Is X an offspring of Y?
offspring(CHILD, PARENT) :- parent(PARENT, CHILD).
offspring(CHILD, ANCESTOR) :-
    parent(ANCESTOR, PARENT),
    offspring(CHILD, PARENT).


/*
=============
 Sodoku
=============
*/
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


%Puzzle = [
%    [5, 3, _, _, 7, _, _, _, _],
%    [6, _, _, 1, 9, 5, _, _, _],
%    [_, 9, 8, _, _, _, _, _, _],
%    [8, _, _, _, 6, _, _, _, 3],
%    [4, _, _, 8, _, 3, _, _, 1],
%    [7, _, _, _, 2, _, _, _, 6],
%    [_, 6, _, _, _, _, 2, 8, _],
%    [_, _, _, 4, 1, 9, _, _, _],
%    [_, _, _, _, 8, _, _, 7, 9]
%    ],
%    Puzzle = [A, B, C, D, E, F, G, H, I],
%    sudoku([A, B, C, D, E, F, G, H, I]).
%
:- Puzzle = [[5, 3, _, _, 7, _, _, _, _],[6, _, _, 1, 9, 5, _, _, _],[_,9, 8, _, _, _, _, _, _],[8, _, _, _, 6, _, _, _, 3],[4, _, _, 8, _, 3, _, _, 1],[7, _, _, _, 2, _, _, _, 6],[_, 6, _, _, _, _, 2, 8, _],[_, _, _, 4, 1, 9, _, _, _],[_, _, _, _, 8, _, _, 7, 9]],Puzzle = [A, B, C, D, E, F, G, H, I],sudoku([A, B, C, D, E, F, G, H, I]).


/*
=============
 HTTP & JSON (With a little help)
=============
*/
% Aus Ilias. Sollte selbsterklärend sein. Objekt-Definitionen.
:- json_object
        relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom),
	sudoku(problemKey:integer, sudoku:list),
	relationship_solution(solution:atomic, problemKey:integer),
	sudoku_solution(problemKey:integer, solution:list).

solve(relationship, Id) :-
	atom_concat('http://localhost:16316/problem/relationship/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, relationship(Problemkey, Relationship, FirstPerson, SecondPerson)),
	call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson).

solve(sudoku, Id) :-
	atom_concat('http://localhost:16316/problem/sudoku/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, sudoku(Problemkey, NewSudoku)),
	maplist(replace_zeroes, NewSudoku, Sudoku),
	Sudoku = [A, B, C, D, E, F, G, H, I],
	sudoku([A, B, C, D, E, F, G, H, I]),
	prolog_to_json(sudoku_solution(Problemkey, Sudoku), Json_Post),
	http_post('http://localhost:16316/problem/sudoku', json(Json_Post), _,[]).

% Falls die Antwort falsch ist
call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	\+ call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(relationship_solution(false, Problemkey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _,[]),
	!.

% Falls die Antwort richtig ist
call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(true, Problemkey), Json),
	% Why json(json()) Prolog-Bug?
	http_post('http://localhost:16316/problem/relationship/', json(Json), _, []),
	!.

replace_zeroes(L1, L2) :-
	maplist(replace_rule, L1, L2),
	!.
replace_rule(0, _). % Replace "0" with "_"
replace_rule(X, X). % Otherwise keep value
