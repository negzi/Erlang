-module(salary).
-export([read_lines/1, fill_employee_info/6]).

-record(employee, {no,
                  name,
                  salary,
                  level,
                  basesalary,
                  performance}).


read_lines(FileName) ->
    case file:read_file(FileName) of
	{ok, Data} ->
	   binary:split(Data, [<<"\n">>], [global]);
	{error,Reason} ->
	    {error,Reason}
    end.


		
fill_employee_info(No, Name, Salary, Level, Basesalary, Performance) ->
    #employee{no=No, name=Name, salary=Salary, 
	      level=Level, basesalary=Basesalary, 
	      performance=Performance}.
