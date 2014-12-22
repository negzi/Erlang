-module(hive).
-compile(export_all).

-record(state, {queen_id,
                hive_id,
		node_name}).
-define(TOPDIR, "/home/neg/Erlang/distributed_honeymaker").


start(File) ->
    register(?MODULE, Pid=spawn(?MODULE, init, [File])),
    Pid.

start_link() ->
    register(?MODULE, Pid=spawn_link(?MODULE, init, [])),
    Pid.

terminate() ->
    ?MODULE ! shutdown.

init(File) ->
    spawn(?MODULE, honey_maker_bee, [File]),
    loop(#state{queen_id= get_queen_id(),
		hive_id = get_hive_id(),
		node_name = get_hives_node()}).

loop(S = #state{}) ->
    receive
        {From, Ref, destroy} ->
	    Q = hive:get_queen_id(),
	    From ! {Ref, ok, S#state{queen_id = Q}},
	    loop(S);
	{From, Ref, shutdown}->
	    exit(hive, shutdown);
	{From, Ref, identify_your_self} ->
	    From ! {}
    end.


honey_maker_bee(File) ->
    honey_maker:generate_md5(File, node()).

communicator_bee() ->
    OtherNode= file_search:return_node_name(?TOPDIR),
    S = #state{},
    Ref = S#state.hive_id,
    MyNode =  S#state.node_name,
    {Ref, MyNode, OtherNode}.

get_hives_node() ->
    node().

get_hive_id() ->
    erlang:monitor(process, whereis(?MODULE)).

get_queen_id() ->    
    make_ref().
