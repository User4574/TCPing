-module(tcping_server).
-export([server_start/1]).

server_start(Port) ->
  {ok, LSock} = gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]),
  {ok, Sock} = gen_tcp:accept(LSock),
  server_loop(Sock).

server_loop(Sock) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, Ping} ->
      io:format(Ping),
      gen_tcp:send(Sock, "Pong"),
      io:format(" Pong~n"),
      server_loop(Sock);
    {error, closed} ->
      io:format("Disconnect~n")
  end.
