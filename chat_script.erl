%	Programming Assignment 6: Erlang Chat Server
%	CS-3363, Summer 2025
%	Professor Richard L. Churchill, Oklahoma State University
%	Due:07-25-2025, 11:59 p.m.
%	--------------
%	Date:		07-21-2025
%	Author:		Joshua Price
%	csx username:	joshpri
%	--------------
%
%	~~chat_script~~
%	This module creates an instance of the server module and inits the clients. It then calls
%	on these two modules, simulating the server-to-client relationship.	
%	--------------
%	How to run this file:
%	Using erl on the csx server:
%		erl
%		c(chat_server).
%		c(chat_client).
%		c(chat_script).
%		chat_script:start().
%	Note: The order in which you compile the 3 modules does not matter, and you can expect
%	a 3 message conversation between two clients.
%	---------------
%	Thank you for your time!


-module(chat_script).

-export([start/0]).

start() ->

    {ok, ChatServer} = chat_server:start_link(),

    ChatClient1 = chat_client:start_link(),

    ChatClient2 = chat_client:start_link(),

    chat_client:connect(ChatServer, ChatClient1),

    chat_client:connect(ChatServer, ChatClient2),

    chat_client:send_message(ChatClient1, "You killed my father!"),
    timer:sleep(100),

    chat_client:send_message(ChatClient2, "No... I am your father."),
    timer:sleep(100),

    chat_client:send_message(ChatClient1, "...Cool, so can i just get my inheritance now?"),
    timer:sleep(100).

