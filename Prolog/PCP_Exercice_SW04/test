% =========================================================================================
% Übung 1
% =========================================================================================
:- use_module(library(clpr)).

fib_clp(N, F) :- { N = 0, F = 0 }.
fib_clp(N, F) :- { N = 1, F = 1 }.
fib_clp(N, F) :-
	{ N >= 2,
	  F = F1+F2,
	  N1 = N-1,
	  N2 = N-2 },
	fib_clp(N1, F1),
	fib_clp(N2, F2).

% a) ERROR: Out of global stack
% b) Es werden alle rellen Zahlen durchprobiert bis der Stack ausgeht
% c) F1 und F2 müssen in Beziehung zu N stehen

% =========================================================================================
% Übung 2
% =========================================================================================

% set_difference([a, b, c, d], [b, d, e, f], [a, c]).
% set_difference([1, 2, 3, 4, 5, 6], [2, 4, 6], L).

set_difference([E | Set1], Set2, [E | SetDifference]) :-
	\+ member(E, Set2),
	set_difference(Set1, Set2, SetDifference).

set_difference([E | Set1], Set2, SetDifference) :-
	member(E, Set2),
	set_difference(Set1, Set2, SetDifference).

set_difference([], _, []).

% =========================================================================================
% Übung 3
% =========================================================================================

% Die Tochter ist 15 Jahre alt, die Mutter dreimal so alt. In wie vielen
% Jahren wird die Mutter nur noch doppelt so alt sein wie ihre Tochter?
%
% {T = 15, M = 3*T, M = 2*T + Y}.

:- use_module(library(clpfd)).

send_more_money([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y]) :-
	Vars = [S,E,N,D,M,O,R,Y],  % define the variables
	Vars ins 0..9, % define the domain for the vars
	all_distinct(Vars), % all variables must be different
	S*1000 + E*100 + N*10 + D +
	M*1000 + O*100 + R*10 + E #=  % attention: use #=/2
	M*10000 + O*1000 + N*100 + E*10 + Y,  % addition must be ok
	M #\= 0, S #\= 0,  % numbers cannot start with zero
	label(Vars). % assign values to the variables

donald_gerald_robert([D,O,N,A,L,D] + [G,E,R,A,L,D] = [R,O,B,E,R,T]) :-
		     Vars = [D,O,N,A,L,G,E,R,B,T],
		     Vars ins 0..9,
		     all_distinct(Vars),
		     D*100000 + O*10000 + N*1000 + A*100 + L*10 + D +
		     G*100000 + E*10000 + R*1000 + A*100 + L*10 + D #=
		     R*100000 + O*10000 + B*1000 + E*100 + R*10 + T,
		     D #\= 0, G #\= 0, R #\= 0,
		     label(Vars).


donald_gerald_robert([D,O,N,A,L,D] + [G,E,R,A,L,D] = [R,O,B,E,R,T]):-
		    Vars = [A,B,D,E,G,L,N,O,R,T],  % define the variables
		    Vars ins 0..9,                 % define the domain for the vars
		    all_distinct(Vars),            % all variables must be different
		    D*100000 + O*10000 + N*1000 + A*100 + L*10 + D +
		    G*100000 + E*10000 + R*1000 + A*100 + L*10 + D #=
		    R*100000 + O*10000 + B*1000 + E*100 + R*10 + T,
		    D #\=0, % D mustn't be zero
		    G #\=0, % G mustn't be zero
		    label(Vars).


% =========================================================================================
% Übung 4
% =========================================================================================
%
% solve(relationship, 326).

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
