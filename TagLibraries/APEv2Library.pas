// ********************************************************************************************************************************
// *                                                                                                                              *
// *     APEv2 Library 1.0.6.8 © 3delite 2012-2015                                                                                *
// *     See APEv2 Library Readme.txt for details                                                                                 *
// *                                                                                                                              *
// * Two licenses are available for commercial usage of this component:                                                           *
// * Shareware License: €25                                                                                                       *
// * Commercial License: €100                                                                                                     *
// *                                                                                                                              *
// *     http://www.shareit.com/product.html?productid=300517941                                                                  *
// *                                                                                                                              *
// * Using the component in free programs is free.                                                                                *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
// *                                                                                                                              *
// * This component is also available as a part of Tags Library:                                                                  *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
// *                                                                                                                              *
// * There is also an ID3v2 Library available at:                                                                                 *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
// *                                                                                                                              *
// * and also an MP4 Tag Library available at:                                                                                    *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
// *                                                                                                                              *
// * and also an Ogg Vorbis and Opus Tag Library available at:                                                                    *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
// *                                                                                                                              *
// * a Flac Tag Library available at:                                                                                             *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
// *                                                                                                                              *
// * an WMA Tag Library available at:                                                                                             *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
// *                                                                                                                              *
// * For other Delphi components see the home page:                                                                               *
// *                                                                                                                              *
// *     http://www.3delite.hu/                                                                                                   *
// *                                                                                                                              *
// * If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
// *                                                                                                                              *
// * Good coding! :)                                                                                                              *
// * 3delite                                                                                                                      *
// ********************************************************************************************************************************

unit APEv2Library;

interface

Uses
  SysUtils,
  Classes;

Const
  APEv2LIBRARY_VERSION = $01000608;

Const
  APEV2LIBRARY_SUCCESS = 0;
  APEV2LIBRARY_ERROR = $FFFF;
  APEV2LIBRARY_ERROR_NO_TAG_FOUND = 1;
  APEV2LIBRARY_ERROR_EMPTY_TAG = 2;
  APEV2LIBRARY_ERROR_EMPTY_FRAMES = 3;
  APEV2LIBRARY_ERROR_OPENING_FILE = 4;
  APEV2LIBRARY_ERROR_READING_FILE = 5;
  APEV2LIBRARY_ERROR_WRITING_FILE = 6;
  APEV2LIBRARY_ERROR_CORRUPT = 7;
  APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION = 8;
  APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT = 9;

Const
  DEFAULT_UPPERCASE_FIELD_NAMES = True;

type
  TAPEv2ID = Array [1 .. 8] of Byte;
  TID3v1ID = Array [0 .. 2] of Byte;

type
  TAPEv2Header = packed record
    Version: Cardinal;
    TagSize: Cardinal;
    ItemCount: Cardinal;
    Flags: Cardinal;
    Reserved: Int64;
  end;

type
  TAPEv2PictureFormat = (pfUnknown, pfJPEG, pfPNG, pfBMP, pfGIF);

type
  TAPEv2FrameFormat = (ffUnknown, ffApeText, ffBinary);

type
  TAPEv2Tag = class;

  TAPEv2Frame = class
  private
  public
    Name: String;
    Format: TAPEv2FrameFormat;
    Stream: TMemoryStream;
    Index: Integer;
    Parent: TAPEv2Tag;
    Constructor Create(Parent: TAPEv2Tag);
    Destructor Destroy; override;
    function GetAsText: String;
    function SetAsText(Text: String): Boolean;
    function GetAsList(var List: TStrings): Boolean;
    function SetAsList(List: TStrings): Boolean;
    function IsCoverArt: Boolean;
    procedure Clear;
    function Assign(APEv2Frame: TAPEv2Frame): Boolean;
  end;

  TAPEv2Tag = class
  private
  public
    FileName: String;
    Loaded: Boolean;
    Version: Cardinal;
    Flags: Cardinal;
    Size: Cardinal;
    Frames: Array of TAPEv2Frame;
    UpperCaseFieldNamesToWrite: Boolean;
    Constructor Create;
    Destructor Destroy; override;
    function LoadFromFile(FileName: String): Integer;
    function LoadFromStream(TagStream: TStream): Integer;
    function SaveToFile(FileName: String): Integer;
    function SaveToStream(Stream: TStream): Integer;
    function AddFrame(Name: String): TAPEv2Frame;
    function DeleteFrame(FrameIndex: Integer): Boolean;
    procedure DeleteAllFrames;
    procedure DeleteAllCoverArts;
    procedure Clear;
    function Count: Integer;
    function CoverArtCount: Integer;
    function FrameExists(Name: String): Integer; overload;
    function FrameTypeCount(Name: String): Integer;
    function CalculateTotalFramesSize: Integer;
    function CalculateTagSize: Integer;
    function AddTextFrame(Name: String; Text: String): Integer;
    function AddBinaryFrame(Name: String; BinaryStream: TStream; Size: Integer): Integer;
    procedure SetTextFrameText(Name: String; Text: String);
    procedure SetListFrameText(Name: String; List: TStrings);
    function ReadFrameByNameAsText(Name: String): String;
    function ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
    procedure RemoveEmptyFrames;
    function AddCoverArtFrame(Name: String; PictureStream: TStream; Description: String): Integer;
    function SetCoverArtFrame(Index: Integer; PictureStream: TStream; Description: String): Boolean;
    function GetCoverArtFromFrame(Index: Integer; var PictureStream: TStream; var PictureFormat: TAPEv2PictureFormat; var Description: String): Boolean;
    function GetCoverArtInfo(Index: Integer; var PictureFormat: TAPEv2PictureFormat; var Description: String): Boolean;
    function GetCoverArtInfoPointer(Index: Integer; var PictureFormat: TAPEv2PictureFormat; var Description: Pointer; var Data: Pointer; var DataSize: Int64): Boolean;
    function DeleteFrameByName(Name: String): Boolean;
    function Assign(Source: TAPEv2Tag): Boolean;
  end;

function APEv2ValidTag(TagStream: TStream): Boolean;

function RemoveAPEv2FromFile(FileName: String): Integer;
function RemoveAPEv2FromStream(Stream: TStream): Integer;

function APEv2TagErrorCode2String(ErrorCode: Integer): String;

var
  APEv2ID: TAPEv2ID;
  ID3v1ID: TID3v1ID;
  APEv2TagLibraryDefaultUpperCaseFieldNamesToWrite: Boolean = DEFAULT_UPPERCASE_FIELD_NAMES;

implementation

// Uses
// Windows;

function Bytes2MB(Bytes: Int64): String;
var
  KB: Extended;
  MB: Extended;
  GB: Extended;
  TB: Extended;
  PB: Extended;
  EB: Extended;
  ZB: Extended;
  YB: Extended;
  KBD: Extended;
  MBD: Extended;
  GBD: Extended;
  TBD: Extended;
  PBD: Extended;
  EBD: Extended;
  ZBD: Extended;
  YBD: Extended;
