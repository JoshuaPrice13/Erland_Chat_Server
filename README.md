# Erlang Chat Server

A concurrent messaging system implemented in Erlang, demonstrating client-server communication and process coordination using `gen_server`. The project simulates real-time chat between multiple clients through a centralized server.  

## Features

- **Server (`chat_server`)**: Manages client registration and routes messages between connected clients.  
- **Client (`chat_client`)**: Connects to the server, sends messages, and receives messages from other clients.  
- **Script (`chat_script`)**: Initializes the server and clients, and simulates a short interactive conversation.  

## Getting Started

Compile the modules and run the script:

```erlang
erl
c(chat_server).
c(chat_client).
c(chat_script).
chat_script:start().
