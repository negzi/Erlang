-module(assignment_1).
-export([math/1, return_odds/1]).

math(List) ->
	Odds = return_odds(List),
	{lists:sum(Odds)}.
	
return_odds(List) ->
	[Odd || Odd <-List, Odd rem 2 =/= 0].

