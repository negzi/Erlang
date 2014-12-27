-module(distributed_honeymaker_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    hive:start_hive("myfile").

stop(_State) ->
    ok.
