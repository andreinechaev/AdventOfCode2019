-module(helper).

-export([read_ints/2, read_lines/1, split_bin_str/2]).

read_ints(FileName, Delim) ->
    {ok, Data} = file:read_file(FileName),
    lists:map(fun (C) -> {V, _} = string:to_integer(C), V
	      end,
	      binary:split(Data, [Delim], [global])).

read_lines(FileName) ->
    {ok, Data} = file:read_file(FileName),
    binary:split(Data, [<<"\n">>], [global]).

split_bin_str(Bin, Delim) ->
    lists:map(fun (C) -> binary:bin_to_list(C) end,
	      binary:split(Bin, [Delim], [global])).
