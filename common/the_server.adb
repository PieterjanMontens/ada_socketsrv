with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with GNAT.Sockets;          use GNAT.Sockets;
with GNAT.Command_Line;     use GNAT.Command_Line;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

with Ada.Streams; use type Ada.Streams.Stream_Element_Count;

package body the_server is

    procedure start is
  
    begin
        loop  
            case Getopt ("-port= -help") is
                when '-' =>
                    if Full_Switch = "-port" then
                        Port := Port_Type'Value(Parameter);
                    elsif Full_Switch = "-help" then
                        help;
                        Ada.Command_Line.Set_Exit_Status(1);
                        return;
                    else
                        Ada.Text_IO.Put_Line("Cannot parse " & Full_Switch);
                        return;
                    end if;
                when others => 
                    exit;
             end case;
        end loop;
        Ada.Text_IO.Put_Line ("-- Starting server on port " & Port_Type'Image(Port));

        Address.Addr := Addresses (Get_Host_By_Name (Host_Name), 1);
        Address.Port := Port;

        Create_Socket(Server);
        Set_Socket_Option(Server
                         ,Socket_Level
                         ,(Reuse_Address, Enabled => True));
        Set_Socket_Option(Server
                         ,Socket_Level
                         ,(Receive_Timeout, Timeout => 10.0));
        Bind_Socket(Server,Address);
        Listen_Socket(Server);
        loop
            Accept_Socket(Server, Socket, Address);
            Ada.Text_IO.Put_Line ("Client connected from " & GNAT.Sockets.Image (Client));
            Channel := Stream(Socket);
            begin
                Receive_Socket(Socket, Data, Offset);
                for I in 1 .. Offset loop
                    Append(HTTP_Request, Character'Val(Data(I)));
                end loop;
                Ada.Text_IO.Put_Line("Client " & GNAT.Sockets.Image (Client) & ":");
                Ada.Text_IO.Unbounded_IO.Put_Line(HTTP_Request);
                
                String'Write(Channel, 
                     "HTTP/1.1 200 OK" & CRLF & 
                     "Date: Tue, 25 Jul 2017 13:33:54 GMT" & 
                     Send & 
                     "something" & Send 
                  );
            exception
                when Ada.IO_Exceptions.End_Error=>
                    null;
                when Socket_Error =>
                    Errors := Errors + 1;
                    exit when Errors = 10;
            end;
            Close_Socket(Socket);
        end loop;
    end start;

    procedure help is
    begin
        Ada.Text_IO.Put_Line ("How to use: simple_http --port=[PORT] [--help]");
    end help;

end the_server;
