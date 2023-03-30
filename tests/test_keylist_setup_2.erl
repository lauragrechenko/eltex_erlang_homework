-module(test_keylist_setup_2).

-include_lib("eunit/include/eunit.hrl").

-define(setup(F), {setup, fun setup/0, fun teardown/1, F}).

-define(TEST_KEYLIST_NAME1, keylist1).

keylist_test_() ->
    [
        {setup, fun setup/0, fun teardown/1, fun test_add_find/0},
        {setup, fun setup/0, fun teardown/1, fun test_add_find2/0}
    ].

setup() ->
    {ok, Pid} = keylist:start_link(?TEST_KEYLIST_NAME1),
    #{pid => Pid, name => ?TEST_KEYLIST_NAME1}.

teardown(#{pid := Pid}) ->
    erlang:monitor(process, Pid),
    keylist:stop(?TEST_KEYLIST_NAME1),
    receive
        {'DOWN', _Ref, process, _Pid, _Reason} ->
            ok
    end.

test_add_find() ->
    TestKey = "test_key",
    TestValue = "test_value",
    TestComment = "test_comment",
    keylist:add(?TEST_KEYLIST_NAME1, TestKey, TestValue, TestComment),
    ?assertMatch({ok, 1}, wait_result()),
    keylist:find(?TEST_KEYLIST_NAME1, TestKey),
    ?assertMatch({ok, 2, {TestKey, TestValue, TestComment}}, wait_result()).


test_add_find2() ->
    TestKey = "test_key2",
    TestValue = "test_value2",
    TestComment = "test_comment2",
    keylist:add(?TEST_KEYLIST_NAME1, TestKey, TestValue, TestComment),
    AddResult = wait_result(),
    ?assertMatch({ok, 1}, AddResult),
    keylist:find(?TEST_KEYLIST_NAME1, TestKey),
    FindResult = wait_result(),
    ?assertMatch({ok, 2, {TestKey, TestValue, TestComment}}, FindResult).

%% Private functions

wait_result() ->
    receive
        Msg -> Msg
    end.