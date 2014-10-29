-module(server).
-export([start/1]).
-compile(export_all).

-define(TCP_OPTIONS, [list, {packet, 0}, 
		      {active, false}, {reuseaddr, true}]).
-define(ERROR, {error, wrong_command_format}).
-define(UNDEFCOMMAND, {error,command_does_not_exist}).

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
    Res = case verify_input(Data) of
	      true ->
		  Result = execute_command(Data),
		  [Result];
	      {error, Reason} ->
		  format(Reason)
	  end,
    send(Socket,Res).

send(Soc, Res) ->
    gen_tcp:send(Soc, Res),
    loop(Soc).

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
    case module_is_defined(Mod) of
	true ->
	    func_specific_executaor(Fun , Mod, Args);
	 false ->
	    format(?UNDEFCOMMAND)
    end.

module_is_defined(assignment_1) ->
    true;
module_is_defined(salary) ->
    true;
module_is_defined(_) ->
    false.

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
    end;
func_specific_executaor(_, _, _) ->
    format(?UNDEFCOMMAND).

format(Data) ->
    io_lib:format("~w", [Data]).

are_none_integers(Args) ->
    List = [io_lib:fread("~d", X) || X <- Args],
    proplists:is_defined(error, List).
    
