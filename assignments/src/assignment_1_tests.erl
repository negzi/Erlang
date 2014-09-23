-module(assignment_1_tests).
-include_lib("eunit/include/eunit.hrl").

math_sum_of_odds_test() ->
	?assertEqual({4, 8}, assignment_1:math([1, 2, 3, 4])).
	
return_odds_test() ->
	?assertEqual([1, 3], assignment_1:return_odds([1, 2, 3, 4])).

return_evens_test() ->
        ?assertEqual([2, 4], assignment_1:return_evens([1, 2, 3, 4])).

product_test() ->
	 ?assertEqual(24, assignment_1:prod([1, 2, 3, 4])).

product_empty_list_test() ->
         ?assertEqual(0, assignment_1:prod([])).

product_single_list_test() ->
         ?assertEqual(2, assignment_1:prod([2])).

product_list_with_ziro_test() ->
         ?assertEqual(0, assignment_1:prod([2, 0, 1, 3])).
