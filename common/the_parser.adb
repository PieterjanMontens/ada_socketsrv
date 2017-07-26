with Ada.Streams; 
with Ada.Strings.Unbounded; 

package body the_parser is
    
    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_record is
    begin
        -- Just some defaults, awaiting implementation
        Request := (method  => Get
                   ,path    => Ada.Strings.Unbounded.To_Unbounded_String("/")
                   ,version => http11);

        return Request;
    end parse_request;

end the_parser;
