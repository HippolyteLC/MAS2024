%Group 172, Hippolyte Le Carreres(hca102), Joseph Agess(jga)

step('pancakes', 1, 'Fill a mixing bowl with the flour, eggs and milk.',
     ['flour', 'eggs', 'milk'], ['mixing bowl']).
step('pancakes', 2, 'Mix the ingredients to a coherent batter.',
     [], ['mixing bowl', 'mixer']).
step('pancakes', 3, 'Heat a pan with a knob of butter.',
     ['butter'], ['pan']).
step('pancakes', 4, 'Bake the pancakes until all the batter is used up.',
     [], ['pan']).
step('pasta', 1, 'Boil a pan full of water.',
     ['water'], ['cooking pan']).
step('pasta', 2, 'Cut the garlic.',
     ['garlic'], ['kitchen knife', 'cutting board']).
step('pasta', 3, 'When the water boils, add the penne.',
     ['water', 'penne'], ['cooking pan']).
step('pasta', 4, 'Garnish to taste with grated cheese and your pasta is finished.',
     ['grated cheese'], []).

% ingredient predicate --> (Recipe, Ingredient, Number of persons, Amount, Unit)
ingredient('pasta', 'water', 4, 1000, 'millilitre').
ingredient('pasta', 'penne', 4, 400, 'grams').
ingredient('pasta', 'garlic', 4, 2, 'cloves').
ingredient('pasta', 'grated cheese', 4, 50, 'grams').


getStepText(Recipe,Index, Text) :-
    step(Recipe, Index, Text, _, _).
getSteps(Recipe, Steps) :-
    findall(Steps, step(Recipe, Steps, _, _, _), Steps).

%this rule concatenates the list of lists into a single 
%list of ingredients using recursion
concat_list([], []).
concat_list([H|T], Result) :-
     append(H, Placeholder, Result),
     concat_list(T, Placeholder).

% finds all ingredients and returns the list of ingredients
getIngredients(Recipe, Ingredients) :- 
     findall(Ingr, step(Recipe, _, _, Ingr, _), Ings),
     concat_list(Ings, IngredientsPre),
     list_to_set(IngredientsPre, Ingredients).

%checks if an item (utensil) is in a list 
checkUtensil([Utensil|_], Utensil).
checkUtensil([_|T], Utensil) :-
     checkUtensil(T, Utensil).

% checks first for utensil list of a recipe, then 
% checks for membership of target utensil in that list
% and then checks for all Texts that are part of steps that satisfy prior 
% conditions and puts into list
utensilSteps(Recipe, Utensil, StepTexts) :-
     step(Recipe, _, _, _, Utensils),
     checkUtensil(Utensils, Utensil),
     findall(Texts, step(Recipe, _, Texts, _, Utensils), StepTexts).

%returns the quantity in list format with unit of a given ingredient
returnQuantity(Recipe, Ingredient, NPeople, Quantity) :-
     ingredient(Recipe, Ingredient, X, CurrQuantity, Unit),
     Q is ((CurrQuantity/X) * NPeople),
     Quantity = [Q, Unit].

%sub rule for returnStepQuantity. obtains ingredient, quantity, and unit
%useful for use findall in nexrt rule
returnQuantityIngredient(Recipe, Ingredient, NPeople, Quantity) :-
     ingredient(Recipe, Ingredient, X, CurrQuantity, Unit),
     Q is ((CurrQuantity/X) * NPeople),
     Quantity = [Ingredient, Q, Unit].

%utilises previous functions to obtains quantity values at a sepecific
%step for a given recipe. Returns it in list of list format. 
returnStepQuantity(Recipe, Stepnumber, NumPeople, Quantity) :-
     step(Recipe, Stepnumber, _, Ingredients, _),
     checkUtensil(Ingredients, Ingredient),
     findall(CurrQuantity, returnQuantityIngredient(Recipe, Ingredient, NumPeople, 
     CurrQuantity), Quantity).
     
     



