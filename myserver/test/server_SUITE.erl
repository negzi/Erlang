-module(server_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0, groups/0, init_per_testcase/2, end_per_testcase/2]).
-export([test_salary_result/1, test1/1]).
-define(LOCALHOST, {127,0,0,1}).
-define(PORT, 1234).


all() ->
    [{group, server_test_cases}].

groups() ->
    [{server_test_cases, [], [test_salary_result, test1]}].

init_per_testcase(server_test_cases, Config) ->
    dbg:tracer(),
    dbg:p(all,[c]),
    dbg:tpl(gen_tcp,x),
    dbg:tpl(server,x),
    server:start(?PORT),
%    {ok, Csocket} = gen_tcp:connect(?LOCALHOST, ?PORT, [binary, {active,true}]),
    [{csocket,ok} | Config].
%% init_per_testcase(_, Config) ->
%%     Config.

end_per_testcase(server_test_cases, Config) ->
    dbg:tracer(),
    dbg:p(all,[c]),
    dbg:tpl(gen_tcp,x),
    dbg:tpl(server,x),
%    ok = gen_tcp:close(Lsocket),
    ok = gen_tcp:close(?config(csocket, Config)).


%% test_palindrome_result(Config) ->
%%     dbg:tracer(),
%%     dbg:p(all,[c]),
%%     dbg:tpl(gen_tcp,x),
%%     dbg:tpl(server,x),
%%     gen_tcp:send(?config(csocket, Config), "assignment_1 palindrome level").

test_salary_result(_Config) ->
    dbg:tracer(),
    dbg:p(all,[c]),
    dbg:tpl(gen_tcp,x),
    dbg:tpl(server,x),
    {ok, Csocket} = gen_tcp:connect(?LOCALHOST, ?PORT, [binary, {active,true}]),
    gen_tcp:send(?config(Csocket), 
		 "salary sorted_list /home/enegfaz/employee_info /home/enegfaz/salary_result"),
     true = filelib:is_regular("/home/enegfaz/salary_result").
    
test1(_Config) ->
    1 = 1.
