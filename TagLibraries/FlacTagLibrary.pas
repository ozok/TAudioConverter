// ********************************************************************************************************************************
// *                                                                                                                              *
// *     Flac Tag Library 2.0.14.38 © 3delite 2013-2015                                                                           *
// *     See Flac Tag Library Readme.txt for details                                                                              *
// *                                                                                                                              *
// * This unit is based on ATL's FlacFile class but many new features were added, specially full support for managing cover arts, *
// * support of Ogg Flac files and Delphi XE5 mobile platform target support.                                                     *
// * As the original unit is LGPL licensed you are entitled to use it for free given the LGPL license terms.                      *
// * If you are using the cover art managing functions (read and/or write) and/or Ogg Flac functions you can use it for free for  *
// * free programs/projects but for shareware or commerical programs you need one of the following licenses:                      *
// * Shareware License: €25                                                                                                       *
// * Commercial License: €100                                                                                                     *
// *                                                                                                                              *
// *     http://www.shareit.com/product.html?productid=300576722                                                                  *
// *                                                                                                                              *
// * Using the component in free programs is free.                                                                                *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
// *                                                                                                                              *
// * This component is also available as a part of Tags Library:                                                                  *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
// *                                                                                                                              *
// * There is also an ID3v2 Library available at:                                                                                 *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
// *                                                                                                                              *
// * an APEv2 Library available at:                                                                                               *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
// *                                                                                                                              *
// * an MP4 Tag Library available at:                                                                                             *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
// *                                                                                                                              *
// * and an Ogg Vorbis and Opus Tag Library available at:                                                                    *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
// *                                                                                                                              *
// * and a WMA Tag Library available at:                                                                                     *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
// *                                                                                                                              *
// * and a WAV Tag Library available at:                                                                                     *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                         *
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

