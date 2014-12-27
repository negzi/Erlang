-module(hive).
-compile(export_all).

-record(state, {queen_id,
                hive_id,
		node_name}).
-define(TOPDIR, "/home/neg/Erlang/distributed_honeymaker").


start_hive(File) ->
    register(?MODULE, Pid=spawn(?MODULE, init, [File])),
    {ok, Pid}.

start_link() ->
    register(?MODULE, Pid=spawn_link(?MODULE, init, [])),
    {ok, Pid}.

terminate() ->
    ?MODULE ! {shutdown}.

init(File) ->
    spawn(?MODULE, honey_maker_bee, [File]),
    loop(#state{queen_id= get_queen_id(),
		hive_id = get_hive_id(),
		node_name = get_hives_node()}).

loop(S = #state{}) ->
    receive
        {From, identify_your_self} ->
	    From ! {?MODULE,S},
	    loop(S);
	{shutdown}->
	    exit(?MODULE, kill)
    end.

identify_your_self(From) ->
    ?MODULE ! {From, identify_your_self}.

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
