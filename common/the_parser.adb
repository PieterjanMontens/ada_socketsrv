package body the_parser is

    procedure parse_request(Data    : in Ada.Streams.Stream_Element_Array
                           ;Index   : in out Ada.Streams.Stream_Element_Offset
                           ;Request : out Request_Record) is
    begin
        -- Just some defaults, awaiting implementation
        -- Probably some kind of byte-for-byte interface & state machine.

        Headers(1) := (header => UB.To_Unbounded_String("host")
                      ,value  => UB.To_Unbounded_String("my_host") );

        -- start-line = request-line / status-line
        -- request-line   = method SP request-target SP HTTP-version CRLF
        method_obtain(Data,Index,Method);
        Index := Ada.Streams.Stream_Element_Offset'Succ(Index);
        target_obtain(Data,Index,Target);

        Request := (method  => Method
                   ,path    => Target
                   ,version => http11
                   ,headers => Headers);

    end parse_request;

    procedure method_obtain(Data:Ada.Streams.Stream_Element_Array
                           ;Index: in out Ada.Streams.Stream_Element_Offset
                           ;Method: out Http_Method) is

        Line_Buffer : String(1..6) := "      ";
        --Pos : Integer Line_Buffer'Range;
        Pos : Integer range 0 .. 6 := 0;

    begin
        while Data(Index) /= 32 and Pos <= 6 loop
            Pos := Pos + 1;
            Line_Buffer(Pos) := Character'Val(Data(Index));
            Index := Ada.Streams.Stream_Element_Offset'Succ(Index);
        end loop;
        Method := Http_Method'Value(Line_Buffer);

    exception
        When CONSTRAINT_ERROR => Method := Get; -- No error handling yet. 501 (not implemented) ?

    end method_obtain;

    procedure target_obtain(Data   : Ada.Streams.Stream_Element_Array
                           ;Index  : in out Ada.Streams.Stream_Element_Offset
                           ;Target : out Request_Path) is 

        Max : Integer range 0 .. 256 := 0;
    begin
        Target := UB.To_Unbounded_String("");
        while Data(Index) /= 32 and Max <= 256 loop
            Max := Max + 1;
            UB.append(Target, Character'Val(Data(Index)));
            Index := Ada.Streams.Stream_Element_Offset'Succ(Index);
        end loop;
    end target_obtain;


    function image(Req:Request_Record) return String is
    begin
        return "-------------------------" & ASCII.LF
             & "Request details: " & ASCII.LF
             & "    Method is " & Http_Method'Image(Req.method) & ASCII.LF
             & "    Target is " & UB.To_String(Req.path) & ASCII.LF
             & "-------------------------";
    end image;

end the_parser;

