% group 172, Hippolyte Le Carreres (hca102), Joseph Agass (jag208)

% this rule counts the yy occurences
count_yy([], [], 0). 
count_yy([H1|T1], [H2|T2], YY) :-
    count_yy(T1, T2, NewYY),  
    % check if the heads of the two lists are 1
    % if so, increment the count of YY by 1 
    (   H1 = H2, H2 = 1       
    ->  YY is NewYY + 1       
    ;   YY = NewYY           
    ).

% this rule counts the yn occurences
count_yn([], [], 0). 
count_yn([H1|T1], [H2|T2], YN) :-
    count_yn(T1, T2, NewYN),  
    % check if the head of the first list is 1, and the head of the 
    % other list is 0
    % if so, increment the count of YN by 1 
    (   H1 = 1, H2 = 0       
    ->  YN is NewYN + 1       
    ;   YN = NewYN           
    ).

% this rule counts the ny occurences
count_ny([], [], 0). 
count_ny([H1|T1], [H2|T2], NY) :-
    count_ny(T1, T2, NewNY),  
    % check if the head of the first list is 0 and the head of the 
    % other list is 1
    % if so, increment the count of NY by 1 
    (   H1 = 0, H2 = 1       
    ->  NY is NewNY + 1       
    ;   NY = NewNY           
    ).

% this rule counts the nn occurences
count_nn([], [], 0). 
count_nn([H1|T1], [H2|T2], NN) :-
    count_nn(T1, T2, NewNN),  
    % check if the head of the first list is 0 and the head of the 
    % other list is 0
    % if so, increment the count of NN by 1 
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
    % sum of agreements divided by the total inputs
    OA is (YY+NN) / (YY + YN + NY + NN).

% CA calculation (or Pe)
chance_agreement(YY,YN,NY,NN,CA) :-
    % the probability of 1s by the first annotator, multiplied by the prob 
    % of 1s by the second annotator
    %then prob of 0s multplied by prob of 0s of other annotator 
    % and these two multiplications are summed to obtain the Change Agreement value
    CA is (((YY+YN)/ (YY+YN+NY+NN)) * ((YY+NY)/ (YY+YN+NY+NN))) 
    + (((NN+YN)/ (YY+YN+NY+NN)) * ((NN+NY)/ (YY+YN+NY+NN))).

% calling all the functions and returing the ck val.
ck(L1, L2, CK) :-
    count_agreement(L1, L2, YY, YN, NY, NN),
    observed_agreement(YY, YN, NY, NN, OA),
    chance_agreement(YY,YN,NY,NN,CA),
    CK is (OA - CA)/(1-CA).



