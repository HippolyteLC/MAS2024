% group 172, Hippolyte Le Carreres (hca102), Joseph Agass (jag208)

dissimilar([X], [Y]) :-
    X \= Y. % Returns true if two lists with one element each have different elements.

dissimilar([H1|T1], [H2|T2]) :-
    H1 \= H2, % The heads of the lists are different.
    dissimilar(T1, T2). % Recursively checks if the tails are also dissimilar.

dissimilar([], []) :- false. % Returns false if both lists are empty, as empty lists are not considered dissimilar.


dissimilar_anyLength([], []) :- false. % Fails if both lists are empty as two empty lists have the same length of 0.
dissimilar_anyLength([], _). % Returns true if the firrst list is an empty list and the other list is not empty.
dissimilar_anyLength(_, []). % Returns true if the second list is an empty list and the other list is not empty.

dissimilar_anyLength([H1|T1], [H2|T2]) :-
    H1 \= H2, % The heads of the two lists have to be different.
    dissimilar_anyLength(T1, T2). % Recurisvely checks the elements of the tails of the two lists.
