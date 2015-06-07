//********************************************************************************************************************************
//*                                                                                                                              *
//*     ID3v1 Library 2.0.41.96 © 3delite 2010-2015                                                                              *
//*     See ID3v2 Library 2.0 ReadMe.txt for details                                                                             *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €50                                                                                                       *
//* Commercial License: €250                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300294127                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is an APEv2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
//*                                                                                                                              *
//* and an MP4 Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* and an Ogg Vorbis and Opus Tag Library available at:                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* and a Flac Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* and a WMA Tag Library available at:                                                                                          *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
//*                                                                                                                              *
//* and a WAV Tag Library available at:                                                                                          *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                         *
//*                                                                                                                              *
//* For other Delphi components see the home page:                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/                                                                                                   *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

unit ID3v1Library;

interface

Uses
    SysUtils,
    Classes;

{$MINENUMSIZE 4}

const
    ID3V1TAGSIZE = 128;

var
    ID3V1TAGID: Array[0..2] of Byte;
    ID3LYRICSTAGIDSTART: Array[1..11] of Byte;
    ID3LYRICSTAGIDEND: Array[1..9] of Byte;
    INDFieldID: Array [1..8] of Byte;

const
    ID3V1LIBRARY_SUCCESS            = 0;
    ID3V1LIBRARY_ERROR              = $FFFF;
    ID3V1LIBRARY_ERROR_OPENING_FILE = 3;
    ID3V1LIBRARY_ERROR_READING_FILE = 4;
    ID3V1LIBRARY_ERROR_WRITING_FILE = 5;

type
    TID3v1TagData = packed record
        Identifier: Array [0..2] of Byte;
        Title: Array [0..29] of Byte;
        Artist: Array [0..29] of Byte;
        Album: Array [0..29] of Byte;
        Year: Array [0..3] of Byte;
        Comment: Array [0..29] of Byte;
        Genre: Byte;
    end;

type
    TID3LyricsTagIDStart = Array [1..11] of Byte;
    TID3LyricsTagIDEnd = Array [1..9] of Byte;
    TID3LyricsTagSize = Array [1..6] of Byte;
    TID3LyricsFieldSize = Array [1..5] of Byte;

const
    ID3Genres: Array[0..147] of String = (
        { The following genres are defined in ID3v1 }
        'Blues',
        'Classic Rock',
        'Country',
        'Dance',
        'Disco',
        'Funk',
        'Grunge',
        'Hip-Hop',
        'Jazz',
        'Metal',
        'New Age',
        'Oldies',
        'Other',     { <= 12 Default }
        'Pop',
        'R&B',
        'Rap',
        'Reggae',
        'Rock',
        'Techno',
        'Industrial',
        'Alternative',
        'Ska',
        'Death Metal',
        'Pranks',
        'Soundtrack',
        'Euro-Techno',
        'Ambient',
        'Trip-Hop',
        'Vocal',
        'Jazz+Funk',
        'Fusion',
        'Trance',
        'Classical',
        'Instrumental',
        'Acid',
        'House',
        'Game',
        'Sound Clip',
        'Gospel',
        'Noise',
        'AlternRock',
        'Bass',
        'Soul',
        'Punk',
        'Space',
        'Meditative',
        'Instrumental Pop',
        'Instrumental Rock',
        'Ethnic',
        'Gothic',
        'Darkwave',
        'Techno-Industrial',
        'Electronic',
        'Pop-Folk',
        'Eurodance',
        'Dream',
        'Southern Rock',
        'Comedy',
        'Cult',
        'Gangsta',
        'Top 40',
        'Christian Rap',
        'Pop/Funk',
        'Jungle',
        'Native American',
        'Cabaret',
        'New Wave',
        'Psychedelic', // = 'Psychadelic' in ID3 docs, 'Psychedelic' in winamp.
        'Rave',
        'Showtunes',
        'Trailer',
        'Lo-Fi',
        'Tribal',
        'Acid Punk',
        'Acid Jazz',
        'Polka',
        'Retro',
        'Musical',
        'Rock & Roll',
        'Hard Rock',
        { The following genres are Winamp extensions }
        'Folk',
        'Folk-Rock',
        'National Folk',
        'Swing',
        'Fast Fusion',
        'Bebob',
        'Latin',
        'Revival',
        'Celtic',
        'Bluegrass',
        'Avantgarde',
        'Gothic Rock',
        'Progressive Rock',
        'Psychedelic Rock',
        'Symphonic Rock',
        'Slow Rock',
        'Big Band',
        'Chorus',
        'Easy Listening',
        'Acoustic',
        'Humour',
        'Speech',
        'Chanson',
        'Opera',
        'Chamber Music',
        'Sonata',
        'Symphony',
        'Booty Bass',
        'Primus',
        'Porn Groove',
        'Satire',
        'Slow Jam',
        'Club',
        'Tango',
        'Samba',
        'Folklore',
        'Ballad',
        'Power Ballad',
        'Rhythmic Soul',
        'Freestyle',
        'Duet',
        'Punk Rock',
        'Drum Solo',
        'A capella', // A Capella
        'Euro-House',
        'Dance Hall',
        { winamp ?? genres }
        'Goa',
        'Drum & Bass',
        'Club-House',
        'Hardcore',
        'Terror',
        'Indie',
        'BritPop',
        'Negerpunk',
        'Polsk Punk',
        'Beat',
        'Christian Gangsta Rap',
        'Heavy Metal',
        'Black Metal',
        'Crossover',
        'Contemporary Christian',
        'Christian Rock',
        { winamp 1.91 genres }
        'Merengue',
        'Salsa',
        'Trash Metal',
        { winamp 1.92 genres }
        'Anime',
        'JPop',
        'SynthPop'
    );

