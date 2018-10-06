% Multiplikation durch rekursive Addition
% ---------------------------------------

% a) Implementieren Sie ein eigenes Pr�dikat mult/3, welches erf�llt
%    ist, wenn die ersten beiden Argumente miteinander multipliziert,
%    dem Wert des dritten Arguments entsprechen. Dazu d�rfen Sie den
%    Multiplikationsoperator nicht verwenden, sondern Sie sollen
%    multiplizieren durch wiederholtes addieren. Der Aufruf von
%    mult(3, 4, X) soll also beispielsweise X = 12 zur�ck liefern und
%    mult(3, 4, 11) entsprechend false. Sie d�rfen davon ausgehen, dass
%    die ersten beiden Argumente >= 0 sind. Hinweis: Achtung, mult/3
%    soll auch funktionieren, falls eines der ersten zwei oder die beide
%    ersten Argumente 0 oder 1 sind, also z.B. f�r die F�lle
%    mult(3, 0, X), mult(0, 3, 0) oder (77, 1, X).

mult(_, 0, 0).
mult(0, _, 0).
mult(Fakt1, Fakt2, Prod) :-
    Count is Fakt1 - 1,            % Z�hlt Runter
    >=(Count, 0),                  % b) Z�hler darf nicht unter 0 gehen
    mult(Count, Fakt2, ProdTemp),  % Solange Z�hler >=0 rufe sich selbst auf
    Prod is ProdTemp + Fakt2.      % Zwischenresultat

% b) Wie k�nnen Sie verhindern, dass mult/3 den Fehler �Out of local
%    stack� produziert? Dies passiert beispielsweise, wenn Sie sich vom
%    System beim Aufruf von mult(3, 4, X) alle L�sungen f�r X angeben
%    lassen (indem Sie wiederholt ; dr�cken). Wie entsteht dieser
%    Fehler? Verbessern Sie ihr Pr�dikat mult/3 so, dass dieser Fehler
%    nicht mehr auftreten kann.
