// ********************************************************************************************************************************
// *                                                                                                                              *
// *     Ogg Vorbis and Opus Tag Library 1.0.18.34 © 3delite 2012-2015                                                            *
// *     See Ogg Vorbis and Opus Tag Library Readme.txt for details                                                               *
// *                                                                                                                              *
// * Two licenses are available for commercial usage of this component:                                                           *
// * Shareware License: €50                                                                                                       *
// * Commercial License: €250                                                                                                     *
// *                                                                                                                              *
// *     http://www.shareit.com/product.html?productid=300552311                                                                  *
// *                                                                                                                              *
// * Using the component in free programs is free.                                                                                *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
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
// * a Flac Tag Library available at:                                                                                             *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
// *                                                                                                                              *
// * an WMA Tag Library available at:                                                                                             *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
// *                                                                                                                              *
// * a WAV Tag Library available at:                                                                                              *
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

unit OggVorbisAndOpusTagLibrary;

{$IFDEF IOS}
{$DEFINE OVAOTL_MOBILE}
{$ENDIF}
{$IFDEF ANDROID}
{$DEFINE OVAOTL_MOBILE}
{$ENDIF}

interface

Uses
  SysUtils,
  // Dialogs,
  Classes;

{$MINENUMSIZE 4}

Const
  OPUSTAGLIBRARY_VERSION = $01001834;

Const
  OPUSTAGLIBRARY_SUCCESS = 0;
  OPUSTAGLIBRARY_ERROR = $FFFF;
  OPUSTAGLIBRARY_ERROR_NO_TAG_FOUND = 1;
  OPUSTAGLIBRARY_ERROR_EMPTY_TAG = 2;
  OPUSTAGLIBRARY_ERROR_EMPTY_FRAMES = 3;
  OPUSTAGLIBRARY_ERROR_OPENING_FILE = 4;
  OPUSTAGLIBRARY_ERROR_READING_FILE = 5;
  OPUSTAGLIBRARY_ERROR_WRITING_FILE = 6;
  OPUSTAGLIBRARY_ERROR_CORRUPT = 7;
  OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION = 8;
  OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT = 9;
  OPUSTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS = 10;

Const
  OGG_PAGE_ID = 'OggS';
  // * Opus
  OPUS_PARAMETERS_ID = 'OpusHead';
  OPUS_TAG_ID = 'OpusTags';
  OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE = 'METADATA_BLOCK_PICTURE';
  OPUSTAGLIBRARY_FRAMENAME_PADDING = 'PADDING';
  OPUSTAGLIBRARY_PADDING_BYTE = '#';
  // * Vorbis
  VORBIS_PARAMETERS_ID = #1 + 'vorbis';
  VORBIS_TAG_ID = #3 + 'vorbis';
  // * Theora
  THEORA_ID = #80 + 'theora';
  THEORA_TAG_ID = Char($81) + 'theora';

Const
  OGG_PAGE_SEGMENT_SIZE = 17;
  DEFAULT_WRITE_PADDING = False;
  DEFAULT_PADDING_SIZE = 2048;
  DEFAULT_UPPERCASE_FIELD_NAMES = True;
  DEFAULT_PARSE_PLAYTIME = False;
  DEFAULT_OPUS_DEEP_BITRATE_SCAN = False;