type
    TID3LyricsFrameID = Array [0..2] of Byte;

type
    TID3LyricsFrame = class
        ID: String;
        Data: String;
    end;

type
    TID3v1Tag = class
    private
        FLyricsTagSize: Cardinal;
    public
        FileName: String;
        Loaded: Boolean;
        Revision1: Boolean;
        Title: String;
        Artist: String;
        Album: String;
        Year: String;
        Comment: String;
        Track: Byte;
        TrackString: String;
        Genre: String;
        LyricsFrames: Array of TID3LyricsFrame;
        LyricsHasTimeStamp: Boolean;
        InhibitTracksForRandomSelection: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function LoadFromFile(FileName: String): Integer;
        function LoadFromStream(TagStream: TStream): Integer;
        function LoadFromMemory(MemoryAddress: Pointer): Integer;
        function SaveToFile(FileName: String; WriteLyricsTag: Boolean = False): Integer;
        function SaveToStream(var TagStream: TStream): Integer;
        function LoadLyricsTag(TagStream: TStream): Integer;
        function LyricsTagSaveToStream(TagStream: TStream): Integer;
        procedure Clear;
        function AddLyricsFrame(ID: String): TID3LyricsFrame;
        function DeleteLyricsFrame(Index: Integer): Boolean;
        function GetLyrics: String;
        procedure SetLyrics(Text: String);
        function FindLyricsFrame(ID: String): TID3LyricsFrame;
        property Lyrics: String read GetLyrics write SetLyrics;
        function Assign(Source: TID3v1Tag): Boolean;
        property LyricsSize: Cardinal read FLyricsTagSize;
    end;

    function Min(const B1, B2: Integer): Integer;

    procedure AnsiStringToPAnsiChar(const Source: String; Dest: PByte; const MaxLength: Integer);
    function PAnsiCharToAnsiString(P: PByte; MaxLength: Integer): String;

    function ID3GenreDataToString(GenreIndex: Byte): String;
    function ID3GenreStringToData(Genre: String): Byte;

    function RemoveID3v1TagFromFile(FileName: String): Integer;
    function RemoveID3v1TagFromStream(Stream: TStream): Integer;

    function ID3v1TagErrorCode2String(ErrorCode: Integer): String;

implementation

function Min(const B1, B2: Integer): Integer;
begin
    if B1 < B2 then begin
        Result := B1
    end else begin
        Result := B2;
    end;
end;

procedure AnsiStringToPAnsiChar(const Source: String; Dest: PByte; const MaxLength: Integer);
var
    Bytes: TBytes;
begin
    Bytes := TEncoding.ANSI.GetBytes(Source);
    Move(Bytes[0], Dest^, Min(MaxLength, Length(Bytes)));
end;


function PAnsiCharToAnsiString(P: PByte; MaxLength: Integer): String;
var
    Data: Byte;
    Counter: Integer;
    Bytes: TBytes;
begin
    Result := '';
    SetLength(Bytes, MaxLength);
    Counter := 0;
    repeat
        Data := P^;
        Bytes[Counter] := Data;
        Inc(P);
        Inc(Counter);
    until (Counter >= MaxLength)
    OR (Data = 0);
    if Data = 0 then begin
        SetLength(Bytes, Counter - 1);
    end else begin
        SetLength(Bytes, Counter);
    end;
    Result := Trim(StringOf(Bytes));
end;

Constructor TID3v1Tag.Create;
begin
    Inherited;
    Clear;
end;

function TID3v1Tag.DeleteLyricsFrame(Index: Integer): Boolean;
var
    i: Integer;
    j: Integer;
begin
    Result := False;
    if (Index >= Length(LyricsFrames))
    OR (Index < 0)
    then begin
        Exit;
    end;
    FreeAndNil(LyricsFrames[Index]);
    i := 0;
    j := 0;
    while i <= Length(LyricsFrames) - 1 do begin
        if LyricsFrames[i] <> nil then begin
            LyricsFrames[j] := LyricsFrames[i];
            Inc(j);
        end;
        Inc(i);
    end;
    SetLength(LyricsFrames, j);
    Result := True;
end;

Destructor TID3v1Tag.Destroy;
begin
    Inherited;
end;

function TID3v1Tag.FindLyricsFrame(ID: String): TID3LyricsFrame;
var
    i: Integer;
begin
    Result := nil;
    for i := 0 to Length(LyricsFrames) - 1 do begin
        if LyricsFrames[i].ID = ID then begin
            Result := LyricsFrames[i];
            Exit;
        end;
    end;
end;

function TID3v1Tag.AddLyricsFrame(ID: String): TID3LyricsFrame;
begin
    Result := nil;
    try
        SetLength(LyricsFrames, Length(LyricsFrames) + 1);
        LyricsFrames[Length(LyricsFrames) - 1] := TID3LyricsFrame.Create;
        LyricsFrames[Length(LyricsFrames) - 1].ID := ID;
        Result := LyricsFrames[Length(LyricsFrames) - 1];
    except
        //*
    end;
