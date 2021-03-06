-module(salary).
-compile([debug_info, export_all]).
-record(employee, {no,
                  name,
                  salary,
                  level,
                  basesalary,
                  performance}).

sorted_list(Source_File, Dest_File) ->    
    Sorted_records = sort_employees(Source_File),
    List = [record_value(Rec) || Rec <- Sorted_records],
    [write_to_file(Dest_File, L) || L <-List].

write_to_file(New_File, List) ->
    file:write_file(New_File, 
		    io_lib:fwrite("~s ~s ~s ~s ~s ~s ~n", List), [append]).

sort_employees(File) ->
    Employees = record_of_all_employees(File),
    lists:sort(
      fun(A, B) ->	      
	      case equal_performance(A, B) of
		  true ->
		      
		      calculate_compa_ratio(A, B);
		  false ->    
		      compare_performance(A, B)
	      end
      end,
      Employees).

record_value(Rec) ->    
    [Rec#employee.no, Rec#employee.name, Rec#employee.salary,
     Rec#employee.level, Rec#employee.basesalary, Rec#employee.performance].

calculate_compa_ratio(A, B) ->
    A_salary = list_to_integer(A#employee.salary),
    A_base = list_to_integer(A#employee.basesalary),
    B_salary = list_to_integer(B#employee.salary),
    B_base = list_to_integer(B#employee.basesalary),
    (A_salary * 100) / A_base < (B_salary * 100) / B_base.


equal_performance(A, B) ->
    map(A#employee.performance) =:= map(B#employee.performance).


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