begin
  {
    if Bytes > 1048576 then begin
    if Bytes > 1073741824
    then Result := FloatToStrF((Bytes / 1073741824), ffFixed, 4, 2) + ' GB'
    else Result := FloatToStrF((Bytes / 1048576), ffFixed, 4, 2) + ' MB';
    end else Result := FloatToStrF((Bytes / 1024), ffFixed, 4, 2) + ' KB';
    if Bytes < 1024
    then Result := IntToStr(Bytes) + ' Byte';
  }

  KB := 1024.0 * 1024.0;
  MB := 1024.0 * 1024.0 * 1024.0;
  GB := 1024.0 * 1024.0 * 1024.0 * 1024.0;
  TB := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  PB := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  EB := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  ZB := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  YB := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;

  KBD := 1024.0;
  MBD := 1024.0 * 1024.0;
  GBD := 1024.0 * 1024.0 * 1024.0;
  TBD := 1024.0 * 1024.0 * 1024.0 * 1024.0;
  PBD := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  EBD := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  ZBD := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;
  YBD := 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0;

  if Bytes < 1024 then
  begin
    Result := IntToStr(Bytes) + ' Byte';
  end
  else
  begin
    if Bytes < KB then
    begin
      Result := FloatToStrF((Bytes / KBD), ffFixed, 4, 2) + ' KB';
    end
    else
    begin
      if Bytes < MB then
      begin
        Result := FloatToStrF((Bytes / MBD), ffFixed, 4, 2) + ' MB';
      end
      else
      begin
        if Bytes < GB then
        begin
          Result := FloatToStrF((Bytes / GBD), ffFixed, 4, 2) + ' GB'
        end
        else
        begin
          if Bytes < TB then
          begin
            Result := FloatToStrF((Bytes / TBD), ffFixed, 4, 2) + ' TB'
          end
          else
          begin
            if Bytes < PB then
            begin
              Result := FloatToStrF((Bytes / PBD), ffFixed, 4, 2) + ' PB'
            end
            else
            begin
              if Bytes < EB then
              begin
                Result := FloatToStrF((Bytes / EBD), ffFixed, 4, 2) + ' EB'
              end
              else
              begin
                if Bytes < ZB then
                begin
                  Result := FloatToStrF((Bytes / ZBD), ffFixed, 4, 2) + ' ZB'
                end
                else
                begin
                  if Bytes < YB then
                  begin
                    Result := FloatToStrF((Bytes / YBD), ffFixed, 4, 2) + ' YB'
                  end
                  else
                  begin
                    Result := FloatToStrF((Bytes / YBD), ffFixed, 4, 2) + ' YB'
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

Constructor TAPEv2Frame.Create(Parent: TAPEv2Tag);
begin
  Inherited Create;
  Self.Parent := Parent;
  Name := '';
  // Flags := 0;
  Stream := TMemoryStream.Create;
  Format := ffUnknown;
end;

Destructor TAPEv2Frame.Destroy;
begin
  FreeAndNil(Stream);
  Inherited;
end;

function TAPEv2Frame.GetAsText: String;
var
  i: Integer;
  Data: Byte;
  Bytes: TBytes;
begin
  Result := '';
  if Format = ffBinary then
  begin
    Result := 'BINARY ' + Bytes2MB(Stream.Size);
  end
  else
  begin
    if Stream.Size < 1 then
    begin
      Exit;
    end;
    Stream.Seek(0, soBeginning);
    SetLength(Bytes, Stream.Size);
    for i := 0 to Stream.Size - 1 do
    begin
      Stream.Read(Data, 1);
      Bytes[i] := Data;
    end;
    Stream.Seek(0, soBeginning);
    Result := TEncoding.UTF8.GetString(Bytes);
    if Result = '' then
    begin
      Result := TEncoding.ANSI.GetString(Bytes);
    end;
  end;
end;

function TAPEv2Frame.SetAsText(Text: String): Boolean;
var
  Bytes: TBytes;
begin
  Bytes := TEncoding.UTF8.GetBytes(Text);
  if Length(Bytes) = 0 then
  begin
    Bytes := TEncoding.ANSI.GetBytes(Text);
  end;
  Stream.Clear;
  Stream.Write(Bytes[0], Length(Bytes));
  Stream.Seek(0, soBeginning);
  Format := ffApeText;
  Result := True;
end;

function TAPEv2Frame.SetAsList(List: TStrings): Boolean;
var
  i: Integer;
  Data: Byte;
  NameBytes: TBytes;
  ValueBytes: TBytes;
begin
  // if Format <> ffText then begin
  // Exit;
  // end;
  Stream.Clear;
  for i := 0 to List.Count - 1 do
  begin
    SetLength(NameBytes, 0);
    SetLength(ValueBytes, 0);
    NameBytes := TEncoding.UTF8.GetBytes(List.Names[i]);
    if Length(NameBytes) = 0 then
    begin
      NameBytes := TEncoding.ANSI.GetBytes(List.Names[i]);
    end;
    ValueBytes := TEncoding.UTF8.GetBytes(List.ValueFromIndex[i]);
    if Length(ValueBytes) = 0 then
    begin
      ValueBytes := TEncoding.ANSI.GetBytes(List.ValueFromIndex[i]);
    end;
    Stream.Write(NameBytes[0], Length(NameBytes));
    Data := $0D;
    Stream.Write(Data, 1);
    Data := $0A;
    Stream.Write(Data, 1);
    Stream.Write(ValueBytes[0], Length(ValueBytes));
    Data := $0D;
    Stream.Write(Data, 1);
    Data := $0A;
    Stream.Write(Data, 1);
  end;
  Stream.Seek(0, soBeginning);
  Format := ffApeText;
  Result := True;
end;

function TAPEv2Frame.GetAsList(var List: TStrings): Boolean;
var
  Data: Byte;
  Bytes: TBytes;
  Name: String;
  Value: String;
  ByteCounter: Integer;