end;

function TID3v1Tag.Assign(Source: TID3v1Tag): Boolean;
var
    i: Integer;
begin
    Clear;
    FileName := Source.FileName;
    Loaded := Source.Loaded;
    Revision1 := Source.Revision1;
    Title := Source.Title;
    Artist := Source.Artist;
    Album := Source.Album;
    Year := Source.Year;
    Comment := Source.Comment;
    Track := Source.Track;
    Genre := Source.Genre;
    for i := 0 to Length(Source.LyricsFrames) - 1 do begin
        AddLyricsFrame(Source.LyricsFrames[i].ID).Data := Source.LyricsFrames[i].Data;
    end;
    LyricsHasTimeStamp := Source.LyricsHasTimeStamp;
    InhibitTracksForRandomSelection := Source.InhibitTracksForRandomSelection;
    Result := True;
end;

procedure TID3v1Tag.Clear;
var
    i: Integer;
begin
    FileName := '';
    Loaded := False;
    Revision1 := False;
    Title := '';
    Artist := '';
    Album := '';
    Year := '';
    Comment := '';
    Genre := '';
    Track := 0;
    TrackString := '';
    for i := Length(LyricsFrames) - 1 downto 0 do begin
        FreeAndNil(LyricsFrames[i]);
    end;
    SetLength(LyricsFrames, 0);
    FLyricsTagSize := 0;
end;

function TID3v1Tag.LoadFromFile(FileName: String): Integer;
var
    FileStream: TFileStream;
begin
    try
        Clear;
        Loaded := False;
        if NOT FileExists(FileName) then begin
            Result := ID3V1LIBRARY_ERROR_OPENING_FILE;
            Exit;
        end;
        FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
        try
            //FileStream.Seek(-ID3V1TAGSIZE, soEnd);
            Result := LoadFromStream(FileStream);
            if Result = ID3V1LIBRARY_SUCCESS then begin
                Self.FileName := FileName;
            end;
            LoadLyricsTag(FileStream);
        finally
            FreeAndNil(FileStream);
        end;
    except
        Result := ID3V1LIBRARY_ERROR;
    end;
end;

function TID3v1Tag.LoadFromStream(TagStream: TStream): Integer;
var
    TagData: TID3v1TagData;
