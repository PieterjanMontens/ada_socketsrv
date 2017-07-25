with GNAT.Sockets;          use GNAT.Sockets;
with Ada.Streams;           use type Ada.Streams.Stream_Element_Count;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package the_server is
    --subtype Port_Range is Natural range 1 .. 65535;

    Server  : Socket_Type;
    Socket  : Socket_Type;

    Address : Sock_Addr_Type;
    Client  : Sock_Addr_Type;
    Channel    : Stream_Access;
    Port    : Port_Type;
    Errors  : Natural := 0;

    CRLF    : String := (1 => ASCII.CR ,2 => ASCII.LF);
    Send    : String := (1 => ASCII.CR ,2 => ASCII.LF
                        ,3 => ASCII.CR ,4 => ASCII.LF);

    Offset  : Ada.Streams.Stream_Element_Count;
    Data    : Ada.Streams.Stream_Element_Array (1 .. 512);

    HTTP_Request: Unbounded_String;

    CR : String := "" & ASCII.CR;

    unused : Integer;

    procedure start;
    procedure help;

end the_server;
