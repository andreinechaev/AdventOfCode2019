-module(day3).

-export([are_parallel/2, do_intersect/2, part1/0]).

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

do_intersect({{Px1, Py1}, {Px2, Py2}},
	     {{Qx1, Qy1}, {Qx2, Qy2}}) ->
    % Ia = {max(min(Px1, Px2), min(Qx1, Qx2)), min(max(Px1, Px2), max(Qx1, Qx2))},
    Max = max(Px1, Px2),
    Min = min(Qx1, Qx2),
    if Max < Min -> false;
       true ->
	   A1 = (Py1 - Py2) / null_safe(Px1, Px2),
	   A2 = (Qy1 - Qy2) / null_safe(Qx1, Qx2),
	   B1 = Py1 - A1 * Px1,
	   B2 = Qy1 - A2 * Qx1,
	   if A1 == A2 -> false;
	      true ->
		  Xa = (B2 - B1) / (A1 - A2),
		  % Ya = A1 * Xa + B1,
		  not
		    ((Xa < max(min(Px1, Px2), min(Qx1, Qx2))) or
		       (Xa > min(max(Px1, Px2), max(Qx1, Qx2))))
	   end
    end.

are_parallel({{Px1, Py1}, {Px2, Py2}},
	     {{Qx1, Qy1}, {Qx2, Qy2}}) ->
    A1 = (Py1 - Py2) / null_safe(Px1, Px2),
    A2 = (Qy1 - Qy2) / null_safe(Qx1, Qx2),
    A1 == A2.

null_safe(V1, V2) when V1 - V2 == 0 -> 1;
null_safe(V1, V2) -> V1 - V2.
