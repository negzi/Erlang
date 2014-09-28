-module(salary).
-export([read_lines/1]).

read_lines(FileName) ->
    case file:read_file(FileName) of
	{ok, Data} ->
	   binary:split(Data, [<<"\n">>], [global]);
	{error,Reason} ->
		{error,Reason}
    end.
		
