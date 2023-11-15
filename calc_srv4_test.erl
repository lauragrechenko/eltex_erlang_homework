-module(calc_srv4_test).
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
  {
    foreach, fun start/0, fun stop/1,
    [
      fun test_calc_add_one/1,
      fun test_calc_add_two/1
    ]
  }.

start() ->
    {ok, Pid} = calc_srv:start_link(?CALC_NAME_1),
    ?debugFmt("Setting up", []),
    #{pid => Pid, name => ?CALC_NAME_1}.

stop(#{name := Name}) ->
  ?debugFmt("Cleaning up", []),
  calc_srv:stop(Name).

test_calc_add_one(#{name := Name}) ->
    ?assertEqual({ok, 101}, calc_srv:add_one(Name, 100)).

test_calc_add_two(#{name := Name}) ->
    ?assertEqual({ok, 102}, calc_srv:add_two(Name, 100)).

