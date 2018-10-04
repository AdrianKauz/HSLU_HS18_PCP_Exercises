female(mary). female(liz). female(mia). female(tina). female(ann). female(sue). % all females
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).            % all males
parent(mary, mia). parent(mary, fred). parent(mary, tina).                      % all childern of mary
parent(mike, mia). parent(mike, fred). parent(mike, tina).                      % all children of mike
parent(liz, tom). parent(liz, joe).                                             % allchildern of liz
parent(jack, tom). parent(jack, joe).                                           % all childern of jack
parent(mia, ann).                                                               % all childern of mia
parent(tina, sue). parent(tina, jim).                                           % all childern of tina
parent(tom, sue). parent(tom, jim).                                             % all childern of tom

mother(PARENT, CHILD) :- parent(PARENT, CHILD), female(PARENT).
father(PARENT, CHILD) :- parent(PARENT, CHILD), male(PARENT).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X\= Y.

% Grossmutter = G, Erzeuger = E, Kind = K
grandmother(G, K) :- parent(E , K), parent(G, E), female(G).

% Is X an offspring of Y?
offspring(CHILD, PARENT) :- parent(PARENT, CHILD).
offspring(CHILD, ANCESTOR) :- parent(ANCESTOR, PARENT), offspring(CHILD, PARENT).
