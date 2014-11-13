-module(parse_tests).
-include_lib("eunit/include/eunit.hrl").

parse_palindrome_data_test() ->
    Data = "assignment_1 palindrome negar",
    ?assertEqual({ok, [assignment_1, palindrome, "negar"]},
		 parse:parse(Data)).


parse_palindrome_data_tcp_format_test() ->
    Data = "\"assignment_1 palindrome ses\"\n",
    ?assertEqual({ok, [assignment_1, palindrome, "ses"]},
		 parse:parse(Data)).

parse_salary_command_input_test() ->
    Data =
	"salary sorted_list /home/enegfaz/employee_info /home/enegfaz/sortedf",
    ?assertEqual({ok, [salary, sorted_list, 
		       "/home/enegfaz/employee_info",
		       "/home/enegfaz/sortedf"]},
		 parse:parse(Data)).

parse_math_data_tcp_format_test() ->
    Data = "\"assignment_1 math 1 2 3 4\"\n",
    ?assertEqual({ok, [assignment_1, math, "1", "2", "3","4"]},
		 parse:parse(Data)).


parse_irrelevant_data_test() ->
    Data = "1 2 3",
    ?assertEqual({ok,[invalid,data,"entered"]},
		 parse:parse(Data)).


parse_non_relevant_data_test() ->
    Data = "1",
    ?assertEqual({ok, [invalid, data, "entered"]},
		 parse:parse(Data)).


parse_non_relevant_data2_test() ->
    Data = "*",
    ?assertEqual({ok, [invalid, data, "entered"]},
		 parse:parse(Data)).


parse_history_test() ->
    Data = "history",
    ?assertEqual({ok, [history, invalid, "data", "entered"]},
		 parse:parse(Data)).
