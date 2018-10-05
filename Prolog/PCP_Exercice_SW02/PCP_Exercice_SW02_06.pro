% Operatoren und arithmetische Ausdr�cke
% --------------------------------------

% a) Wie wird in SWI-Prolog der Term x is 16 / 4 / 2 ausgewertet?
%    Erkl�ren Sie weshalb das so ist.
%    ------------------------------------------------------------
%    A: �hnlich wie die "Punkt vor Strich"-Regel. Definiert durch die
%    Pr�zedenz-Regel wird hier im Term "/" zuerst ausgef�hrt gefolgt
%    von "is". "/" liegt mit der Pr�zedenz von 400 tiefer als "is" mit
%    700. Alles was einen tieferen Pr�zedenz-Wert beinhaltet, wird
%    zuerst ausgef�hrt.

% b) Was ist die Antwort auf die Anfrage Y = 3, X = Y - 1?
%    ----------------------------------------------------
%    A: Mit "=" wird ein Matching ausgef�hrt. Und "X" ist halt nicht das
%    gleiche wie "Y - 1"

% c) Was ist die Antwort auf die Anfrage Y = 3, X is Y - 1?
%    Wie l�sst sich das unterschiedliche Resultat gegen�ber
%    der Teilaufgabe b) erkl�ren?
%    ------------------------------------------------------
%    A: Mit "is" wird explizit eine Auswertung erzwungen, falls die
%    Operanten Zahlen sind.
