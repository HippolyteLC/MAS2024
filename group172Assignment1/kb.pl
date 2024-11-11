%Prolog data base for assignment 1 exercise 1.

boiling(water). % water is used as a constant as it is assumed that this specific water is boiling.
drinking_tea(ravi, alexandra). % Ravi and Alexandra are of type constant since these people specifically are drinking tea together.
likes(alexandra, rooibos). % Alexandra likes a specfic type of tea, a constant called Rooibos
has_motherboard(X) :- isComputer(X). % Every computer X has to have a motherboard. Variable X was used as there could be different computers that have a motherboard.
has_motherboard(X) :- isSmartphone(X). % Every smartphone X has to have a motherboard. Variable X was used as there could be different smartphones that have a motherboard.
functions(X) :- hasBattery(X),
                isPluggedIn(X). % A laptop X only functions if it has battery and it is plugged in.
can_play_video_game(X) :- hasGamingDevice(X), masAssignment(X). % A person X can play a video game if they have a gaming device and they have completed their MAS assignment.
game_is_good(X) :- engaging(X), immersive(X). % A video game X is good if it is engaging and immersive.
