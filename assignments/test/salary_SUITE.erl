-module(salary_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0, groups/0, init_per_testcase/2, end_per_testcase/2]).
-export([test_sorted_result/1,test_read_file/1]).
-define(SOURCE, "employee").
-define(DEST, "Sorted_employees").

all() ->
    [{group, file_test_cases}].

groups() ->
     [{file_test_cases, [], [test_sorted_result, test_read_file]}].

init_per_testcase(file_test_cases, Config) ->
    Data = [["No","Name","Salary","Level","BaseSalary","Performance"],
	    ["2","albert","21161","4","15000","Bad"],
	    ["3","becka","21161","4","15000","Good"],
	    ["4","emilio","21562","6","25000","Excellent"]],
    {ok, FD} =  file:open(?SOURCE, [read, write]),
    List = [io_lib:fwrite("~s ~s ~s ~s ~s ~s ~n", Line) || Line <- Data],
    file:write(FD, List),   
    case file:read_file(?DEST) of
	{ok, Res} ->
	    file:delete(?DEST);
	{error,_} ->
	    ok		  
    end,
    [{employee,FD}  | Config];
init_per_testcase(_, Config) ->
    Config.


end_per_testcase(file_test_cases, Config) ->
    ok = file:close(?config(employee, Config)), 
    ok = file:delete(?SOURCE);
end_per_testcase(_, _Config) ->
    ok.


test_read_file(_Config) ->
    Data = [["No","Name","Salary","Level","BaseSalary","Performance"],
	    ["2","albert","21161","4","15000","Bad"],
	    ["3","becka","21161","4","15000","Good"],
	    ["4","emilio","21562","6","25000","Excellent"]],    
    Data == salary:read_lines(?SOURCE).

test_sorted_result(_Config) ->
    Sorted = [["4","emilio","21562","6","25000","Excellent"],
	      ["3","becka","21161","4","15000","Good"],
	      ["2","albert","21161","4","15000","Bad"]],
    %% Sorted == %% salary:sorted_list(?SOURCE
    1 = Sorted.
