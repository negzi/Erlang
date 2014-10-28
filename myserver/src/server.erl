-module(server).
-export([start/1]).
-compile(export_all).

-define(TCP_OPTIONS, [list, {packet, 0}, 
		      {active, false}, {reuseaddr, true}]).
-define(ERROR, {error, wrong_command_format}).

start(Port) ->     
    {ok, ListenSocket} = gen_tcp:listen(Port, ?TCP_OPTIONS),
    accept(ListenSocket).

accept(ListenSocket) ->
    {ok, Socket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> loop(Socket) end),
    accept(ListenSocket).

loop(Socket) ->
    case gen_tcp:recv(Socket, 0) of
        {ok, Data} ->
	    verify_and_send(Data, Socket);
	{error, closed} ->
	    ok
    end.

verify_and_send(Data, Socket) ->
    case verify_input(Data) of
	true ->
	    Result = execute_command(Data),		   
	    gen_tcp:send(Socket, [Result]),
	    loop(Socket);
	{error, Reason} ->
	    gen_tcp:send(Socket, format(Reason)),
	    loop(Socket)
    end.

verify_input(Data) ->
    case is_list(Data) of
	true -> 
	    case string:words(Data) >= 3 of
		true ->
		    true;
	    false ->
		    ?ERROR
	    end;
	false ->
	    ?ERROR
    end.


execute_command(Data) ->
    {ok, [Mod, Fun |Args]} = parse_command(Data), 
    func_specific_executaor(Fun , Mod, Args).

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
    Res = Module:sorted_list(Src_file, Res_file),
    format(Res);
func_specific_executaor(math, Module, Args) ->
    case are_none_integers(Args) of
	true ->
	    format(?ERROR);
	false ->
	    Arguments = [list_to_integer(X) || X <- Args],
	    Res = Module:math(Arguments),
	    format(Res)
    end.

format(Data) ->
    io_lib:format("~w", [Data]).

are_none_integers(Args) ->
    List = [io_lib:fread("~d", X) || X <- Args],
    proplists:is_defined(error, List).
    
