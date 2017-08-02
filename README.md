*work in progress*
# ada_socketsrv

Very simple ADA Http/socket server, a nice exercise to get to know a new language.

## Why Ada ?
 * Robustness
 * See how it fits for larger projects (Ada is known for its modularity)
 * Interest in learning the language (compiler, data types, concurrency, strong typing)

## Current state
It just answers something to a HTTP/1.1 request, one at a time. 
Still working on a parser, though it can already read HTTP method & target.

## How to use
You'll need Ada, GNAT & gprbuild.

Compile:

    $ gprbuild -Pada_socketsrv

Run:

    $ ./bin/simple_http --port=[PORT]
