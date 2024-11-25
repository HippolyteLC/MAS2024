% group 172, Hippolyte Le Carreres (hca102), Joseph Agass (jag208)

% Returns true if the input list is empty, with the result also being empty.
% This is the base case so that the recursion doesn't continue infinitely.
% And since empty lists don't have any elements, there can't be any duplicate elements.
remove_duplicates([], []).

% Checks if the head exists again in the tail (i.e., a duplicate of the head).
% If there isn't a duplicate, then this clause is skipped and the next rule is tried.
remove_duplicates([H|T], Result) :-
    exists_in_tail(H, T),
    remove_duplicates(T, Result). % Skips the head and recursively processes the tail.

% Handles the case where the head is unique (i.e., it does not exist in the tail).
% Adds the head to the result list and continues processing the rest of the list recursively.
remove_duplicates([H|T], [H|Result]) :-
    \+ exists_in_tail(H, T),
    remove_duplicates(T, Result).

% The element exists in the tail if it matches the head of the tail
exists_in_tail(X, [X|_]).

% Otherwise, the rest of the tail is recursively checked.
exists_in_tail(X, [_|T]) :-
    exists_in_tail(X, T).

