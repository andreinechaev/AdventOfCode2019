-module(day2).

-export([part1/0, part2/0, replace/3, traverse/1]).

part1() ->
    List = helper:read_ints("input2.txt", <<",">>),
    F = replace(List, 2, 12),
    S = replace(F, 3, 2),
    traverse(S).

part2() ->
    List = helper:read_ints("input2.txt", <<",">>),
    filter(List, 19690720).

filter(List, Num) -> step(List, 0, 0, Num).

step(_, Noun, _, _) when Noun > 99 -> -1;
step(List, Noun, Verb, Num) when Noun =< 99 ->
    Res = traverse(List),
    case Res == Num of
      % Early return appears to be more complex than expected. TODO: think a better way
      true -> io:format("Result = ~p\n", [100 * Noun + Verb]);
      false ->
	  In = internal(List, Noun, 0, Num),
	  step(List, Noun + 1, In, Num)
    end.

internal(_, _, Verb, _) when Verb > 99 -> Verb - 1;
internal(List, Noun, Verb, Num) when Verb =< 99 ->
    F = replace(List, 2, Noun),
    S = replace(F, 3, Verb),
    Res = traverse(S),
    case Res == Num of
      true -> step(S, Noun, Verb, Num);
      false -> internal(List, Noun, Verb + 1, Num)
    end.

traverse(Arr) -> traverse(Arr, Arr, 0).

traverse([H | _], [], _) -> H;
traverse([H | _], [Cmd | _], _) when Cmd == 99 -> H;
traverse(Original, [Cmd, Noun, Verb, OutPos | _],
	 Idx) ->
    F = lists:nth(Noun + 1, Original),
    S = lists:nth(Verb + 1, Original),
    Res = op(Cmd, F, S),
    Mod = replace(Original, OutPos + 1, Res),
    traverse(Mod, lists:nthtail(Idx + 4, Mod), Idx + 4).

op(Op, V1, V2) ->
    if Op == 1 -> V1 + V2;
       Op == 2 -> V1 * V2
    end.

replace([], _, Res) -> [Res];
replace(List, Out, Res) when Out > 1 ->
    lists:sublist(List, Out - 1) ++
      [Res] ++ lists:nthtail(Out, List);
replace(List, Out, Res) ->
    [Res] ++ lists:nthtail(Out, List).
