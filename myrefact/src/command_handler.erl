-module(command_handler).
-compile(export_all).

exec(history,_, _, Socket) ->
    return_history(Socket);
exec(Mod, Fun, Args, _) ->
    command_matcher(Fun, Mod, Args).

command_matcher(palindrome, Mod, Args) ->
    Mod:palindrome(Args);
command_matcher(sorted_list,Mod, Args) ->
    [Src_file, Res_file] = Args,
    Mod:sorted_list(Src_file, Res_file);
command_matcher(math, Mod, Args) ->
    case are_none_integers(Args) of
	true ->
	    "error";
	false ->
	    Arguments = [list_to_integer(X) || X <- Args],
	    Mod:math(Arguments)
    end;
command_matcher(_, _, _) ->
    {error, "Undefined_module_or_function"}.

are_none_integers(Args) ->
    List = [io_lib:fread("~d", X) || X <- Args],
    proplists:is_defined(error, List).

collect_history(Msg, Socket) ->
    P = return_history(Socket),
    Data = [Msg|P],
    put(Socket, Data ).

return_history(Socket) ->
    case get(Socket) of
        undefined ->
            [];
	History ->
            History
    end.
    
