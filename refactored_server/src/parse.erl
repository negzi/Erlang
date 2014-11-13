-module(parse).
-compile(export_all).

parse(Data) ->
    Striped = Data--"\"\"\"",
    List_from_input = string:tokens(Striped, ",[]\n "),
    Validated_data = check_length_of(List_from_input),
    format(Validated_data).

format(Data) ->
    [Module, Function| Args] = Data,
    [Mod, Fun] = [list_to_atom(X) || X <- [Module, Function]],
    case is_mod_defined(Mod) of
	true -> {ok, [Mod, Fun |Args]};
	false -> {ok,[invalid, data,"entered"]}
    end.

check_length_of(Data) ->
    case length(Data) < 3 of
	true -> 
	    Data ++ ["invalid", "data" ,"entered"];
	false ->
	    Data
    end.

is_mod_defined(assignment_1) ->
    true;
is_mod_defined(salary) ->
    true;
is_mod_defined(history) ->
    true;
is_mod_defined(_) ->
    false.


