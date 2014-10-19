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
    case gen_tcp:recv(Socket, 0) of
        {ok, Data} ->    
            io:format("Recieved: ~s~n", [Data]),
	    gen_tcp:send(Socket, [Data]),
	    loop(Socket);
	        {error, closed} ->
            ok
    end.

execute_command(Data) ->
    [Module, Function| Args] = parse_command(Data),
    Mod = list_to_atom(Module),
    Fun =list_to_atom(Function),
    func_specific_executaor(Fun , Mod, Args).
    %Mod:Fun(Args).
        
parse_command(Data) ->
    string:tokens(Data, " ").

func_specific_executaor(palindrome, Module, Args) ->
    Module:palindrome(Args);
func_specific_executaor(sorted_list, Module, Args) ->
    [Src_file, Res_file] = Args,
    Module:sorted_list(Src_file, Res_file).




%func_specific_executaor() ->

    
