with Ada.Strings.Unbounded; 
with Ada.Streams; 

package the_parser is

    type Http_Method is (get, post, put, delete);
    type Http_Version is (http11,http2);
    
    type Request_record is
        record
            method : Http_Method;
            path   : Ada.Strings.Unbounded.Unbounded_String;
            version: Http_Version;
        end record;

    Request : Request_record;
    
    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_record;

end the_parser;
