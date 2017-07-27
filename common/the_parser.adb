package body the_parser is

    function parse_request(Data:Ada.Streams.Stream_Element_Array) return Request_Record is
    begin
        -- Just some defaults, awaiting implementation
        -- Probably some kind of byte-for-byte interface & state machine.

        Headers(1) := (header => UB.To_Unbounded_String("host")
                         ,value  => UB.To_Unbounded_String("my_host") );

        Request := (method  => Get
                   ,path    => parse_path(Data)
                   ,version => http11
                   ,headers => Headers);

        return Request;
    end parse_request;

    function parse_path(Data:Ada.Streams.Stream_Element_Array) return Request_Path is
    begin
        -- Just some defaults, awaiting implementation
        -- Probably read allowed characters until whitespace
        return UB.To_Unbounded_String("/");
    end parse_path;

end the_parser;
