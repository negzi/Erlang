-module(server_tests).
-include_lib("eunit/include/eunit.hrl").

parse_palindrome_data_test() ->
    Data = "assignment_1 palindrome negar",
    ?assertEqual(["assignment_1", "palindrome", "negar"],
		 server:parse_command(Data)).

%% %% parse_math_data_test() ->
%% %%     Data = "assignment_1 math 1, 2, 3",
%% %%         ?assertEqual(["assignment_1", "math", [1, 2, 3]],
%% %%                  server:parse_command(Data)).


palindrome_command_test() ->
    Data = "assignment_1 palindrome ses",
    ?assertEqual(["ses"], server:execute_command(Data)).

salary_command_test() ->
    Data = "salary sorted_list /home/neg/em_file /home/neg/sortedf",
        ?assertEqual([ok,ok,ok], server:execute_command(Data)).
