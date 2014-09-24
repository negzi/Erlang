-module(assignment_1_tests).
-include_lib("eunit/include/eunit.hrl").

math_sum_of_odds_test() ->
    ?assertEqual({4, 8}, assignment_1:math([1, 2, 3, 4])).

return_odds_test() ->
    ?assertEqual([1, 3], assignment_1:return_odds([1, 2, 3, 4])).

return_odds_with_other_types_test() ->
    ?assertEqual([1, 3], assignment_1:return_odds([1, 2, 3, 4, a])).

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

palindrome_empty_string_test() ->
    ?assertEqual([[]], assignment_1:palindrome([""])).

palindrome_one_string_test() ->
    ?assertEqual(["a"], assignment_1:palindrome(["a"])).

palindrome_mixed_strings_test() ->
    ?assertEqual(["a", "abba", "level", "dad dad"], assignment_1:palindrome(["a", "abba", "neg", "level", "dad dad"])).

palindrome_other_types__test() ->
    ?assertEqual(["a"], assignment_1:palindrome(["a", 1, abba, {abba}])).
    
no_palindrome_with_other_types_test() ->
    ?assertEqual([], assignment_1:palindrome([1, abba, {abba}])).
