-module(generic_server_tests).
-include_lib("eunit/include/eunit.hrl").

start_link_test() ->
    ?assertMatch({ok, _}, generic_server:start_link()).

handle_command_terminate_test() ->
    {ok, Pid} = generic_server:start_link(),
    ?assertMatch(ok, 
		 generic_server:terminate_cli(Pid)).


handle_palindrome_command_test() ->
    {ok, Pid} = generic_server:start_link(),
    Command = {command, "assignment_1 palindrome negar"},
    ?assertMatch([], generic_server:handle_command(Pid, Command)).