begin
    Result := ID3V1LIBRARY_ERROR;
    Loaded := False;
    FillChar(TagData, SizeOf(TID3v1TagData), #0);
    try
        if TagStream.Size > ID3V1TAGSIZE then begin
            TagStream.Seek(- ID3V1TAGSIZE, soEnd);
        end else begin
            TagStream.Seek(0, soBeginning);
        end;
        TagStream.Read(TagData, ID3V1TAGSIZE);
        if (TagData.Identifier[0] <> ID3V1TAGID[0])
        OR (TagData.Identifier[1] <> ID3V1TAGID[1])
        OR (TagData.Identifier[2] <> ID3V1TAGID[2])
        then begin
            Exit;
        end;
        Title := PAnsiCharToAnsiString(@TagData.Title, 30);
        Artist := PAnsiCharToAnsiString(@TagData.Artist, 30);
        Album := PAnsiCharToAnsiString(@TagData.Album, 30);
        Year := PAnsiCharToAnsiString(@TagData.Year, 4);
        Comment := PAnsiCharToAnsiString(@TagData.Comment, 30);
        Genre := ID3GenreDataToString(TagData.Genre);
        if TagData.Comment[28] = 0 then begin
            Track := Byte(TagData.Comment[29]);
            TrackString := IntToStr(Track);
            Revision1 := True;
        end else begin
            Track := 0;
            TrackString := '';
            Revision1 := False;
        end;
        Loaded := True;
        Result := ID3V1LIBRARY_SUCCESS;
    except
        Clear;
        Result := ID3V1LIBRARY_ERROR_READING_FILE;
    end;
end;

function TID3v1Tag.LoadFromMemory(MemoryAddress: Pointer): Integer;
var
    DataStream: TMemoryStream;
begin
    Result := ID3V1LIBRARY_ERROR;
    if MemoryAddress <> nil then begin
        DataStream := TMemoryStream.Create;
        try
            DataStream.Write(MemoryAddress^, ID3V1TAGSIZE);
            DataStream.Seek(0, soBeginning);
            Result := LoadFromStream(DataStream);
        finally
            FreeAndNil(DataStream);
        end;
    end;
end;

function TID3v1Tag.LoadLyricsTag(TagStream: TStream): Integer;
var
    LyricsTagIDStart: TID3LyricsTagIDStart;
    LyricsTagIDEnd: TID3LyricsTagIDEnd;
    LyricsTagSize: TID3LyricsTagSize;
    //TagSize: Cardinal;
    FieldID: TID3LyricsFrameID;
    FieldIDString: String;
    LyricsFieldSize: TID3LyricsFieldSize;
    FieldSize: Cardinal;
    LyricsFrame: TID3LyricsFrame;
    i: Integer;
    Data: Byte;
begin
    Result := ID3V1LIBRARY_ERROR;
    TagStream.Seek(- (ID3V1TAGSIZE + 9), soFromEnd);
    TagStream.Read(LyricsTagIDEnd, SizeOf(TID3LyricsTagIDEnd));
    if (LyricsTagIDEnd[1] = ID3LYRICSTAGIDEND[1])
    AND (LyricsTagIDEnd[2] = ID3LYRICSTAGIDEND[2])
    AND (LyricsTagIDEnd[3] = ID3LYRICSTAGIDEND[3])
    AND (LyricsTagIDEnd[4] = ID3LYRICSTAGIDEND[4])
    AND (LyricsTagIDEnd[5] = ID3LYRICSTAGIDEND[5])
    AND (LyricsTagIDEnd[6] = ID3LYRICSTAGIDEND[6])
    AND (LyricsTagIDEnd[7] = ID3LYRICSTAGIDEND[7])
    AND (LyricsTagIDEnd[8] = ID3LYRICSTAGIDEND[8])
    AND (LyricsTagIDEnd[9] = ID3LYRICSTAGIDEND[9])
    then begin
        TagStream.Seek(- (ID3V1TAGSIZE + 9 + 6), soFromEnd);
        TagStream.Read(LyricsTagSize, SizeOf(TID3LyricsTagSize));
        FLyricsTagSize := StrToInt(Char(LyricsTagSize[1])
             + Char(LyricsTagSize[2])
             + Char(LyricsTagSize[3])
             + Char(LyricsTagSize[4])
             + Char(LyricsTagSize[5])
             + Char(LyricsTagSize[6])
             );
        TagStream.Seek(- (ID3V1TAGSIZE + 9 + 6 + FLyricsTagSize), soEnd);
        TagStream.Read(LyricsTagIDStart, SizeOf(TID3LyricsTagIDStart));
        if (LyricsTagIDStart[1] = ID3LYRICSTAGIDSTART[1])
        AND (LyricsTagIDStart[2] = ID3LYRICSTAGIDSTART[2])
        AND (LyricsTagIDStart[3] = ID3LYRICSTAGIDSTART[3])
        AND (LyricsTagIDStart[4] = ID3LYRICSTAGIDSTART[4])
        AND (LyricsTagIDStart[5] = ID3LYRICSTAGIDSTART[5])
        AND (LyricsTagIDStart[6] = ID3LYRICSTAGIDSTART[6])
        AND (LyricsTagIDStart[7] = ID3LYRICSTAGIDSTART[7])
        AND (LyricsTagIDStart[8] = ID3LYRICSTAGIDSTART[8])
        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
        then begin
            repeat
                TagStream.Read(FieldID, SizeOf(TID3LyricsFrameID));
                TagStream.Read(LyricsFieldSize, SizeOf(TID3LyricsFieldSize));
                FieldSize := StrToInt(Char(LyricsFieldSize[1])
                     + Char(LyricsFieldSize[2])
                     + Char(LyricsFieldSize[3])
                     + Char(LyricsFieldSize[4])
                     + Char(LyricsFieldSize[5])
                     );
                FieldIDString := Char(FieldID[0]) + Char(FieldID[1]) + Char(FieldID[2]);
                LyricsFrame := AddLyricsFrame(FieldIDString);
                for i := 0 to FieldSize - 1 do begin
                    TagStream.Read(Data, 1);
                    LyricsFrame.Data := LyricsFrame.Data + Char(Data);
                end;
                if FieldIDString = 'IND' then begin
                    LyricsHasTimeStamp := Copy(LyricsFrame.Data, 2, 1) = '1';
                    InhibitTracksForRandomSelection := Copy(LyricsFrame.Data, 3, 1) = '1';
                end;
                if FieldIDString = 'EAL' then begin
                    if Pos(Album, LyricsFrame.Data) > 0 then begin
                        Album := LyricsFrame.Data;
                    end;
                end;
                if FieldIDString = 'EAR' then begin
                    if Pos(Artist, LyricsFrame.Data) > 0 then begin
                        Artist := LyricsFrame.Data;
                    end;
                end;
                if FieldIDString = 'ETT' then begin
                    if Pos(Title, LyricsFrame.Data) > 0 then begin
                        Title := LyricsFrame.Data;
                    end;
                end;
                Result := ID3V1LIBRARY_SUCCESS;
            until TagStream.Position >= TagStream.Size - (ID3V1TAGSIZE + 9 + 6);
        end;
    end;
end;

function TID3v1Tag.LyricsTagSaveToStream(TagStream: TStream): Integer;

    function NumberToFieldSize(Value: Cardinal): TID3LyricsFieldSize;
    var
        Text: String;
    begin
        Text := IntToStr(Value);
        while Length(Text) < 5 do begin
            Text := '0' + Text;
        end;
        AnsiStringToPAnsiChar(Text, @Result, 5);
    end;

    function NumberToTagSize(Value: Cardinal): TID3LyricsTagSize;
    var
        Text: String;
    begin
        Text := IntToStr(Value);
        while Length(Text) < 6 do begin
            Text := '0' + Text;
        end;
        AnsiStringToPAnsiChar(Text, @Result, 6);
    end;

var
    LyricsTagIDStart: TID3LyricsTagIDStart;
    LyricsTagIDEnd: TID3LyricsTagIDEnd;
    LyricsTagSize: TID3LyricsTagSize;
    TagSize: Integer;
    LyricsFieldSize: TID3LyricsFieldSize;
    i: Integer;
    Data: Byte;
    LyricsFrameID: TID3LyricsFrameID;
    Bytes: TBytes;
begin
    try
        TagStream.Seek(- 9, soFromEnd);
        TagStream.Read(LyricsTagIDEnd, SizeOf(TID3LyricsTagIDEnd));
        if (LyricsTagIDEnd[1] = ID3LYRICSTAGIDEND[1])
        AND (LyricsTagIDEnd[2] = ID3LYRICSTAGIDEND[2])
        AND (LyricsTagIDEnd[3] = ID3LYRICSTAGIDEND[3])
        AND (LyricsTagIDEnd[4] = ID3LYRICSTAGIDEND[4])
        AND (LyricsTagIDEnd[5] = ID3LYRICSTAGIDEND[5])
        AND (LyricsTagIDEnd[6] = ID3LYRICSTAGIDEND[6])
        AND (LyricsTagIDEnd[7] = ID3LYRICSTAGIDEND[7])
        AND (LyricsTagIDEnd[8] = ID3LYRICSTAGIDEND[8])
        AND (LyricsTagIDEnd[9] = ID3LYRICSTAGIDEND[9])
        then begin
            TagStream.Seek(- (9 + 6), soFromEnd);
            TagStream.Read(LyricsTagSize, SizeOf(TID3LyricsTagSize));
            TagSize := StrToInt(Char(LyricsTagSize[1])
                 + Char(LyricsTagSize[2])
                 + Char(LyricsTagSize[3])
                 + Char(LyricsTagSize[4])
                 + Char(LyricsTagSize[5])
                 + Char(LyricsTagSize[6])
                 );
            TagStream.Seek(- (9 + 6 + TagSize), soEnd);
            TagStream.Read(LyricsTagIDStart, SizeOf(TID3LyricsTagIDStart));
            if (LyricsTagIDStart[1] = ID3LYRICSTAGIDSTART[1])
            AND (LyricsTagIDStart[2] = ID3LYRICSTAGIDSTART[2])
            AND (LyricsTagIDStart[3] = ID3LYRICSTAGIDSTART[3])
            AND (LyricsTagIDStart[4] = ID3LYRICSTAGIDSTART[4])
            AND (LyricsTagIDStart[5] = ID3LYRICSTAGIDSTART[5])
            AND (LyricsTagIDStart[6] = ID3LYRICSTAGIDSTART[6])
            AND (LyricsTagIDStart[7] = ID3LYRICSTAGIDSTART[7])
            AND (LyricsTagIDStart[8] = ID3LYRICSTAGIDSTART[8])
            AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
            AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
            AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
            then begin
                TagStream.Size := TagStream.Position - SizeOf(TID3LyricsTagIDStart);
            end;
        end;
        TagStream.Seek(0, soFromEnd);
        TagSize := 0;
        AnsiStringToPAnsiChar('LYRICSBEGIN', @LyricsTagIDStart, Length(ID3LYRICSTAGIDSTART));
        TagSize := TagSize + TagStream.Write(LyricsTagIDStart, Length(LyricsTagIDStart));
        TagSize := TagSize + TagStream.Write(INDFieldID[1], 8);
        if FindLyricsFrame('LYR') <> nil then begin
            Data := Ord('1');
        end else begin
            Data := Ord('0');
        end;
        TagSize := TagSize + TagStream.Write(Data, 1);
        if LyricsHasTimeStamp then begin
            Data := Ord('1');
        end else begin
            Data := Ord('0');
        end;
        TagSize := TagSize + TagStream.Write(Data, 1);
        if InhibitTracksForRandomSelection then begin
            Data := Ord('1');
        end else begin
            Data := Ord('0');
        end;
        TagSize := TagSize + TagStream.Write(Data, 1);
        for i := 0 to Length(LyricsFrames) - 1 do begin
            if Length(LyricsFrames[i].Data) = 0 then begin
                Continue;
            end;
            if LyricsFrames[i].ID = 'IND' then begin
                Continue;
            end;
            AnsiStringToPAnsiChar(LyricsFrames[i].ID, @LyricsFrameID, SizeOf(LyricsFrameID));
            TagSize := TagSize + TagStream.Write(LyricsFrameID[0], 3);
            if LyricsFrames[i].ID = 'EAL' then begin
                SetLength(Bytes, 0);
                Bytes := TEncoding.UTF8.GetBytes(Album);
                LyricsFieldSize := NumberToFieldSize(Length(Bytes));
                TagSize := TagSize + TagStream.Write(LyricsFieldSize, 5);
                TagSize := TagSize + TagStream.Write(Bytes[0], Length(Bytes));
                Continue;
            end;
            if LyricsFrames[i].ID = 'EAR' then begin
                SetLength(Bytes, 0);
                Bytes := TEncoding.UTF8.GetBytes(Artist);
                LyricsFieldSize := NumberToFieldSize(Length(Bytes));
                TagSize := TagSize + TagStream.Write(LyricsFieldSize, 5);
                TagSize := TagSize + TagStream.Write(Bytes[0], Length(Bytes));
                Continue;
            end;
            if LyricsFrames[i].ID = 'ETT' then begin
                SetLength(Bytes, 0);
                Bytes := TEncoding.UTF8.GetBytes(Title);
                LyricsFieldSize := NumberToFieldSize(Length(Bytes));
                TagSize := TagSize + TagStream.Write(LyricsFieldSize, 5);
                TagSize := TagSize + TagStream.Write(Bytes[0], Length(Bytes));
                Continue;
            end;
            SetLength(Bytes, 0);
            Bytes := TEncoding.UTF8.GetBytes(LyricsFrames[i].Data);
            LyricsFieldSize := NumberToFieldSize(Length(Bytes));
            TagSize := TagSize + TagStream.Write(LyricsFieldSize, 5);
            TagSize := TagSize + TagStream.Write(Bytes[0], Length(Bytes));
        end;
        LyricsTagSize := NumberToTagSize(TagSize);
        TagStream.Write(LyricsTagSize, 6);
        AnsiStringToPAnsiChar('LYRICS200', @LyricsTagIDEnd, Length(ID3LYRICSTAGIDEND));
        TagStream.Write(LyricsTagIDEnd, Length(LyricsTagIDEnd));
        Result := ID3V1LIBRARY_SUCCESS;
    except
        Result := ID3V1LIBRARY_ERROR;
    end;
end;

function TID3v1Tag.GetLyrics: String;
var
    i: Integer;
begin
    Result := '';
    for i := 0 to Length(LyricsFrames) - 1 do begin
        if LyricsFrames[i].ID = 'LYR' then begin
            Result := LyricsFrames[i].Data;
        end;
    end;
end;

procedure TID3v1Tag.SetLyrics(Text: String);
var
    i: Integer;
begin
    for i := 0 to Length(LyricsFrames) - 1 do begin
        if LyricsFrames[i].ID = 'LYR' then begin
            if Text <> '' then begin
                LyricsFrames[i].Data := Text;
            end else begin
                DeleteLyricsFrame(i);
            end;
            Exit;
        end;
    end;
    if Text <> '' then begin
        AddLyricsFrame('LYR').Data := Text;
    end;
end;

function TID3v1Tag.SaveToFile(FileName: String; WriteLyricsTag: Boolean = False): Integer;
var
    FileStream: TStream;
begin
    try
        if WriteLyricsTag then begin
            RemoveID3v1TagFromFile(FileName);
        end;
        if FileExists(FileName) then begin
            FileStream := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite);
        end else begin
            FileStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite);
        end;
    except
        Result := ID3V1LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        if WriteLyricsTag then begin
            LyricsTagSaveToStream(FileStream);
        end;
        FileStream.Seek(-ID3V1TAGSIZE, soEnd);
        Result := SaveToStream(FileStream);
        if Result = ID3V1LIBRARY_SUCCESS then begin
            Self.FileName := FileName;
        end;
    finally
        FreeAndNil(FileStream);
    end;
