% group 172, Hippolyte Le Carreres (hca102), Joseph Agass (jag208)

% Base case: The product of an empty list is 1.
prodMinMax([], 1).

% Single element case: The product is the square of the element.
prodMinMax([X], Product) :-
    Product is X * X.

% General case: Compute the product of the minimum and maximum elements.
prodMinMax([H|T], Product) :-
    find_min_max(T, H, H, Min, Max),
    Product is Min * Max.

% Base case for finding the minimum and maximum:
% If the list is empty, the current Min and Max are the final values.
find_min_max([], Min, Max, Min, Max).

% Recursive case: Compare the current element with the current Min and Max.
find_min_max([H|T], CurrentMin, CurrentMax, Min, Max) :-
    % Check if the current element (H) is smaller than the current minimum.
    % If true, update the minimum to H; otherwise, keep the current minimum.
    (H < CurrentMin -> NewMin = H; NewMin = CurrentMin),

    % Check if the current element (H) is larger than the current maximum.
    % If true, update the maximum to H; otherwise, keep the current maximum.
    (H > CurrentMax -> NewMax = H; NewMax = CurrentMax),
    % Continue recursion with the rest of the list (T), using the updated Min and Max values.
    find_min_max(T, NewMin, NewMax, Min, Max).
