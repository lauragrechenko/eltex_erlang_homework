-module(calc_srv).
-author("lauragrechenko").

-behavior(gen_server).

%% API
-export([start/1, stop/1]).
-export([print_state/1, add_one/2, add_two/2]).

%% Callbacks
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2]).

-record(state, {
  cmd_count,
  last_cmd,
  all_cmd
}).

%% API

start(Name) ->
  gen_server:start({local, Name}, ?MODULE, [], []).

stop(Name) ->
  gen_server:stop(Name).

add_one(Name, Value) when is_integer(Value) ->
  gen_server:call(Name, {add_one, Value, self()}, infinity).

add_two(Name, Value) ->
  gen_server:call(Name, {add_two, Value, self()}).

print_state(Name) ->
  gen_server:cast(Name, print_state).

%% Callbacks

init([]) ->
  process_flag(trap_exit, true),
  {ok, #state{cmd_count = 0, all_cmd = []}}.

handle_call({add_one, Value, _Pid} = Msg, _From, #state{cmd_count = Count} = State) ->
  io:format("Received a new msg ~p~n", [Msg]),
  io:format("Current state ~p~n", [State]),
  NewState = State#state{cmd_count = Count + 1, last_cmd = add_one, all_cmd = [add_one | State#state.all_cmd]},
  {reply, {ok, Value + 1}, NewState};
handle_call({add_two, Value, _Pid} = Msg, _From, #state{cmd_count = Count} = State) ->
  io:format("Received a new msg ~p~n", [Msg]),
  io:format("Current state ~p~n", [State]),
  NewState = State#state{cmd_count = Count + 1, last_cmd = add_two, all_cmd = [add_two | State#state.all_cmd]},
  {reply, {ok, Value + 2}, NewState};
handle_call(stop, _From, State) ->
  io:format("Received a new msg ~p~n", [stop]),
  {stop, normal, State}.

handle_cast({print_state, _From}, State) ->
  io:format("Current state ~p~n", [State]),
  {noreply, State}.

handle_info({'EXIT', Pid, Reason}, State) ->
  {stop, noreply, State};
handle_info(Msg, State) ->
  io:format("Received msg info ~p~n", [Msg]),
  1 / 0,
  {noreply, State}.

terminate(Reason, State) ->
%%  io:format("Terminating reason ~p in state ~p~n", [Reason, State]),
  ok.
