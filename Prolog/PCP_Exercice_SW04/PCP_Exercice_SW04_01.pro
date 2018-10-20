:- use_module(library(clpr)).
fib_clp(N, F) :- {N = 0, F = 0}. % Die 0. Fibonacci-Zahl für 0 ist 0
fib_clp(N, F) :- {N = 1, F = 1}. % Die 1. Fibonacci-Zahl für 1 ist 1
fib_clp(N, F) :-
    { N >= 2,
      F = F1+F2,
      N1 = N-1,
      N2 = N-2,
      N1 >= N2,
      N1 =< F1+1,
      N2 =< F2+1},
    fib_clp(N1, F1),
    fib_clp(N2, F2).


% In der Vorlesung wurde erwähnt, dass die gezeigte Berechnung
% (Prädikat fib_clp/2) von Fibonacci-Zahlen mit CLP-R ein Problem hat,
% wenn das zweite Argument von fib_clp/2 gar keine Fibonacci-Zahl ist
% (siehe Prolog 5, Folie 31).
% Dasselbe Problem tritt auch auf, wenn zu einer gegeben
% Fibonacci-Zahl nach der ersten, korrekten Antwort weitere Lösungen
% (durch drücken von ; bzw. der Leerschlagtaste) gesucht werden.

% a) Wie manifestiert sich dieses Problem in SWI-Prolog?
%    - Prolog meldet nach einer Weile:
%      "ERROR:Out of global stack
%       Exception: (33) bv_r:export_binding(_65378072{itf = ...}, 1.0)?"
%
% b) Wieso tritt dieses Problem auf?
%    - Prolog versucht hier eine Lösung zu finden und probiert alle
%      möglichen Zahlen für N aus. Somit füllt sich nach und nach der
%      Stack auf. Hier müsste noch eine Beziehung von N zu F definiert
%      werden, damit die nächste Rekursion nicht aufgerufen wird.
%
% c) Lässt sich das oben beschriebene Problem einfach beheben?
%    Falls ja: Modifizieren Sie das Prädikat entsprechend und testen sie
%    das neue Prädikat.
%    Falls Nein: Begründen Sie Ihre Antwort.
%    - Ja. Wenn man sich mal eine Tabelle erstellt in Bezug N zu F,
%      fällt auf, dass N immer <= F ist. Diese Regel eingesetzt und es
%      klappt.









