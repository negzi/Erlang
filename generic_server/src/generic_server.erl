-module(generic_server).
-compile(export_all).
-export([init/1, handle_call/3, terminate/2, handle_info/2]).
-behaviour(gen_server).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

handle_command(Pid, Command) ->
    gen_server:call(Pid, Command).

terminate_cli(Pid) ->
    gen_server:call(Pid, terminate).


%%% Server callback funcs
init([]) ->
    {ok, []}.

handle_call(terminate, _From, []) ->
    {stop, normal, ok, []};
handle_call({command, Command}, _From, []) ->
    {ok,[Mod, Fun |Args]} = parser:parse(Command),
    Res = command_handler:exec(Mod, Fun, Args, _From),
    {reply, Res, []}.

terminate(normal, []) ->
    ok.

handle_info(Msg, Cats) ->
    io:format("Unexpected message: ~p~n",[Msg]),
    {noreply, Cats}.
