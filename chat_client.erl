%	Programming Assignment 6: Erlang Chat Server
%	CS-3363, Summer 2025
%	Professor Richard L. Churchill, Oklahoma State University
%	Due:07-25-2025, 11:59 p.m.
%	--------------
%	Date:		07-21-2025
%	Author: 	Joshua Price
%	csx username: 	joshpri
%	--------------
%
%	~~chat_client~~
%	This module defines a client that connects to the server. Once connected, they
%	are put in a loop. They then await to send or recieve a message from the server.	
%	--------------
%	How to run this file:
%	Don't. This file is only here to define the clients and is called on from the script file.
%	---------------
%	Thank you for your time!


-module(chat_client).

-export([start_link/0, connect/2, loop/1, send_message/2]).


start_link() -> 
	spawn_link(fun() -> loop(undefined) end).

connect(Server, Client) -> 
	Client ! {connect, Server},
	chat_server:register_client(Client),
	ok.

loop(Server) -> 
	receive
		{connect, NewServer} ->
			io:format("client connected to server ~n"),
			loop(NewServer);
		{send, Message} ->
			chat_server:send_message(self(), Message),
			loop(Server);
		{chat, FromPid, Message} ->
			io:format("From ~p: ~s~n", [FromPid, Message]),
			loop(Server)
	end.


send_message(Client, Message) ->
	Client ! {send, Message},
	ok.