begin
  Result := False;
  List.Clear;
  if Format <> ffApeText then
  begin
    Exit;
  end;
  Stream.Seek(0, soBeginning);
  while Stream.Position < Stream.Size do
  begin
    SetLength(Bytes, 0);
    ByteCounter := 0;
    repeat
      Stream.Read(Data, 1);
      if Data = $0D then
      begin
        Stream.Read(Data, 1);
        if Data = $0A then
        begin
          Break;
        end;
      end;
      SetLength(Bytes, Length(Bytes) + 1);
      Bytes[ByteCounter] := Data;
      Inc(ByteCounter);
    until Stream.Position >= Stream.Size;
    Name := TEncoding.UTF8.GetString(Bytes);
    if Name = '' then
    begin
      Name := TEncoding.ANSI.GetString(Bytes);
    end;
    SetLength(Bytes, 0);
    ByteCounter := 0;
    repeat
      Stream.Read(Data, 1);
      if Data = $0D then
      begin
        Stream.Read(Data, 1);
        if Data = $0A then
        begin
          Break;
        end;
      end;
      SetLength(Bytes, Length(Bytes) + 1);
      Bytes[ByteCounter] := Data;
      Inc(ByteCounter);
    until Stream.Position >= Stream.Size;
    Value := TEncoding.UTF8.GetString(Bytes);
    if Value = '' then
    begin
      Value := TEncoding.ANSI.GetString(Bytes);
    end;
    List.Append(Name + '=' + Value);
    Result := True;
  end;
  Stream.Seek(0, soBeginning);
end;

function TAPEv2Frame.IsCoverArt: Boolean;
var
  Bytes: TBytes;
  ByteCounter: Integer;
  DataSize: Cardinal;
  PPicture: PByte;
  Offset: Cardinal;
begin
  Result := False;
  if Format <> ffBinary then
  begin
    Exit;
  end;
  if SameText(Name, 'Cover Art (Front)') then
  begin
    Result := True;
    Exit;
  end;
  try
    try
      Offset := 0;
      DataSize := Stream.Size;
      PPicture := Stream.Memory;
      while Offset < DataSize do
      begin
        if Length(Bytes) = 0 then
        begin
          ByteCounter := 0;
          while (PPicture^ <> 0) AND (Offset < DataSize) do
          begin
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := PPicture^;
            Inc(ByteCounter);
            Inc(PPicture);
            Inc(Offset);
          end;
        end;
        // * JPEG
        if PPicture^ = $FF then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $D8 then
          begin
            // PictureFormat := pfJPEG;
            // Dec(PPicture);
            // Dec(Offset);
            Result := True;
            Break;
          end;
        end;
        // * PNG 89 50 4E 47 0D 0A 1A 0A
        if PPicture^ = $89 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $50 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $4E then
            begin
              Inc(PPicture);
              Inc(Offset);
              if PPicture^ = $47 then
              begin
                Inc(PPicture);
                Inc(Offset);
                if PPicture^ = $0D then
                begin
                  Inc(PPicture);
                  Inc(Offset);
                  if PPicture^ = $0A then
                  begin
                    Inc(PPicture);
                    Inc(Offset);
                    if PPicture^ = $1A then
                    begin
                      Inc(PPicture);
                      Inc(Offset);
                      if PPicture^ = $0A then
                      begin
                        // PictureFormat := pfPNG;
                        // Dec(PPicture, 7);
                        // Dec(Offset, 7);
                        Result := True;
                        Break;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        // * GIF 47 49 46 38
        if PPicture^ = $47 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $49 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $46 then
            begin
              Inc(PPicture);
              Inc(Offset);
              if PPicture^ = $38 then
              begin
                // PictureFormat := pfGIF;
                // Dec(PPicture, 3);
                // Dec(Offset, 3);
                Result := True;
                Break;
              end;
            end;
          end;
        end;
        // * BMP 42 4D
        if PPicture^ = $42 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $4D then
          begin
            // PictureFormat := pfBMP;
            // Dec(PPicture);
            // Dec(Offset);
            Result := True;
            Break;
          end;
        end;
        Inc(PPicture);
        Inc(Offset);
      end;
    finally
      // *
    end;
  except
    Result := False;
  end;
end;

procedure TAPEv2Frame.Clear;
begin
  Format := ffUnknown;
  // Flags := 0;
  Stream.Clear;
end;

function TAPEv2Frame.Assign(APEv2Frame: TAPEv2Frame): Boolean;
begin
  Result := False;
  Self.Clear;
  if APEv2Frame <> nil then
  begin
    Format := APEv2Frame.Format;
    // Flags := APEv2Frame.Flags;
    APEv2Frame.Stream.Seek(0, soBeginning);
    Stream.CopyFrom(APEv2Frame.Stream, APEv2Frame.Stream.Size);
    Stream.Seek(0, soBeginning);
    APEv2Frame.Stream.Seek(0, soBeginning);
    Result := True;
  end;
end;

Constructor TAPEv2Tag.Create;
begin
  Inherited;
  Clear;
  UpperCaseFieldNamesToWrite := APEv2TagLibraryDefaultUpperCaseFieldNamesToWrite;
end;

Destructor TAPEv2Tag.Destroy;
begin
  Clear;
  Inherited;
end;

procedure TAPEv2Tag.DeleteAllCoverArts;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
  begin
    if Frames[i].IsCoverArt then
    begin
      DeleteFrame(i);
    end;
  end;
end;

function TAPEv2Tag.CoverArtCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Count - 1 downto 0 do
  begin
    if Frames[i].IsCoverArt then
    begin
      Inc(Result);
    end;
  end;
end;

procedure TAPEv2Tag.DeleteAllFrames;
var
  i: Integer;
begin
  for i := 0 to Length(Frames) - 1 do
  begin
    FreeAndNil(Frames[i]);
  end;
  SetLength(Frames, 0);
end;

function TAPEv2Tag.LoadFromStream(TagStream: TStream): Integer;
var
  PreviousPosition: Int64;
  ReadID3v1ID: TID3v1ID;
  APEv2Header: TAPEv2Header;
  i: Integer;
  DataSize: Cardinal;
  DataFlags: Cardinal;
  Data: Byte;
  FrameName: String;
  Bytes: TBytes;
  ByteCounter: Integer;
