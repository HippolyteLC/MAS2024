%group 172 Joseph Agass, Hippolyte Le Carreres.

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
    
% A cell is black if both coordinates are either even or both are odd.


white(X,Y) :-
    cell(X,Y),
    not(black(X,Y)).
    
% A cell is white if it is not black


same_color(X,Y) :-
    cell(X1, Y1),
    cell(X2, Y2),
    X = cell(X1, Y1),
    Y = cell(X2, Y2),
    (   (   black(X1,Y1), black(X2, Y2));
    (   white(X1, Y1), white(X2, Y2))).
    
% X and Y have the same color if both are black cells or both are white cells.


horizontal_distance(X,Y,Dist) :- 
    horizontal(H), nth1(IX, H, X), nth1(IY, H, Y),
    Dist is abs(IX - IY).

% horizontal distance Dist between cells X and Y, calculated by their positions from the list H.


vertical_distance(X,Y,Dist) :- 
    Dist is abs(Y - X). 
    
% Dist is the vertical distance between cells X and Y, calculated as the absolute difference between Y and X.


distance(A,B,C,D,Dist) :- 
    horizontal_distance(A, C, R1),
    vertical_distance(B, D, R2),
    Dist is R1 + R2.
    
% Dist is the total distance between cells (A, B) and (C, D) calculated as the sum of the horizontal distance R1 and vertical distance R2.


%horizontal
allowed(rook,A,B,C,B) :-
    piece_type(rook),
    cell(A,B), 
    cell(C,B),
    C \= A.

% The rook can move to move horizontally from (A, B) to (C, B) if A and C are in the same row and different columns.



%vertical
allowed(rook,A,B,A,C) :-
    piece_type(rook),
    cell(A,B), 
    cell(A,C),
    C \= B.

% The rook is allowed to move vertically from (A, B) to (A, C) if A and C are in the same column and different rows.




%only for white pawns
allowed(pawn,A,B,A,C) :-
    piece_type(pawn), 
(    (cell(A,B), B =:= 2, (C is 4; C is 3), cell(A, C)) ;

    (cell(A,B), B > 2, C is B + 1, cell(A, C))).

% The white pawn can move from (A, B) to (A, C). If it moves from row 2, it can move one or two squares forward, from other rows, it can only move one square forward.



allowed(queen,A,B,C,D) :-
    piece_type(queen),
    horizontal(H),
    vertical(V),
    nth0(IndexA, H, A),
    nth0(IndexB, V, B),
    nth0(IndexC, H, C),
    nth0(IndexD, V, D),
    %here we check for vertical only V horizontal only V diagonal only
    ((IndexA - IndexC) =:= (IndexB - IndexD);
    IndexA =:= IndexC;
    IndexB =:= IndexD),
    cell(A, B) \= cell(C,D).    

    % The queen can move from (A, B) to (C, D) if the move is vertical, horizontal, or diagonal, provided, the starting square is not the same as the destination square.


allowed(bishop,A,B,C,D) :-
    piece_type(bishop),
    horizontal(H),
    vertical(V),
    nth0(IndexA, H, A),
    nth0(IndexB, V, B),
    nth0(IndexC, H, C),
    nth0(IndexD, V, D),
    (IndexA - IndexC) =:= (IndexB - IndexD),
    cell(A, B) \= cell(C,D).    

% The bishop can move from (A, B) to (C, D) if the move is diagonal, meaning the change in row equals the change in column, and the cells are not the same.



allowed(horse, A,B,C,D) :-
    piece_type(horse),
    horizontal(H),
    vertical(V),
    nth0(IndexA, H, A),
    nth0(IndexB, V, B),
    nth0(IndexC, H, C),
    nth0(IndexD, V, D),
(
(    abs(IndexC - IndexA) =:= 2,
    abs(IndexD - IndexB) =:= 1);
(    abs(IndexC - IndexA) =:= 1,
    abs(IndexD - IndexB) =:= 2)
),
    cell(A, B) \= cell(C,D). 

% The knight can move from (A, B) to (C, D) if it moves in an "L" shape: two squares in one direction and one in the perpendicular direction, and if the cells are not the same.



allowed(king,A,B,C,D) :-
    piece_type(king),
    
    horizontal(H),
    vertical(V),
    member(B,V),
    member(A,H),
    member(D,V),
    member(C,H),

% The king can move from (A, B) to (C, D) if the squares exist.



%get the indices of the current cell and next cell
    nth0(IndexA, H, A),
    nth0(IndexB, V, B),
    nth0(IndexC, H, C),
    nth0(IndexD, V, D),
%make sure the difference in index is 0 or 1(i.e. that the distance is 1). The abs ensures for all cases
%that the next cell is only 1 index later in the hori and/or verti list
    abs(IndexC - IndexA) =< 1,
    abs(IndexD - IndexB) =< 1,
    cell(A, B) \= cell(C,D).

%case for N = 1
reachable(Piece,A,B,C,D,1) :-
    allowed(Piece,A,B,C,D).
%case for N = 2
reachable(Piece,A,B,C,D,2) :-
    allowed(Piece,A,B,C1,D1),
    allowed(Piece,C1,D1,C,D).
%case for N = 3
reachable(Piece,A,B,C,D,3) :-
    allowed(Piece,A,B,C1,D1),
    allowed(Piece,C1,D1,C2,D2),
    allowed(Piece,C2,D2,C,D).

% base case for N=1
reachableInN(Piece,A,B,C,D,1) :- allowed(Piece,A,B,C,D).

%recursion rule, the rule checks that N greater than 1 
%and sees which moves are allowed, reduces N, and then recursively calls itself with the new N value and the new cell coords 
reachableInN(Piece,A,B,C,D,N) :- 
    N > 1, 
    allowed(Piece, A,B,C1,D1), 
    NewN is N-1, 
    reachableInN(Piece,C1,D1,C,D,NewN).

    


    
