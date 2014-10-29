-module(server_tests).
-include_lib("eunit/include/eunit.hrl").

parse_palindrome_data_test() ->
    Data = "assignment_1 palindrome negar",
    ?assertEqual({ok, [assignment_1, palindrome, "negar"]},
		 server:parse_command(Data)).

parse_tcp_rcv_data_test() ->
    Data = "\"assignment_1 palindrome ses\"\n",
    ?assertEqual({ok, [assignment_1, palindrome, "ses"]},
		 server:parse_command(Data)).

palindrome_command_test() ->
    Data = "assignment_1 palindrome ses",
    ?assertEqual(["ses"], server:execute_command(Data)).

salary_command_test() ->
    Data = 
	"salary sorted_list /home/enegfaz/employee_info /home/enegfaz/sortedf",
    ?assertEqual([[91,["ok",44,"ok",44,"ok"],93]], 
		 server:execute_command(Data)).

math_command_test() ->
    Data = "assignment_1 math 1 2 3 4",
    ?assertEqual([[123,["4",44,"8"],125]], server:execute_command(Data)).


math2_command_test() ->
    Data = "assignment_1 math 1 2 3 a",
    ?assertEqual([[123,["error",44,"wrong_command_format"],125]],
		 server:execute_command(Data)).

wrong_format_test() ->
    Data = 1,
    ?assertEqual({error, wrong_command_format},
		 server:verify_input(Data)).

unknown_module_test() ->
    Data = "assignment math 1 2 3 4",
    ?assertEqual([[123,["error",44,"command_does_not_exist"],125]], 
       server:execute_command(Data)).
