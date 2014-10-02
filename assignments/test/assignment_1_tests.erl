
-module(assignment_1_tests).
-include_lib("eunit/include/eunit.hrl").

math_test() ->
    ?assertEqual({4, 8}, assignment_1:math([1, 2, 3, 4])).


math_list_of_different_types_test() ->
    ?assertEqual({error, "wrong input"}, assignment_1:math([1, {2}, "b", a])).


math_different_types_test() ->
    ?assertEqual({error, "input has to be list"},
		  assignment_1:math({2})).


palindrome_empty_string_test() ->
    ?assertEqual([[]], assignment_1:palindrome([""])).


palindrome_one_string_test() ->
    ?assertEqual(["a"], assignment_1:palindrome(["a"])).


palindrome_mixed_strings_test() ->
    ?assertEqual(["a", "abba", "level", "dad dad"], 
		 assignment_1:palindrome(["a", "abba",
					  "neg", "level", "dad dad"])).


palindrome_other_types_test() ->
    ?assertEqual({error, "wrong input"},
		 assignment_1:palindrome(a)).


no_palindrome_with_other_types_test() ->
    ?assertEqual( {error, "wrong input"},
		  assignment_1:palindrome([1, abba, {abba}])).
