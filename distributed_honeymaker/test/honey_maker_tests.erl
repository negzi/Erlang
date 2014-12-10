-module(honey_maker_tests).
-include_lib("eunit/include/eunit.hrl").

create_md5_test() ->
    File = "/home/enegfaz/learnings/erlang_assignments/Erlang/Erlang/distributed_honeymaker/myfile",
    Hash = "3b8d2ee0a5172e97c05952c5eb3154d1",
    ?assertEqual({ok, Hash}, honey_maker:open(File)).

