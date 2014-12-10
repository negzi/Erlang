-module(honey_maker).
-export([open/1]).

-define(BLOCKSIZE, 8).


open(File) ->
    case file:open(File, [binary,raw,read]) of
	{ok, IoDevice} ->
	    case read_bytes(IoDevice, erlang:md5_init()) of
		{ok, Result} ->
		    file:write_file(file.md5, Result)
	    end;
	Error -> {error, file_open_failed}
    end.

read_bytes(Device, Context) ->
    case file:read(Device, ?BLOCKSIZE) of
	{ok, Bin} ->
	    read_bytes(Device, erlang:md5_update(Context, Bin));
	eof ->
	    file:close(Device),
	    {ok, erlang:md5_final(Context)}
    end.
