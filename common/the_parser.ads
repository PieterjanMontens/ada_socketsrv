with Ada.Strings.Unbounded; 
with Ada.Streams; 

package the_parser is

    type Http_Method is (get, post, put, delete);
    type Http_Version is (http11,http2);
    subtype Request_Path is Ada.Strings.Unbounded.Unbounded_String;
    
    type Request_Record is
        record
            method : Http_Method;
            path   : Request_Path;
            version: Http_Version;
        end record;

    Request : Request_record;
    
    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_Record;

    function parse_path(Data:Ada.Streams.Stream_Element_Array) return Request_Path;

end the_parser;
