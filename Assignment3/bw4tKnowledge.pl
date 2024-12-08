% declarations of predicates used but not defined here.
:- dynamic
	in/1,		% percept predicate that informs where the robot is. 
	state/1,	% percept predicate to keep track of whether a robot is moving.
	visited/1,	% predicate to keep track of the rooms that have been visited.
	zone/5,		% percept predicate with information about all zones in BW4T.
	color/2,	% provides information about the color of blocks. 
	sequence/1,	% provides initial information about goal sequence of blocks.
	sequenceIndex/1,% keeps track of current needed color in sequence. 
	atBlock/1,	% indicates that the robot is within reach of a block. 
	holding/1,% keeps track of current held blocks by robot.
	gripperCapacity/1,	% current gripper capacity.
	block/3. 
	atBlock/1.
	
% A room is a place with exactly one neighbour; in other words, there is only one way to
% get to and from that place.
room(PlaceID) :- zone(_, PlaceID, _, _, Neighbours), length(Neighbours, 1).

% A room has not yet been visited if the robot has not yet been there.
not_yet_visited(PlaceID) :- room(PlaceID), not( visited(PlaceID) ).

% rule for storing block information if seen in a room. 
block(BlockID, ColorID, PlaceID) :- in(PlaceID), room(PlaceID), color(BlockID, ColorID).

% Added next_color_needed/1 to determine the next required block color.
next_color_needed(ColorID) :-
    sequence(List),
    sequenceIndex(Index),
    nth0(Index, List, ColorID).
