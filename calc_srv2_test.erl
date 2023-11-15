-module(calc_srv2_test).
-author("lauragrechenko").

-include_lib("eunit/include/eunit.hrl").

-define(CALC_NAME_1, calc1).

%%start_stop_test() ->
%%    {ok, Pid} = calc_srv:start_link(?CALC_NAME_1),
%%    ?assert(is_pid(Pid)),
%%    ?assertEqual(Pid, whereis(?CALC_NAME_1)),
%%    calc_srv:stop(?CALC_NAME_1),
%%    ?assertNot(is_process_alive(Pid)).

calc_add_test_() ->
    [
      {setup, fun start/0, fun stop/1, fun test_calc_add_one/0},
      {setup, fun start/0, fun stop/1, fun test_calc_add_two/0}
    ].

start() ->
    {ok, Pid} = calc_srv:start_link(?CALC_NAME_1),
    ?debugFmt("Setting up", []),
    #{pid => Pid, name => ?CALC_NAME_1}.

stop(#{name := Name}) ->
  ?debugFmt("Cleaning up", []),
  calc_srv:stop(Name).

test_calc_add_one() ->
    ?assertEqual({ok, 101}, calc_srv:add_one(?CALC_NAME_1, 100)).

test_calc_add_two() ->
    ?assertEqual({ok, 102}, calc_srv:add_two(?CALC_NAME_1, 100)).

