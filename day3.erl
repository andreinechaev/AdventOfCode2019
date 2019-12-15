-module(day3).

-export([part1/0]).

-import(string, [slice/2, slice/3]).

part1() ->
    Wires = helper:read_lines("input3.txt"),
    parse(Wires, []).

parse([], Acc) -> Acc;
parse([H | T], Acc) ->
    Split = helper:split_bin_str(H, <<",">>),
    Tups = to_direction(Split, []),
    Points = to_points(Tups, []),
    Lines = to_lines(Points, []),
    parse(T, [Lines | Acc]).

to_direction([], Acc) -> Acc;
to_direction([H | T], Acc) ->
    Dir = slice(H, 0, 1),
    {Step, _} = string:to_integer(slice(H, 1)),
    to_direction(T, Acc ++ [{Dir, Step}]).

to_points([{D, Val} | T], Result) ->
    Priv = case D of
	     "U" -> {0, Val};
	     "R" -> {Val, 0};
	     "D" -> {0, -Val};
	     "L" -> {-Val, 0}
	   end,
    to_points(T, Priv, Result ++ [Priv]).

to_points([], _, Result) -> Result;
to_points([{D, Val} | T], Priv, Result) ->
    {X, Y} = Priv,
    Next = case D of
	     "U" -> {X, Y + Val};
	     "R" -> {X + Val, Y};
	     "D" -> {X, Y + -Val};
	     "L" -> {X + -Val, Y}
	   end,
    to_points(T, Next, Result ++ [Next]).

to_lines([], Result) -> Result;
to_lines([P1, P2], Result) ->
    to_lines([], Result ++ [{P1, P2}]);
to_lines([P1, P2 | T], Result) ->
    to_lines([P2 | T], Result ++ [{P1, P2}]).
