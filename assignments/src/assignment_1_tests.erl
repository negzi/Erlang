-module(assignment_1_tests).
-include_lib("eunit/include/eunit.hrl").

math_sum_of_odds_test() ->
	?assertEqual({4}, assignment_1:math([1, 2, 3, 4])).
	
return_odds_test() ->
	?assertEqual([1, 3], assignment_1:return_odds([1, 2, 3, 4])).