type
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

  // Opus parameter header
  TOpusHeader = packed record
    ID: array [1 .. 8] of Byte; { Always "OpusHead" }
    BitstreamVersion: Byte; { Bitstream version number }
    ChannelCount: Byte; { Number of channels }
    PreSkip: Word;
    SampleRate: LongWord; { Sample rate (hz) }
    OutputGain: Word;
    MappingFamily: Byte; { 0,1,255 }
  end;

  // Opus tag data
  TOpusTags = record
    ID: array [1 .. 8] of Byte; { Always "OpusTags" }
    Fields: Integer; { Number of tag fields }
  end;

  // Vorbis parameter header
  TVorbisHeader = packed record
    ID: array [1 .. 7] of Byte; { Always #1 + "vorbis" }
    BitstreamVersion: array [1 .. 4] of Byte; { Bitstream version number }
    ChannelMode: Byte; { Number of channels }
    SampleRate: Integer; { Sample rate (hz) }
    BitRateMaximal: Integer; { Bit rate upper limit }
    BitRateNominal: Integer; { Nominal bit rate }
    BitRateMinimal: Integer; { Bit rate lower limit }
    BlockSize: Byte; { Coded size for small and long blocks }
    StopFlag: Byte; { Always 1 }
  end;

  // Theora parameter header
  TTheoraHeader = packed record
    ID: array [1 .. 7] of Byte; { Always #1 + "vorbis" }
    HeaderData: array [1 .. 35] of Byte; { Bitstream version number }
  end;

  { Vorbis tag data }
  TVorbisTag = record
    ID: array [1 .. 7] of Byte; { Always #3 + "vorbis" }
    Fields: Integer; { Number of tag fields }
  end;

type
  // Opus file data
  TFileInfo = record
    FPage, SPage, LPage: TOggHeader; { First, second and last page }
    OpusParameters: TOpusHeader; { Opus parameter header }
    Tag: TOpusTags; { Opus tag data }
    VorbisParameters: TVorbisHeader;
    VorbisTag: TVorbisTag;
    ChannelMapping: Array [0 .. 7] of Byte;
    TheoraHeader: TTheoraHeader;
    FileSize: Integer; { File size (bytes) }
    ID3v2Size: Integer; { ID3v2 tag size (bytes) }
    SPagePos: Integer; { Position of second Ogg page }
    TagEndPos: Integer; { Tag end position }
    TagCount: Integer;
    DataPageNumberStartsFrom: Int64;
    HeaderOggPageCount: Int64;
    SampleCount: Int64;
    PlayTime: Double;
    BitRate: Integer;
  end;

type
  TOGGStream = class
    FStream: TStream;
    LastPageQueried: Int64;
    FirstOGGHeader: TOggHeader;
    Constructor Create(SourceStream: TStream);
  public
    function GetPage(PageNumber: Int64; Stream: TStream): Boolean;
    function GetPageData(PageNumber: Int64; Stream: TStream): Boolean;
    function GetNextPage(Stream: TStream): Boolean;
    function GetNextPageData(Stream: TStream): Boolean;
    function GetNextPageHeader(var OggHeader: TOggHeader; Stream: TStream = nil): Boolean;
    function CreateTagStream(TagStream: TStream; OutputOGGStream: TStream; StartPageNumber: Cardinal = 1): Integer;
    function CreateTagStreamVorbis(TagSize: Integer; TagStream: TStream; OutputOGGStream: TStream): Integer;
    function CalculateWrappedStreamSize(InputDataSize: Integer): Integer;
    function CalculateWrappedStreamSizeVorbis(TagSize: Integer; InputDataSize: Integer): Integer;
    function CalculateWrappedStreamSizeEx(InputDataSize: Integer; MustFitSize: Integer; var PaddingNeeded: Integer): Integer;
    function ReNumberPages(PageNumberStartsFrom: Int64; Source, Destination: TStream): Boolean;
    function ReNumberPagesTheora(PageNumberStartsFrom: Int64; Source, Destination: TStream): Boolean;
  end;

type
  TOggFormat = (ofUnknown, ofVorbis, ofOpus, ofTheora);

type
  TOpusVorbisCoverArtInfo = record
    PictureType: Cardinal;
    MIMEType: String;
    Description: String;
    Width: Cardinal;
    Height: Cardinal;
    ColorDepth: Cardinal;
    NoOfColors: Cardinal;
    SizeOfPictureData: Cardinal;
  end;

type
  TOpusTagFrameFormat = (otffUnknown, otffText, otffCoverArt, otffBinary);

type
  TOpusTag = class;

  TOpusTagFrame = class
  private
  public
    Name: String;
    Format: TOpusTagFrameFormat;
    Stream: TMemoryStream;
    Index: Integer;
    Parent: TOpusTag;
    Constructor Create(Parent: TOpusTag);
    Destructor Destroy; override;
    function GetAsText: String;
    function SetAsText(Text: String): Boolean;
    function GetAsList(var List: TStrings): Boolean;
    function SetAsList(List: TStrings): Boolean;
    function IsCoverArt: Boolean;
    procedure Clear;
    function Assign(OpusTagFrame: TOpusTagFrame): Boolean;
    function CalculateTotalFrameSize: Integer;
  end;

  TOpusTag = class
  private
    procedure ReadOpusAudioAttributes(Stream: TStream);
    procedure ReadVorbisAudioAttributes(Stream: TStream);
    function GetSamples(const Source: TStream): Int64;
    function GetPlayTime: Double;
  public
    FileName: String;
    Loaded: Boolean;
    Frames: Array of TOpusTagFrame;
    Info: TFileInfo;
    VendorString: String;
    FirstOGGPage: TMemoryStream;
    WritePadding: Boolean;
    PaddingSizeToWrite: Integer;
    UpperCaseFieldNamesToWrite: Boolean;
    ParsePlayTime: Boolean;
    DeepOpusBitRateScan: Boolean;
    Format: TOggFormat;
    VorbisData: TMemoryStream;
    Constructor Create;
    Destructor Destroy; override;
    procedure FillDefault;
    function LoadFromFile(FileName: String): Integer;
    function LoadFromStream(Stream: TStream): Integer;
    function SaveToFile(FileName: String): Integer;
    function SaveToStream(Stream: TStream): Integer;
    function AddFrame(Name: String): TOpusTagFrame;
    function DeleteFrame(FrameIndex: Integer): Boolean;
    procedure DeleteAllFrames;
    procedure DeleteAllCoverArts;
    procedure Clear;
    function Count: Integer;
    function CoverArtCount: Integer;
    function FrameExists(Name: String): Integer; overload;
    function FrameTypeCount(Name: String): Integer;
    function CalculateTotalFramesSize: Integer;
    function CalculateTagSize(IncludePadding: Boolean): Integer;
    function AddTextFrame(Name: String; Text: String): Integer;
    function AddBinaryFrame(Name: String; BinaryStream: TStream): Boolean;
    function SetBinaryFrame(FrameIndex: Integer; BinaryStream: TStream): Boolean;
    procedure SetTextFrameText(Name: String; Text: String);
    procedure SetListFrameText(Name: String; List: TStrings);
    function ReadFrameByNameAsText(Name: String): String;
    function ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
    function ReadBinaryFrame(FrameIndex: Integer; BinaryStream: TStream): Boolean; overload;
    function ReadBinaryFrame(Name: String; BinaryStream: TStream): Boolean; overload;
    procedure RemoveEmptyFrames;
    function AddCoverArtFrame(PictureStream: TStream; CoverArtInfo: TOpusVorbisCoverArtInfo): Integer;
    function SetCoverArtFrame(Index: Integer; PictureStream: TStream; CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
    function GetCoverArtFromFrame(Index: Integer; var PictureStream: TStream; var CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
    function GetCoverArtInfo(Index: Integer; var CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
    function DeleteFrameByName(Name: String): Boolean;
    function Assign(Source: TOpusTag): Boolean;
    procedure SetTagItem(const Data: String; DataStream: TMemoryStream);
    procedure ReadTag(const Source: TStream; OGGStream: TOGGStream);
    function GetInfo(SourceFile: TStream): Boolean;
    function BuildTag(var Stream: TMemoryStream; PaddingSize: Cardinal): Boolean;
    function AdjustPadding(TagSize: Integer): Boolean;
  end;

function RemoveOpusTagFromFile(FileName: String): Integer;
function RemoveOpusTagFromStream(Stream: TStream): Integer;

function OpusTagErrorCode2String(ErrorCode: Integer): String;

function RebuildFile(FileName: String; Info: TFileInfo; TagOGGStream: TStream; ReplaceMode: Boolean; Format: TOggFormat; Stream: TStream = nil): Integer;

procedure CalculateCRC(var CRC: Cardinal; const Data; Size: Cardinal);
function SetCRC(const Destination: TStream; Header: TOggHeader): Boolean;

function ReverseBytes(Value: Cardinal): Cardinal;

procedure EncodeStream(Input, Output: TStream);
procedure DecodeStream(Input, Output: TStream);

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

Const
  DecodeTable: array [0 .. 127] of Integer = (Byte('='), 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
    64, 64, 64, 64, 64, 64, 62, 64, 64, 64, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 64, 64, 64, 64, 64, 64, 64, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 64, 64, 64, 64, 64, 64, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 64, 64, 64, 64, 64);

var
  EncodeTable: array [0 .. 63] of Byte;

type
  PPacket = ^TPacket;

  TPacket = packed record
    case Integer of
      0:
        (b0, b1, b2, b3: Byte);
      1:
        (i: Integer);
      2:
        (a: array [0 .. 3] of Byte);
      3:
        (c: array [0 .. 3] of Byte);
  end;

var
  OpusTagLibraryWritePadding: Boolean = DEFAULT_WRITE_PADDING;
  OpusTagLibraryPaddingSize: Cardinal = DEFAULT_PADDING_SIZE;
  OpusTagLibraryDefaultUpperCaseFieldNamesToWrite: Boolean = DEFAULT_UPPERCASE_FIELD_NAMES;
  OpusTagLibraryDefaultParsePlayTime: Boolean = DEFAULT_PARSE_PLAYTIME;
  OpusTagLibraryDefaultOpusDeepBitRateScan: Boolean = DEFAULT_OPUS_DEEP_BITRATE_SCAN;

implementation

{$IFDEF MSWINDOWS}

Uses
  Windows;
{$ENDIF}
{$IFDEF POSIX}

Uses
  Posix.UniStd,
  Posix.StdIO;
{$ENDIF}

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

procedure EncodePacket(const Packet: TPacket; NumChars: Integer; OutBuf: PByte);
begin
  OutBuf[0] := EncodeTable[Packet.a[0] shr 2];
  OutBuf[1] := EncodeTable[((Packet.a[0] shl 4) or (Packet.a[1] shr 4)) and $0000003F];
  if NumChars < 2 then
    OutBuf[2] := Ord('=')
  else
    OutBuf[2] := EncodeTable[((Packet.a[1] shl 2) or (Packet.a[2] shr 6)) and $0000003F];
  if NumChars < 3 then
    OutBuf[3] := Ord('=')
  else
    OutBuf[3] := EncodeTable[Packet.a[2] and $0000003F];
end;

function DecodePacket(InBuf: PByte; var nChars: Integer): TPacket;
begin
  Result.a[0] := (DecodeTable[InBuf[0]] shl 2) or (DecodeTable[InBuf[1]] shr 4);
  nChars := 1;
  if InBuf[2] <> Ord('=') then
  begin
    Inc(nChars);
    Result.a[1] := Byte((DecodeTable[InBuf[1]] shl 4) or (DecodeTable[InBuf[2]] shr 2));
  end;
  if InBuf[3] <> Ord('=') then
  begin
    Inc(nChars);
    Result.a[2] := Byte((DecodeTable[InBuf[2]] shl 6) or DecodeTable[InBuf[3]]);
  end;
end;

procedure EncodeStream(Input, Output: TStream);
type
  PInteger = ^Integer;
var
  InBuf: array [0 .. 509] of Byte;
  OutBuf: array [0 .. 1023] of Byte;
  BufPtr: PByte;
  I, J, { K, } BytesRead: Integer;
  Packet: TPacket;
begin
  // K := 0;
  repeat
    BytesRead := Input.Read(InBuf, SizeOf(InBuf));
    I := 0;
    BufPtr := @OutBuf[0];
    while I < BytesRead do
    begin
      if BytesRead - I < 3 then
        J := BytesRead - I
      else
        J := 3;
      Packet.i := 0;
      Packet.b0 := InBuf[I];
      if J > 1 then
        Packet.b1 := InBuf[I + 1];
      if J > 2 then
        Packet.b2 := InBuf[I + 2];
      EncodePacket(Packet, J, BufPtr);
      Inc(I, 3);
      Inc(BufPtr, 4);
      // Inc(K, 4);
    end;
    Output.Write(OutBuf, BufPtr - PChar(@OutBuf));
  until BytesRead = 0;
end;

procedure DecodeStream(Input, Output: TStream);
var
  InBuf: array [0 .. 75] of Byte;
  OutBuf: array [0 .. 60] of Byte;
  InBufPtr, OutBufPtr: PByte;
  I, J, K, BytesRead: Integer;
  Packet: TPacket;

  procedure SkipWhite;
  var
    c: Char;
    NumRead: Integer;
  begin
    while True do
    begin
      FillChar(c, SizeOf(c), 0);
      NumRead := Input.Read(c, 1);
      if NumRead = 1 then
      begin
        if c in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/', '='] then
        begin
          Input.Position := Input.Position - 1;
          Break;
        end;
      end
      else
        Break;
    end;
  end;

  function ReadInput: Integer;
  var
    WhiteFound, EndReached: Boolean;
    CntRead, Idx, IdxEnd: Integer;
  begin
    IdxEnd := 0;
    repeat
      WhiteFound := False;
      CntRead := Input.Read(InBuf[IdxEnd], (SizeOf(InBuf) - IdxEnd));
      EndReached := CntRead < (SizeOf(InBuf) - IdxEnd);
      Idx := IdxEnd;
      IdxEnd := CntRead + IdxEnd;
      while (Idx < IdxEnd) do
      begin
        if not(Char(InBuf[Idx]) in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/', '=']) then
        begin
          Dec(IdxEnd);
          if Idx < IdxEnd then
            Move(InBuf[Idx + 1], InBuf[Idx], IdxEnd - Idx);
          WhiteFound := True;
        end
        else
          Inc(Idx);
      end;
    until (not WhiteFound) or (EndReached);
    Result := IdxEnd;
  end;

begin
  repeat
    SkipWhite;
    BytesRead := ReadInput;
    InBufPtr := @InBuf[0];
    OutBufPtr := @OutBuf;
    I := 0;
    while I < BytesRead do
    begin
      Packet := DecodePacket(InBufPtr, J);
      K := 0;
      while J > 0 do
      begin
        OutBufPtr^ := Byte(Packet.a[K]);
        Inc(OutBufPtr);
        Dec(J);
        Inc(K);
      end;
      Inc(InBufPtr, 4);
      Inc(I, 4);
    end;
    Output.Write(OutBuf, OutBufPtr - PByte(@OutBuf));
  until BytesRead = 0;
end;

function ReverseBytes(Value: Cardinal): Cardinal;
begin
  Result := (Value SHR 24) OR (Value SHL 24) OR ((Value AND $00FF0000) SHR 8) OR ((Value AND $0000FF00) SHL 8);
end;

function ValidOggHeader(OggHeader: TOggHeader): Boolean; inline;
begin
  if
{$IFDEF NEXTGEN}
    (OggHeader.ID[1] <> Ord(OGG_PAGE_ID[0])) OR (OggHeader.ID[2] <> Ord(OGG_PAGE_ID[1])) OR (OggHeader.ID[3] <> Ord(OGG_PAGE_ID[2])) OR (OggHeader.ID[4] <> Ord(OGG_PAGE_ID[3]))
{$ELSE}
  (OggHeader.ID[1] <> Ord(OGG_PAGE_ID[1])) OR (OggHeader.ID[2] <> Ord(OGG_PAGE_ID[2])) OR (OggHeader.ID[3] <> Ord(OGG_PAGE_ID[3])) OR (OggHeader.ID[4] <> Ord(OGG_PAGE_ID[4]))
{$ENDIF}
  then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
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

function TOGGStream.GetNextPageHeader(var OggHeader: TOggHeader; Stream: TStream): Boolean;
var
  Position: UInt64;
  PageSize: Integer;
begin
  Result := False;
  try
    FillChar(OggHeader, SizeOf(TOggHeader), 0);
    Position := FStream.Position;
    FStream.Read(OggHeader, SizeOf(TOggHeader) - SizeOf(OggHeader.LacingValues));
    if NOT ValidOggHeader(OggHeader) then
    begin
      FStream.Seek(Position, soBeginning);
      Exit;
    end;
    FStream.Read(OggHeader.LacingValues, OggHeader.Segments);
    PageSize := GetPageSize(OggHeader);
    // PageHeaderSize := GetPageHeaderSize(Header);
    // DataSize := GetPageDataSize(Header);
    FStream.Seek(-(SizeOf(TOggHeader) - SizeOf(OggHeader.LacingValues)) - OggHeader.Segments, soCurrent);
    if Assigned(Stream) then
    begin
      Stream.CopyFrom(FStream, PageSize);
    end
    else
    begin
      FStream.Seek(PageSize, soCurrent);
    end;
    Inc(LastPageQueried);
    Result := True;
  except
    // Result := False;
  end;
end;

function TOGGStream.CreateTagStream(TagStream: TStream; OutputOGGStream: TStream; StartPageNumber: Cardinal = 1): Integer;
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
    Header.PageNumber := StartPageNumber;
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

function TOGGStream.CreateTagStreamVorbis(TagSize: Integer; TagStream: TStream; OutputOGGStream: TStream): Integer;
var
  Header: TOggHeader;
  DataSize: Integer;
  i: Integer;
  OGGPage: TMemoryStream;
  TagSegments: Integer;
  TagDataSize: Integer;
begin
  try
    Result := 0;
    Header := FirstOGGHeader;
    Header.TypeFlag := 0;
    Header.AbsolutePosition := 0 { - 1 };
    // Header.PageNumber := 1;
    Header.Checksum := 0;
    OGGPage := TMemoryStream.Create;
    try
      while TagStream.Position < TagStream.Size do
      begin
        FillChar(Header.LacingValues, SizeOf(Header.LacingValues), 0);
        if TagSize > 0 then
        begin
          if TagSize > OGG_PAGE_SEGMENT_SIZE * High(Byte) then
          begin
            DataSize := OGG_PAGE_SEGMENT_SIZE * High(Byte);
            Header.Segments := OGG_PAGE_SEGMENT_SIZE;
            for i := 1 to High(Header.LacingValues) do
            begin
              Header.LacingValues[i] := $FF;
            end;
            Dec(TagSize, DataSize);
          end
          else
          begin
            DataSize := TagSize;
            Dec(TagSize, DataSize);
            if DataSize MOD $FF = 0 then
            begin
              Header.Segments := DataSize div $FF;
            end
            else
            begin
              Header.Segments := (DataSize div $FF) + 1;
            end;
            TagSegments := Header.Segments;
            TagDataSize := DataSize;
            for i := 1 to Header.Segments do
            begin
              Header.LacingValues[i] := $FF;
            end;
            if DataSize mod $FF <> 0 then
            begin
              Header.LacingValues[Header.Segments] := (DataSize mod $FF);
            end;
            DataSize := TagStream.Size - TagStream.Position;
            if (DataSize - TagDataSize) MOD $FF = 0 then
            begin
              Header.Segments := Header.Segments + ((DataSize - TagDataSize) div $FF);
            end
            else
            begin
              Header.Segments := Header.Segments + ((DataSize - TagDataSize) div $FF) + 1;
            end;
            for i := TagSegments + 1 to Header.Segments do
            begin
              Header.LacingValues[i] := $FF;
            end;
            if ((DataSize - TagDataSize) mod $FF) <> 0 then
            begin
              Header.LacingValues[Header.Segments] := ((DataSize - TagDataSize) mod $FF);
            end;
          end;
        end
        else
        begin
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

function TOGGStream.CalculateWrappedStreamSizeVorbis(TagSize: Integer; InputDataSize: Integer): Integer;
var
  Header: TOggHeader;
  DataSize: Integer;
  DataLeft: Integer;
  // TagSegments: Integer;
  TagDataSize: Integer;
begin
  try
    Result := 0;
    DataLeft := InputDataSize;
    while DataLeft > 0 do
    begin
      if TagSize > 0 then
      begin

        if TagSize > OGG_PAGE_SEGMENT_SIZE * High(Byte) then
        begin
          DataSize := OGG_PAGE_SEGMENT_SIZE * High(Byte);
          Header.Segments := OGG_PAGE_SEGMENT_SIZE;
          Dec(TagSize, DataSize);
        end
        else
        begin
          DataSize := TagSize;
          Dec(TagSize, DataSize);
          if DataSize MOD $FF = 0 then
          begin
            Header.Segments := DataSize div $FF;
          end
          else
          begin
            Header.Segments := (DataSize div $FF) + 1;
          end;
          // TagSegments := Header.Segments;
          TagDataSize := DataSize;

          DataSize := DataLeft;
          if (DataSize - TagDataSize) MOD $FF = 0 then
          begin
            Header.Segments := Header.Segments + ((DataSize - TagDataSize) div $FF);
          end
          else
          begin
            Header.Segments := Header.Segments + ((DataSize - TagDataSize) div $FF) + 1;
          end;

        end;
        {
          if TagSize > OGG_PAGE_SEGMENT_SIZE * High(Byte) then begin
          DataSize := OGG_PAGE_SEGMENT_SIZE * High(Byte);
          Header.Segments := OGG_PAGE_SEGMENT_SIZE;
          Dec(TagSize, DataSize);
          end else begin
          DataSize := TagSize;
          Dec(TagSize, DataSize);
          if DataSize MOD $FF = 0 then begin
          Header.Segments := DataSize div $FF;
          end else begin
          Header.Segments := (DataSize div $FF) + 1;
          end;
          TagSegments := Header.Segments;
          TagDataSize := DataSize;
          DataSize := DataLeft;
          if (DataSize - TagDataSize) div $FF = 0 then begin
          Header.Segments := Header.Segments + ((DataSize - TagDataSize) div $FF);
          end else begin
          Header.Segments := Header.Segments + ((DataSize - TagDataSize) div $FF) + 1;
          end;
          end;
        }
      end
      else
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

function TOGGStream.CalculateWrappedStreamSizeEx(InputDataSize: Integer; MustFitSize: Integer; var PaddingNeeded: Integer): Integer;
var
  Header: TOggHeader;
  DataSize: Integer;
  DataLeft: Integer;
begin
  try
    Result := 0;
    DataLeft := InputDataSize + MustFitSize;
    while DataLeft > 0 do
    begin
      if (DataLeft > OGG_PAGE_SEGMENT_SIZE * High(Byte)) OR (DataLeft < MustFitSize) then
      begin
        DataSize := OGG_PAGE_SEGMENT_SIZE * High(Byte);
        Header.Segments := OGG_PAGE_SEGMENT_SIZE;
        if DataLeft < MustFitSize then
        begin
          PaddingNeeded := DataSize - MustFitSize;
        end;
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

function TOGGStream.ReNumberPages(PageNumberStartsFrom: Int64; Source, Destination: TStream): Boolean;
var
  Header: TOggHeader;
  OGGPage: TMemoryStream;
  PageCounter: Int64;
begin
  try
    FillChar(Header, SizeOf(TOggHeader), 0);
    PageCounter := PageNumberStartsFrom;
    OGGPage := TMemoryStream.Create;
    try
      while Source.Position < Source.Size do
      begin
        OGGPage.Clear;
        GetNextPage(OGGPage);
        OGGPage.Seek(0, soBeginning);
        OGGPage.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
        OGGPage.Read(Header.LacingValues, Header.Segments);
        OGGPage.Seek(0, soBeginning);
        Header.PageNumber := { Header.PageNumber + } PageCounter;
        Header.Checksum := 0;
        OGGPage.Write(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
        OGGPage.Seek(0, soBeginning);
        SetCRC(OGGPage, Header);
        OGGPage.Seek(0, soBeginning);
        Destination.CopyFrom(OGGPage, OGGPage.Size);
        Inc(PageCounter);
      end;
      Result := True;
    finally
      FreeAndNil(OGGPage);
    end;
  except
    Result := False;
  end;
end;

function TOGGStream.ReNumberPagesTheora(PageNumberStartsFrom: Int64; Source, Destination: TStream): Boolean;
var
  Header: TOggHeader;
  OGGPage: TMemoryStream;
begin
  try
    FillChar(Header, SizeOf(TOggHeader), 0);
    OGGPage := TMemoryStream.Create;
    try
      while Source.Position < Source.Size do
      begin
        OGGPage.Clear;
        GetNextPage(OGGPage);
        OGGPage.Seek(0, soBeginning);
        OGGPage.Read(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
        OGGPage.Read(Header.LacingValues, Header.Segments);
        if FirstOGGHeader.Serial = Header.Serial then
        begin
          OGGPage.Seek(0, soBeginning);
          Header.PageNumber := Header.PageNumber + PageNumberStartsFrom;
          Header.Checksum := 0;
          OGGPage.Write(Header, SizeOf(TOggHeader) - SizeOf(Header.LacingValues));
          OGGPage.Seek(0, soBeginning);
          SetCRC(OGGPage, Header);
        end;
        OGGPage.Seek(0, soBeginning);
        Destination.CopyFrom(OGGPage, OGGPage.Size);
      end;
      Result := True;
    finally
      FreeAndNil(OGGPage);
    end;
  except
    Result := False;
  end;
end;

Constructor TOpusTagFrame.Create(Parent: TOpusTag);
begin
  Inherited Create;
  Self.Parent := Parent;
  Name := '';
  Stream := TMemoryStream.Create;
  Format := otffUnknown;
end;

Destructor TOpusTagFrame.Destroy;
begin
  FreeAndNil(Stream);
  Inherited;
end;

function TOpusTagFrame.GetAsText: String;
var
  i: Integer;
  Data: Byte;
  Bytes: TBytes;
begin
  Result := '';
  if Format = otffCoverArt then
  begin
    Result := 'COVER ART BINARY ' + Bytes2MB(Stream.Size);
    Exit;
  end;
  if Format = otffBinary then
  begin
    Result := 'BINARY ' + Bytes2MB(Stream.Size);
    Exit;
  end;
  if Format <> otffText then
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
end;

function TOpusTagFrame.SetAsText(Text: String): Boolean;
var
  Bytes: TBytes;
begin
  Bytes := TEncoding.UTF8.GetBytes(Text);
  Stream.Clear;
  Stream.Write(Bytes[0], Length(Bytes));
  Stream.Seek(0, soBeginning);
  Format := otffText;
  Result := True;
end;

function TOpusTagFrame.SetAsList(List: TStrings): Boolean;
var
  i: Integer;
  Data: Byte;
  Name: TBytes;
  Value: TBytes;
begin
  Stream.Clear;
  for i := 0 to List.Count - 1 do
  begin
    Name := TEncoding.UTF8.GetBytes(List.Names[i]);
    Value := TEncoding.UTF8.GetBytes(List.ValueFromIndex[i]);
    Stream.Write(Name[0], Length(Name));
    Data := $0D;
    Stream.Write(Data, 1);
    Data := $0A;
    Stream.Write(Data, 1);
    Stream.Write(Value, Length(Value));
    Data := $0D;
    Stream.Write(Data, 1);
    Data := $0A;
    Stream.Write(Data, 1);
  end;
  Stream.Seek(0, soBeginning);
  Format := otffText;
  Result := True;
end;

function TOpusTagFrame.GetAsList(var List: TStrings): Boolean;
var
  Data: Byte;
  Bytes: TBytes;
  Name: String;
  Value: String;
  ByteCounter: Integer;
begin
  Result := False;
  List.Clear;
  if Format <> otffText then
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
      Bytes[ByteCounter] := Data;
      Inc(ByteCounter);
    until Stream.Position >= Stream.Size;
    Name := TEncoding.UTF8.GetString(Bytes);
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
      Bytes[ByteCounter] := Data;
      Inc(ByteCounter);
    until Stream.Position >= Stream.Size;
    Value := TEncoding.UTF8.GetString(Bytes);
    List.Append(Name + '=' + Value);
    Result := True;
  end;
  Stream.Seek(0, soBeginning);
end;

function TOpusTagFrame.IsCoverArt: Boolean;
begin
  Result := Format = otffCoverArt;
end;

procedure TOpusTagFrame.Clear;
begin
  Format := otffUnknown;
  Stream.Clear;
end;

function TOpusTagFrame.CalculateTotalFrameSize: Integer;
begin
  Result := Length(Name) + 1 + Stream.Size;
end;

function TOpusTagFrame.Assign(OpusTagFrame: TOpusTagFrame): Boolean;
begin
  Clear;
  if OpusTagFrame <> nil then
  begin
    Format := OpusTagFrame.Format;
    OpusTagFrame.Stream.Seek(0, soBeginning);
    Stream.CopyFrom(OpusTagFrame.Stream, OpusTagFrame.Stream.Size);
    Stream.Seek(0, soBeginning);
    OpusTagFrame.Stream.Seek(0, soBeginning);
  end;
  Result := True;
end;

Constructor TOpusTag.Create;
begin
  Inherited;
  Clear;
  FillDefault;
  FirstOGGPage := TMemoryStream.Create;
  WritePadding := OpusTagLibraryWritePadding;
  PaddingSizeToWrite := OpusTagLibraryPaddingSize;
  UpperCaseFieldNamesToWrite := OpusTagLibraryDefaultUpperCaseFieldNamesToWrite;
  ParsePlayTime := OpusTagLibraryDefaultParsePlayTime;
  DeepOpusBitRateScan := OpusTagLibraryDefaultOpusDeepBitRateScan;
  VorbisData := TMemoryStream.Create;
end;

Destructor TOpusTag.Destroy;
begin
  Clear;
  FreeAndNil(FirstOGGPage);
  FreeAndNil(VorbisData);
  Inherited;
end;

procedure TOpusTag.FillDefault;
begin
{$IFDEF OVAOTL_MOBILE}
  Info.FPage.ID[1] := Ord(OGG_PAGE_ID[0]);
  Info.FPage.ID[2] := Ord(OGG_PAGE_ID[1]);
  Info.FPage.ID[3] := Ord(OGG_PAGE_ID[2]);
  Info.FPage.ID[4] := Ord(OGG_PAGE_ID[3]);
{$ELSE}
  Info.FPage.ID[1] := Ord(OGG_PAGE_ID[1]);
  Info.FPage.ID[2] := Ord(OGG_PAGE_ID[2]);
  Info.FPage.ID[3] := Ord(OGG_PAGE_ID[3]);
  Info.FPage.ID[4] := Ord(OGG_PAGE_ID[4]);
{$ENDIF}
  Info.FPage.StreamVersion := 0;
  Info.FPage.TypeFlag := 0;
  Info.FPage.AbsolutePosition := 0;
  Info.FPage.Serial := 0;
  Info.FPage.PageNumber := 1;
  Info.FPage.Checksum := 0;
  Info.FPage.Segments := 1;
  Info.FPage.LacingValues[1] := 19;

{$IFDEF OVAOTL_MOBILE}
  Info.SPage.ID[1] := Ord(OGG_PAGE_ID[0]);
  Info.SPage.ID[2] := Ord(OGG_PAGE_ID[1]);
  Info.SPage.ID[3] := Ord(OGG_PAGE_ID[2]);
  Info.SPage.ID[4] := Ord(OGG_PAGE_ID[3]);
{$ELSE}
  Info.SPage.ID[1] := Ord(OGG_PAGE_ID[1]);
  Info.SPage.ID[2] := Ord(OGG_PAGE_ID[2]);
  Info.SPage.ID[3] := Ord(OGG_PAGE_ID[3]);
  Info.SPage.ID[4] := Ord(OGG_PAGE_ID[4]);
{$ENDIF}
  Info.SPage.StreamVersion := 0;
  Info.SPage.TypeFlag := 0;
  Info.SPage.AbsolutePosition := 0;
  Info.SPage.Serial := 0;
  Info.SPage.PageNumber := 2;
  Info.SPage.Checksum := 0;
  Info.SPage.Segments := 1;
  Info.SPage.LacingValues[1] := 19;

{$IFDEF OVAOTL_MOBILE}
  Info.OpusParameters.ID[1] := Ord(OPUS_PARAMETERS_ID[0]);
  Info.OpusParameters.ID[2] := Ord(OPUS_PARAMETERS_ID[1]);
  Info.OpusParameters.ID[3] := Ord(OPUS_PARAMETERS_ID[2]);
  Info.OpusParameters.ID[4] := Ord(OPUS_PARAMETERS_ID[3]);
  Info.OpusParameters.ID[5] := Ord(OPUS_PARAMETERS_ID[4]);
  Info.OpusParameters.ID[6] := Ord(OPUS_PARAMETERS_ID[5]);
  Info.OpusParameters.ID[7] := Ord(OPUS_PARAMETERS_ID[6]);
  Info.OpusParameters.ID[8] := Ord(OPUS_PARAMETERS_ID[7]);
{$ELSE}
  Info.OpusParameters.ID[1] := Ord(OPUS_PARAMETERS_ID[1]);
  Info.OpusParameters.ID[2] := Ord(OPUS_PARAMETERS_ID[2]);
  Info.OpusParameters.ID[3] := Ord(OPUS_PARAMETERS_ID[3]);
  Info.OpusParameters.ID[4] := Ord(OPUS_PARAMETERS_ID[4]);
  Info.OpusParameters.ID[5] := Ord(OPUS_PARAMETERS_ID[5]);
  Info.OpusParameters.ID[6] := Ord(OPUS_PARAMETERS_ID[6]);
  Info.OpusParameters.ID[7] := Ord(OPUS_PARAMETERS_ID[7]);
  Info.OpusParameters.ID[8] := Ord(OPUS_PARAMETERS_ID[8]);
{$ENDIF}
  Info.OpusParameters.BitstreamVersion := 0;
  Info.OpusParameters.ChannelCount := 0;
  Info.OpusParameters.PreSkip := 0;
  Info.OpusParameters.SampleRate := 0;
  Info.OpusParameters.OutputGain := 0;
  Info.OpusParameters.MappingFamily := 0;

{$IFDEF OVAOTL_MOBILE}
  Info.Tag.ID[1] := Ord(OPUS_TAG_ID[0]);
  Info.Tag.ID[2] := Ord(OPUS_TAG_ID[1]);
  Info.Tag.ID[3] := Ord(OPUS_TAG_ID[2]);
  Info.Tag.ID[4] := Ord(OPUS_TAG_ID[3]);
  Info.Tag.ID[5] := Ord(OPUS_TAG_ID[4]);
  Info.Tag.ID[6] := Ord(OPUS_TAG_ID[5]);
  Info.Tag.ID[7] := Ord(OPUS_TAG_ID[6]);
  Info.Tag.ID[8] := Ord(OPUS_TAG_ID[7]);
{$ELSE}
  Info.Tag.ID[1] := Ord(OPUS_TAG_ID[1]);
  Info.Tag.ID[2] := Ord(OPUS_TAG_ID[2]);
  Info.Tag.ID[3] := Ord(OPUS_TAG_ID[3]);
  Info.Tag.ID[4] := Ord(OPUS_TAG_ID[4]);
  Info.Tag.ID[5] := Ord(OPUS_TAG_ID[5]);
  Info.Tag.ID[6] := Ord(OPUS_TAG_ID[6]);
  Info.Tag.ID[7] := Ord(OPUS_TAG_ID[7]);
  Info.Tag.ID[8] := Ord(OPUS_TAG_ID[8]);
{$ENDIF}
  Info.Tag.Fields := 0;
{$IFDEF OVAOTL_MOBILE}
  Info.VorbisTag.ID[1] := Ord(VORBIS_TAG_ID[0]);
  Info.VorbisTag.ID[2] := Ord(VORBIS_TAG_ID[1]);
  Info.VorbisTag.ID[3] := Ord(VORBIS_TAG_ID[2]);
  Info.VorbisTag.ID[4] := Ord(VORBIS_TAG_ID[3]);
  Info.VorbisTag.ID[5] := Ord(VORBIS_TAG_ID[4]);
  Info.VorbisTag.ID[6] := Ord(VORBIS_TAG_ID[5]);
  Info.VorbisTag.ID[7] := Ord(VORBIS_TAG_ID[6]);
{$ELSE}
  Info.VorbisTag.ID[1] := Ord(VORBIS_TAG_ID[1]);
  Info.VorbisTag.ID[2] := Ord(VORBIS_TAG_ID[2]);
  Info.VorbisTag.ID[3] := Ord(VORBIS_TAG_ID[3]);
  Info.VorbisTag.ID[4] := Ord(VORBIS_TAG_ID[4]);
  Info.VorbisTag.ID[5] := Ord(VORBIS_TAG_ID[5]);
  Info.VorbisTag.ID[6] := Ord(VORBIS_TAG_ID[6]);
  Info.VorbisTag.ID[7] := Ord(VORBIS_TAG_ID[7]);
{$ENDIF}
{$IFDEF OVAOTL_MOBILE}
  Info.TheoraHeader.ID[1] := Ord(THEORA_TAG_ID[0]);
  Info.TheoraHeader.ID[2] := Ord(THEORA_TAG_ID[1]);
  Info.TheoraHeader.ID[3] := Ord(THEORA_TAG_ID[2]);
  Info.TheoraHeader.ID[4] := Ord(THEORA_TAG_ID[3]);
  Info.TheoraHeader.ID[5] := Ord(THEORA_TAG_ID[4]);
  Info.TheoraHeader.ID[6] := Ord(THEORA_TAG_ID[5]);
  Info.TheoraHeader.ID[7] := Ord(THEORA_TAG_ID[6]);
{$ELSE}
  Info.TheoraHeader.ID[1] := Ord(THEORA_TAG_ID[1]);
  Info.TheoraHeader.ID[2] := Ord(THEORA_TAG_ID[2]);
  Info.TheoraHeader.ID[3] := Ord(THEORA_TAG_ID[3]);
  Info.TheoraHeader.ID[4] := Ord(THEORA_TAG_ID[4]);
  Info.TheoraHeader.ID[5] := Ord(THEORA_TAG_ID[5]);
  Info.TheoraHeader.ID[6] := Ord(THEORA_TAG_ID[6]);
  Info.TheoraHeader.ID[7] := Ord(THEORA_TAG_ID[7]);
{$ENDIF}
  Info.SPagePos := 47;
end;

procedure TOpusTag.DeleteAllCoverArts;
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

function TOpusTag.CoverArtCount: Integer;
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

procedure TOpusTag.DeleteAllFrames;
var
  i: Integer;
begin
  for i := 0 to Length(Frames) - 1 do
  begin
    FreeAndNil(Frames[i]);
  end;
  SetLength(Frames, 0);
end;

function TOpusTag.LoadFromStream(Stream: TStream): Integer;
var
  PreviousPosition: Int64;
begin
  Result := OPUSTAGLIBRARY_ERROR;
  Loaded := False;
  Format := ofUnknown;
  Clear;
  try
    PreviousPosition := Stream.Position;
    try
      Stream.Seek(0, soBeginning);
      Loaded := GetInfo(Stream);
    finally
      Stream.Seek(PreviousPosition, soBeginning);
    end;
    if Loaded then
    begin
      Result := OPUSTAGLIBRARY_SUCCESS;
    end;
  except
    Result := OPUSTAGLIBRARY_ERROR;
  end;
end;

function TOpusTag.LoadFromFile(FileName: String): Integer;
var
  FileStream: TFileStream;
begin
  // Clear;
  Loaded := False;
  Format := ofUnknown;
  if NOT FileExists(FileName) then
  begin
    Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
  except
    Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
    Exit;
  end;
  try
    Result := LoadFromStream(FileStream);
    if (Result = OPUSTAGLIBRARY_SUCCESS) OR (Result = OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION) then
    begin
      Self.FileName := FileName;
    end;
  finally
    FreeAndNil(FileStream);
  end;
end;

function TOpusTag.AddFrame(Name: String): TOpusTagFrame;
begin
  Result := nil;
  try
    SetLength(Frames, Length(Frames) + 1);
    Frames[Length(Frames) - 1] := TOpusTagFrame.Create(Self);
    Frames[Length(Frames) - 1].Name := Name;
    Frames[Length(Frames) - 1].Index := Length(Frames) - 1;
    Result := Frames[Length(Frames) - 1];
  except
    // *
  end;
end;

function TOpusTag.DeleteFrame(FrameIndex: Integer): Boolean;
var
  i: Integer;
  J: Integer;
begin
  Result := False;
  if (FrameIndex >= Length(Frames)) OR (FrameIndex < 0) then
  begin
    Exit;
  end;
  FreeAndNil(Frames[FrameIndex]);
  i := 0;
  J := 0;
  while i <= Length(Frames) - 1 do
  begin
    if Frames[i] <> nil then
    begin
      Frames[J] := Frames[i];
      Frames[J].Index := i;
      Inc(J);
    end;
    Inc(i);
  end;
  SetLength(Frames, J);
  Result := True;
end;

function TOpusTag.FrameExists(Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Length(Frames) - 1 do
  begin
    if UpperCase(Name) = UpperCase(Frames[i].Name) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TOpusTag.FrameTypeCount(Name: String): Integer;
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

function TOpusTag.BuildTag(var Stream: TMemoryStream; PaddingSize: Cardinal): Boolean;
var
  Fields, Size: Integer;
  Bytes: TBytes;
  i: Integer;
  Data: Byte;
begin
  Result := False;
  Fields := Count;
  // Write frame ID, vendor info and number of fields
  if Format = ofOpus then
  begin
    Stream.Write(Info.Tag.ID, SizeOf(Info.Tag.ID));
  end;
  if Format = ofVorbis then
  begin
    Stream.Write(Info.VorbisTag.ID, SizeOf(Info.VorbisTag.ID));
  end;
  if Format = ofTheora then
  begin
    Stream.Write(Info.TheoraHeader.ID, SizeOf(Info.TheoraHeader.ID));
  end;
  Bytes := TEncoding.UTF8.GetBytes(VendorString);
  Size := Length(Bytes);
  Stream.Write(Size, SizeOf(Size));
  Stream.Write(Bytes[0], Length(Bytes));
  Stream.Write(Fields, SizeOf(Fields));
  // Write tag fields
  for i := 0 to Count - 1 do
  begin
    if UpperCaseFieldNamesToWrite then
    begin
      Size := Length(UpperCase(Frames[i].Name)) + 1 + Frames[i].Stream.Size;
    end
    else
    begin
      Size := Length(Frames[i].Name) + 1 + Frames[i].Stream.Size;
    end;
    Stream.Write(Size, SizeOf(Size));
    SetLength(Bytes, 0);
    if UpperCaseFieldNamesToWrite then
    begin
      Bytes := TEncoding.UTF8.GetBytes(UpperCase(Frames[i].Name));
    end
    else
    begin
      Bytes := TEncoding.UTF8.GetBytes(Frames[i].Name);
    end;
    Stream.Write(Bytes[0], Length(Bytes));
    Data := Ord('=');
    Stream.Write(Data, 1);
    Frames[i].Stream.Seek(0, soBeginning);
    Stream.CopyFrom(Frames[i].Stream, Frames[i].Stream.Size);
    Frames[i].Stream.Seek(0, soBeginning);
  end;

  if Format = ofVorbis then
  begin
    Data := 1;
    Stream.Write(Data, 1);
  end;

  for i := 0 to PaddingSize - 1 do
  begin
    Data := 0;
    Stream.Write(Data, 1);
  end;
  {
    if Format = ofVorbis then begin
    VorbisData.Seek(0, soBeginning);
    Stream.CopyFrom(VorbisData, VorbisData.Size)
    end;
  }
  Stream.Seek(0, soBeginning);
end;

function TOpusTag.CalculateTagSize(IncludePadding: Boolean): Integer;
var
  TotalTagSize: Integer;
  Bytes: TBytes;
  PaddingFrameIndex: Integer;
begin
  TotalTagSize := CalculateTotalFramesSize;
  Bytes := TEncoding.UTF8.GetBytes(VendorString);
  TotalTagSize := 8 + 4 + Length(Bytes) + 4 + TotalTagSize;
  if NOT IncludePadding then
  begin
    PaddingFrameIndex := FrameExists('PADDING');
    if PaddingFrameIndex > -1 then
    begin
      TotalTagSize := TotalTagSize - Frames[PaddingFrameIndex].CalculateTotalFrameSize;
    end;
  end;
  // * Not needed becouse vorbis tag header is exactly 1 less then Opus
  // if Format = ofVorbis then begin
  // Inc(TotalTagSize);
  // end;
  Result := TotalTagSize;
end;

function TOpusTag.CalculateTotalFramesSize: Integer;
var
  TotalFramesSize: Integer;
  i: Integer;

begin
  TotalFramesSize := 0;
  for i := 0 to Length(Frames) - 1 do
  begin
    TotalFramesSize := TotalFramesSize + Frames[i].CalculateTotalFrameSize + 4;
  end;
  Result := TotalFramesSize;
end;

procedure TOpusTag.Clear;
begin
  DeleteAllFrames;
  FileName := '';
  Loaded := False;
  VendorString := '';
  FillChar(Info.ChannelMapping, SizeOf(Info.ChannelMapping), 0);
end;

function TOpusTag.Count: Integer;
begin
  Result := Length(Frames);
end;

function TOpusTag.AddTextFrame(Name: String; Text: String): Integer;
begin
  with AddFrame(Name) do
  begin
    SetAsText(Text);
    Result := Index;
  end;
end;

function TOpusTag.AddBinaryFrame(Name: String; BinaryStream: TStream): Boolean;
var
  FrameIndex: Integer;
begin
  FrameIndex := AddFrame(Name).Index;
  Result := SetBinaryFrame(FrameIndex, BinaryStream);
end;

function TOpusTag.SetBinaryFrame(FrameIndex: Integer; BinaryStream: TStream): Boolean;
var
  PreviousPosition: Int64;
  EncodedStream: TMemoryStream;
begin
  Result := False;
  if (FrameIndex >= Length(Frames)) OR (FrameIndex < 0) then
  begin
    Exit;
  end;
  EncodedStream := TMemoryStream.Create;
  try
    PreviousPosition := BinaryStream.Position;
    BinaryStream.Seek(0, soBeginning);
    EncodeStream(BinaryStream, EncodedStream);
    EncodedStream.Seek(0, soBeginning);
    Frames[FrameIndex].Stream.Clear;
    Frames[FrameIndex].Stream.CopyFrom(EncodedStream, EncodedStream.Size);
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
    Frames[FrameIndex].Format := otffBinary;
    BinaryStream.Seek(PreviousPosition, soBeginning);
    Result := True;
  finally
    FreeAndNil(EncodedStream);
  end;
end;

function TOpusTag.ReadBinaryFrame(Name: String; BinaryStream: TStream): Boolean;
var
  FrameIndex: Integer;
begin
  Result := False;
  FrameIndex := FrameExists(Name);
  if FrameIndex = -1 then
  begin
    Exit;
  end;
  Result := ReadBinaryFrame(FrameIndex, BinaryStream);
end;

function TOpusTag.ReadBinaryFrame(FrameIndex: Integer; BinaryStream: TStream): Boolean;
var
  DecodedStream: TMemoryStream;
begin
  Result := False;
  if (FrameIndex >= Length(Frames)) OR (FrameIndex < 0) then
  begin
    Exit;
  end;
  DecodedStream := TMemoryStream.Create;
  try
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
    DecodeStream(Frames[FrameIndex].Stream, DecodedStream);
    DecodedStream.Seek(0, soBeginning);
    BinaryStream.CopyFrom(DecodedStream, DecodedStream.Size);
  finally
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
    FreeAndNil(DecodedStream);
  end;
end;

procedure TOpusTag.SetTextFrameText(Name: String; Text: String);
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

procedure TOpusTag.SetListFrameText(Name: String; List: TStrings);
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

function TOpusTag.ReadFrameByNameAsText(Name: String): String;
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
    Result := Frames[i].GetAsText;
  end;
end;

procedure TOpusTag.ReadOpusAudioAttributes(Stream: TStream);
var
  PreviousPosition: Int64;
begin
  PreviousPosition := Stream.Position;
  try
    Stream.Seek($1C, soBeginning);
    Stream.Read(Info.OpusParameters, SizeOf(Info.OpusParameters));
  finally
    Stream.Seek(PreviousPosition, soBeginning);
  end;
end;

function TOpusTag.ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
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
    if Frames[i].Format = otffText then
    begin
      Result := Frames[i].GetAsList(List);
    end;
  end;
end;

procedure TOpusTag.RemoveEmptyFrames;
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

function TOpusTag.AddCoverArtFrame(PictureStream: TStream; CoverArtInfo: TOpusVorbisCoverArtInfo): Integer;
begin
  try
    Result := AddFrame(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE).Index;
    if NOT SetCoverArtFrame(Result, PictureStream, CoverArtInfo) then
    begin
      DeleteFrame(Result);
      Result := -1;
    end;
  except
    Result := -1;
  end;
end;

function TOpusTag.SetCoverArtFrame(Index: Integer; PictureStream: TStream; CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
var
  MIMETypeLength: Cardinal;
  DescriptionLength: Cardinal;
  LengthOfPictureData: Cardinal;
  Bytes: TBytes;
  EncodedStream: TMemoryStream;
  NewStream: TMemoryStream;
begin
  Result := False;
  if Frames[Index].Name <> OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE then
  begin
    Exit;
  end;
  try
    try
      with CoverArtInfo do
      begin
        NewStream := TMemoryStream.Create;
        EncodedStream := TMemoryStream.Create;
        Frames[Index].Stream.Clear;
        PictureType := ReverseBytes(PictureType);
        NewStream.Write(PictureType, 4);
        MIMEType := LowerCase(MIMEType);
        MIMETypeLength := ReverseBytes(Length(MIMEType));
        NewStream.Write(MIMETypeLength, 4);
        Bytes := TEncoding.UTF8.GetBytes(MIMEType);
        NewStream.Write(Bytes[0], Length(Bytes));
        SetLength(Bytes, 0);
        Bytes := TEncoding.UTF8.GetBytes(Description);
        DescriptionLength := ReverseBytes(Length(Bytes));
        NewStream.Write(DescriptionLength, 4);
        NewStream.Write(Bytes[0], Length(Bytes));
        Width := ReverseBytes(Width);
        NewStream.Write(Width, 4);
        Height := ReverseBytes(Height);
        NewStream.Write(Height, 4);
        ColorDepth := ReverseBytes(ColorDepth);
        NewStream.Write(ColorDepth, 4);
        NoOfColors := ReverseBytes(NoOfColors);
        NewStream.Write(NoOfColors, 4);
        if Assigned(PictureStream) then
        begin
          LengthOfPictureData := ReverseBytes(PictureStream.Size);
          NewStream.Write(LengthOfPictureData, 4);
          PictureStream.Seek(0, soBeginning);
          NewStream.CopyFrom(PictureStream, PictureStream.Size);
        end;
        NewStream.Seek(0, soBeginning);
        EncodeStream(NewStream, EncodedStream);
        EncodedStream.Seek(0, soBeginning);
        Frames[Index].Stream.CopyFrom(EncodedStream, EncodedStream.Size);
        Frames[Index].Stream.Seek(0, soBeginning);
      end;
      Result := True;
    finally
      Frames[Index].Format := otffCoverArt;
      FreeAndNil(EncodedStream);
      FreeAndNil(NewStream);
    end;
  except
    Result := False;
  end;
end;

function TOpusTag.GetCoverArtFromFrame(Index: Integer; var PictureStream: TStream; var CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
var
  MIMETypeLength: Cardinal;
  DescriptionLength: Cardinal;
  LengthOfPictureData: Cardinal;
  Bytes: TBytes;
  DecodedStream: TMemoryStream;
begin
  Result := False;
  with CoverArtInfo do
  begin
    PictureType := 0;
    MIMEType := '';
    Description := '';
    Width := 0;
    Height := 0;
    ColorDepth := 0;
    NoOfColors := 0;
  end;
  if Frames[Index].Name <> OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE then
  begin
    Exit;
  end;
  try
    try
      with CoverArtInfo do
      begin
        DecodedStream := TMemoryStream.Create;
        Frames[Index].Stream.Seek(0, soBeginning);
        DecodeStream(Frames[Index].Stream, DecodedStream);
        DecodedStream.Seek(0, soBeginning);
        DecodedStream.Read(PictureType, 4);
        PictureType := ReverseBytes(PictureType);
        DecodedStream.Read(MIMETypeLength, 4);
        MIMETypeLength := ReverseBytes(MIMETypeLength);
        SetLength(Bytes, MIMETypeLength);
        DecodedStream.Read(Bytes[0], MIMETypeLength);
        CoverArtInfo.MIMEType := TEncoding.UTF8.GetString(Bytes);
        DecodedStream.Read(DescriptionLength, 4);
        DescriptionLength := ReverseBytes(DescriptionLength);
        SetLength(Bytes, DescriptionLength);
        DecodedStream.Read(Bytes[0], DescriptionLength);
        Description := TEncoding.UTF8.GetString(Bytes);
        DecodedStream.Read(Width, 4);
        Width := ReverseBytes(Width);
        DecodedStream.Read(Height, 4);
        Height := ReverseBytes(Height);
        DecodedStream.Read(ColorDepth, 4);
        ColorDepth := ReverseBytes(ColorDepth);
        DecodedStream.Read(NoOfColors, 4);
        NoOfColors := ReverseBytes(NoOfColors);
        DecodedStream.Read(LengthOfPictureData, 4);
        LengthOfPictureData := ReverseBytes(LengthOfPictureData);
        SizeOfPictureData := LengthOfPictureData;
        PictureStream.CopyFrom(DecodedStream, LengthOfPictureData);
        PictureStream.Seek(0, soBeginning);
      end;
      Result := True;
    finally
      FreeAndNil(DecodedStream);
    end;
  except
    Result := False;
  end;
end;

function TOpusTag.GetCoverArtInfo(Index: Integer; var CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
var
  DataByte: Byte;
  MIMETypeLength: Cardinal;
  DescriptionLength: Cardinal;
  LengthOfPictureData: Cardinal;
  Bytes: TBytes;
  DecodedStream: TMemoryStream;
begin
  Result := False;
  with CoverArtInfo do
  begin
    PictureType := 0;
    MIMEType := '';
    Description := '';
    Width := 0;
    Height := 0;
    ColorDepth := 0;
    NoOfColors := 0;
  end;
  if Frames[Index].Name <> OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE then
  begin
    Exit;
  end;
  try
    try
      with CoverArtInfo do
      begin
        DecodedStream := TMemoryStream.Create;
        Frames[Index].Stream.Seek(0, soBeginning);
        DecodeStream(Frames[Index].Stream, DecodedStream);
        DecodedStream.Seek(0, soBeginning);
        DecodedStream.Read(PictureType, 4);
        PictureType := ReverseBytes(PictureType);
        DecodedStream.Read(MIMETypeLength, 4);
        MIMETypeLength := ReverseBytes(MIMETypeLength);
        SetLength(Bytes, MIMETypeLength);
        DecodedStream.Read(Bytes[0], MIMETypeLength);
        CoverArtInfo.MIMEType := TEncoding.UTF8.GetString(Bytes);
        DecodedStream.Read(DescriptionLength, 4);
        DescriptionLength := ReverseBytes(DescriptionLength);
        SetLength(Bytes, DescriptionLength);
        DecodedStream.Read(DataByte, 1);
        Description := TEncoding.UTF8.GetString(Bytes);
        DecodedStream.Read(Width, 4);
        Width := ReverseBytes(Width);
        DecodedStream.Read(Height, 4);
        Height := ReverseBytes(Height);
        DecodedStream.Read(ColorDepth, 4);
        ColorDepth := ReverseBytes(ColorDepth);
        DecodedStream.Read(NoOfColors, 4);
        NoOfColors := ReverseBytes(NoOfColors);
        DecodedStream.Read(LengthOfPictureData, 4);
        LengthOfPictureData := ReverseBytes(LengthOfPictureData);
        SizeOfPictureData := LengthOfPictureData;
      end;
      Result := True;
    finally
      FreeAndNil(DecodedStream);
    end;
  except
    Result := False;
  end;
end;

function TOpusTag.DeleteFrameByName(Name: String): Boolean;
var
  i: Integer;
  l: Integer;
  J: Integer;
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
  J := 0;
  while i <= l - 1 do
  begin
    if Frames[i] <> nil then
    begin
      Frames[J] := Frames[i];
      Inc(J);
    end;
    Inc(i);
  end;
  SetLength(Frames, J);
  Result := True;
end;

function TOpusTag.Assign(Source: TOpusTag): Boolean;
var
  i: Integer;
begin
  Clear;
  FileName := Source.FileName;
  Format := Source.Format;
  Loaded := Source.Loaded;
  // VendorString := Source.VendorString;
  for i := 0 to Length(Source.Frames) - 1 do
  begin
    AddFrame(Source.Frames[i].Name).Assign(Source.Frames[i]);
  end;
  Result := True;
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

procedure TOpusTag.SetTagItem(const Data: String; DataStream: TMemoryStream);
var
  Separator: Integer;
  FieldID: string;
begin
  Separator := Pos('=', Data);
  if Separator > 0 then
  begin
    FieldID := UpperCase(Copy(Data, 1, Separator - 1));
    with AddFrame(FieldID) do
    begin
      DataStream.Seek(Separator, soBeginning);
      if DataStream.Size - Separator > 0 then
      begin
        Stream.CopyFrom(DataStream, DataStream.Size - Separator);
      end;
      if FieldID = OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE then
      begin
        Format := otffCoverArt;
      end
      else
      begin
        Format := otffText;
      end;
    end;
  end;
end;

procedure TOpusTag.ReadTag(const Source: TStream; OGGStream: TOGGStream);
var
  Index, Size, Position: Integer;
  Bytes: TBytes;
  DataStream: TMemoryStream;
  PreviousPosition: Int64;
  DataByte: Byte;
  TempString: String;
begin
  // * Read vendor string
  Source.Read(Size, SizeOf(Size));
  // Position := Source.Position;
  SetLength(Bytes, Size);
  Source.Read(Bytes[0], Size);
  VendorString := TEncoding.UTF8.GetString(Bytes);
  // * Read tag count
  Source.Read(Info.Tag.Fields, SizeOf(Info.Tag.Fields));
  if Info.Tag.Fields > 0 then
  begin
    // Read Opus tag
    DataStream := TMemoryStream.Create;
    try
      Index := 1;
      repeat
        DataStream.Clear;
        SetLength(Bytes, 0);
        // * Query more data if needed
        PreviousPosition := Source.Position;
        while Source.Position + SizeOf(Size) > Source.Size do
        begin
          Source.Seek(0, soEnd);
          OGGStream.GetNextPageData(Source);
          Source.Seek(PreviousPosition, soBeginning);
        end;
        // * Read in tag size
        Source.Read(Size, SizeOf(Size));
        Position := Source.Position;
        // * Query more data if needed
        PreviousPosition := Source.Position;
        while Source.Position + Size > Source.Size do
        begin
          Source.Seek(0, soEnd);
          OGGStream.GetNextPageData(Source);
          Source.Seek(PreviousPosition, soBeginning);
        end;
        // * Read tag data (to extract tag name)
        SetLength(Bytes, Size);
        Source.Read(Bytes[0], Size);
        // * Read tag data in stream
        Source.Seek(Position, soBeginning);
        DataStream.CopyFrom(Source, Size);
        // Add Opus tag item
        TempString := TEncoding.UTF8.GetString(Bytes);
        SetTagItem(TempString, DataStream);
        Source.Seek(Position + Size, soFromBeginning);
        Inc(Index);
      until Index > Info.Tag.Fields;
      // Info.TagEndPos := OGGStream.FStream.Position;
    finally
      FreeAndNil(DataStream);
    end;
  end;
  if (Format = ofVorbis) then
  begin
    Source.Seek(1, soFromCurrent);
    repeat
      Source.Read(DataByte, 1);
    until (DataByte <> 0) OR (DataByte = 5) OR (Source.Size <= Source.Position);
    VorbisData.Clear;
    if Source.Size - Source.Position > 0 then
    begin
      Source.Seek(-1, soFromCurrent);
      VorbisData.CopyFrom(Source, Source.Size - Source.Position);
    end;
  end;
  if (Format = ofTheora) then
  begin
    {
      Source.Seek(1, soFromCurrent);
      repeat
      Source.Read(DataByte, 1);
      until (DataByte <> 0)
      OR (DataByte = 5)
      OR (Source.Size <= Source.Position);
    }
    VorbisData.Clear;
    if Source.Size - Source.Position > 0 then
    begin
      // Source.Seek(- 1, soFromCurrent);
      VorbisData.CopyFrom(Source, Source.Size - Source.Position);
    end;
  end;
  // if Format = ofOpus then begin
  Info.TagEndPos := OGGStream.FStream.Position;
  // end;
end;

procedure TOpusTag.ReadVorbisAudioAttributes(Stream: TStream);
var
  PreviousPosition: Int64;
begin
  PreviousPosition := Stream.Position;
  try
    Stream.Seek($1C, soBeginning);
    Stream.Read(Info.VorbisParameters, SizeOf(Info.VorbisParameters));
  finally
    Stream.Seek(PreviousPosition, soBeginning);
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

function TOpusTag.GetInfo(SourceFile: TStream): Boolean;
var
  OGGStream: TOGGStream;
  Data: TMemoryStream;
  OpusTags: TOpusTags;
  VorbisHeader: TVorbisHeader;
  // TheoraHeader: TTheoraHeader;
  TheoraTagID: Array [1 .. 7] of Byte;
  TheoraPageCounter: Integer;
  OggHeader: TOggHeader;
  OggDataSize: UInt64;
begin
  Result := False;
  Info.ID3v2Size := GetID3v2Size(SourceFile);
  Info.FileSize := SourceFile.Size;
  SourceFile.Seek(Info.ID3v2Size, soFromBeginning);
  OGGStream := TOGGStream.Create(SourceFile);
  try
    if
{$IFDEF OVAOTL_MOBILE}
      (OGGStream.FirstOGGHeader.ID[1] <> Ord(OGG_PAGE_ID[0])) OR (OGGStream.FirstOGGHeader.ID[2] <> Ord(OGG_PAGE_ID[1])) OR (OGGStream.FirstOGGHeader.ID[3] <> Ord(OGG_PAGE_ID[2])) OR
      (OGGStream.FirstOGGHeader.ID[4] <> Ord(OGG_PAGE_ID[3]))
{$ELSE}
    (OGGStream.FirstOGGHeader.ID[1] <> Ord(OGG_PAGE_ID[1])) OR (OGGStream.FirstOGGHeader.ID[2] <> Ord(OGG_PAGE_ID[2])) OR (OGGStream.FirstOGGHeader.ID[3] <> Ord(OGG_PAGE_ID[3])) OR
      (OGGStream.FirstOGGHeader.ID[4] <> Ord(OGG_PAGE_ID[4]))
{$ENDIF}
    then
    begin
      Exit;
    end;
    FirstOGGPage.Clear;
    OGGStream.GetNextPageData(FirstOGGPage);
    Info.SPagePos := OGGStream.FStream.Position;
    // * This will be re-set after all the tags are parsed
    Info.TagEndPos := OGGStream.FStream.Position;
    Data := TMemoryStream.Create;
    try
      OGGStream.GetNextPageData(Data);
      // * Check if Opus
      Data.Seek(0, soBeginning);
      Data.Read(OpusTags.ID, SizeOf(OpusTags.ID));
      if
{$IFDEF OVAOTL_MOBILE}
        (OpusTags.ID[1] = Ord(OPUS_TAG_ID[0])) AND (OpusTags.ID[2] = Ord(OPUS_TAG_ID[1])) AND (OpusTags.ID[3] = Ord(OPUS_TAG_ID[2])) AND (OpusTags.ID[4] = Ord(OPUS_TAG_ID[3])) AND
        (OpusTags.ID[5] = Ord(OPUS_TAG_ID[4])) AND (OpusTags.ID[6] = Ord(OPUS_TAG_ID[5])) AND (OpusTags.ID[7] = Ord(OPUS_TAG_ID[6])) AND (OpusTags.ID[8] = Ord(OPUS_TAG_ID[7]))
{$ELSE}
      (OpusTags.ID[1] = Ord(OPUS_TAG_ID[1])) AND (OpusTags.ID[2] = Ord(OPUS_TAG_ID[2])) AND (OpusTags.ID[3] = Ord(OPUS_TAG_ID[3])) AND (OpusTags.ID[4] = Ord(OPUS_TAG_ID[4])) AND
        (OpusTags.ID[5] = Ord(OPUS_TAG_ID[5])) AND (OpusTags.ID[6] = Ord(OPUS_TAG_ID[6])) AND (OpusTags.ID[7] = Ord(OPUS_TAG_ID[7])) AND (OpusTags.ID[8] = Ord(OPUS_TAG_ID[8]))
{$ENDIF}
      then
      begin
        Format := ofOpus;
        ReadOpusAudioAttributes(SourceFile);
        ReadTag(Data, OGGStream);
        Result := True;
      end
      else
      begin
        // * Check if Vorbis
        Data.Seek(0, soBeginning);
        Data.Read(VorbisHeader.ID, SizeOf(VorbisHeader.ID));
        if
{$IFDEF OVAOTL_MOBILE}
          (VorbisHeader.ID[1] = Ord(VORBIS_TAG_ID[0])) AND (VorbisHeader.ID[2] = Ord(VORBIS_TAG_ID[1])) AND (VorbisHeader.ID[3] = Ord(VORBIS_TAG_ID[2])) AND (VorbisHeader.ID[4] = Ord(VORBIS_TAG_ID[3])
          ) AND (VorbisHeader.ID[5] = Ord(VORBIS_TAG_ID[4])) AND (VorbisHeader.ID[6] = Ord(VORBIS_TAG_ID[5])) AND (VorbisHeader.ID[7] = Ord(VORBIS_TAG_ID[6]))
{$ELSE}
        (VorbisHeader.ID[1] = Ord(VORBIS_TAG_ID[1])) AND (VorbisHeader.ID[2] = Ord(VORBIS_TAG_ID[2])) AND (VorbisHeader.ID[3] = Ord(VORBIS_TAG_ID[3])) AND (VorbisHeader.ID[4] = Ord(VORBIS_TAG_ID[4]))
          AND (VorbisHeader.ID[5] = Ord(VORBIS_TAG_ID[5])) AND (VorbisHeader.ID[6] = Ord(VORBIS_TAG_ID[6])) AND (VorbisHeader.ID[7] = Ord(VORBIS_TAG_ID[7]))
{$ENDIF}
        then
        begin
          Format := ofVorbis;
          ReadVorbisAudioAttributes(SourceFile);
          ReadTag(Data, OGGStream);
          Result := True;
        end
        else
        begin
          // * Check if theora
          (*
            Data.Seek(0, soBeginning);
            Data.Read(TheoraHeader.ID, SizeOf(TTheoraHeader));
            if
            {$IFDEF OVAOTL_MOBILE}
            (TheoraHeader.ID[1] = Ord(THEORA_ID[0]))
            AND (TheoraHeader.ID[2] = Ord(THEORA_ID[1]))
            AND (TheoraHeader.ID[3] = Ord(THEORA_ID[2]))
            AND (TheoraHeader.ID[4] = Ord(THEORA_ID[3]))
            AND (TheoraHeader.ID[5] = Ord(THEORA_ID[4]))
            AND (TheoraHeader.ID[6] = Ord(THEORA_ID[5]))
            AND (TheoraHeader.ID[7] = Ord(THEORA_ID[6]))
            {$ELSE}
            (TheoraHeader.ID[1] = Ord(THEORA_ID[1]))
            AND (TheoraHeader.ID[2] = Ord(THEORA_ID[2]))
            AND (TheoraHeader.ID[3] = Ord(THEORA_ID[3]))
            AND (TheoraHeader.ID[4] = Ord(THEORA_ID[4]))
            AND (TheoraHeader.ID[5] = Ord(THEORA_ID[5]))
            AND (TheoraHeader.ID[6] = Ord(THEORA_ID[6]))
            AND (TheoraHeader.ID[7] = Ord(THEORA_ID[7]))
            {$ENDIF}
            then begin
            Format := ofTheora;
            //ReadTheoraAttributes(SourceFile);
          *)
          TheoraPageCounter := 0;
          repeat
            Info.SPagePos := OGGStream.FStream.Position;
            Data.Clear;
            OGGStream.GetNextPageData(Data);
            Data.Seek(0, soBeginning);
            Data.Read(TheoraTagID, SizeOf(TheoraTagID));
            if
{$IFDEF OVAOTL_MOBILE}
              (TheoraTagID[1] = Ord(THEORA_TAG_ID[0])) AND (TheoraTagID[2] = Ord(THEORA_TAG_ID[1])) AND (TheoraTagID[3] = Ord(THEORA_TAG_ID[2])) AND (TheoraTagID[4] = Ord(THEORA_TAG_ID[3])) AND
              (TheoraTagID[5] = Ord(THEORA_TAG_ID[4])) AND (TheoraTagID[6] = Ord(THEORA_TAG_ID[5])) AND (TheoraTagID[7] = Ord(THEORA_TAG_ID[6]))
{$ELSE}
            (TheoraTagID[1] = Ord(THEORA_TAG_ID[1])) AND (TheoraTagID[2] = Ord(THEORA_TAG_ID[2])) AND (TheoraTagID[3] = Ord(THEORA_TAG_ID[3])) AND (TheoraTagID[4] = Ord(THEORA_TAG_ID[4])) AND
              (TheoraTagID[5] = Ord(THEORA_TAG_ID[5])) AND (TheoraTagID[6] = Ord(THEORA_TAG_ID[6])) AND (TheoraTagID[7] = Ord(THEORA_TAG_ID[7]))
{$ENDIF}
            then
            begin
              Format := ofTheora;
              ReadTag(Data, OGGStream);
              Result := True;
              Break;
            end;
            Inc(TheoraPageCounter);
          until TheoraPageCounter > 16;
        end;
      end;
      Info.HeaderOggPageCount := OGGStream.LastPageQueried;
      if ParsePlayTime then
      begin
        if (Format = ofVorbis) OR (Format = ofOpus) then
        begin
          Info.SampleCount := GetSamples(SourceFile);
          Info.PlayTime := GetPlayTime;
          if (Format = ofVorbis) AND (Info.VorbisParameters.BitRateNominal <> 0) then
          begin
            Info.BitRate := Info.VorbisParameters.BitRateNominal div 1000;
          end
          else
          begin
            Info.BitRate := Round((Info.FileSize - Info.TagEndPos) / Info.PlayTime / 125);
            if DeepOpusBitRateScan then
            begin
              OGGStream.FStream.Seek(Info.TagEndPos, soFromBeginning);
              OggDataSize := 0;
              while OGGStream.GetNextPageHeader(OggHeader) do
              begin
                OggDataSize := OggDataSize + GetPageDataSize(OggHeader);
              end;
              Info.BitRate := Round(OggDataSize / Info.PlayTime / 125);
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(Data);
    end;
  finally
    FreeAndNil(OGGStream);
  end;
end;

function TOpusTag.GetPlayTime: Double;
begin
  Result := 0;
  if Format = ofVorbis then
  begin
    { Calculate duration time }
    if Info.SampleCount > 0 then
    begin
      if Info.VorbisParameters.SampleRate > 0 then
      begin
        Result := Info.SampleCount / Info.VorbisParameters.SampleRate;
      end;
    end
    else
    begin
      if (Info.VorbisParameters.BitRateNominal > 0) and (Info.VorbisParameters.ChannelMode > 0) then
      begin
        Result := (Info.FileSize - Info.ID3v2Size) / Info.VorbisParameters.BitRateNominal / Info.VorbisParameters.ChannelMode / 125 * 2
      end;
    end;
  end;
  if Format = ofOpus then
  begin
    { Calculate duration time }
    if Info.SampleCount > 0 then
    begin
      Result := Info.SampleCount / 48000;
    end;
  end;
end;

function RemoveOpusTagFromFile(FileName: String): Integer;
var
  OpusTag: TOpusTag;
  i: Integer;
begin
  Result := OPUSTAGLIBRARY_ERROR;
  OpusTag := TOpusTag.Create;
  try
    OpusTag.LoadFromFile(FileName);
    if OpusTag.Loaded then
    begin
      for i := OpusTag.Count - 1 downto 0 do
      begin
        if OpusTag.Frames[i].Name <> 'ENCODER' then
        begin
          OpusTag.DeleteFrame(i);
        end;
      end;
      Result := OpusTag.SaveToFile(FileName);
    end;
  finally
    FreeAndNil(OpusTag);
  end;
end;

function RemoveOpusTagFromStream(Stream: TStream): Integer;
var
  OpusTag: TOpusTag;
  i: Integer;
begin
  Result := OPUSTAGLIBRARY_ERROR;
  OpusTag := TOpusTag.Create;
  try
    Stream.Seek(0, soBeginning);
    OpusTag.LoadFromStream(Stream);
    if OpusTag.Loaded then
    begin
      for i := OpusTag.Count - 1 downto 0 do
      begin
        if OpusTag.Frames[i].Name <> 'ENCODER' then
        begin
          OpusTag.DeleteFrame(i);
        end;
      end;
      Stream.Seek(0, soBeginning);
      Result := OpusTag.SaveToStream(Stream);
    end;
  finally
    FreeAndNil(OpusTag);
  end;
end;

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

function TOpusTag.AdjustPadding(TagSize: Integer): Boolean;
var
  Tag: TMemoryStream;
  NewOGGTagStream: TMemoryStream;
  ProcessingOGGStream: TOGGStream;
  NewTagSize: Integer;
  NewWrappedTagSize: Integer;
  TmpString: String;
  PaddingFrameIndex: Integer;
  i: Integer;
  ExistingPaddingSize: Integer;
  PaddingSize: Integer;
  WritePaddingLocal: Boolean;
begin
  Result := False;
  PaddingSize := PaddingSizeToWrite;
  WritePaddingLocal := WritePadding;
  if (NOT WritePaddingLocal) OR (PaddingSizeToWrite = 0) then
  begin
    DeleteFrame(FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING));
    WritePaddingLocal := False;
  end
  else
  begin
    if PaddingSizeToWrite < Length(OPUSTAGLIBRARY_FRAMENAME_PADDING) + 1 + 4 + 1 then
    begin
      PaddingSize := Length(OPUSTAGLIBRARY_FRAMENAME_PADDING) + 1 + 4 + 1;
    end;
  end;
  Tag := TMemoryStream.Create;
  NewOGGTagStream := TMemoryStream.Create;
  ProcessingOGGStream := TOGGStream.Create(nil);
  try
    NewTagSize := CalculateTagSize(False);
    NewWrappedTagSize := ProcessingOGGStream.CalculateWrappedStreamSize(NewTagSize);
    if NewWrappedTagSize = TagSize then
    begin
      DeleteFrame(FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING));
      Result := True;
    end
    else
    begin
      if WritePaddingLocal then
      begin
        NewTagSize := CalculateTagSize(True);
        NewWrappedTagSize := ProcessingOGGStream.CalculateWrappedStreamSize(NewTagSize);
        if NewWrappedTagSize = TagSize then
        begin
          Result := True;
          Exit;
        end;
        ExistingPaddingSize := 0;
        PaddingFrameIndex := FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING);
        if PaddingFrameIndex > -1 then
        begin
          ExistingPaddingSize := Frames[PaddingFrameIndex].CalculateTotalFrameSize;
        end;
        if (TagSize - NewWrappedTagSize) > PaddingSize then
        begin
          Result := False;
          Exit;
        end;
        if (NewWrappedTagSize < TagSize) AND (Length(OPUSTAGLIBRARY_FRAMENAME_PADDING) + 1 + 4 < TagSize) AND (ExistingPaddingSize < PaddingSize) then
        begin
          TmpString := ReadFrameByNameAsText(OPUSTAGLIBRARY_FRAMENAME_PADDING);
          repeat
            TmpString := TmpString + OPUSTAGLIBRARY_PADDING_BYTE;
            if Length(TmpString) + Length(OPUSTAGLIBRARY_FRAMENAME_PADDING) + 1 + 4 > PaddingSize then
            begin
              DeleteFrame(FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING));
              Result := False;
              Break;
            end;
            SetTextFrameText(OPUSTAGLIBRARY_FRAMENAME_PADDING, TmpString);
            NewTagSize := CalculateTagSize(True);
            NewWrappedTagSize := ProcessingOGGStream.CalculateWrappedStreamSize(NewTagSize);
          until NewWrappedTagSize >= TagSize;
          if NewWrappedTagSize = TagSize then
          begin
            Result := True;
          end;
        end;
        if (NewWrappedTagSize > TagSize) AND (ExistingPaddingSize > 0) then
        begin
          TmpString := ReadFrameByNameAsText(OPUSTAGLIBRARY_FRAMENAME_PADDING);
          repeat
            TmpString := Copy(TmpString, 1, Length(TmpString) - 1);
            if TmpString = '' then
            begin
              DeleteFrame(FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING));
              Break;
            end;
            SetTextFrameText(OPUSTAGLIBRARY_FRAMENAME_PADDING, TmpString);
            NewTagSize := CalculateTagSize(True);
            NewWrappedTagSize := ProcessingOGGStream.CalculateWrappedStreamSize(NewTagSize);
          until NewWrappedTagSize <= TagSize;
          if NewWrappedTagSize = TagSize then
          begin
            Result := True;
          end;
        end;
      end;
    end;
    if (NOT Result) AND WritePaddingLocal then
    begin
      PaddingFrameIndex := AddFrame(OPUSTAGLIBRARY_FRAMENAME_PADDING).Index;
      TmpString := '';
      for i := 0 to PaddingSize - Length(OPUSTAGLIBRARY_FRAMENAME_PADDING) - 1 - 4 do
      begin
        TmpString := TmpString + OPUSTAGLIBRARY_PADDING_BYTE;
      end;
      Frames[PaddingFrameIndex].SetAsText(TmpString);
    end;
  finally
    FreeAndNil(Tag);
    FreeAndNil(NewOGGTagStream);
    FreeAndNil(ProcessingOGGStream);
  end;
end;

function RebuildFile(FileName: String; Info: TFileInfo; TagOGGStream: TStream; ReplaceMode: Boolean; Format: TOggFormat; Stream: TStream = nil): Integer;
var
  Source, Destination: TStream;
  BufferName: String;
  NewOGGStream: TOGGStream;

begin
  Source := nil;
  Destination := nil;
  // Rebuild the file with the new Opus tag
  Result := OPUSTAGLIBRARY_ERROR;
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
      Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
      Exit;
    end;
  end;
  try
    // * Check exclusive access
    if (NOT ReplaceMode) AND (NOT Assigned(Stream)) then
    begin
      try
        Destination := TFileStream.Create(FileName, fmOpenReadWrite);
      except
        Result := OPUSTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
        Exit;
      end;
      FreeAndNil(Destination);
    end;
    // Create file streams
    if NOT Assigned(Stream) then
    begin
      try
        Source := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyNone);
      except
        Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
        Exit;
      end;
      if ReplaceMode then
      begin
        Destination := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite);
      end
      else
      begin
        BufferName := FileName + '~';
        Destination := TFileStream.Create(BufferName, fmCreate);
      end;
    end
    else
    begin
      Source := Stream;
      if ReplaceMode then
      begin
        Destination := TMemoryStream.Create;
        Destination.CopyFrom(Stream, 0);
      end
      else
      begin
        Destination := TMemoryStream.Create;
      end;
      Source.Seek(0, soBeginning);
    end;
    try
      // Copy data blocks
      if ReplaceMode then
      begin
        Destination.Seek(Info.SPagePos, soBeginning);
      end
      else
      begin
        Destination.CopyFrom(Source, Info.SPagePos);
      end;
      TagOGGStream.Seek(0, soBeginning);
      Destination.CopyFrom(TagOGGStream, TagOGGStream.Size);
      // * TODO: Optimization: check if OGG page frame numbers do really need re-adjusting
      // if NOT ReplaceMode then begin
      Source.Seek(Info.TagEndPos, soFromBeginning);
      if Source.Size - Info.TagEndPos > 0 then
      begin
        NewOGGStream := TOGGStream.Create(Source);
        if Format = ofTheora then
        begin
          NewOGGStream.ReNumberPagesTheora(Info.DataPageNumberStartsFrom + 1, Source, Destination);
        end
        else
        begin
          NewOGGStream.ReNumberPages(Info.DataPageNumberStartsFrom + 1, Source, Destination);
        end;
        FreeAndNil(NewOGGStream);
      end;
      // end;
    finally
      if NOT Assigned(Stream) then
      begin
        if Assigned(Source) then
        begin
          FreeAndNil(Source);
        end;
      end
      else
      begin
        Stream.Size := 0;
        Stream.Seek(0, soBeginning);
        Stream.CopyFrom(Destination, 0);
        Stream.Seek(0, soBeginning);
      end;
      if Assigned(Destination) then
      begin
        FreeAndNil(Destination);
      end;
    end;
    // Replace old file and delete temporary file
    if NOT Assigned(Stream) then
    begin
      if NOT ReplaceMode then
      begin
        if (DeleteFile(PChar(FileName))) and (RenameFile(BufferName, FileName)) then
        begin
          Result := OPUSTAGLIBRARY_SUCCESS;
        end
        else
        begin
          raise Exception.Create('');
        end;
      end
      else
      begin
        Result := OPUSTAGLIBRARY_SUCCESS;
      end;
    end
    else
    begin
      Result := OPUSTAGLIBRARY_SUCCESS;
    end;
  except
    // Access error
    if FileExists(BufferName) then
    begin
      SysUtils.DeleteFile(BufferName);
    end;
  end;
end;

function TOpusTag.SaveToFile(FileName: String): Integer;
var
  TagStream: TFileStream;
  Tag: TMemoryStream;
  NewFileOpusTag: TOpusTag;
  NewOGGStream: TOGGStream;
  NewOGGTagStream: TMemoryStream;
  OldTagSize: Integer;
  FitsInOldTag: Boolean;
  NewPaddingSize: Integer;
  NewTagSize: Integer;
  NewWrappedTagSize: Integer;
  NewFileCreate: Boolean;
  TheoraTagsSize: Integer;
begin
  // Result := OPUSTAGLIBRARY_ERROR;
  NewFileCreate := False;
  FitsInOldTag := False;
  NewTagSize := 0;
  TagStream := nil;
  NewOGGStream := nil;
  try
    if NOT FileExists(FileName) then
    begin
      // * If we have a first page already use that
      if FirstOGGPage.Size > 0 then
      begin
        FirstOGGPage.SaveToFile(FileName);
        // * If not create one (not valid yet but usefull for exporting an Opus tag because the library can red it back)
      end
      else
      begin
        try
          TagStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite);
          TagStream.Write(Info.FPage, 28);
          TagStream.Write(Info.OpusParameters, 19);
          Info.TagEndPos := 28 + 19;
          NewFileCreate := True;
        except
          Result := OPUSTAGLIBRARY_ERROR_WRITING_FILE;
          Exit;
        end;
        FreeAndNil(TagStream);
      end;
    end;
    try
      TagStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
      // * To get basic data from OGG stream
      NewOGGStream := TOGGStream.Create(TagStream);
    except
      Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
      Exit;
    end;
    FreeAndNil(TagStream);
    NewFileOpusTag := TOpusTag.Create;
    try
      // * Get info about destination
      NewFileOpusTag.LoadFromFile(FileName);
      if NewFileCreate then
      begin
        NewFileOpusTag.Format := ofOpus;
      end
      else
      begin
        if (NewFileOpusTag.Format = ofUnknown)
        // OR (NewFileOpusTag.Format = ofTheora)
        then
        begin
          Result := OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
          Exit;
        end;
      end;
      Format := NewFileOpusTag.Format;
      if NewFileOpusTag.VendorString <> '' then
      begin
        Self.VendorString := NewFileOpusTag.VendorString;
      end
      else
      begin
        if Self.VendorString = '' then
        begin
          Self.VendorString := 'Unknown vendor';
        end;
      end;
      VorbisData.Clear;
      NewFileOpusTag.VorbisData.Seek(0, soBeginning);
      VorbisData.CopyFrom(NewFileOpusTag.VorbisData, NewFileOpusTag.VorbisData.Size);
      OldTagSize := NewFileOpusTag.Info.TagEndPos - NewFileOpusTag.Info.SPagePos;
      // * Check sizes and adjust padding from settings
      if Format = ofOpus then
      begin
        FitsInOldTag := AdjustPadding(OldTagSize);
      end;
      if Format = ofVorbis then
      begin
        DeleteFrame(FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING));
      end;
      // * The new tag streams
      Tag := TMemoryStream.Create;
      NewOGGTagStream := TMemoryStream.Create;
      try
        if Format = ofVorbis then
        begin
          BuildTag(Tag, 0);
          Tag.Seek(0, soEnd);
          VorbisData.Seek(0, soBeginning);
          Tag.CopyFrom(VorbisData, VorbisData.Size);
          // * Wrap it in OGG container
          Tag.Seek(0, soBeginning);
          NewOGGStream.CreateTagStream(Tag, NewOGGTagStream);
          if (NOT WritePadding) OR (PaddingSizeToWrite = 0) then
          begin
            FitsInOldTag := OldTagSize = NewOGGTagStream.Size;
          end
          else
          begin
            FitsInOldTag := OldTagSize >= NewOGGTagStream.Size;
          end;
          // *
        end;
        // * Create a tag stream
        Tag.Clear;
        NewOGGTagStream.Clear;
        if Format = ofVorbis then
        begin
          if FitsInOldTag then
          begin
            NewPaddingSize := -1;
            NewTagSize := CalculateTagSize(False);
            repeat
              Inc(NewPaddingSize);
              NewWrappedTagSize := NewOGGStream.CalculateWrappedStreamSizeVorbis(NewTagSize + NewPaddingSize, NewTagSize + NewPaddingSize + VorbisData.Size);
            until (NewWrappedTagSize >= OldTagSize) OR (NewPaddingSize >= PaddingSizeToWrite);
            FitsInOldTag := NewWrappedTagSize = OldTagSize;
          end;
          if NOT FitsInOldTag then
          begin
            if WritePadding then
            begin
              NewPaddingSize := Self.PaddingSizeToWrite;
              NewOGGStream.CalculateWrappedStreamSizeEx(NewTagSize, VorbisData.Size, NewPaddingSize);
            end
            else
            begin
              NewPaddingSize := 0;
            end;
          end;
          Tag.Clear;
          BuildTag(Tag, NewPaddingSize);
          NewTagSize := Tag.Size;
          Tag.Seek(0, soEnd);
          VorbisData.Seek(0, soBeginning);
          Tag.CopyFrom(VorbisData, VorbisData.Size);
          Tag.Seek(0, soBeginning);
          // * Wrap it in OGG container
          NewOGGStream.FirstOGGHeader.PageNumber := 1;
          NewFileOpusTag.Info.DataPageNumberStartsFrom := NewOGGStream.CreateTagStreamVorbis(NewTagSize, Tag, NewOGGTagStream);
          FitsInOldTag := OldTagSize = NewOGGTagStream.Size;
        end;
        if Format = ofOpus then
        begin
          BuildTag(Tag, 0);
          // * Wrap it in OGG container
          NewOGGTagStream.Clear;
          NewFileOpusTag.Info.DataPageNumberStartsFrom := NewOGGStream.CreateTagStream(Tag, NewOGGTagStream);
        end;
        if Format = ofTheora then
        begin
          BuildTag(Tag, 0);
          TheoraTagsSize := Tag.Size;
          Tag.Seek(0, soEnd);
          VorbisData.Seek(0, soBeginning);
          Tag.CopyFrom(VorbisData, VorbisData.Size);
          Tag.Seek(0, soBeginning);
          // * Wrap it in OGG container
          NewOGGTagStream.Clear;
          try
            NewOGGStream.Free;
            TagStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
            // * To get basic data from OGG stream
            TagStream.Seek(NewFileOpusTag.Info.SPagePos, soBeginning);
            NewOGGStream := TOGGStream.Create(TagStream);
          except
            Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
            Exit;
          end;
          FreeAndNil(TagStream);
          NewFileOpusTag.Info.DataPageNumberStartsFrom := NewOGGStream.CreateTagStreamVorbis(TheoraTagsSize, Tag, NewOGGTagStream) - 2;
        end;
        // * Write the tag to destination
        Result := RebuildFile(FileName, NewFileOpusTag.Info, NewOGGTagStream, FitsInOldTag, Format);
      finally
        FreeAndNil(Tag);
        FreeAndNil(NewOGGTagStream);
      end;
    finally
      FreeAndNil(NewFileOpusTag);
      if Assigned(NewOGGStream) then
      begin
        FreeAndNil(NewOGGStream);
      end;
    end;
  except
    Result := OPUSTAGLIBRARY_ERROR;
  end;
end;

function TOpusTag.SaveToStream(Stream: TStream): Integer;
var
  Tag: TMemoryStream;
  NewFileOpusTag: TOpusTag;
  NewOGGStream: TOGGStream;
  NewOGGTagStream: TMemoryStream;
  OldTagSize: Integer;
  FitsInOldTag: Boolean;
  NewPaddingSize: Integer;
  NewTagSize: Integer;
  NewWrappedTagSize: Integer;
  NewFileCreate: Boolean;
  TheoraTagsSize: Integer;
begin
  // Result := OPUSTAGLIBRARY_ERROR;
  NewFileCreate := False;
  FitsInOldTag := False;
  NewTagSize := 0;
  NewOGGStream := nil;
  try
    if Stream.Size = 0 then
    begin
      // * If we have a first page already use that
      if FirstOGGPage.Size > 0 then
      begin
        Stream.CopyFrom(FirstOGGPage, 0);
        // * If not create one (not valid yet but usefull for exporting an Opus tag because the component can red it back)
      end
      else
      begin
        try
          Stream.Seek(0, soBeginning);
          Stream.Write(Info.FPage, 28);
          Stream.Write(Info.OpusParameters, 19);
          Info.TagEndPos := 28 + 19;
          NewFileCreate := True;
        except
          Result := OPUSTAGLIBRARY_ERROR_WRITING_FILE;
          Exit;
        end;
        // FreeAndNil(TagStream);
      end;
    end;
    try
      Stream.Seek(0, soBeginning);
      // * To get basic data from OGG stream
      NewOGGStream := TOGGStream.Create(Stream);
    except
      Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
      Exit;
    end;
    // FreeAndNil(TagStream);
    NewFileOpusTag := TOpusTag.Create;
    try
      // * Get info about destination
      NewFileOpusTag.LoadFromStream(Stream);
      if NewFileCreate then
      begin
        NewFileOpusTag.Format := ofOpus;
      end
      else
      begin
        if NewFileOpusTag.Format = ofUnknown then
        begin
          Result := OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
          Exit;
        end;
      end;
      Format := NewFileOpusTag.Format;
      if NewFileOpusTag.VendorString <> '' then
      begin
        Self.VendorString := NewFileOpusTag.VendorString;
      end
      else
      begin
        if Self.VendorString = '' then
        begin
          Self.VendorString := 'Unknown vendor';
        end;
      end;
      VorbisData.Clear;
      NewFileOpusTag.VorbisData.Seek(0, soBeginning);
      VorbisData.CopyFrom(NewFileOpusTag.VorbisData, NewFileOpusTag.VorbisData.Size);
      OldTagSize := NewFileOpusTag.Info.TagEndPos - NewFileOpusTag.Info.SPagePos;
      // * Check sizes and adjust padding from settings
      if Format = ofOpus then
      begin
        FitsInOldTag := AdjustPadding(OldTagSize);
      end;
      if Format = ofVorbis then
      begin
        DeleteFrame(FrameExists(OPUSTAGLIBRARY_FRAMENAME_PADDING));
      end;
      // * The new tag streams
      Tag := TMemoryStream.Create;
      NewOGGTagStream := TMemoryStream.Create;
      try
        if Format = ofVorbis then
        begin
          BuildTag(Tag, 0);
          Tag.Seek(0, soEnd);
          VorbisData.Seek(0, soBeginning);
          Tag.CopyFrom(VorbisData, VorbisData.Size);
          // * Wrap it in OGG container
          Tag.Seek(0, soBeginning);
          NewOGGStream.CreateTagStream(Tag, NewOGGTagStream);
          if (NOT WritePadding) OR (PaddingSizeToWrite = 0) then
          begin
            FitsInOldTag := OldTagSize = NewOGGTagStream.Size;
          end
          else
          begin
            FitsInOldTag := OldTagSize >= NewOGGTagStream.Size;
          end;
          // *
        end;
        // * Create a tag stream
        Tag.Clear;
        NewOGGTagStream.Clear;
        if Format = ofVorbis then
        begin
          if FitsInOldTag then
          begin
            NewPaddingSize := -1;
            NewTagSize := CalculateTagSize(False);
            repeat
              Inc(NewPaddingSize);
              NewWrappedTagSize := NewOGGStream.CalculateWrappedStreamSizeVorbis(NewTagSize + NewPaddingSize, NewTagSize + NewPaddingSize + VorbisData.Size);
            until (NewWrappedTagSize >= OldTagSize) OR (NewPaddingSize >= PaddingSizeToWrite);
            FitsInOldTag := NewWrappedTagSize = OldTagSize;
          end;
          if NOT FitsInOldTag then
          begin
            if WritePadding then
            begin
              NewPaddingSize := Self.PaddingSizeToWrite;
              NewOGGStream.CalculateWrappedStreamSizeEx(NewTagSize, VorbisData.Size, NewPaddingSize);
            end
            else
            begin
              NewPaddingSize := 0;
            end;
          end;
          Tag.Clear;
          BuildTag(Tag, NewPaddingSize);
          NewTagSize := Tag.Size;
          Tag.Seek(0, soEnd);
          VorbisData.Seek(0, soBeginning);
          Tag.CopyFrom(VorbisData, VorbisData.Size);
          Tag.Seek(0, soBeginning);
          // * Wrap it in OGG container
          NewOGGStream.FirstOGGHeader.PageNumber := 1;
          NewFileOpusTag.Info.DataPageNumberStartsFrom := NewOGGStream.CreateTagStreamVorbis(NewTagSize, Tag, NewOGGTagStream);
          FitsInOldTag := OldTagSize = NewOGGTagStream.Size;
        end;
        if Format = ofOpus then
        begin
          BuildTag(Tag, 0);
          // * Wrap it in OGG container
          NewOGGTagStream.Clear;
          NewFileOpusTag.Info.DataPageNumberStartsFrom := NewOGGStream.CreateTagStream(Tag, NewOGGTagStream);
        end;
        if Format = ofTheora then
        begin
          BuildTag(Tag, 0);
          TheoraTagsSize := Tag.Size;
          Tag.Seek(0, soEnd);
          VorbisData.Seek(0, soBeginning);
          Tag.CopyFrom(VorbisData, VorbisData.Size);
          Tag.Seek(0, soBeginning);
          // * Wrap it in OGG container
          NewOGGTagStream.Clear;
          try
            NewOGGStream.Free;
            // * To get basic data from OGG stream
            Stream.Seek(NewFileOpusTag.Info.SPagePos, soBeginning);
            NewOGGStream := TOGGStream.Create(Stream);
          except
            Result := OPUSTAGLIBRARY_ERROR_OPENING_FILE;
            Exit;
          end;
          NewFileOpusTag.Info.DataPageNumberStartsFrom := NewOGGStream.CreateTagStreamVorbis(TheoraTagsSize, Tag, NewOGGTagStream) - 2;
        end;
        // * Write the tag to destination
        Result := RebuildFile('', NewFileOpusTag.Info, NewOGGTagStream, FitsInOldTag, Format, Stream);
      finally
        FreeAndNil(Tag);
        FreeAndNil(NewOGGTagStream);
      end;
    finally
      FreeAndNil(NewFileOpusTag);
      if Assigned(NewOGGStream) then
      begin
        FreeAndNil(NewOGGStream);
      end;
    end;
  except
    Result := OPUSTAGLIBRARY_ERROR;
  end;
end;

function TOpusTag.GetSamples(const Source: TStream): Int64;
var
  i: Integer;
  Data: array [0 .. 3] of Byte;
  Header: TOggHeader;
begin
  Result := 0;
  for i := 0 to 10 * 4096 do
  begin
    Source.Seek(Source.Size - (4 + i), soBeginning);
    Source.Read(Data, SizeOf(Data));
    if
{$IFDEF OVAOTL_MOBILE}
      (Data[0] = Ord(OGG_PAGE_ID[0])) AND (Data[1] = Ord(OGG_PAGE_ID[1])) AND (Data[2] = Ord(OGG_PAGE_ID[2])) AND (Data[3] = Ord(OGG_PAGE_ID[3]))
{$ELSE}
    (Data[0] = Ord(OGG_PAGE_ID[1])) AND (Data[1] = Ord(OGG_PAGE_ID[2])) AND (Data[2] = Ord(OGG_PAGE_ID[3])) AND (Data[3] = Ord(OGG_PAGE_ID[4]))
{$ENDIF}
    then
    begin
      Source.Seek(-4, soCurrent);
      Source.Read(Header, SizeOf(TOggHeader));
      Result := Header.AbsolutePosition;
      Exit;
    end;
  end;
end;

function OpusTagErrorCode2String(ErrorCode: Integer): String;
begin
  Result := 'Unknown error code.';
  case ErrorCode of
    OPUSTAGLIBRARY_SUCCESS:
      Result := 'Success.';
    OPUSTAGLIBRARY_ERROR:
      Result := 'Unknown error occured.';
    OPUSTAGLIBRARY_ERROR_NO_TAG_FOUND:
      Result := 'No Opus/Vorbis tags found.';
    OPUSTAGLIBRARY_ERROR_EMPTY_TAG:
      Result := 'Opus/Vorbis tag is empty.';
    OPUSTAGLIBRARY_ERROR_EMPTY_FRAMES:
      Result := 'Opus/Vorbis tag contains only empty frames.';
    OPUSTAGLIBRARY_ERROR_OPENING_FILE:
      Result := 'Error opening file.';
    OPUSTAGLIBRARY_ERROR_READING_FILE:
      Result := 'Error reading file.';
    OPUSTAGLIBRARY_ERROR_WRITING_FILE:
      Result := 'Error writing file.';
    OPUSTAGLIBRARY_ERROR_CORRUPT:
      Result := 'Error: corrupt file.';
    // OPUSTAGLIBRARY_ERROR_DOESNT_FIT: Result := 'Error: WAV LIST INFO chunk doesn''t fit into the file.';
    OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION:
      Result := 'Error: not supported Opus/Vorbis tag version.';
    OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT:
      Result := 'Error: not supported file format.';
    OPUSTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS:
      Result := 'Error: file is locked. Need exclusive access to write Opus/Vorbis tag to this file.';
  end;
end;

Initialization

  EncodeTable[0] := Ord('A');
EncodeTable[1] := Ord('B');
EncodeTable[2] := Ord('C');
EncodeTable[3] := Ord('D');
EncodeTable[4] := Ord('E');
EncodeTable[5] := Ord('F');
EncodeTable[6] := Ord('G');
EncodeTable[7] := Ord('H');
EncodeTable[8] := Ord('I');
EncodeTable[9] := Ord('J');
EncodeTable[10] := Ord('K');
EncodeTable[11] := Ord('L');
EncodeTable[12] := Ord('M');
EncodeTable[13] := Ord('N');
EncodeTable[14] := Ord('O');
EncodeTable[15] := Ord('P');
EncodeTable[16] := Ord('Q');
EncodeTable[17] := Ord('R');
EncodeTable[18] := Ord('S');
EncodeTable[19] := Ord('T');
EncodeTable[20] := Ord('U');
EncodeTable[21] := Ord('V');
EncodeTable[22] := Ord('W');
EncodeTable[23] := Ord('X');
EncodeTable[24] := Ord('Y');
EncodeTable[25] := Ord('Z');

EncodeTable[26] := Ord('a');
EncodeTable[27] := Ord('b');
EncodeTable[28] := Ord('c');
EncodeTable[29] := Ord('d');
EncodeTable[30] := Ord('e');
EncodeTable[31] := Ord('f');
EncodeTable[32] := Ord('g');
EncodeTable[33] := Ord('h');
EncodeTable[34] := Ord('i');
EncodeTable[35] := Ord('j');
EncodeTable[36] := Ord('k');
EncodeTable[37] := Ord('l');
EncodeTable[38] := Ord('m');
EncodeTable[39] := Ord('n');
EncodeTable[40] := Ord('o');
EncodeTable[41] := Ord('p');
EncodeTable[42] := Ord('q');
EncodeTable[43] := Ord('r');
EncodeTable[44] := Ord('s');
EncodeTable[45] := Ord('t');
EncodeTable[46] := Ord('u');
EncodeTable[47] := Ord('v');
EncodeTable[48] := Ord('w');
EncodeTable[49] := Ord('x');
EncodeTable[50] := Ord('y');
EncodeTable[51] := Ord('z');

EncodeTable[52] := Ord('0');
EncodeTable[53] := Ord('1');
EncodeTable[54] := Ord('2');
EncodeTable[55] := Ord('3');
EncodeTable[56] := Ord('4');
EncodeTable[57] := Ord('5');
EncodeTable[58] := Ord('6');
EncodeTable[59] := Ord('7');
EncodeTable[60] := Ord('8');
EncodeTable[61] := Ord('9');
EncodeTable[62] := Ord('+');
EncodeTable[63] := Ord('/');

end.
