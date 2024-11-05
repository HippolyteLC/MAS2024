horizontal([a,b,c,d,e,f,g,h]).
vertical([1,2,3,4,5,6,7,8]).
cell(X,Y) :- horizontal(H), vertical(V), member(X,H), member(Y,V).

even_letters([b,d,f,h]).
even_letter(X) :- even_letters(E), member(X, E).
even_number(X) :- X mod 2 =:= 0.
% for column A have all uneven be black, and column B all even, and then
% cycle back through


black(X,Y) :-
    cell(X, Y),
    (   (   even_letter(X), even_number(Y) );
    (   not(even_letter(X)), not(even_number(Y)) )).
white(X,Y) :-
    cell(X,Y),
    not(black(X,Y)).

same_color(X,Y) :-
    cell(X1, Y1),
    cell(X2, Y2),
    X = cell(X1, Y1),
    Y = cell(X2, Y2),
    (   (   black(X1,Y1), black(X2, Y2));
    (   white(X1, Y1), white(X2, Y2))).

horizontal_distance(X,Y,Dist) :- 
    horizontal(H), nth1(IX, H, X), nth1(IY, H, Y),
    Dist is abs(IX - IY).

vertical_distance(X,Y,Dist) :- 
    Dist is abs(Y - X). 

distance(A,B,C,D,Dist) :- 
    horizontal_distance(A, C, R1),
    vertical_distance(B, D, R2),
    Dist is R1 + R2.