begin
  Result := APEV2LIBRARY_ERROR;
  Loaded := False;
  Clear;
  try
    PreviousPosition := TagStream.Position;
    try
      // if NOT APEv2ValidTag(TagStream) then begin
      TagStream.Seek(-128, soEnd);
      TagStream.Read(ReadID3v1ID, 3);
      if (ReadID3v1ID[0] = ID3v1ID[0]) AND (ReadID3v1ID[1] = ID3v1ID[1]) AND (ReadID3v1ID[2] = ID3v1ID[2]) then
      begin
        TagStream.Seek(-32 - 128, soEnd);
      end
      else
      begin
        TagStream.Seek(-32, soEnd);
      end;
      if NOT APEv2ValidTag(TagStream) then
      begin
        Result := APEV2LIBRARY_ERROR_NO_TAG_FOUND;
        Exit;
      end;
      // end;
      if TagStream.Read(APEv2Header, SizeOf(TAPEv2Header)) <> SizeOf(TAPEv2Header) then
      begin
        Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
      end;
      Version := APEv2Header.Version;
      Flags := APEv2Header.Flags;
      Size := APEv2Header.TagSize;
      {
        if APEv2Header.Reserved <> 0 then begin
        Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
        end;
      }
      if (APEv2Header.Version <> 2000) then
      begin
        if (APEv2Header.Version <> 1000) then
        begin
          Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION;
          Exit;
        end;
      end;
      if APEv2Header.Flags AND NOT $80000001 <> 0 then
      begin
        Result := APEV2LIBRARY_ERROR_CORRUPT;
        Exit;
      end;
      TagStream.Seek(-APEv2Header.TagSize, soCurrent);
      for i := 0 to APEv2Header.ItemCount - 1 do
      begin
        FrameName := '';
        TagStream.Read(DataSize, 4);
        TagStream.Read(DataFlags, 4);
        if DataFlags AND NOT $7 <> 0 then
        begin
          Result := APEV2LIBRARY_ERROR_CORRUPT;
          // Exit;
        end;
        if DataSize > Size then
        begin
          Result := APEV2LIBRARY_ERROR_CORRUPT;
          Exit;
        end;
        SetLength(Bytes, 0);
        ByteCounter := 0;
        repeat
          TagStream.Read(Data, 1);
          if Data <> 0 then
          begin
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := Data;
            Inc(ByteCounter);
          end;
        until Data = 0;
        FrameName := TEncoding.UTF8.GetString(Bytes);
        if FrameName = '' then
        begin
          FrameName := TEncoding.ANSI.GetString(Bytes);
        end;
        case (DataFlags and $6) SHR 1 of
          0:
            begin
              with AddFrame(FrameName) do
              begin
                if DataSize > 0 then
                begin
                  Stream.CopyFrom(TagStream, DataSize);
                end;
                Format := ffApeText;
              end;
            end;
          1:
            begin
              with AddFrame(FrameName) do
              begin
                if DataSize > 0 then
                begin
                  Stream.CopyFrom(TagStream, DataSize);
                end;
                Format := ffBinary;
              end;
            end;
          // 2: unsupported feature
          3:
            begin
              Result := APEV2LIBRARY_ERROR_CORRUPT;
            end;
        end;
        Loaded := True;
      end;
    finally
      TagStream.Seek(PreviousPosition, soBeginning);
    end;
    Result := APEV2LIBRARY_SUCCESS;
  except
    if Result <> APEV2LIBRARY_ERROR_CORRUPT then
    begin
      Result := APEV2LIBRARY_ERROR;
    end;
  end;
end;

function TAPEv2Tag.LoadFromFile(FileName: String): Integer;
var
  FileStream: TFileStream;
begin
  Clear;
  Loaded := False;
  if NOT FileExists(FileName) then
  begin
    Result := APEV2LIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
  except
    Result := APEV2LIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    Result := LoadFromStream(FileStream);
    if (Result = APEV2LIBRARY_SUCCESS) OR (Result = APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION) then
    begin
      Self.FileName := FileName;
    end;
  finally
    FreeAndNil(FileStream);
  end;
end;

function TAPEv2Tag.AddFrame(Name: String): TAPEv2Frame;
begin
  Result := nil;
  try
    SetLength(Frames, Length(Frames) + 1);
    Frames[Length(Frames) - 1] := TAPEv2Frame.Create(Self);
    Frames[Length(Frames) - 1].Name := Name;
    Frames[Length(Frames) - 1].Index := Length(Frames) - 1;
    Result := Frames[Length(Frames) - 1];
  except
    // *
  end;
end;

function TAPEv2Tag.DeleteFrame(FrameIndex: Integer): Boolean;
var
  i: Integer;
  j: Integer;
begin
  Result := False;
  if (FrameIndex >= Length(Frames)) OR (FrameIndex < 0) then
  begin
    Exit;
  end;
  FreeAndNil(Frames[FrameIndex]);
  i := 0;
  j := 0;
  while i <= Length(Frames) - 1 do
  begin
    if Frames[i] <> nil then
    begin
      Frames[j] := Frames[i];
      Frames[j].Index := j;
      Inc(j);
    end;
    Inc(i);
  end;
  SetLength(Frames, j);
  Result := True;
end;

function TAPEv2Tag.FrameExists(Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Length(Frames) - 1 do
  begin
    if Name = Frames[i].Name then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TAPEv2Tag.FrameTypeCount(Name: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Length(Frames) - 1 do
  begin
    if UpperCase(Name) = UpperCase(Frames[i].Name) then
    begin
      Inc(Result);
    end;
  end;
end;

function TAPEv2Tag.SaveToFile(FileName: String): Integer;
var
  TagStream: TStream;
begin
  // Result := APEV2LIBRARY_ERROR;
  TagStream := nil;
  try
    try
      RemoveEmptyFrames;
      if Length(Frames) = 0 then
      begin
        Result := APEV2LIBRARY_ERROR_EMPTY_TAG;
        Exit;
      end;
      if CalculateTotalFramesSize = 0 then
      begin
        Result := APEV2LIBRARY_ERROR_EMPTY_FRAMES;
        Exit;
      end;
      if NOT FileExists(FileName) then
      begin
        TagStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite);
      end
      else
      begin
        TagStream := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite);
      end;
      Result := SaveToStream(TagStream);
    finally
      if Assigned(TagStream) then
      begin
        FreeAndNil(TagStream);
      end;
    end;
  except
    Result := APEV2LIBRARY_ERROR;
  end;
end;

function TAPEv2Tag.SaveToStream(Stream: TStream): Integer;
var
  // TagStream: TStream;
  ReadID3v1ID: TID3v1ID;
  APEv2Header: TAPEv2Header;
  ID3v1Stream: TMemoryStream;
  APEv2TagExists: Boolean;
  i: Integer;
  Bytes: TBytes;
  FrameSize: Cardinal;
  FrameFlags: Cardinal;
  Data: Byte;
