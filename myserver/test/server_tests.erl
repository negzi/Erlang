-module(server_tests).
-include_lib("eunit/include/eunit.hrl").

check_server_connection_test() ->
    dbg:tracer(),
    dbg:p(all,[c]),
    dbg:tpl(gen_tcp,x),
    dbg:tpl(server,x),
    Port = 8082,
    Localhost = {127,0,0,1},
    {ok, Pid} = server:listen_socket(Port),
    io:format(user,"~p", [Pid]),
    ?assertMatch({ok, _},
		 gen_tcp:connect(Localhost,
				 Port, 
				 [binary, {active,true}])).
