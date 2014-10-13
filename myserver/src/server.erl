-module(server).
%-compile(export_all).
-export([listen_socket/1]).

listen_socket(Port) ->
    {ok, ListenSocket} = gen_tcp:listen(Port, [{active,true}, binary]),
    Pid = spawn(fun() -> acceptor(ListenSocket) end),
    {ok, Pid}.
%    {ok, AcceptSocket} = gen_tcp:accept(ListenSocket).

acceptor(ListenSocket) ->
    case gen_tcp:accept(ListenSocket) of
	{ok, Socket} ->
	    ok;
	{error, Res} ->
	    {error, Res} 
    end.
