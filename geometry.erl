-module(geometry).

-export([area/1, area/2, area/3]).
-export([area_case/1]).

area({rectangle, _, _} = Arg) ->
  io:format("~p~n", [Arg]),
  {_, Width, Height} = Arg,
  {ok, Width * Height};
area({square, Side}) when is_integer(Side) ->
  {ok, Side * Side};
area({triangle, Width, Height}) when Width < Height ->
  {ok, (Width * Height)/2};
area(Error) ->
  io:format("Error arg ~p~n", [Error]),
  {error, badarg}.

area(_A, _B) -> ok.

area(_A, _B, _C) -> ok.

area_case(Arg) ->
  Result =
    case Arg of
      {rectangle, Width, Height} ->
        {ok, Width * Height};
      {square, Side} ->
        {ok, Side * Side};
      {triangle, Width, Height} ->
        {ok, (Width * Height)/2};
      Error ->
        io:format("Error arg ~p~n", [Error]),
        {error, badarg}
    end,
%%  f1(Result).
  Result2 = f1(Result),
  Result2.


f1(Result) -> Result.