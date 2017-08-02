with Ada.Text_IO;
with Ada.Streams; 
with Ada.Strings.Unbounded; 

package the_parser is
    package UB renames Ada.Strings.Unbounded;

    type Http_Method is (get, head, post, put, delete);
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
    Method  : Http_Method;
    Headers : Http_Headers;
    Char    : Character;
    
    function parse_path(Data:Ada.Streams.Stream_Element_Array) return Request_Path;

    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_Record;

    --function parse_method(Data:Ada.Streams.Stream_Element_Array) return Http_Method;

    function parse_requestLine(Data:Ada.Streams.Stream_Element_Array; Index:in out Ada.Streams.Stream_Element_Offset) return Http_Method;

end the_parser;
