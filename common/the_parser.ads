with Ada.Text_IO;
with Ada.Streams; use type Ada.Streams.Stream_Element; 
with Ada.Strings.Unbounded; 
with Ada.Strings.Fixed;

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
    Target  : Request_Path;
    Headers : Http_Headers;

    procedure parse_request(Data    : in Ada.Streams.Stream_Element_Array
                           ;Index   : in out Ada.Streams.Stream_Element_Offset
                           ;Request : out Request_Record);
    

    procedure method_obtain(Data   : Ada.Streams.Stream_Element_Array
                           ;Index  : in out Ada.Streams.Stream_Element_Offset
                           ;Method : out Http_Method);

    procedure target_obtain(Data   : Ada.Streams.Stream_Element_Array
                           ;Index  : in out Ada.Streams.Stream_Element_Offset
                           ;Target : out Request_Path);

    function image(Req:Request_Record) return String;

end the_parser;
