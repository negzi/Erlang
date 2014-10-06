-module(fixture).
-include_lib("eunit/include/eunit.hrl").

my_test_() ->
    {setup,
     fun start/0,
     fun stop/1,
     fun instant/0
    }.

start() ->
    {ok, FD} =  file:open("/home/enegfaz/employee", [read, write]),
    FD.

stop(FD) ->
    ok = file:close(FD),
    ok =  file:delete("/home/enegfaz/employee").

instant() ->
    File = "/home/enegfaz/employee",
    ?assertEqual([["No","Name","Salary","Level","BaseSalary","Performance"],
		  ["2","albert","21161","4","15000","Bad"],
		  ["3","becka","21161","4","15000","Good"],
		  ["4","emilio","21562","6","25000","Excellent"]],
		 salary:read_lines(File)).


    