begin
  // Result := APEV2LIBRARY_ERROR;
  APEv2TagExists := False;
  // Stream := nil;
  try
    try
      RemoveEmptyFrames;
      if Length(Frames) = 0 then
      begin
        Result := APEV2LIBRARY_ERROR_EMPTY_TAG;
        Exit;
      end;
      if CalculateTotalFramesSize = 0 then
      begin
        Result := APEV2LIBRARY_ERROR_EMPTY_FRAMES;
        Exit;
      end;
      ID3v1Stream := TMemoryStream.Create;
      if Stream.Size >= 128 then
      begin
        Stream.Seek(-128, soEnd);
        Stream.Read(ReadID3v1ID, 3);
      end;
      if (ReadID3v1ID[0] = ID3v1ID[0]) AND (ReadID3v1ID[1] = ID3v1ID[1]) AND (ReadID3v1ID[2] = ID3v1ID[2]) then
      begin
        Stream.Seek(-128, soEnd);
        ID3v1Stream.CopyFrom(Stream, 128);
        ID3v1Stream.Seek(0, soBeginning);
        Stream.Seek(-32 - 128, soEnd);
      end
      else
      begin
        Stream.Seek(-32, soEnd);
      end;
      if APEv2ValidTag(Stream) then
      begin
        APEv2TagExists := True;
      end;
      if NOT APEv2TagExists then
      begin
        if ID3v1Stream.Size <> 0 then
        begin
          Stream.Seek(-128, soEnd);
        end
        else
        begin
          Stream.Seek(0, soEnd);
        end;
      end
      else
      begin
        if ID3v1Stream.Size <> 0 then
        begin
          Stream.Seek(-24 - 128, soEnd);
        end
        else
        begin
          Stream.Seek(-24, soEnd);
        end;
        if Stream.Read(APEv2Header, SizeOf(TAPEv2Header)) <> SizeOf(TAPEv2Header) then
        begin
          Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
          Exit;
        end;
        if APEv2Header.Reserved <> 0 then
        begin
          Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
          Exit;
        end;
        if (APEv2Header.Version <> 2000) then
        begin
          if (APEv2Header.Version <> 1000) then
          begin
            Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION;
            Exit;
          end;
        end;
        if APEv2Header.Flags AND NOT $80000001 <> 0 then
        begin
          Result := APEV2LIBRARY_ERROR_CORRUPT;
          Exit;
        end;
        Stream.Seek(-APEv2Header.TagSize, soCurrent);
        Stream.Seek(-32, soCurrent);
      end;
      // * Do the write
      APEv2Header.Version := 2000;
      APEv2Header.TagSize := CalculateTagSize;
      APEv2Header.ItemCount := Length(Frames);
      APEv2Header.Flags := $A0000000;
      APEv2Header.Reserved := 0;
      Stream.Write(APEv2ID, 8);
      Stream.Write(APEv2Header, SizeOf(TAPEv2Header));
      for i := 0 to Length(Frames) - 1 do
      begin
        if UpperCaseFieldNamesToWrite then
        begin
          Bytes := TEncoding.UTF8.GetBytes(UpperCase(Frames[i].Name));
          if Length(Bytes) = 0 then
          begin
            Bytes := TEncoding.ANSI.GetBytes(UpperCase(Frames[i].Name));
          end;
        end
        else
        begin
          Bytes := TEncoding.UTF8.GetBytes(Frames[i].Name);
          if Length(Bytes) = 0 then
          begin
            Bytes := TEncoding.ANSI.GetBytes(Frames[i].Name);
          end;
        end;
        case Frames[i].Format of
          ffApeText:
            begin
              FrameFlags := 0;
            end;
          ffBinary:
            begin
              FrameFlags := $2;
            end;
        end;
        FrameSize := Frames[i].Stream.Size;
        Stream.Write(FrameSize, 4);
        Stream.Write(FrameFlags, 4);
        Stream.Write(Bytes[0], Length(Bytes));
        Data := $0;
        Stream.Write(Data, 1);
        Frames[i].Stream.Seek(0, soBeginning);
        Stream.CopyFrom(Frames[i].Stream, Frames[i].Stream.Size);
      end;
      Stream.Write(APEv2ID, 8);
      APEv2Header.Flags := $A0000000 AND NOT $20000000;
      Stream.Write(APEv2Header, SizeOf(TAPEv2Header));
      Stream.CopyFrom(ID3v1Stream, ID3v1Stream.Size);
      TFileStream(Stream).Size := Stream.Position;
      Result := APEV2LIBRARY_SUCCESS;
    finally
      if Assigned(ID3v1Stream) then
      begin
        FreeAndNil(ID3v1Stream);
      end;
    end;
  except
    Result := APEV2LIBRARY_ERROR;
  end;
end;

function TAPEv2Tag.CalculateTagSize: Integer;
var
  TotalTagSize: Integer;
begin
  TotalTagSize := CalculateTotalFramesSize;
  TotalTagSize := TotalTagSize + 8 + SizeOf(TAPEv2Header);
  Result := TotalTagSize;
end;

function TAPEv2Tag.CalculateTotalFramesSize: Integer;
var
  TotalFramesSize: Integer;
  i: Integer;
  Bytes: TBytes;
begin
  TotalFramesSize := 0;
  for i := 0 to Length(Frames) - 1 do
  begin
    Bytes := TEncoding.UTF8.GetBytes(Frames[i].Name);
    if Length(Bytes) = 0 then
    begin
      Bytes := TEncoding.ANSI.GetBytes(Frames[i].Name);
    end;
    TotalFramesSize := TotalFramesSize + Frames[i].Stream.Size + Length(Bytes) + 1 + 4 + 4;
  end;
  Result := TotalFramesSize;
end;

procedure TAPEv2Tag.Clear;
begin
  DeleteAllFrames;
  FileName := '';
  Loaded := False;
  Version := 0;
  Flags := 0;
  Size := 0;
end;

function TAPEv2Tag.Count: Integer;
begin
  Result := Length(Frames);
end;

function TAPEv2Tag.AddTextFrame(Name: String; Text: String): Integer;
begin
  with AddFrame(Name) do
  begin
    SetAsText(Text);
    Result := Index;
  end;
end;

function TAPEv2Tag.AddBinaryFrame(Name: String; BinaryStream: TStream; Size: Integer): Integer;
var
  PreviousPosition: Int64;
begin
  with AddFrame(Name) do
  begin
    PreviousPosition := BinaryStream.Position;
    Stream.CopyFrom(BinaryStream, Size);
    Format := ffBinary;
    BinaryStream.Seek(PreviousPosition, soBeginning);
    Result := Index;
  end;
end;

