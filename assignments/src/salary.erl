-module(salary).
-export([read_lines/1, fill_employee_info/6,
	 record_of_all_employees/1, performance_map_to_number/1,
	 compare_performance/2]).

-record(employee, {no,
                  name,
                  salary,
                  level,
                  basesalary,
                  performance}).


%% sort_employees(File) ->
%%     Employees = record_of_all_employees(File),
%%     F = fun(X, Y) -> {performance(X#employee.performance)} > 
%% 			 compare_performance({Y#employee.performance}) end,
%%     lists:sort(F ,  Employees).


compare_performance(A, B) ->
    A#employee.performance >  B#employee.performance.
    
performance_map_to_number(Performance) ->
    case Performance of
    	"Excellent" ->
    	    3;
    	"Good" ->
    	    2;
    	"Bad" ->
    	    1
    end.


record_of_all_employees(FileName) ->
    Lines = lists:nthtail(1, read_lines(FileName)),
    [salary:fill_employee_info(No, Name, Salary, Level,
			       Basesalary, Performance) || [No, Name, Salary, Level, 
							    Basesalary, Performance]
							       <-Lines].

fill_employee_info(No, Name, Salary, Level, Basesalary, Performance) ->
    #employee{no=No, name=Name, salary=Salary, 
	      level=Level, basesalary=Basesalary, 
	      performance=Performance}.


read_lines(FileName) ->    
    case file:open(FileName, [read]) of
	{ok, Data} ->
	    Lines = get_lines(Data, []),
	    Strip_List = [string:strip(X, right, $\n) || X <- Lines],
	    [string:tokens(X, "! ") || X <- Strip_List];
	{error,Reason} ->
	    {error,Reason}
    end.

get_lines(Data, Acc) ->    
    case io:get_line(Data, "") of
        eof  ->
	    file:close(Data),
	    Acc;
	Line ->
	    get_lines(Data, Acc ++ [Line])
    end.	      
