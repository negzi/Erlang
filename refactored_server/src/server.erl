-module(server).
-export([start_server/1]).
-compile(export_all).
-define(TCP_OPTIONS, [list, {packet, 0},
		      {active, false}, {reuseaddr, true}]).

start_server(Port) ->
    {ok, ListenSocket} = gen_tcp:listen(Port, ?TCP_OPTIONS),
    accept_tcp_connection(ListenSocket).

accept_tcp_connection(ListenSocket) ->
    {ok, Socket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> handle_messages(Socket) end),
    accept_tcp_connection(ListenSocket).

handle_messages(Socket) ->
    case gen_tcp:recv(Socket, 0) of
	{ok, Data} ->
	    command_handler:collect_history(Data, Socket),
	    {ok,[Mod, Fun |Args]} = parser:parse(Data),
	    Res = command_handler:exec(Mod, Fun, Args, Socket),
	    gen_tcp:send(Socket, Res),
	    handle_messages(Socket);
	{error, closed} ->
	    ok
    end.
