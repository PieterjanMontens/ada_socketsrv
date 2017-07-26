with Ada.Streams; 
with Ada.Strings.Unbounded; 

package body the_parser is
    
    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_Record is
    begin
        -- Just some defaults, awaiting implementation
        Request := (method  => Get
                   ,path    => parse_path(Data)
                   ,version => http11);

        return Request;
    end parse_request;

    function parse_path(Data:Ada.Streams.Stream_Element_Array) return Request_Path is
    begin
        return Ada.Strings.Unbounded.To_Unbounded_String("/");
    end parse_path;

end the_parser;
