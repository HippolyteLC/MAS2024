% Knowledge base for the BW4T robot.
% Manages dynamic predicates and rules for environment awareness.

:- dynamic
	in/1,                % Current location of the robot.
	state/1,             % Current movement state.
	visited/1,           % Tracks visited rooms.
	zone/5,              % Zone information.
	color/2,             % Block color information.
	sequence/1,          % Goal sequence of blocks.
	sequenceIndex/1,     % Current goal block index.
	atBlock/1,           % Tracks blocks near the robot.
	holding/1,           % Tracks blocks held by the robot.
	gripperCapacity/1,   % Tracks robot's gripper capacity.
	block/3.             % Tracks seen blocks with ID, color, and location.

% Identify a room by its single neighbor.
room(PlaceID) :- zone(_, PlaceID, _, _, Neighbours), length(Neighbours, 1).

% Identify rooms not yet visited.
not_yet_visited(PlaceID) :- room(PlaceID), not(visited(PlaceID)).

% Store block information when seen in a room.
block(BlockID, ColorID, PlaceID) :- in(PlaceID), room(PlaceID), color(BlockID, ColorID).

% Determine the next required block color.
next_color_needed(ColorID) :-
    sequence(List),
    sequenceIndex(Index),
    nth0(Index, List, ColorID).