end;

function TID3v1Tag.SaveToStream(var TagStream: TStream): Integer;
var
    TagData: TID3v1TagData;
begin
    FillChar(TagData, SizeOf(TID3v1TagData), #0);
    try
        if TagStream.Size > ID3V1TAGSIZE then begin
            TagStream.Seek(- ID3V1TAGSIZE, soEnd);
        end else begin
            TagStream.Seek(0, soBeginning);
        end;
        TagStream.Read(TagData, ID3V1TAGSIZE);
    except
        Result := ID3V1LIBRARY_ERROR_READING_FILE;
        Exit;
    end;
    try
        if (TagData.Identifier[0] = ID3V1TAGID[0])
        AND (TagData.Identifier[1] = ID3V1TAGID[1])
        AND (TagData.Identifier[2] = ID3V1TAGID[2])
        then begin
            TagStream.Seek(- ID3V1TAGSIZE, soCurrent);
        end else begin
            TagStream.Seek(0, soEnd);
        end;
        FillChar(TagData, SizeOf(TID3v1TagData), #0);
        Move(ID3V1TAGID[0], TagData.Identifier[0], 3);
        AnsiStringToPAnsiChar(Title, @TagData.Title, 30);
        AnsiStringToPAnsiChar(Artist, @TagData.Artist, 30);
        AnsiStringToPAnsiChar(Album, @TagData.Album, 30);
        AnsiStringToPAnsiChar(Year, @TagData.Year, 4);
        AnsiStringToPAnsiChar(Comment, @TagData.Comment, 30);
        TagData.Genre := ID3GenreStringToData(Genre);
        if TagData.Comment[28] = 0 then begin
            TagData.Comment[29] := Byte(Track);
        end;
        TagStream.Write(TagData, ID3V1TAGSIZE);
        Result := ID3V1LIBRARY_SUCCESS;
    except
        Result := ID3V1LIBRARY_ERROR_WRITING_FILE;
    end;
end;

function ID3GenreDataToString(GenreIndex: Byte): String;
begin
    if GenreIndex < 148 then begin
        Result := ID3Genres[GenreIndex];
    end else begin
        Result := ID3Genres[12];
    end;
end;

function ID3GenreStringToData(Genre: String): Byte;
var
    i: Integer;
    GenreString: String;
begin
    Result := 12;
    GenreString := Genre;
    if GenreString = 'Psychadelic' then begin
        GenreString := 'Psychedelic';
    end;
    for i := 0 to Length(ID3Genres) - 1 do begin
        if GenreString = ID3Genres[i] then begin
            Result := i;
            Break;
        end;
    end;
end;

function RemoveID3v1TagFromFile(FileName: String): Integer;
var
    AudioFile: TFileStream;
    DataByte: Byte;
    LyricsTagIDStart: TID3LyricsTagIDStart;
    LyricsTagIDEnd: TID3LyricsTagIDEnd;
    LyricsTagSize: TID3LyricsTagSize;
    TagSize: Integer;
begin
    Result := ID3V1LIBRARY_ERROR;
    if NOT FileExists(FileName) then begin
        Exit;
    end;
    try
        try
            AudioFile := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite);
        except
            Result := ID3V1LIBRARY_ERROR_OPENING_FILE;
            Exit;
        end;
        if AudioFile.Size < ID3V1TAGSIZE then begin
            Exit;
        end;
        AudioFile.Seek(- ID3V1TAGSIZE, soEnd);
        AudioFile.Read(DataByte, 1);
        if DataByte = Ord('T') then begin
            AudioFile.Read(DataByte, 1);
            if DataByte = Ord('A') then begin
                AudioFile.Read(DataByte, 1);
                if DataByte = Ord('G') then begin
                    AudioFile.Seek(- (ID3V1TAGSIZE + 9), soFromEnd);
                    AudioFile.Read(LyricsTagIDEnd, SizeOf(TID3LyricsTagIDEnd));
                    if (LyricsTagIDEnd[1] = ID3LYRICSTAGIDEND[1])
                    AND (LyricsTagIDEnd[2] = ID3LYRICSTAGIDEND[2])
                    AND (LyricsTagIDEnd[3] = ID3LYRICSTAGIDEND[3])
                    AND (LyricsTagIDEnd[4] = ID3LYRICSTAGIDEND[4])
                    AND (LyricsTagIDEnd[5] = ID3LYRICSTAGIDEND[5])
                    AND (LyricsTagIDEnd[6] = ID3LYRICSTAGIDEND[6])
                    AND (LyricsTagIDEnd[7] = ID3LYRICSTAGIDEND[7])
                    AND (LyricsTagIDEnd[8] = ID3LYRICSTAGIDEND[8])
                    AND (LyricsTagIDEnd[9] = ID3LYRICSTAGIDEND[9])
                    then begin
                        AudioFile.Seek(- (ID3V1TAGSIZE + 9 + 6), soFromEnd);
                        AudioFile.Read(LyricsTagSize, SizeOf(TID3LyricsTagSize));
                        TagSize := StrToInt(Char(LyricsTagSize[1])
                             + Char(LyricsTagSize[2])
                             + Char(LyricsTagSize[3])
                             + Char(LyricsTagSize[4])
                             + Char(LyricsTagSize[5])
                             + Char(LyricsTagSize[6])
                             );
                        AudioFile.Seek(- (ID3V1TAGSIZE + 9 + 6 + TagSize), soFromEnd);
                        AudioFile.Read(LyricsTagIDStart, SizeOf(TID3LyricsTagIDStart));
                        if (LyricsTagIDStart[1] = ID3LYRICSTAGIDSTART[1])
                        AND (LyricsTagIDStart[2] = ID3LYRICSTAGIDSTART[2])
                        AND (LyricsTagIDStart[3] = ID3LYRICSTAGIDSTART[3])
                        AND (LyricsTagIDStart[4] = ID3LYRICSTAGIDSTART[4])
                        AND (LyricsTagIDStart[5] = ID3LYRICSTAGIDSTART[5])
                        AND (LyricsTagIDStart[6] = ID3LYRICSTAGIDSTART[6])
                        AND (LyricsTagIDStart[7] = ID3LYRICSTAGIDSTART[7])
                        AND (LyricsTagIDStart[8] = ID3LYRICSTAGIDSTART[8])
                        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
                        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
                        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
                        then begin
                            AudioFile.Seek(- (ID3V1TAGSIZE + 9 + 6 + TagSize), soFromEnd);
                            AudioFile.Size := AudioFile.Position;
                        end;
                    end else begin
                        AudioFile.Seek(- ID3V1TAGSIZE, soEnd);
                        AudioFile.Size := AudioFile.Position;
                    end;
                    Result := ID3V1LIBRARY_SUCCESS;
                end;
            end;
        end;
        if AudioFile <> nil then begin
            FreeAndNil(AudioFile);
        end;
    except
        Result := ID3V1LIBRARY_ERROR;
    end;
end;

function RemoveID3v1TagFromStream(Stream: TStream): Integer;
var
    DataByte: Byte;
    LyricsTagIDStart: TID3LyricsTagIDStart;
    LyricsTagIDEnd: TID3LyricsTagIDEnd;
    LyricsTagSize: TID3LyricsTagSize;
    TagSize: Integer;
begin
    Result := ID3V1LIBRARY_ERROR;
    try
        if Stream.Size < ID3V1TAGSIZE then begin
            Exit;
        end;
        Stream.Seek(- ID3V1TAGSIZE, soEnd);
        Stream.Read(DataByte, 1);
        if DataByte = Ord('T') then begin
            Stream.Read(DataByte, 1);
            if DataByte = Ord('A') then begin
                Stream.Read(DataByte, 1);
                if DataByte = Ord('G') then begin
                    Stream.Seek(- (ID3V1TAGSIZE + 9), soFromEnd);
                    Stream.Read(LyricsTagIDEnd, SizeOf(TID3LyricsTagIDEnd));
                    if (LyricsTagIDEnd[1] = ID3LYRICSTAGIDEND[1])
                    AND (LyricsTagIDEnd[2] = ID3LYRICSTAGIDEND[2])
                    AND (LyricsTagIDEnd[3] = ID3LYRICSTAGIDEND[3])
                    AND (LyricsTagIDEnd[4] = ID3LYRICSTAGIDEND[4])
                    AND (LyricsTagIDEnd[5] = ID3LYRICSTAGIDEND[5])
                    AND (LyricsTagIDEnd[6] = ID3LYRICSTAGIDEND[6])
                    AND (LyricsTagIDEnd[7] = ID3LYRICSTAGIDEND[7])
                    AND (LyricsTagIDEnd[8] = ID3LYRICSTAGIDEND[8])
                    AND (LyricsTagIDEnd[9] = ID3LYRICSTAGIDEND[9])
                    then begin
                        Stream.Seek(- (ID3V1TAGSIZE + 9 + 6), soFromEnd);
                        Stream.Read(LyricsTagSize, SizeOf(TID3LyricsTagSize));
                        TagSize := StrToInt(Char(LyricsTagSize[1])
                             + Char(LyricsTagSize[2])
                             + Char(LyricsTagSize[3])
                             + Char(LyricsTagSize[4])
                             + Char(LyricsTagSize[5])
                             + Char(LyricsTagSize[6])
                             );
                        Stream.Seek(- (ID3V1TAGSIZE + 9 + 6 + TagSize), soFromEnd);
                        Stream.Read(LyricsTagIDStart, SizeOf(TID3LyricsTagIDStart));
                        if (LyricsTagIDStart[1] = ID3LYRICSTAGIDSTART[1])
                        AND (LyricsTagIDStart[2] = ID3LYRICSTAGIDSTART[2])
                        AND (LyricsTagIDStart[3] = ID3LYRICSTAGIDSTART[3])
                        AND (LyricsTagIDStart[4] = ID3LYRICSTAGIDSTART[4])
                        AND (LyricsTagIDStart[5] = ID3LYRICSTAGIDSTART[5])
                        AND (LyricsTagIDStart[6] = ID3LYRICSTAGIDSTART[6])
                        AND (LyricsTagIDStart[7] = ID3LYRICSTAGIDSTART[7])
                        AND (LyricsTagIDStart[8] = ID3LYRICSTAGIDSTART[8])
                        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
                        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
                        AND (LyricsTagIDStart[9] = ID3LYRICSTAGIDSTART[9])
                        then begin
                            Stream.Seek(- (ID3V1TAGSIZE + 9 + 6 + TagSize), soFromEnd);
                            Stream.Size := Stream.Position;
                        end;
                    end else begin
                        Stream.Seek(- ID3V1TAGSIZE, soEnd);
                        Stream.Size := Stream.Position;
                    end;
                    Result := ID3V1LIBRARY_SUCCESS;
                end;
            end;
        end;
    except
        Result := ID3V1LIBRARY_ERROR;
    end;
end;

function ID3v1TagErrorCode2String(ErrorCode: Integer): String;
begin
    Result := 'Unknown error code.';
    case ErrorCode of
        ID3V1LIBRARY_SUCCESS: Result := 'Success.';
        ID3V1LIBRARY_ERROR: Result := 'Unknown error occured.';
        ID3V1LIBRARY_ERROR_OPENING_FILE: Result := 'Error opening file.';
        ID3V1LIBRARY_ERROR_READING_FILE: Result := 'Error reading file.';
        ID3V1LIBRARY_ERROR_WRITING_FILE: Result := 'Error writing file.';
    end;
end;

Initialization

    ID3V1TAGID[0] := Ord('T');
    ID3V1TAGID[1] := Ord('A');
    ID3V1TAGID[2] := Ord('G');

    ID3LYRICSTAGIDSTART[1] := Ord('L');
    ID3LYRICSTAGIDSTART[2] := Ord('Y');
    ID3LYRICSTAGIDSTART[3] := Ord('R');
    ID3LYRICSTAGIDSTART[4] := Ord('I');
    ID3LYRICSTAGIDSTART[5] := Ord('C');
    ID3LYRICSTAGIDSTART[6] := Ord('S');
    ID3LYRICSTAGIDSTART[7] := Ord('B');
    ID3LYRICSTAGIDSTART[8] := Ord('E');
    ID3LYRICSTAGIDSTART[9] := Ord('G');
    ID3LYRICSTAGIDSTART[10] := Ord('I');
    ID3LYRICSTAGIDSTART[11] := Ord('N');


    ID3LYRICSTAGIDEND[1] := Ord('L');
    ID3LYRICSTAGIDEND[2] := Ord('Y');
    ID3LYRICSTAGIDEND[3] := Ord('R');
    ID3LYRICSTAGIDEND[4] := Ord('I');
    ID3LYRICSTAGIDEND[5] := Ord('C');
    ID3LYRICSTAGIDEND[6] := Ord('S');
    ID3LYRICSTAGIDEND[7] := Ord('2');
    ID3LYRICSTAGIDEND[8] := Ord('0');
    ID3LYRICSTAGIDEND[9] := Ord('0');

    INDFieldID[1] := Ord('I');
    INDFieldID[2] := Ord('N');
    INDFieldID[3] := Ord('D');
    INDFieldID[4] := Ord('0');
    INDFieldID[5] := Ord('0');
    INDFieldID[6] := Ord('0');
    INDFieldID[7] := Ord('0');
    INDFieldID[8] := Ord('3');

end.



