-module(day1).

-export([calc_fuel/1]).

calc_fuel(FileName) ->
    List = helper:read_ints(FileName, <<"\n">>),
    traverse(List, 0).

traverse([], Acc) -> Acc;
traverse([Head | Tail], Acc) ->
    traverse(Tail, Acc + incl_fuel(Head)).

incl_fuel(Fuel) -> incl_fuel(Fuel, 0).

incl_fuel(Fuel, Acc) ->
    Res = calc(Fuel),
    if Res > 0 -> incl_fuel(Res, Acc + Res);
       Res =< 0 -> Acc;
       true -> incl_fuel(Res, Acc)
    end.

calc(Num) -> Num div 3 - 2.
