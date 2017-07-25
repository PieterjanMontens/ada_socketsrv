with Ada.Text_IO;
with the_server;

procedure simple_http is
begin
       Ada.Text_IO.Put_Line ("");
	   Ada.Text_IO.Put_Line ("-----------------------------");
	   Ada.Text_IO.Put_Line ("--   Simple HTTP Server    --");
	   Ada.Text_IO.Put_Line ("-----------------------------");
	   Ada.Text_IO.Put_Line ("");

	   the_server.start;

end simple_http;
