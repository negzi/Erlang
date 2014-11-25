-module(assignment_1).
-export([math/1,  palindrome/1]).

math(List) when is_list(List) ->
     case all_integer(List) of 
 	true ->
 	    reutn_odd_even(List);
 	false ->
 	    {error, "wrong input"}
     end;
math(List) ->
    {error, "input has to be list"}.     


all_integer(List) ->
    lists:all(fun(X) -> is_integer(X) end,List).

reutn_odd_even(List) ->
    {Odds, Evens} = lists:partition(fun(X) -> X rem 2 =:= 1 end, 
				    List),
    {sum(Odds), product(Evens)}.

sum(Odds) ->
    lists:sum(Odds).

product(Evens) ->
    lists:foldl(fun(X, Acc) -> Acc*X end,
		1,
		Evens).


palindrome(List) ->
    palindrome(List, []).

palindrome([], Acc) ->
    lists:reverse(Acc);
palindrome([H|T], Acc) when is_list(H) ->
    case lists:reverse(H) =:= H of
	true ->
	    palindrome(T, [H|Acc]);
	false ->
	    palindrome(T, Acc)
    end;
palindrome(_,_) ->
    {error, "wrong input"}.

