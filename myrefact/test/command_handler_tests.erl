-module(command_handler_tests).
-include_lib("eunit/include/eunit.hrl").

math_command_test() ->
    [Mod, Fun |Args] = [assignment_1, math, "1", "2", "3","4"],
    ?assertEqual({4, 8}, 
		 command_handler:command_matcher(Fun , Mod, Args)).

math_command_invalid_data_test() ->
    [Mod, Fun |Args] = [assignment_1, math, "1", "2", "3","a"],
    ?assertEqual("error", 
		 command_handler:command_matcher(Fun , Mod, Args)).

palindrome_command_test() ->
    [Mod, Fun |Args] = [assignment_1, palindrome, "level"],
    ?assertEqual(["level"], 
		 command_handler:command_matcher(Fun , Mod, Args)).

invalid_function_name_test() ->
    [Mod, Fun |Args] =  [assignment_1, math1, "1", "2", "3","4"],
    ?assertEqual({error, "Undefined_module_or_function"},
		 command_handler:command_matcher(Fun , Mod, Args)).

history_command_test() ->
    Message = "hej",
    Socket = 1234,
    command_handler:collect_history(Message, Socket),
    ?assertEqual(["hej"], 
		 command_handler:return_history(Socket)).

main_interface_history_test() ->
    Data = history,
    Socket = 1234,
    command_handler:collect_history("history", Socket),
    [Mod, Fun |Args] = [Data, Socket, "whateverdata"],
    ?assertEqual(["history", "hej"],
		 command_handler:exec(Mod, ok, Args, Socket)).
