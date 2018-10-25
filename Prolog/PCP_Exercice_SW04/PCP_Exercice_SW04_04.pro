:- use_module(library(clpfd)).
:- use_module(library(http/json)).
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
 HTTP & JSON
=============
*/
:- json_object
        relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom),
	sudoku(problemKey:integer, sudoku:list),
	% Switch to boolean when server is fixed
	solution(solution:atomic, problemKey:integer),
	sudoku_solution(problemKey:integer, solution:list).

solve(relationship, Id) :-
    atom_concat('http://localhost:16316/problem/relationship/', Id, Url),
    http_get(Url, Json, []),
    % {"firstPerson":"mike","problemKey":42,"relationship":"father","secondPerson":"tina"}
    json_to_prolog(Json, relationship(FirstPerson, ProblemKey, Relationship, SecondPerson)),
    relationship(ProblemKey, Relationship, FirstPerson, SecondPerson).


% If result is false
relationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	\+ call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(@true, Problemkey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _,[]).

% If result is true
relationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(@true, Problemkey), Json),
        http_post('http://localhost:16316/problem/relationship/', json(Json), _,[]).



/*
solve_relationship(Object, Result) :-
	Object = json([firstPerson=Y, problemKey=_,
		       relationship=Rela,secondPerson=Z]),
	call(Rela,Y,Z),
	Result = true, !.
solve_relationship(_, Result) :-
	Result = false.



solve(Problem,ID) :-
	atom_concat('http://localhost:16316/problem/',Problem,L1),
	atom_concat(L1,/,L2),
	atom_concat(L2, ID, L3),
	http_get(L3, Json, []),
	json_to_prolog(Json, Object),
	atom_concat('solve_', Problem, Call),
	call(Call, Object, Result),
	JsonRes = json([problemKey=ID, solution=Result]),
	http_post(L1, json(JsonRes),_,[]).


% Replace

replace_0([] , [] ).
replace_0([0 | L1], [_| L2]) :- replace_0(L1, L2).
replace_0([X | L1], [X| L2]) :- X \= 0,
	replace_0(L1, L2).


solve_sudoku(Object, Sud_) :-
       Object = json([problemKey=_,sudoku= Sud0]),
       maplist(replace_0, Sud0, Sud_),
       Sud_ = [A, B, C, D, E, F, G, H, I],
       sudoku([A,B,C,D,E,F,G,H,I]).
*/
