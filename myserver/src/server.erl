-module(server).
-export([start/1]).
-compile(export_all).

-define(TCP_OPTIONS, [list, {packet, 0}, 
		      {active, false}, {reuseaddr, true}]).

start(Port) ->     
    {ok, ListenSocket} = gen_tcp:listen(Port, ?TCP_OPTIONS),
    accept(ListenSocket).

accept(ListenSocket) ->
    {ok, Socket} = gen_tcp:accept(ListenSocket),
    spawn(fun() ->
		  loop(Socket) end),
    accept(ListenSocket).

loop(Socket) ->
    dbg:tracer(),
    dbg:p(all,[c]),
    dbg:tpl(gen_tcp,x),
    dbg:tpl(server,x),
    case gen_tcp:recv(Socket, 0) of
        {ok, Data} ->
            io:format("Recieved: ~s~n", [Data]),
	    Result = execute_command(Data),
	    gen_tcp:send(Socket, Result),
	    gen_tcp:close(Socket),
	    loop(Socket);
	{error, closed} ->
            ok
    end.

execute_command(Data) ->
    case is_list(Data) of
	true ->
	    {ok, [Mod, Fun |Args]} = parse_command(Data), 
		func_specific_executaor(Fun , Mod, Args);
	false ->
	    {error, wrong_command_format}
    end.

parse_command(Data) ->
    Striped = Data--"\"\"\"",
    [Module, Function| Args] =  string:tokens(Striped, ",[]\n "),
    [Mod, Fun] = [list_to_atom(X) ||
		     X <- [Module, Function]],
    {ok, [Mod, Fun |Args]}.

func_specific_executaor(palindrome, Module, Args) ->
    Module:palindrome(Args);
func_specific_executaor(sorted_list, Module, Args) ->
    [Src_file, Res_file] = Args,
    Module:sorted_list(Src_file, Res_file);
func_specific_executaor(math, Module, Args) ->
    Arguments = [list_to_integer(X) || X <- Args],
    {A, B} = Module:math(Arguments),
    [A, B].
    
