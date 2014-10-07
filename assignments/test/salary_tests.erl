
-module(salary_tests).
-include_lib("eunit/include/eunit.hrl").

-record(employee, {no, name, salary, level,  basesalary,performance}).

wrong_file_name_test() ->
    ?assertEqual({error,enoent}, salary:read_lines("/home/neg/myfil")).

read_lines_test() ->
    ?assertEqual([["No","Name","Salary","Level","BaseSalary","Performance"],
		  ["2","albert","21161","4","15000","Bad"],
		  ["3","becka","21161","4","15000","Good"],
		  ["4","emilio","21562","6","25000","Excellent"]],
		 salary:read_lines("/home/enegfaz/employee_info")).

assign_employee_info_test() ->
    ?assertEqual(#employee{no = 1,name = albert, 
			   salary=21161, level=4, basesalary=15000, performance=bad},
		 salary:fill_employee_info(1, albert, 21161,4, 15000, bad)).

record_all_employee_test() ->
    ?assertEqual([ #employee{no = "2",name = "albert",salary = "21161",
			    level = "4",basesalary = "15000",performance = "Bad"},
		  #employee{no = "3",name = "becka",salary = "21161",
			    level = "4",basesalary = "15000",performance = "Good"},
		  #employee{no = "4",name = "emilio",salary = "21562",
			    level = "6",basesalary = "25000",performance = "Excellent"}],
		salary:record_of_all_employees("/home/enegfaz/employee_info")).

performance_to_num_test() ->
    ?assertEqual(3, salary:map("Excellent")).

compare_performance_test() ->
    A = #employee{no = "2",name = "albert",salary = "21161",
	      level = "4",basesalary = "15000",performance = "Bad"},
    B = #employee{no = "4",name = "emilio",salary = "21562",
		  level = "6",basesalary = "25000",performance = "Bad"},
    ?assertEqual(false, salary:compare_performance(A, B)).

calculate_compa_ratio_test() ->
    A = #employee{no = "2",name = "albert",salary = "21161",
		  level = "4",basesalary = "15000",performance = "Good"},
    B = #employee{no = "4",name = "emilio",salary = "21562",
		  level = "6",basesalary = "25000",performance = "Bad"},
    ?assertEqual(false, salary:calculate_compa_ratio(A, B)).
    

sorted_employees_test() ->
    ?assertEqual([#employee{no = "4",name = "emilio",salary = "21562",
			    level = "6",basesalary = "25000",performance = "Excellent"},
		  #employee{no = "3",name = "becka",salary = "21161",
			    level = "4",basesalary = "15000",performance = "Good"},
		  #employee{no = "2",name = "albert",salary = "21161",
			    level = "4",basesalary = "15000",performance = "Bad"}],
		 salary:sort_employees("/home/enegfaz/employee_info")).

record_value_test() ->
    A = #employee{no = "2",name = "albert",salary = "21161",
		  level = "4",basesalary = "15000",performance = "Good"},
    ?assertEqual(["2","albert","21161","4","15000","Good"], salary:record_value(A)).
