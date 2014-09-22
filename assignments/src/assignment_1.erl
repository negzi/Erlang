-module(assignment_1).
-export([math/1, return_odds/1, return_evens/1]).

math(List) ->
	Odds = return_odds(List),
	{lists:sum(Odds)}.
	
return_odds(List) ->
	[Odd || Odd <-List, Odd rem 2 =/= 0].

return_evens(List) ->
	[Even || Even <-List, Even rem 2 =:= 0].
