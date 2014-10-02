-module(salary).
-export([read_lines/1, fill_employee_info/6,
	 record_of_all_employees/1, map/1,
	 compare_performance/2, sort_employees/1, calculate_compa_ratio/2]).

-record(employee, {no,
                  name,
                  salary,
                  level,
                  basesalary,
                  performance}).


sort_employees(File) ->
    Employees = record_of_all_employees(File),
    
    lists:sort(fun(A, B) -> compare_performance(A, B) end , Employees).

calculate_compa_ratio(A, B) ->
    (string:to_integer(A#employee.salary) * 100) / 
	string:to_integer(A#employee.basesalary) > 
	(string:to_integer(B#employee.salary) * 100) / 
	string:to_integer(B#employee.basesalary).


compare_performance(A, B) ->
    map(A#employee.performance) >  map(B#employee.performance).
	     

map(Performance) ->
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
    [fill_employee_info(No, Name, Salary, Level,
			Basesalary, Performance) || [No, Name, Salary, Level, 
						     Basesalary, Performance]
							<-Lines].

fill_employee_info(No, Name, Salary, Level, Basesalary, Performance) ->
    #employee{no=No, name=Name, salary=Salary, 
	      level=Level, basesalary=Basesalary, 
	      performance=Performance}.


read_lines(FileName) ->    
    case file:read_file(FileName) of
	{ok, Data} ->
	    Lines = string:tokens(binary:bin_to_list(Data), "\n"),
	    [string:tokens(X, " ") || X <- Lines];
	{error,Reason} ->
	    {error,Reason}
    end.


