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

    -- start-line = request-line / status-line
    -- request-line   = method SP request-target SP HTTP-version CRLF

    function parse_requestLine(Data:Ada.Streams.Stream_Element_Array; Index: in out Ada.Streams.Stream_Element_Offset) return Http_Method is
    begin
        Char := Character'Val(Data(Index));
        Index := 2;
        if Char = 'G' then
            pragma Assert(Character'Val(Data(Index)) = 'E', "Bad Method"); Index := 3;
            pragma Assert(Character'Val(Data(Index)) = 'T', "Bad Method");
            Method := Get;
        elsif Char = 'H' then
            pragma Assert(Character'Val(Data(Index)) = 'E', "Bad Method"); Index := 3;
            pragma Assert(Character'Val(Data(Index)) = 'A', "Bad Method"); Index := 4;
            pragma Assert(Character'Val(Data(Index)) = 'D', "Bad Method");
            Method := Head;
        else
            Ada.Text_IO.Put_Line("Method not supported");
            Method := Get;
        end if;
        pragma Assert(Character'Val(Data(Index)) = ' ', "Bad Method");
            
        return Method;
    end parse_requestLine;

end the_parser;

