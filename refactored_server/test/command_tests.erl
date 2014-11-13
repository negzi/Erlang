-module(command_tests).
-include_lib("eunit/include/eunit.hrl").

math_command_test() ->
    Data = "assignment_1 math 1 2 3 4",
    {ok, [Mod, Fun |Args]} = parse:parse(Data),
    ?assertEqual({4, 8}, 
		 command_exec:command_matcher(Fun , Mod, Args)).

math_command_invalid_data_test() ->
    Data = "assignment_1 math 1 2 3 a",
    {ok, [Mod, Fun |Args]} = parse:parse(Data),
    ?assertEqual("error", 
		 command_exec:command_matcher(Fun , Mod, Args)).

palindrome_command_test() ->
    Data = "assignment_1 palindrome level neg",
    {ok, [Mod, Fun |Args]} = parse:parse(Data),
    ?assertEqual(["level"], 
		 command_exec:command_matcher(Fun , Mod, Args)).

invalid_module_name_test() ->
    Data = "invalid math 1 2 3 4",
    {ok, [Mod, Fun |Args]} = parse:parse(Data),
    ?assertEqual({error, "Undefined_module_or_function"},
		 command_exec:command_matcher(Fun , Mod, Args)).

history_command_test() ->
    Message = "hej",
    Socket = 1234,
    command_exec:collect_history(Message, Socket),
	?assertEqual(["hej", "history"], 
		 command_exec:return_history(Socket)).

main_interface_history_test() ->
    Data = "history",
    Socket = 1234,
    command_exec:collect_history(Data, Socket),
    {ok, [Mod, Fun |Args]} = parse:parse(Data),
        ?assertEqual(["history"],
		 command_exec:exec_command(Mod, Fun, Args, Socket)).
