% Operatoren und arithmetische Ausdrücke
% --------------------------------------

% a) Wie wird in SWI-Prolog der Term x is 16 / 4 / 2 ausgewertet?
%    Erklären Sie weshalb das so ist.
%    ------------------------------------------------------------
%    A: Ähnlich wie die "Punkt vor Strich"-Regel. Definiert durch die
%    Präzedenz-Regel wird hier im Term "/" zuerst ausgeführt gefolgt
%    von "is". "/" liegt mit der Präzedenz von 400 tiefer als "is" mit
%    700. Alles was einen tieferen Präzedenz-Wert beinhaltet, wird
%    zuerst ausgeführt.

% b) Was ist die Antwort auf die Anfrage Y = 3, X = Y - 1?
%    ----------------------------------------------------
%    A: Mit "=" wird ein Matching ausgeführt. Und "X" ist halt nicht das
%    gleiche wie "Y - 1"

% c) Was ist die Antwort auf die Anfrage Y = 3, X is Y - 1?
%    Wie lässt sich das unterschiedliche Resultat gegenüber
%    der Teilaufgabe b) erklären?
%    ------------------------------------------------------
%    A: Mit "is" wird explizit eine Auswertung erzwungen, falls die
%    Operanten Zahlen sind.
