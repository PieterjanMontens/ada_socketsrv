with Ada.Streams; 
with Ada.Strings.Unbounded; 

package the_parser is
    package UB renames Ada.Strings.Unbounded;

    type Http_Method is (get, post, put, delete);
    type Http_Version is (http11,http2);
    subtype Request_Path is UB.Unbounded_String;
    
    type Header_Record is
        record
            header : UB.Unbounded_String;
            value  : UB.Unbounded_String;
        end record;

    type Http_Headers is array(1 .. 256) of Header_Record;

    type Request_Record is
        record
            method : Http_Method;
            path   : Request_Path;
            version: Http_Version;
            headers: Http_Headers;
        end record;

    Request : Request_record;
    Headers : Http_Headers;
    
    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_Record;

    function parse_path(Data:Ada.Streams.Stream_Element_Array) return Request_Path;

end the_parser;
