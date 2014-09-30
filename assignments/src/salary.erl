-module(salary).
-export([read_lines/1, fill_employee_info/6]).

-record(employee, {no,
                  name,
                  salary,
                  level,
                  basesalary,
                  performance}).

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

	
fill_employee_info(No, Name, Salary, Level, Basesalary, Performance) ->
    #employee{no=No, name=Name, salary=Salary, 
	      level=Level, basesalary=Basesalary, 
	      performance=Performance}.
