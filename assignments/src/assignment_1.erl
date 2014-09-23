-module(assignment_1).
-export([math/1, return_odds/1, return_evens/1,  prod/1]).

math(List) ->
	Odds = return_odds(List),
	Evens = return_evens(List),
	{lists:sum(Odds), prod(Evens)}.
	
return_odds(List) ->
	[Odd || Odd <-List, Odd rem 2 =/= 0].

return_evens(List) ->
        [Evens || Evens <-List, Evens rem 2 =:= 0].

prod([]) -> 0;
prod([Head]) -> Head;
prod([Head|T]) -> Head * prod(T).
