with GNAT.Sockets;          use GNAT.Sockets;
with Ada.Streams;           use type Ada.Streams.Stream_Element_Count;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with the_parser;

package the_server is
    subtype Port_Range is Port_Type range 0 .. 65535;

    Server  : Socket_Type;
    Socket  : Socket_Type;

    Address : Sock_Addr_Type;
    Client  : Sock_Addr_Type;
    Channel    : Stream_Access;
    Port    : Port_Range;
    Errors  : Natural := 0;

    CRLF    : String := (1 => ASCII.CR ,2 => ASCII.LF);
    Send    : String := (1 => ASCII.CR ,2 => ASCII.LF
                        ,3 => ASCII.CR ,4 => ASCII.LF);

    Offset  : Ada.Streams.Stream_Element_Count;
    Data    : Ada.Streams.Stream_Element_Array (1 .. 512);

    HTTP_Request: Unbounded_String;

    procedure start;
    procedure help;

end the_server;