procedure TAPEv2Tag.SetTextFrameText(Name: String; Text: String);
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Frames);
  while (i < l) AND (UpperCase(Frames[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    AddTextFrame(Name, Text);
  end
  else
  begin
    Frames[i].SetAsText(Text);
  end;
end;

procedure TAPEv2Tag.SetListFrameText(Name: String; List: TStrings);
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Frames);
  while (i < l) AND (UpperCase(Frames[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    AddFrame(Name).SetAsList(List);
  end
  else
  begin
    Frames[i].SetAsList(List);
  end;
end;

function TAPEv2Tag.ReadFrameByNameAsText(Name: String): String;
var
  i: Integer;
  l: Integer;
begin
  Result := '';
  l := Length(Frames);
  i := 0;
  while (i <> l) AND (UpperCase(Frames[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := '';
  end
  else
  begin
    if Frames[i].Format = ffApeText then
    begin
      Result := Frames[i].GetAsText;
    end;
  end;
end;

function TAPEv2Tag.ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
var
  i: Integer;
  l: Integer;
begin
  Result := False;
  l := Length(Frames);
  i := 0;
  while (i <> l) AND (UpperCase(Frames[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := False;
  end
  else
  begin
    if Frames[i].Format = ffApeText then
    begin
      Result := Frames[i].GetAsList(List);
    end;
  end;
end;

procedure TAPEv2Tag.RemoveEmptyFrames;
var
  i: Integer;
begin
  for i := Length(Frames) - 1 downto 0 do
  begin
    if Frames[i].Stream.Size = 0 then
    begin
      DeleteFrame(i);
    end;
  end;
end;

function TAPEv2Tag.AddCoverArtFrame(Name: String; PictureStream: TStream; Description: String): Integer;
var
  Data: TMemoryStream;
  ZeroByte: Byte;
  Bytes: TBytes;
begin
  ZeroByte := 0;
  Data := TMemoryStream.Create;
  try
    Bytes := TEncoding.UTF8.GetBytes(Description);
    if Length(Bytes) = 0 then
    begin
      Bytes := TEncoding.ANSI.GetBytes(Description);
    end;
    Data.Write(Bytes[0], Length(Bytes));
    Data.Write(ZeroByte, 1);
    if Assigned(PictureStream) then
    begin
      PictureStream.Seek(0, soBeginning);
      Data.CopyFrom(PictureStream, PictureStream.Size);
      PictureStream.Seek(0, soBeginning);
    end;
    Data.Seek(0, soBeginning);
    Result := AddBinaryFrame(Name, Data, Data.Size);
  finally
    FreeAndNil(Data);
  end;
end;

function TAPEv2Tag.SetCoverArtFrame(Index: Integer; PictureStream: TStream; Description: String): Boolean;
var
  Data: TMemoryStream;
  ZeroByte: Byte;
  Bytes: TBytes;
begin
  Result := False;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  ZeroByte := 0;
  Data := TMemoryStream.Create;
  try
    Bytes := TEncoding.UTF8.GetBytes(Description);
    if Length(Bytes) = 0 then
    begin
      Bytes := TEncoding.ANSI.GetBytes(Description);
    end;
    Data.Write(Bytes[0], Length(Bytes));
    Data.Write(ZeroByte, 1);
    PictureStream.Seek(0, soBeginning);
    Data.CopyFrom(PictureStream, PictureStream.Size);
    Data.Seek(0, soBeginning);
    Frames[Index].Stream.Clear;
    Frames[Index].Stream.CopyFrom(Data, Data.Size);
    PictureStream.Seek(0, soBeginning);
    Result := True;
  finally
    FreeAndNil(Data);
  end;
end;

function TAPEv2Tag.GetCoverArtFromFrame(Index: Integer; var PictureStream: TStream; var PictureFormat: TAPEv2PictureFormat; var Description: String): Boolean;
var
  BinaryStream: TMemoryStream;
  DataSize: Cardinal;
  PPicture: PByte;
  Offset: Cardinal;
  Bytes: TBytes;
  ByteCounter: Integer;
begin
  Result := False;
  Description := '';
  PictureFormat := pfUnknown;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  try
    BinaryStream := TMemoryStream.Create;
    try
      Offset := 0;
      DataSize := Frames[Index].Stream.Size;
      PPicture := Frames[Index].Stream.Memory;
      while Offset < DataSize do
      begin
        if Length(Bytes) = 0 then
        begin
          ByteCounter := 0;
          while (PPicture^ <> 0) AND (Offset < DataSize) do
          begin
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := PPicture^;
            Inc(ByteCounter);
            Inc(PPicture);
            Inc(Offset);
          end;
        end;
        // * JPEG
        if PPicture^ = $FF then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $D8 then
          begin
            PictureFormat := pfJPEG;
            Dec(PPicture);
            Dec(Offset);
            Result := True;
            Break;
          end;
        end;
        // * PNG 89 50 4E 47 0D 0A 1A 0A
        if PPicture^ = $89 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $50 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $4E then
            begin
              Inc(PPicture);
              Inc(Offset);
              if PPicture^ = $47 then
              begin
                PictureFormat := pfPNG;
                Dec(PPicture, 3);
                Dec(Offset, 3);
                Result := True;
                Break;
              end;
            end;
          end;
        end;
        // * GIF 47 49 46 38
        if PPicture^ = $47 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $49 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $46 then
            begin
              Inc(PPicture);
              Inc(Offset);
              if PPicture^ = $38 then
              begin
                PictureFormat := pfGIF;
                Dec(PPicture, 3);
                Dec(Offset, 3);
                Result := True;
                Break;
              end;
            end;
          end;
        end;
        // * BMP 42 4D
        if PPicture^ = $42 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $4D then
          begin
            PictureFormat := pfBMP;
            Dec(PPicture);
            Dec(Offset);
            Result := True;
            Break;
          end;
        end;
        Inc(PPicture);
        Inc(Offset);
      end;
      BinaryStream.Write(PPicture^, DataSize - Offset);
      BinaryStream.Seek(0, soBeginning);
      PictureStream.CopyFrom(BinaryStream, PictureStream.Size);
      PictureStream.Seek(0, soBeginning);
      Description := TEncoding.UTF8.GetString(Bytes);
      if Description = '' then
      begin
        Description := TEncoding.ANSI.GetString(Bytes);
      end;
      if Result then
      begin
        // *
      end
      else
      begin
        Description := '';
      end;
    finally
      FreeAndNil(BinaryStream);
    end;
  except
    Result := False;
  end;
end;

function TAPEv2Tag.GetCoverArtInfo(Index: Integer; var PictureFormat: TAPEv2PictureFormat; var Description: String): Boolean;
var
  BinaryStream: TMemoryStream;
  DataSize: Cardinal;
  PPicture: PByte;
  Offset: Cardinal;
  Bytes: TBytes;
  ByteCounter: Integer;
begin
  Result := False;
  Description := '';
  PictureFormat := pfUnknown;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  try
    BinaryStream := TMemoryStream.Create;
    try
      Offset := 0;
      DataSize := Frames[Index].Stream.Size;
      PPicture := Frames[Index].Stream.Memory;
      while Offset < DataSize do
      begin
        if Length(Bytes) = 0 then
        begin
          ByteCounter := 0;
          while (PPicture^ <> 0) AND (Offset < DataSize) do
          begin
            SetLength(Bytes, Length(Bytes) + 1);
            Bytes[ByteCounter] := PPicture^;
            Inc(ByteCounter);
            Inc(PPicture);
            Inc(Offset);
          end;
        end;
        // * JPEG
        if PPicture^ = $FF then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $D8 then
          begin
            PictureFormat := pfJPEG;
            Dec(PPicture);
            Dec(Offset);
            Result := True;
            Break;
          end;
        end;
        // * PNG 89 50 4E 47 0D 0A 1A 0A
        if PPicture^ = $89 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $50 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $4E then
            begin
              Inc(PPicture);
              Inc(Offset);
              if PPicture^ = $47 then
              begin
                PictureFormat := pfPNG;
                Dec(PPicture, 3);
                Dec(Offset, 3);
                Result := True;
                Break;
              end;
            end;
          end;
        end;
        // * GIF 47 49 46 38
        if PPicture^ = $47 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $49 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $46 then
            begin
              Inc(PPicture);
              Inc(Offset);
              if PPicture^ = $38 then
              begin
                PictureFormat := pfGIF;
                Dec(PPicture, 3);
                Dec(Offset, 3);
                Result := True;
                Break;
              end;
            end;
          end;
        end;
        // * BMP 42 4D
        if PPicture^ = $42 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $4D then
          begin
            PictureFormat := pfBMP;
            Dec(PPicture);
            Dec(Offset);
            Result := True;
            Break;
          end;
        end;
        Inc(PPicture);
        Inc(Offset);
      end;
      BinaryStream.Write(PPicture^, DataSize - Offset);
      BinaryStream.Seek(0, soBeginning);
      Description := TEncoding.UTF8.GetString(Bytes);
      if Description = '' then
      begin
        Description := TEncoding.ANSI.GetString(Bytes);
      end;
      if Result then
      begin
        // *
      end
      else
      begin
        Description := '';
      end;
    finally
      FreeAndNil(BinaryStream);
    end;
  except
    Result := False;
  end;
end;

function TAPEv2Tag.GetCoverArtInfoPointer(Index: Integer; var PictureFormat: TAPEv2PictureFormat; var Description: Pointer; var Data: Pointer; var DataSize: Int64): Boolean;
var
  PPicture: PByte;
  Offset: Cardinal;
  Bytes: TBytes;
  ByteCounter: Integer;
begin
  Result := False;
  PictureFormat := pfUnknown;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  try
    Offset := 0;
    DataSize := Frames[Index].Stream.Size;
    PPicture := Frames[Index].Stream.Memory;
    Description := Frames[Index].Stream.Memory;
    while Offset < DataSize do
    begin
      if Length(Bytes) = 0 then
      begin
        ByteCounter := 0;
        while (PPicture^ <> 0) AND (Offset < DataSize) do
        begin
          SetLength(Bytes, Length(Bytes) + 1);
          Bytes[ByteCounter] := PPicture^;
          Inc(ByteCounter);
          Inc(PPicture);
          Inc(Offset);
        end;
      end;
      // * JPEG
      if PPicture^ = $FF then
      begin
        Inc(PPicture);
        Inc(Offset);
        if PPicture^ = $D8 then
        begin
          PictureFormat := pfJPEG;
          Dec(PPicture);
          Dec(Offset);
          Result := True;
          Break;
        end;
      end;
      // * PNG 89 50 4E 47 0D 0A 1A 0A
      if PPicture^ = $89 then
      begin
        Inc(PPicture);
        Inc(Offset);
        if PPicture^ = $50 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $4E then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $47 then
            begin
              PictureFormat := pfPNG;
              Dec(PPicture, 3);
              Dec(Offset, 3);
              Result := True;
              Break;
            end;
          end;
        end;
      end;
      // * GIF 47 49 46 38
      if PPicture^ = $47 then
      begin
        Inc(PPicture);
        Inc(Offset);
        if PPicture^ = $49 then
        begin
          Inc(PPicture);
          Inc(Offset);
          if PPicture^ = $46 then
          begin
            Inc(PPicture);
            Inc(Offset);
            if PPicture^ = $38 then
            begin
              PictureFormat := pfGIF;
              Dec(PPicture, 3);
              Dec(Offset, 3);
              Result := True;
              Break;
            end;
          end;
        end;
      end;
      // * BMP 42 4D
      if PPicture^ = $42 then
      begin
        Inc(PPicture);
        Inc(Offset);
        if PPicture^ = $4D then
        begin
          PictureFormat := pfBMP;
          Dec(PPicture);
          Dec(Offset);
          Result := True;
          Break;
        end;
      end;
      Inc(PPicture);
      Inc(Offset);
    end;
    Data := PPicture;
    DataSize := DataSize - Offset;
  except
    Result := False;
  end;
end;

function TAPEv2Tag.DeleteFrameByName(Name: String): Boolean;
var
  i: Integer;
  l: Integer;
  j: Integer;
begin
  l := Length(Frames);
  i := 0;
  while (i <> l) and (UpperCase(Frames[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := False;
    Exit;
  end;
  FreeAndNil(Frames[i]);
  i := 0;
  j := 0;
  while i <= l - 1 do
  begin
    if Frames[i] <> nil then
    begin
      Frames[j] := Frames[i];
      Inc(j);
    end;
    Inc(i);
  end;
  SetLength(Frames, j);
  Result := True;
end;

function TAPEv2Tag.Assign(Source: TAPEv2Tag): Boolean;
var
  i: Integer;
begin
  Clear;
  try
    FileName := Source.FileName;
    Loaded := Source.Loaded;
    Version := Source.Version;
    Flags := Source.Flags;
    Size := Source.Size;
    for i := 0 to Length(Source.Frames) - 1 do
    begin
      case Source.Frames[i].Format of
        ffApeText:
          begin
            SetTextFrameText(Source.Frames[i].Name, Source.Frames[i].GetAsText);
          end;
        ffBinary:
          begin
            Source.Frames[i].Stream.Seek(0, soBeginning);
            AddBinaryFrame(Source.Frames[i].Name, Source.Frames[i].Stream, Source.Frames[i].Stream.Size);
          end;
      end;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function APEv2ValidTag(TagStream: TStream): Boolean;
var
  Identification: TAPEv2ID;
begin
  Result := False;
  try
    FillChar(Identification, SizeOf(Identification), 0);
    TagStream.Read(Identification[1], 8);
    if (Identification[1] = APEv2ID[1]) AND (Identification[2] = APEv2ID[2]) AND (Identification[3] = APEv2ID[3]) AND (Identification[4] = APEv2ID[4]) AND (Identification[5] = APEv2ID[5]) AND
      (Identification[6] = APEv2ID[6]) AND (Identification[7] = APEv2ID[7]) AND (Identification[8] = APEv2ID[8]) then
    begin
      Result := True;
    end;
  except
    // *
  end;
end;

function RemoveAPEv2FromFile(FileName: String): Integer;
var
  TagStream: TStream;
  ReadID3v1ID: TID3v1ID;
  APEv2Header: TAPEv2Header;
  ID3v1Stream: TMemoryStream;
begin
  // Result := APEV2LIBRARY_ERROR;
  TagStream := nil;
  try
    try
      if NOT FileExists(FileName) then
      begin
        TagStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite);
      end
      else
      begin
        TagStream := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite);
      end;
      ID3v1Stream := TMemoryStream.Create;
      if TagStream.Size >= 128 then
      begin
        TagStream.Seek(-128, soEnd);
        TagStream.Read(ReadID3v1ID, 3);
      end;
      if (ReadID3v1ID[0] = ID3v1ID[0]) AND (ReadID3v1ID[1] = ID3v1ID[1]) AND (ReadID3v1ID[2] = ID3v1ID[2]) then
      begin
        TagStream.Seek(-128, soEnd);
        ID3v1Stream.CopyFrom(TagStream, 128);
        ID3v1Stream.Seek(0, soBeginning);
        TagStream.Seek(-32 - 128, soEnd);
      end
      else
      begin
        TagStream.Seek(-32, soEnd);
      end;
      if NOT APEv2ValidTag(TagStream) then
      begin
        Result := APEV2LIBRARY_ERROR_NO_TAG_FOUND;
        Exit;
      end;
      if ID3v1Stream.Size <> 0 then
      begin
        TagStream.Seek(-24 - 128, soEnd);
      end
      else
      begin
        TagStream.Seek(-24, soEnd);
      end;
      if TagStream.Read(APEv2Header, SizeOf(TAPEv2Header)) <> SizeOf(TAPEv2Header) then
      begin
        Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
      end;
      if APEv2Header.Reserved <> 0 then
      begin
        Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
      end;
      if (APEv2Header.Version <> 2000) then
      begin
        if (APEv2Header.Version <> 1000) then
        begin
          Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION;
          Exit;
        end;
      end;
      if APEv2Header.Flags AND NOT $80000001 <> 0 then
      begin
        Result := APEV2LIBRARY_ERROR_CORRUPT;
        Exit;
      end;
      TagStream.Seek(-APEv2Header.TagSize, soCurrent);
      TagStream.Seek(-32, soCurrent);
      TFileStream(TagStream).Size := TagStream.Position;
      TagStream.CopyFrom(ID3v1Stream, ID3v1Stream.Size);
      Result := APEV2LIBRARY_SUCCESS;
    finally
      if Assigned(TagStream) then
      begin
        FreeAndNil(TagStream);
      end;
      if Assigned(ID3v1Stream) then
      begin
        FreeAndNil(ID3v1Stream);
      end;
    end;
  except
    Result := APEV2LIBRARY_ERROR;
  end;
end;

function RemoveAPEv2FromStream(Stream: TStream): Integer;
var
  ReadID3v1ID: TID3v1ID;
  APEv2Header: TAPEv2Header;
  ID3v1Stream: TMemoryStream;
begin
  // Result := APEV2LIBRARY_ERROR;
  if Stream.Size = 0 then
  begin
    Result := APEV2LIBRARY_SUCCESS;
    Exit;
  end;
  try
    try
      ID3v1Stream := TMemoryStream.Create;
      if Stream.Size >= 128 then
      begin
        Stream.Seek(-128, soEnd);
        Stream.Read(ReadID3v1ID, 3);
      end;
      if (ReadID3v1ID[0] = ID3v1ID[0]) AND (ReadID3v1ID[1] = ID3v1ID[1]) AND (ReadID3v1ID[2] = ID3v1ID[2]) then
      begin
        Stream.Seek(-128, soEnd);
        ID3v1Stream.CopyFrom(Stream, 128);
        ID3v1Stream.Seek(0, soBeginning);
        Stream.Seek(-32 - 128, soEnd);
      end
      else
      begin
        Stream.Seek(-32, soEnd);
      end;
      if NOT APEv2ValidTag(Stream) then
      begin
        Result := APEV2LIBRARY_ERROR_NO_TAG_FOUND;
        Exit;
      end;
      if ID3v1Stream.Size <> 0 then
      begin
        Stream.Seek(-24 - 128, soEnd);
      end
      else
      begin
        Stream.Seek(-24, soEnd);
      end;
      if Stream.Read(APEv2Header, SizeOf(TAPEv2Header)) <> SizeOf(TAPEv2Header) then
      begin
        Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
      end;
      if APEv2Header.Reserved <> 0 then
      begin
        Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
      end;
      if (APEv2Header.Version <> 2000) then
      begin
        if (APEv2Header.Version <> 1000) then
        begin
          Result := APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION;
          Exit;
        end;
      end;
      if APEv2Header.Flags AND NOT $80000001 <> 0 then
      begin
        Result := APEV2LIBRARY_ERROR_CORRUPT;
        Exit;
      end;
      Stream.Seek(-APEv2Header.TagSize, soCurrent);
      Stream.Seek(-32, soCurrent);
      Stream.Size := Stream.Position;
      Stream.CopyFrom(ID3v1Stream, ID3v1Stream.Size);
      Stream.Seek(0, soBeginning);
      Result := APEV2LIBRARY_SUCCESS;
    finally
      if Assigned(ID3v1Stream) then
      begin
        FreeAndNil(ID3v1Stream);
      end;
    end;
  except
    Result := APEV2LIBRARY_ERROR;
  end;
end;

function APEv2TagErrorCode2String(ErrorCode: Integer): String;
begin
  Result := 'Unknown error code.';
  case ErrorCode of
    APEV2LIBRARY_SUCCESS:
      Result := 'Success.';
    APEV2LIBRARY_ERROR:
      Result := 'Unknown error occured.';
    APEV2LIBRARY_ERROR_NO_TAG_FOUND:
      Result := 'No APE(v2) tag found.';
    APEV2LIBRARY_ERROR_EMPTY_TAG:
      Result := 'APE(v2) tag is empty.';
    APEV2LIBRARY_ERROR_EMPTY_FRAMES:
      Result := 'APE(v2) tag contains only empty frames.';
    APEV2LIBRARY_ERROR_OPENING_FILE:
      Result := 'Error opening file.';
    APEV2LIBRARY_ERROR_READING_FILE:
      Result := 'Error reading file.';
    APEV2LIBRARY_ERROR_WRITING_FILE:
      Result := 'Error writing file.';
    APEV2LIBRARY_ERROR_CORRUPT:
      Result := 'Error: corrupt file.';
    // APEV2LIBRARY_ERROR_DOESNT_FIT: Result := 'Error: APE(v2) tag doesn''t fit into the file.';
    APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION:
      Result := 'Error: not supported APE tag version.';
    APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT:
      Result := 'Error: not supported file format.';
    // APEV2LIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := 'Error: file is locked. Need exclusive access to write APEv2 tag to this file.';
  end;
end;

Initialization

  APEv2ID[1] := Ord('A');
APEv2ID[2] := Ord('P');
APEv2ID[3] := Ord('E');
APEv2ID[4] := Ord('T');
APEv2ID[5] := Ord('A');
APEv2ID[6] := Ord('G');
APEv2ID[7] := Ord('E');
APEv2ID[8] := Ord('X');

ID3v1ID[0] := Ord('T');
ID3v1ID[1] := Ord('A');
ID3v1ID[2] := Ord('G');

end.
