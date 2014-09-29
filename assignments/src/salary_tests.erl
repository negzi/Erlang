
-module(salary_tests).
-include_lib("eunit/include/eunit.hrl").

-record(employee, {no, name, salary, level,  basesalary,performance}).
wrong_file_name_test() ->
    ?assertEqual({error,enoent}, salary:read_lines("/home/neg/myfil")).


assign_employee_info_test() ->
    ?assertEqual(#employee{no = 1,name = albert, 
			   salary=21161, level=4, basesalary=15000, performance=bad},
		 salary:fill_employee_info(1, albert, 21161,4, 15000, bad)).
