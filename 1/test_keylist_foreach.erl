-module(test_keylist_foreach).

-include_lib("eunit/include/eunit.hrl").

-define(setup(F), {setup, fun setup/0, fun teardown/1, F}).

-define(TEST_KEYLIST_NAME1, keylist1).

keylist_test_() ->
    {
        foreach, fun setup/0, fun teardown/1,
        [
            fun test_add_find/1,
            fun test_add_find2/1
        ]
    }.

setup() ->
    {ok, Pid} = keylist:start_link(?TEST_KEYLIST_NAME1),
    #{pid => Pid, name => ?TEST_KEYLIST_NAME1}.

teardown(#{pid := Pid, name := Name}) ->
    erlang:monitor(process, Pid),
    keylist:stop(Name),
    receive
        {'DOWN', _Ref, process, _Pid, _Reason} ->
            ok
    end.

test_add_find(#{name := Name}) ->
    TestKey = "test_key",
    TestValue = "test_value",
    TestComment = "test_comment",
    keylist:add(Name, TestKey, TestValue, TestComment),
    AddResult = wait_result(),
    keylist:find(Name, TestKey),
    FindResult = wait_result(),
    [
        ?_assertMatch({ok, 1}, AddResult),
        ?_assertMatch({ok, 2, {TestKey, TestValue, TestComment}}, FindResult)
    ].


test_add_find2(#{name := Name}) ->
    TestKey = "test_key",
    TestValue = "test_value2",
    TestComment = "test_comment2",
    keylist:add(Name, TestKey, TestValue, TestComment),
    AddResult = wait_result(),
    keylist:find(Name, TestKey),
    FindResult = wait_result(),
    [
        ?_assertMatch({ok, 1}, AddResult),
        ?_assertMatch({ok, 2, {TestKey, TestValue, TestComment}}, FindResult)
    ].

%% Private functions

wait_result() ->
    receive
        Msg -> Msg
    end.