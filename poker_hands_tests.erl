-module(poker_hands_tests).
-include_lib("eunit/include/eunit.hrl").
-import(poker_hands, [category/1, card/1, rank/1, hand/1, highcard/1, flush/1, straight/1, straight_flush/1, n_of_a_kind/2, rank_frequencies/1]).

card_test() ->
	?assertEqual({3, h}, card("3H")),
	?assertEqual({2, h}, card("2H")),
	?assertEqual({13, h}, card("KH")).

rank_test() ->
	?assertEqual(2, rank({2, h})),
	?assertEqual(3, rank({3, h})).

hand_test() ->
	?assertEqual([{3, h}, {2, s}, {13, h}], hand("3H 2S KH")).

highcard_test() ->
	% ace is high
	?assertEqual(14, highcard(hand("2H 3S 4D 5C AH"))), 
	?assertEqual(10, highcard(hand("2H 3S 4D 5C TH"))),
	?assertEqual(13, highcard(hand("2H 3S 4D KH 5C"))).	

flush_test() ->
	?assertEqual(true, flush(hand("2H 3H 6H 8H JH"))),
	?assertEqual(false, flush(hand("2H 3C 6H 8H AC"))).

straight_test() ->
	?assertEqual(true, straight(hand("2H 3H 4H 5H 6H"))),
	?assertEqual(false, straight(hand("2H 3H 8H 5H 6H"))).

straight_flush_test() ->
	?assertEqual(true, straight_flush(hand("2H 3H 4H 5H 6H"))),
	?assertEqual(false, straight_flush(hand("2H 3H 6S 5H 6H"))),
	?assertEqual(false, straight_flush(hand("2H 3H 4D 5H 6H"))).

% 0: high card
% 1: pair
% 2: 2 pair
% 3: 3 of a kind
% 4: straight
% 5: flush
% 6: full house
% 7: 4 of a kind
% 8: straight flush
hand_category_test() ->
	?assertEqual(0, category(hand("2H 4D 6S 8C TD"))),
	?assertEqual(8, category(hand("2H 3H 4H 5H 6H"))),
	?assertEqual(5, category(hand("2H 3H 4H 5H 8H"))),
	?assertEqual(4, category(hand("2H 3D 4H 5H 6H"))).

% n_of_a_kind_test() ->
	% ?assertEqual(true, n_of_a_kind(2, hand("2H 2D 3H 4S 8C"))),
	% ?assertEqual(false, n_of_a_kind(2, hand("AH 2D 3H 4S 8C"))).

rank_frequencies_test() ->
	?assertEqual([1,0,1,0,1,0,1,0,1,0,0,0,0],
		rank_frequencies(hand("2H 4D 6S 8C TD"))),
	?assertEqual([0,1,0,1,0,1,0,1,1,0,0,0,0],
		rank_frequencies(hand("3H 5D 7S 9C TD"))).

% what_the_if_test() ->
% 	if 1 =:= 1 ->
% 		works
% 	end,
% 	if 1 =:= 2; 1 =:= 1 ->
% 		works
% 	end,	
% 	if 1 =:= 2, 1 =:= 1 ->
% 		fails
% 	end.