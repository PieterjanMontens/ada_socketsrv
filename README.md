# ada_socketsrv
*work in progress*

Very simple ADA Http/socket server, so I can explore what makes a web server tick.

## Why Ada ?
 * Robustness
 * See how it fits for larger projects (Ada is known for its modularity)
 * Interest in learning the language (compiler, data types, concurrency, strong typing)

## Current state
It just answers something to a HTTP/1.1 request.

## How to use
You'll need Ada, GNAT & gprbuild
Compile:

    $ gprbuild -Pada_socketsrv

Run:

    $ ./bin/simple_http --port=18080
