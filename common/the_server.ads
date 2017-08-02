with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Ada.Command_Line;
with the_parser;
with Ada.Strings.Unbounded; 

-- packages inserted into namespace
with GNAT.Sockets;          use GNAT.Sockets;
with GNAT.Command_Line;     use GNAT.Command_Line;
with Ada.Streams;           use type Ada.Streams.Stream_Element_Count;


package the_server is
    package UB renames Ada.Strings.Unbounded;

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

    HTTP_Request: UB.Unbounded_String;

    Last     : Ada.Streams.Stream_Element_Offset;
    test_out : the_parser.Http_Method;

    procedure start;
    procedure help;

end the_server;
