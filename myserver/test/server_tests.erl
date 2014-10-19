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
    Data = "salary sorted_list /home/neg/em_file /home/neg/sortedf",
        ?assertEqual([ok,ok,ok], server:execute_command(Data)).

math_command_test() ->
    Data = "assignment_1 math [1 2 3 4]",
    ?assertEqual({4, 8}, server:execute_command(Data)).

wrong_format_test() ->
    Data = 1,
    ?assertEqual({error, wrong_command_format},
		 server:execute_command(Data)).

    
%% wrong_format2_test() ->
%%     dbg:tracer(),
%%     dbg:p(all, [c]),
%%     dbg:tpl(server, x),
%%     Data = [1],
%%     ?assertEqual({error, wrong_command_format},
%%                  server:execute_command(Data)).
