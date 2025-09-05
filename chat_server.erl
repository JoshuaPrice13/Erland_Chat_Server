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
%	~~chat_server~~
%	This module defines the chat server creating a gen_server module. 
%	start_link, register_client, and send_message are all functions that we directly
%	call in the script. The rest of the functions are defining the inherant gen-server
%	behavior. 
%	--------------
%	How to run this file:
%	Don't. This file is only here to define the server and is called on from the script file.
%	---------------
%	Reasources:
%		I used Claude Sonnet 4 to give me an overview of the gen_server behavior.
%		https://claude.ai
%	Thank you for your time!


-module(chat_server).
-behaviour(gen_server).

-export([start_link/0, register_client/1, send_message/2]).
-export([init/1, handle_call/3, handle_cast/2]).

-define(SERVER, ?MODULE).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
    

register_client(Pid) ->
    gen_server:call(?SERVER, {register, Pid}).

send_message(FromPid, Message) ->
    gen_server:cast(?SERVER, {message, FromPid, Message}).


%automatically called functions by the gen server behavior

init([]) ->
    {ok, []}.  % Initial state: empty client list

handle_call({register, Pid}, _From, Clients) ->
    {reply, ok, lists:usort([Pid | Clients])}.


handle_cast({message, FromPid, Message}, Clients) ->
    % Broadcast to all except sender
    lists:foreach(fun(Pid) ->
    if Pid =/= FromPid ->
        Pid ! {chat, FromPid, Message};
            true ->
            ok
        end
        end, Clients),
        {noreply, Clients}.

