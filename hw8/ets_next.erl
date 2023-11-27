%%%-------------------------------------------------------------------
%%% @author lauragrechenko
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Nov 2023 12:40
%%%-------------------------------------------------------------------
-module(ets_next).
-author("lauragrechenko").

%% API
-export([print_each/1]).

print_each(Table) ->
  ets:safe_fixtable(Table, true),
  FirstKey = ets:first(Table),
  print_record(Table, FirstKey),
  print_each(Table, FirstKey).

print_each(Table, '$end_of_table') ->
  ets:safe_fixtable(Table, false),
  ok;
print_each(Table, LastKey) ->
  io:format("LastKey ~p ~n", [LastKey]),
  NextKey = ets:next(Table, LastKey),
  io:format("NextKey ~p ~n", [NextKey]),
  print_record(Table, NextKey),
  print_each(Table, NextKey).


print_record(Table, Key) ->
  Object = ets:lookup(Table, Key),
  io:format("Key ~p Object ~p~n", [Key, Object]).
