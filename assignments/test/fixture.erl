-module(fixture).
-include_lib("eunit/include/eunit.hrl").

my_test_() ->
    {%setup,
      foreach,
      fun start/0,
      fun stop/1,
      [fun instant/0,
       fun result_file_exist/0]}.

start() ->
    Data = [["No","Name","Salary","Level","BaseSalary","Performance"],
	    ["2","albert","21161","4","15000","Bad"],
	    ["3","becka","21161","4","15000","Good"],
	    ["4","emilio","21562","6","25000","Excellent"]],
    {ok, FD} =  file:open("employee", [read, write]),
    List = [io_lib:fwrite("~s ~s ~s ~s ~s ~s ~n", Line) || Line <- Data],
    file:write(FD, List),   
    case file:read_file("Sorted_employees") of
	{ok, Res} ->
	    file:delete("Sorted_employees");
	{error,_} ->
	    ok		  
    end,
    FD.

stop(FD) ->
    ok = file:close(FD),
    ok =  file:delete("employee").

instant() ->
    File = "employee",
    Data = [["No","Name","Salary","Level","BaseSalary","Performance"],
	    ["2","albert","21161","4","15000","Bad"],
	    ["3","becka","21161","4","15000","Good"],
	    ["4","emilio","21562","6","25000","Excellent"]],    
    ?assertEqual(Data,
		 salary:read_lines(File)).


result_file_exist() ->
    File = "employee",
    Dest = "Sorted_employees",
    salary:sorted_list(File, Dest),
    ?assertMatch({ok, _}, file:read_file(Dest)).
