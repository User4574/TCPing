-module(tcping_client).
-export([client_start/2]).
-define(Timeout, 1000).

client_start(Server, Port) ->
  {ok, Sock} = gen_tcp:connect(Server, Port, [binary, {packet, 0}, {active, false}]),
  client_loop(Sock, 1).

client_loop(Sock, N) ->
  receive
  after ?Timeout ->
    ok
  end,
  Ping = io_lib:format("~p Ping", [N]),
  ok = gen_tcp:send(Sock, Ping),
  io:format(Ping),
  {ok, <<"Pong">>} = gen_tcp:recv(Sock, 0),
  io:format(" Pong~n"),
  client_loop(Sock, N+1).
