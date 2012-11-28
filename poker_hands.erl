-module(poker_hands).
-export([category/1, card/1, rank/1, hand/1, highcard/1, flush/1, straight/1, straight_flush/1, n_of_a_kind/2, rank_frequencies/1]).

string_to_suit($H) -> h;
string_to_suit($D) -> d;
string_to_suit($C) -> c;
string_to_suit($S) -> s.

string_to_rank(N) ->
	string:str("123456789TJQKA",[N]).

card([X,Y]) -> {string_to_rank(X),string_to_suit(Y)}.

rank({X,_}) -> X.

hand([X,Y]) -> [card([X,Y])];
hand([X,Y,32|R]) ->
	[card([X,Y])] ++ hand(R).

% [{2, h}, {3, s}, {4, s}, {5, s}]
highcard(L) ->
	lists:max(lists:map(fun rank/1, L)).	

flush([{_,S},{_,S},{_,S},{_,S},{_,S}]) -> true;
flush(_) -> false.

straight_sorted([{R1,_}, {R2,_}]) -> R2 - R1 =:= 1;
straight_sorted([{R1,_}, {R2,_} = C|Xs]) when R2 - R1 =:= 1 ->
	straight_sorted([C|Xs]);
straight_sorted(_) -> false.

straight(L) ->
	straight_sorted(lists:sort(L)).

straight_flush(L) ->
	straight(L) and flush(L).

n_of_a_kind(N, H) ->
	true.

% lists:sublist(L,2) ++ [lists:nth(3,L)*100] ++ lists:nthtail(3,L).
rank_frequencies(H) ->
	Frequencies = [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	lists:foldl(fun(C, F) ->
		I = rank(C) - 1,
		lists:sublist(F,I) ++ [lists:nth(I+1,F)] ++ lists:nthtail(I+1,F)
	end, Frequencies, H).

category(H) ->
	case straight_flush(H) of
		true -> 8;
		false -> case flush(H) of 
			true -> 5;
			false -> case straight(H) of 
				true -> 4;
				false -> 0
			end
		end
	end.	

