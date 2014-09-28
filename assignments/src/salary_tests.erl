-module(salary_tests).
-include_lib("eunit/include/eunit.hrl").

wrong_file_name_test() ->
    ?assertEqual({error,enoent}, salary:read_lines("/home/neg/myfil")).
