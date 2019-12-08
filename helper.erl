-module(helper).

-export([read_ints/2]).

read_ints(FileName, Delim) ->
    {ok, Data} = file:read_file(FileName),
    lists:map(fun (C) -> {V, _} = string:to_integer(C), V
	      end,
	      binary:split(Data, [Delim], [global])).