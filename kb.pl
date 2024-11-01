%Prolog data base for assignment 1 exercise 1.
boiling(water).
drinking_tea(ravi, alexandra). likes(alexandra, rooibos).

hasBattery(macbook).
isPluggedIn(macbook).
isComputer(macbook).
isSmartphone(iphone).
has_motherboard(X) :- isComputer(X);
                     isSmartphone(X).
functions(X) :- hasBattery(X),
                isPluggedIn(X).
immersive(fifa2023).
engaging(twoofus).
hasGamingDevice(toni).
masAssignment(fred).
masAssignment(elia). hasGamingDevice(elia).
can_play_video_game(X) :- hasGamingDevice(X), masAssignment(X).

game_is_good(X) :- engaging(X), immersive(X).
