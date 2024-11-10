horizontal([a,b,c,d,e,f,g,h]).
vertical([1,2,3,4,5,6,7,8]).
piece_type(pawn).
piece_type(rook).
piece_type(horse).
piece_type(bishop).
piece_type(queen).
piece_type(king).
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

%horizontal
allowed(rook,A,B,C,B) :-
    piece_type(rook),
    cell(A,B),
    cell(C,B),
    C \= A.

%vertical
allowed(rook,A,B,A,C) :-
    piece_type(rook),
    cell(A,B),
    cell(A,C),
    C \= B.

%only for white pawns
allowed(pawn,A,B,A,C) :-
    piece_type(pawn),
(    (cell(A,B), B =:= 2, C is 4, cell(A, C)) ;
    (cell(A,B), B > 2, C is B + 1, cell(A, C))).


allowed(horse, A, B, C, D) :-
    piece_type(horse),
    cell(A, B), cell(C, D),
    ((horizontal_distance(A, C, 2), vertical_distance(B, D, 1)) ;
     (horizontal_distance(A, C, 1), vertical_distance(B, D, 2))),
    ((black(A, B), white(C, D)) ; (white(A, B), black(C, D))).

allowed(bishop, A, B, C, D) :-
    piece_type(bishop),
    cell(A, B), cell(C, D),
    horizontal_distance(A, C, Dist),
    vertical_distance(B, D, Dist).

allowed(queen, A, B, C, D) :-
    piece_type(queen),
    cell(A, B), cell(C, D),
    ((horizontal_distance(A, C, Dist), Dist > 0, B = D) ;
     (vertical_distance(B, D, Dist), Dist > 0, A = C) ;
     (horizontal_distance(A, C, Dist), vertical_distance(B, D, Dist), Dist > 0)).

allowed(king, A, B, C, D) :-
    piece_type(king),
    cell(A, B), cell(C, D),
    horizontal_distance(A, C, HDist),
    vertical_distance(B, D, VDist),
    max(HDist, VDist) =:= 1.




