%%%-------------------------------------------------------------------
%%% @author lauragrechenko
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Nov 2023 13:48
%%%-------------------------------------------------------------------
-module(ex).
-author("lauragrechenko").

-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).

-record(ex_state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%% @doc Spawns the server and registers the local name (unique)
-spec(start_link() ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc Initializes the server
-spec(init(Args :: term()) ->
  {ok, State :: #ex_state{}} | {ok, State :: #ex_state{}, timeout() | hibernate} |
  {stop, Reason :: term()} | ignore).
init([]) ->
  {ok, #ex_state{}}.

%% @private
%% @doc Handling call messages
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
    State :: #ex_state{}) ->
  {reply, Reply :: term(), NewState :: #ex_state{}} |
  {reply, Reply :: term(), NewState :: #ex_state{}, timeout() | hibernate} |
  {noreply, NewState :: #ex_state{}} |
  {noreply, NewState :: #ex_state{}, timeout() | hibernate} |
  {stop, Reason :: term(), Reply :: term(), NewState :: #ex_state{}} |
  {stop, Reason :: term(), NewState :: #ex_state{}}).
handle_call(_Request, _From, State = #ex_state{}) ->
  {reply, ok, State}.

%% @private
%% @doc Handling cast messages
-spec(handle_cast(Request :: term(), State :: #ex_state{}) ->
  {noreply, NewState :: #ex_state{}} |
  {noreply, NewState :: #ex_state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #ex_state{}}).
handle_cast(_Request, State = #ex_state{}) ->
  {noreply, State}.

%% @private
%% @doc Handling all non call/cast messages
-spec(handle_info(Info :: timeout() | term(), State :: #ex_state{}) ->
  {noreply, NewState :: #ex_state{}} |
  {noreply, NewState :: #ex_state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #ex_state{}}).
handle_info(_Info, State = #ex_state{}) ->
  {noreply, State}.

%% @private
%% @doc This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
    State :: #ex_state{}) -> term()).
terminate(_Reason, _State = #ex_state{}) ->
  ok.

%% @private
%% @doc Convert process state when code is changed
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #ex_state{},
    Extra :: term()) ->
  {ok, NewState :: #ex_state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State = #ex_state{}, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
