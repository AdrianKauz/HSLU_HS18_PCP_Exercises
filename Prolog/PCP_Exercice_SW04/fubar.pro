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
	mother(X, Z).

offspring(X, Y) :- parent(Y, X).
offspring(X, Y) :- parent(Z, X),
	parent(Z, Y).

/*
Puzzle = [
[5, 3, _, _, 7, _, _, _, _],
[6, _, _, 1, 9, 5, _, _, _],
[_, 9, 8, _, _, _, _, 6, _],
[8, _, _, _, 6, _, _, _, 3],
[4, _, _, 8, _, 3, _, _, 1],
[7, _, _, _, 2, _, _, _, 6],
[_, 6, _, _, _, _, 2, 8, _],
[_, _, _, 4, 1, 9, _, _, _],
[_, _, _, _, 8, _, _, 7, 9]
],
Puzzle = [A, B, C, D, E, F, G, H, I],
sudoku([A, B, C, D, E, F, G, H, I]).
*/

:- use_module(library(clpfd)).

sudoku(Rows) :-
	append(Rows, Vs), Vs ins 1..9,
	maplist(all_distinct, Rows),
	transpose(Rows, Columns),
	maplist(all_distinct, Columns),
	Rows = [A, B, C, D, E, F, G, H, I],
	blocks(A, B, C), blocks(D, E, F), blocks(G, H, I),
	maplist(label, Rows).

blocks([], [], []).
blocks([A, B, C|Bs1], [D, E, F|Bs2], [G, H, I|Bs3]) :-
	all_distinct([A, B, C, D, E, F, G, H, I]),
	blocks(Bs1, Bs2, Bs3).

:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_client)).

:- json_object
        relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom),
	sudoku(problemKey:integer, sudoku:list),
	% Switch to boolean when server is fixed
	solution(solution:atomic, problemKey:integer),
	sudoku_solution(problemKey:integer, solution:list).

solve(relationship, Id) :-
	atom_concat('http://localhost:16316/problem/relationship/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, relationship(Problemkey, Relationship, FirstPerson, SecondPerson)),
	call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson).

solve(sudoku, Id) :-
	atom_concat('http://localhost:16316/problem/sudoku/', Id, Url),
	http_get(Url, Json, []),
	json_to_prolog(Json, sudoku(Problemkey, Sudoku_0)),
	maplist(replace_0, Sudoku_0, Sudoku),
	Sudoku = [A, B, C, D, E, F, G, H, I],
	sudoku([A, B, C, D, E, F, G, H, I]),
	prolog_to_json(sudoku_solution(Problemkey, Sudoku), Json_Post),
	http_post('http://localhost:16316/problem/sudoku', json(Json_Post), _,[]).

call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	\+ call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(false, Problemkey), Json),
	http_post('http://localhost:16316/problem/relationship/', json(Json), _,[]),
	!.

call_relationship(Problemkey, Relationship, FirstPerson, SecondPerson) :-
	call(Relationship, FirstPerson, SecondPerson),
	prolog_to_json(solution(true, Problemkey), Json),
	% Why json(json()) Prolog-Bug?
	http_post('http://localhost:16316/problem/relationship/', json(Json), _, []),
	!.

replace_0(L1, L2) :-
	maplist(replace_help, L1, L2),
	!.
replace_help(0, _).
replace_help(X, X).
