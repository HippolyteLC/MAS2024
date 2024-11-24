
% this rule counts the yy occurences
count_yy([], [], 0). 
count_yy([H1|T1], [H2|T2], YY) :-
    count_yy(T1, T2, NewYY),  
    (   H1 = H2, H2 = 1       
    ->  YY is NewYY + 1       
    ;   YY = NewYY           
    ).

% this rule counts the yn occurences
count_yn([], [], 0). 
count_yn([H1|T1], [H2|T2], YN) :-
    count_yn(T1, T2, NewYN),  
    (   H1 = 1, H2 = 0       
    ->  YN is NewYN + 1       
    ;   YN = NewYN           
    ).

% this rule counts the ny occurences
count_ny([], [], 0). 
count_ny([H1|T1], [H2|T2], NY) :-
    count_ny(T1, T2, NewNY),  
    (   H1 = 0, H2 = 1       
    ->  NY is NewNY + 1       
    ;   NY = NewNY           
    ).

% this rule counts the nn occurences
count_nn([], [], 0). 
count_nn([H1|T1], [H2|T2], NN) :-
    count_nn(T1, T2, NewNN),  
    (   H1 = H2, H2 = 0     
    ->  NN is NewNN + 1       
    ;   NN = NewNN           
    ).

% here all the recursive rules are called to obtain all occ values.
count_agreement(L1, L2, YY, YN, NY, NN) :-
    count_yy(L1, L2, YY), 
    count_yn(L1, L2, YN), 
    count_ny(L1, L2, NY), 
    count_nn(L1, L2, NN).

% OA calculation (or Po)
observed_agreement(YY, YN, NY, NN, OA) :-
    OA is (YY+NN) / (YY + YN + NY + NN).

% CA calculation (or Pe)
chance_agreement(YY,YN,NY,NN,CA) :-
    CA is (((YY+YN)/ (YY+YN+NY+NN)) * ((YY+NY)/ (YY+YN+NY+NN))) 
    + (((NN+YN)/ (YY+YN+NY+NN)) * ((NN+NY)/ (YY+YN+NY+NN))).

% calling all the functions and returing the ck val.
ck(L1, L2, CK) :-
    count_agreement(L1, L2, YY, YN, NY, NN),
    observed_agreement(YY, YN, NY, NN, OA),
    chance_agreement(YY,YN,NY,NN,CA),
    CK is (OA - CA)/(1-CA).

