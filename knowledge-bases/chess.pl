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