{ *************************************************************************** }
{ }
{ Audio Tools Library }
{ Class TFLACfile - for manipulating with FLAC file information }
{ }
{ http://mac.sourceforge.net/atl/ }
{ e-mail: macteam@users.sourceforge.net }
{ }
{ Copyright (c) 2000-2002 by Jurgen Faul }
{ Copyright (c) 2003-2005 by The MAC Team }
{ Copyright (c) 2013 by 3delite }
{ }
{ Version 2.0 (February 2013) by 3delite }
{ - removed TNT and ATLCommon dependency (now the unit is stand alone) }
{ - fixed writing to files with ID3v2 tags }
{ - converted program logic to handle all tags easily }
{ - added full support for managing cover arts }
{ - support for Win64 and OSX build mode }
{ }
{ Version 1.4 (April 2005) by Gambit }
{ - updated to unicode file access }
{ }
{ Version 1.3 (13 August 2004) by jtclipper }
{ - unit rewritten, VorbisComment is obsolete now }
{ }
{ Version 1.2 (23 June 2004) by sundance }
{ - Check for ID3 tags (although not supported) }
{ - Don't parse for other FLAC metablocks if FLAC header is missing }
{ }
{ Version 1.1 (6 July 2003) by Erik }
{ - Class: Vorbis comments (native comment to FLAC files) added }
{ }
{ Version 1.0 (13 August 2002) }
{ - Info: channels, sample rate, bits/sample, file size, duration, ratio }
{ - Class TID3v1: reading & writing support for ID3v1 tags }
{ - Class TID3v2: reading & writing support for ID3v2 tags }
{ }
{ This library is free software; you can redistribute it and/or }
{ modify it under the terms of the GNU Lesser General Public }
{ License as published by the Free Software Foundation; either }
{ version 2.1 of the License, or (at your option) any later version. }
{ }
{ This library is distributed in the hope that it will be useful, }
{ but WITHOUT ANY WARRANTY; without even the implied warranty of }
{ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU }
{ Lesser General Public License for more details. }
{ }
{ You should have received a copy of the GNU Lesser General Public }
{ License along with this library; if not, write to the Free Software }
{ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA }
{ }
{ *************************************************************************** }

unit FlacTagLibrary;

interface

Uses
  Classes,
  SysUtils,
  StrUtils;

Const
  FLACTAGLIBRARY_SUCCESS = 0;
  FLACTAGLIBRARY_ERROR = $FFFF;
  FLACTAGLIBRARY_ERROR_NO_TAG_FOUND = 1;
  FLACTAGLIBRARY_ERROR_EMPTY_TAG = 2;
  FLACTAGLIBRARY_ERROR_EMPTY_FRAMES = 3;
  FLACTAGLIBRARY_ERROR_OPENING_FILE = 4;
  FLACTAGLIBRARY_ERROR_READING_FILE = 5;
  FLACTAGLIBRARY_ERROR_WRITING_FILE = 6;
  FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION = 7;
  FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT = 8;
  FLACTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS = 9;

Const
  META_STREAMINFO = 0;
  META_PADDING = 1;
  META_APPLICATION = 2;
  META_SEEKTABLE = 3;
  META_VORBIS_COMMENT = 4;
  META_CUESHEET = 5;
  META_COVER_ART = 6;

Const
  DEFAULT_PADDING_SIZE = 4096 - 4;
  DEFAULT_UPPERCASE_FIELD_NAMES = True;

Const
  OGG_PAGE_SEGMENT_SIZE = 17;

type
  TMetaDataBlockHeader = array [1 .. 4] of Byte;

  TFlacHeader = record
    StreamMarker: array [1 .. 4] of Byte; // should always be 'fLaC'
    MetaDataBlockHeader: array [1 .. 4] of Byte;
    Info: array [1 .. 18] of Byte;
    MD5Sum: array [1 .. 16] of Byte;
  end;

  TFlacTagCoverArtInfo = record
    PictureType: Cardinal;
    MIMEType: String;
    Description: String;
    Width: Word;
    Height: Word;
    ColorDepth: Cardinal;
    NoOfColors: Cardinal;
    PictureData: Pointer;
    SizeOfPictureData: Cardinal;
  end;

  TMetaData = record
    MetaDataBlockHeader: TMetaDataBlockHeader;
    Data: TMemoryStream;
    BlockType: Integer;
    // * Only for cover art meta blocks
    CoverArtInfo: TFlacTagCoverArtInfo;
  end;

  // Ogg page header
  TOggHeader = packed record
    ID: array [1 .. 4] of Byte; { Always "OggS" }
    StreamVersion: Byte; { Stream structure version }
    TypeFlag: Byte; { Header type flag }
    AbsolutePosition: Int64; { Absolute granule position }
    Serial: Integer; { Stream serial number }
    PageNumber: Integer; { Page sequence number }
    Checksum: Cardinal; { Page checksum }
    Segments: Byte; { Number of page segments }
    LacingValues: array [1 .. $FF] of Byte; { Lacing values - segment sizes }
  end;

  TOggFlacHeader = packed record
    PacketType: Byte;
    Signature: array [1 .. 4] of Byte; // should always be 'FLAC'
    MajorVersion: Byte;
    MinorVersion: Byte;
    NumberOfHeaderPackets: Word;
    StreamInfo: TFlacHeader;
  end;

type
  TVorbisCommentFormat = (vcfUnknown, vcfText, vcfBinary);

type
  TFlacStreamType = (fstUnknown, fstNativeFlac, fstOggFlac);

type
  TOGGStream = class
    FStream: TStream;
    LastPageQueried: Int64;
    FirstOGGHeader: TOggHeader;
    Constructor Create(SourceStream: TStream);
  public
    function GetNextPageHeader(var Header: TOggHeader): Boolean;
    function GetPage(PageNumber: Int64; Stream: TStream): Boolean;
    function GetPageData(PageNumber: Int64; Stream: TStream): Boolean;
    function GetNextPage(Stream: TStream): Boolean;
    function GetNextPageData(Stream: TStream): Boolean;
    function CreateTagStream(TagStream: TStream; OutputOGGStream: TStream): Integer;
    function CalculateWrappedStreamSize(InputDataSize: Integer): Integer;
    function ReNumberPages(StartPageNumber: Int64; EndingPageNumber: Int64; Destination: TStream): Boolean;
  end;

type
  TFlacTag = class;

  TVorbisComment = class
  private
  public
    Name: String;
    Format: TVorbisCommentFormat;
    Stream: TMemoryStream;
    Index: Integer;
    Parent: TFlacTag;
    Constructor Create;
    Destructor Destroy; override;
    function GetAsText: String;
    function SetAsText(Text: String): Boolean;
    function GetAsList(var List: TStrings): Boolean;
    function SetAsList(List: TStrings): Boolean;
    procedure Clear;
    function Assign(VorbisComment: TVorbisComment): Boolean;
    function CalculateTotalFrameSize: Integer;
    function Delete: Boolean;
  end;

  TFlacTag = class(TObject)
  private
    FHeader: TFlacHeader;
    FOggFlacHeader: TOggFlacHeader;
    FPaddingIndex: Integer;
    FPaddingLast: Boolean;
    FPaddingFragments: Boolean;
    FVorbisIndex: Integer;
    FPadding: Integer;
    FVCOffset: Integer;
    FAudioOffset: Integer;
    FChannels: Byte;
    FSampleRate: Integer;
    FBitsPerSample: Byte;
    FBitrate: Integer;
    FFileLength: Integer;
    FSamples: Int64;
    FTagSize: integer;
    FMetaBlocksSize: Integer;
    FExists: Boolean;
    procedure FResetData(const HeaderInfo, TagFields: Boolean);
    function FIsValid: Boolean;
    function FGetPlayTime: Double;
    function FGetRatio: Double;
    function FGetChannelMode: String;
    function GetInfo(Stream: TStream; SetTags: Boolean): Integer;
    procedure ReadTag(Source: TStream; SetTagFields: Boolean);
    function ConstructVorbisBlock(VorbisBlock: TStream): Boolean;
    function RebuildFile(const FileName: String; VorbisBlock: TStream; Stream: TStream = nil): Integer;
    function RebuildOggFile(const FileName: String; VorbisBlock: TStream; Stream: TStream = nil): Integer;
  public
    FileName: String;
    Tags: Array of TVorbisComment;
    VendorString: String;
    Loaded: Boolean;
    MetaBlocksCoverArts: array of TMetaData;
    aMetaBlockOther: array of TMetaData;
    bTAG_PreserveDate: Boolean;
    PaddingSizeToWrite: Cardinal;
    UpperCaseFieldNamesToWrite: Boolean;
    ForceReWrite: Boolean;
    StreamType: TFlacStreamType;
    UTF8Encoding: TEncoding;
    constructor Create;
    destructor Destroy; override;
    function LoadFromFile(const FileName: String): Integer;
    function LoadFromStream(Stream: TStream): Integer;
    function SaveToFile(const FileName: String): Integer;
    function SaveToStream(Stream: TStream): Integer;
    function AddMetaDataCoverArt(Stream: TStream; const Blocklength: Integer): Integer;
    function AddMetaDataOther(aMetaHeader: array of Byte; Stream: TStream; const Blocklength: Integer; BlockType: Integer): Integer;
    procedure Clear;
    function Count: Integer;
    function CoverArtCount: Integer;
    function AddTag(Name: String): TVorbisComment;
    function DeleteFrame(FrameIndex: Integer): Boolean;
    procedure DeleteAllFrames;
    procedure DeleteAllCoverArts;
    function FrameExists(Name: String): Integer;
    function AddTextTag(Name: String; Text: String): Integer;
    function ReadFrameByNameAsText(Name: String): String;
    function ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
    procedure SetTextFrameText(Name: String; Text: String);
    procedure SetListFrameText(Name: String; List: TStrings);
    function DeleteFrameByName(Name: String): Boolean;
    function GetCoverArt(Index: Integer; PictureStream: TStream; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function GetCoverArtInfo(Index: Integer; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function GetCoverArtInfoPointer(Index: Integer; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function SetCoverArt(Index: Integer; PictureStream: TStream; FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
    function DeleteCoverArt(Index: Integer): Boolean;
    function CalculateVorbisCommentsSize: Integer;
    function CalculateMetaBlocksSize(IncludePadding: Boolean): Integer;
    function CalculateTagSize(IncludePadding: Boolean): Integer;
    procedure Assign(FlacTag: TFlacTag);
    function GetMultipleValues(const TagName: string; List: TStrings): Boolean;
    procedure SetMultipleValues(const TagName: String; List: TStrings);
    property Channels: Byte read FChannels; // Number of channels
    property SampleRate: Integer read FSampleRate; // Sample rate (hz)
    property BitsPerSample: Byte read FBitsPerSample; // Bits per sample
    property FileLength: integer read FFileLength; // File length (bytes)
    property SampleCount: Int64 read FSamples; // Number of samples
    property Valid: Boolean read FIsValid; // True if header valid
    property Playtime: Double read FGetPlayTime; // Duration (seconds)
    property Ratio: Double read FGetRatio; // Compression ratio (%)
    property Bitrate: integer read FBitrate;
    property ChannelMode: String read FGetChannelMode;
    property Exists: Boolean read FExists;
    property AudioOffset: integer read FAudioOffset; // offset of audio data
    property VCOffset: Integer read FVCOffset;
  end;

function RemoveFlacTagFromFile(const FileName: String): Integer;
function RemoveFlacTagFromStream(Stream: TStream): Integer;

function FlacTagErrorCode2String(ErrorCode: Integer): String;

Const
  // CRC table for checksum calculating
  CRC_TABLE: array [0 .. $FF] of Cardinal = ($00000000, $04C11DB7, $09823B6E, $0D4326D9, $130476DC, $17C56B6B, $1A864DB2, $1E475005, $2608EDB8, $22C9F00F, $2F8AD6D6, $2B4BCB61, $350C9B64, $31CD86D3,
    $3C8EA00A, $384FBDBD, $4C11DB70, $48D0C6C7, $4593E01E, $4152FDA9, $5F15ADAC, $5BD4B01B, $569796C2, $52568B75, $6A1936C8, $6ED82B7F, $639B0DA6, $675A1011, $791D4014, $7DDC5DA3, $709F7B7A,
    $745E66CD, $9823B6E0, $9CE2AB57, $91A18D8E, $95609039, $8B27C03C, $8FE6DD8B, $82A5FB52, $8664E6E5, $BE2B5B58, $BAEA46EF, $B7A96036, $B3687D81, $AD2F2D84, $A9EE3033, $A4AD16EA, $A06C0B5D,
    $D4326D90, $D0F37027, $DDB056FE, $D9714B49, $C7361B4C, $C3F706FB, $CEB42022, $CA753D95, $F23A8028, $F6FB9D9F, $FBB8BB46, $FF79A6F1, $E13EF6F4, $E5FFEB43, $E8BCCD9A, $EC7DD02D, $34867077,
    $30476DC0, $3D044B19, $39C556AE, $278206AB, $23431B1C, $2E003DC5, $2AC12072, $128E9DCF, $164F8078, $1B0CA6A1, $1FCDBB16, $018AEB13, $054BF6A4, $0808D07D, $0CC9CDCA, $7897AB07, $7C56B6B0,
    $71159069, $75D48DDE, $6B93DDDB, $6F52C06C, $6211E6B5, $66D0FB02, $5E9F46BF, $5A5E5B08, $571D7DD1, $53DC6066, $4D9B3063, $495A2DD4, $44190B0D, $40D816BA, $ACA5C697, $A864DB20, $A527FDF9,
    $A1E6E04E, $BFA1B04B, $BB60ADFC, $B6238B25, $B2E29692, $8AAD2B2F, $8E6C3698, $832F1041, $87EE0DF6, $99A95DF3, $9D684044, $902B669D, $94EA7B2A, $E0B41DE7, $E4750050, $E9362689, $EDF73B3E,
    $F3B06B3B, $F771768C, $FA325055, $FEF34DE2, $C6BCF05F, $C27DEDE8, $CF3ECB31, $CBFFD686, $D5B88683, $D1799B34, $DC3ABDED, $D8FBA05A, $690CE0EE, $6DCDFD59, $608EDB80, $644FC637, $7A089632,
    $7EC98B85, $738AAD5C, $774BB0EB, $4F040D56, $4BC510E1, $46863638, $42472B8F, $5C007B8A, $58C1663D, $558240E4, $51435D53, $251D3B9E, $21DC2629, $2C9F00F0, $285E1D47, $36194D42, $32D850F5,
    $3F9B762C, $3B5A6B9B, $0315D626, $07D4CB91, $0A97ED48, $0E56F0FF, $1011A0FA, $14D0BD4D, $19939B94, $1D528623, $F12F560E, $F5EE4BB9, $F8AD6D60, $FC6C70D7, $E22B20D2, $E6EA3D65, $EBA91BBC,
    $EF68060B, $D727BBB6, $D3E6A601, $DEA580D8, $DA649D6F, $C423CD6A, $C0E2D0DD, $CDA1F604, $C960EBB3, $BD3E8D7E, $B9FF90C9, $B4BCB610, $B07DABA7, $AE3AFBA2, $AAFBE615, $A7B8C0CC, $A379DD7B,
    $9B3660C6, $9FF77D71, $92B45BA8, $9675461F, $8832161A, $8CF30BAD, $81B02D74, $857130C3, $5D8A9099, $594B8D2E, $5408ABF7, $50C9B640, $4E8EE645, $4A4FFBF2, $470CDD2B, $43CDC09C, $7B827D21,
    $7F436096, $7200464F, $76C15BF8, $68860BFD, $6C47164A, $61043093, $65C52D24, $119B4BE9, $155A565E, $18197087, $1CD86D30, $029F3D35, $065E2082, $0B1D065B, $0FDC1BEC, $3793A651, $3352BBE6,
    $3E119D3F, $3AD08088, $2497D08D, $2056CD3A, $2D15EBE3, $29D4F654, $C5A92679, $C1683BCE, $CC2B1D17, $C8EA00A0, $D6AD50A5, $D26C4D12, $DF2F6BCB, $DBEE767C, $E3A1CBC1, $E760D676, $EA23F0AF,
    $EEE2ED18, $F0A5BD1D, $F464A0AA, $F9278673, $FDE69BC4, $89B8FD09, $8D79E0BE, $803AC667, $84FBDBD0, $9ABC8BD5, $9E7D9662, $933EB0BB, $97FFAD0C, $AFB010B1, $AB710D06, $A6322BDF, $A2F33668,
    $BCB4666D, $B8757BDA, $B5365D03, $B1F740B4);

var
  FlacTagLibraryDefaultPaddingSizeToWrite: Cardinal = DEFAULT_PADDING_SIZE;
  FlacTagLibraryDefaultUpperCaseFieldNamesToWrite: Boolean = DEFAULT_UPPERCASE_FIELD_NAMES;

implementation

{$IFDEF MSWINDOWS}

Uses
  Winapi.Windows;
{$ENDIF}
{$IFDEF POSIX}

Uses
  Posix.UniStd,
  Posix.StdIO;
{$ENDIF}

function ReverseBytes(Value: Cardinal): Cardinal;
begin
  Result := (Value SHR 24) OR (Value SHL 24) OR ((Value AND $00FF0000) SHR 8) OR ((Value AND $0000FF00) SHL 8);
end;

procedure UnSyncSafe(var Source; const SourceSize: Integer; var Dest: Cardinal);
type
  TBytes = array [0 .. MaxInt - 1] of Byte;
var
  I: Byte;
begin
  { Test : Source = $01 $80 -> Dest = 255
    Source = $02 $00 -> Dest = 256
    Source = $02 $01 -> Dest = 257 etc.
  }
  Dest := 0;
  for I := 0 to SourceSize - 1 do
  begin
    Dest := Dest shl 7;
    Dest := Dest or (TBytes(Source)[I] and $7F); // $7F = %01111111
  end;
end;

function GetID3v2Size(const Source: TStream): Cardinal;
type
  ID3v2Header = packed record
    ID: array [1 .. 3] of Byte;
    Version: Byte;
    Revision: Byte;
    Flags: Byte;
    Size: Cardinal;
  end;
var
  Header: ID3v2Header;
begin
  // Get ID3v2 tag size (if exists)
  Result := 0;
  Source.Seek(0, soFromBeginning);
  Source.Read(Header, SizeOf(ID3v2Header));
  if (Header.ID[1] = Ord('I')) AND (Header.ID[2] = Ord('D')) AND (Header.ID[3] = Ord('3')) then
  begin
    UnSyncSafe(Header.Size, 4, Result);
    Inc(Result, 10);
    if Result > Source.Size then
    begin
      Result := 0;
    end;
  end;
end;

{
  procedure SetBlockSizeHeader(MetaDataBlockHeader: TMetaDataBlockHeader; BlockSize: Integer);
  begin
  MetaDataBlockHeader[2] := Byte((BlockSize SHR 16 ) AND 255 );
  MetaDataBlockHeader[3] := Byte((BlockSize SHR 8 ) AND 255 );
  MetaDataBlockHeader[4] := Byte(BlockSize AND 255 );
  end;
}

(* -------------------------------------------------------------------------- *)

procedure CalculateCRC(var CRC: Cardinal; const Data; Size: Cardinal);
var
  Buffer: ^Byte;
  Index: Cardinal;
begin
  // Calculate CRC through data
  Buffer := Addr(Data);
  for Index := 1 to Size do
  begin
    CRC := (CRC shl 8) xor CRC_TABLE[((CRC shr 24) and $FF) xor Buffer^];
    Inc(Buffer);
  end;
end;

function SetCRC(const Destination: TStream; Header: TOggHeader): Boolean;
var
  Index: Integer;
  Value: Cardinal;
  Data: array [1 .. $FF] of Byte;
begin
  // Calculate and set checksum for OGG frame
  Value := 0;
  CalculateCRC(Value, Header, Header.Segments + 27);
  Destination.Seek(Header.Segments + 27, soFromBeginning);
  for Index := 1 to Header.Segments do
  begin
    if Header.LacingValues[Index] > 0 then
    begin
      Destination.Read(Data, Header.LacingValues[Index]);
      CalculateCRC(Value, Data, Header.LacingValues[Index]);
    end;
  end;
  Destination.Seek(22, soFromBeginning);
  Destination.Write(Value, SizeOf(Value));
  Result := True;
end;

Constructor TOGGStream.Create(SourceStream: TStream);
var
  PreviousPosition: Int64;
begin
  FStream := SourceStream;
  try
    if Assigned(SourceStream) then
    begin
      PreviousPosition := FStream.Position;
      FStream.Read(FirstOGGHeader, SizeOf(TOggHeader));
      FStream.Seek(PreviousPosition, soBeginning);
    end;
  except
    // *
  end;
end;

function GetPageDataSize(Header: TOggHeader): Integer;
var
  i: Integer;
begin
  Result := 0;
  i := 1;
  repeat
    Result := Result + Header.LacingValues[i];
    Inc(i);
  until i > Header.Segments;
end;

function GetPageHeaderSize(Header: TOggHeader): Integer;
begin
  Result := 27 + Header.Segments;
end;

function GetPageSize(Header: TOggHeader): Integer;
begin
  Result := GetPageHeaderSize(Header) + GetPageDataSize(Header);
end;

function TOGGStream.GetPage(PageNumber: Int64; Stream: TStream): Boolean;
var
  Header: TOggHeader;
  PageCounter: Int64;
  DataSize: Integer;
  PageSize: Integer;
  // PageHeaderSize: Integer;
begin
  Result := False;
  try
    LastPageQueried := PageNumber;
    PageCounter := 0;
    FStream.Seek(0, soBeginning);
    repeat
      FillChar(Header, SizeOf(TOggHeader), 0);
      FStream.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
      FStream.Read(Header.LacingValues, Header.Segments);
      PageSize := GetPageSize(Header);
      // PageHeaderSize := GetPageHeaderSize(Header);
      DataSize := GetPageDataSize(Header);
      Inc(PageCounter);
      if PageCounter = PageNumber then
      begin
        FStream.Seek(-(SizeOf(TOggHeader) - SizeOf(Header.LacingValues)) - Header.Segments, soCurrent);
        Stream.CopyFrom(FStream, PageSize);
        Result := True;
        Break;
      end
      else
      begin
        FStream.Seek(DataSize, soCurrent);
      end;
    until FStream.Position = FStream.Size;
  except
    Result := False;
  end;
end;

function TOGGStream.GetPageData(PageNumber: Int64; Stream: TStream): Boolean;
var
  Header: TOggHeader;
  PageCounter: Int64;
  DataSize: Integer;
  // PageHeaderSize: Integer;
begin
  Result := False;
  try
    LastPageQueried := PageNumber;
    PageCounter := 0;
    FStream.Seek(0, soBeginning);
    repeat
      FillChar(Header, SizeOf(TOggHeader), 0);
      FStream.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
      FStream.Read(Header.LacingValues, Header.Segments);
      DataSize := GetPageDataSize(Header);
      // PageHeaderSize := GetPageHeaderSize(Header);
      Inc(PageCounter);
      if PageCounter = PageNumber then
      begin
        Stream.CopyFrom(FStream, DataSize);
        Result := True;
        Break;
      end
      else
      begin
        FStream.Seek(DataSize, soCurrent);
      end;
    until FStream.Position = FStream.Size;
  except
    Result := False;
  end;
end;

function TOGGStream.GetNextPageHeader(var Header: TOggHeader): Boolean;
var
  // DataSize: Integer;
  PageSize: Integer;
  // PageHeaderSize: Integer;
begin
  try
    FillChar(Header, SizeOf(TOggHeader), 0);
    FStream.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
    FStream.Read(Header.LacingValues, Header.Segments);
    PageSize := GetPageSize(Header);
    // PageHeaderSize := GetPageHeaderSize(Header);
    // DataSize := GetPageDataSize(Header);
    FStream.Seek(-(SizeOf(TOggHeader) - SizeOf(Header.LacingValues)) - Header.Segments, soCurrent);
    FStream.Seek(PageSize, soCurrent);
    Inc(LastPageQueried);
    Result := True;
  except
    Result := False;
  end;
end;

function TOGGStream.GetNextPage(Stream: TStream): Boolean;
var
  Header: TOggHeader;
  // DataSize: Integer;
  PageSize: Integer;
  // PageHeaderSize: Integer;
begin
  try
    FillChar(Header, SizeOf(TOggHeader), 0);
    FStream.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
    FStream.Read(Header.LacingValues, Header.Segments);
    PageSize := GetPageSize(Header);
    // PageHeaderSize := GetPageHeaderSize(Header);
    // DataSize := GetPageDataSize(Header);
    FStream.Seek(-(SizeOf(TOggHeader) - SizeOf(Header.LacingValues)) - Header.Segments, soCurrent);
    Stream.CopyFrom(FStream, PageSize);
    Inc(LastPageQueried);
    Result := True;
  except
    Result := False;
  end;
end;

function TOGGStream.GetNextPageData(Stream: TStream): Boolean;
var
  Header: TOggHeader;
  DataSize: Integer;
  // PageHeaderSize: Integer;
begin
  try
    FillChar(Header, SizeOf(TOggHeader), 0);
    FStream.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
    FStream.Read(Header.LacingValues, Header.Segments);
    DataSize := GetPageDataSize(Header);
    // PageHeaderSize := GetPageHeaderSize(Header);
    Stream.CopyFrom(FStream, DataSize);
    Inc(LastPageQueried);
    Result := True;
  except
    Result := False;
  end;
end;

function TOGGStream.CreateTagStream(TagStream: TStream; OutputOGGStream: TStream): Integer;
var
  Header: TOggHeader;
  DataSize: Integer;
  i: Integer;
  OGGPage: TMemoryStream;
begin
  try
    Result := 0;
    Header := FirstOGGHeader;
    Header.TypeFlag := 0;
    Header.AbsolutePosition := 0 { - 1 };
    Header.PageNumber := 1;
    Header.Checksum := 0;
    OGGPage := TMemoryStream.Create;
    try
      while TagStream.Position < TagStream.Size do
      begin
        FillChar(Header.LacingValues, SizeOf(Header.LacingValues), 0);
        if TagStream.Size - TagStream.Position > OGG_PAGE_SEGMENT_SIZE * High(Byte) then
        begin
          DataSize := OGG_PAGE_SEGMENT_SIZE * High(Byte);
          Header.Segments := OGG_PAGE_SEGMENT_SIZE;
          for i := 1 to High(Header.LacingValues) do
          begin
            Header.LacingValues[i] := $FF;
          end;
        end
        else
        begin
          DataSize := TagStream.Size - TagStream.Position;
          if DataSize MOD $FF = 0 then
          begin
            Header.Segments := DataSize div $FF;
          end
          else
          begin
            Header.Segments := (DataSize div $FF) + 1;
          end;
          for i := 1 to Header.Segments do
          begin
            Header.LacingValues[i] := $FF;
          end;
          if DataSize mod $FF <> 0 then
          begin
            Header.LacingValues[Header.Segments] := (DataSize mod $FF);
          end;
        end;
        OGGPage.Clear;
        OGGPage.Write(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
        OGGPage.Write(Header.LacingValues, Header.Segments);
        OGGPage.CopyFrom(TagStream, DataSize);
        OGGPage.Seek(0, soBeginning);
        SetCRC(OGGPage, Header);
        OGGPage.Seek(0, soBeginning);
        OutputOGGStream.CopyFrom(OGGPage, OGGPage.Size);
        Header.TypeFlag := 1;
        Header.Checksum := 0;
        Inc(Header.PageNumber);
        Inc(Result);
      end;
    finally
      FreeAndNil(OGGPage);
    end;
  except
    Result := 0;
  end;
end;

function TOGGStream.CalculateWrappedStreamSize(InputDataSize: Integer): Integer;
var
  Header: TOggHeader;
  DataSize: Integer;
  DataLeft: Integer;
begin
  try
    Result := 0;
    DataLeft := InputDataSize;
    while DataLeft > 0 do
    begin
      if DataLeft > OGG_PAGE_SEGMENT_SIZE * High(Byte) then
      begin
        DataSize := OGG_PAGE_SEGMENT_SIZE * High(Byte);
        Header.Segments := OGG_PAGE_SEGMENT_SIZE;
      end
      else
      begin
        DataSize := DataLeft;
        if DataSize MOD $FF = 0 then
        begin
          Header.Segments := DataSize div $FF;
        end
        else
        begin
          Header.Segments := (DataSize div $FF) + 1;
        end;
      end;
      Inc(Result, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
      Inc(Result, Header.Segments);
      Inc(Result, DataSize);
      Dec(DataLeft, DataSize);
    end;
  except
    Result := 0;
  end;
end;

function TOGGStream.ReNumberPages(StartPageNumber: Int64; EndingPageNumber: Int64; Destination: TStream): Boolean;
var
  Header: TOggHeader;
  OGGPage: TMemoryStream;
  PageCounter: Int64;
  DestinationPosition: Int64;
begin
  try
    FillChar(Header, SizeOf(TOggHeader), 0);
    PageCounter := StartPageNumber;
    OGGPage := TMemoryStream.Create;
    try
      while (Destination.Position < Destination.Size) OR (FStream.Position < FStream.Size) do
      begin
        DestinationPosition := Destination.Position;
        OGGPage.Clear;
        GetNextPage(OGGPage);
        OGGPage.Seek(0, soBeginning);
        OGGPage.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
        OGGPage.Read(Header.LacingValues, Header.Segments);
        OGGPage.Seek(0, soBeginning);
        Header.PageNumber := PageCounter;
        Header.Checksum := 0;
        OGGPage.Write(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
        OGGPage.Seek(0, soBeginning);
        SetCRC(OGGPage, Header);
        OGGPage.Seek(0, soBeginning);
        Destination.Seek(DestinationPosition, soBeginning);
        Destination.CopyFrom(OGGPage, OGGPage.Size);
        Inc(PageCounter);
        if EndingPageNumber <> -1 then
        begin
          if PageCounter > EndingPageNumber then
          begin
            Break;
          end;
        end;
      end;
      Result := True;
    finally
      FreeAndNil(OGGPage);
    end;
  except
    Result := False;
  end;
end;

(* -------------------------------------------------------------------------- *)

Constructor TVorbisComment.Create;
begin
  Inherited;
  Name := '';
  Format := vcfUnknown;
  Stream := TMemoryStream.Create;
end;

function TVorbisComment.Delete: Boolean;
begin
  Result := Parent.DeleteFrame(Index);
end;

Destructor TVorbisComment.Destroy;
begin
  FreeAndNil(Stream);
  Inherited;
end;

function TVorbisComment.GetAsText: String;
var
  Data: Byte;
  Bytes: TBytes;
  i: Integer;
begin
  Result := '';
  if Format <> vcfText then
  begin
    Exit;
  end;
  Stream.Seek(0, soBeginning);
  SetLength(Bytes, Stream.Size);
  for i := 0 to Stream.Size - 1 do
  begin
    Stream.Read(Data, 1);
    if (Data > 31) OR (Data = 13) OR (Data = 10) then
    begin
      Bytes[i] := Data;
    end
    else
    begin
      Bytes[i] := $20;
    end;
  end;
  Stream.Seek(0, soBeginning);
  Result := Parent.UTF8Encoding.GetString(Bytes);
end;

function TVorbisComment.SetAsText(Text: String): Boolean;
var
  Bytes: TBytes;
begin
  if Text <> '' then
  begin
    Bytes := Parent.UTF8Encoding.GetBytes(Text);
    Stream.Clear;
    Stream.Write(Bytes[0], Length(Bytes));
    Stream.Seek(0, soBeginning);
    Format := vcfText;
    Result := True;
  end
  else
  begin
    Result := Delete;
  end;
end;

function TVorbisComment.SetAsList(List: TStrings): Boolean;
var
  i: Integer;
  Data: Byte;
  BytesName: TBytes;
  BytesValue: TBytes;
begin
  Stream.Clear;
  for i := 0 to List.Count - 1 do
  begin
    BytesName := Parent.UTF8Encoding.GetBytes(List.Names[i]);
    BytesValue := Parent.UTF8Encoding.GetBytes(List.ValueFromIndex[i]);
    Stream.Write(BytesName[0], Length(BytesName));
    Data := $0D;
    Stream.Write(Data, 1);
    Data := $0A;
    Stream.Write(Data, 1);
    Stream.Write(BytesValue[0], Length(BytesValue));
    Data := $0D;
    Stream.Write(Data, 1);
    Data := $0A;
    Stream.Write(Data, 1);
  end;
  Stream.Seek(0, soBeginning);
  Format := vcfText;
  Result := True;
end;

function TVorbisComment.GetAsList(var List: TStrings): Boolean;
var
  Data: Byte;
  Bytes: TBytes;
  Name: String;
  Value: String;
  ByteCounter: Integer;
begin
  Result := False;
  List.Clear;
  if Format <> vcfText then
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
    Name := Parent.UTF8Encoding.GetString(Bytes);
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
    Value := Parent.UTF8Encoding.GetString(Bytes);
    List.Append(Name + '=' + Value);
    Result := True;
  end;
  Stream.Seek(0, soBeginning);
end;

procedure TVorbisComment.Clear;
begin
  Format := vcfUnknown;
  Stream.Clear;
end;

function TVorbisComment.CalculateTotalFrameSize: Integer;
begin
  Result := Length(Name) + 1 + Stream.Size;
end;

function TVorbisComment.Assign(VorbisComment: TVorbisComment): Boolean;
begin
  Clear;
  if VorbisComment <> nil then
  begin
    Name := VorbisComment.Name;
    Format := VorbisComment.Format;
    VorbisComment.Stream.Seek(0, soBeginning);
    Stream.CopyFrom(VorbisComment.Stream, VorbisComment.Stream.Size);
    Stream.Seek(0, soBeginning);
    VorbisComment.Stream.Seek(0, soBeginning);
  end;
  Result := True;
end;

(* -------------------------------------------------------------------------- *)

procedure TFlacTag.FResetData(const HeaderInfo, TagFields: Boolean);
var
  i: integer;
begin
  if HeaderInfo then
  begin
    FillChar(FOggFlacHeader, SizeOf(TOggFlacHeader), #0);
    FileName := '';
    FPadding := 0;
    FPaddingLast := False;
    FPaddingFragments := False;
    // ForceReWrite := False;
    FChannels := 0;
    FSampleRate := 0;
    FBitsPerSample := 0;
    FFileLength := 0;
    FSamples := 0;
    FVorbisIndex := 0;
    FPaddingIndex := 0;
    FVCOffset := 0;
    FAudioOffset := 0;
    FMetaBlocksSize := 0;
    StreamType := fstUnknown;
    for i := 0 to Length(aMetaBlockOther) - 1 do
    begin
      if Assigned(aMetaBlockOther[i].Data) then
      begin
        FreeAndNil(aMetaBlockOther[i].Data);
      end;
    end;
    SetLength(aMetaBlockOther, 0);
  end;
  // tag data
  if TagFields then
  begin
    VendorString := '';
    FTagSize := 0;
    FExists := False;
    DeleteAllFrames;
    for i := 0 to Length(MetaBlocksCoverArts) - 1 do
    begin
      if Assigned(MetaBlocksCoverArts[i].Data) then
      begin
        FreeAndNil(MetaBlocksCoverArts[i].Data);
      end;
    end;
    SetLength(MetaBlocksCoverArts, 0);
  end;
end;

function TFlacTag.FIsValid: Boolean;
begin
  Result := False;
  if StreamType = fstNativeFlac then
  begin
    Result := ((FHeader.StreamMarker[1] = Ord('f')) AND (FHeader.StreamMarker[2] = Ord('L')) AND (FHeader.StreamMarker[3] = Ord('a')) AND (FHeader.StreamMarker[4] = Ord('C'))) AND (FChannels > 0) AND
      (FSampleRate > 0) AND (FBitsPerSample > 0) AND (FSamples > 0);
  end;
  if StreamType = fstOggFlac then
  begin
    Result := ((FOggFlacHeader.StreamInfo.StreamMarker[1] = Ord('f')) AND (FOggFlacHeader.StreamInfo.StreamMarker[2] = Ord('L')) AND (FOggFlacHeader.StreamInfo.StreamMarker[3] = Ord('a')) AND
      (FOggFlacHeader.StreamInfo.StreamMarker[4] = Ord('C'))) AND (FChannels > 0) AND (FSampleRate > 0) AND (FBitsPerSample > 0) AND (FSamples > 0);
  end;
end;

function TFlacTag.FrameExists(Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Length(Tags) - 1 do
  begin
    if Name = Tags[i].Name then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TFlacTag.FGetPlayTime: Double;
begin
  if (FIsValid) and (FSampleRate > 0) then
  begin
    Result := FSamples / FSampleRate;
  end
  else
  begin
    Result := 0;
  end;
end;

function TFlacTag.FGetRatio: Double;
begin
  if FIsValid then
  begin
    Result := FFileLength / (FSamples * FChannels * FBitsPerSample / 8) * 100
  end
  else
  begin
    Result := 0;
  end;
end;

function TFlacTag.FGetChannelMode: String;
begin
  if FIsValid then
  begin
    case FChannels of
      1:
        Result := 'Mono';
      2:
        Result := 'Stereo';
    else
      Result := 'Multi Channel';
    end;
  end
  else
  begin
    Result := '';
  end;
end;

(* -------------------------------------------------------------------------- *)

procedure TFlacTag.Clear;
begin
  FResetData(True, True);
  FileName := '';
  Loaded := False;
  VendorString := '';
end;

function TFlacTag.Count: Integer;
begin
  Result := Length(Tags);
end;

constructor TFlacTag.Create;
begin
  inherited;
  UTF8Encoding := TEncoding.UTF8;
  FResetData(True, True);
  PaddingSizeToWrite := FlacTagLibraryDefaultPaddingSizeToWrite;
  UpperCaseFieldNamesToWrite := FlacTagLibraryDefaultUpperCaseFieldNamesToWrite;
end;

procedure TFlacTag.DeleteAllCoverArts;
var
  i: Integer;
begin
  for i := CoverArtCount - 1 downto 0 do
  begin
    DeleteCoverArt(i);
  end;
end;

procedure TFlacTag.DeleteAllFrames;
var
  i: Integer;
begin
  for i := 0 to Length(Tags) - 1 do
  begin
    FreeAndNil(Tags[i]);
  end;
  SetLength(Tags, 0);
end;

function TFlacTag.DeleteFrame(FrameIndex: Integer): Boolean;
var
  i: Integer;
  j: Integer;
begin
  Result := False;
  if (FrameIndex >= Length(Tags)) OR (FrameIndex < 0) then
  begin
    Exit;
  end;
  FreeAndNil(Tags[FrameIndex]);
  i := 0;
  j := 0;
  while i <= Length(Tags) - 1 do
  begin
    if Tags[i] <> nil then
    begin
      Tags[j] := Tags[i];
      Tags[j].Index := i;
      Inc(j);
    end;
    Inc(i);
  end;
  SetLength(Tags, j);
  Result := True;
end;

destructor TFlacTag.Destroy;
begin
  FResetData(True, True);
  // FreeAndNil(UTF8Encoding);
  inherited;
end;

function TFlacTag.ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
var
  i: Integer;
  l: Integer;
begin
  Result := False;
  l := Length(Tags);
  i := 0;
  while (i <> l) AND (UpperCase(Tags[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := False;
  end
  else
  begin
    if Tags[i].Format = vcfText then
    begin
      Result := Tags[i].GetAsList(List);
    end;
  end;
end;

function TFlacTag.ReadFrameByNameAsText(Name: String): String;
var
  i: Integer;
  l: Integer;
begin
  Result := '';
  l := Length(Tags);
  i := 0;
  while (i <> l) AND (UpperCase(Tags[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := '';
  end
  else
  begin
    if Tags[i].Format = vcfText then
    begin
      Result := Tags[i].GetAsText;
    end;
  end;
end;

function TFlacTag.LoadFromFile(const FileName: String): Integer;
var
  Stream: TStream;
begin
  Clear;
  if NOT FileExists(FileName) then
  begin
    Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    Stream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
  except
    Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    Result := GetInfo(Stream, True);
  finally
    FreeAndNil(Stream);
  end;
end;

function TFlacTag.LoadFromStream(Stream: TStream): Integer;
begin
  Clear;
  try
    Result := GetInfo(Stream, True);
  except
    Result := FLACTAGLIBRARY_ERROR;
  end;
end;

function TFlacTag.GetCoverArt(Index: Integer; PictureStream: TStream; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
var
  i: Integer;
  Stream: TStream;
  MIMETypeLength: Cardinal;
  Data: Byte;
  Bytes: TBytes;
  DescriptionLength: Cardinal;
  LengthOfPictureData: Cardinal;
begin
  Result := False;
  with FlacTagCoverArtInfo do
  begin
    PictureType := 0;
    MIMEType := '';
    Description := '';
    Width := 0;
    Height := 0;
    ColorDepth := 0;
    NoOfColors := 0;
    SizeOfPictureData := 0;
  end;
  if (Index < 0) OR (Index >= Length(MetaBlocksCoverArts)) then
  begin
    Exit;
  end;
  Stream := MetaBlocksCoverArts[Index].Data;
  Stream.Seek(0, soBeginning);
  with FlacTagCoverArtInfo do
  begin
    Stream.Read(PictureType, 4);
    PictureType := ReverseBytes(PictureType);
    Stream.Read(MIMETypeLength, 4);
    MIMETypeLength := ReverseBytes(MIMETypeLength);
    for i := 0 to MIMETypeLength - 1 do
    begin
      Stream.Read(Data, 1);
      MIMEType := MIMEType + Char(Data);
    end;
    Stream.Read(DescriptionLength, 4);
    DescriptionLength := ReverseBytes(DescriptionLength);
    if DescriptionLength > 0 then
    begin
      SetLength(Bytes, DescriptionLength);
      for i := 0 to DescriptionLength - 1 do
      begin
        Stream.Read(Data, 1);
        Bytes[i] := Data;
      end;
      Description := UTF8Encoding.GetString(Bytes);
    end
    else
    begin
      Description := '';
    end;
    Stream.Read(Width, 4);
    Width := ReverseBytes(Width);
    Stream.Read(Height, 4);
    Height := ReverseBytes(Height);
    Stream.Read(ColorDepth, 4);
    ColorDepth := ReverseBytes(ColorDepth);
    Stream.Read(NoOfColors, 4);
    NoOfColors := ReverseBytes(NoOfColors);
    Stream.Read(LengthOfPictureData, 4);
    LengthOfPictureData := ReverseBytes(LengthOfPictureData);
    SizeOfPictureData := LengthOfPictureData;
    try
      if Assigned(Stream) then
      begin
        if Stream.Size > 0 then
        begin
          PictureStream.CopyFrom(Stream, LengthOfPictureData);
        end;
      end;
      PictureStream.Seek(0, soBeginning);
    except

    end;
  end;
  Result := True;
end;

function TFlacTag.GetCoverArtInfo(Index: Integer; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
var
  i: Integer;
  Stream: TStream;
  MIMETypeLength: Cardinal;
  Data: Byte;
  DescriptionLength: Cardinal;
  Bytes: TBytes;
begin
  Result := False;
  with FlacTagCoverArtInfo do
  begin
    PictureType := 0;
    MIMEType := '';
    Description := '';
    Width := 0;
    Height := 0;
    ColorDepth := 0;
    NoOfColors := 0;
    SizeOfPictureData := 0;
  end;
  if (Index < 0) OR (Index >= Length(MetaBlocksCoverArts)) then
  begin
    Exit;
  end;
  with FlacTagCoverArtInfo do
  begin
    Stream := MetaBlocksCoverArts[Index].Data;
    Stream.Seek(0, soBeginning);
    Stream.Read(PictureType, 4);
    PictureType := ReverseBytes(PictureType);
    Stream.Read(MIMETypeLength, 4);
    MIMETypeLength := ReverseBytes(MIMETypeLength);
    for i := 0 to MIMETypeLength - 1 do
    begin
      Stream.Read(Data, 1);
      MIMEType := MIMEType + Char(Data);
    end;
    Stream.Read(DescriptionLength, 4);
    DescriptionLength := ReverseBytes(DescriptionLength);
    if DescriptionLength > 0 then
    begin
      SetLength(Bytes, DescriptionLength);
      for i := 0 to DescriptionLength - 1 do
      begin
        Stream.Read(Data, 1);
        Bytes[i] := Data;
      end;
      Description := UTF8Encoding.GetString(Bytes);
    end
    else
    begin
      Description := '';
    end;
    Stream.Read(Width, 4);
    Width := ReverseBytes(Width);
    Stream.Read(Height, 4);
    Height := ReverseBytes(Height);
    Stream.Read(ColorDepth, 4);
    ColorDepth := ReverseBytes(ColorDepth);
    Stream.Read(NoOfColors, 4);
    NoOfColors := ReverseBytes(NoOfColors);
    Stream.Read(SizeOfPictureData, 4);
    SizeOfPictureData := ReverseBytes(SizeOfPictureData);
  end;
  Result := True;
end;

function TFlacTag.GetCoverArtInfoPointer(Index: Integer; var FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
var
  i: Integer;
  Stream: TStream;
  MIMETypeLength: Cardinal;
  Data: Byte;
  DescriptionLength: Cardinal;
  Bytes: TBytes;
  Offset: Cardinal;
begin
  Result := False;
  with FlacTagCoverArtInfo do
  begin
    PictureType := 0;
    MIMEType := '';
    Description := '';
    Width := 0;
    Height := 0;
    ColorDepth := 0;
    NoOfColors := 0;
    PictureData := nil;
    SizeOfPictureData := 0;
  end;
  if (Index < 0) OR (Index >= Length(MetaBlocksCoverArts)) then
  begin
    Exit;
  end;
  with FlacTagCoverArtInfo do
  begin
    Stream := MetaBlocksCoverArts[Index].Data;
    Stream.Seek(0, soBeginning);
    Stream.Read(PictureType, 4);
    PictureType := ReverseBytes(PictureType);
    Stream.Read(MIMETypeLength, 4);
    MIMETypeLength := ReverseBytes(MIMETypeLength);
    for i := 0 to MIMETypeLength - 1 do
    begin
      Stream.Read(Data, 1);
      MIMEType := MIMEType + Char(Data);
    end;
    Stream.Read(DescriptionLength, 4);
    DescriptionLength := ReverseBytes(DescriptionLength);
    if DescriptionLength > 0 then
    begin
      SetLength(Bytes, DescriptionLength);
      for i := 0 to DescriptionLength - 1 do
      begin
        Stream.Read(Data, 1);
        Bytes[i] := Data;
      end;
      Description := UTF8Encoding.GetString(Bytes);
    end
    else
    begin
      Description := '';
    end;
    Stream.Read(Width, 4);
    Width := ReverseBytes(Width);
    Stream.Read(Height, 4);
    Height := ReverseBytes(Height);
    Stream.Read(ColorDepth, 4);
    ColorDepth := ReverseBytes(ColorDepth);
    Stream.Read(NoOfColors, 4);
    NoOfColors := ReverseBytes(NoOfColors);
    Stream.Read(SizeOfPictureData, 4);
    SizeOfPictureData := ReverseBytes(SizeOfPictureData);
    PictureData := TMemoryStream(Stream).Memory;
    Offset := Stream.Position;
    PictureData := Pointer(NativeUInt(PictureData) + Offset);
  end;
  Result := True;
end;

function TFlacTag.SetCoverArt(Index: Integer; PictureStream: TStream; FlacTagCoverArtInfo: TFlacTagCoverArtInfo): Boolean;
var
  Stream: TMemoryStream;
  MIMETypeLength: Cardinal;
  Bytes: TBytes;
  DescriptionLength: Cardinal;
  LengthOfPictureData: Cardinal;
begin
  Result := False;
  if (Index < 0) OR (Index >= Length(MetaBlocksCoverArts)) then
  begin
    Exit;
  end;
  Stream := MetaBlocksCoverArts[Index].Data;
  Stream.Clear;
  Stream.Seek(0, soBeginning);
  with FlacTagCoverArtInfo do
  begin
    PictureType := ReverseBytes(PictureType);
    Stream.Write(PictureType, 4);
    MIMETypeLength := Length(MIMEType);
    MIMETypeLength := ReverseBytes(MIMETypeLength);
    Stream.Write(MIMETypeLength, 4);
    Bytes := UTF8Encoding.GetBytes(MIMEType);
    Stream.Write(Bytes[0], Length(Bytes));
    Bytes := UTF8Encoding.GetBytes(Description);
    DescriptionLength := Length(Bytes);
    DescriptionLength := ReverseBytes(DescriptionLength);
    Stream.Write(DescriptionLength, 4);
    Stream.Write(Bytes[0], Length(Bytes));
    Width := ReverseBytes(Width);
    Stream.Write(Width, 4);
    Height := ReverseBytes(Height);
    Stream.Write(Height, 4);
    ColorDepth := ReverseBytes(ColorDepth);
    Stream.Write(ColorDepth, 4);
    NoOfColors := ReverseBytes(NoOfColors);
    Stream.Write(NoOfColors, 4);
    LengthOfPictureData := PictureStream.Size;
    LengthOfPictureData := ReverseBytes(LengthOfPictureData);
    Stream.Write(LengthOfPictureData, 4);
    PictureStream.Seek(0, soBeginning);
    Stream.CopyFrom(PictureStream, PictureStream.Size);
    PictureStream.Seek(0, soBeginning);
  end;
  with MetaBlocksCoverArts[Index] do
  begin
    MetaDataBlockHeader[1] := META_COVER_ART;
    MetaDataBlockHeader[2] := Byte((Data.Size SHR 16) AND 255);
    MetaDataBlockHeader[3] := Byte((Data.Size SHR 8) AND 255);
    MetaDataBlockHeader[4] := Byte(Data.Size AND 255);
  end;
  GetCoverArtInfoPointer(Index, Self.MetaBlocksCoverArts[Index].CoverArtInfo);
  Result := True;
end;

function TFlacTag.DeleteCoverArt(Index: Integer): Boolean;
var
  i: Integer;
  j: Integer;
begin
  Result := False;
  if (Index >= Length(MetaBlocksCoverArts)) OR (Index < 0) then
  begin
    Exit;
  end;
  if Assigned(MetaBlocksCoverArts[Index].Data) then
  begin
    FreeAndNil(MetaBlocksCoverArts[Index].Data);
  end;
  i := 0;
  j := 0;
  while i <= Length(MetaBlocksCoverArts) - 1 do
  begin
    if MetaBlocksCoverArts[i].Data <> nil then
    begin
      MetaBlocksCoverArts[j] := MetaBlocksCoverArts[i];
      // MetaBlocksCoverArts[j].Index := i;
      Inc(j);
    end;
    Inc(i);
  end;
  SetLength(MetaBlocksCoverArts, j);
  Result := True;
end;

function TFlacTag.GetInfo(Stream: TStream; SetTags: Boolean): Integer;
var
  // SourceFile: TFileStream;
  aMetaDataBlockHeader: array [1 .. 4] of Byte;
  iBlockLength, iMetaType, iIndex: Integer;
  bPaddingFound: Boolean;
  ID3v2Size: Integer;
  OggHeader: TOggHeader;
  Data: TMemoryStream;
  PreviousPosition: Int64;
  OGGStream: TOGGStream;
  CoverArtIndex: Integer;
begin
  Result := FLACTAGLIBRARY_ERROR;
  // SourceFile := nil;
  bPaddingFound := False;
  FResetData(True, False);
  try
    // Set read-access and open file
    if Stream.Size = 0 then
    begin
      Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
      Exit;
    end;
    FFileLength := Stream.Size;
    FileName := FileName;
    { Seek past the ID3v2 tag, if there is one }
    ID3v2Size := GetID3v2Size(Stream);
    Stream.Seek(ID3v2Size, soFromBeginning);
    // Read header data
    FillChar(FHeader, SizeOf(FHeader), 0);
    Stream.Read(FHeader, SizeOf(FHeader));
    // Process data if loaded and header valid
    if ((FHeader.StreamMarker[1] = Ord('f')) AND (FHeader.StreamMarker[2] = Ord('L')) AND (FHeader.StreamMarker[3] = Ord('a')) AND (FHeader.StreamMarker[4] = Ord('C'))) then
    begin
      StreamType := fstNativeFlac;
      with FHeader do
      begin
        FChannels := (Info[13] shr 1 and $7 + 1);
        FSampleRate := (Info[11] shl 12 or Info[12] shl 4 or Info[13] shr 4);
        FBitsPerSample := (Info[13] and 1 shl 4 or Info[14] shr 4 + 1);
        FSamples := (Info[15] shl 24 or Info[16] shl 16 or Info[17] shl 8 or Info[18]);
      end;
      if (FHeader.MetaDataBlockHeader[1] and $80) <> 0 then
      begin
        Result := FLACTAGLIBRARY_ERROR_NO_TAG_FOUND;
        Exit; // no metadata blocks exist
      end;
      iIndex := 0;
      repeat // read more metadata blocks if available
        Stream.Read(aMetaDataBlockHeader, 4);
        Inc(iIndex); // metadatablock index
        iBlockLength := (aMetaDataBlockHeader[2] shl 16 or aMetaDataBlockHeader[3] shl 8 or aMetaDataBlockHeader[4]); // decode length
        if iBlockLength <= 0 then
        begin
          FMetaBlocksSize := FMetaBlocksSize + 4;
          Continue;
        end;
        iMetaType := (aMetaDataBlockHeader[1] and $7F); // decode metablock type
        if iMetaType = META_VORBIS_COMMENT then
        begin // read vorbis block
          FVCOffset := Stream.Position;
          FTagSize := iBlockLength;
          FVorbisIndex := iIndex;
          ReadTag(Stream, SetTags); // set up fields
        end
        else if (iMetaType = META_PADDING) and not bPaddingFound then
        begin // we have padding block
          FPadding := iBlockLength; // if we find more skip & put them in metablock array
          FPaddingLast := ((aMetaDataBlockHeader[1] and $80) <> 0);
          FPaddingIndex := iIndex;
          bPaddingFound := True;
          Stream.Seek(FPadding, soCurrent); // advance into file till next block or audio data start
        end
        else
        begin // all other
          if iMetaType <= 6 then
          begin // is it a valid metablock ?
            if (iMetaType = META_PADDING) then
            begin // set flag for fragmented padding blocks
              FPaddingFragments := True;
            end;
            if iMetaType = META_COVER_ART then
            begin
              if SetTags then
              begin
                CoverArtIndex := AddMetaDataCoverArt( { aMetaDataBlockHeader, } Stream, iBlockLength { , iIndex } );
                GetCoverArtInfoPointer(CoverArtIndex, Self.MetaBlocksCoverArts[CoverArtIndex].CoverArtInfo);
              end
              else
              begin
                Stream.Seek(iBlockLength, soCurrent);
              end;
            end
            else
            begin
              AddMetaDataOther(aMetaDataBlockHeader, Stream, iBlockLength, iMetaType);
            end;
            FMetaBlocksSize := FMetaBlocksSize + iBlockLength + 4;
          end
          else
          begin
            FSamples := 0; // ops...
            Result := FLACTAGLIBRARY_SUCCESS;
            Exit;
          end;
        end;
      until ((aMetaDataBlockHeader[1] and $80) <> 0); // until is last flag ( first bit = 1 )
      Loaded := True;
      Result := FLACTAGLIBRARY_SUCCESS;
    end
    else
    begin
      FillChar(OggHeader, SizeOf(TOggHeader), #0);
      Stream.Seek(ID3v2Size, soFromBeginning);
      Stream.Read(OggHeader, SizeOf(TOggHeader));
      if (OggHeader.ID[1] = Ord('O')) AND (OggHeader.ID[2] = Ord('g')) AND (OggHeader.ID[3] = Ord('g')) AND (OggHeader.ID[4] = Ord('S')) then
      begin
        Stream.Seek(ID3v2Size + $1C, soFromBeginning);
        Stream.Read(FOggFlacHeader, SizeOf(TOggFlacHeader));
        if (FOggFlacHeader.PacketType = $7F) AND ((FOggFlacHeader.Signature[1] = Ord('F')) AND (FOggFlacHeader.Signature[2] = Ord('L')) AND (FOggFlacHeader.Signature[3] = Ord('A')) AND
          (FOggFlacHeader.Signature[4] = Ord('C'))) AND (FOggFlacHeader.MajorVersion = 1) AND
          ((FOggFlacHeader.StreamInfo.StreamMarker[1] = Ord('f')) AND (FOggFlacHeader.StreamInfo.StreamMarker[2] = Ord('L')) AND (FOggFlacHeader.StreamInfo.StreamMarker[3] = Ord('a')) AND
          (FOggFlacHeader.StreamInfo.StreamMarker[4] = Ord('C'))) then
        begin
          StreamType := fstOggFlac;
          with FOggFlacHeader.StreamInfo do
          begin
            FChannels := (Info[13] shr 1 and $7 + 1);
            FSampleRate := (Info[11] shl 12 or Info[12] shl 4 or Info[13] shr 4);
            FBitsPerSample := (Info[13] and 1 shl 4 or Info[14] shr 4 + 1);
            FSamples := (Info[15] shl 24 or Info[16] shl 16 or Info[17] shl 8 or Info[18]);
          end;
          if (FOggFlacHeader.StreamInfo.MetaDataBlockHeader[1] and $80) <> 0 then
          begin
            Result := FLACTAGLIBRARY_ERROR_NO_TAG_FOUND;
            Exit; // no metadata blocks exist
          end;
          OGGStream := TOGGStream.Create(Stream);
          Data := TMemoryStream.Create;
          try
            OGGStream.GetNextPageData(Data);
            Data.Seek(0, soBeginning);
            iIndex := 0;
            repeat // read more metadata blocks if available
              // * Query more data if needed
              PreviousPosition := Data.Position;
              while Data.Position + 4 > Data.Size do
              begin
                Data.Seek(0, soEnd);
                OGGStream.GetNextPageData(Data);
                Data.Seek(PreviousPosition, soBeginning);
              end;
              Data.Read(aMetaDataBlockHeader, 4);
              Inc(iIndex); // metadatablock index
              iBlockLength := (aMetaDataBlockHeader[2] shl 16 or aMetaDataBlockHeader[3] shl 8 or aMetaDataBlockHeader[4]); // decode length
              if iBlockLength <= 0 then
              begin
                FMetaBlocksSize := FMetaBlocksSize + 4;
                Continue;
              end;
              iMetaType := (aMetaDataBlockHeader[1] and $7F); // decode metablock type
              if iMetaType = META_VORBIS_COMMENT then
              begin // read vorbis block
                FVCOffset := Data.Position;
                FTagSize := iBlockLength;
                FVorbisIndex := iIndex;
                // * Query more data if needed
                PreviousPosition := Data.Position;
                while Data.Position + iBlockLength > Data.Size do
                begin
                  Data.Seek(0, soEnd);
                  OGGStream.GetNextPageData(Data);
                  Data.Seek(PreviousPosition, soBeginning);
                end;
                ReadTag(Data, SetTags); // set up fields
              end
              else if (iMetaType = META_PADDING) and not bPaddingFound then
              begin // we have padding block
                FPadding := iBlockLength; // if we find more skip & put them in metablock array
                FPaddingLast := ((aMetaDataBlockHeader[1] and $80) <> 0);
                FPaddingIndex := iIndex;
                bPaddingFound := True;
                // * Query more data if needed
                PreviousPosition := Data.Position;
                while Data.Position + FPadding > Data.Size do
                begin
                  Data.Seek(0, soEnd);
                  OGGStream.GetNextPageData(Data);
                  Data.Seek(PreviousPosition, soBeginning);
                end;
                Data.Seek(FPadding, soCurrent); // advance into file till next block or audio data start
              end
              else
              begin // all other
                if iMetaType <= 6 then
                begin // is it a valid metablock ?
                  if (iMetaType = META_PADDING) then
                  begin // set flag for fragmented padding blocks
                    FPaddingFragments := True;
                  end;
                  // * Query more data if needed
                  PreviousPosition := Data.Position;
                  while Data.Position + iBlockLength > Data.Size do
                  begin
                    Data.Seek(0, soEnd);
                    OGGStream.GetNextPageData(Data);
                    Data.Seek(PreviousPosition, soBeginning);
                  end;
                  if iMetaType = META_COVER_ART then
                  begin
                    if SetTags then
                    begin
                      CoverArtIndex := AddMetaDataCoverArt(Data, iBlockLength);
                      GetCoverArtInfoPointer(CoverArtIndex, Self.MetaBlocksCoverArts[CoverArtIndex].CoverArtInfo);
                    end
                    else
                    begin
                      Data.Seek(iBlockLength, soCurrent);
                    end;
                  end
                  else
                  begin
                    AddMetaDataOther(aMetaDataBlockHeader, Data, iBlockLength, iMetaType);
                  end;
                  FMetaBlocksSize := FMetaBlocksSize + iBlockLength + 4;
                end
                else
                begin
                  FSamples := 0; // ops...
                  Result := FLACTAGLIBRARY_SUCCESS;
                  Exit;
                end;
              end;
            until ((aMetaDataBlockHeader[1] and $80) <> 0); // until is last flag ( first bit = 1 )
            Loaded := True;
            Result := FLACTAGLIBRARY_SUCCESS;
          finally
            FreeAndNil(OGGStream);
            FreeAndNil(Data);
          end;
        end
        else
        begin
          if FOggFlacHeader.MajorVersion <> 1 then
          begin
            Result := FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
          end
          else
          begin
            Result := FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
          end;
          Exit;
        end;
      end
      else
      begin
        Result := FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        Exit;
      end;
    end;
  finally
    if FIsValid then
    begin
      FAudioOffset := Stream.Position; // we need that to rebuild the file if nedeed
      FBitrate := Round(((FFileLength - FAudioOffset) / 1000) * 8 / FGetPlayTime); // time to calculate average bitrate
    end
    else
    begin
      if Result = FLACTAGLIBRARY_ERROR then
      begin
        Result := FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
      end;
    end;
  end;
end;

function TFlacTag.GetMultipleValues(const TagName: string; List: TStrings): Boolean;
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Count - 1 do
  begin
    if SameText(Tags[i].Name, TagName) then
    begin
      List.add(Tags[i].GetAsText);
    end;
  end;
  Result := (List.Count > 0);
end;

function TFlacTag.AddTag(Name: String): TVorbisComment;
begin
  Result := nil;
  try
    SetLength(Tags, Length(Tags) + 1);
    Tags[Length(Tags) - 1] := TVorbisComment.Create;
    Tags[Length(Tags) - 1].Name := Name;
    Tags[Length(Tags) - 1].Index := Length(Tags) - 1;
    Tags[Length(Tags) - 1].Parent := Self;
    Result := Tags[Length(Tags) - 1];
  except
    // *
  end;
end;

function TFlacTag.AddTextTag(Name: String; Text: String): Integer;
begin
  with AddTag(Name) do
  begin
    SetAsText(Text);
    Result := Index;
  end;
end;

function TFlacTag.CoverArtCount: Integer;
begin
  Result := Length(MetaBlocksCoverArts);
end;

function TFlacTag.AddMetaDataCoverArt(Stream: TStream; const Blocklength: Integer): Integer;
var
  iMetaLen: integer;
begin
  // enlarge array
  iMetaLen := Length(MetaBlocksCoverArts) + 1;
  SetLength(MetaBlocksCoverArts, iMetaLen);
  // save header
  MetaBlocksCoverArts[iMetaLen - 1].MetaDataBlockHeader[1] := META_COVER_ART; // aMetaHeader[0];
  // save content in a stream
  MetaBlocksCoverArts[iMetaLen - 1].Data := TMemoryStream.Create;
  if Assigned(Stream) then
  begin
    MetaBlocksCoverArts[iMetaLen - 1].Data.CopyFrom(Stream, Blocklength);
  end;
  Result := iMetaLen - 1;
end;

function TFlacTag.AddMetaDataOther(aMetaHeader: array of Byte; Stream: TStream; const Blocklength: Integer; BlockType: Integer): Integer;
var
  iMetaLen: integer;
begin
  // enlarge array
  iMetaLen := Length(aMetaBlockOther) + 1;
  SetLength(aMetaBlockOther, iMetaLen);
  // save header
  aMetaBlockOther[iMetaLen - 1].MetaDataBlockHeader[1] := aMetaHeader[0];
  aMetaBlockOther[iMetaLen - 1].MetaDataBlockHeader[2] := aMetaHeader[1];
  aMetaBlockOther[iMetaLen - 1].MetaDataBlockHeader[3] := aMetaHeader[2];
  aMetaBlockOther[iMetaLen - 1].MetaDataBlockHeader[4] := aMetaHeader[3];
  // * Store type
  aMetaBlockOther[iMetaLen - 1].BlockType := BlockType;
  // save content in a stream
  aMetaBlockOther[iMetaLen - 1].Data := TMemoryStream.Create;
  aMetaBlockOther[iMetaLen - 1].Data.Position := 0;
  if Assigned(Stream) then
  begin
    aMetaBlockOther[iMetaLen - 1].Data.CopyFrom(Stream, Blocklength);
  end;
  Result := iMetaLen - 1;
end;

(* -------------------------------------------------------------------------- *)

{
  function AnsiPos(const Substr, S: String): Integer;
  var
  P: PChar;
  begin
  Result := 0;
  P := AnsiStrPos(PChar(S), PChar(SubStr));
  if P <> nil then
  Result := (IntPtr(P) - IntPtr(PChar(S))) div 1 + 1;
  end;
}

procedure TFlacTag.ReadTag(Source: TStream; SetTagFields: Boolean);
var
  i, TagCount, DataSize, SeparatorPos: Integer;
  Data: TMemoryStream;
  FieldName: String;
  FieldValue: String;
  // ZeroByte: Byte;
  Bytes: TBytes;
  TempString: String;
begin
  // ZeroByte := 0;
  TagCount := 0;
  DataSize := 0;
  Data := TMemoryStream.Create;
  try
    Source.Read(DataSize, SizeOf(DataSize)); // vendor
    if DataSize > 0 then
    begin
      Data.CopyFrom(Source, DataSize);
      // Data.Seek(0, soEnd);
      // Data.Write(ZeroByte, 1);
      Data.Seek(0, soBeginning);
      SetLength(Bytes, Data.Size);
      Data.Read(Bytes[0], Data.Size);
      VendorString := UTF8Encoding.GetString(Bytes);
      VendorString := Copy(VendorString, 1, Length(VendorString));
      // VendorString := PANSIChar(Data.Memory);
    end;
    Source.Read(TagCount, SizeOf(TagCount)); // field count
    FExists := (TagCount > 0);
    for i := 0 to TagCount - 1 do
    begin
      Source.Read(DataSize, SizeOf(DataSize));
      if DataSize <= 0 then
      begin
        Continue;
      end;
      Data.Clear;
      Data.CopyFrom(Source, DataSize);
      // Data.Seek(0, soEnd);
      // Data.Write(ZeroByte, 1);
      if NOT SetTagFields then
      begin
        Continue; // if we don't want to re assign fields we skip
      end;
      // SetLength(Bytes, Data.Size);
      Data.Seek(0, soBeginning);
      SetLength(Bytes, Data.Size);
      Data.Read(Bytes[0], Data.Size);
      TempString := UTF8Encoding.GetString(Bytes);
      SeparatorPos := Pos('=', TempString);
      if SeparatorPos > 0 then
      begin
        FieldName := UpperCase(Copy(TempString, 1, SeparatorPos - 1));
        // Data.Seek(SeparatorPos, soBeginning);
        with AddTag(FieldName) do
        begin
          FieldValue := Copy(TempString, SeparatorPos + 1, Length(TempString));
          Bytes := UTF8Encoding.GetBytes(FieldValue);
          Stream.Write(Bytes[0], Length(Bytes));
          Stream.Seek(0, soBeginning);
          Format := vcfText;
        end;

      end;
    end;
  finally
    FreeAndNil(Data);
  end;
end;

function TFlacTag.ConstructVorbisBlock(VorbisBlock: TStream): Boolean;
var
  i, iFieldCount, iSize: Integer;
  Tag: TStream;
  Bytes: TBytes;

  procedure _WriteTagBuff(sID: String; sData: string);
  var
    iTmp: integer;
    Bytes: TBytes;
  begin
    if sData <> '' then
    begin
      Bytes := UTF8Encoding.GetBytes(sID + '=' + sData);
      iTmp := Length(Bytes);
      Tag.Write(iTmp, SizeOf(iTmp));
      Tag.Write(Bytes[0], Length(Bytes));
      Inc(iFieldCount);
    end;
  end;

begin
  try
    Result := False;
    // * TODO: remove 'Tag' and write directly to 'VorbisBlock'
    Tag := TMemoryStream.Create;
    // VorbisBlock := TMemoryStream.Create;
    iFieldCount := 0;
    for i := 0 to Length(Tags) - 1 do
    begin
      if UpperCaseFieldNamesToWrite then
      begin
        _WriteTagBuff(UpperCase(Tags[i].Name), Tags[i].GetAsText);
      end
      else
      begin
        _WriteTagBuff(Tags[i].Name, Tags[i].GetAsText);
      end;
    end;
    // Write vendor info and number of fields
    with VorbisBlock do
    begin
      if VendorString = '' then
      begin
        VendorString := 'reference libFLAC 1.1.0 20030126'; // guess it
      end;
      Bytes := UTF8Encoding.GetBytes(VendorString);
      iSize := Length(Bytes);
      Write(iSize, SizeOf(iSize));
      Write(Bytes[0], Length(Bytes));
      Write(iFieldCount, SizeOf(iFieldCount));
    end;
    VorbisBlock.CopyFrom(Tag, 0); // All tag data is here now
    VorbisBlock.Seek(0, soBeginning);
    Result := True;
  finally
    FreeAndNil(Tag);
  end;
end;

function TFlacTag.SaveToFile(const FileName: String): Integer;
var
  VorbisBlock: TStream;
  FileStream: TStream;
begin
  Result := FLACTAGLIBRARY_ERROR;
  try
    FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
  except
    Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    // reload all except tag fields
    if GetInfo(FileStream, False) <> FLACTAGLIBRARY_SUCCESS then
    begin
      Exit;
    end;
  finally
    FreeAndNil(FileStream);
  end;
  VorbisBlock := TMemoryStream.Create;
  try
    if NOT ConstructVorbisBlock(VorbisBlock) then
    begin
      Exit;
    end;
    if StreamType = fstNativeFlac then
    begin
      Result := RebuildFile(FileName, VorbisBlock);
    end;
    if StreamType = fstOggFlac then
    begin
      Result := RebuildOggFile(FileName, VorbisBlock);
    end;
    FExists := Result = FLACTAGLIBRARY_SUCCESS { ) AND (VorbisBlock.Size > 0) };
  finally
    FreeAndNil(VorbisBlock);
  end;
end;

function TFlacTag.SaveToStream(Stream: TStream): Integer;
var
  VorbisBlock: TStream;
begin
  Result := FLACTAGLIBRARY_ERROR;
  try
    Stream.Seek(0, soBeginning);
    // reload all except tag fields
    if GetInfo(Stream, False) <> FLACTAGLIBRARY_SUCCESS then
    begin
      Exit;
    end;
  except
    Exit;
  end;
  VorbisBlock := TMemoryStream.Create;
  try
    if NOT ConstructVorbisBlock(VorbisBlock) then
    begin
      Exit;
    end;
    if StreamType = fstNativeFlac then
    begin
      Result := RebuildFile('', VorbisBlock, Stream);
    end;
    if StreamType = fstOggFlac then
    begin
      Result := RebuildOggFile('', VorbisBlock, Stream);
    end;
    FExists := Result = FLACTAGLIBRARY_SUCCESS { ) AND (VorbisBlock.Size > 0) };
  finally
    FreeAndNil(VorbisBlock);
  end;
end;

procedure TFlacTag.SetListFrameText(Name: String; List: TStrings);
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Tags);
  while (i < l) AND (UpperCase(Tags[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    AddTag(Name).SetAsList(List);
  end
  else
  begin
    Tags[i].SetAsList(List);
  end;
end;

procedure TFlacTag.SetMultipleValues(const TagName: String; List: TStrings);
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
  begin
    if SameText(Tags[i].Name, TagName) then
    begin
      DeleteFrame(i);
    end;
  end;
  for i := 0 to List.Count - 1 do
  begin
    AddTag(TagName).SetAsText(List[i]);
  end;
end;

procedure TFlacTag.SetTextFrameText(Name: String; Text: String);
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Tags);
  while (i < l) AND (UpperCase(Tags[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    if Text <> '' then
    begin
      AddTextTag(Name, Text);
    end;
  end
  else
  begin
    Tags[i].SetAsText(Text);
  end;
end;

function TFlacTag.DeleteFrameByName(Name: String): Boolean;
var
  i: Integer;
  l: Integer;
  j: Integer;
begin
  l := Length(Tags);
  i := 0;
  while (i <> l) and (UpperCase(Tags[i].Name) <> UpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := False;
    Exit;
  end;
  FreeAndNil(Tags[i]);
  i := 0;
  j := 0;
  while i <= l - 1 do
  begin
    if Tags[i] <> nil then
    begin
      Tags[j] := Tags[i];
      Inc(j);
    end;
    Inc(i);
  end;
  SetLength(Tags, j);
  Result := True;
end;

function TFlacTag.RebuildFile(const FileName: String; VorbisBlock: TStream; Stream: TStream = nil): Integer;
var
  Source, Destination: TStream;
  i, k, iNewPadding, iMetaCount, iExtraPadding: Integer;
  // iFileAge: Integer;
  BufferName: string;
  // Bytes: TBytes;
  MetaDataBlockHeader: array [1 .. 4] of Byte;
  oldHeader: TFlacHeader;
  MetaBlocks: TMemoryStream;
  bRebuild, bRearange: Boolean;
  ID3v2Size: Integer;
  NewMetaBlocksSize: Integer;
  Data: Byte;
  FileDateTime: TDateTime;
begin
  Result := FLACTAGLIBRARY_ERROR;
  Source := nil;
  Destination := nil;
  MetaBlocks := nil;
  bRearange := False;
  iExtraPadding := 0;
  if NOT Assigned(Stream) then
  begin
    if (NOT FileExists(FileName))
{$IFDEF MSWINDOWS}
{$WARN SYMBOL_PLATFORM OFF}
      OR (FileSetAttr(FileName, 0) <> 0)
{$WARN SYMBOL_PLATFORM ON}
{$ENDIF}
    then
    begin
      Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
      Exit;
    end;
  end;
  try
    FileDateTime := 0;
    if NOT Assigned(Stream) then
    begin
      if bTAG_PreserveDate then
      begin
        // iFileAge := FileAge(FileName);
        FileAge(FileName, FileDateTime);
      end;
    end;

    NewMetaBlocksSize := CalculateMetaBlocksSize(True);

    // re arrange other metadata in case of
    // 1. padding block is not aligned after vorbis comment
    // 2. insufficient padding - rearange upon file rebuild
    // * 3. Meta block order changed
    // 3. fragmented padding blocks
    // * 4. ForceReWrite set
    iMetaCount := Length(aMetaBlockOther);
    if (FPaddingIndex <> FVorbisIndex + 1) OR (FPadding <= VorbisBlock.Size - FTagSize) OR (FMetaBlocksSize <> NewMetaBlocksSize) OR FPaddingFragments OR ForceReWrite then
    begin
      MetaBlocks := TMemoryStream.Create;
      for i := 0 to Length(MetaBlocksCoverArts) - 1 do
      begin
        MetaBlocksCoverArts[i].MetaDataBlockHeader[1] := (MetaBlocksCoverArts[i].MetaDataBlockHeader[1] AND $7F); // not last
        MetaBlocksCoverArts[i].MetaDataBlockHeader[2] := Byte((MetaBlocksCoverArts[i].Data.Size SHR 16) AND 255);
        MetaBlocksCoverArts[i].MetaDataBlockHeader[3] := Byte((MetaBlocksCoverArts[i].Data.Size SHR 8) AND 255);
        MetaBlocksCoverArts[i].MetaDataBlockHeader[4] := Byte(MetaBlocksCoverArts[i].Data.Size AND 255);
        // SetBlockSizeHeader(MetaBlocksCoverArts[i].MetaDataBlockHeader, MetaBlocksCoverArts[i].Data.Size);
        MetaBlocksCoverArts[i].Data.Position := 0;
        MetaBlocks.Write(MetaBlocksCoverArts[i].MetaDataBlockHeader[1], 4);
        MetaBlocks.CopyFrom(MetaBlocksCoverArts[i].Data, 0);
      end;
      for i := 0 to iMetaCount - 1 do
      begin
        aMetaBlockOther[i].MetaDataBlockHeader[1] := (aMetaBlockOther[i].MetaDataBlockHeader[1] AND $7F); // not last
        if aMetaBlockOther[i].MetaDataBlockHeader[1] = META_PADDING then
        begin
          iExtraPadding := iExtraPadding + aMetaBlockOther[i].Data.Size + 4; // add padding size plus 4 bytes of header block
        end
        else
        begin
          aMetaBlockOther[i].MetaDataBlockHeader[2] := Byte((aMetaBlockOther[i].Data.Size SHR 16) AND 255);
          aMetaBlockOther[i].MetaDataBlockHeader[3] := Byte((aMetaBlockOther[i].Data.Size SHR 8) AND 255);
          aMetaBlockOther[i].MetaDataBlockHeader[4] := Byte(aMetaBlockOther[i].Data.Size AND 255);
          // SetBlockSizeHeader(aMetaBlockOther[i].MetaDataBlockHeader, aMetaBlockOther[i].Data.Size);
          aMetaBlockOther[i].Data.Position := 0;
          MetaBlocks.Write(aMetaBlockOther[i].MetaDataBlockHeader[1], 4);
          MetaBlocks.CopyFrom(aMetaBlockOther[i].Data, 0);
        end;
      end;
      MetaBlocks.Position := 0;
      bRearange := True;
    end;
    // set up file
    if (FPadding <= VorbisBlock.Size - FTagSize) OR (FMetaBlocksSize <> NewMetaBlocksSize) OR ForceReWrite then
    begin // no room rebuild the file from scratch
      bRebuild := True;
      // * Working with files
      if NOT Assigned(Stream) then
      begin
        BufferName := FileName + '~';
        try
          try
            Source := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareExclusive);
          except
            Result := FLACTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
            Exit;
          end;
        finally
          FreeAndNil(Source);
        end;
        try
          Source := TFileStream.Create(FileName, fmOpenRead); // Set read-only and open old file, and create new
        except
          Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
          Exit;
        end;
        try
          Destination := TFileStream.Create(BufferName, fmCreate);
        except
          Result := FLACTAGLIBRARY_ERROR_WRITING_FILE;
          Exit;
        end;
        // * Working in memory
      end
      else
      begin
        Source := Stream;
        Source.Seek(0, soBeginning);
        Destination := TMemoryStream.Create;
      end;

      ID3v2Size := GetID3v2Size(Source);
      Source.Seek(0, soFromBeginning);
      if ID3v2Size > 0 then
      begin
        Destination.CopyFrom(Source, ID3v2Size);
      end;
      Source.Read(oldHeader, SizeOf(oldHeader));
      oldHeader.MetaDataBlockHeader[1] := (oldHeader.MetaDataBlockHeader[1] and $7F); // just in case no metadata existed
      Destination.Write(oldHeader, SizeOf(oldHeader));
      Destination.CopyFrom(MetaBlocks, 0);
    end
    else
    begin
      bRebuild := False;
      if NOT Assigned(Stream) then
      begin
        // Source := nil;
        try
          Destination := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite); // Set write-access and open file
        except
          Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
          Exit;
        end;
      end
      else
      begin
        Destination := Stream;
        Destination.Seek(0, soBeginning);
      end;
      if bRearange then
      begin
        ID3v2Size := GetID3v2Size(Destination);
        Destination.Seek(ID3v2Size, soFromBeginning);
        Destination.Seek(SizeOf(FHeader), soCurrent);
        Destination.CopyFrom(MetaBlocks, 0);
      end
      else
      begin
        Destination.Seek(FVCOffset - 4, soFromBeginning);
      end;
    end;
    // finally write vorbis block
    MetaDataBlockHeader[1] := META_VORBIS_COMMENT;
    MetaDataBlockHeader[2] := Byte((VorbisBlock.Size SHR 16) AND 255);
    MetaDataBlockHeader[3] := Byte((VorbisBlock.Size SHR 8) AND 255);
    MetaDataBlockHeader[4] := Byte(VorbisBlock.Size AND 255);
    Destination.Write(MetaDataBlockHeader[1], SizeOf(MetaDataBlockHeader));
    Destination.CopyFrom(VorbisBlock, VorbisBlock.Size);
    // and add padding
    if FPaddingLast or bRearange then
    begin
      MetaDataBlockHeader[1] := META_PADDING or $80;
    end
    else
    begin
      MetaDataBlockHeader[1] := META_PADDING;
    end;
    if bRebuild then
    begin
      iNewPadding := PaddingSizeToWrite; // why not...
    end
    else
    begin
      // * TODO: check this when deleting a cover art block (FMetaBlocksSize < NewMetaBlocksSize)
      if (FTagSize + FMetaBlocksSize) > (VorbisBlock.Size + NewMetaBlocksSize) then
      begin // tag got smaller increase padding
        iNewPadding := (FPadding + (FTagSize + FMetaBlocksSize) - (VorbisBlock.Size + NewMetaBlocksSize)) + iExtraPadding;
      end
      else
      begin // tag got bigger shrink padding
        iNewPadding := (FPadding - (VorbisBlock.Size + NewMetaBlocksSize) + (FTagSize + FMetaBlocksSize)) + iExtraPadding;
      end;
    end;
    MetaDataBlockHeader[2] := Byte((iNewPadding SHR 16) AND 255);
    MetaDataBlockHeader[3] := Byte((iNewPadding SHR 8) AND 255);
    MetaDataBlockHeader[4] := Byte(iNewPadding AND 255);
    Destination.Write(MetaDataBlockHeader[1], 4);
    if (FPadding <> iNewPadding) or bRearange then
    begin // fill the block with zeros
      Data := 0;
      for k := 0 to iNewPadding - 1 do
      begin
        Destination.Write(Data, 1);
      end;
    end;
    // finish
    if bRebuild then
    begin // time to put back the audio data...
      Source.Seek(FAudioOffset, soFromBeginning);
      Destination.CopyFrom(Source, Source.Size - FAudioOffset);
      if NOT Assigned(Stream) then
      begin
        FreeAndNil(Source);
        FreeAndNil(Destination);
        if (SysUtils.DeleteFile(FileName)) AND (RenameFile(BufferName, FileName)) then
        begin // Replace old file and delete temporary file
          Result := FLACTAGLIBRARY_SUCCESS;
        end
        else
        begin
          Result := FLACTAGLIBRARY_SUCCESS;
          raise Exception.Create('');
        end;
      end
      else
      begin
        Result := FLACTAGLIBRARY_SUCCESS;
      end;
    end
    else
    begin
      Result := FLACTAGLIBRARY_SUCCESS;
      if NOT Assigned(Stream) then
      begin
        FreeAndNil(Destination);
      end;
    end;
    if Assigned(MetaBlocks) then
    begin
      FreeAndNil(MetaBlocks);
    end;
    // post save tasks
    if NOT Assigned(Stream) then
    begin
      if bTAG_PreserveDate then
      begin
        FileSetDate(FileName, DateTimeToFileDate(FileDateTime));
      end;
    end
    else
    begin
      if Destination <> Stream then
      begin
        Stream.Size := 0;
        Stream.Seek(0, soBeginning);
        Stream.CopyFrom(Destination, 0);
        FreeAndNil(Destination);
      end;
      Stream.Seek(0, soBeginning);
    end;
  except
    // Access error
    if FileExists(BufferName) then
    begin
      SysUtils.DeleteFile(BufferName);
    end;
  end;
end;

function TFlacTag.RebuildOggFile(const FileName: String; VorbisBlock: TStream; Stream: TStream = nil): Integer;
var
  Source, Destination: TStream;
  i, iMetaCount: Integer;
  // iFileAge: Integer;
  iNewPadding: Cardinal;
  BufferName: string;
  MetaDataBlockHeader: TMetaDataBlockHeader;
  MetaBlock: TMemoryStream;
  Rebuild: Boolean;
  ID3v2Size: Integer;
  OGGStream: TOGGStream;
  OggPageCount: Integer;
  UnWrappedVorbisBlock: TStream;
  NewOGGStream: TOGGStream;
  SourceOggStream: TFileStream;
  AvailableSpace: Int64;
  WrappedBlocks: TStream;
  WrappedPaddingSize: Int64;
  UnWrappedPaddingStream: TStream;
  OggPageHeader: TOggHeader;
  FileDateTime: TDateTime;
  NewBlocksSize: Integer;

  procedure AddPadding(PaddingSize: Integer);
  var
    Data: Byte;
    k: Integer;
  begin
    UnWrappedPaddingStream := TMemoryStream.Create;
    try
      MetaDataBlockHeader[1] := META_PADDING OR $80;
      // SetBlockSizeHeader(MetaDataBlockHeader, PaddingSize);
      MetaDataBlockHeader[2] := Byte((PaddingSize SHR 16) AND 255);
      MetaDataBlockHeader[3] := Byte((PaddingSize SHR 8) AND 255);
      MetaDataBlockHeader[4] := Byte(PaddingSize AND 255);
      UnWrappedPaddingStream.Write(MetaDataBlockHeader[1], 4);
      Data := 0;
      for k := 0 to PaddingSize - 1 do
      begin
        UnWrappedPaddingStream.Write(Data, 1);
      end;
      UnWrappedPaddingStream.Seek(0, soBeginning);
      OggPageCount := OggPageCount + OGGStream.CreateTagStream(UnWrappedPaddingStream, WrappedBlocks);
    finally
      FreeAndNil(UnWrappedPaddingStream);
    end;
  end;

begin
  Result := FLACTAGLIBRARY_ERROR;
  Source := nil;
  Destination := nil;
  Rebuild := ForceReWrite;
  OggPageCount := 0;
  if NOT Assigned(Stream) then
  begin
    if (NOT FileExists(FileName))
{$IFDEF MSWINDOWS}
{$WARN SYMBOL_PLATFORM OFF}
      OR (FileSetAttr(FileName, 0) <> 0)
{$WARN SYMBOL_PLATFORM ON}
{$ENDIF}
    then
    begin
      Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
      Exit;
    end;
  end;
  try
    FileDateTime := 0;
    if NOT Assigned(Stream) then
    begin
      if bTAG_PreserveDate then
      begin
        // iFileAge := FileAge(FileName);
        FileAge(FileName, FileDateTime);
      end;
    end;
    // NewMetaBlocksSize := CalculateMetaBlocksSize(True);

    AvailableSpace := FAudioOffset - $4F;

    // * Create an Ogg wrapper class with the Ogg stream infos from the source file
    if NOT Assigned(Stream) then
    begin
      try
        SourceOggStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
        OGGStream := TOGGStream.Create(SourceOggStream);
        FreeAndNil(SourceOggStream);
      except
        Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
      end;
    end
    else
    begin
      try
        Stream.Seek(0, soBeginning);
        OGGStream := TOGGStream.Create(Stream);
      except
        Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
      end;
    end;

    WrappedBlocks := TMemoryStream.Create;
    // * Set and wrap the vorbis comments block into Ogg conteiner
    UnWrappedVorbisBlock := TMemoryStream.Create;
    try
      MetaDataBlockHeader[1] := META_VORBIS_COMMENT;
      // SetBlockSizeHeader(MetaDataBlockHeader, VorbisBlock.Size);
      MetaDataBlockHeader[2] := Byte((VorbisBlock.Size SHR 16) AND 255);
      MetaDataBlockHeader[3] := Byte((VorbisBlock.Size SHR 8) AND 255);
      MetaDataBlockHeader[4] := Byte(VorbisBlock.Size AND 255);
      UnWrappedVorbisBlock.Write(MetaDataBlockHeader[1], SizeOf(MetaDataBlockHeader));
      UnWrappedVorbisBlock.CopyFrom(VorbisBlock, VorbisBlock.Size);

      UnWrappedVorbisBlock.Seek(0, soBeginning);
      OggPageCount := OggPageCount + OGGStream.CreateTagStream(UnWrappedVorbisBlock, WrappedBlocks);

    finally
      FreeAndNil(UnWrappedVorbisBlock);
    end;
    // * Set and wrap cover art blocks and meta blocks into Ogg conteiner
    try
      iMetaCount := Length(aMetaBlockOther);
      MetaBlock := TMemoryStream.Create;
      try
        for i := 0 to Length(MetaBlocksCoverArts) - 1 do
        begin
          MetaBlock.Clear;
          MetaBlocksCoverArts[i].MetaDataBlockHeader[1] := (MetaBlocksCoverArts[i].MetaDataBlockHeader[1] AND $7F); // not last
          MetaBlocksCoverArts[i].MetaDataBlockHeader[2] := Byte((MetaBlocksCoverArts[i].Data.Size SHR 16) AND 255);
          MetaBlocksCoverArts[i].MetaDataBlockHeader[3] := Byte((MetaBlocksCoverArts[i].Data.Size SHR 8) AND 255);
          MetaBlocksCoverArts[i].MetaDataBlockHeader[4] := Byte(MetaBlocksCoverArts[i].Data.Size AND 255);
          // SetBlockSizeHeader(MetaBlocksCoverArts[i].MetaDataBlockHeader, MetaBlocksCoverArts[i].Data.Size);
          MetaBlocksCoverArts[i].Data.Position := 0;
          MetaBlock.Write(MetaBlocksCoverArts[i].MetaDataBlockHeader[1], 4);
          MetaBlock.CopyFrom(MetaBlocksCoverArts[i].Data, 0);
          MetaBlock.Seek(0, soBeginning);
          OggPageCount := OggPageCount + OGGStream.CreateTagStream(MetaBlock, WrappedBlocks);
        end;
        for i := 0 to iMetaCount - 1 do
        begin
          MetaBlock.Clear;
          aMetaBlockOther[i].MetaDataBlockHeader[1] := (aMetaBlockOther[i].MetaDataBlockHeader[1] AND $7F); // not last
          if aMetaBlockOther[i].BlockType = META_PADDING then
          begin
            Continue;
          end
          else
          begin
            aMetaBlockOther[i].MetaDataBlockHeader[2] := Byte((aMetaBlockOther[i].Data.Size SHR 16) AND 255);
            aMetaBlockOther[i].MetaDataBlockHeader[3] := Byte((aMetaBlockOther[i].Data.Size SHR 8) AND 255);
            aMetaBlockOther[i].MetaDataBlockHeader[4] := Byte(aMetaBlockOther[i].Data.Size AND 255);
            // SetBlockSizeHeader(aMetaBlockOther[i].MetaDataBlockHeader, aMetaBlockOther[i].Data.Size);
            aMetaBlockOther[i].Data.Position := 0;
            MetaBlock.Write(aMetaBlockOther[i].MetaDataBlockHeader[1], 4);
            MetaBlock.CopyFrom(aMetaBlockOther[i].Data, 0);
            MetaBlock.Seek(0, soBeginning);
            OggPageCount := OggPageCount + OGGStream.CreateTagStream(MetaBlock, WrappedBlocks);
          end;
        end;
      finally
        FreeAndNil(MetaBlock);
      end;

      NewBlocksSize := WrappedBlocks.Size + OGGStream.CalculateWrappedStreamSize(5);

      // * Calculate size of padding
      if NewBlocksSize <> AvailableSpace then
      begin
        // * Add padding
        if (NewBlocksSize < AvailableSpace) OR (AvailableSpace - NewBlocksSize > PaddingSizeToWrite) then
        begin
          iNewPadding := 4;
          repeat
            Inc(iNewPadding);
            WrappedPaddingSize := OGGStream.CalculateWrappedStreamSize(iNewPadding);
          until (WrappedBlocks.Size + WrappedPaddingSize >= AvailableSpace) OR (iNewPadding > PaddingSizeToWrite);
          if WrappedBlocks.Size + WrappedPaddingSize <> AvailableSpace then
          begin
            Rebuild := True;
          end
          else
          begin
            AddPadding(iNewPadding - 4);
          end;
          // * Re-write is needed
        end
        else
        begin
          Rebuild := True;
        end;
      end;

      // * Create a new file
      if Rebuild then
      begin
        // * Create a new padding with default size
        AddPadding(PaddingSizeToWrite);
        // * Working with files
        if NOT Assigned(Stream) then
        begin
          // * Check if the existing file can be deleted
          BufferName := FileName + '~';
          try
            try
              Source := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareExclusive);
            except
              Result := FLACTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
              Exit;
            end;
          finally
            FreeAndNil(Source);
          end;
          // * Open source file
          try
            Source := TFileStream.Create(FileName, fmOpenRead); // Set read-only and open old file, and create new
          except
            Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
            Exit;
          end;
          // * Create new destination file
          try
            Destination := TFileStream.Create(BufferName, fmCreate);
          except
            Result := FLACTAGLIBRARY_ERROR_WRITING_FILE;
            Exit;
          end;
          // * Working in memory
        end
        else
        begin
          Source := Stream;
          Source.Seek(0, soBeginning);
          Destination := TMemoryStream.Create;
        end;
        // * Copy ID3v2 if theres one
        ID3v2Size := GetID3v2Size(Source);
        Source.Seek(0, soFromBeginning);
        if ID3v2Size > 0 then
        begin
          Destination.CopyFrom(Source, ID3v2Size);
        end;
        // * Copy STREAMINFO block (wrapped in Ogg)
        Destination.CopyFrom(Source, $4F);

        // * Use the existing file
      end
      else
      begin
        if NOT Assigned(Stream) then
        begin
          try
            Destination := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite); // Set write-access and open file
          except
            Result := FLACTAGLIBRARY_ERROR_OPENING_FILE;
            Exit;
          end;
        end
        else
        begin
          Destination := Stream;
          Destination.Seek(0, soBeginning);
        end;
        ID3v2Size := GetID3v2Size(Destination);
      end;

      // * Set STREAMINFO block
      Destination.Seek(ID3v2Size + $1C, soFromBeginning);
      Destination.Read(FOggFlacHeader, SizeOf(TOggFlacHeader));
      FOggFlacHeader.StreamInfo.MetaDataBlockHeader[1] := (FOggFlacHeader.StreamInfo.MetaDataBlockHeader[1] and $7F); // just in case no metadata existed
      FOggFlacHeader.NumberOfHeaderPackets := Swap(OggPageCount);
      Destination.Seek(ID3v2Size + $1C, soFromBeginning);
      Destination.Write(FOggFlacHeader, SizeOf(TOggFlacHeader));

      // * Copy the new meta data block pack
      Destination.CopyFrom(WrappedBlocks, 0);

      // * Re-number the meta data block Ogg headers
      Destination.Seek(ID3v2Size, soBeginning);
      NewOGGStream := TOGGStream.Create(Destination);
      NewOGGStream.ReNumberPages(0, OggPageCount, Destination);
      NewOGGStream.Free;

      // * Re-number remaining (audio) pages if needed
      if Rebuild then
      begin
        Source.Seek(FAudioOffset, soBeginning);
        NewOGGStream := TOGGStream.Create(Source);
        NewOGGStream.ReNumberPages(OggPageCount + 1, -1, Destination);
        NewOGGStream.Free;
      end
      else
      begin
        Destination.Seek(ID3v2Size, soBeginning);
        NewOGGStream := TOGGStream.Create(Destination);
        Destination.Seek(ID3v2Size + $4F + WrappedBlocks.Size, soBeginning);
        NewOGGStream.GetNextPageHeader(OggPageHeader);
        if (OggPageHeader.PageNumber <> OggPageCount + 1) then
        begin
          Destination.Seek(ID3v2Size + $4F + WrappedBlocks.Size, soBeginning);
          NewOGGStream.ReNumberPages(OggPageCount + 1, -1, Destination);
        end;
        NewOGGStream.Free;
      end;

      if NOT Assigned(Stream) then
      begin
        if Assigned(Source) then
        begin
          FreeAndNil(Source);
        end;
        if Assigned(Destination) then
        begin
          FreeAndNil(Destination);
        end;
      end;

      Result := FLACTAGLIBRARY_SUCCESS;

    finally
      FreeAndNil(OGGStream);
      FreeAndNil(WrappedBlocks);
    end;

    if Rebuild then
    begin
      if NOT Assigned(Stream) then
      begin
        if NOT SysUtils.DeleteFile(FileName) then
        begin
          // Replace old file and delete temporary file
          raise Exception.Create('Error deleting existing file: ' + FileName);
        end;
        RenameFile(BufferName, FileName);
      end;
    end;

    // post save tasks
    if NOT Assigned(Stream) then
    begin
      if bTAG_PreserveDate then
      begin
        FileSetDate(FileName, DateTimeToFileDate(FileDateTime));
      end;
    end
    else
    begin
      if Destination <> Stream then
      begin
        Stream.Size := 0;
        Stream.Seek(0, soBeginning);
        Stream.CopyFrom(Destination, 0);
        FreeAndNil(Destination);
      end;
      Stream.Seek(0, soBeginning);
    end;
  except
    // Access error
    if FileExists(BufferName) then
    begin
      SysUtils.DeleteFile(BufferName);
    end;
  end;
end;

function TFlacTag.CalculateVorbisCommentsSize: Integer;
var
  i, iFieldCount, iSize: Integer;
  VorbisBlock, Tag: TStream;
  Bytes: TBytes;

  procedure _WriteTagBuff(sID: String; sData: string);
  var
    iTmp: integer;
    Bytes: TBytes;
  begin
    if sData <> '' then
    begin
      Bytes := UTF8Encoding.GetBytes(sID + '=' + sData);
      iTmp := Length(Bytes);
      Tag.Write(iTmp, SizeOf(iTmp));
      Tag.Write(Bytes[0], Length(Bytes));
      Inc(iFieldCount);
    end;
  end;

begin

  try
    Result := 0;
    Tag := TMemoryStream.Create;
    VorbisBlock := TMemoryStream.Create;
    iFieldCount := 0;
    for i := 0 to Length(Tags) - 1 do
    begin
      if UpperCaseFieldNamesToWrite then
      begin
        _WriteTagBuff(UpperCase(Tags[i].Name), Tags[i].GetAsText);
      end
      else
      begin
        _WriteTagBuff(Tags[i].Name, Tags[i].GetAsText);
      end;
    end;
    // Write vendor info and number of fields
    with VorbisBlock do
    begin
      if VendorString = '' then
      begin
        VendorString := 'reference libFLAC 1.1.0 20030126'; // guess it
      end;
      Bytes := UTF8Encoding.GetBytes(VendorString);
      iSize := Length(Bytes);
      Write(iSize, SizeOf(iSize));
      Write(Bytes[0], Length(Bytes));
      Write(iFieldCount, SizeOf(iFieldCount));
    end;
    VorbisBlock.CopyFrom(Tag, 0); // All tag data is here now
    VorbisBlock.Position := 0;
    Result := VorbisBlock.Size;
  finally
    FreeAndNil(Tag);
    FreeAndNil(VorbisBlock);
  end;
end;

function TFlacTag.CalculateMetaBlocksSize(IncludePadding: Boolean): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Length(aMetaBlockOther) - 1 do
  begin
    if ((aMetaBlockOther[i].MetaDataBlockHeader[1] and $7F) = META_PADDING) then
    begin
      if IncludePadding then
      begin
        Result := Result + aMetaBlockOther[i].Data.Size + 4;
      end;
    end
    else
    begin
      Result := Result + aMetaBlockOther[i].Data.Size + 4;
    end;
  end;
  for i := 0 to Length(MetaBlocksCoverArts) - 1 do
  begin
    Result := Result + MetaBlocksCoverArts[i].Data.Size + 4;
  end;
end;

function TFlacTag.CalculateTagSize(IncludePadding: Boolean): Integer;
begin
  Result := CalculateVorbisCommentsSize + CalculateMetaBlocksSize(IncludePadding);
  if IncludePadding then
  begin
    Result := Result + FPadding;
  end;
end;

procedure TFlacTag.Assign(FlacTag: TFlacTag);
var
  i: Integer;
begin
  Clear;
  FileName := FlacTag.FileName;
  for i := 0 to Length(FlacTag.Tags) - 1 do
  begin
    Self.AddTag('').Assign(FlacTag.Tags[i]);
  end;
  for i := 0 to Length(FlacTag.MetaBlocksCoverArts) - 1 do
  begin
    FlacTag.MetaBlocksCoverArts[i].Data.Seek(0, soBeginning);
    Self.AddMetaDataCoverArt(FlacTag.MetaBlocksCoverArts[i].Data, FlacTag.MetaBlocksCoverArts[i].Data.Size);
  end;
end;

function RemoveFlacTagFromFile(const FileName: String): Integer;
var
  FlacTag: TFlacTag;
begin
  FlacTag := TFlacTag.Create;
  try
    FlacTag.FResetData(False, True);
    Result := FlacTag.SaveToFile(FileName);
  finally
    FreeAndNil(FlacTag);
  end;
end;

function RemoveFlacTagFromStream(Stream: TStream): Integer;
var
  FlacTag: TFlacTag;
begin
  FlacTag := TFlacTag.Create;
  try
    FlacTag.FResetData(False, True);
    Stream.Seek(0, soBeginning);
    Result := FlacTag.SaveToStream(Stream);
  finally
    FreeAndNil(FlacTag);
  end;
end;

function FlacTagErrorCode2String(ErrorCode: Integer): String;
begin
  Result := 'Unknown error code.';
  case ErrorCode of
    FLACTAGLIBRARY_SUCCESS:
      Result := 'Success.';
    FLACTAGLIBRARY_ERROR:
      Result := 'Unknown error occured.';
    FLACTAGLIBRARY_ERROR_NO_TAG_FOUND:
      Result := 'No Flac tag found.';
    FLACTAGLIBRARY_ERROR_EMPTY_TAG:
      Result := 'Flac tag is empty.';
    FLACTAGLIBRARY_ERROR_EMPTY_FRAMES:
      Result := 'Flac tag contains only empty frames.';
    FLACTAGLIBRARY_ERROR_OPENING_FILE:
      Result := 'Error opening file.';
    FLACTAGLIBRARY_ERROR_READING_FILE:
      Result := 'Error reading file.';
    FLACTAGLIBRARY_ERROR_WRITING_FILE:
      Result := 'Error writing file.';
    FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION:
      Result := 'Error: not supported Flac tag version.';
    FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT:
      Result := 'Error not supported file format.';
    FLACTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS:
      Result := 'Error: file is locked. Need exclusive access to write Flac tag to this file.';
  end;
end;

end.
