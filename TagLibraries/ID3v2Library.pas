//********************************************************************************************************************************
//*                                                                                                                              *
//*     ID3v2 Library 2.0.41.96 © 3delite 2010-2015                                                                              *
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

unit ID3v2Library;

interface

Uses
    SysUtils,
    Classes;

{$MINENUMSIZE 4}

Const
    ID3V2LIBRARY_VERSION = $02004196;

Const
    ID3V2LIBRARY_DEFAULT_PARSE_AUDIO_ATTRIBUTES = True;

type
    DWord = Cardinal;

type
    TID3v2ID = Array [0..2] of Byte;
    TFrameID = Array [0..3] of Byte;
    TLanguageID = Array [0..2] of Byte;
    TRIFFID = Array [0..3] of Byte;
    TRIFFChunkID = Array [0..3] of Byte;
    TAIFFID = Array [0..3] of Byte;
    TAIFFChunkID = Array [0..3] of Byte;

Const
    ID3V2LIBRARY_SUCCESS                        = 0;
    ID3V2LIBRARY_ERROR                          = $FFFF;
    ID3V2LIBRARY_ERROR_NO_TAG_FOUND             = 1;
    ID3V2LIBRARY_ERROR_EMPTY_TAG                = 2;
    ID3V2LIBRARY_ERROR_EMPTY_FRAMES             = 3;
    ID3V2LIBRARY_ERROR_OPENING_FILE             = 4;
    ID3V2LIBRARY_ERROR_READING_FILE             = 5;
    ID3V2LIBRARY_ERROR_WRITING_FILE             = 6;
    ID3V2LIBRARY_ERROR_CORRUPT                  = 7;
    ID3V2LIBRARY_ERROR_NOT_SUPPORTED_VERSION    = 8;
    ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT     = 9;
    ID3V2LIBRARY_ERROR_DOESNT_FIT               = 10;
    ID3V2LIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS    = 11;

const
    ID3V2LIBRARY_DEFAULT_PADDING_SIZE    = 4096;

const
    ID3V2LIBRARY_SESC_ID    = $55555555;
    ID3V2LIBRARY_SESC_VERSION2: Byte = $02;

type
    TExtendedBytes = Array [0..9] of Byte;

type
    TMPEGVersion = (tmpegvUnknown, tmpegv1, tmpegv2, tmpegv25);

    TMPEGLayer = (tmpeglUnknown, tmpegl1, tmpegl2, tmpegl3);

    TMPEGChannelMode = (tmpegcmUnknown, tmpegcmMono, tmpegcmDualChannel, tmpegcmJointStereo, tmpegcmStereo);

    TMPEGModeExtension = (tmpegmeUnknown, tmpegmeNone, tmpegmeIntensity, tmpegmeMS, tmpegmeIntensityMS);

    TMPEGEmphasis = (tmpegeUnknown, tmpegeNo, tmpege5015, tmpegeCCITJ17);

    TMPEGHeader = record
        Position: Int64;                //* Position in bytes
        Header: Cardinal;               //* The Headers bytes
        FrameSize: Integer;             //* frames length
        Version: TMPEGVersion;          //* MPEG Version
        Layer: TMPEGLayer;              //* MPEG Layer
        CRC: Boolean;                   //* Frame has CRC
        BitRate: DWord;                 //* frames bitrate
        SampleRate: DWord;              //* frames sample rate
        Padding: Boolean;               //* frame is padded
        _Private: Boolean;              //* frames private bit is set
        ChannelMode: TMPEGChannelMode;  //* frames channel mode
        ModeExtension: TMPEGModeExtension; //* Joint stereo only
        Copyrighted: Boolean;           //* frames Copyright bit is set
        Original: Boolean;              //* frames Original bit is set
        Emphasis: TMPEGEmphasis;        //* frames emphasis mode
        VBR: Boolean;                   //* Stream is probably VBR
        FrameCount: Int64;              //* Total number of MPEG frames (by header)
        Quality: Integer;               //* MPEG quality
        Bytes: Int64;                   //* Total bytes
    end;

type
    TWaveds64 = record
        ds64Size: DWORD;
        RIFFSizeLow: DWORD;
        RIFFSizeHigh: DWORD;
        DataSizeLow: DWORD;
        DataSizeHigh: DWORD;
        SampleCountLow: DWORD;
        SampleCountHigh: DWORD;
        TableLength: DWORD;
    end;

type
    TID3v2ExtendedHeader3 = class
        Size: Dword;
        CodedSize: Cardinal;
        Data: TMemoryStream;
        Flags: Word;
        CRCPresent: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        procedure DecodeExtendedHeaderSize;
        procedure DecodeExtendedHeaderFlags;
    end;

type
    TID3v2ExtendedHeader4TagSizeRestriction = (
        NoMoreThan128FramesAnd1MBTotalTagSize,
        NoMoreThan64FramesAnd128KBTotalTagSize,
        NoMoreThan32FramesAnd40KBTotalTagSize,
        NoMoreThan32FramesAnd4KBTotalTagSize
    );

type
    TID3v2ExtendedHeader4TextEncodingRestriction = (
        NoTextEncodingRestrictions,
        OnlyEncodedWithISO88591OrUTF8
    );

type
    TID3v2ExtendedHeader4TextFieldsSizeRestriction = (
        NoTextFieldsSizeRestrictions,
        NoStringIsLongerThan1024Characters,
        NoStringIsLongerThan128Characters,
        NoStringIsLongerThan30Characters
    );

type
    TID3v2ExtendedHeader4ImageEncodingRestriction = (
        NoImageEncodingRestrictions,
        ImagesAreEncodedOnlyWithPNGOrJPEG
    );

type
    TID3v2ExtendedHeader4ImageSizeRestriction = (
        NoImageSizeRestrictions,
        AllImagesAre256x256PixelsOrSmaller,
        AllImagesAre64x64PixelsOrSmaller,
        AllImagesAreExactly64x64PixelsUnlessRequiredOtherwise
    );

type
    TID3v2ExtendedHeader4 = class
        Size: DWord;
        CodedSize: Cardinal;
        FlagBytes: Byte;
        Flags: Byte;
        ExtendedFlagsDataSize: Cardinal;
        ExtendedFlagsData: Array of Byte;
        TagIsAnUpdate: Boolean;
        CRCPresent: Boolean;
        TagRestrictions: Boolean;
        TagRestrictionsData: TID3v2ExtendedHeader4TagSizeRestriction;
        TextEncodingRestrictions: TID3v2ExtendedHeader4TextEncodingRestriction;
        TextFieldsSizeRestriction: TID3v2ExtendedHeader4TextFieldsSizeRestriction;
        ImageEncodingRestriction: TID3v2ExtendedHeader4ImageEncodingRestriction;
        ImageSizeRestriction: TID3v2ExtendedHeader4ImageSizeRestriction;
        Constructor Create;
        Destructor Destroy; override;
        procedure DecodeExtendedHeaderSize;
        procedure DecodeExtendedHeaderFlags;
        procedure CalculateExtendedFlagsDataSize;
        procedure DecodeExtendedHeaderFlagData;
    end;

type
    TID3v2SampleCache = Array of Byte;

type
    TID3v2Frame = class
    private
    public
        ID: TFrameID;
        Size: Cardinal;
        CodedSize: Cardinal;
        Stream: TMemoryStream;
        Flags: Word;
        TagAlterPreservation: Boolean;
        FileAlterPreservation: Boolean;
        ReadOnly: Boolean;
        Compressed: Boolean;
        Encrypted: Boolean;
        GroupingIdentity: Boolean;
        Unsynchronised: Boolean;
        DataLengthIndicator: Boolean;
        GroupIdentifier: Byte;
        EncryptionMethod: Byte;
        DataLengthIndicatorValue: Cardinal;
        Constructor Create;
        Destructor Destroy; override;
        procedure DecodeFlags3;
        procedure EncodeFlags3;
        procedure DecodeFlags4;
        procedure EncodeFlags4;
        function Compress: Boolean;
        function DeCompress: Boolean;
        function RemoveUnsynchronisation: Boolean;
        function ApplyUnsynchronisation: Boolean;
        function Assign(ID3v2Frame: TID3v2Frame): Boolean;
        procedure Clear;
    end;

type
    TDSFChannelType = (dsfctUnknown, dsfctMono, dsfctStereo, dsfct3Channels, dsfctQuad, dsfct4Channels, dsfct5Channels, dsfct51Channels);

type
    TDSFInfo = class
    private
        function GetBitRate: Integer;
    public
        FormatVersion: Cardinal;
        FormatID: Cardinal;
        ChannelType: TDSFChannelType;
        ChannelNumber: Cardinal;
        SamplingFrequency: Cardinal;
        BitsPerSample: Cardinal;
        SampleCount: UInt64;
        BlockSizePerChannel: Cardinal;
        PlayTime: Double;
        procedure Clear;
        procedure Assign(DSFInfo: TDSFInfo);
        property BitRate: Integer read GetBitRate;
    end;

type
    TWaveHeader = record
        ident1: TRIFFID;                    // Must be "RIFF"
        len: DWORD;                         // Remaining length after this header
    end;

type
    TWaveFmt = record
        //ident2: TWAVIdent;                // Must be "WAVE"
        //ident3: TWAVIdent;                // Must be "fmt "
        fmtSize: DWord;                     // Reserved 4 bytes
        FormatTag: Word;                    // format type
        Channels: Word;                     // number of channels (i.e. mono, stereo, etc.)
        SamplesPerSec: DWord;               // sample rate
        AvgBytesPerSec: DWord;              // for buffer estimation
        BlockAlign: Word;                   // block size of data
        BitsPerSample: Word;                // number of bits per sample of mono data
        //* WAVE_FORMAT_EXTENSIBLE
        cbSize: Word;	                    // Size of the extension: 22
        ValidBitsPerSample: Word;	        // at most 8 *  M
        ChannelMask: DWord;	                // Speaker position mask: 0
        SubFormat: Array[0..15] of Byte;    // 16
    end;

type
    TAIFFInformation = record
        Channels: Word;
        SampleFrames: DWord;
        SampleSize: Word;
        SampleRate: Double;
        CompressionID: String;  // http://en.wikipedia.org/wiki/Audio_Interchange_File_Format
        Compression: String;
    end;

type
    TSourceFileType = (sftUnknown, sftMPEG, sftWAVE, sftRF64, sftAIFF, sftDSF);

type
    TID3v2Tag = class
    private
        CodedSize: Cardinal;
        FPosition: Int64;
        FSourceFileType: TSourceFileType;
        FPlayTime: Double;
        FStrangeTag: Boolean;
        procedure DecodeFlags;
        procedure EncodeFlags;
        procedure DecodeSize;
        procedure EncodeSize;
        function ReadExtendedHeader(TagStream: TStream): Boolean;
        //function WriteExtendedHeader(TagStream: TStream): Boolean;
        //function RemoveUnsynchronisationOnExtendedHeaderSize: Boolean;
        //function ApplyUnsynchronisationOnExtendedHeaderSize: Boolean;
        function RemoveUnsynchronisationOnExtendedHeaderData: Boolean;
        //function ApplyUnsynchronisationOnExtendedHeaderData: Boolean;
        function LoadFrame(TagStream: TStream): Boolean;
        procedure LoadFrameData(TagStream: TStream; FrameIndex: Integer);
        procedure CompactFrameList;
        function WriteAllFrames(var TagStream: TStream): Integer;
        function WriteAllHeaders(var TagStream: TStream): Integer;
        function Convertv2Tov3(FrameIndex: Integer): Boolean;
        function Convertv2PICtoAPIC(FrameIndex: Integer): Boolean;
        function SaveDSF(TagStream: TStream; WriteTagTotalSize: Cardinal): Integer;
        function LoadDSFInfo(TagStream: TStream): Boolean;
        function CheckMPEG(MPEGStream: TStream): Boolean;
        function MPEGProcessHeader(MPEGStream: TStream): TMPEGHeader;
        function GetMPEGHeaderInformation(Stream: TStream): Boolean;
        procedure LoadWAVEAttributes(Stream: TStream);
        function GetWAVEInformation(Stream: TStream): TWaveFmt;
        function GetAIFFInformation(Stream: TStream): TAIFFInformation;
        function GetPlayTime: Double;
    public
        FileName: String;
        Loaded: Boolean;
        MajorVersion: Byte;
        MinorVersion: Byte;
        Flags: Byte;
        Unsynchronised: Boolean;
        Compressed: Boolean;
        ExtendedHeader: Boolean;
        Experimental: Boolean;
        FooterPresent: Boolean;
        Size: Cardinal;
        Frames: Array of TID3v2Frame;
        FrameCount: Integer;
        ExtendedHeader3: TID3v2ExtendedHeader3;
        ExtendedHeader4: TID3v2ExtendedHeader4;
        PaddingSize: Cardinal;
        PaddingToWrite: Cardinal;
        MPEGInfo: TMPEGHeader;
        WAVInfo: TWaveFmt;
        AIFFInfo: TAIFFInformation;
        DSFInfo: TDSFInfo;
        SampleCount: Int64;
        BitRate: Integer;
        ParseAudioAttributes: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function LoadFromFile(FileName: String): Integer;
        function LoadFromStream(TagStream: TStream): Integer;
        function LoadFromMemory(MemoryAddress: Pointer): Integer;
        function SaveToFile(FileName: String): Integer;
        function SaveToStream(Stream: TStream): Integer;
        function SaveTagToStream(var TagStream: TStream; PaddingSizeToWrite: Integer = 0): Integer;
        function AddFrame(FrameID: TFrameID): Integer; overload;
        function AddFrame(FrameID: String): Integer; overload;
        function InsertFrame(FrameID: TFrameID; Position: Integer): Integer; overload;
        function InsertFrame(FrameID: String; Position: Integer): Integer; overload;
        function DeleteFrame(FrameIndex: Integer): Boolean; overload;
        function DeleteFrame(FrameID: TFrameID): Boolean; overload;
        function DeleteFrame(FrameID: String): Boolean; overload;
        procedure DeleteAllFrames;
        procedure DeleteAllCoverArts;
        procedure Clear;
        procedure Assign(ID3v2Tag: TID3v2Tag);
        function RemoveUnsynchronisationOnAllFrames: Boolean;
        function ApplyUnsynchronisationOnAllFrames: Boolean;
        function FrameExists(FrameID: TFrameID): Integer; overload;
        function FrameExists(FrameID: String): Integer; overload;
        function FrameTypeCount(FrameID: TFrameID): Integer; overload;
        function FrameTypeCount(FrameID: String): Integer; overload;
        function CoverArtCount: Integer;
        function CalculateTotalFramesSize: Integer;
        function CalculateTagSize(PaddingSize: Integer): Integer;
        function FullFrameSize(FrameIndex: Cardinal): Cardinal;
        function CalculateTagCRC32: Cardinal;
        function GetUnicodeText(FrameIndex: Integer; ReturnNativeText: Boolean = False): String; overload;
        function GetUnicodeText(FrameID: String; ReturnNativeText: Boolean = False): String; overload;
        function SetUnicodeText(FrameIndex: Integer; Text: String): Boolean; overload;
        function SetUnicodeText(FrameID: String; Text: String): Boolean; overload;
        function GetUnicodeTextMultiple(FrameIndex: Integer; List: TStrings): Boolean; overload;
        function GetUnicodeTextMultiple(FrameID: String; List: TStrings): Boolean; overload;
        function SetUnicodeTextMultiple(FrameIndex: Integer; List: TStrings): Boolean; overload;
        function SetUnicodeTextMultiple(FrameID: String; List: TStrings): Boolean; overload;
        function SetText(FrameID: String; Text: String): Boolean; overload;
        function SetText(FrameIndex: Integer; Text: String): Boolean; overload;
        function SetUTF8Text(FrameID: String; Text: String): Boolean; overload;
        function SetUTF8Text(FrameIndex: Integer; Text: String): Boolean; overload;
        function SetRawText(FrameIndex: Integer; Text: String): Boolean; overload;
        function SetRawText(FrameID: String; Text: String): Boolean; overload;
        function GetUnicodeContent(FrameIndex: Integer; var LanguageID: TLanguageID; var Description: String): String; overload;
        function GetUnicodeContent(FrameID: String; var LanguageID: TLanguageID; var Description: String): String; overload;
        function SetContent(FrameIndex: Integer; Content: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetContent(FrameID: String; Content: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUTF8Content(FrameIndex: Integer; Content: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUTF8Content(FrameID: String; Content: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUnicodeContent(FrameIndex: Integer; Content: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUnicodeContent(FrameID: String; Content: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function GetUnicodeComment(FrameIndex: Integer; var LanguageID: TLanguageID; var Description: String): String; overload;
        function GetUnicodeComment(FrameID: String; var LanguageID: TLanguageID; var Description: String): String; overload;
        function FindUnicodeCommentByDescription(Description: String; var LanguageID: TLanguageID; var Comment: String): Integer;
        function SetUnicodeComment(FrameIndex: Integer; Comment: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUnicodeComment(FrameID: String; Comment: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUnicodeCommentByDescription(Description: String; LanguageID: TLanguageID; Comment: String): Boolean;
        function GetUnicodeLyrics(FrameIndex: Integer; var LanguageID: TLanguageID; var Description: String): String; overload;
        function GetUnicodeLyrics(FrameID: String; var LanguageID: TLanguageID; var Description: String): String; overload;
        function SetUnicodeLyrics(FrameIndex: Integer; Lyrics: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function SetUnicodeLyrics(FrameID: String; Lyrics: String; LanguageID: TLanguageID; Description: String): Boolean; overload;
        function GetUnicodeCoverPictureStream(FrameIndex: Integer; var PictureStream: TStream; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean; overload;
        function GetUnicodeCoverPictureStream(FrameID: String; var PictureStream: TStream; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean; overload;
        function GetUnicodeCoverPictureInfo(FrameIndex: Integer; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean; overload;
        function GetUnicodeCoverPictureInfo(FrameID: String; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean; overload;
        function GetCoverPictureInfoPointer(FrameIndex: Integer; var Data: Pointer; var DataSize: Int64; var MIMEType: Pointer; var Description: Pointer; var TextEncoding: Integer; var CoverType: Integer): Boolean;
        function SetUnicodeCoverPictureFromStream(FrameIndex: Integer; Description: String; PictureStream: TStream; MIMEType: String; CoverType: Integer): Boolean; overload;
        function SetUnicodeCoverPictureFromStream(FrameID: String; Description: String; PictureStream: TStream; MIMEType: String; CoverType: Integer): Boolean; overload;
        function SetUnicodeCoverPictureFromFile(FrameIndex: Integer; Description: String; PictureFileName: String; MIMEType: String; CoverType: Integer): Boolean; overload;
        function SetUnicodeCoverPictureFromFile(FrameID: String; Description: String; PictureFileName: String; MIMEType: String; CoverType: Integer): Boolean; overload;
        function GetURL(FrameIndex: Integer): String; overload;
        function GetURL(FrameID: String): String; overload;
        function SetURL(FrameIndex: Integer; URL: String): Boolean; overload;
        function SetURL(FrameID: String; URL: String): Boolean; overload;
        function GetUnicodeUserDefinedURLLink(FrameIndex: Integer; var Description: String): String; overload;
        function GetUnicodeUserDefinedURLLink(FrameID: String; var Description: String): String; overload;
        function FindUnicodeUserDefinedURLLinkByDescription(Description: String; var URL: String): Integer;
        function SetUserDefinedURLLink(FrameIndex: Integer; URL: String; Description: String): Boolean; overload;
        function SetUserDefinedURLLink(FrameID: String; URL: String; Description: String): Boolean; overload;
        function SetUTF8UserDefinedURLLink(FrameIndex: Integer; URL: String; Description: String): Boolean; overload;
        function SetUTF8UserDefinedURLLink(FrameID: String; URL: String; Description: String): Boolean; overload;
        function SetUnicodeUserDefinedURLLink(FrameIndex: Integer; URL: String; Description: String): Boolean; overload;
        function SetUnicodeUserDefinedURLLink(FrameID: String; URL: String; Description: String): Boolean; overload;
        function SetUnicodeUserDefinedURLLinkByDescription(Description: String; URL: String): Boolean;
        function GetTime(FrameIndex: Integer): TDateTime; overload;
        function GetTime(FrameID: String): TDateTime; overload;
        function SetTime(FrameIndex: Integer; DateTime: TDateTime): Boolean; overload;
        function SetTime(FrameID: String; DateTime: TDateTime): Boolean; overload;
        function GetSEBR(FrameIndex: Integer): {$IFDEF CPUX64}Double{$ELSE}Extended{$ENDIF}; overload;
        function GetSEBR(FrameID: String): {$IFDEF CPUX64}Double{$ELSE}Extended{$ENDIF}; overload;
        function GetSEBRString(FrameIndex: Integer): String;
        function SetSEBR(FrameIndex: Integer; BitRate: String): Boolean; overload;
        function SetSEBR(FrameID: String; BitRate: String): Boolean; overload;
        {$IFNDEF CPUX64}
        function SetSEBR(FrameIndex: Integer; BitRate: Extended): Boolean; overload;
        function SetSEBR(FrameID: String; BitRate: Extended): Boolean; overload;
        {$ENDIF}
        function GetSampleCache(FrameIndex: Integer; ForceDecompression: Boolean; var Version: Byte; var Channels: Integer): TID3v2SampleCache;
        function SetSampleCache(FrameIndex: Integer; SESC: TID3v2SampleCache; Channels: Integer): Boolean;
        function GetSEFC(FrameIndex: Integer): Int64;
        function SetSEFC(FrameIndex: Integer; SEFC: Int64): Boolean;
        function SetAlbumColors(FrameIndex: Integer; TitleColor, TextColor: Cardinal): Boolean; overload;
        function SetAlbumColors(FrameID: String; TitleColor, TextColor: Cardinal): Boolean; overload;
        function GetAlbumColors(FrameIndex: Integer; var TitleColor, TextColor: Cardinal): Boolean; overload;
        function GetAlbumColors(FrameID: String; var TitleColor, TextColor: Cardinal): Boolean; overload;
        function SetTLEN(FrameIndex: Integer; TLEN: Integer): Boolean; overload;
        function SetTLEN(FrameID: String; TLEN: Integer): Boolean; overload;
        function GetPlayCount(FrameIndex: Integer): Cardinal; overload;
        function GetPlayCount(FrameID: String): Cardinal; overload;
        function SetPlayCount(FrameIndex: Integer; PlayCount: Cardinal): Boolean; overload;
        function SetPlayCount(FrameID: String; PlayCount: Cardinal): Boolean; overload;
        function FindCustomFrame(FrameID: String; Description: String): Integer;
        function GetUnicodeUserDefinedTextInformation(FrameIndex: Integer; var Description: String): String;
        function SetUserDefinedTextInformation(FrameIndex: Integer; Description: String; Text: String): Boolean; overload;
        function SetUserDefinedTextInformation(FrameID: String; Description: String; Text: String): Boolean; overload;
        function SetUnicodeUserDefinedTextInformationMultiple(FrameIndex: Integer; Description: String; List: TStrings): Boolean; overload;
        function SetUnicodeUserDefinedTextInformationMultiple(FrameID: String; Description: String; List: TStrings): Boolean; overload;
        function GetUnicodeUserDefinedTextInformationMultiple(FrameIndex: Integer; var Description: String; List: TStrings): Boolean; overload;
        function GetUnicodeUserDefinedTextInformationMultiple(FrameID: String; var Description: String; List: TStrings): Boolean; overload;
        function SetUTF8UserDefinedTextInformation(FrameIndex: Integer; Description: String; Text: String): Boolean; overload;
        function SetUTF8UserDefinedTextInformation(FrameID: String; Description: String; Text: String): Boolean; overload;
        function SetUnicodeUserDefinedTextInformation(FrameIndex: Integer; Description: String; Text: String): Boolean; overload;
        function SetUnicodeUserDefinedTextInformation(FrameID: String; Description: String; Text: String): Boolean; overload;
        function GetPopularimeter(FrameIndex: Integer; var Email: String; var Rating: Byte; var PlayCounter: Cardinal): Boolean;
        function FindPopularimeter(Email: String; var Rating: Byte; var PlayCounter: Cardinal): Integer;
        function SetPopularimeterByEmail(Email: String; Rating: Byte; PlayCounter: Cardinal = 0): Boolean;
        function SetPopularimeter(FrameIndex: Integer; Email: String; Rating: Byte; PlayCounter: Cardinal): Boolean;
        function FindTXXXByDescription(Description: String; var Text: String): Integer; overload;
        function FindTXXXByDescriptionMultiple(Description: String; List: TStrings): Integer; overload;
        //function GetUnicodeTXXX(FrameIndex: Integer; var Description: String): String;
        function SetUnicodeTXXXByDescription(Description: String; Text: String): Boolean;
        function SetUnicodeTXXXByDescriptionMultiple(Description: String; List: TStrings): Boolean;
        function SetUnicodeTXXX(Index: Integer; Description: String; Text: String): Boolean;
        function GetUnicodeListFrame(FrameID: String; var List: TStrings): Boolean; overload;
        function GetUnicodeListFrame(FrameIndex: Integer; var List: TStrings): Boolean; overload;
        function SetUnicodeListFrame(FrameID: String; List: TStrings): Boolean; overload;
        function SetUnicodeListFrame(Index: Integer; List: TStrings): Boolean; overload;
        function GetUFID(FrameIndex: Integer; var OwnerIdentifier: String): String; overload;
        function GetUFID(FrameID: String; var OwnerIdentifier: String): String; overload;
        function FindUFIDByOwnerIdentifier(OwnerIdentifier: String; var Identifier: String): Integer;
        function SetUFID(FrameIndex: Integer; OwnerIdentifier: String; Identifier: String): Boolean; overload;
        function SetUFID(FrameID: String; OwnerIdentifier: String; Identifier: String): Boolean; overload;
        function SetUFIDByOwnerIdentifier(OwnerIdentifier: String; Identifier: String): Boolean;
        property Position: Int64 read FPosition;
        property SourceFileType: TSourceFileType read FSourceFileType;
        property PlayTime: Double read GetPlayTime;
    end;

type
    TID3v2FrameType = (ftUnknown, ftText, ftTextWithDescription, ftTextWithDescriptionAndLangugageID, ftTextList, ftURL, ftUserDefinedURL, ftPlayCount, ftBinary);

// The constants here are for the CRC-32 generator
// polynomial, as defined in the Microsoft
// Systems Journal, March 1995, pp. 107-108
Const
    CRC32Table: array[0..255] of DWORD =
    ($00000000, $77073096, $EE0E612C, $990951BA,
    $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
    $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
    $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172,
    $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
    $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116,
    $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
    $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,

    $76DC4190, $01DB7106, $98D220BC, $EFD5102A,
    $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818,
    $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
    $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
    $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
    $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086,
    $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
    $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,

    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
    $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
    $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
    $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,
    $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,
    $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
    $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
    $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,

    $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
    $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
    $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
    $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
    $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
    $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
    $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
    $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);

    procedure UnSyncSafe(var Source; const SourceSize: Integer; var Dest: Cardinal);
    procedure SyncSafe(Source: Cardinal; var Dest; const DestSize: Integer);

    function Min(const B1, B2: Integer): Integer; inline;
    function Max(const B1, B2: Integer): Integer; inline;

    function ReverseBytes(Value: Cardinal): Cardinal; overload;
    function Swap16(ASmallInt: SmallInt): SmallInt; register;

    function RemoveUnsynchronisationScheme(Source, Dest: TStream; BytesToRead: Integer): Boolean;
    function ApplyUnsynchronisationScheme(Source, Dest: TStream; BytesToRead: Integer): Boolean;

    function RemoveUnsynchronisationOnStream(Stream: TMemoryStream): Boolean;
    function ApplyUnsynchronisationOnStream(Stream: TMemoryStream): Boolean;

    function ID3v2EncodeTime(DateTime: TDateTime): String;
    function ID3v2DecodeTime(ID3v2DateTime: String): TDateTime;
    function ID3v2DecodeTimeToNumbers(ID3v2DateTime: String; var Year, Month, Day, Hour, Minute, Second: Integer): Boolean;

    function ValidID3v2FrameID(FrameID: TFrameID): Boolean;
    function ValidID3v2FrameID2(FrameID: TFrameID): Boolean;
    function LanguageIDtoString(LanguageId : TLanguageID): String;
    procedure AnsiStringToPAnsiChar(const Source: String; var Dest: TFrameID);
    procedure StringToLanguageID(const Source: String; var Dest: TLanguageID);

    function APICType2Str(PictureType: Integer): String;
    function APICTypeStr2No(PictureType: String): Integer;

    function ID3v2ValidTag(TagStream: TStream): Boolean;
    function CheckRIFF(TagStream: TStream): Boolean;
    function SeekRIFF(TagStream: TStream): Integer;
    function CheckAIFF(TagStream: TStream): Boolean;
    function SeekAIFF(TagStream: TStream): Integer;
    function CheckRF64(TagStream: TStream): Boolean;
    function SeekRF64(TagStream: TStream): Integer;
    function CheckDSF(TagStream: TStream): Boolean;
    function SeekDSF(TagStream: TStream): Integer;
    function ValidRIFF(TagStream: TStream): Boolean;
    function ValidRF64(TagStream: TStream): Boolean;
    function ValidDSF(TagStream: TStream): Boolean;

    function RemoveID3v2TagFromFile(FileName: String): Integer;
    function RemoveID3v2TagFromStream(Stream: TStream): Integer;

    procedure CalcCRC32(P: Pointer; ByteCount: DWORD; var CRCValue: DWORD);
    function CalculateStreamCRC32(Stream: TStream; var CRCvalue: DWORD): Boolean;

    function RIFFCreateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PaddingToWrite: Cardinal): Integer;
    function RIFFUpdateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PreviousTagSize: Cardinal; PaddingToWrite: Cardinal): Integer;

    function AIFFCreateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PaddingToWrite: Cardinal): Integer;
    function AIFFUpdateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PreviousTagSize: Cardinal; PaddingToWrite: Cardinal): Integer;

    function RF64CreateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PaddingToWrite: Cardinal): Integer;
    function RF64UpdateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PreviousTagSize: Cardinal; PaddingToWrite: Cardinal): Integer;

    function WritePadding(var TagStream: TStream; PaddingSize: Integer): Integer;

    function RemoveRIFFID3v2FromFile(FileName: String): Integer;
    function RemoveRIFFID3v2FromStream(Stream: TStream): Integer;
    function RemoveAIFFID3v2FromFile(FileName: String): Integer;
    function RemoveAIFFID3v2FromStream(Stream: TStream): Integer;
    function RemoveRF64ID3v2FromFile(FileName: String): Integer;
    function RemoveRF64ID3v2FromStream(Stream: TStream): Integer;
    function RemoveDSFID3v2FromFile(FileName: String): Integer;
    function RemoveDSFID3v2FromStream(Stream: TStream): Integer;

    function ID3v2TagErrorCode2String(ErrorCode: Integer): String;

    function MakeInt64(LowDWord, HiDWord: DWord): Int64;
    function LowDWordOfInt64(Value: Int64): Cardinal;
    function HighDWordOfInt64(Value: Int64): Cardinal;

    function GetID3v2FrameType(FrameID: TFrameID): TID3v2FrameType;

    procedure ConvertString2FrameID(StringFrameID: String; var FrameID: TFrameID);
    function ConvertFrameID2String(FrameID: TFrameID): String;
    function IsSameFrameID(FrameID1: TFrameID; FrameID2: TFrameID): Boolean; overload;
    function IsSameFrameID(FrameID: TFrameID; StringFrameID: String): Boolean; overload;

    function GetID3v2Size(PMemory: Pointer): Cardinal; overload;
    function GetID3v2Size(Stream: TStream): Cardinal; overload;

var
    ID3v2ID: TID3v2ID;
    RIFFID: TRIFFID;
    RF64ID: TRIFFID;
    RIFFWAVEID: TRIFFChunkID;
    RIFFID3v2ID: TRIFFChunkID;
    AIFFID: TAIFFID;
    AIFFChunkID: TAIFFChunkID;
    AIFCChunkID: TAIFFChunkID;
    AIFFID3v2ID: TAIFFChunkID;
    DSFID: TRIFFID;
    DSFfmt_ID: TRIFFID;

    ID3v2LibraryDefaultParseAudioAttributes: Boolean = ID3V2LIBRARY_DEFAULT_PARSE_AUDIO_ATTRIBUTES;

implementation

Uses
    {$IFDEF POSIX}
    Posix.UniStd,
    Posix.StdIO,
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    WinAPI.Windows,
    {$ENDIF}
    {$IFDEF CPUX64}
    uTExtendedX87,
    {$ENDIF}
    //ZLibEx,
    ZLib,
    ID3v1Library;

function MakeInt64(LowDWord, HiDWord: DWord): Int64;
begin
    Result := LowDWord OR (Int64(HiDWord) SHL 32);
end;

function LowDWordOfInt64(Value: Int64): Cardinal;
begin
    Result := (Value SHL 32) SHR 32;
end;

function HighDWordOfInt64(Value: Int64): Cardinal;
begin
    Result := Value SHR 32;
end;

function ReverseBytes64(Value: UInt64): UInt64;
var
    LowDWord: DWord;
    HighDWord: DWord;
begin
    LowDWord := LowDWordOfInt64(Value);
    HighDWord := HighDWordOfInt64(Value);
    LowDWord := ReverseBytes(LowDWord);
    HighDWord := ReverseBytes(HighDWord);
    Result := MakeInt64(HighDWord, LowDWord);
end;

function NGetFileSize(FileName: String): Int64;
var
  f: TSearchRec;
begin
    Result := -1;
    if FileExists(FileName) then begin
    	try
            if FindFirst(FileName, faAnyFile, f) = 0 then begin
                Result := f.Size;
                //Result := MakeInt64(f.FindData.nFileSizeLow, f.FindData.nFileSizeHigh);
            end;
        finally
            SysUtils.FindClose(f);
        end;
    end;
end;

Constructor TID3v2ExtendedHeader3.Create;
begin
    inherited;
    Flags := 0;
    Size := 0;
    //SizeData := TMemoryStream.Create;
    Data := TMemoryStream.Create;
end;

Destructor TID3v2ExtendedHeader3.Destroy;
begin
    //FreeAndNil(SizeData);
    FreeAndNil(Data);
    inherited;
end;

procedure TID3v2ExtendedHeader3.DecodeExtendedHeaderSize;
begin
    UnSyncSafe(CodedSize, 4, Size);
end;

procedure TID3v2ExtendedHeader3.DecodeExtendedHeaderFlags;
var
    Bit: Byte;
begin
    Flags := Swap16(Flags);
    Bit := Flags SHR 15;
    CRCPresent := Boolean(Bit);
end;

Constructor TID3v2ExtendedHeader4.Create;
begin
    inherited;
    TagIsAnUpdate := False;
    CRCPresent := False;
    TagRestrictions := False;
    TagRestrictionsData := NoMoreThan128FramesAnd1MBTotalTagSize;
    TextEncodingRestrictions := NoTextEncodingRestrictions;
    TextFieldsSizeRestriction := NoTextFieldsSizeRestrictions;
    ImageEncodingRestriction := NoImageEncodingRestrictions;
    ImageSizeRestriction := NoImageSizeRestrictions;
end;

Destructor TID3v2ExtendedHeader4.Destroy;
begin
    inherited;
end;

procedure TID3v2ExtendedHeader4.DecodeExtendedHeaderSize;
begin
    UnSyncSafe(CodedSize, 4, Size);
end;

procedure TID3v2ExtendedHeader4.DecodeExtendedHeaderFlags;
var
    Bit: Byte;
begin
    Bit := Flags SHL 1;
    Bit := Bit SHR 7;
    TagIsAnUpdate := Boolean(Bit);
    Bit := Flags SHL 2;
    Bit := Bit SHR 7;
    CRCPresent := Boolean(Bit);
    Bit := Flags SHL 3;
    Bit := Bit SHR 7;
    TagRestrictions := Boolean(Bit);
end;

procedure TID3v2ExtendedHeader4.CalculateExtendedFlagsDataSize;
begin
    ExtendedFlagsDataSize := 0;
    if TagIsAnUpdate then begin
        //* No flag data
    end;
    if CRCPresent then begin
        ExtendedFlagsDataSize := ExtendedFlagsDataSize + 5;
    end;
    if TagRestrictions then begin
        ExtendedFlagsDataSize := ExtendedFlagsDataSize + 1;
    end;
end;

procedure TID3v2ExtendedHeader4.DecodeExtendedHeaderFlagData;
begin
    //* Not yet implemented
end;

Constructor TID3v2Frame.Create;
begin
    Inherited;
    //ID := '';
    Flags := 0;
    TagAlterPreservation := False;
    FileAlterPreservation := False;
    ReadOnly := False;
    Compressed := False;
    Encrypted := False;
    GroupingIdentity := False;
    Unsynchronised := False;
    DataLengthIndicator := False;
    Stream := TMemoryStream.Create;
    Unsynchronised := False;
    DataLengthIndicatorValue := 0;
    GroupIdentifier := 0;
    EncryptionMethod := 0;
end;

Destructor TID3v2Frame.Destroy;
begin
    //ID := #0#0#0#0;
    FreeAndNil(Stream);
    Inherited;
end;

procedure TID3v2Frame.DecodeFlags3;
var
    Bit: Word;
begin
    Bit := Flags SHR 15;
    TagAlterPreservation := Boolean(Bit);
    Bit := Flags SHL 1;
    Bit := Bit SHR 15;
    FileAlterPreservation := Boolean(Bit);
    Bit := Flags SHL 2;
    Bit := Bit SHR 15;
    ReadOnly := Boolean(Bit);
    Bit := Flags SHL 8;
    Bit := Bit SHR 15;
    Compressed := Boolean(Bit);
    Bit := Flags SHL 9;
    Bit := Bit SHR 15;
    Encrypted := Boolean(Bit);
    Bit := Flags SHL 10;
    Bit := Bit SHR 15;
    GroupingIdentity := Boolean(Bit);
end;

procedure TID3v2Frame.EncodeFlags3;
var
    EncodedFlags: Word;
    Bit: Word;
begin
    EncodedFlags := 0;
    if TagAlterPreservation then begin
        Bit := 1 SHL 7;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if FileAlterPreservation then begin
        Bit := 1 SHL 6;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if ReadOnly then begin
        Bit := 1 SHL 5;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if Compressed then begin
        Bit := 1 SHL 15;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if Encrypted then begin
        Bit := 1 SHL 14;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if GroupingIdentity then begin
        Bit := 1 SHL 13;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    Flags := EncodedFlags;
end;

procedure TID3v2Frame.DecodeFlags4;
var
    Bit: Word;
begin
    Bit := Flags SHR 14;
    TagAlterPreservation := Boolean(Bit);
    Bit := Flags SHL 1;
    Bit := Bit SHR 14;
    FileAlterPreservation := Boolean(Bit);
    Bit := Flags SHL 2;
    Bit := Bit SHR 14;
    ReadOnly := Boolean(Bit);
    Bit := Flags SHL 9;
    Bit := Bit SHR 15;
    GroupingIdentity := Boolean(Bit);
    Bit := Flags SHL 12;
    Bit := Bit SHR 15;
    Compressed := Boolean(Bit);
    Bit := Flags SHL 13;
    Bit := Bit SHR 15;
    Encrypted := Boolean(Bit);
    Bit := Flags SHL 14;
    Bit := Bit SHR 15;
    Unsynchronised := Unsynchronised OR Boolean(Bit);
    Bit := Flags SHL 15;
    Bit := Bit SHR 15;
    DataLengthIndicator := Boolean(Bit);
end;

procedure TID3v2Frame.EncodeFlags4;
var
    EncodedFlags: Word;
    Bit: Word;
begin
    EncodedFlags := 0;
    if TagAlterPreservation then begin
        Bit := 1 SHL 14;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if FileAlterPreservation then begin
        Bit := 1 SHL 13;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if ReadOnly then begin
        Bit := 1 SHL 12;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if GroupingIdentity then begin
        Bit := 1 SHL 6;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if Compressed then begin
        Bit := 1 SHL 3;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if Encrypted then begin
        Bit := 1 SHL 2;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if Unsynchronised then begin
        Bit := 1 SHL 1;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if DataLengthIndicator then begin
        Bit := 1;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    Flags := EncodedFlags;
end;

function TID3v2Frame.Compress: Boolean;
var
    CompressionStream: TZCompressionStream;
    CompressedStream: TStream;
    UnCompressedSize: DWord;
    SyncSafeSize: DWord;
begin
    Result := False;
    if Stream.Size = 0 then begin
        Exit;
    end;
    CompressionStream := nil;
    CompressedStream := nil;
    try
        try
            CompressedStream := TMemoryStream.Create;
            //* TZCompressionStream constructor has changed
            {$IF CompilerVersion >= 22}
            CompressionStream := TZCompressionStream.Create(clMax, CompressedStream);
            {$ELSE}
            CompressionStream := TZCompressionStream.Create(CompressedStream, zcMax);
            {$IFEND}
            Stream.Seek(0, soBeginning);
            CompressionStream.CopyFrom(Stream, Stream.Size);
            //* Needed to flush the buffer
            FreeAndNil(CompressionStream);
            if CompressedStream.Size > 0 then begin
                UnCompressedSize := Stream.Size;
                SyncSafe(UnCompressedSize, SyncSafeSize, 4);
                Stream.Clear;
                //Stream.Write(SyncSafeSize, 4);
                DataLengthIndicatorValue := SyncSafeSize;
                CompressedStream.Seek(0, soBeginning);
                Stream.CopyFrom(CompressedStream, CompressedStream.Size);
                Compressed := True;
                DataLengthIndicator := True;
                Result := True;
            end;
        except
            //*
        end;
    finally
        if Assigned(CompressionStream) then begin
            FreeAndNil(CompressionStream);
        end;
        if Assigned(CompressedStream) then begin
            FreeAndNil(CompressedStream);
        end;
    end;
end;

function TID3v2Frame.DeCompress: Boolean;
var
    DeCompressionStream: TZDeCompressionStream;
    UnCompressedStream: TMemoryStream;
begin
    Result := False;
    if Stream.Size <= 4 then begin
        Exit;
    end;
    DeCompressionStream := nil;
    UnCompressedStream := nil;
    try
        try
            UnCompressedStream := TMemoryStream.Create;
            Stream.Seek(0, soBeginning);
            DeCompressionStream := TZDeCompressionStream.Create(Stream);

            DeCompressionStream.Seek(0, soBeginning);

            UnCompressedStream.CopyFrom(DeCompressionStream, 0);
            Stream.Clear;
            Stream.CopyFrom(UnCompressedStream, 0);
            Stream.Seek(0, soBeginning);
            Compressed := False;
            DataLengthIndicator := False;
            Result := True;
        except
            //*
        end;
    finally
        if Assigned(DeCompressionStream) then begin
            FreeAndNil(DeCompressionStream);
        end;
        if Assigned(UnCompressedStream) then begin
            FreeAndNil(UnCompressedStream);
        end;
    end;
end;

function TID3v2Frame.RemoveUnsynchronisation: Boolean;
begin
    Result := RemoveUnsynchronisationOnStream(Stream);
    if Result then begin
        Unsynchronised := False;
    end;
end;

function TID3v2Frame.ApplyUnsynchronisation: Boolean;
begin
    Result := ApplyUnsynchronisationOnStream(Stream);
    if Result then begin
        Unsynchronised := True;
    end;
end;

function TID3v2Frame.Assign(ID3v2Frame: TID3v2Frame): Boolean;
begin
    Result := False;
    Clear;
    if ID3v2Frame <> nil then begin
        ID := ID3v2Frame.ID;
        Size := ID3v2Frame.Size;
        Flags := ID3v2Frame.Flags;
        TagAlterPreservation := ID3v2Frame.TagAlterPreservation;
        FileAlterPreservation := ID3v2Frame.FileAlterPreservation;
        ReadOnly := ID3v2Frame.ReadOnly;
        Compressed := ID3v2Frame.Compressed;
        Encrypted := ID3v2Frame.Encrypted;
        GroupingIdentity := ID3v2Frame.GroupingIdentity;
        Unsynchronised := ID3v2Frame.Unsynchronised;
        DataLengthIndicator := ID3v2Frame.DataLengthIndicator;
        GroupIdentifier := ID3v2Frame.GroupIdentifier;
        EncryptionMethod := ID3v2Frame.EncryptionMethod;
        ID3v2Frame.Stream.Seek(0, soBeginning);
        Stream.CopyFrom(ID3v2Frame.Stream, ID3v2Frame.Stream.Size);
        ID3v2Frame.Stream.Seek(0, soBeginning);
    end;
end;

procedure TID3v2Frame.Clear;
begin
    FillChar(ID, SizeOf(ID), 0);
    Size := 0;
    Flags := 0;
    TagAlterPreservation := False;
    FileAlterPreservation := False;
    ReadOnly := False;
    Compressed := False;
    Encrypted := False;
    GroupingIdentity := False;
    Unsynchronised := False;
    DataLengthIndicator := False;
    GroupIdentifier := 0;
    EncryptionMethod := 0;
    Stream.Clear;
end;

Constructor TID3v2Tag.Create;
begin
    Inherited;
    ExtendedHeader3 := TID3v2ExtendedHeader3.Create;
    ExtendedHeader4 := TID3v2ExtendedHeader4.Create;
    DSFInfo := TDSFInfo.Create;
    Clear;
    ParseAudioAttributes := ID3v2LibraryDefaultParseAudioAttributes;
end;

Destructor TID3v2Tag.Destroy;
begin
    Clear;
    FreeAndNil(ExtendedHeader3);
    FreeAndNil(ExtendedHeader4);
    FreeAndNil(DSFInfo);
    Inherited;
end;

procedure TID3v2Tag.DeleteAllCoverArts;
var
    i: Integer;
begin
    for i := FrameCount - 1 downto 0 do begin
        if IsSameFrameID(Frames[i].ID, 'APIC') then begin
            DeleteFrame(i);
        end;
    end;
end;

procedure TID3v2Tag.DeleteAllFrames;
var
    i: Integer;
begin
    for i := 0 to Length(Frames) - 1 do begin
        FreeAndNil(Frames[i]);
    end;
    SetLength(Frames, 0);
    FrameCount := 0;
end;

function TID3v2Tag.LoadFromStream(TagStream: TStream): Integer;
var
    ValidFrameLoaded: Boolean;
    PreviousPosition: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    Loaded := False;
    try
        Clear;
        PreviousPosition := TagStream.Position;
        if NOT ID3v2ValidTag(TagStream) then begin
            TagStream.Seek(PreviousPosition, soBeginning);
            //* WAV
            if CheckRIFF(TagStream) then begin
                FSourceFileType := sftWAVE;
                if ParseAudioAttributes then begin
                    LoadWAVEAttributes(TagStream);
                end;
                if SeekRIFF(TagStream) = 0 then begin
                    Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                    Exit;
                end;
            end else begin
                //* WAV64
                TagStream.Seek(PreviousPosition, soBeginning);
                if CheckRF64(TagStream) then begin
                    FSourceFileType := sftRF64;
                    if ParseAudioAttributes then begin
                        LoadWAVEAttributes(TagStream);
                    end;
                    if SeekRF64(TagStream) = 0 then begin
                        Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                        Exit;
                    end;
                end else begin
                    //* AIFF
                    TagStream.Seek(PreviousPosition, soBeginning);
                    if CheckAIFF(TagStream) then begin
                        FSourceFileType := sftAIFF;
                        if ParseAudioAttributes then begin
                            AIFFInfo := GetAIFFInformation(TagStream);
                        end;
                        if SeekAIFF(TagStream) = 0 then begin
                            Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                            Exit;
                        end;
                    end else begin
                        //* DSF
                        TagStream.Seek(PreviousPosition, soBeginning);
                        if CheckDSF(TagStream) then begin
                            FSourceFileType := sftDSF;
                            if ParseAudioAttributes then begin
                                LoadDSFInfo(TagStream);
                            end;
                            if SeekDSF(TagStream) = 0 then begin
                                Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                                Exit;
                            end;
                        end;
                    end;
                end;
            end;
            if NOT ID3v2ValidTag(TagStream) then begin
                Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                Exit;
            end;
        end;
        try
            TagStream.Read(MajorVersion, 1);
            TagStream.Read(MinorVersion, 1);
        except
            Exit;
        end;
        if (MajorVersion > 4)
        OR (MajorVersion < 2)
        then begin
            Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_VERSION;
            Exit;
        end;
        try
            TagStream.Read(Flags, 1);
            DecodeFlags;
        except
            Exit;
        end;
        try
            TagStream.Read(CodedSize, 4);
            DecodeSize;
        except
            Exit;
        end;
        FPosition := TagStream.Position - 10;
        if ExtendedHeader then begin
            //Showmessage('Extended header found!');
            ReadExtendedHeader(TagStream);
        end;
        repeat
            ValidFrameLoaded := LoadFrame(TagStream);
            //* TODO seek back 3 bytes for compatibility for corrupt tags and try again
        until NOT ValidFrameLoaded
        OR (TagStream.Position >= FPosition + 10 + Self.Size);
        Result := ID3V2LIBRARY_SUCCESS;
        Loaded := True;
    finally
        //* Check if source is an MPEG
        TagStream.Seek(Self.Size, soBeginning);
        if CheckMPEG(TagStream) then begin
            FSourceFileType := sftMPEG;
            if ParseAudioAttributes then begin
                //TagStream.Seek(Self.Size, soBeginning);
                MPEGInfo := MPEGProcessHeader(TagStream);
                Self.BitRate := MPEGInfo.BitRate;
                //TagStream.Seek(Self.Size, soBeginning);
                GetMPEGHeaderInformation(TagStream);
            end;
        end;
    end;
end;

function TID3v2Tag.LoadFromFile(FileName: String): Integer;
var
    FileStream: TFileStream;
begin
    Clear;
    Loaded := False;
    if NOT FileExists(FileName) then begin
        Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        FileStream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
    except
        Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        Result := LoadFromStream(FileStream);
        if Result < ID3V2LIBRARY_ERROR_OPENING_FILE
        //OR (Result = ID3V2LIBRARY_ERROR_NOT_SUPPORTED_VERSION)
        then begin
            Self.FileName := FileName;
        end;
    finally
        FreeAndNil(FileStream);
    end;
end;

function TID3v2Tag.LoadFromMemory(MemoryAddress: Pointer): Integer;
var
    ID3v2Size: Cardinal;
    DataStream: TMemoryStream;
begin
    Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
    if MemoryAddress <> nil then begin
        ID3v2Size := GetID3v2Size(MemoryAddress);
        if ID3v2Size > 0 then begin
            DataStream := TMemoryStream.Create;
            try
                DataStream.Write(MemoryAddress^, ID3v2Size);
                DataStream.Seek(0, soBeginning);
                Result := LoadFromStream(DataStream);
            finally
                FreeAndNil(DataStream);
            end;
        end;
    end;
end;

procedure TID3v2Tag.DecodeFlags;
var
    Bit: Byte;
begin
    if MajorVersion = 2 then begin
        Bit := Flags SHR 7;
        Unsynchronised := Boolean(Bit);
        Bit := Flags SHL 1;
        Bit := Bit SHR 7;
        Compressed := Boolean(Bit);
    end else begin
        Bit := Flags SHR 7;
        Unsynchronised := Boolean(Bit);
        Bit := Flags SHL 1;
        Bit := Bit SHR 7;
        ExtendedHeader := Boolean(Bit);
        Bit := Flags SHL 2;
        Bit := Bit SHR 7;
        Experimental := Boolean(Bit);
        Bit := Flags SHL 3;
        Bit := Bit SHR 7;
        FooterPresent := Boolean(Bit);
    end;
end;

procedure TID3v2Tag.EncodeFlags;
var
    EncodedFlags: Byte;
    Bit: Byte;
begin
    EncodedFlags := 0;
    if Unsynchronised then begin
        Bit := 1 SHL 7;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if ExtendedHeader then begin
        //* Extended header writing is not supported
        //Bit := 1 SHL 6;
        //EncodedFlags := EncodedFlags OR Bit;
    end;
    if Experimental then begin
        Bit := 1 SHL 5;
        EncodedFlags := EncodedFlags OR Bit;
    end;
    if FooterPresent then begin
        //* Footer writing is not supported
        //Bit := 1 SHL 6;
        //EncodedFlags := EncodedFlags OR Bit;
    end;
    Flags := EncodedFlags;
end;

procedure TID3v2Tag.DecodeSize;
begin
    UnSyncSafe(CodedSize, 4, Size);
    Size := Size + 10;
end;

function TID3v2Tag.ReadExtendedHeader(TagStream: TStream): Boolean;
var
    ExtendedFrameID: TFrameID;
begin
    try
        TagStream.Read(ExtendedFrameID[0], 4);
        //* Support for bad Tags that report an extended header but don't have one
        if NOT ValidID3v2FrameID(ExtendedFrameID) then begin
            TagStream.Seek(-4, soCurrent);
            //* v3
            if MajorVersion = 3 then begin
                with ExtendedHeader3 do begin
                    //* If extended header is unsynchronised needed to remove it
                    //SizeData.CopyFrom(TagStream, 4);
                    //if Unsynchronised then begin
                    //    RemoveUnsynchronisationOnExtendedHeaderSize;
                    //end;
                    //SizeData.Seek(0, soBeginning);
                    //SizeData.Read(CodedExtendedHeaderSize3, 4);
                    //SizeData.Seek(0, soBeginning);
                    TagStream.Read(CodedSize, 4);
                    DecodeExtendedHeaderSize;

                    //* Read extended header flags
                    TagStream.Read(ExtendedHeader3.Flags, 2);
                    DecodeExtendedHeaderFlags;

                    Data.CopyFrom(TagStream, Size - 2);
                    if Unsynchronised then begin
                        RemoveUnsynchronisationOnExtendedHeaderData;
                    end;
                end;
            end;
            //* v4
            if MajorVersion = 4 then begin
                with ExtendedHeader4 do begin
                    TagStream.Read(CodedSize, 4);
                    DecodeExtendedHeaderSize;
                    TagStream.Read(FlagBytes, 1);
                    TagStream.Read(Flags, 1);
                    DecodeExtendedHeaderFlags;
                    CalculateExtendedFlagsDataSize;
                    SetLength(ExtendedFlagsData, ExtendedFlagsDataSize);
                    TagStream.Read(ExtendedFlagsData[0], ExtendedFlagsDataSize);
                    DecodeExtendedHeaderFlagData;
                end;
            end;
        end else begin
            ExtendedHeader := False;
            TagStream.Seek(-4, soCurrent);
        end;
        Result := True;
    except
        Result := False;
    end;
end;

procedure UnSyncSafe(var Source; const SourceSize: Integer; var Dest: Cardinal);
type
    TBytes = array [0..MaxInt - 1] of Byte;
var
    I: Byte;
begin
    { Test : Source = $01 $80 -> Dest = 255
             Source = $02 $00 -> Dest = 256
             Source = $02 $01 -> Dest = 257 etc.
    }
    Dest := 0;
    for I := 0 to SourceSize - 1 do begin
        Dest := Dest shl 7;
        Dest := Dest or (TBytes(Source)[I] and $7F); // $7F = %01111111
    end;
end;

procedure SyncSafe(Source: Cardinal; var Dest; const DestSize: Integer);
type
    TBytes = array [0..MaxInt - 1] of Byte;
var
    I: Byte;
begin
    { Test : Source = 255 -> Dest = $01 $80
             Source = 256 -> Dest = $02 $00
             Source = 257 -> Dest = $02 $01 etc.
    }
    for I := DestSize - 1 downto 0 do begin
        TBytes(Dest)[I] := Source and $7F; // $7F = %01111111
        Source := Source shr 7;
    end;
end;

{$IFDEF CPUX64}
procedure ReverseExtended(Source: TExtendedX87; var Dest: TExtendedX87);
begin
    Dest.AsBytes[0] := Source.AsBytes[9];
    Dest.AsBytes[1] := Source.AsBytes[8];
    Dest.AsBytes[2] := Source.AsBytes[7];
    Dest.AsBytes[3] := Source.AsBytes[6];
    Dest.AsBytes[4] := Source.AsBytes[5];
    Dest.AsBytes[5] := Source.AsBytes[4];
    Dest.AsBytes[6] := Source.AsBytes[3];
    Dest.AsBytes[7] := Source.AsBytes[2];
    Dest.AsBytes[8] := Source.AsBytes[1];
    Dest.AsBytes[9] := Source.AsBytes[0];
end;
{$ELSE}
procedure ReverseExtended(Source: TExtendedBytes; var Dest: TExtendedBytes);
begin
    Dest[0] := Source[9];
    Dest[1] := Source[8];
    Dest[2] := Source[7];
    Dest[3] := Source[6];
    Dest[4] := Source[5];
    Dest[5] := Source[4];
    Dest[6] := Source[3];
    Dest[7] := Source[2];
    Dest[8] := Source[1];
    Dest[9] := Source[0];
end;
{$ENDIF}

function TID3v2Tag.LoadFrame(TagStream: TStream): Boolean;
var
    FrameID: TFrameID;
    FrameIndex: Integer;
    ValidFrame: Boolean;
begin
    Result := False;
    FillChar(FrameID, SizeOf(FrameID), 0);
    try
        if Self.MajorVersion = 2 then begin
            TagStream.Read(FrameID[0], 3);
            ValidFrame := ValidID3v2FrameID2(FrameID);
        end else begin
            TagStream.Read(FrameID[0], 4);
            ValidFrame := ValidID3v2FrameID(FrameID);
            if NOT ValidFrame then begin
                FillChar(FrameID, SizeOf(FrameID), 0);
                TagStream.Seek(- 4, soCurrent);
                TagStream.Read(FrameID[0], 3);
                ValidFrame := ValidID3v2FrameID2(FrameID);
                FStrangeTag := True;
            end;
        end;
        //* Workaround for buggy DataLengthIndicator
        if NOT ValidFrame then begin
            TagStream.Read(FrameID[0], 4);
            ValidFrame := ValidID3v2FrameID(FrameID);
        end;
        if ValidFrame then begin
            FrameIndex := AddFrame(FrameID);
            if FrameIndex > - 1 then begin
                LoadFrameData(TagStream, FrameIndex);
                Result := True;
            end;
        end;
    except

    end;
end;

procedure TID3v2Tag.LoadFrameData(TagStream: TStream; FrameIndex: Integer);
var
    Size: DWord;
    Flags: Word;
    DataLengthIndicatorValueCoded: Cardinal;
begin
    try
        if FStrangeTag then begin
            Size := 0;
            Flags := 0;
            if Frames[FrameIndex].ID[3] = 0 then begin
                TagStream.Seek(4, soCurrent);
            end else begin
                TagStream.Seek(3, soCurrent);
            end;
            TagStream.Read(Size, 3);
            Frames[FrameIndex].Size := Size;
            if (Frames[FrameIndex].Size < 1)
            OR (Frames[FrameIndex].Size > Self.Size)
            then begin
                Exit;
            end;
            Frames[FrameIndex].Unsynchronised := Unsynchronised;
            Frames[FrameIndex].Stream.CopyFrom(TagStream, Frames[FrameIndex].Size);
            Convertv2Tov3(FrameIndex);
            Exit;
        end;
        if MajorVersion = 2 then begin
            Size := 0;
            Flags := 0;
            TagStream.Read(Size, 3);
            Frames[FrameIndex].Size := ReverseBytes(Size SHL 8);
            if (Frames[FrameIndex].Size < 1)
            OR (Frames[FrameIndex].Size > Self.Size)
            then begin
                Exit;
            end;
            Frames[FrameIndex].Unsynchronised := Unsynchronised;
            Frames[FrameIndex].Stream.CopyFrom(TagStream, Frames[FrameIndex].Size);
            Convertv2Tov3(FrameIndex);
        end;
        if MajorVersion = 3 then begin
            TagStream.Read(Size, 4);
            TagStream.Read(Flags, 2);
            Frames[FrameIndex].Size := ReverseBytes(Size);
            if (Frames[FrameIndex].Size < 1)
            OR (Frames[FrameIndex].Size > Self.Size)
            then begin
                Exit;
            end;
            Frames[FrameIndex].Flags := Swap16(Flags);
            Frames[FrameIndex].DecodeFlags3;
            Frames[FrameIndex].Unsynchronised := Unsynchronised;
            if Frames[FrameIndex].Compressed then begin
                TagStream.Read(DataLengthIndicatorValueCoded, 4);
                UnSyncSafe(DataLengthIndicatorValueCoded, 4, Frames[FrameIndex].DataLengthIndicatorValue);
                Frames[FrameIndex].DataLengthIndicator := True;
                Frames[FrameIndex].Size := Frames[FrameIndex].Size - 4;
            end;
            if Frames[FrameIndex].Encrypted then begin
                TagStream.Read(Frames[FrameIndex].EncryptionMethod, 1);
                Frames[FrameIndex].Size := Frames[FrameIndex].Size - 1;
            end;
            if Frames[FrameIndex].GroupingIdentity then begin
                TagStream.Read(Frames[FrameIndex].GroupIdentifier, 1);
                Frames[FrameIndex].Size := Frames[FrameIndex].Size - 1;
            end;
            Frames[FrameIndex].Stream.CopyFrom(TagStream, Frames[FrameIndex].Size);
        end;
        if MajorVersion > 3 then begin
            TagStream.Read(Size, 4);
            TagStream.Read(Flags, 2);
            UnSyncSafe(Size, 4, Frames[FrameIndex].Size);
            if (Frames[FrameIndex].Size < 1)
            OR (Frames[FrameIndex].Size > Self.Size)
            then begin
                Exit;
            end;
            Frames[FrameIndex].Flags := Swap16(Flags);
            Frames[FrameIndex].DecodeFlags4;
            if Frames[FrameIndex].GroupingIdentity then begin
                TagStream.Read(Frames[FrameIndex].GroupIdentifier, 1);
                Frames[FrameIndex].Size := Frames[FrameIndex].Size - 1;
            end;
            if Frames[FrameIndex].Encrypted then begin
                TagStream.Read(Frames[FrameIndex].EncryptionMethod, 1);
                Frames[FrameIndex].Size := Frames[FrameIndex].Size - 1;
            end;
            if Frames[FrameIndex].DataLengthIndicator then begin
                TagStream.Read(DataLengthIndicatorValueCoded, 4);
                UnSyncSafe(DataLengthIndicatorValueCoded, 4, Frames[FrameIndex].DataLengthIndicatorValue);
                Frames[FrameIndex].Size := Frames[FrameIndex].Size - 4;
            end;
            Frames[FrameIndex].Stream.CopyFrom(TagStream, Frames[FrameIndex].Size);
        end;
    except
        //*
    end;
end;

function TID3v2Tag.AddFrame(FrameID: TFrameID): Integer;
begin
    Result := -1;
    try
        SetLength(Frames, Length(Frames) + 1);
        Frames[Length(Frames) - 1] := TID3v2Frame.Create;
        Frames[Length(Frames) - 1].ID := FrameID;
        Result := Length(Frames) - 1;
        Inc(FrameCount);
    except
        //*
    end;
end;

function TID3v2Tag.AddFrame(FrameID: String): Integer;
var
    ID: TFrameID;
begin
    AnsiStringToPAnsiChar(FrameID, ID);
    Result := AddFrame(ID);
end;

function TID3v2Tag.InsertFrame(FrameID: TFrameID; Position: Integer): Integer;
var
    i: Integer;
begin
    Result := -1;
    try
        SetLength(Frames, Length(Frames) + 1);
        if Position > Length(Frames) - 1 then begin
            Position := Length(Frames) - 1;
        end;
        for i := Length(Frames) - 2 downto Position do begin
            Frames[i + 1] := Frames[i];
        end;
        Frames[Position] := TID3v2Frame.Create;
        Frames[Position].ID := FrameID;
        Result := Position;
        Inc(FrameCount);
    except
        //*
    end;
end;

function TID3v2Tag.InsertFrame(FrameID: String; Position: Integer): Integer;
var
    ID: TFrameID;
begin
    AnsiStringToPAnsiChar(FrameID, ID);
    Result := InsertFrame(ID, Position);
end;

function TID3v2Tag.DeleteFrame(FrameIndex: Integer): Boolean;
begin
    Result := False;
    if (FrameIndex >= Length(Frames))
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    FreeAndNil(Frames[FrameIndex]);
    CompactFrameList;
    Dec(FrameCount);
    Result := True;
end;

function TID3v2Tag.DeleteFrame(FrameID: TFrameID): Boolean;
var
    Index: Integer;
begin
    Result := False;
    Index := FrameExists(FrameID);
    if (Index >= Length(Frames))
    OR (Index < 0)
    then begin
        Exit;
    end;
    Result := DeleteFrame(Index);
end;

function TID3v2Tag.DeleteFrame(FrameID: String): Boolean;
var
    ID: TFrameID;
begin
    AnsiStringToPAnsiChar(FrameID, ID);
    Result := DeleteFrame(ID);
end;

procedure TID3v2Tag.CompactFrameList;
var
    i: Integer;
    Compacted: Boolean;
begin
    Compacted := False;
    if Frames[FrameCount - 1]  = nil then begin
        Compacted := True;
    end else begin
        for i := 0 to FrameCount - 2 do begin
            if Frames[i] = nil then begin
                Frames[i] := Frames[i + 1];
                Frames[i + 1] := nil;
                Compacted := True;
            end;
        end;
    end;
    if Compacted then begin
        SetLength(Frames, Length(Frames) - 1);
    end;
end;

function TID3v2Tag.Convertv2PICtoAPIC(FrameIndex: Integer): Boolean;
var
    StrMimeType: String;
    Data: Byte;
    TextEncoding: Integer;
    UData: Word;
    MIMEType: String;
    Description: String;
    CoverType: Byte;
    PictureStream: TStream;
    i: Integer;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := False;
    MIMEType := '';
    Description := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);

        PictureStream := TMemoryStream.Create;

        try
            //* Get text encoding
            Frames[FrameIndex].Stream.Read(Data, 1);
            TextEncoding := Data;

            //* Get MIME type
            StrMimeType := '';
            for i := 0 to 2 do begin
                Frames[FrameIndex].Stream.Read(Data, 1);
                if Data <> 0 then begin
                    StrMimeType := StrMimeType + Char(Data);
                end;
            end;

            //* Get picture type
            Frames[FrameIndex].Stream.Read(Data, 1);
            CoverType := Data;

            //* Get description
            //* ASCII format ISO-8859-1
            case TextEncoding of
                0: begin
                    Description := '';
                    repeat
                        Frames[FrameIndex].Stream.Read(Data, 1);
                        if Data <> $0 then begin
                            Description := Description + Char(Data);
                        end;
                    until (Data = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    Description := Description;
                end;
                //* Unicode format UTF-16 with BOM
                1: begin
                    Description := '';
                    repeat
                        Frames[FrameIndex].Stream.Read(UData, 2);
                        if UData <> $0 then begin
                            Description := Description + Char(UData);
                        end;
                    until (UData = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    Description := Copy(Description, 2, Length(Description));
                end;
                //* Unicode format UTF-16BE without BOM
                2: begin
                    Description := '';
                    repeat
                        Frames[FrameIndex].Stream.Read(UData, 2);
                        if UData <> $0 then begin
                            Description := Description + Char(UData);
                        end;
                    until (UData = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                end;
                //* Unicode format UTF-8
                3: begin
                    SetLength(Bytes, 0);
                    ByteCounter := 0;
                    repeat
                        Frames[FrameIndex].Stream.Read(Data, 1);
                        if Data <> $0 then begin
                            SetLength(Bytes, Length(Bytes) + 1);
                            Bytes[ByteCounter] := Data;
                            Inc(ByteCounter);
                        end;
                    until (Data = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    Description := TEncoding.UTF8.GetString(Bytes);
                end;
            end;

            //* Get binary picture data
            PictureStream.Seek(0, soBeginning);
            try
                PictureStream.CopyFrom(Frames[FrameIndex].Stream, Frames[FrameIndex].Stream.Size - Frames[FrameIndex].Stream.Position);
                PictureStream.Seek(0, soFromBeginning);
            except

            end;

            //* Set results
            MIMEType := StrMimeType;

            MIMEType := UpperCase(MIMEType);
            if MIMEType = 'JPG' then begin
                MIMEType := 'image/jpeg';
            end;
            if MIMEType = 'PNG' then begin
                MIMEType := 'image/png';
            end;
            if MIMEType = 'GIF' then begin
                MIMEType := 'image/gif';
            end;
            if MIMEType = 'BMP' then begin
                MIMEType := 'image/bmp';
            end;

             Result := SetUnicodeCoverPictureFromStream(FrameIndex, Description, PictureStream, MIMEType, CoverType);

        finally
            FreeAndNil(PictureStream);
        end;

    except
        //*
    end;
end;

function TID3v2Tag.Convertv2Tov3(FrameIndex: Integer): Boolean;
var
    V2FrameID: String;
begin
    Result := False;
    V2FrameID := Char(Frames[FrameIndex].ID[0]) + Char(Frames[FrameIndex].ID[1]) + Char(Frames[FrameIndex].ID[2]);
    if V2FrameID = 'PIC' then begin
        ConvertString2FrameID('APIC', Frames[FrameIndex].ID);
        Convertv2PICtoAPIC(FrameIndex);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TYE' then begin
        ConvertString2FrameID('TYER', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TCO' then begin
        ConvertString2FrameID('TCON', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'BUF' then begin
        ConvertString2FrameID('RBUF', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'CNT' then begin
        ConvertString2FrameID('PCNT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'COM' then begin
        ConvertString2FrameID('COMM', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'CRA' then begin
        ConvertString2FrameID('ENCR', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'CRM' then begin
        ConvertString2FrameID('AENC', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'ETC' then begin
        ConvertString2FrameID('ETCO', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'EQU' then begin
        ConvertString2FrameID('EQUA', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'GEO' then begin
        ConvertString2FrameID('GEOB', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'IPL' then begin
        ConvertString2FrameID('TIPL', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'LNK' then begin
        ConvertString2FrameID('LINK', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'MCI' then begin
        ConvertString2FrameID('MCDI', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'MLL' then begin
        ConvertString2FrameID('MLLT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'POP' then begin
        ConvertString2FrameID('POPM', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'REV' then begin
        ConvertString2FrameID('RVRB', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'RVA' then begin
        ConvertString2FrameID('RVAD', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'SLT' then begin
        ConvertString2FrameID('SYLT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'STC' then begin
        ConvertString2FrameID('SYTC', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TAL' then begin
        ConvertString2FrameID('TALB', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TBP' then begin
        ConvertString2FrameID('TBPM', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TCM' then begin
        ConvertString2FrameID('TCOM', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TCO' then begin
        ConvertString2FrameID('TCON', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TCR' then begin
        ConvertString2FrameID('TCOP', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TDA' then begin
        ConvertString2FrameID('TDAT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TDY' then begin
        ConvertString2FrameID('TDLY', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TEN' then begin
        ConvertString2FrameID('TENC', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TFT' then begin
        ConvertString2FrameID('TFLT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TIM' then begin
        ConvertString2FrameID('TIME', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TKE' then begin
        ConvertString2FrameID('TKEY', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TLA' then begin
        ConvertString2FrameID('TLAN', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TLE' then begin
        ConvertString2FrameID('TLEN', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TMT' then begin
        ConvertString2FrameID('TMED', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TOA' then begin
        ConvertString2FrameID('TOPE', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TOF' then begin
        ConvertString2FrameID('TOFN', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TOL' then begin
        ConvertString2FrameID('TOLY', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TOR' then begin
        ConvertString2FrameID('TORY', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TOT' then begin
        ConvertString2FrameID('TOAL', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TDR' then begin
        ConvertString2FrameID('TRDA', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TP1' then begin
        ConvertString2FrameID('TPE1', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TP2' then begin
        ConvertString2FrameID('TPE2', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TP3' then begin
        ConvertString2FrameID('TPE3', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TP4' then begin
        ConvertString2FrameID('TPE4', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TPA' then begin
        ConvertString2FrameID('TPOS', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TPB' then begin
        ConvertString2FrameID('TPUB', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TRC' then begin
        ConvertString2FrameID('TSRC', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TRD' then begin
        ConvertString2FrameID('TRDA', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TRK' then begin
        ConvertString2FrameID('TRCK', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TSI' then begin
        ConvertString2FrameID('TSIZ', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TSS' then begin
        ConvertString2FrameID('TSSE', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TT1' then begin
        ConvertString2FrameID('TIT1', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TT2' then begin
        ConvertString2FrameID('TIT2', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TT3' then begin
        ConvertString2FrameID('TIT3', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TXT' then begin
        ConvertString2FrameID('TEXT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TXX' then begin
        ConvertString2FrameID('TXXX', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'TYE' then begin
        ConvertString2FrameID('TYER', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'UFI' then begin
        ConvertString2FrameID('UFID', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'ULT' then begin
        ConvertString2FrameID('USLT', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WAF' then begin
        ConvertString2FrameID('WOAF', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WAR' then begin
        ConvertString2FrameID('WOAR', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WAS' then begin
        ConvertString2FrameID('WOAS', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WCM' then begin
        ConvertString2FrameID('WCOM', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WCP' then begin
        ConvertString2FrameID('WCOP', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WPB' then begin
        ConvertString2FrameID('WPUB', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
    if V2FrameID = 'WXX' then begin
        ConvertString2FrameID('WXXX', Frames[FrameIndex].ID);
        Result := True;
        Exit;
    end;
end;

function TID3v2Tag.FrameExists(FrameID: TFrameID): Integer;
var
    i: Integer;
begin
    Result := - 1;
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            Result := i;
            Break;
        end;
    end;
end;

function TID3v2Tag.FrameExists(FrameID: String): Integer;
var
    i: Integer;
    TempFrameID: TFrameID;
begin
    Result := - 1;
    ConvertString2FrameID(FrameID, TempFrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(TempFrameID, Frames[i].ID) then begin
            Result := i;
            Break;
        end;
    end;
end;

function TID3v2Tag.FrameTypeCount(FrameID: TFrameID): Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            Inc(Result);
        end;
    end;
end;

function TID3v2Tag.FrameTypeCount(FrameID: String): Integer;
var
    ID: TFrameID;
begin
    ConvertString2FrameID(FrameID, ID);
    Result := FrameTypeCount(ID);
end;

function TID3v2Tag.CoverArtCount: Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, 'APIC') then begin
            Inc(Result);
        end;
    end;
end;

function TID3v2Tag.SaveTagToStream(var TagStream: TStream; PaddingSizeToWrite: Integer = 0): Integer;
begin
    try
        if MajorVersion = 2 then begin
            MajorVersion := 3;
        end;
        if (MajorVersion < 3)
        OR (MajorVersion > 4)
        then begin
            Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_VERSION;
            Exit;
        end;
        PaddingSize := PaddingSizeToWrite;
        EncodeSize;
        EncodeFlags;
        //* EncodeExtendedHeader;
        Result := WriteAllHeaders(TagStream);
        if Result <> ID3V2LIBRARY_SUCCESS then begin
            Exit;
        end;
        Result := WriteAllFrames(TagStream);
        if Result <> ID3V2LIBRARY_SUCCESS then begin
            Exit;
        end;
        Result := WritePadding(TagStream, PaddingSize);
        if Result <> ID3V2LIBRARY_SUCCESS then begin
            Exit;
        end;
        Result := ID3V2LIBRARY_SUCCESS;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function TID3v2Tag.SaveToFile(FileName: String): Integer;
var
    TagStream: TStream;
    NewTagStream: TStream;
    TagSizeInExistingStream: Cardinal;
    TagCodedSizeInExistingStream: Cardinal;
    WriteTagTotalSize: Cardinal;
    NeedToCopyExistingStream: Boolean;
    PaddingNeededToWrite: Integer;
    NewFile: Boolean;
    ExclusiveAccess: Boolean;

    function CheckTag: Boolean;
    var
        PreviousPosition: Int64;
    begin
        PreviousPosition := TagStream.Position;
        if ID3v2ValidTag(TagStream) then begin
            //* Skip version data and flags
            TagStream.Seek(3, soCurrent);
            TagStream.Read(TagCodedSizeInExistingStream, 4);
            UnSyncSafe(TagCodedSizeInExistingStream, 4, TagSizeInExistingStream);
            //* Add header size to size
            TagSizeInExistingStream := TagSizeInExistingStream + 10;
            if (WriteTagTotalSize > TagSizeInExistingStream)
            OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
            then begin
                NeedToCopyExistingStream := True;
                NewFile := True;
            end;
            TagStream.Seek(PreviousPosition, soBeginning);
            Result := True;
        end else begin
            Result := False;
        end;
    end;

begin
    TagStream := nil;
    NewTagStream := nil;
    NewFile := False;
    try
        try
            if FrameCount = 0 then begin
                Result := ID3V2LIBRARY_ERROR_EMPTY_TAG;
                Exit;
            end;
            if MajorVersion = 2 then begin
                MajorVersion := 3;
            end;
            if CalculateTotalFramesSize = 0 then begin
                Result := ID3V2LIBRARY_ERROR_EMPTY_FRAMES;
                Exit;
            end;
            if NOT FileExists(FileName) then begin
                TagStream := TFileStream.Create(FileName, fmCreate OR fmShareDenyWrite);
                ExclusiveAccess := True;
            end else begin
                try
                    TagStream := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareExclusive);
                    ExclusiveAccess := True;
                    FreeAndNil(TagStream);
                except
                    ExclusiveAccess := False;
                end;
                try
                    TagStream := TFileStream.Create(FileName, fmOpenReadWrite OR fmShareDenyWrite);
                except
                    Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
                    Exit;
                end;
            end;
            NeedToCopyExistingStream := False;
            WriteTagTotalSize := CalculateTagSize(0);
            try
                if CheckRIFF(TagStream) then begin
                    if NOT ValidRIFF(TagStream) then begin
                        Result := ID3V2LIBRARY_ERROR_CORRUPT;
                        Exit;
                    end;
                    if SeekRIFF(TagStream) > 0 then begin
                        if CheckTag then begin
                            if (WriteTagTotalSize > TagSizeInExistingStream)
                            OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
                            then begin
                                TagStream.Seek(0, soBeginning);
                                //* Update size datas
                                Result := RIFFUpdateID3v2(FileName, TagStream, WriteTagTotalSize, TagSizeInExistingStream, PaddingToWrite);
                                if Result = ID3V2LIBRARY_SUCCESS then begin
                                    Result := SaveTagToStream(TagStream, PaddingToWrite);
                                end;
                                Exit;
                            end else begin
                                PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                                //* Just write it
                                Result := SaveTagToStream(TagStream, PaddingNeededToWrite);
                                Exit;
                            end;
                        //* Need to create new Tag
                        end else begin
                            TagStream.Seek(0, soBeginning);
                            Result := RIFFCreateID3v2(FileName, TagStream, WriteTagTotalSize, PaddingToWrite);
                            if Result = ID3V2LIBRARY_SUCCESS then begin
                                Result := SaveTagToStream(TagStream, PaddingToWrite);
                            end;
                            Exit;
                        end;
                    //* Need to create new Tag
                    end else begin
                        TagStream.Seek(0, soBeginning);
                        Result := RIFFCreateID3v2(FileName, TagStream, WriteTagTotalSize, PaddingToWrite);
                        if Result = ID3V2LIBRARY_SUCCESS then begin
                            Result := SaveTagToStream(TagStream, PaddingToWrite);
                        end;
                        Exit;
                    end;
                end else begin
                    TagStream.Seek(0, soBeginning);
                    if CheckAIFF(TagStream) then begin
                        if SeekAIFF(TagStream) > 0 then begin
                            if CheckTag then begin
                                if (WriteTagTotalSize > TagSizeInExistingStream)
                                OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
                                then begin
                                    TagStream.Seek(0, soBeginning);
                                    //* Update size datas
                                    Result := AIFFUpdateID3v2(FileName, TagStream, WriteTagTotalSize, TagSizeInExistingStream, PaddingToWrite);
                                    if Result = ID3V2LIBRARY_SUCCESS then begin
                                        Result := SaveTagToStream(TagStream, PaddingToWrite);
                                    end;
                                    Exit;
                                end else begin
                                    PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                                    //* Just write it
                                    Result := SaveTagToStream(TagStream, PaddingNeededToWrite);
                                    Exit;
                                end;
                            //* Need to create new Tag
                            end else begin
                                TagStream.Seek(0, soBeginning);
                                Result := AIFFCreateID3v2(FileName, TagStream, WriteTagTotalSize, PaddingToWrite);
                                if Result = ID3V2LIBRARY_SUCCESS then begin
                                    Result := SaveTagToStream(TagStream, PaddingToWrite);
                                end;
                                Exit;
                            end;
                        end else begin
                            TagStream.Seek(0, soBeginning);
                            Result := AIFFCreateID3v2(FileName, TagStream, WriteTagTotalSize, PaddingToWrite);
                            if Result = ID3V2LIBRARY_SUCCESS then begin
                                Result := SaveTagToStream(TagStream, PaddingToWrite);
                            end;
                            Exit;
                        end;
                    end else begin
                        TagStream.Seek(0, soBeginning);
                        if CheckRF64(TagStream) then begin
                            if NOT ValidRF64(TagStream) then begin
                                Result := ID3V2LIBRARY_ERROR_CORRUPT;
                                Exit;
                            end;
                            if SeekRF64(TagStream) > 0 then begin
                                if CheckTag then begin
                                    if (WriteTagTotalSize > TagSizeInExistingStream)
                                    OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
                                    then begin
                                        TagStream.Seek(0, soBeginning);
                                        //* Update size datas
                                        Result := RF64UpdateID3v2(FileName, TagStream, WriteTagTotalSize, TagSizeInExistingStream, PaddingToWrite);
                                        if Result = ID3V2LIBRARY_SUCCESS then begin
                                            Result := SaveTagToStream(TagStream, PaddingToWrite);
                                        end;
                                        Exit;
                                    end else begin
                                        PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                                        //* Just write it
                                        Result := SaveTagToStream(TagStream, PaddingNeededToWrite);
                                        Exit;
                                    end;
                                //* Need to create new Tag
                                end else begin
                                    TagStream.Seek(0, soBeginning);
                                    Result := RF64CreateID3v2(FileName, TagStream, WriteTagTotalSize, PaddingToWrite);
                                    if Result = ID3V2LIBRARY_SUCCESS then begin
                                        Result := SaveTagToStream(TagStream, PaddingToWrite);
                                    end;
                                    Exit;
                                end;
                            end else begin
                                TagStream.Seek(0, soBeginning);
                                Result := RF64CreateID3v2(FileName, TagStream, WriteTagTotalSize, PaddingToWrite);
                                if Result = ID3V2LIBRARY_SUCCESS then begin
                                    Result := SaveTagToStream(TagStream, PaddingToWrite);
                                end;
                                Exit;
                            end;
                        end else begin
                            TagStream.Seek(0, soBeginning);
                            if CheckDSF(TagStream) then begin
                                if NOT ValidDSF(TagStream) then begin
                                    Result := ID3V2LIBRARY_ERROR_CORRUPT;
                                    Exit;
                                end;
                                Result := SaveDSF(TagStream, WriteTagTotalSize);
                                Exit;
                            end else begin
                                //* Normal file (MP3) - tag at start
                                TagStream.Seek(0, soBeginning);
                                if NOT CheckTag then begin
                                    TagSizeInExistingStream := 0;
                                    NeedToCopyExistingStream := True;
                                    NewFile := True;
                                end;
                            end;
                        end;
                    end;
                end;
            except
                Result := ID3V2LIBRARY_ERROR_READING_FILE;
                Exit;
            end;

            if (TagSizeInExistingStream = 0)
            OR NewFile
            then begin
                PaddingNeededToWrite := PaddingToWrite;
            end else begin
                //* Calculate padding here
                PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                if PaddingNeededToWrite < 0 then begin
                    PaddingNeededToWrite := PaddingToWrite;
                end;
            end;

            if NewFile then begin
                if NOT ExclusiveAccess then begin
                    Result := ID3V2LIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
                    Exit;
                end;
                NewTagStream := TFileStream.Create(FileName + '.tmp', fmCreate OR fmShareExclusive);
                try
                    Result := SaveTagToStream(NewTagStream, PaddingNeededToWrite);
                    TagStream.Seek(TagSizeInExistingStream, soBeginning);
                    NewTagStream.CopyFrom(TagStream, TagStream.Size - TagSizeInExistingStream);
                    if Assigned(TagStream) then begin
                        FreeAndNil(TagStream);
                    end;
                    if Assigned(NewTagStream) then begin
                        FreeAndNil(NewTagStream);
                    end;
                    if SysUtils.DeleteFile(FileName) then begin
                        if RenameFile(FileName + '.tmp', FileName) then begin
                            Result := ID3V2LIBRARY_SUCCESS;
                            Exit;
                        end;
                    end else begin
                        SysUtils.DeleteFile(FileName + '.tmp');
                        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                    end;
                except
                    Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                    Exit;
                end;
            end else begin
                try
                    Result := SaveTagToStream(TagStream, PaddingNeededToWrite);
                except
                    Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                    Exit;
                end;
            end;
        finally
            if Assigned(TagStream) then begin
                FreeAndNil(TagStream);
            end;
            if Assigned(NewTagStream) then begin
                FreeAndNil(NewTagStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function TID3v2Tag.SaveToStream(Stream: TStream): Integer;
var
    NewTagStream: TStream;
    TagSizeInExistingStream: Cardinal;
    TagCodedSizeInExistingStream: Cardinal;
    WriteTagTotalSize: Cardinal;
    NeedToCopyExistingStream: Boolean;
    PaddingNeededToWrite: Integer;
    NewFile: Boolean;
    ExclusiveAccess: Boolean;
    FileName: String;

    function CheckTag: Boolean;
    var
        PreviousPosition: Int64;
    begin
        PreviousPosition := Stream.Position;
        if ID3v2ValidTag(Stream) then begin
            //* Skip version data and flags
            Stream.Seek(3, soCurrent);
            Stream.Read(TagCodedSizeInExistingStream, 4);
            UnSyncSafe(TagCodedSizeInExistingStream, 4, TagSizeInExistingStream);
            //* Add header size to size
            TagSizeInExistingStream := TagSizeInExistingStream + 10;
            if (WriteTagTotalSize > TagSizeInExistingStream)
            OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
            then begin
                NeedToCopyExistingStream := True;
                NewFile := True;
            end;
            Stream.Seek(PreviousPosition, soBeginning);
            Result := True;
        end else begin
            Result := False;
        end;
    end;

begin
    NewTagStream := nil;
    NewFile := False;
    ExclusiveAccess := True;
    FileName := '';
    try
        try
            if FrameCount = 0 then begin
                Result := ID3V2LIBRARY_ERROR_EMPTY_TAG;
                Exit;
            end;
            if MajorVersion = 2 then begin
                MajorVersion := 3;
            end;
            if CalculateTotalFramesSize = 0 then begin
                Result := ID3V2LIBRARY_ERROR_EMPTY_FRAMES;
                Exit;
            end;
            Stream.Seek(0, soBeginning);
            NeedToCopyExistingStream := False;
            WriteTagTotalSize := CalculateTagSize(0);
            try
                if CheckRIFF(Stream) then begin
                    if NOT ValidRIFF(Stream) then begin
                        Result := ID3V2LIBRARY_ERROR_CORRUPT;
                        Exit;
                    end;
                    if SeekRIFF(Stream) > 0 then begin
                        if CheckTag then begin
                            if (WriteTagTotalSize > TagSizeInExistingStream)
                            OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
                            then begin
                                Stream.Seek(0, soBeginning);
                                //* Update size datas
                                Result := RIFFUpdateID3v2('', Stream, WriteTagTotalSize, TagSizeInExistingStream, PaddingToWrite);
                                if Result = ID3V2LIBRARY_SUCCESS then begin
                                    Result := SaveTagToStream(Stream, PaddingToWrite);
                                end;
                                Exit;
                            end else begin
                                PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                                //* Just write it
                                Result := SaveTagToStream(Stream, PaddingNeededToWrite);
                                Exit;
                            end;
                        //* Need to create new Tag
                        end else begin
                            Stream.Seek(0, soBeginning);
                            Result := RIFFCreateID3v2('', Stream, WriteTagTotalSize, PaddingToWrite);
                            if Result = ID3V2LIBRARY_SUCCESS then begin
                                Result := SaveTagToStream(Stream, PaddingToWrite);
                            end;
                            Exit;
                        end;
                    //* Need to create new Tag
                    end else begin
                        Stream.Seek(0, soBeginning);
                        Result := RIFFCreateID3v2('', Stream, WriteTagTotalSize, PaddingToWrite);
                        if Result = ID3V2LIBRARY_SUCCESS then begin
                            Result := SaveTagToStream(Stream, PaddingToWrite);
                        end;
                        Exit;
                    end;
                end else begin
                    Stream.Seek(0, soBeginning);
                    if CheckAIFF(Stream) then begin
                        if SeekAIFF(Stream) > 0 then begin
                            if CheckTag then begin
                                if (WriteTagTotalSize > TagSizeInExistingStream)
                                OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
                                then begin
                                    Stream.Seek(0, soBeginning);
                                    //* Update size datas
                                    Result := AIFFUpdateID3v2('', Stream, WriteTagTotalSize, TagSizeInExistingStream, PaddingToWrite);
                                    if Result = ID3V2LIBRARY_SUCCESS then begin
                                        Result := SaveTagToStream(Stream, PaddingToWrite);
                                    end;
                                    Exit;
                                end else begin
                                    PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                                    //* Just write it
                                    Result := SaveTagToStream(Stream, PaddingNeededToWrite);
                                    Exit;
                                end;
                            //* Need to create new Tag
                            end else begin
                                Stream.Seek(0, soBeginning);
                                Result := AIFFCreateID3v2('', Stream, WriteTagTotalSize, PaddingToWrite);
                                if Result = ID3V2LIBRARY_SUCCESS then begin
                                    Result := SaveTagToStream(Stream, PaddingToWrite);
                                end;
                                Exit;
                            end;
                        end else begin
                            Stream.Seek(0, soBeginning);
                            Result := AIFFCreateID3v2('', Stream, WriteTagTotalSize, PaddingToWrite);
                            if Result = ID3V2LIBRARY_SUCCESS then begin
                                Result := SaveTagToStream(Stream, PaddingToWrite);
                            end;
                            Exit;
                        end;
                    end else begin
                        Stream.Seek(0, soBeginning);
                        if CheckRF64(Stream) then begin
                            if NOT ValidRF64(Stream) then begin
                                Result := ID3V2LIBRARY_ERROR_CORRUPT;
                                Exit;
                            end;
                            if SeekRF64(Stream) > 0 then begin
                                if CheckTag then begin
                                    if (WriteTagTotalSize > TagSizeInExistingStream)
                                    OR (TagSizeInExistingStream - WriteTagTotalSize > PaddingToWrite)
                                    then begin
                                        Stream.Seek(0, soBeginning);
                                        //* Update size datas
                                        Result := RF64UpdateID3v2('', Stream, WriteTagTotalSize, TagSizeInExistingStream, PaddingToWrite);
                                        if Result = ID3V2LIBRARY_SUCCESS then begin
                                            Result := SaveTagToStream(Stream, PaddingToWrite);
                                        end;
                                        Exit;
                                    end else begin
                                        PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                                        //* Just write it
                                        Result := SaveTagToStream(Stream, PaddingNeededToWrite);
                                        Exit;
                                    end;
                                //* Need to create new Tag
                                end else begin
                                    Stream.Seek(0, soBeginning);
                                    Result := RF64CreateID3v2('', Stream, WriteTagTotalSize, PaddingToWrite);
                                    if Result = ID3V2LIBRARY_SUCCESS then begin
                                        Result := SaveTagToStream(Stream, PaddingToWrite);
                                    end;
                                    Exit;
                                end;
                            end else begin
                                Stream.Seek(0, soBeginning);
                                Result := RF64CreateID3v2('', Stream, WriteTagTotalSize, PaddingToWrite);
                                if Result = ID3V2LIBRARY_SUCCESS then begin
                                    Result := SaveTagToStream(Stream, PaddingToWrite);
                                end;
                                Exit;
                            end;
                        end else begin
                            Stream.Seek(0, soBeginning);
                            if CheckDSF(Stream) then begin
                                if NOT ValidDSF(Stream) then begin
                                    Result := ID3V2LIBRARY_ERROR_CORRUPT;
                                    Exit;
                                end;
                                Result := SaveDSF(Stream, WriteTagTotalSize);
                                Exit;
                            end else begin
                                //* Normal file (MP3) - tag at start
                                Stream.Seek(0, soBeginning);
                                if NOT CheckTag then begin
                                    TagSizeInExistingStream := 0;
                                    NeedToCopyExistingStream := True;
                                    NewFile := True;
                                end;
                            end;
                        end;
                    end;
                end;
            except
                Result := ID3V2LIBRARY_ERROR_READING_FILE;
                Exit;
            end;

            if (TagSizeInExistingStream = 0)
            OR NewFile
            then begin
                PaddingNeededToWrite := PaddingToWrite;
            end else begin
                //* Calculate padding here
                PaddingNeededToWrite := TagSizeInExistingStream - WriteTagTotalSize;
                if PaddingNeededToWrite < 0 then begin
                    PaddingNeededToWrite := PaddingToWrite;
                end;
            end;

            if NewFile then begin
                if NOT ExclusiveAccess then begin
                    Result := ID3V2LIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
                    Exit;
                end;
                NewTagStream := TMemoryStream.Create;
                try
                    Result := SaveTagToStream(NewTagStream, PaddingNeededToWrite);
                    Stream.Seek(TagSizeInExistingStream, soBeginning);
                    NewTagStream.CopyFrom(Stream, Stream.Size - TagSizeInExistingStream);
                    Stream.Size := 0;
                    Stream.Seek(0, soBeginning);
                    Stream.CopyFrom(NewTagStream, 0);
                    Result := ID3V2LIBRARY_SUCCESS;
                except
                    Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                    Exit;
                end;
            end else begin
                try
                    Result := SaveTagToStream(Stream, PaddingNeededToWrite);
                except
                    Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                    Exit;
                end;
            end;
        finally
            Stream.Seek(0, soBeginning);
            if Assigned(NewTagStream) then begin
                FreeAndNil(NewTagStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function TID3v2Tag.GetUnicodeText(FrameID: String; ReturnNativeText: Boolean = False): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeText(Index, ReturnNativeText);
end;

function TID3v2Tag.GetUnicodeText(FrameIndex: Integer; ReturnNativeText: Boolean = False): String;
var
    DataBOM: Word;
    Data: Byte;
    DataWord: Word;
    Bytes: TBytes;
    ByteCounter: Integer;
    BigEndian: Boolean;
begin
    Result := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        BigEndian := False;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Frames[FrameIndex].Stream.Read(Data, 1);

        if Data > 3 then begin
            Data := 0;
            Frames[FrameIndex].Stream.Seek(0, soBeginning);
        end;

        case Data of
            //* ISO-8859-1
            0: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if (Data = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if Data <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 1);
                            Bytes[ByteCounter] := Data;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                try
                    Result := StringOf(Bytes);
                except
                    Result := TEncoding.ANSI.GetString(Bytes);
                end;
            end;
            //* UTF-16
            1: begin
                Frames[FrameIndex].Stream.Read(DataBOM, 2);
                if DataBOM = $FEFF then begin
                    BigEndian := False;
                end;
                if DataBOM = $FFFE then begin
                    BigEndian := True;
                end;
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataWord, 2);
                    if (DataWord = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if DataWord <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 2);
                            Bytes[ByteCounter] := DataWord;
                            Inc(ByteCounter);
                            Bytes[ByteCounter] := DataWord SHR 8;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                if BigEndian then begin
                    Result := TEncoding.BigEndianUnicode.GetString(Bytes);
                end else begin
                    Result := TEncoding.Unicode.GetString(Bytes);
                end;
            end;
            //* UTF-16BE
            2: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataWord, 2);
                    if (DataWord = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if DataWord <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 2);
                            Bytes[ByteCounter] := DataWord;
                            Inc(ByteCounter);
                            Bytes[ByteCounter] := DataWord SHR 8;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                Result := TEncoding.BigEndianUnicode.GetString(Bytes);
            end;
            //* UTF-8
            3: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if (Data = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if Data <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 1);
                            Bytes[ByteCounter] := Data;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                if ReturnNativeText then begin
                    Result := TEncoding.ANSI.GetString(Bytes);
                end else begin
                    Result := TEncoding.UTF8.GetString(Bytes);
                end;
            end;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeText(FrameID: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeText(Index, Text);
end;

function TID3v2Tag.SetUnicodeText(FrameIndex: Integer; Text: String): Boolean;
var
    Data: Byte;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(PWideChar(Text)^, (Length(Text) + 1) * 2);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetUnicodeTextMultiple(FrameIndex: Integer; List: TStrings): Boolean;
begin
    List.Clear;
    List.Text := GetUnicodeText(FrameIndex);
    Result := List.Text <> '';
end;


function TID3v2Tag.GetUnicodeTextMultiple(FrameID: String; List: TStrings): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    List.Clear;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeTextMultiple(Index, List);
end;

function TID3v2Tag.SetUnicodeTextMultiple(FrameIndex: Integer; List: TStrings): Boolean;
var
    Data: Byte;
    i: Integer;
    Text: String;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        for i := 0 to List.Count - 1 do begin
            Text := List[i];
            Frames[FrameIndex].Stream.Write(PWideChar(Text)^, (Length(Text) + 1) * 2);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeTextMultiple(FrameID: String; List: TStrings): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeTextMultiple(Index, List);
end;

function TID3v2Tag.SetText(FrameID: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetText(Index, Text);
end;

function TID3v2Tag.SetText(FrameIndex: Integer; Text: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    Bytes := TEncoding.ANSI.GetBytes(Text);
    try
        Frames[FrameIndex].Stream.Clear;
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUTF8Text(FrameID: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUTF8Text(Index, Text);
end;

function TID3v2Tag.SetUTF8Text(FrameIndex: Integer; Text: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    Bytes := TEncoding.UTF8.GetBytes(Text);
    try
        Frames[FrameIndex].Stream.Clear;
        Data := $03;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetRawText(FrameID: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetRawText(Index, Text);
end;

function TID3v2Tag.SetRawText(FrameIndex: Integer; Text: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    Bytes := TEncoding.ANSI.GetBytes(Text);
    try
        Frames[FrameIndex].Stream.Clear;
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetUnicodeComment(FrameID: String; var LanguageID: TLanguageID; var Description: String): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    FillChar(LanguageID, SizeOf(LanguageID), 0);
    Description := '';
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeComment(Index, LanguageID, Description);
end;

function TID3v2Tag.FindUnicodeCommentByDescription(Description: String; var LanguageID: TLanguageID; var Comment: String): Integer;
var
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetLanguageID: TLanguageID;
    GetContent: String;
begin
    Result := - 1;
    AnsiStringToPAnsiChar('COMM', FrameID);
    FillChar(GetLanguageID, SizeOf(GetLanguageID), 0);
    GetDescription := '';
    Comment := '';
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            GetContent := GetUnicodeComment(i, GetLanguageID, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                Comment := GetContent;
                Result := i;
                Break;
            end;
        end;
    end;
end;

function TID3v2Tag.SetUnicodeCommentByDescription(Description: String; LanguageID: TLanguageID; Comment: String): Boolean;
var
    Index: Integer;
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetLanguageID: TLanguageID;
    GetContent: String;
begin
    Index := - 1;
    AnsiStringToPAnsiChar('COMM', FrameID);
    FillChar(GetLanguageID, SizeOf(GetLanguageID), 0);
    GetDescription := '';
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            GetContent := GetUnicodeComment(i, GetLanguageID, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                Index := i;
                Break;
            end;
        end;
    end;
    if Index = - 1 then begin
        Index := AddFrame('COMM');
    end;
    Result := SetUnicodeComment(Index, Comment, LanguageID, Description);
end;

function TID3v2Tag.GetUnicodeComment(FrameIndex: Integer; var LanguageID: TLanguageID; var Description: String): String;
begin
    Result := GetUnicodeContent(FrameIndex, LanguageID, Description);
end;

function TID3v2Tag.GetUnicodeContent(FrameID: String; var LanguageID: TLanguageID; var Description: String): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    FillChar(LanguageID, SizeOf(LanguageID), 0);
    Description := '';
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeComment(Index, LanguageID, Description);
end;

function TID3v2Tag.GetUnicodeContent(FrameIndex: Integer; var LanguageID: TLanguageID; var Description: String): String;
var
    Data: Byte;
    UData: Word;
    EncodingFormat: Byte;
    Bytes: TBytes;
    ByteCounter: Integer;
    DataBOM: Word;
    BigEndian: Boolean;
begin
    Result := '';
    FillChar(LanguageID, SizeOf(LanguageID), 0);
    Description := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        BigEndian := False;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get encoding format
        Frames[FrameIndex].Stream.Read(EncodingFormat, 1);
        //* Get language ID
        Frames[FrameIndex].Stream.Read(LanguageID[0], 3);
        //* Get decription and content
        case EncodingFormat of
            0: begin
                //* Get description
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := StringOf(Bytes);
                //* Get the content
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Result := StringOf(Bytes);
            end;
            1: begin
                //* Get description
                Description := '';
                Frames[FrameIndex].Stream.Read(DataBOM, 2);
                if DataBOM = $FEFF then begin
                    BigEndian := False;
                end;
                if DataBOM = $FFFE then begin
                    BigEndian := True;
                end;
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := UData;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := UData SHR 8;
                        Inc(ByteCounter);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                if BigEndian then begin
                    Description := TEncoding.BigEndianUnicode.GetString(Bytes);
                end else begin
                    Description := TEncoding.Unicode.GetString(Bytes);
                end;
                //* Get the content
                Frames[FrameIndex].Stream.Read(DataBOM, 2);
                if DataBOM = $FEFF then begin
                    BigEndian := False;
                end;
                if DataBOM = $FFFE then begin
                    BigEndian := True;
                end;
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := UData;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := UData SHR 8;
                        Inc(ByteCounter);
                    end;
                until (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                if BigEndian then begin
                    Result := TEncoding.BigEndianUnicode.GetString(Bytes);
                end else begin
                    Result := TEncoding.Unicode.GetString(Bytes);
                end;
            end;
            2: begin
                //* Get description
                Description := '';
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := UData;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := UData SHR 8;
                        Inc(ByteCounter);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.BigEndianUnicode.GetString(Bytes);
                //* Get the content
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := UData;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := UData SHR 8;
                        Inc(ByteCounter);
                    end;
                until (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Result := TEncoding.BigEndianUnicode.GetString(Bytes);
            end;
            3: begin
                //* Get description
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.UTF8.GetString(Bytes);
                //* Get the content
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Result := TEncoding.UTF8.GetString(Bytes);
            end;
        end;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeComment(FrameID: String; Comment: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeComment(Index, Comment, LanguageID, Description);
end;

function TID3v2Tag.SetUnicodeComment(FrameIndex: Integer; Comment: String; LanguageID: TLanguageID; Description: String): Boolean;
begin
    Result := SetUnicodeContent(FrameIndex, Comment, LanguageID, Description);
end;

function TID3v2Tag.SetContent(FrameID: String; Content: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetContent(Index, Content, LanguageID, Description);
end;

function TID3v2Tag.SetContent(FrameIndex: Integer; Content: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the language
        Frames[FrameIndex].Stream.Write(LanguageID[0], 3);
        //* Set the description
        Bytes := TEncoding.ANSI.GetBytes(Description);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the content with
        SetLength(Bytes, 0);
        Bytes := TEncoding.ANSI.GetBytes(Content);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUTF8Content(FrameID: String; Content: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUTF8Content(Index, Content, LanguageID, Description);
end;

function TID3v2Tag.SetUTF8Content(FrameIndex: Integer; Content: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $03;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the language
        Frames[FrameIndex].Stream.Write(LanguageID[0], 3);
        //* Set the description
        Bytes := TEncoding.UTF8.GetBytes(Description);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the content
        SetLength(Bytes, 0);
        Bytes := TEncoding.UTF8.GetBytes(Content);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeContent(FrameID: String; Content: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeContent(Index, Content, LanguageID, Description);
end;

function TID3v2Tag.SetUnicodeContent(FrameIndex: Integer; Content: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Data: Byte;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the language
        Frames[FrameIndex].Stream.Write(LanguageID[0], 3);
        //* Set the description
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(PWideChar(Description)^, (Length(Description) + 1) * 2);
        //* Write the content with BOM
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(PWideChar(Content)^, (Length(Content) + 1) * 2);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetUnicodeLyrics(FrameID: String; var LanguageID: TLanguageID; var Description: String): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    FillChar(LanguageID, SizeOf(LanguageID), 0);
    Description := '';
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeLyrics(Index, LanguageID, Description);
end;

function TID3v2Tag.GetUnicodeLyrics(FrameIndex: Integer; var LanguageID: TLanguageID; var Description: String): String;
begin
    Result := GetUnicodeContent(FrameIndex, LanguageID, Description);
end;

function TID3v2Tag.SetUnicodeLyrics(FrameID: String; Lyrics: String; LanguageID: TLanguageID; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeContent(Index, Lyrics, LanguageID, Description);
end;

function TID3v2Tag.SetUnicodeLyrics(FrameIndex: Integer; Lyrics: String; LanguageID: TLanguageID; Description: String): Boolean;
begin
    Result := SetUnicodeContent(FrameIndex, Lyrics, LanguageID, Description);
end;

function TID3v2Tag.GetUnicodeCoverPictureStream(FrameID: String; var PictureStream: TStream; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    MIMEType := '';
    Description := '';
    CoverType := 0;
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeCoverPictureStream(Index, PictureStream, MIMEType, Description, CoverType);
end;

function TID3v2Tag.GetUnicodeCoverPictureStream(FrameIndex: Integer; var PictureStream: TStream; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean;
var
    Data: Byte;
    TextEncoding: Integer;
    UData: Word;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := False;
    MIMEType := '';
    Description := '';
    CoverType := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get text encoding
        Frames[FrameIndex].Stream.Read(Data, 1);
        TextEncoding := Data;
        //* Get MIME type
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> 0 then begin
                MIMEType := MIMEType + Char(Data);
            end;
        until (Data = 0)
        OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
        //* Get picture type
        Frames[FrameIndex].Stream.Read(Data, 1);
        CoverType := Data;
        //* Get description
        //* ASCII format ISO-8859-1
        case TextEncoding of
            0: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := StringOf(Bytes);
            end;
            //* Unicode format UTF-16 with BOM
            1: begin
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        Description := Description + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := Copy(Description, 2, Length(Description));
            end;
            //* Unicode format UTF-16BE without BOM
            2: begin
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        Description := Description + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            //* Unicode format UTF-8
            3: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.UTF8.GetString(Bytes);
            end;
        end;
        //* Get binary picture data
        PictureStream.Seek(0, soBeginning);
        try
            PictureStream.CopyFrom(Frames[FrameIndex].Stream, Frames[FrameIndex].Stream.Size - Frames[FrameIndex].Stream.Position);
            PictureStream.Seek(0, soFromBeginning);
        except

        end;

        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetUnicodeCoverPictureInfo(FrameID: String; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    MIMEType := '';
    Description := '';
    CoverType := 0;
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeCoverPictureInfo(Index, MIMEType, Description, CoverType);
end;

function TID3v2Tag.GetUnicodeCoverPictureInfo(FrameIndex: Integer; var MIMEType: String; var Description: String; var CoverType: Integer): Boolean;
var
    Data: Byte;
    TextEncoding: Integer;
    UData: Word;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := False;
    MIMEType := '';
    Description := '';
    CoverType := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);

        //* Get text encoding
        Frames[FrameIndex].Stream.Read(Data, 1);
        TextEncoding := Data;

        //* Get MIME type
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> 0 then begin
                MimeType := MimeType + Char(Data);
            end;
        until (Data = 0)
        OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);

        //* Get picture type
        Frames[FrameIndex].Stream.Read(Data, 1);
        CoverType := Data;

        //* Get description
        //* ASCII format ISO-8859-1
        case TextEncoding of
            0: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := StringOf(Bytes);
            end;
            //* Unicode format UTF-16 with BOM
            1: begin
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        Description := Description + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := Copy(Description, 2, Length(Description));
            end;
            //* Unicode format UTF-16BE without BOM
            2: begin
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        Description := Description + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            //* Unicode format UTF-8
            3: begin
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.UTF8.GetString(Bytes);
            end;
        end;
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetCoverPictureInfoPointer(FrameIndex: Integer; var Data: Pointer; var DataSize: Int64; var MIMEType: Pointer; var Description: Pointer; var TextEncoding: Integer; var CoverType: Integer): Boolean;
var
    DataByte: Byte;
    UData: Word;
    Bytes: TBytes;
    ByteCounter: Integer;
    MimeTypeString, DescriptionString: String;
begin
    Result := False;
    CoverType := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);

        //* Get text encoding
        Frames[FrameIndex].Stream.Read(DataByte, 1);
        TextEncoding := DataByte;

        //* Get MIME type
        MIMEType := Pointer(NativeUInt(Frames[FrameIndex].Stream.Memory) + Frames[FrameIndex].Stream.Position);
        repeat
            Frames[FrameIndex].Stream.Read(DataByte, 1);
            if DataByte <> 0 then begin
                MimeTypeString := MimeTypeString + Char(DataByte);
            end;
        until (DataByte = 0)
        OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);

        //* Get picture type
        Frames[FrameIndex].Stream.Read(DataByte, 1);
        CoverType := DataByte;

        //* Get description
        //* ASCII format ISO-8859-1
        case TextEncoding of
            0: begin
                Description := Pointer(NativeUInt(Frames[FrameIndex].Stream.Memory) + Frames[FrameIndex].Stream.Position);
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataByte, 1);
                    if DataByte <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := DataByte;
                        Inc(ByteCounter);
                    end;
                until (DataByte = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                DescriptionString := StringOf(Bytes);
            end;
            //* Unicode format UTF-16 with BOM
            1: begin
                Description := Pointer(NativeUInt(Frames[FrameIndex].Stream.Memory) + Frames[FrameIndex].Stream.Position + 2);
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        DescriptionString := DescriptionString + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                DescriptionString := Copy(DescriptionString, 2, Length(DescriptionString));
            end;
            //* Unicode format UTF-16BE without BOM
            2: begin
                Description := Pointer(NativeUInt(Frames[FrameIndex].Stream.Memory) + Frames[FrameIndex].Stream.Position);
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        DescriptionString := DescriptionString + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            //* Unicode format UTF-8
            3: begin
                Description := Pointer(NativeUInt(Frames[FrameIndex].Stream.Memory) + Frames[FrameIndex].Stream.Position);
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataByte, 1);
                    if DataByte <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := DataByte;
                        Inc(ByteCounter);
                    end;
                until (DataByte = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                DescriptionString := TEncoding.UTF8.GetString(Bytes);
            end;
        end;
        Data := Pointer(NativeUInt(Frames[FrameIndex].Stream.Memory) + Frames[FrameIndex].Stream.Position);
        DataSize := Frames[FrameIndex].Stream.Size - Frames[FrameIndex].Stream.Position;
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeCoverPictureFromStream(FrameID: String; Description: String; PictureStream: TStream; MIMEType: String; CoverType: Integer): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeCoverPictureFromStream(Index, Description, PictureStream, MIMEType, CoverType);
end;

function TID3v2Tag.SetUnicodeCoverPictureFromStream(FrameIndex: Integer; Description: String; PictureStream: TStream; MIMEType: String; CoverType: Integer): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        ///* Set data is unicode
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the MIME type
        Bytes := TEncoding.ANSI.GetBytes(MIMEType);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        ///* Set picture type
        Data := CoverType;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the description with BOM
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(PWideChar(Description)^, (Length(Description) + 1) * 2);
        //* Set picture data
        PictureStream.Seek(0, soBeginning);
        Frames[FrameIndex].Stream.CopyFrom(PictureStream, PictureStream.Size);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeCoverPictureFromFile(FrameID: String; Description: String; PictureFileName: String; MIMEType: String; CoverType: Integer): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeCoverPictureFromFile(Index, Description, PictureFileName, MIMEType, CoverType);
end;


function TID3v2Tag.SetUnicodeCoverPictureFromFile(FrameIndex: Integer; Description: String; PictureFileName: String; MIMEType: String; CoverType: Integer): Boolean;
var
    PictureStream: TFileStream;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        PictureStream := nil;
        try
            PictureStream := TFileStream.Create(PictureFileName, fmOpenRead);
            Result := SetUnicodeCoverPictureFromStream(FrameIndex, Description, PictureStream, MIMEType, CoverType);
        finally
            if Assigned(PictureStream) then begin
                FreeAndNil(PictureStream);
            end;
        end;
    except
        //*
    end;
end;

function Min(const B1, B2: Integer): Integer;
begin
    if B1 < B2 then begin
        Result := B1
    end else begin
        Result := B2;
    end;
end;

function Max(const B1, B2: Integer): Integer;
begin
    if B1 > B2 then begin
        Result := B1
    end else begin
        Result := B2;
    end;
end;

function ReverseBytes(Value: Cardinal): Cardinal;
begin
    Result := (Value SHR 24) OR (Value SHL 24) OR ((Value AND $00FF0000) SHR 8) OR ((Value AND $0000FF00) SHL 8);
end;

(*
asm
  {$IFDEF CPU32}
  // --> EAX Value
  // <-- EAX Value
  BSWAP  EAX
  {$ENDIF CPU32}
  {$IFDEF CPU64}
  // --> ECX Value
  // <-- EAX Value
  MOV    EAX, ECX
  BSWAP  EAX
  {$ENDIF CPU64}
end;
*)

function RemoveUnsynchronisationScheme(Source, Dest: TStream; BytesToRead: Integer): Boolean;
const
  MaxBufSize = $F000;
var
  LastWasFF: Boolean;
  BytesRead: Integer;
  SourcePtr, DestPtr: Integer;
  SourceBuf, DestBuf: array[0..MaxBufSize - 1] of Byte;
begin

  { Replace $FF 00 with $FF }

  LastWasFF := False;
  while BytesToRead > 0 do
  begin
    { Read at max CBufferSize bytes from the stream }
    BytesRead := Source.Read(SourceBuf[0], Min(MaxBufSize, BytesToRead));
    //if BytesRead = 0 then
    //  ID3Error(RsECouldNotReadData);

    Dec(BytesToRead, BytesRead);

    DestPtr := 0;
    SourcePtr := 0;

    while SourcePtr < BytesRead do
    begin
      { If previous was $FF and current is $00 then skip.. }
      if not LastWasFF or (SourceBuf[SourcePtr] <> $00) then
      begin
        { ..otherwise copy }
        DestBuf[DestPtr] := SourceBuf[SourcePtr];
        Inc(DestPtr);
      end;

      LastWasFF := SourceBuf[SourcePtr] = $FF;
      Inc(SourcePtr);
    end;
    Dest.Write(DestBuf[0], DestPtr);
  end;
    Result := True;
end;

function ApplyUnsynchronisationScheme(Source, Dest: TStream; BytesToRead: Integer): Boolean;
const
  MaxBufSize = $F000;
var
  LastWasFF: Boolean;
  BytesRead: Integer;
  SourcePtr, DestPtr: Integer;
  SourceBuf, DestBuf: PByte;
begin
  { Replace $FF 00         with  $FF 00 00
    Replace $FF %111xxxxx  with  $FF 00 %111xxxxx (%11100000 = $E0 = 224 }

  GetMem(SourceBuf, Min(MaxBufSize div 2, BytesToRead));
  GetMem(DestBuf, 2 * Min(MaxBufSize div 2, BytesToRead));
  try
    LastWasFF := False;
    while BytesToRead > 0 do
    begin
      { Read at max CBufferSize div 2 bytes from the stream }
      BytesRead := Source.Read(SourceBuf^, Min(MaxBufSize div 2, BytesToRead));
      //if BytesRead = 0 then
      //  ID3Error(RsECouldNotReadData);

      Dec(BytesToRead, BytesRead);

      DestPtr := 0;
      SourcePtr := 0;

      while SourcePtr < BytesRead do
      begin
        { If previous was $FF and current is $00 or >=$E0 then add space.. }
        if LastWasFF and
          ((SourceBuf[SourcePtr] = $00) or (Byte(SourceBuf[SourcePtr]) and $E0 > 0)) then
        begin
          DestBuf[DestPtr] := $00;
          Inc(DestPtr);
        end;

        { Copy }
        DestBuf[DestPtr] := SourceBuf[SourcePtr];
        Inc(DestPtr);

        LastWasFF := SourceBuf[SourcePtr] = $FF;
        Inc(SourcePtr);
      end;
      Dest.Write(DestBuf^, DestPtr);
    end;
  finally
    FreeMem(SourceBuf);
    FreeMem(DestBuf);
  end;
  Result := True;
end;

function TID3v2Tag.GetURL(FrameID: String): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetURL(Index);
end;

function TID3v2Tag.GetUnicodeUserDefinedURLLink(FrameID: String; var Description: String): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    Description := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeUserDefinedURLLink(Index, Description);
end;

function TID3v2Tag.FindUnicodeUserDefinedURLLinkByDescription(Description: String; var URL: String): Integer;
var
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetURL: String;
begin
    Result := - 1;
    ConvertString2FrameID('WXXX', FrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, FrameID) then begin
            GetURL := GetUnicodeUserDefinedURLLink(i, GetDescription);
            if GetDescription = Description then begin
                Result := i;
                URL := GetURL;
                Break;
            end;
        end;
    end;
end;

function TID3v2Tag.SetUnicodeUserDefinedURLLinkByDescription(Description: String; URL: String): Boolean;
var
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetURL: String;
    Index: Integer;
begin
    Index := - 1;
    ConvertString2FrameID('WXXX', FrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, FrameID) then begin
            GetURL := GetUnicodeUserDefinedURLLink(i, GetDescription);
            if GetDescription = Description then begin
                Index := i;
                Break;
            end;
        end;
    end;
    if Index = - 1 then begin
        Index := AddFrame(FrameID);
    end;
    Result := SetUnicodeUserDefinedURLLink(Index, URL, Description);
end;

function TID3v2Tag.GetUnicodeUserDefinedURLLink(FrameIndex: Integer; var Description: String): String;
var
    Data: Byte;
    UData: Word;
    EncodingFormat: Byte;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := '';
    Description := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get encoding format
        Frames[FrameIndex].Stream.Read(EncodingFormat, 1);
        //* Get decription and content
        case EncodingFormat of
            0: begin
                //* Get description
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        Description := Description + Char(Data);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            1: begin
                //* Get description
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        Description := Description + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := Copy(Description, 2, Length(Description));
            end;
            2: begin
                //* Get description
                Description := '';
                repeat
                    Frames[FrameIndex].Stream.Read(UData, 2);
                    if UData <> $0 then begin
                        Description := Description + Char(UData);
                    end;
                until (UData = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            3: begin
                //* Get description
                SetLength(Bytes, 0);
                ByteCounter  := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.UTF8.GetString(Bytes);
            end;
        end;
        //* Get the URL
        SetLength(Bytes, 0);
        ByteCounter  := 0;
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> $0 then begin
                SetLength(Bytes, Length(Bytes) + 1);
                Bytes[ByteCounter] := Data;
                Inc(ByteCounter);
            end;
        until (Data = 0)
        OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
        Result := StringOf(Bytes);
    except
        //*
    end;
end;

function TID3v2Tag.SetUserDefinedURLLink(FrameID: String; URL: String; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUserDefinedURLLink(Index, URL, Description);
end;

function TID3v2Tag.SetUserDefinedURLLink(FrameIndex: Integer; URL: String; Description: String): Boolean;
var
    Data: Byte;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        {$IFDEF NEXTGEN}
        for i := 0 to Length(Description) - 1 do begin
        {$ELSE}
        for i := 1 to Length(Description) do begin
        {$ENDIF}
            Data := Ord(Description[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the URL
        {$IFDEF NEXTGEN}
        for i := 0 to Length(URL) - 1 do begin
        {$ELSE}
        for i := 1 to Length(URL) do begin
        {$ENDIF}
            Data := Ord(URL[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUTF8UserDefinedURLLink(FrameID: String; URL: String; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUTF8UserDefinedURLLink(Index, URL, Description);
end;

function TID3v2Tag.SetUTF8UserDefinedURLLink(FrameIndex: Integer; URL: String; Description: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $03;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        Bytes := TEncoding.UTF8.GetBytes(Description);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the URL
        SetLength(Bytes, 0);
        Bytes := TEncoding.UTF8.GetBytes(URL);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeUserDefinedURLLink(FrameID: String; URL: String; Description: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeUserDefinedURLLink(Index, URL, Description);
end;

function TID3v2Tag.SetUnicodeUserDefinedURLLink(FrameIndex: Integer; URL: String; Description: String): Boolean;
var
    Data: Byte;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Write(PWideChar(Description)^, (Length(Description) + 1) * 2);
        //* Write the URL
        {$IFDEF NEXTGEN}
        for i := 0 to Length(URL) - 1 do begin
        {$ELSE}
        for i := 1 to Length(URL) do begin
        {$ENDIF}
            Data := Ord(URL[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetURL(FrameIndex: Integer): String;
var
    Data: Byte;
begin
    Result := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get the URL
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            Result := Result + Char(Data);
        until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
    except
        //*
    end;
end;

function TID3v2Tag.SetURL(FrameID: String; URL: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetURL(Index, URL);
end;

function TID3v2Tag.SetURL(FrameIndex: Integer; URL: String): Boolean;
var
    Data: Byte;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Write the URL
        {$IFDEF NEXTGEN}
        for i := 0 to Length(URL) - 1 do begin
        {$ELSE}
        for i := 1 to Length(URL) do begin
        {$ENDIF}
            Data := Ord(URL[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function ID3v2EncodeTime(DateTime: TDateTime): String;
var
    Year: Word;
    Month: Word;
    Day: Word;
    Hour: Word;
    Minute: Word;
    Second: Word;
    MSec: Word;
    StrYear: String;
    StrMonth: String;
    StrDay: String;
    StrHour: String;
    StrMinute: String;
    StrSecond: String;
begin
    DecodeTime(DateTime, Hour, Minute, Second, MSec);
    DecodeDate(DateTime, Year, Month, Day);
    StrYear := IntToStr(Year);
    if Length(StrYear) = 1 then begin
        StrYear := '0' + StrYear;
    end;
    StrMonth := IntToStr(Month);
    if Length(StrMonth) = 1 then begin
        StrMonth := '0' + StrMonth;
    end;
    StrDay := IntToStr(Day);
    if Length(StrDay) = 1 then begin
        StrDay := '0' + StrDay;
    end;
    StrHour := IntToStr(Hour);
    if Length(StrHour) = 1 then begin
        StrHour := '0' + StrHour;
    end;
    StrMinute := IntToStr(Minute);
    if Length(StrMinute) = 1 then begin
        StrMinute := '0' + StrMinute;
    end;
    StrSecond := IntToStr(Second);
    if Length(StrSecond) = 1 then begin
        StrSecond := '0' + StrSecond;
    end;
    //* yyyy-MM-ddTHH:mm:ss
    Result := StrYear + '-' + StrMonth + '-' + StrDay + 'T' + StrHour + ':' + StrMinute + ':' + StrSecond;
end;

function ID3v2DecodeTime(ID3v2DateTime: String): TDateTime;
var
    Year: Word;
    Month: Word;
    Day: Word;
    Hour: Word;
    Minute: Word;
    Second: Word;
    MSec: Word;
    StrYear: String;
    StrMonth: String;
    StrDay: String;
    StrHour: String;
    StrMinute: String;
    StrSecond: String;
    Date: TDateTime;
    Time: TDateTime;
begin
    //* yyyy-MM-ddTHH:mm:ss
    StrYear := Copy(ID3v2DateTime, 1, 4);
    StrMonth := Copy(ID3v2DateTime, 6, 2);
    StrDay := Copy(ID3v2DateTime, 9, 2);
    StrHour := Copy(ID3v2DateTime, 12, 2);
    StrMinute := Copy(ID3v2DateTime, 15, 2);
    StrSecond := Copy(ID3v2DateTime, 18, 2);
    Year := StrToIntDef(StrYear, 0);
    Month := StrToIntDef(StrMonth, 0);
    Day := StrToIntDef(StrDay, 0);
    Hour := StrToIntDef(StrHour, 0);
    Minute := StrToIntDef(StrMinute, 0);
    Second := StrToIntDef(StrSecond, 0);
    MSec := 0;
    if Year = 0 then begin
        Year := 2000;
    end;
    if Month = 0 then begin
        Month := 1;
    end;
    if Day = 0 then begin
        Day := 1;
    end;
    Time := EncodeTime(Hour, Minute, Second, MSec);
    Date := EncodeDate(Year, Month, Day);
    Result := Date + Time;
end;

function ID3v2DecodeTimeToNumbers(ID3v2DateTime: String; var Year, Month, Day, Hour, Minute, Second: Integer): Boolean;
var
    StrYear: String;
    StrMonth: String;
    StrDay: String;
    StrHour: String;
    StrMinute: String;
    StrSecond: String;
begin
    //* yyyy-MM-ddTHH:mm:ss
    StrYear := Copy(ID3v2DateTime, 1, 4);
    StrMonth := Copy(ID3v2DateTime, 6, 2);
    StrDay := Copy(ID3v2DateTime, 9, 2);
    StrHour := Copy(ID3v2DateTime, 12, 2);
    StrMinute := Copy(ID3v2DateTime, 15, 2);
    StrSecond := Copy(ID3v2DateTime, 18, 2);
    Year := StrToIntDef(StrYear, 0);
    Month := StrToIntDef(StrMonth, 0);
    Day := StrToIntDef(StrDay, 0);
    Hour := StrToIntDef(StrHour, - 1);
    Minute := StrToIntDef(StrMinute, - 1);
    Second := StrToIntDef(StrSecond, - 1);
    Result := True;
end;

function TID3v2Tag.GetTime(FrameID: String): TDateTime;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := 0;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetTime(Index);
end;

function TID3v2Tag.GetTime(FrameIndex: Integer): TDateTime;
var
    TDRCDateTime: String;
    TDRCValueUnicode: PWideChar;
    Data: Byte;
    ReadAmount: Integer;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //ReadAmount := Frames[FrameIndex].Stream.Size;

        Frames[FrameIndex].Stream.Read(Data, 1);

        case Data of
            0: begin
                Frames[FrameIndex].Stream.Seek(1, soBeginning);
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    TDRCDateTime := TDRCDateTime + Char(Data);
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
            end;
            1: begin
                Frames[FrameIndex].Stream.Seek(3, soBeginning);
                ReadAmount := Frames[FrameIndex].Stream.Size - 3;
                TDRCValueUnicode := AllocMem(ReadAmount);
                Frames[FrameIndex].Stream.Read(TDRCValueUnicode^, ReadAmount);
                TDRCDateTime := TDRCValueUnicode;
                FreeMem(TDRCValueUnicode);
            end;
            2: begin
                Frames[FrameIndex].Stream.Seek(1, soBeginning);
                ReadAmount := Frames[FrameIndex].Stream.Size - 1;
                TDRCValueUnicode := AllocMem(ReadAmount);
                Frames[FrameIndex].Stream.Read(TDRCValueUnicode^, ReadAmount);
                TDRCDateTime := TDRCValueUnicode;
                FreeMem(TDRCValueUnicode);
            end;
            3: begin
                Frames[FrameIndex].Stream.Seek(1, soBeginning);
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    SetLength(Bytes, Length(Bytes) + 1);
                    Bytes[ByteCounter] := Data;
                    Inc(ByteCounter);
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                TDRCDateTime := TEncoding.UTF8.GetString(Bytes);
            end;
            else begin
                Frames[FrameIndex].Stream.Seek(0, soBeginning);
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    TDRCDateTime := TDRCDateTime + Char(Data);
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
            end;
        end;
        Result := ID3v2DecodeTime(TDRCDateTime);
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
    except
        //*
    end;
end;

function TID3v2Tag.SetTime(FrameID: String; DateTime: TDateTime): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetTime(Index, DateTime);
end;

function TID3v2Tag.SetTime(FrameIndex: Integer; DateTime: TDateTime): Boolean;
var
    TDRCDateTime: String;
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        TDRCDateTime := ID3v2EncodeTime(DateTime);
        Bytes := TEncoding.ANSI.GetBytes(TDRCDateTime);
        Data := 0;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the date time
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := 0;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.CalculateTagSize(PaddingSize: Integer): Integer;
var
    TotalTagSize: Integer;
    i: Integer;
begin
    //* TODO: Ext header size
    TotalTagSize := 10{ + ExtendedHeaderSize3};
    if MajorVersion = 3 then begin
        for i := 0 to FrameCount - 1 do begin
            if (Frames[i].Stream.Size = 0)
            OR (NOT ValidID3v2FrameID(Frames[i].ID))
            then begin
                Continue;
            end;
            TotalTagSize := TotalTagSize + Frames[i].Stream.Size + 10;
            if Frames[i].DataLengthIndicator
            OR Frames[i].Compressed
            then begin
                TotalTagSize := TotalTagSize + 4;
            end;
        end;
    end;
    if MajorVersion > 3 then begin
        for i := 0 to FrameCount - 1 do begin
            if (Frames[i].Stream.Size = 0)
            OR (NOT ValidID3v2FrameID(Frames[i].ID))
            then begin
                Continue;
            end;
            TotalTagSize := TotalTagSize + 10;
            TotalTagSize := TotalTagSize + Frames[i].Stream.Size;
            if Frames[i].GroupingIdentity then begin
                TotalTagSize := TotalTagSize + 1;
            end;
            if Frames[i].Encrypted then begin
                TotalTagSize := TotalTagSize + 1;
            end;
            if Frames[i].DataLengthIndicator then begin
                TotalTagSize := TotalTagSize + 4;
            end;
        end;
    end;
    TotalTagSize := TotalTagSize + PaddingSize;
    Result := TotalTagSize;
end;

function TID3v2Tag.CalculateTotalFramesSize: Integer;
var
    TotalFramesSize: Integer;
    i: Integer;
begin
    TotalFramesSize := 0;
    for i := 0 to FrameCount - 1 do begin
        if ValidID3v2FrameID(Frames[i].ID) then begin
            TotalFramesSize := TotalFramesSize + Frames[i].Stream.Size;
        end;
    end;
    Result := TotalFramesSize;
end;

function TID3v2Tag.CheckMPEG(MPEGStream: TStream): Boolean;
Const
    MPEG_SEARCH_LENGTH = 32; //* Increasing this value helps for corrupted ID3v2 tags, but increses false MPEG sync detection
var
    i: Integer;
    Data: Byte;
begin
    Result := False;
    i := 0;
    Data := 0;
    repeat
        MPEGStream.Read(Data, 1);
        if Data = $FF then begin
            MPEGStream.Read(Data, 1);
            if (Data = $F9)
            OR (Data = $FA)
            OR (Data = $FB)
            OR (Data = $FC)
            OR (Data = $FD)
            OR (Data = $F2)
            OR (Data = $F3)
            OR (Data = $E3)
            then begin
                MPEGStream.Seek(- 2, soCurrent);
                Result := True;
                Exit;
            end;
        end;
        Inc(i);
    until i > MPEG_SEARCH_LENGTH;
end;

function TID3v2Tag.FullFrameSize(FrameIndex: Cardinal): Cardinal;
begin
    Result := 0;
    if MajorVersion = 2 then begin
        Result := Frames[FrameIndex].Stream.Size;
    end;
    if MajorVersion = 3 then begin
        Result := Frames[FrameIndex].Stream.Size;
        if Frames[FrameIndex].Compressed
        OR Frames[FrameIndex].DataLengthIndicator
        then begin
            Result := Result + 4;
        end;
        if Frames[FrameIndex].Encrypted then begin
            Result := Result + 1;
        end;
        if Frames[FrameIndex].GroupingIdentity then begin
            Result := Result + 1;
        end;
    end;
    if MajorVersion > 3 then begin
        Result := Frames[FrameIndex].Stream.Size;
        if Frames[FrameIndex].GroupingIdentity then begin
            Result := Result + 1;
        end;
        if Frames[FrameIndex].Encrypted then begin
            Result := Result + 1;
        end;
        if Frames[FrameIndex].DataLengthIndicator then begin
            Result := Result + 4;
        end;
    end;
end;

procedure TID3v2Tag.Clear;
begin
    Self.DeleteAllFrames;
    FileName := '';
    Loaded := False;
    MajorVersion := 3;
    MinorVersion := 0;
    Flags := 0;
    Unsynchronised := False;
    Compressed := False;
    ExtendedHeader := False;
    Experimental := False;
    Size := 0;
    CodedSize := 0;
    PaddingSize := 0;
    PaddingToWrite := ID3V2LIBRARY_DEFAULT_PADDING_SIZE;
    FPosition := 0;
    if Assigned(ExtendedHeader3) then begin
        FreeAndNil(ExtendedHeader3);
    end;
    ExtendedHeader3 := TID3v2ExtendedHeader3.Create;
    if Assigned(ExtendedHeader4) then begin
        FreeAndNil(ExtendedHeader4);
    end;
    ExtendedHeader4 := TID3v2ExtendedHeader4.Create;
    MPEGInfo.Position := 0;
    MPEGInfo.Header := 0;
    MPEGInfo.FrameSize := 0;
    MPEGInfo.Version := tmpegvUnknown;
    MPEGInfo.Layer := tmpeglUnknown;
    MPEGInfo.CRC := False;
    MPEGInfo.BitRate := 0;
    MPEGInfo.SampleRate := 0;
    MPEGInfo.Padding := False;
    MPEGInfo._Private := False;
    MPEGInfo.ChannelMode := tmpegcmUnknown;
    MPEGInfo.ModeExtension := tmpegmeUnknown;
    MPEGInfo.Copyrighted := False;
    MPEGInfo.Original := False;
    MPEGInfo.Emphasis := tmpegeUnknown;
    MPEGInfo.VBR := False;
    MPEGInfo.FrameCount := 0;
    MPEGInfo.Quality := 0;
    MPEGInfo.Bytes := 0;
    FillChar(Self.WAVInfo, SizeOf(TWaveFmt), 0);
    DSFInfo.Clear;
    AIFFInfo.Channels := 0;
    AIFFInfo.SampleFrames := 0;
    AIFFInfo.SampleSize := 0;
    AIFFInfo.SampleRate := 0;
    AIFFInfo.CompressionID := '';
    AIFFInfo.Compression := '';
    FSourceFileType := sftUnknown;
    FPlayTime := 0;
    SampleCount := 0;
    BitRate := 0;
    FStrangeTag := False;
end;

function TID3v2Tag.WriteAllFrames(var TagStream: TStream): Integer;
var
    i: Integer;
    UnCodedSize: Cardinal;
    ReversedFlags: Word;
begin
    try
        for i := 0 to FrameCount - 1 do begin
            if (NOT ValidID3v2FrameID(Frames[i].ID))
            OR (Frames[i].Stream.Size = 0)
            then begin
                Continue;
            end;
            TagStream.Write(Frames[i].ID, 4);
            UnCodedSize := FullFrameSize(i);
            if MajorVersion = 3 then begin
                CodedSize := ReverseBytes(UnCodedSize);
                TagStream.Write(CodedSize, 4);
                Frames[i].EncodeFlags3;
                TagStream.Write(Frames[i].Flags, 2);
                if Frames[i].Compressed
                OR Frames[i].DataLengthIndicator
                then begin
                    TagStream.Write(Frames[i].DataLengthIndicatorValue, 4);
                end;
                if Frames[i].Encrypted then begin
                    TagStream.Write(Frames[i].EncryptionMethod, 1);
                end;
                if Frames[i].GroupingIdentity then begin
                    TagStream.Write(Frames[i].GroupIdentifier, 1);
                end;
            end;
            if MajorVersion = 4 then begin
                UnCodedSize := FullFrameSize(i);
                SyncSafe(UnCodedSize, CodedSize, 4);
                TagStream.Write(CodedSize, 4);
                Frames[i].EncodeFlags4;
                ReversedFlags := Swap16(Frames[i].Flags);
                TagStream.Write(ReversedFlags, 2);
                if Frames[i].GroupingIdentity then begin
                    TagStream.Write(Frames[i].GroupIdentifier, 1);
                end;
                if Frames[i].Encrypted then begin
                    TagStream.Write(Frames[i].EncryptionMethod, 1);
                end;
                if Frames[i].DataLengthIndicator then begin
                    TagStream.Write(Frames[i].DataLengthIndicatorValue, 4);
                end;
            end;
            TagStream.CopyFrom(Frames[i].Stream, 0);
        end;
        Result := ID3V2LIBRARY_SUCCESS;
    except
        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
    end;
end;

function TID3v2Tag.WriteAllHeaders(var TagStream: TStream): Integer;
begin
    try
        TagStream.Write(ID3v2ID, 3);
        TagStream.Write(MajorVersion, 1);
        TagStream.Write(MinorVersion, 1);
        if MajorVersion = 3 then begin
            TagStream.Write(Flags, 1);
            TagStream.Write(CodedSize, 4);
        end;
        if MajorVersion = 4 then begin
            TagStream.Write(Flags, 1);
            TagStream.Write(CodedSize, 4);
        end;
        if ExtendedHeader then begin
            //* TODO
            if MajorVersion = 3 then begin

            end;
            if MajorVersion >= 4 then begin

            end;
        end;
        Result := ID3V2LIBRARY_SUCCESS;
    except
        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
    end;
end;

function WritePadding(var TagStream: TStream; PaddingSize: Integer): Integer;
var
    Data: TBytes;
begin
    try
        SetLength(Data, PaddingSize);
        TagStream.Write(Data[0], Length(Data));
        Result := ID3V2LIBRARY_SUCCESS;
    except
        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
    end;
end;

function LanguageIDtoString(LanguageId : TLanguageID): String;
var
    i: integer;
begin
    Result := '';
    for i := low(TLanguageID) to high(TLanguageID) do begin
        if LanguageId[i] <> 0 then begin
            Result := Result + Char(LanguageId[i]);
        end;
    end;
end;

procedure TID3v2Tag.EncodeSize;
var
    UnCodedSize: Cardinal;
begin
    UnCodedSize := CalculateTagSize(PaddingSize) - 10;
    SyncSafe(UnCodedSize, CodedSize, 4);
end;

{
function TID3v2Tag.RemoveUnsynchronisationOnExtendedHeaderSize: Boolean;
begin
    //Result := RemoveUnsynchronisationOnStream(ExtendedHeader3.SizeData);
    Result := False;
end;

function TID3v2Tag.ApplyUnsynchronisationOnExtendedHeaderSize: Boolean;
begin
    //Result := ApplyUnsynchronisationOnStream(ExtendedHeader3.SizeData);
    Result := False;
end;
}

function TID3v2Tag.RemoveUnsynchronisationOnExtendedHeaderData: Boolean;
begin
    Result := RemoveUnsynchronisationOnStream(ExtendedHeader3.Data);
end;
{
function TID3v2Tag.ApplyUnsynchronisationOnExtendedHeaderData: Boolean;
begin
    Result := ApplyUnsynchronisationOnStream(ExtendedHeader3.Data);
end;
}
function RemoveUnsynchronisationOnStream(Stream: TMemoryStream): Boolean;
var
    UnUnsyncronisedStream: TMemoryStream;
    Success: Boolean;
begin
    Result := False;
    UnUnsyncronisedStream := nil;
    try
        UnUnsyncronisedStream := TMemoryStream.Create;
        Stream.Seek(0, soBeginning);
        Success := RemoveUnsynchronisationScheme(Stream, UnUnsyncronisedStream, Stream.Size);
        if Success then begin
            Stream.Clear;
            UnUnsyncronisedStream.Seek(0, soBeginning);
            Stream.CopyFrom(UnUnsyncronisedStream, 0);
            Result := True;
        end;
    finally
        if Assigned(UnUnsyncronisedStream) then begin
            FreeAndNil(UnUnsyncronisedStream);
        end;
    end;
end;

function ApplyUnsynchronisationOnStream(Stream: TMemoryStream): Boolean;
var
    UnsyncronisedStream: TMemoryStream;
    Success: Boolean;
begin
    Result := False;
    UnsyncronisedStream := nil;
    try
        UnsyncronisedStream := TMemoryStream.Create;
        Stream.Seek(0, soBeginning);
        Success := ApplyUnsynchronisationScheme(Stream, UnsyncronisedStream, Stream.Size);
        if Success then begin
            Stream.Clear;
            UnsyncronisedStream.Seek(0, soBeginning);
            Stream.CopyFrom(UnsyncronisedStream, 0);
            Result := True;
        end;
    finally
        if Assigned(UnsyncronisedStream) then begin
            FreeAndNil(UnsyncronisedStream);
        end;
    end;
end;
                   // CPUX64
function TID3v2Tag.GetSEBR(FrameID: String): {$IFDEF CPUX64}Double{$ELSE}Extended{$ENDIF};
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := 0;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetSEBR(Index);
end;

function TID3v2Tag.GetSEBR(FrameIndex: Integer): {$IFDEF CPUX64}Double{$ELSE}Extended{$ENDIF};
var
    {$IFNDEF CPUX64}
    SEBR: Extended;
    {$ENDIF}
    SEBRStr: String;
begin
    Result := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    {$IFDEF CPUX64}
    SEBRStr := GetSEBRString(FrameIndex);
    if Copy(SEBRStr, 1, 1) = '~' then begin
        Result := StrToFloatDef(Copy(SEBRStr, 2, Length(SEBRStr)), 0);
    end;
    {$ELSE}
    if Frames[FrameIndex].Stream.Size = 0 then begin
        Exit;
    end;
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
    try
        SEBR := 0;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Frames[FrameIndex].Stream.Read(SEBR, 10);
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Result := SEBR;
    except
        //*
    end;
    if SEBR = 0 then begin
        SEBRStr := GetSEBRString(FrameIndex);
        if Copy(SEBRStr, 1, 1) = '~' then begin
            Result := StrToFloatDef(Copy(SEBRStr, 2, Length(SEBRStr)), 0);
        end;
    end;
    {$ENDIF}
end;

function TID3v2Tag.GetSEBRString(FrameIndex: Integer): String;
var
    SEBR: String;
    Data: Byte;
begin
    Result := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    if Frames[FrameIndex].Stream.Size = 0 then begin
        Exit;
    end;
    Frames[FrameIndex].Stream.Seek(10, soBeginning);
    try
        SEBR := '';
        Data := 0;
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> 0 then begin
                SEBR := SEBR + Char(Data);
            end;
        until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Result := SEBR;
    except
        //*
    end;
end;

function TID3v2Tag.SetSEBR(FrameID: String; BitRate: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetSEBR(Index, BitRate);
end;

function TID3v2Tag.SetSEBR(FrameIndex: Integer; BitRate: String): Boolean;
var
    Data: Byte;
    i: Integer;
    {$IFNDEF CPUX64}
    SEBR: Extended;
    {$ENDIF}
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    Frames[FrameIndex].Stream.Clear;
    try
        {$IFDEF CPUX64}
        Data := 0;
        for i := 0 to 9 do begin
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        {$ELSE}
        if Copy(BitRate, 1, 1) = '~' then begin
            SEBR := StrToFloatDef(Copy(BitRate, 2, Length(BitRate)), 0);
        end;
        Frames[FrameIndex].Stream.Write(SEBR, 10);
        {$ENDIF}
        for i := 1 to Length(BitRate) - 1 do begin
            Data := Ord(BitRate[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Result := True;
    except
        //*
    end;
end;

{$IFNDEF CPUX64}

function TID3v2Tag.SetSEBR(FrameID: String; BitRate: Extended): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetSEBR(Index, BitRate);
end;

function TID3v2Tag.SetSEBR(FrameIndex: Integer; BitRate: Extended): Boolean;
var
    StrSEBR: String;
    i: Integer;
    Data: Byte;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    Frames[FrameIndex].Stream.Clear;
    try
        Frames[FrameIndex].Stream.Write(BitRate, 10);
        StrSEBR := FloatToStr(BitRate);
        {$IFDEF NEXTGEN}
        for i := 0 to Length(StrSEBR) - 1 do begin
        {$ELSE}
        for i := 1 to Length(StrSEBR) do begin
        {$ENDIF}
            Data := Ord(StrSEBR[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Result := True;
    except
        //*
    end;
end;

{$ENDIF}

function TID3v2Tag.GetSampleCache(FrameIndex: Integer; ForceDecompression: Boolean; var Version: Byte; var Channels: Integer): TID3v2SampleCache;
var
    ID: Integer;
    SESCHeaderSize: Cardinal;
    ReportedChannels: Integer;
    DataVersion: Byte;
    SeekPosition: Integer;
begin
    SetLength(Result, 0);
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    if Frames[FrameIndex].Stream.Size = 0 then begin
        Exit;
    end;
    Version := 1;
    Channels := 2;
    if Frames[FrameIndex].Unsynchronised then begin
        Frames[FrameIndex].RemoveUnsynchronisation;
    end;
    if Frames[FrameIndex].Compressed
    OR ForceDecompression
    then begin
        Frames[FrameIndex].DeCompress;
    end;
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
    try
        Frames[FrameIndex].Stream.Read(ID, 4);
        if ID = ID3V2LIBRARY_SESC_ID then begin
            Frames[FrameIndex].Stream.Read(DataVersion, 1);
            Frames[FrameIndex].Stream.Read(SESCHeaderSize, 4);
            Version := DataVersion;
            if DataVersion = ID3V2LIBRARY_SESC_VERSION2 then begin
                if SESCHeaderSize >= 4 then begin
                    Frames[FrameIndex].Stream.Read(ReportedChannels, 4);
                    SeekPosition := SESCHeaderSize - 4;
                    Frames[FrameIndex].Stream.Seek(SeekPosition, soCurrent);
                end;
            end;
        end else begin
            Frames[FrameIndex].Stream.Seek(-4, soCurrent);
        end;
        SetLength(Result, Frames[FrameIndex].Stream.Size - Frames[FrameIndex].Stream.Position);
        Frames[FrameIndex].Stream.Read(Pointer(Result)^, Frames[FrameIndex].Stream.Size - Frames[FrameIndex].Stream.Position);
    except
        //*
    end;
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
end;

function TID3v2Tag.SetSampleCache(FrameIndex: Integer; SESC: TID3v2SampleCache; Channels: Integer): Boolean;
var
    SESCHeaderSize: Cardinal;
    SESCID: Integer;
    DataVersion: Byte;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        SESCID := ID3V2LIBRARY_SESC_ID;
        Frames[FrameIndex].Stream.Write(SESCID, 4);
        DataVersion := ID3V2LIBRARY_SESC_VERSION2;
        Frames[FrameIndex].Stream.Write(DataVersion, 1);
        SESCHeaderSize := 4;
        Frames[FrameIndex].Stream.Write(SESCHeaderSize, 4);
        Frames[FrameIndex].Stream.Write(Channels, 4);
        Frames[FrameIndex].Stream.Write(Pointer(SESC)^, Length(SESC));
        Frames[FrameIndex].Compress;
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetSEFC(FrameIndex: Integer): Int64;
var
    SEFC: String;
    Data: Byte;
begin
    Result := -1;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    if Frames[FrameIndex].Stream.Size = 0 then begin
        Exit;
    end;
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
    try
        Frames[FrameIndex].Stream.Read(Data, 1);
        if Data = $01 then begin
            repeat
                Frames[FrameIndex].Stream.Read(Data, 1);
                SEFC := SEFC + Char(Data);
            until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
            Result := StrToIntDef(SEFC, 0);
        end;
    except
        //*
    end;
    Frames[FrameIndex].Stream.Seek(0, soBeginning);
end;

function TID3v2Tag.SetSEFC(FrameIndex: Integer; SEFC: Int64): Boolean;
var
    StrSEFC: String;
    Data: Byte;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        StrSEFC := IntToStr(SEFC);
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        {$IFDEF NEXTGEN}
        for i := 0 to Length(StrSEFC) - 1 do begin
        {$ELSE}
        for i := 1 to Length(StrSEFC) do begin
        {$ENDIF}
            Data := Ord(StrSEFC[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Result := True;
    except
        //*
    end;
end;

procedure AnsiStringToPAnsiChar(const Source: String; var Dest: TFrameID);
var
    SourceLength: Integer;
begin
    SourceLength := Length(Source);
    {$IFDEF NEXTGEN}
    if SourceLength > 0 then begin
        Dest[0] := Ord(Source[0]);
    end else begin
        Dest[0] := 20;
    end;
    if SourceLength > 1 then begin
        Dest[1] := Ord(Source[1]);
    end else begin
        Dest[1] := 20;
    end;
    if SourceLength > 2 then begin
        Dest[2] := Ord(Source[2]);
    end else begin
        Dest[2] := 20;
    end;
    if SourceLength > 3 then begin
        Dest[3] := Ord(Source[3]);
    end else begin
        Dest[3] := 20;
    end;
    {$ELSE}
    if SourceLength > 0 then begin
        Dest[0] := Ord(Source[1]);
    end else begin
        Dest[0] := 20;
    end;
    if SourceLength > 1 then begin
        Dest[1] := Ord(Source[2]);
    end else begin
        Dest[1] := 20;
    end;
    if SourceLength > 2 then begin
        Dest[2] := Ord(Source[3]);
    end else begin
        Dest[2] := 20;
    end;
    if SourceLength > 3 then begin
        Dest[3] := Ord(Source[4]);
    end else begin
        Dest[3] := 20;
    end;
    {$ENDIF}
end;

procedure StringToLanguageID(const Source: String; var Dest: TLanguageID);
begin
    Dest[0] := $20;
    Dest[1] := $20;
    Dest[2] := $20;
    {$IFDEF NEXTGEN}
    if Length(Source) > 0 then begin
        Dest[0] := Byte(Source[0]);
    end;
    if Length(Source) > 1 then begin
        Dest[1] := Byte(Source[1]);
    end;
    if Length(Source) > 2 then begin
        Dest[2] := Byte(Source[2]);
    end;
    {$ELSE}
    if Length(Source) > 0 then begin
        Dest[0] := Byte(Source[1]);
    end;
    if Length(Source) > 1 then begin
        Dest[1] := Byte(Source[2]);
    end;
    if Length(Source) > 2 then begin
        Dest[2] := Byte(Source[3]);
    end;
    {$ENDIF}
end;

function TID3v2Tag.SetAlbumColors(FrameIndex: Integer; TitleColor, TextColor: Cardinal): Boolean;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        Frames[FrameIndex].Stream.Write(TitleColor, 4);
        Frames[FrameIndex].Stream.Write(TextColor, 4);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetAlbumColors(FrameID: String; TitleColor, TextColor: Cardinal): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetAlbumColors(Index, TitleColor, TextColor);
end;

function TID3v2Tag.GetAlbumColors(FrameID: String; var TitleColor, TextColor: Cardinal): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := GetAlbumColors(Index, TitleColor, TextColor);
end;

function TID3v2Tag.GetAlbumColors(FrameIndex: Integer; var TitleColor, TextColor: Cardinal): Boolean;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    if Frames[FrameIndex].Stream.Size = 0 then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Frames[FrameIndex].Stream.Read(TitleColor, 4);
        Frames[FrameIndex].Stream.Read(TextColor, 4);
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetTLEN(FrameID: String; TLEN: Integer): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetTLEN(Index, TLEN);
end;

function TID3v2Tag.SetTLEN(FrameIndex: Integer; TLEN: Integer): Boolean;
var
    TLENString: String;
    i: Integer;
    Data: Byte;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        Data := 0;
        Frames[FrameIndex].Stream.Write(Data, 1);
        TLENString := IntToStr(TLEN);
        {$IFDEF NEXTGEN}
        for i := 0 to Length(TLENString) - 1 do begin
        {$ELSE}
        for i := 1 to Length(TLENString) do begin
        {$ENDIF}
            Data := Ord(TLENString[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetPlayCount(FrameID: String): Cardinal;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := 0;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := GetPlayCount(Index);
end;

function TID3v2Tag.GetPlayTime: Double;
var
    TLEN: String;
    ID3v1Tag: TID3v1Tag;
    ID3v1Size: Integer;
begin
    if FPlayTime = 0 then begin
        //* First check if there's a 'TLEN' frame
        TLEN := GetUnicodeText('TLEN');
        if TLEN <> '' then begin
            FPlayTime := StrToIntDef(TLEN, 0) / 1000;
        end else begin
            if SourceFileType = sftMPEG then begin
                if MPEGInfo.VBR then begin
                    //* Guess for VBR (if we have 'FrameCount')
                    FPlayTime := MPEGInfo.FrameCount * 0.026;
                end else begin
                    //* Only valid for CBR
                    ID3v1Size := 0;
                    ID3v1Tag := TID3v1Tag.Create;
                    try
                        ID3v1Tag.LoadFromFile(Self.FileName);
                        if ID3v1Tag.Loaded then begin
                            ID3v1Size := 128 + ID3v1Tag.LyricsSize;
                        end;
                    finally
                        FreeAndNil(ID3v1Tag);
                    end;
                    FPlayTime := ((NGetFileSize(Self.FileName) - Self.Size - ID3v1Size) / Self.Bitrate * 8) / 1000;
                end;
            end;
        end;
    end;
    Result := FPlayTime;
end;

function TID3v2Tag.GetPlayCount(FrameIndex: Integer): Cardinal;
var
    Data: Byte;
    i: Integer;
    Value: Cardinal;
begin
    Result := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    if Frames[FrameIndex].Stream.Size = 0 then begin
        Exit;
    end;
    try
        Value := 0;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        for i := 0 to Frames[FrameIndex].Stream.Size - 1 do begin
            Value := Value SHL 8;
            Frames[FrameIndex].Stream.Read(Data, 1);
            Value := Value + Data;
        end;
        Result := Value;
    except
        //*
    end;
end;

function TID3v2Tag.SetPlayCount(FrameID: String; PlayCount: Cardinal): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetPlayCount(Index, PlayCount);
end;

function TID3v2Tag.SetPlayCount(FrameIndex: Integer; PlayCount: Cardinal): Boolean;
var
    Data: Byte;
    Value: Cardinal;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        Value := PlayCount SHR 24;
        Data := Value;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Value := PlayCount SHL 8;
        Value := Value SHR 24;
        Data := Value;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Value := PlayCount SHL 16;
        Value := Value SHR 24;
        Data := Value;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Value := PlayCount SHL 24;
        Value := Value SHR 24;
        Data := Value;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Result := True;
    except
        //*
    end;
end;

function Swap16(ASmallInt: SmallInt): SmallInt; register;
    {
asm
    xchg al,ah
    }
begin
    Result := Swap(ASmallInt);
end;

function TID3v2Tag.RemoveUnsynchronisationOnAllFrames: Boolean;
var
    i: Integer;
begin
    Result := False;
    try
        if MajorVersion = 3 then begin
            if Unsynchronised then begin
                for i := 0 to FrameCount - 1 do begin
                    Frames[i].RemoveUnsynchronisation;
                end;
                Unsynchronised := False;
            end;
        end;
        if MajorVersion = 4 then begin
            for i := 0 to FrameCount - 1 do begin
                if Frames[i].Unsynchronised then begin
                    Frames[i].RemoveUnsynchronisation;
                end;
            end;
            Unsynchronised := False;
        end;
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.ApplyUnsynchronisationOnAllFrames: Boolean;
var
    i: Integer;
begin
    Result := False;
    try
        if MajorVersion = 3 then begin
            for i := 0 to FrameCount - 1 do begin
                Frames[i].ApplyUnsynchronisation;
            end;
            Unsynchronised := True;
        end;
        if MajorVersion = 4 then begin
            for i := 0 to FrameCount - 1 do begin
                if NOT Frames[i].Unsynchronised then begin
                    Frames[i].ApplyUnsynchronisation;
                end;
            end;
            Unsynchronised := True;
        end;
        Result := True;
    except
        //*
    end;
end;

function APICType2Str(PictureType: Integer): String;
begin
    Result := 'Other';
    if PictureType = $00 then begin
        Result := 'Other';
        Exit;
    end;
    if PictureType = $01 then begin
        Result := '32x32 pixels ''file icon'' (PNG only)';
        Exit;
    end;
    if PictureType = $02 then begin
        Result := 'Other file icon';
        Exit;
    end;
    if PictureType = $03 then begin
        Result := 'Cover (front)';
        Exit;
    end;
    if PictureType = $04 then begin
        Result := 'Cover (back)';
        Exit;
    end;
    if PictureType = $05 then begin
        Result := 'Leaflet page';
        Exit;
    end;
    if PictureType = $06 then begin
        Result := 'Media (e.g. label side of CD)';
        Exit;
    end;
    if PictureType = $07 then begin
        Result := 'Lead artist/lead performer/soloist';
        Exit;
    end;
    if PictureType = $08 then begin
        Result := 'Artist/performer';
        Exit;
    end;
    if PictureType = $09 then begin
        Result := 'Conductor';
        Exit;
    end;
    if PictureType = $0A then begin
        Result := 'Band/Orchestra';
        Exit;
    end;
    if PictureType = $0B then begin
        Result := 'Composer';
    end;
    if PictureType = $0C then begin
        Result := 'Lyricist/text writer';
        Exit;
    end;
    if PictureType = $0D then begin
        Result := 'Recording Location';
        Exit;
    end;
    if PictureType = $0E then begin
        Result := 'During recording';
        Exit;
    end;
    if PictureType = $0F then begin
        Result := 'During performance';
        Exit;
    end;
    if PictureType = $10 then begin
        Result := 'Movie/video screen capture';
        Exit;
    end;
    if PictureType = $11 then begin
        Result := 'A bright coloured fish';
        Exit;
    end;
    if PictureType = $12 then begin
        Result := 'Illustration';
        Exit;
    end;
    if PictureType = $13 then begin
        Result := 'Band/artist logotype';
        Exit;
    end;
    if PictureType = $14 then begin
        Result := 'Publisher/Studio logotype';
        Exit;
    end;
end;

function APICTypeStr2No(PictureType: String): Integer;
begin
    Result := $00;
    if PictureType = 'Other' then begin
        Result := $00;
        Exit;
    end;
    if PictureType = '32x32 pixels ''file icon'' (PNG only)' then begin
        Result := $01;
        Exit;
    end;
    if PictureType = 'Other file icon' then begin
        Result := $02;
        Exit;
    end;
    if PictureType = 'Cover (front)' then begin
        Result := $03;
        Exit;
    end;
    if PictureType = 'Cover (back)' then begin
        Result := $04;
        Exit;
    end;
    if PictureType = 'Leaflet page' then begin
        Result := $05;
        Exit;
    end;
    if PictureType = 'Media (e.g. label side of CD)' then begin
        Result := $06;
        Exit;
    end;
    if PictureType = 'Lead artist/lead performer/soloist' then begin
        Result := $07;
        Exit;
    end;
    if PictureType = 'Artist/performer' then begin
        Result := $08;
        Exit;
    end;
    if PictureType = 'Conductor' then begin
        Result := $09;
        Exit;
    end;
    if PictureType = 'Band/Orchestra' then begin
        Result := $0A;
        Exit;
    end;
    if PictureType = 'Composer' then begin
        Result := $0B;
    end;
    if PictureType = 'Lyricist/text writer' then begin
        Result := $0C;
        Exit;
    end;
    if PictureType = 'Recording Location' then begin
        Result := $0D;
        Exit;
    end;
    if PictureType = 'During recording' then begin
        Result := $0E;
        Exit;
    end;
    if PictureType = 'During performance' then begin
        Result := $0F;
        Exit;
    end;
    if PictureType = 'Movie/video screen capture' then begin
        Result := $10;
        Exit;
    end;
    if PictureType = 'A bright coloured fish' then begin
        Result := $11;
        Exit;
    end;
    if PictureType = 'Illustration' then begin
        Result := $12;
        Exit;
    end;
    if PictureType = 'Band/artist logotype' then begin
        Result := $13;
        Exit;
    end;
    if PictureType = 'Publisher/Studio logotype' then begin
        Result := $14;
        Exit;
    end;
end;

function RemoveID3v2TagFromFile(FileName: String): Integer;
var
    AudioFileName: String;
    AudioFile: TFileStream;
    OutputFileName: String;
    OutputFile: TFileStream;
    ID3v2Size: Integer;
    TagCodedSizeInExistingStream: Cardinal;
    TagSizeInExistingStream: Cardinal;
begin
    Result := ID3V2LIBRARY_ERROR;
    AudioFile := nil;
    if NOT FileExists(FileName) then begin
        Exit;
    end;
    ID3v2Size := 0;
    try
        Result := ID3V2LIBRARY_ERROR_EMPTY_TAG;
        AudioFileName := FileName;
        try
            try
                AudioFile := TFileStream.Create(AudioFileName, fmOpenRead);
            except
                Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
                Exit;
            end;
            if ID3v2ValidTag(AudioFile) then begin
                //* Skip version data and flags
                AudioFile.Seek(3, soCurrent);
                AudioFile.Read(TagCodedSizeInExistingStream, 4);
                UnSyncSafe(TagCodedSizeInExistingStream, 4, TagSizeInExistingStream);
                //* Add header size to size
                ID3v2Size := TagSizeInExistingStream + 10;
            end else begin
                AudioFile.Seek(0, soBeginning);
                if CheckRIFF(AudioFile) then begin
                    if SeekRIFF(AudioFile) > 0 then begin
                        FreeAndNil(AudioFile);
                        Result := RemoveRIFFID3v2FromFile(FileName);
                        Exit;
                    end else begin
                        Exit;
                    end;
                end else begin
                    AudioFile.Seek(0, soBeginning);
                    if CheckRF64(AudioFile) then begin
                        if SeekRF64(AudioFile) > 0 then begin
                            FreeAndNil(AudioFile);
                            Result := RemoveRF64ID3v2FromFile(FileName);
                            Exit;
                        end else begin
                            Exit;
                        end;
                    end else begin
                        AudioFile.Seek(0, soBeginning);
                        if CheckAIFF(AudioFile) then begin
                            if SeekAIFF(AudioFile) > 0 then begin
                                FreeAndNil(AudioFile);
                                Result := RemoveAIFFID3v2FromFile(FileName);
                                Exit;
                            end else begin
                                Exit;
                            end;
                        end else begin
                            AudioFile.Seek(0, soBeginning);
                            if CheckDSF(AudioFile) then begin
                                if SeekDSF(AudioFile) > 0 then begin
                                    FreeAndNil(AudioFile);
                                    Result := RemoveDSFID3v2FromFile(FileName);
                                    Exit;
                                end else begin
                                    Exit;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        finally
            if Assigned(AudioFile) then begin
                FreeAndNil(AudioFile);
            end;
        end;
        //ID3v2Size := Size + 10;
        if ID3v2Size > 0 then begin
            try
                AudioFile := TFileStream.Create(AudioFileName, fmOpenRead);
            except
                Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
                Exit;
            end;
            OutputFileName := ChangeFileExt(AudioFileName, '.tmp');
            try
                OutputFile := TFileStream.Create(OutputFileName, fmCreate OR fmOpenReadWrite);
            except
                Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
                Exit;
            end;
            AudioFile.Seek(ID3v2Size, soBeginning);
            OutputFile.CopyFrom(AudioFile, AudioFile.Size - ID3v2Size);
            FreeAndNil(AudioFile);
            FreeAndNil(OutputFile);
            if NOT SysUtils.DeleteFile(AudioFileName) then begin
                Result := GetLastError;
                SysUtils.DeleteFile(OutputFileName);
            end else begin
                RenameFile(OutputFileName, AudioFileName);
                Result := ID3V2LIBRARY_SUCCESS;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveID3v2TagFromStream(Stream: TStream): Integer;
var
    //AudioFileName: String;
    //AudioFile: TFileStream;
    //OutputFileName: String;
    TempStream: TStream;
    ID3v2Size: Integer;
    TagCodedSizeInExistingStream: Cardinal;
    TagSizeInExistingStream: Cardinal;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    if Stream.Size = 0 then begin
        Exit;
    end;
    ID3v2Size := 0;
    try
        Result := ID3V2LIBRARY_ERROR_EMPTY_TAG;

        Stream.Seek(0, soBeginning);
        if ID3v2ValidTag(Stream) then begin
            //* Skip version data and flags
            Stream.Seek(3, soCurrent);
            Stream.Read(TagCodedSizeInExistingStream, 4);
            UnSyncSafe(TagCodedSizeInExistingStream, 4, TagSizeInExistingStream);
            //* Add header size to size
            ID3v2Size := TagSizeInExistingStream + 10;
        end else begin
            Stream.Seek(0, soBeginning);
            if CheckRIFF(Stream) then begin
                if SeekRIFF(Stream) > 0 then begin
                    FreeAndNil(Stream);
                    Result := RemoveRIFFID3v2FromStream(Stream);
                    Exit;
                end else begin
                    Exit;
                end;
            end else begin
                Stream.Seek(0, soBeginning);
                if CheckRF64(Stream) then begin
                    if SeekRF64(Stream) > 0 then begin
                        FreeAndNil(Stream);
                        Result := RemoveRF64ID3v2FromStream(Stream);
                        Exit;
                    end else begin
                        Exit;
                    end;
                end else begin
                    Stream.Seek(0, soBeginning);
                    if CheckAIFF(Stream) then begin
                        if SeekAIFF(Stream) > 0 then begin
                            FreeAndNil(Stream);
                            Result := RemoveAIFFID3v2FromStream(Stream);
                            Exit;
                        end else begin
                            Exit;
                        end;
                    end else begin
                        Stream.Seek(0, soBeginning);
                        if CheckDSF(Stream) then begin
                            if SeekDSF(Stream) > 0 then begin
                                FreeAndNil(Stream);
                                Result := RemoveDSFID3v2FromStream(Stream);
                                Exit;
                            end else begin
                                Exit;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if ID3v2Size > 0 then begin
            TempStream := TMemoryStream.Create;
            try
                Stream.Seek(ID3v2Size, soBeginning);
                try
                    TempStream.CopyFrom(Stream, Stream.Size - ID3v2Size);
                except
                    Exit;
                end;
                Stream.Size := 0;
                Stream.CopyFrom(TempStream, 0);
                Stream.Seek(0, soBeginning);
                Result := ID3V2LIBRARY_SUCCESS;
            finally
                FreeAndNil(TempStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function ID3v2ValidTag(TagStream: TStream): Boolean;
var
    Identification: TID3v2ID;
begin
    Result := False;
    try
        FillChar(Identification, SizeOf(TID3v2ID), 0);
        TagStream.Read(Identification[0], 3);
        if (Identification[0] = ID3v2ID[0])
        AND (Identification[1] = ID3v2ID[1])
        AND (Identification[2] = ID3v2ID[2])
        then begin
            Result := True;
        end;
    except
        //*
    end;
end;

function CheckRIFF(TagStream: TStream): Boolean;
var
    Identification: TRIFFID;
begin
    Result := False;
    try
        FillChar(Identification, SizeOf(TRIFFID), 0);
        TagStream.Read(Identification[0], 4);
        if (Identification[0] = RIFFID[0])
        AND (Identification[1] = RIFFID[1])
        AND (Identification[2] = RIFFID[2])
        AND (Identification[3] = RIFFID[3])
        then begin
            Result := True;
        end;
    except
        Result := False;
    end;
end;

function SeekRIFF(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
begin
    Result := 0;
    try
        //* Find ID3v2
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if (ChunkID[0] = RIFFID3v2ID[0])
                AND (ChunkID[1] = RIFFID3v2ID[1])
                AND (ChunkID[2] = RIFFID3v2ID[2])
                AND (ChunkID[3] = RIFFID3v2ID[3])
                then begin
                    Result := ChunkSize;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function CheckAIFF(TagStream: TStream): Boolean;
var
    Identification: TAIFFID;
begin
    Result := False;
    try
        FillChar(Identification, SizeOf(TRIFFID), 0);
        TagStream.Read(Identification[0], 4);
        if (Identification[0] = AIFFID[0])
        AND (Identification[1] = AIFFID[1])
        AND (Identification[2] = AIFFID[2])
        AND (Identification[3] = AIFFID[3])
        then begin
            Result := True;
        end;
    except
        Result := False;
    end;
end;

function SeekAIFF(TagStream: TStream): Integer;
var
    AIFFChunkSize: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
begin
    Result := 0;
    try
        //* Find ID3v2
        TagStream.Read(AIFFChunkSize, 4);
        AIFFChunkSize := ReverseBytes(AIFFChunkSize);
        TagStream.Read(ChunkID, 4);
        if ((ChunkID[0] = AIFFChunkID[0])
        AND (ChunkID[1] = AIFFChunkID[1])
        AND (ChunkID[2] = AIFFChunkID[2])
        AND (ChunkID[3] = AIFFChunkID[3]))
        OR ((ChunkID[0] = AIFCChunkID[0])
        AND (ChunkID[1] = AIFCChunkID[1])
        AND (ChunkID[2] = AIFCChunkID[2])
        AND (ChunkID[3] = AIFCChunkID[3]))
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                ChunkSize := ReverseBytes(ChunkSize);
                if (ChunkID[0] = AIFFID3v2ID[0])
                AND (ChunkID[1] = AIFFID3v2ID[1])
                AND (ChunkID[2] = AIFFID3v2ID[2])
                AND (ChunkID[3] = AIFFID3v2ID[3])
                then begin
                    Result := ChunkSize;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function CheckRF64(TagStream: TStream): Boolean;
var
    Identification: TRIFFID;
begin
    Result := False;
    try
        FillChar(Identification, SizeOf(TRIFFID), 0);
        TagStream.Read(Identification[0], 4);
        if (Identification[0] = RF64ID[0])
        AND (Identification[1] = RF64ID[1])
        AND (Identification[2] = RF64ID[2])
        AND (Identification[3] = RF64ID[3])
        then begin
            Result := True;
        end;
    except
        Result := False;
    end;
end;

function SeekRF64(TagStream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    ds64DataSize: Int64;
    Waveds64: TWaveds64;
begin
    Result := 0;
    try
        //* Find ID3v2
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('s'))
                AND (ChunkID[2] = Ord('6'))
                AND (ChunkID[3] = Ord('4'))
                then begin
                    TagStream.Read(Waveds64, SizeOf(TWaveds64));
                    TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    Continue;
                end;
                TagStream.Read(ChunkSize, 4);
                if (ChunkID[0] = RIFFID3v2ID[0])
                AND (ChunkID[1] = RIFFID3v2ID[1])
                AND (ChunkID[2] = RIFFID3v2ID[2])
                AND (ChunkID[3] = RIFFID3v2ID[3])
                then begin
                    Result := ChunkSize;
                    Exit;
                end else begin
                    if ((ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a')))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        ds64DataSize := MakeInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh);
                        TagStream.Seek(ds64DataSize, soCurrent);
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := 0;
    end;
end;

function CheckDSF(TagStream: TStream): Boolean;
var
    Identification: TRIFFID;
begin
    Result := False;
    try
        FillChar(Identification, SizeOf(TRIFFID), 0);
        TagStream.Read(Identification[0], 4);
        if (Identification[0] = DSFID[0])
        AND (Identification[1] = DSFID[1])
        AND (Identification[2] = DSFID[2])
        AND (Identification[3] = DSFID[3])
        then begin
            Result := True;
        end;
    except
        Result := False;
    end;
end;

function SeekDSF(TagStream: TStream): Integer;
var
    ID3v2Pointer: UInt64;
begin
    Result := 0;
    try
        //* Find ID3v2
        TagStream.Seek(16, soCurrent);
        TagStream.Read(ID3v2Pointer, 8);
        //ID3v2Pointer := ReverseBytes64(ID3v2Pointer);
        if ID3v2Pointer > 0 then begin
            TagStream.Seek(ID3v2Pointer, soBeginning);
            Result := GetID3v2Size(TagStream);
        end;
    except
        Result := 0;
    end;
end;

function TID3v2Tag.LoadDSFInfo(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    ChunkSize: UInt64;
    ChunkID: TRIFFID;
    ChannelType: Cardinal;
begin
    Result := False;
    PreviousPosition := TagStream.Position;
    try
        TagStream.Seek(4, soBeginning);
        TagStream.Read(ChunkSize, 8);
        TagStream.Seek(ChunkSize - 12, soCurrent);
        TagStream.Read(ChunkID[0], 4);
        if (ChunkID[0] = DSFfmt_ID[0])
        AND (ChunkID[1] = DSFfmt_ID[1])
        AND (ChunkID[2] = DSFfmt_ID[2])
        AND (ChunkID[3] = DSFfmt_ID[3])
        then begin
            TagStream.Seek(8, soCurrent);
            TagStream.Read(DSFInfo.FormatVersion, 4);
            TagStream.Read(DSFInfo.FormatID, 4);
            TagStream.Read(ChannelType, 4);
            case ChannelType of
                1: DSFInfo.ChannelType := dsfctMono;
                2: DSFInfo.ChannelType := dsfctStereo;
                3: DSFInfo.ChannelType := dsfct3Channels;
                4: DSFInfo.ChannelType := dsfctQuad;
                5: DSFInfo.ChannelType := dsfct4Channels;
                6: DSFInfo.ChannelType := dsfct5Channels;
                7: DSFInfo.ChannelType := dsfct51Channels;
            else
                DSFInfo.ChannelType := dsfctUnknown;
            end;
            TagStream.Read(DSFInfo.ChannelNumber, 4);
            TagStream.Read(DSFInfo.SamplingFrequency, 4);
            TagStream.Read(DSFInfo.BitsPerSample, 4);
            TagStream.Read(DSFInfo.SampleCount, 8);
            TagStream.Read(DSFInfo.BlockSizePerChannel, 4);
            //* Calculate playtime
            DSFInfo.PlayTime := DSFInfo.SampleCount / DSFInfo.SamplingFrequency;
            //* Set attrbiutes
            FPlayTime := DSFInfo.PlayTime;
            SampleCount := DSFInfo.SampleCount;
            BitRate := DSFInfo.GetBitRate;
            Result := True;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

  // Use CalcCRC32 as a procedure so CRCValue can be passed in but
  // also returned. This allows multiple calls to CalcCRC32 for
  // the "same" CRC-32 calculation.
procedure CalcCRC32(P: Pointer; ByteCount: DWORD; var CRCValue: DWORD);
  // The following is a little cryptic (but executes very quickly).
  // The algorithm is as follows:
  // 1. exclusive-or the input byte with the low-order byte of
  // the CRC register to get an INDEX
  // 2. shift the CRC register eight bits to the right
  // 3. exclusive-or the CRC register with the contents of Table[INDEX]
  // 4. repeat steps 1 through 3 for all bytes
var
    i: DWORD;
    q: ^BYTE;
begin
    q := p;
    for i := 0 to ByteCount - 1 do begin
        CRCvalue := (CRCvalue SHR 8) XOR CRC32Table[q^ XOR (CRCvalue AND $000000FF)];
        Inc(q)
    end;
end;

function CalculateStreamCRC32(Stream: TStream; var CRCvalue: DWORD): Boolean;
var
    MemoryStream: TMemoryStream;
begin
    Result := False;
    CRCValue := $FFFFFFFF;
    MemoryStream := TMemoryStream(Stream);
    try
        MemoryStream.Seek(0, soBeginning);
        if MemoryStream.Size > 0 then begin
            CalcCRC32(MemoryStream.Memory, MemoryStream.Size, CRCvalue);
            Result := True;
        end;
    except
        Result := False;
    end;
    CRCvalue := NOT CRCvalue;
end;

function TID3v2Tag.CalculateTagCRC32: Cardinal;
var
    CRC32: Cardinal;
    TagsStream: TStream;
    Error: Integer;
    ReUnsynchronise: Boolean;
begin
    Result := 0;
    ReUnsynchronise := Unsynchronised;
    TagsStream := TMemoryStream.Create;
    try
        if ReUnsynchronise then begin
            RemoveUnsynchronisationOnAllFrames;
        end;
        Error := WriteAllFrames(TagsStream);
        if Error <> ID3V2LIBRARY_SUCCESS then begin
            Exit;
        end;
        CalculateStreamCRC32(TagsStream, CRC32);
        Result := CRC32;
    finally
        FreeAndNil(TagsStream);
        if ReUnsynchronise then begin
            ApplyUnsynchronisationOnAllFrames;
        end;
    end;
end;

function RIFFCreateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PaddingToWrite: Cardinal): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TotalSize: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Seek(- 4, soCurrent);
        TotalSize := RIFFChunkSize + WriteTagTotalSize + PaddingToWrite + 8;
        if Odd(TotalSize) then begin
            Inc(TotalSize);
        end;
        if TotalSize > $FFFFFFFF then begin
            Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
            Exit;
        end;
        RIFFChunkSizeNew := TotalSize;
        TagStream.Write(RIFFChunkSizeNew, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            while TagStream.Position + 8 < RIFFChunkSize do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                TagStream.Seek(ChunkSize, soCurrent);
            end;
            if TagStream.Position < TagStream.Size then begin
                PreviousPosition := TagStream.Position;
                if FileName <> '' then begin
                    try
                        TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                    except
                        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                        Exit;
                    end;
                end else begin
                    TempStream := TMemoryStream.Create;
                end;
                TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                TagStream.Seek(PreviousPosition, soBeginning);
            end;
            TagStream.Write(RIFFID3v2ID[0], 4);
            ChunkSize := WriteTagTotalSize + PaddingToWrite;
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            TagStream.Write(ChunkSize, 4);
            PreviousPosition := TagStream.Position;
            WritePadding(TagStream, ChunkSize);
            if Assigned(TempStream) then begin
                TempStream.Seek(0, soBeginning);
                TagStream.CopyFrom(TempStream, TempStream.Size);
                FreeAndNil(TempStream);
                SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
            end;
            TagStream.Seek(PreviousPosition, soBeginning);
            Result := ID3V2LIBRARY_SUCCESS;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RIFFUpdateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PreviousTagSize: Cardinal; PaddingToWrite: Cardinal): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TotalSize: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        TagStream.Seek(- 4, soCurrent);
        TotalSize := RIFFChunkSize - PreviousTagSize + WriteTagTotalSize + PaddingToWrite;
        if Odd(TotalSize) then begin
            Inc(TotalSize);
        end;
        if TotalSize > $FFFFFFFF then begin
            Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
            Exit;
        end;
        RIFFChunkSizeNew := TotalSize;
        TagStream.Write(RIFFChunkSizeNew, 4);
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if (ChunkID[0] = RIFFID3v2ID[0])
                AND (ChunkID[1] = RIFFID3v2ID[1])
                AND (ChunkID[2] = RIFFID3v2ID[2])
                AND (ChunkID[3] = RIFFID3v2ID[3])
                then begin
                    TagStream.Seek(- 4, soCurrent);
                    PreviousPosition := TagStream.Position;
                    TagStream.Seek(ChunkSize + 4, soCurrent);
                    if TagStream.Position < TagStream.Size then begin
                        if FileName <> '' then begin
                            try
                                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                            except
                                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                                Exit;
                            end;
                        end else begin
                            TempStream := TMemoryStream.Create;
                        end;
                        TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                    end;
                    TagStream.Seek(PreviousPosition, soBeginning);
                    ChunkSize := ChunkSize - PreviousTagSize + WriteTagTotalSize + PaddingToWrite;
                    if Odd(ChunkSize) then begin
                        Inc(ChunkSize);
                    end;
                    TagStream.Write(ChunkSize, 4);
                    WritePadding(TagStream, ChunkSize);
                    if Assigned(TempStream) then begin
                        TempStream.Seek(0, soBeginning);
                        TagStream.CopyFrom(TempStream, TempStream.Size);
                        FreeAndNil(TempStream);
                        SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
                    end;
                    TagStream.Size := TagStream.Position;
                    TagStream.Seek(PreviousPosition + 4, soBeginning);
                    Result := ID3V2LIBRARY_SUCCESS;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function AIFFCreateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PaddingToWrite: Cardinal): Integer;
var
    AIFFChunkSize: DWord;
    AIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    ChunkSizeNew: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    ZeroByte: Byte;
    TotalSize: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(AIFFChunkSize, 4);
        AIFFChunkSize := ReverseBytes(AIFFChunkSize);
        TagStream.Seek(- 4, soCurrent);
        TotalSize := AIFFChunkSize + WriteTagTotalSize + PaddingToWrite + 8;
        if Odd(TotalSize) then begin
            Inc(TotalSize);
        end;
        if TotalSize > $FFFFFFFF then begin
            Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
            Exit;
        end;
        AIFFChunkSizeNew := TotalSize;
        AIFFChunkSizeNew := ReverseBytes(AIFFChunkSizeNew);
        TagStream.Write(AIFFChunkSizeNew, 4);
        TagStream.Read(ChunkID, 4);
        if ((ChunkID[0] = AIFFChunkID[0])
        AND (ChunkID[1] = AIFFChunkID[1])
        AND (ChunkID[2] = AIFFChunkID[2])
        AND (ChunkID[3] = AIFFChunkID[3]))
        OR ((ChunkID[0] = AIFCChunkID[0])
        AND (ChunkID[1] = AIFCChunkID[1])
        AND (ChunkID[2] = AIFCChunkID[2])
        AND (ChunkID[3] = AIFCChunkID[3]))
        then begin
            while (TagStream.Position + 8 < AIFFChunkSize)
            AND (TagStream.Position + 8 < TagStream.Size)
            do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                ChunkSize := ReverseBytes(ChunkSize);
                TagStream.Seek(ChunkSize, soCurrent);
            end;
            if TagStream.Position < TagStream.Size then begin
                PreviousPosition := TagStream.Position;
                if FileName <> '' then begin
                    try
                        TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                    except
                        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                        Exit;
                    end;
                end else begin
                    TempStream := TMemoryStream.Create;
                end;
                TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                TagStream.Seek(PreviousPosition, soBeginning);
            end;
            if Odd(TagStream.Position) then begin
                ZeroByte := 0;
                TagStream.Write(ZeroByte, 1);
            end;
            TagStream.Write(AIFFID3v2ID[0], 4);
            ChunkSize := WriteTagTotalSize + PaddingToWrite;
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            ChunkSizeNew := ReverseBytes(ChunkSize);
            TagStream.Write(ChunkSizeNew, 4);
            PreviousPosition := TagStream.Position;
            WritePadding(TagStream, ChunkSize);
            if Assigned(TempStream) then begin
                TempStream.Seek(0, soBeginning);
                TagStream.CopyFrom(TempStream, TempStream.Size);
                FreeAndNil(TempStream);
                SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
            end;
            TagStream.Seek(PreviousPosition, soBeginning);
            Result := ID3V2LIBRARY_SUCCESS;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function AIFFUpdateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PreviousTagSize: Cardinal; PaddingToWrite: Cardinal): Integer;
var
    AIFFChunkSize: DWord;
    AIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    ChunkSizeNew: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TotalSize: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(AIFFChunkSize, 4);
        AIFFChunkSize := ReverseBytes(AIFFChunkSize);
        TagStream.Seek(- 4, soCurrent);
        TotalSize := AIFFChunkSize - PreviousTagSize + WriteTagTotalSize + PaddingToWrite;
        if Odd(TotalSize) then begin
            Inc(TotalSize);
        end;
        if TotalSize > $FFFFFFFF then begin
            Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
            Exit;
        end;
        AIFFChunkSizeNew := TotalSize;
        AIFFChunkSizeNew := ReverseBytes(AIFFChunkSizeNew);
        TagStream.Write(AIFFChunkSizeNew, 4);
        TagStream.Read(ChunkID, 4);
        if ((ChunkID[0] = AIFFChunkID[0])
        AND (ChunkID[1] = AIFFChunkID[1])
        AND (ChunkID[2] = AIFFChunkID[2])
        AND (ChunkID[3] = AIFFChunkID[3]))
        OR ((ChunkID[0] = AIFCChunkID[0])
        AND (ChunkID[1] = AIFCChunkID[1])
        AND (ChunkID[2] = AIFCChunkID[2])
        AND (ChunkID[3] = AIFCChunkID[3]))
        then begin
            ChunkSize := 0;
            while TagStream.Position + 8 < TagStream.Size do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                ChunkSize := ReverseBytes(ChunkSize);
                if (ChunkID[0] = AIFFID3v2ID[0])
                AND (ChunkID[1] = AIFFID3v2ID[1])
                AND (ChunkID[2] = AIFFID3v2ID[2])
                AND (ChunkID[3] = AIFFID3v2ID[3])
                then begin
                    TagStream.Seek(- 4, soCurrent);
                    PreviousPosition := TagStream.Position;
                    TagStream.Seek(ChunkSize + 4, soCurrent);
                    if TagStream.Position < TagStream.Size then begin
                        if FileName <> '' then begin
                            try
                                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                            except
                                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                                Exit;
                            end;
                        end else begin
                            TempStream := TMemoryStream.Create;
                        end;
                        TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                    end;
                    TagStream.Seek(PreviousPosition, soBeginning);
                    ChunkSize := ChunkSize - PreviousTagSize + WriteTagTotalSize + PaddingToWrite;
                    if Odd(ChunkSize) then begin
                        Inc(ChunkSize);
                    end;
                    ChunkSizeNew := ReverseBytes(ChunkSize);
                    TagStream.Write(ChunkSizeNew, 4);
                    WritePadding(TagStream, ChunkSize);
                    if Assigned(TempStream) then begin
                        TempStream.Seek(0, soBeginning);
                        TagStream.CopyFrom(TempStream, TempStream.Size);
                        FreeAndNil(TempStream);
                        SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
                    end;
                    TagStream.Size := TagStream.Position;
                    TagStream.Seek(PreviousPosition + 4, soBeginning);
                    Result := ID3V2LIBRARY_SUCCESS;
                    Exit;
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RF64CreateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PaddingToWrite: Cardinal): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TotalSize: Int64;
    Waveds64: TWaveds64;
    Data: DWord;
    RF64Size: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    RF64Size := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        if RIFFChunkSize = $FFFFFFFF then begin
            TagStream.Read(ChunkID, 4);
            if (ChunkID[0] <> Ord('W'))
            OR (ChunkID[1] <> Ord('A'))
            OR (ChunkID[2] <> Ord('V'))
            OR (ChunkID[3] <> Ord('E'))
            then begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            TagStream.Read(ChunkID, 4);
            if (ChunkID[0] = Ord('d'))
            AND (ChunkID[1] = Ord('s'))
            AND (ChunkID[2] = Ord('6'))
            AND (ChunkID[3] = Ord('4'))
            then begin
                TagStream.Read(Waveds64, SizeOf(TWaveds64));
                RF64Size := MakeInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                TotalSize := RF64Size + WriteTagTotalSize + PaddingToWrite + 8;
                if Odd(TotalSize) then begin
                    Inc(TotalSize);
                end;
                //* Set new RF64 size
                TagStream.Position := 20;
                Data := LowDWordOfInt64(TotalSize);
                TagStream.write(Data, 4);
                Data := HighDWordOfInt64(TotalSize);
                TagStream.write(Data, 4);
                TagStream.Seek(8, soBeginning);
            end;
        end else begin
            RF64Size := RIFFChunkSize;
            TagStream.Seek(- 4, soCurrent);
            TotalSize := RIFFChunkSize + WriteTagTotalSize + PaddingToWrite + 8;
            if Odd(TotalSize) then begin
                Inc(TotalSize);
            end;
            if TotalSize > $FFFFFFFF then begin
                Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
                Exit;
            end;
            RIFFChunkSizeNew := TotalSize;
            TagStream.Write(RIFFChunkSizeNew, 4);
        end;
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            while TagStream.Position < RF64Size + 8 do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('a'))
                AND (ChunkID[2] = Ord('t'))
                AND (ChunkID[3] = Ord('a'))
                AND (ChunkSize = $FFFFFFFF)
                then begin
                    TagStream.Seek(MakeInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh), soCurrent);
                end else begin
                    TagStream.Seek(ChunkSize, soCurrent);
                end;
            end;
            if TagStream.Position < TagStream.Size then begin
                PreviousPosition := TagStream.Position;
                if FileName <> '' then begin
                    try
                        TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                    except
                        Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                        Exit;
                    end;
                end else begin
                    TempStream := TMemoryStream.Create;
                end;
                TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                TagStream.Seek(PreviousPosition, soBeginning);
            end;
            TagStream.Write(RIFFID3v2ID[0], 4);
            ChunkSize := WriteTagTotalSize + PaddingToWrite;
            if Odd(ChunkSize) then begin
                Inc(ChunkSize);
            end;
            TagStream.Write(ChunkSize, 4);
            PreviousPosition := TagStream.Position;
            WritePadding(TagStream, ChunkSize);
            if Assigned(TempStream) then begin
                TempStream.Seek(0, soBeginning);
                TagStream.CopyFrom(TempStream, TempStream.Size);
                FreeAndNil(TempStream);
                SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
            end;
            TagStream.Seek(PreviousPosition, soBeginning);
            Result := ID3V2LIBRARY_SUCCESS;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RF64UpdateID3v2(FileName: String; TagStream: TStream; WriteTagTotalSize: Cardinal; PreviousTagSize: Cardinal; PaddingToWrite: Cardinal): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TotalSize: Int64;
    Waveds64: TWaveds64;
    RF64Size: Int64;
    Data: DWord;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    RF64Size := 0;
    try
        TagStream.Seek(4, soCurrent);
        TagStream.Read(RIFFChunkSize, 4);
        if RIFFChunkSize = $FFFFFFFF then begin
            TagStream.Read(ChunkID, 4);
            if (ChunkID[0] <> Ord('W'))
            OR (ChunkID[1] <> Ord('A'))
            OR (ChunkID[2] <> Ord('V'))
            OR (ChunkID[3] <> Ord('E'))
            then begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            TagStream.Read(ChunkID, 4);
            if (ChunkID[0] = Ord('d'))
            AND (ChunkID[1] = Ord('s'))
            AND (ChunkID[2] = Ord('6'))
            AND (ChunkID[3] = Ord('4'))
            then begin
                TagStream.Read(Waveds64, SizeOf(TWaveds64));
                RF64Size := MakeInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                TotalSize := RF64Size - PreviousTagSize + WriteTagTotalSize + PaddingToWrite + 8;
                if Odd(TotalSize) then begin
                    Inc(TotalSize);
                end;
                //* Set new RF64 size
                TagStream.Position := 20;
                Data := LowDWordOfInt64(TotalSize);
                TagStream.write(Data, 4);
                Data := HighDWordOfInt64(TotalSize);
                TagStream.write(Data, 4);
                TagStream.Seek(8, soBeginning);
            end;
        end else begin
            //RF64Size := RIFFChunkSize;
            TagStream.Seek(- 4, soCurrent);
            TotalSize := RIFFChunkSize - PreviousTagSize + WriteTagTotalSize + PaddingToWrite + 8;
            if Odd(TotalSize) then begin
                Inc(TotalSize);
            end;
            if TotalSize > $FFFFFFFF then begin
                Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
                Exit;
            end;
            RIFFChunkSizeNew := TotalSize;
            TagStream.Write(RIFFChunkSizeNew, 4);
        end;
        TagStream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while TagStream.Position < RF64Size + 8 do begin
                TagStream.Read(ChunkID, 4);
                TagStream.Read(ChunkSize, 4);
                if (ChunkID[0] = RIFFID3v2ID[0])
                AND (ChunkID[1] = RIFFID3v2ID[1])
                AND (ChunkID[2] = RIFFID3v2ID[2])
                AND (ChunkID[3] = RIFFID3v2ID[3])
                then begin
                    TagStream.Seek(- 4, soCurrent);
                    PreviousPosition := TagStream.Position;
                    TagStream.Seek(ChunkSize + 4, soCurrent);
                    if TagStream.Position < TagStream.Size then begin
                        if FileName <> '' then begin
                            try
                                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                            except
                                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                                Exit;
                            end;
                        end else begin
                            TempStream := TMemoryStream.Create;
                        end;
                        TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                    end;
                    TagStream.Seek(PreviousPosition, soBeginning);
                    ChunkSize := ChunkSize - PreviousTagSize + WriteTagTotalSize + PaddingToWrite;
                    if Odd(ChunkSize) then begin
                        Inc(ChunkSize);
                    end;
                    TagStream.Write(ChunkSize, 4);
                    WritePadding(TagStream, ChunkSize);
                    if Assigned(TempStream) then begin
                        TempStream.Seek(0, soBeginning);
                        TagStream.CopyFrom(TempStream, TempStream.Size);
                        FreeAndNil(TempStream);
                        SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
                    end;
                    TagStream.Size := TagStream.Position;
                    TagStream.Seek(PreviousPosition + 4, soBeginning);
                    Result := ID3V2LIBRARY_SUCCESS;
                    Exit;
                end else begin
                    if (ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a'))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        TagStream.Seek(MakeInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh), soCurrent);
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveRIFFID3v2FromFile(FileName: String): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TFileStream;
    TagStream: TFileStream;
    TagSize: DWord;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream := TFileStream.Create(FileName, fmOpenReadWrite);
    except
        Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        try
            if CheckRIFF(TagStream) then begin
                TagSize := SeekRIFF(TagStream);
                if TagSize = 0 then begin
                    Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                    Exit;
                end;
            end else begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            TagStream.Seek(4, soBeginning);
            TagStream.Read(RIFFChunkSize, 4);
            TagStream.Seek(- 4, soCurrent);
            RIFFChunkSizeNew := RIFFChunkSize - TagSize - 8;
            TagStream.Write(RIFFChunkSizeNew, 4);
            TagStream.Read(ChunkID, 4);
            if (ChunkID[0] = RIFFWAVEID[0])
            AND (ChunkID[1] = RIFFWAVEID[1])
            AND (ChunkID[2] = RIFFWAVEID[2])
            AND (ChunkID[3] = RIFFWAVEID[3])
            then begin
                ChunkSize := 0;
                while TagStream.Position + 8 < TagStream.Size do begin
                    TagStream.Read(ChunkID, 4);
                    TagStream.Read(ChunkSize, 4);
                    if (ChunkID[0] = RIFFID3v2ID[0])
                    AND (ChunkID[1] = RIFFID3v2ID[1])
                    AND (ChunkID[2] = RIFFID3v2ID[2])
                    AND (ChunkID[3] = RIFFID3v2ID[3])
                    then begin
                        TagStream.Seek(- 8, soCurrent);
                        PreviousPosition := TagStream.Position;
                        TagStream.Seek(ChunkSize + 8, soCurrent);
                        if TagStream.Position + 8 + ChunkSize < TagStream.Size then begin
                            try
                                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                            except
                                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                                Exit;
                            end;
                            TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                        end;
                        TagStream.Seek(PreviousPosition, soBeginning);
                        THandleStream(TagStream).Size := TagStream.Position;
                        if Assigned(TempStream) then begin
                            TempStream.Seek(0, soBeginning);
                            TagStream.CopyFrom(TempStream, TempStream.Size);
                            FreeAndNil(TempStream);
                            SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
                        end;
                        Result := ID3V2LIBRARY_SUCCESS;
                        Exit;
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        finally
            if Assigned(TagStream) then begin
                FreeAndNil(TagStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveRIFFID3v2FromStream(Stream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TagSize: DWord;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    if Stream.Size = 0 then begin
        Exit;
    end;
    try
        Stream.Seek(0, soBeginning);
        if CheckRIFF(Stream) then begin
            TagSize := SeekRIFF(Stream);
            if TagSize = 0 then begin
                Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                Exit;
            end;
        end else begin
            Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
            Exit;
        end;
        Stream.Seek(4, soBeginning);
        Stream.Read(RIFFChunkSize, 4);
        Stream.Seek(- 4, soCurrent);
        RIFFChunkSizeNew := RIFFChunkSize - TagSize - 8;
        Stream.Write(RIFFChunkSizeNew, 4);
        Stream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while Stream.Position + 8 < Stream.Size do begin
                Stream.Read(ChunkID, 4);
                Stream.Read(ChunkSize, 4);
                if (ChunkID[0] = RIFFID3v2ID[0])
                AND (ChunkID[1] = RIFFID3v2ID[1])
                AND (ChunkID[2] = RIFFID3v2ID[2])
                AND (ChunkID[3] = RIFFID3v2ID[3])
                then begin
                    Stream.Seek(- 8, soCurrent);
                    PreviousPosition := Stream.Position;
                    Stream.Seek(ChunkSize + 8, soCurrent);
                    if Stream.Position + 8 + ChunkSize < Stream.Size then begin
                        TempStream := TMemoryStream.Create;
                        try
                            TempStream.CopyFrom(Stream, Stream.Size - Stream.Position);
                        except
                            FreeAndNil(TempStream);
                            Exit;
                        end;
                    end;
                    Stream.Seek(PreviousPosition, soBeginning);
                    Stream.Size := Stream.Position;
                    if Assigned(TempStream) then begin
                        TempStream.Seek(0, soBeginning);
                        Stream.CopyFrom(TempStream, TempStream.Size);
                        FreeAndNil(TempStream);
                    end;
                    Result := ID3V2LIBRARY_SUCCESS;
                    Exit;
                end else begin
                    Stream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveAIFFID3v2FromFile(FileName: String): Integer;
var
    AIFFChunkSize: DWord;
    AIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TFileStream;
    TagStream: TFileStream;
    TagSize: DWord;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream := TFileStream.Create(FileName, fmOpenReadWrite);
    except
        Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        try
            if CheckAIFF(TagStream) then begin
                TagSize := SeekAIFF(TagStream);
                if TagSize = 0 then begin
                    Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                    Exit;
                end;
            end else begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            TagStream.Seek(4, soBeginning);
            TagStream.Read(AIFFChunkSize, 4);
            AIFFChunkSize := ReverseBytes(AIFFChunkSize);
            TagStream.Seek(- 4, soCurrent);
            AIFFChunkSizeNew := AIFFChunkSize - TagSize - 8;
            AIFFChunkSizeNew := ReverseBytes(AIFFChunkSizeNew);
            TagStream.Write(AIFFChunkSizeNew, 4);
            TagStream.Read(ChunkID, 4);
            if ((ChunkID[0] = AIFFChunkID[0])
            AND (ChunkID[1] = AIFFChunkID[1])
            AND (ChunkID[2] = AIFFChunkID[2])
            AND (ChunkID[3] = AIFFChunkID[3]))
            OR ((ChunkID[0] = AIFCChunkID[0])
            AND (ChunkID[1] = AIFCChunkID[1])
            AND (ChunkID[2] = AIFCChunkID[2])
            AND (ChunkID[3] = AIFCChunkID[3]))
            then begin
                ChunkSize := 0;
                while TagStream.Position + 8 < TagStream.Size do begin
                    TagStream.Read(ChunkID, 4);
                    TagStream.Read(ChunkSize, 4);
                    ChunkSize := ReverseBytes(ChunkSize);
                    if (ChunkID[0] = AIFFID3v2ID[0])
                    AND (ChunkID[1] = AIFFID3v2ID[1])
                    AND (ChunkID[2] = AIFFID3v2ID[2])
                    AND (ChunkID[3] = AIFFID3v2ID[3])
                    then begin
                        TagStream.Seek(- 8, soCurrent);
                        PreviousPosition := TagStream.Position;
                        TagStream.Seek(ChunkSize + 8, soCurrent);
                        if TagStream.Position + 8 + ChunkSize < TagStream.Size then begin
                            try
                                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                            except
                                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                                Exit;
                            end;
                            TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                        end;
                        TagStream.Seek(PreviousPosition, soBeginning);
                        THandleStream(TagStream).Size := TagStream.Position;
                        if Assigned(TempStream) then begin
                            TempStream.Seek(0, soBeginning);
                            TagStream.CopyFrom(TempStream, TempStream.Size);
                            FreeAndNil(TempStream);
                            SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
                        end;
                        Result := ID3V2LIBRARY_SUCCESS;
                        Exit;
                    end else begin
                        TagStream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        finally
            if Assigned(TagStream) then begin
                FreeAndNil(TagStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveAIFFID3v2FromStream(Stream: TStream): Integer;
var
    AIFFChunkSize: DWord;
    AIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TagSize: DWord;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    if Stream.Size = 0 then begin
        Exit;
    end;
    try
        Stream.Seek(0, soBeginning);
        if CheckAIFF(Stream) then begin
            TagSize := SeekAIFF(Stream);
            if TagSize = 0 then begin
                Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                Exit;
            end;
        end else begin
            Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
            Exit;
        end;
        Stream.Seek(4, soBeginning);
        Stream.Read(AIFFChunkSize, 4);
        AIFFChunkSize := ReverseBytes(AIFFChunkSize);
        Stream.Seek(- 4, soCurrent);
        AIFFChunkSizeNew := AIFFChunkSize - TagSize - 8;
        AIFFChunkSizeNew := ReverseBytes(AIFFChunkSizeNew);
        Stream.Write(AIFFChunkSizeNew, 4);
        Stream.Read(ChunkID, 4);
        if ((ChunkID[0] = AIFFChunkID[0])
        AND (ChunkID[1] = AIFFChunkID[1])
        AND (ChunkID[2] = AIFFChunkID[2])
        AND (ChunkID[3] = AIFFChunkID[3]))
        OR ((ChunkID[0] = AIFCChunkID[0])
        AND (ChunkID[1] = AIFCChunkID[1])
        AND (ChunkID[2] = AIFCChunkID[2])
        AND (ChunkID[3] = AIFCChunkID[3]))
        then begin
            ChunkSize := 0;
            while Stream.Position + 8 < Stream.Size do begin
                Stream.Read(ChunkID, 4);
                Stream.Read(ChunkSize, 4);
                ChunkSize := ReverseBytes(ChunkSize);
                if (ChunkID[0] = AIFFID3v2ID[0])
                AND (ChunkID[1] = AIFFID3v2ID[1])
                AND (ChunkID[2] = AIFFID3v2ID[2])
                AND (ChunkID[3] = AIFFID3v2ID[3])
                then begin
                    Stream.Seek(- 8, soCurrent);
                    PreviousPosition := Stream.Position;
                    Stream.Seek(ChunkSize + 8, soCurrent);
                    if Stream.Position + 8 + ChunkSize < Stream.Size then begin
                        TempStream := TMemoryStream.Create;
                        try
                            TempStream.CopyFrom(Stream, Stream.Size - Stream.Position);
                        except
                            FreeAndNil(TempStream);
                            Exit;
                        end;
                    end;
                    Stream.Seek(PreviousPosition, soBeginning);
                    Stream.Size := Stream.Position;
                    if Assigned(TempStream) then begin
                        TempStream.Seek(0, soBeginning);
                        Stream.CopyFrom(TempStream, TempStream.Size);
                        FreeAndNil(TempStream);
                    end;
                    Result := ID3V2LIBRARY_SUCCESS;
                    Exit;
                end else begin
                    Stream.Seek(ChunkSize, soCurrent);
                end;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveRF64ID3v2FromFile(FileName: String): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TFileStream;
    TagStream: TFileStream;
    TagSize: DWord;
    Waveds64: TWaveds64;
    RF64Size: Int64;
    Data: DWord;
    TotalSize: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    try
        TagStream := TFileStream.Create(FileName, fmOpenReadWrite);
    except
        Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        try
            if CheckRF64(TagStream) then begin
                TagSize := SeekRF64(TagStream);
                if TagSize = 0 then begin
                    Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                    Exit;
                end;
            end else begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            TagStream.Seek(4, soBeginning);
            TagStream.Read(RIFFChunkSize, 4);
            if RIFFChunkSize = $FFFFFFFF then begin
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] <> Ord('W'))
                OR (ChunkID[1] <> Ord('A'))
                OR (ChunkID[2] <> Ord('V'))
                OR (ChunkID[3] <> Ord('E'))
                then begin
                    Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                    Exit;
                end;
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = Ord('d'))
                AND (ChunkID[1] = Ord('s'))
                AND (ChunkID[2] = Ord('6'))
                AND (ChunkID[3] = Ord('4'))
                then begin
                    TagStream.Read(Waveds64, SizeOf(TWaveds64));
                    RF64Size := MakeInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                    TotalSize := RF64Size - TagSize - 8;
                    if Odd(TotalSize) then begin
                        Inc(TotalSize);
                    end;
                    //* Set new RF64 size
                    TagStream.Position := 20;
                    Data := LowDWordOfInt64(TotalSize);
                    TagStream.write(Data, 4);
                    Data := HighDWordOfInt64(TotalSize);
                    TagStream.write(Data, 4);
                    TagStream.Seek(8, soBeginning);
                end;
            end else begin
                RF64Size := RIFFChunkSize;
                TagStream.Seek(- 4, soCurrent);
                TotalSize := RF64Size - TagSize - 8;
                //* Should not happen
                {
                if Odd(TotalSize) then begin
                    Inc(TotalSize);
                end;
                }
                if TotalSize > $FFFFFFFF then begin
                    Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
                    Exit;
                end;
                RIFFChunkSizeNew := TotalSize;
                TagStream.Write(RIFFChunkSizeNew, 4);
            end;
            TagStream.Read(ChunkID, 4);
            if (ChunkID[0] = RIFFWAVEID[0])
            AND (ChunkID[1] = RIFFWAVEID[1])
            AND (ChunkID[2] = RIFFWAVEID[2])
            AND (ChunkID[3] = RIFFWAVEID[3])
            then begin
                ChunkSize := 0;
                while TagStream.Position + 8 < TagStream.Size do begin
                    TagStream.Read(ChunkID, 4);
                    TagStream.Read(ChunkSize, 4);
                    if (ChunkID[0] = RIFFID3v2ID[0])
                    AND (ChunkID[1] = RIFFID3v2ID[1])
                    AND (ChunkID[2] = RIFFID3v2ID[2])
                    AND (ChunkID[3] = RIFFID3v2ID[3])
                    then begin
                        TagStream.Seek(- 8, soCurrent);
                        PreviousPosition := TagStream.Position;
                        TagStream.Seek(ChunkSize + 8, soCurrent);
                        if TagStream.Position + 8 + ChunkSize < TagStream.Size then begin
                            try
                                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                            except
                                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                                Exit;
                            end;
                            TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
                        end;
                        TagStream.Seek(PreviousPosition, soBeginning);
                        THandleStream(TagStream).Size := TagStream.Position;
                        if Assigned(TempStream) then begin
                            TempStream.Seek(0, soBeginning);
                            TagStream.CopyFrom(TempStream, TempStream.Size);
                            FreeAndNil(TempStream);
                            SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
                        end;
                        Result := ID3V2LIBRARY_SUCCESS;
                        Exit;
                    end else begin
                        if (ChunkID[0] = Ord('d'))
                        AND (ChunkID[1] = Ord('a'))
                        AND (ChunkID[2] = Ord('t'))
                        AND (ChunkID[3] = Ord('a'))
                        AND (ChunkSize = $FFFFFFFF)
                        then begin
                            TagStream.Seek(MakeInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh), soCurrent);
                        end else begin
                            TagStream.Seek(ChunkSize, soCurrent);
                        end;
                    end;
                end;
            end;
        finally
            if Assigned(TagStream) then begin
                FreeAndNil(TagStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveRF64ID3v2FromStream(Stream: TStream): Integer;
var
    RIFFChunkSize: DWord;
    RIFFChunkSizeNew: DWord;
    ChunkID: TFrameID;
    ChunkSize: DWord;
    PreviousPosition: Int64;
    TempStream: TStream;
    TagSize: DWord;
    Waveds64: TWaveds64;
    RF64Size: Int64;
    Data: DWord;
    TotalSize: Int64;
begin
    Result := ID3V2LIBRARY_ERROR;
    TempStream := nil;
    if Stream.Size = 0 then begin
        Exit;
    end;

    try
        Stream.Seek(0, soBeginning);
        if CheckRF64(Stream) then begin
            TagSize := SeekRF64(Stream);
            if TagSize = 0 then begin
                Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                Exit;
            end;
        end else begin
            Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
            Exit;
        end;
        Stream.Seek(4, soBeginning);
        Stream.Read(RIFFChunkSize, 4);
        if RIFFChunkSize = $FFFFFFFF then begin
            Stream.Read(ChunkID, 4);
            if (ChunkID[0] <> Ord('W'))
            OR (ChunkID[1] <> Ord('A'))
            OR (ChunkID[2] <> Ord('V'))
            OR (ChunkID[3] <> Ord('E'))
            then begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            Stream.Read(ChunkID, 4);
            if (ChunkID[0] = Ord('d'))
            AND (ChunkID[1] = Ord('s'))
            AND (ChunkID[2] = Ord('6'))
            AND (ChunkID[3] = Ord('4'))
            then begin
                Stream.Read(Waveds64, SizeOf(TWaveds64));
                RF64Size := MakeInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                TotalSize := RF64Size - TagSize - 8;
                if Odd(TotalSize) then begin
                    Inc(TotalSize);
                end;
                //* Set new RF64 size
                Stream.Position := 20;
                Data := LowDWordOfInt64(TotalSize);
                Stream.write(Data, 4);
                Data := HighDWordOfInt64(TotalSize);
                Stream.write(Data, 4);
                Stream.Seek(8, soBeginning);
            end;
        end else begin
            RF64Size := RIFFChunkSize;
            Stream.Seek(- 4, soCurrent);
            TotalSize := RF64Size - TagSize - 8;
            //* Should not happen
            {
            if Odd(TotalSize) then begin
                Inc(TotalSize);
            end;
            }
            if TotalSize > $FFFFFFFF then begin
                Result := ID3V2LIBRARY_ERROR_DOESNT_FIT;
                Exit;
            end;
            RIFFChunkSizeNew := TotalSize;
            Stream.Write(RIFFChunkSizeNew, 4);
        end;
        Stream.Read(ChunkID, 4);
        if (ChunkID[0] = RIFFWAVEID[0])
        AND (ChunkID[1] = RIFFWAVEID[1])
        AND (ChunkID[2] = RIFFWAVEID[2])
        AND (ChunkID[3] = RIFFWAVEID[3])
        then begin
            ChunkSize := 0;
            while Stream.Position + 8 < Stream.Size do begin
                Stream.Read(ChunkID, 4);
                Stream.Read(ChunkSize, 4);
                if (ChunkID[0] = RIFFID3v2ID[0])
                AND (ChunkID[1] = RIFFID3v2ID[1])
                AND (ChunkID[2] = RIFFID3v2ID[2])
                AND (ChunkID[3] = RIFFID3v2ID[3])
                then begin
                    Stream.Seek(- 8, soCurrent);
                    PreviousPosition := Stream.Position;
                    Stream.Seek(ChunkSize + 8, soCurrent);
                    if Stream.Position + 8 + ChunkSize < Stream.Size then begin
                        TempStream := TMemoryStream.Create;
                        try
                            TempStream.CopyFrom(Stream, Stream.Size - Stream.Position);
                        except
                            FreeAndNil(TempStream);
                            Exit;
                        end;
                    end;
                    Stream.Seek(PreviousPosition, soBeginning);
                    THandleStream(Stream).Size := Stream.Position;
                    if Assigned(TempStream) then begin
                        TempStream.Seek(0, soBeginning);
                        Stream.CopyFrom(TempStream, TempStream.Size);
                        FreeAndNil(TempStream);
                    end;
                    Result := ID3V2LIBRARY_SUCCESS;
                    Exit;
                end else begin
                    if (ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('a'))
                    AND (ChunkID[2] = Ord('t'))
                    AND (ChunkID[3] = Ord('a'))
                    AND (ChunkSize = $FFFFFFFF)
                    then begin
                        Stream.Seek(MakeInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh), soCurrent);
                    end else begin
                        Stream.Seek(ChunkSize, soCurrent);
                    end;
                end;
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveDSFID3v2FromFile(FileName: String): Integer;
var
    TempStream: TFileStream;
    TagStream: TFileStream;
    TagSize: DWord;
    ID3v2Pointer: UInt64;
    DSFFileSize: UInt64;
    Zero64: UInt64;
begin
    Zero64 := 0;
    TempStream := nil;
    try
        TagStream := TFileStream.Create(FileName, fmOpenReadWrite);
    except
        Result := ID3V2LIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        try
            if CheckDSF(TagStream) then begin
                TagSize := SeekDSF(TagStream);
                if TagSize = 0 then begin
                    Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                    Exit;
                end;
            end else begin
                Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            //* Update DSF file size
            TagStream.Seek(12, soBeginning);
            TagStream.Read(DSFFileSize, 8);
            Dec(DSFFileSize, TagSize);
            TagStream.Seek(- 8, soCurrent);
            TagStream.Write(DSFFileSize, 8);
            //* Update ID3v2 pointer
            TagStream.Read(ID3v2Pointer, 8);
            TagStream.Seek(- 8, soCurrent);
            TagStream.Write(Zero64, 8);
            //* Check if there is tail data
            TagStream.Seek(ID3v2Pointer, soBeginning);
            if TagStream.Position + TagSize < TagStream.Size then begin
                try
                    TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
                except
                    Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                    Exit;
                end;
                TagStream.Seek(ID3v2Pointer + TagSize, soBeginning);
                TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
            end;
            //* Truncate file at ID3v2 pointer
            TagStream.Seek(ID3v2Pointer, soBeginning);
            TagStream.Size := TagStream.Position;
            //* Copy remaining data if have it
            if Assigned(TempStream) then begin
                TempStream.Seek(0, soBeginning);
                TagStream.CopyFrom(TempStream, TempStream.Size);
                FreeAndNil(TempStream);
                SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
            end;
            Result := ID3V2LIBRARY_SUCCESS;
        finally
            if Assigned(TagStream) then begin
                FreeAndNil(TagStream);
            end;
        end;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function RemoveDSFID3v2FromStream(Stream: TStream): Integer;
var
    TempStream: TStream;
    TagSize: DWord;
    ID3v2Pointer: UInt64;
    DSFFileSize: UInt64;
    Zero64: UInt64;
begin
    Result := ID3V2LIBRARY_ERROR;
    Zero64 := 0;
    TempStream := nil;
    if Stream.Size = 0 then begin
        Exit;
    end;
    try
        Stream.Seek(0, soBeginning);
        if CheckDSF(Stream) then begin
            TagSize := SeekDSF(Stream);
            if TagSize = 0 then begin
                Result := ID3V2LIBRARY_ERROR_NO_TAG_FOUND;
                Exit;
            end;
        end else begin
            Result := ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
            Exit;
        end;
        //* Update DSF file size
        Stream.Seek(12, soBeginning);
        Stream.Read(DSFFileSize, 8);
        Dec(DSFFileSize, TagSize);
        Stream.Seek(- 8, soCurrent);
        Stream.Write(DSFFileSize, 8);
        //* Update ID3v2 pointer
        Stream.Read(ID3v2Pointer, 8);
        Stream.Seek(- 8, soCurrent);
        Stream.Write(Zero64, 8);
        //* Check if there is tail data
        Stream.Seek(ID3v2Pointer, soBeginning);
        if Stream.Position + TagSize < Stream.Size then begin
            TempStream := TMemoryStream.Create;
            try
                Stream.Seek(ID3v2Pointer + TagSize, soBeginning);
                TempStream.CopyFrom(Stream, Stream.Size - Stream.Position);
            except
                FreeAndNil(TempStream);
                Exit;
            end;
        end;
        //* Truncate file at ID3v2 pointer
        Stream.Seek(ID3v2Pointer, soBeginning);
        Stream.Size := Stream.Position;
        //* Copy remaining data if have it
        if Assigned(TempStream) then begin
            TempStream.Seek(0, soBeginning);
            Stream.CopyFrom(TempStream, TempStream.Size);
            FreeAndNil(TempStream);
        end;
        Result := ID3V2LIBRARY_SUCCESS;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

function TID3v2Tag.FindCustomFrame(FrameID: String; Description: String): Integer;
var
    ID: TFrameID;
    FrameDescription: String;
    i: Integer;
begin
    Result := -1;
    AnsiStringToPAnsiChar(FrameID, ID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(ID, Frames[i].ID) then begin
            GetUnicodeUserDefinedTextInformation(i, FrameDescription);
            if FrameDescription = Description then begin
                Result := i;
                Break;
            end;
        end;
    end;
end;

function TID3v2Tag.GetUnicodeUserDefinedTextInformation(FrameIndex: Integer; var Description: String): String;
var
    Data: Byte;
    DataWord: Word;
    EncodingFormat: Byte;
    Bytes: TBytes;
    ByteCounter: Integer;
    DataBOM: Word;
    BigEndian: Boolean;
begin
    Result := '';
    Description := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        BigEndian := False;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get encoding format
        Frames[FrameIndex].Stream.Read(EncodingFormat, 1);
        //* Get decription and content
        case EncodingFormat of
            0: begin
                //* Get description
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        Description := Description + Char(Data);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                //* Get the content
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if (Data = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        Result := Result + #13#10;
                    end else begin
                        if Data <> 0 then begin
                            Result := Result + Char(Data);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
            end;
            1: begin
                //* Get description
                Frames[FrameIndex].Stream.Read(DataBOM, 2);
                if DataBOM = $FEFF then begin
                    BigEndian := False;
                end;
                if DataBOM = $FFFE then begin
                    BigEndian := True;
                end;
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataWord, 2);
                    if DataWord <> 0 then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := DataWord;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := DataWord SHR 8;
                        Inc(ByteCounter);
                    end;
                until (DataWord = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                if BigEndian then begin
                    Description := TEncoding.BigEndianUnicode.GetString(Bytes);
                end else begin
                    Description := TEncoding.Unicode.GetString(Bytes);
                end;
                //* Get the content
                Frames[FrameIndex].Stream.Read(DataBOM, 2);
                if DataBOM = $FEFF then begin
                    BigEndian := False;
                end;
                if DataBOM = $FFFE then begin
                    BigEndian := True;
                end;
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataWord, 2);
                    if (DataWord = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if DataWord <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 2);
                            Bytes[ByteCounter] := DataWord;
                            Inc(ByteCounter);
                            Bytes[ByteCounter] := DataWord SHR 8;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                if BigEndian then begin
                    Result := TEncoding.BigEndianUnicode.GetString(Bytes);
                end else begin
                    Result := TEncoding.Unicode.GetString(Bytes);
                end;
            end;
            2: begin
                //* Get description
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataWord, 2);
                    if DataWord <> 0 then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := DataWord;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := DataWord SHR 8;
                        Inc(ByteCounter);
                    end;
                until (DataWord = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.BigEndianUnicode.GetString(Bytes);
                //* Get the content
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(DataWord, 2);
                    if (DataWord = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if DataWord <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 2);
                            Bytes[ByteCounter] := DataWord;
                            Inc(ByteCounter);
                            Bytes[ByteCounter] := DataWord SHR 8;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                Result := TEncoding.BigEndianUnicode.GetString(Bytes);
            end;
            3: begin
                //* Get description
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if Data <> $0 then begin
                        SetLength(Bytes, Length(Bytes) + 1);
                        Bytes[ByteCounter] := Data;
                        Inc(ByteCounter);
                    end;
                until (Data = 0)
                OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                Description := TEncoding.UTF8.GetString(Bytes);
                //* Get the content
                SetLength(Bytes, 0);
                ByteCounter := 0;
                repeat
                    Frames[FrameIndex].Stream.Read(Data, 1);
                    if (Data = 0)
                    AND (Frames[FrameIndex].Stream.Position <> Frames[FrameIndex].Stream.Size)
                    then begin
                        SetLength(Bytes, Length(Bytes) + 2);
                        Bytes[ByteCounter] := 13;
                        Inc(ByteCounter);
                        Bytes[ByteCounter] := 10;
                        Inc(ByteCounter);
                    end else begin
                        if Data <> 0 then begin
                            SetLength(Bytes, Length(Bytes) + 1);
                            Bytes[ByteCounter] := Data;
                            Inc(ByteCounter);
                        end;
                    end;
                until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
                Result := TEncoding.UTF8.GetString(Bytes);
            end;
        end;
    except
        //*
    end;
end;

function TID3v2Tag.GetUnicodeUserDefinedTextInformationMultiple(FrameIndex: Integer; var Description: String; List: TStrings): Boolean;
var
    Text: String;
begin
    List.Clear;
    Text := GetUnicodeUserDefinedTextInformation(FrameIndex, Description);
    List.Text := Text;
    Result := List.Text <> '';
end;

function TID3v2Tag.GetUnicodeUserDefinedTextInformationMultiple(FrameID: String; var Description: String; List: TStrings): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    List.Clear;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeUserDefinedTextInformationMultiple(Index, Description, List);
end;

function TID3v2Tag.SetUserDefinedTextInformation(FrameID: String; Description: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUserDefinedTextInformation(Index, Description, Text);
end;

function TID3v2Tag.SetUserDefinedTextInformation(FrameIndex: Integer; Description: String; Text: String): Boolean;
var
    Data: Byte;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set UTF-8 flag
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        {$IFDEF NEXTGEN}
        for i := 0 to Length(Description) - 1 do begin
        {$ELSE}
        for i := 1 to Length(Description) do begin
        {$ENDIF}
            Data := Ord(Description[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the user defined text
        {$IFDEF NEXTGEN}
        for i := 0 to Length(Text) - 1 do begin
        {$ELSE}
        for i := 1 to Length(Text) do begin
        {$ENDIF}
            Data := Ord(Text[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeUserDefinedTextInformationMultiple(FrameIndex: Integer; Description: String; List: TStrings): Boolean;
var
    Data: Byte;
    Text: String;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* BOM
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        Frames[FrameIndex].Stream.Write(PWideChar(Description)^, (Length(Description) + 1) * 2);
        //* BOM
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the user defined text
        for i := 0 to List.Count - 1  do begin
            Text := List[i];
            Frames[FrameIndex].Stream.Write(PWideChar(Text)^, (Length(Text) + 1) * 2);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeUserDefinedTextInformationMultiple(FrameID: String; Description: String; List: TStrings): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeUserDefinedTextInformationMultiple(Index, Description, List);
end;

function TID3v2Tag.SetUTF8UserDefinedTextInformation(FrameID: String; Description: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUTF8UserDefinedTextInformation(Index, Description, Text);
end;

function TID3v2Tag.SetUTF8UserDefinedTextInformation(FrameIndex: Integer; Description: String; Text: String): Boolean;
var
    Data: Byte;
    Bytes: TBytes;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set UTF-8 flag
        Data := $03;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        Bytes := TEncoding.UTF8.GetBytes(Description);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the user defined text
        SetLength(Bytes, 0);
        Bytes := TEncoding.UTF8.GetBytes(Text);
        Frames[FrameIndex].Stream.Write(Bytes[0], Length(Bytes));
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeUserDefinedTextInformation(FrameID: String; Description: String; Text: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUnicodeUserDefinedTextInformation(Index, Description, Text);
end;

function TID3v2Tag.SetUnicodeUserDefinedTextInformation(FrameIndex: Integer; Description: String; Text: String): Boolean;
var
    Data: Byte;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Set unicode flag
        Data := $01;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* BOM
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Set the description
        Frames[FrameIndex].Stream.Write(PWideChar(Description)^, (Length(Description) + 1) * 2);
        //* BOM
        Data := $FF;
        Frames[FrameIndex].Stream.Write(Data, 1);
        Data := $FE;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the user defined text
        Frames[FrameIndex].Stream.Write(PWideChar(Text)^, (Length(Text) + 1) * 2);
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetPopularimeter(FrameIndex: Integer; var Email: String; var Rating: Byte; var PlayCounter: Cardinal): Boolean;
var
    Data: Byte;
    i: Integer;
begin
    Result := False;
    Email := '';
    Rating := 0;
    PlayCounter := 0;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get e-mail
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> $0 then begin
                Email := Email + Char(Data);
            end;
        until (Data = 0)
        OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
        //* Get rating
        Frames[FrameIndex].Stream.Read(Data, 1);
        Rating := Data;
        //* Get playcount
        if Frames[FrameIndex].Stream.Position < Frames[FrameIndex].Stream.Size then begin
            for i := 0 to 3 do begin
                PlayCounter := PlayCounter SHL 8;
                Frames[FrameIndex].Stream.Read(Data, 1);
                PlayCounter := PlayCounter + Data;
            end;
        end;
        Result := True;
    except
        //*
    end;
end;


function TID3v2Tag.FindPopularimeter(Email: String; var Rating: Byte; var PlayCounter: Cardinal): Integer;
var
    i: Integer;
    FrameEmail: String;
    FrameID: TFrameID;
begin
    Result := - 1;
    ConvertString2FrameID('POPM', FrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, FrameID) then begin
            if GetPopularimeter(i, FrameEmail, Rating, PlayCounter) then begin
                if FrameEmail = Email then begin
                    Result := i;
                    Break;
                end else begin
                    Rating := 0;
                    PlayCounter := 0;
                end;
            end;
        end;
    end;
end;

function TID3v2Tag.SetPopularimeterByEmail(Email: String; Rating: Byte; PlayCounter: Cardinal = 0): Boolean;
var
    i: Integer;
    GetEmail: String;
    GetRating: Byte;
    GetPlayCounter: Cardinal;
    Index: Integer;
    FrameID: TFrameID;
begin
    Index := - 1;
    ConvertString2FrameID('POPM', FrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, FrameID) then begin
            if GetPopularimeter(i, GetEmail, GetRating, GetPlayCounter) then begin
                if GetEmail = Email then begin
                    Index := i;
                    Break;
                end;
            end;
        end;
    end;
    if Index = - 1 then begin
        Index := AddFrame('POPM');
    end;
    Result := SetPopularimeter(Index, Email, Rating, PlayCounter);
end;

function TID3v2Tag.SetPopularimeter(FrameIndex: Integer; Email: String; Rating: Byte; PlayCounter: Cardinal): Boolean;
var
    Data: Byte;
    Value: Cardinal;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Write e-mail
        {$IFDEF NEXTGEN}
        for i := 0 to Length(Email) - 1 do begin
        {$ELSE}
        for i := 1 to Length(Email) do begin
        {$ENDIF}
            Data := Ord(Email[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Data := 0;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write rating
        Frames[FrameIndex].Stream.Write(Rating, 1);
        //* Write playcount
        if PlayCounter > 0 then begin
            Value := PlayCounter SHR 24;
            Data := Value;
            Frames[FrameIndex].Stream.Write(Data, 1);
            Value := PlayCounter SHL 8;
            Value := Value SHR 24;
            Data := Value;
            Frames[FrameIndex].Stream.Write(Data, 1);
            Value := PlayCounter SHL 16;
            Value := Value SHR 24;
            Data := Value;
            Frames[FrameIndex].Stream.Write(Data, 1);
            Value := PlayCounter SHL 24;
            Value := Value SHR 24;
            Data := Value;
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.FindTXXXByDescription(Description: String; var Text: String): Integer;
var
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetLanguageID: TLanguageID;
    GetContent: String;
begin
    Result := - 1;
    ConvertString2FrameID('TXXX', FrameID);
    FillChar(GetLanguageID, SizeOf(GetLanguageID), 0);
    GetDescription := '';
    Text := '';
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            GetContent := GetUnicodeUserDefinedTextInformation(i, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                Text := GetContent;
                Result := i;
                Break;
            end;
        end;
    end;
end;

function TID3v2Tag.FindTXXXByDescriptionMultiple(Description: String; List: TStrings): Integer;
var
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetLanguageID: TLanguageID;
    GetContent: String;
begin
    Result := - 1;
    List.Clear;
    ConvertString2FrameID('TXXX', FrameID);
    FillChar(GetLanguageID, SizeOf(GetLanguageID), 0);
    GetDescription := '';
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            GetContent := GetUnicodeUserDefinedTextInformation(i, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                List.Text := GetContent;
                Result := i;
                Break;
            end;
        end;
    end;
end;

function TID3v2Tag.SetUnicodeTXXXByDescription(Description: String; Text: String): Boolean;
var
    Index: Integer;
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetLanguageID: TLanguageID;
    GetContent: String;
begin
    Index := - 1;
    ConvertString2FrameID('TXXX', FrameID);
    FillChar(GetLanguageID, SizeOf(GetLanguageID), 0);
    GetDescription := '';
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            GetContent := GetUnicodeUserDefinedTextInformation(i, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                Index := i;
                Break;
            end;
        end;
    end;
    if Index = - 1 then begin
        Index := AddFrame('TXXX');
    end;
    Result := SetUnicodeTXXX(Index, Description, Text);
end;

function TID3v2Tag.SetUnicodeTXXXByDescriptionMultiple(Description: String; List: TStrings): Boolean;
var
    Index: Integer;
    FrameID: TFrameID;
    i: Integer;
    GetDescription: String;
    GetLanguageID: TLanguageID;
    GetContent: String;
begin
    Index := - 1;
    ConvertString2FrameID('TXXX', FrameID);
    FillChar(GetLanguageID, SizeOf(GetLanguageID), 0);
    GetDescription := '';
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(FrameID, Frames[i].ID) then begin
            GetContent := GetUnicodeUserDefinedTextInformation(i, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                Index := i;
                Break;
            end;
        end;
    end;
    if Index = - 1 then begin
        Index := AddFrame('TXXX');
    end;
    Result := SetUnicodeUserDefinedTextInformationMultiple(Index, Description, List);
end;

function TID3v2Tag.SetUnicodeTXXX(Index: Integer; Description: String; Text: String): Boolean;
var
    Data: Byte;
begin
    Result := False;
    if (Index >= FrameCount)
    OR (Index < 0)
    then begin
        Exit;
    end;
    try
        Frames[Index].Stream.Clear;
        Data := $01;
        Frames[Index].Stream.Write(Data, 1);
        Data := $FF;
        Frames[Index].Stream.Write(Data, 1);
        Data := $FE;
        Frames[Index].Stream.Write(Data, 1);
        Frames[Index].Stream.Write(PWideChar(Description)^, (Length(Description) + 1) * 2);
        Data := $FF;
        Frames[Index].Stream.Write(Data, 1);
        Data := $FE;
        Frames[Index].Stream.Write(Data, 1);
        Frames[Index].Stream.Write(PWideChar(Text)^, (Length(Text) + 1) * 2);
        Frames[Index].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function TID3v2Tag.GetUnicodeListFrame(FrameID: String; var List: TStrings): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    List.Clear;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUnicodeListFrame(Index, List);
end;

function TID3v2Tag.GetUnicodeListFrame(FrameIndex: Integer; var List: TStrings): Boolean;
var
    Data: Byte;
    UData: Word;
    Name: String;
    Value: String;
    EncodingFormat: Byte;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := False;
    List.Clear;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        //* Get encoding format
        Frames[FrameIndex].Stream.Read(EncodingFormat, 1);
        //* Get decription and content
        case EncodingFormat of
            0: begin
                repeat
                    Name := '';
                    Value := '';
                    repeat
                        Frames[FrameIndex].Stream.Read(Data, 1);
                        if Data <> $0 then begin
                            Name := Name + Char(Data);
                        end;
                    until (Data = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    repeat
                        Frames[FrameIndex].Stream.Read(Data, 1);
                        if Data <> $0 then begin
                            Value := Value + Char(Data);
                        end;
                    until (Data = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    List.Append(Name + '=' + Value);
                    Result := True;
                until (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            1: begin
                Frames[FrameIndex].Stream.Seek(2, soCurrent);
                repeat
                    Name := '';
                    Value := '';
                    repeat
                        Frames[FrameIndex].Stream.Read(UData, 2);
                        if UData <> $0 then begin
                            Name := Name + Char(UData);
                        end;
                    until (UData = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    repeat
                        Frames[FrameIndex].Stream.Read(UData, 2);
                        if UData <> $0 then begin
                            Value := Value + Char(UData);
                        end;
                    until (UData = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    List.Append(Name + '=' + Value);
                    Result := True;
                until (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            2: begin
                repeat
                    Name := '';
                    Value := '';
                    repeat
                        Frames[FrameIndex].Stream.Read(UData, 2);
                        if UData <> $0 then begin
                            Name := Name + Char(UData);
                        end;
                    until (UData = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    repeat
                        Frames[FrameIndex].Stream.Read(UData, 2);
                        if UData <> $0 then begin
                            Value := Value + Char(UData);
                        end;
                    until (UData = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    List.Append(Name + '=' + Value);
                    Result := True;
                until (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
            3: begin
                repeat
                    Name := '';
                    Value := '';
                    SetLength(Bytes, 0);
                    ByteCounter := 0;
                    repeat
                        Frames[FrameIndex].Stream.Read(Data, 1);
                        if Data <> $0 then begin
                            SetLength(Bytes, Length(Bytes) + 1);
                            Bytes[ByteCounter] := Data;
                            Inc(ByteCounter);
                        end;
                    until (Data = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    Name := TEncoding.UTF8.GetString(Bytes);
                    SetLength(Bytes, 0);
                    ByteCounter := 0;
                    repeat
                        Frames[FrameIndex].Stream.Read(Data, 1);
                        if Data <> $0 then begin
                            SetLength(Bytes, Length(Bytes) + 1);
                            Bytes[ByteCounter] := Data;
                            Inc(ByteCounter);
                        end;
                    until (Data = 0)
                    OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
                    Value := TEncoding.UTF8.GetString(Bytes);
                    List.Append(Name + '=' + Value);
                    Result := True;
                until (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
            end;
        end;
    except
        //*
    end;
end;

function TID3v2Tag.SetUnicodeListFrame(FrameID: String; List: TStrings): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(FrameID);
    end;
    Result := SetUnicodeListFrame(Index, List);
end;

function TID3v2Tag.SetUnicodeListFrame(Index: Integer; List: TStrings): Boolean;
var
    Data: Byte;
    i: Integer;
    Name: String;
    Value: String;
begin
    Result := False;
    if (Index >= FrameCount)
    OR (Index < 0)
    then begin
        Exit;
    end;
    try
        Frames[Index].Stream.Clear;
        Data := $01;
        Frames[Index].Stream.Write(Data, 1);
        Data := $FF;
        Frames[Index].Stream.Write(Data, 1);
        Data := $FE;
        Frames[Index].Stream.Write(Data, 1);
        for i := 0 to List.Count - 1 do begin
            Name := List.Names[i];
            Value := List.ValueFromIndex[i];
            Frames[Index].Stream.Write(PWideChar(Name)^, (Length(Name) + 1) * 2);
            Frames[Index].Stream.Write(PWideChar(Value)^, (Length(Value) + 1) * 2);
        end;
        Frames[Index].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

procedure TID3v2Tag.Assign(ID3v2Tag: TID3v2Tag);
var
    i: Integer;
    Index: Integer;
begin
    Clear;
    FileName := ID3v2Tag.FileName;
    Loaded := ID3v2Tag.Loaded;
    MajorVersion := ID3v2Tag.MajorVersion;
    MinorVersion := ID3v2Tag.MinorVersion;
    Flags := ID3v2Tag.Flags;
    Unsynchronised := ID3v2Tag.Unsynchronised;
    ExtendedHeader := ID3v2Tag.ExtendedHeader;
    Experimental := ID3v2Tag.Experimental;
    FooterPresent := ID3v2Tag.FooterPresent;
    Size := ID3v2Tag.Size;
    PaddingSize := ID3v2Tag.PaddingSize;
    PaddingToWrite := ID3v2Tag.PaddingToWrite;
    FSourceFileType := ID3v2Tag.SourceFileType;
    for i := 0 to ID3v2Tag.FrameCount - 1 do begin
        Index := AddFrame(ID3v2Tag.Frames[i].ID);
        Frames[Index].Assign(ID3v2Tag.Frames[i]);
    end;
    WAVInfo := ID3v2Tag.WAVInfo;
    DSFInfo.Assign(ID3v2Tag.DSFInfo);
    FPlayTime := ID3v2Tag.PlayTime;
    SampleCount := ID3v2Tag.SampleCount;
    BitRate := ID3v2Tag.BitRate;
end;

function TID3v2Tag.GetUFID(FrameID: String; var OwnerIdentifier: String): String;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := '';
    OwnerIdentifier := '';
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Exit;
    end;
    Result := GetUFID(Index, OwnerIdentifier);
end;

function TID3v2Tag.FindUFIDByOwnerIdentifier(OwnerIdentifier: String; var Identifier: String): Integer;
var
    FrameID: TFrameID;
    i: Integer;
    GetOwnerIdentifier: String;
    GetIdentifier: String;
begin
    Result := - 1;
    Identifier := '';
    ConvertString2FrameID('UFID', FrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, FrameID) then begin
            GetIdentifier := GetUFID(i, GetOwnerIdentifier);
            if UpperCase(GetOwnerIdentifier) = UpperCase(OwnerIdentifier) then begin
                Result := i;
                Identifier := GetIdentifier;
                Break;
            end;
        end;
    end;
end;

function TID3v2Tag.SetUFIDByOwnerIdentifier(OwnerIdentifier: String; Identifier: String): Boolean;
var
    FrameID: TFrameID;
    i: Integer;
    GetOwnerIdentifier: String;
    GetIdentifier: String;
    Index: Integer;
begin
    Index := - 1;
    ConvertString2FrameID('UFID', FrameID);
    for i := 0 to FrameCount - 1 do begin
        if IsSameFrameID(Frames[i].ID, FrameID) then begin
            GetIdentifier := GetUFID(i, GetOwnerIdentifier);
            if UpperCase(GetOwnerIdentifier) = UpperCase(OwnerIdentifier) then begin
                Index := i;
                Break;
            end;
        end;
    end;
    if Index = - 1 then begin
        Index := AddFrame(FrameID);
    end;
    Result := SetUFID(Index, OwnerIdentifier, Identifier);
end;

function TID3v2Tag.GetUFID(FrameIndex: Integer; var OwnerIdentifier: String): String;
var
    Data: Byte;
begin
    Result := '';
    OwnerIdentifier := '';
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        if Frames[FrameIndex].Stream.Size = 0 then begin
            Exit;
        end;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> $0 then begin
                OwnerIdentifier := OwnerIdentifier + Char(Data);
            end;
        until (Data = 0)
        OR (Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size);
        repeat
            Frames[FrameIndex].Stream.Read(Data, 1);
            if Data <> $0 then begin
                Result := Result + Char(Data);
            end;
        until Frames[FrameIndex].Stream.Position >= Frames[FrameIndex].Stream.Size;
        Frames[FrameIndex].Stream.Seek(0, soBeginning);
    except
        //*
    end;
end;

function TID3v2Tag.SetUFID(FrameID: String; OwnerIdentifier: String; Identifier: String): Boolean;
var
    Index: Integer;
    ID: TFrameID;
begin
    Result := False;
    AnsiStringToPAnsiChar(FrameID, ID);
    Index := FrameExists(ID);
    if Index < 0 then begin
        Index := AddFrame(ID);
        if Index < 0 then begin
            Exit;
        end;
    end;
    Result := SetUFID(Index, OwnerIdentifier, Identifier);
end;

function TID3v2Tag.SetUFID(FrameIndex: Integer; OwnerIdentifier: String; Identifier: String): Boolean;
var
    Data: Byte;
    i: Integer;
begin
    Result := False;
    if (FrameIndex >= FrameCount)
    OR (FrameIndex < 0)
    then begin
        Exit;
    end;
    try
        Frames[FrameIndex].Stream.Clear;
        //* Write the Owner Identifier
        {$IFDEF NEXTGEN}
        for i := 0 to Length(OwnerIdentifier) - 1 do begin
        {$ELSE}
        for i := 1 to Length(OwnerIdentifier) do begin
        {$ENDIF}
            Data := Ord(OwnerIdentifier[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Data := $00;
        Frames[FrameIndex].Stream.Write(Data, 1);
        //* Write the Identifier
        {$IFDEF NEXTGEN}
        for i := 0 to Length(Identifier) - 1 do begin
        {$ELSE}
        for i := 1 to Length(Identifier) do begin
        {$ENDIF}
            Data := Ord(Identifier[i]);
            Frames[FrameIndex].Stream.Write(Data, 1);
        end;
        Frames[FrameIndex].Stream.Seek(0, soFromBeginning);
        Result := True;
    except
        //*
    end;
end;

function ID3v2TagErrorCode2String(ErrorCode: Integer): String;
begin
    Result := 'Unknown error code.';
    case ErrorCode of
        ID3V2LIBRARY_SUCCESS: Result := 'Success.';
        ID3V2LIBRARY_ERROR: Result := 'Unknown error occured.';
        ID3V2LIBRARY_ERROR_NO_TAG_FOUND: Result := 'No ID3v2 tag found.';
        ID3V2LIBRARY_ERROR_EMPTY_TAG: Result := 'ID3v2 tag is empty.';
        ID3V2LIBRARY_ERROR_EMPTY_FRAMES: Result := 'ID3v2 tag contains only empty frames.';
        ID3V2LIBRARY_ERROR_OPENING_FILE: Result := 'Error opening file.';
        ID3V2LIBRARY_ERROR_READING_FILE: Result := 'Error reading file.';
        ID3V2LIBRARY_ERROR_WRITING_FILE: Result := 'Error writing file.';
        ID3V2LIBRARY_ERROR_CORRUPT: Result := 'Error: corrupt file.';
        ID3V2LIBRARY_ERROR_DOESNT_FIT: Result := 'Error: ID3v2 tag doesn''t fit into the file.';
        ID3V2LIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := 'Error: not supported ID3v2 version.';
        ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := 'Error not supported file format.';
        ID3V2LIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := 'Error: file is locked. Need exclusive access to write ID3v2 tag to this file.';
    end;
end;

function ValidID3v2FrameID(FrameID: TFrameID): Boolean;
var
    FrameIDChar: Char;
    i: Integer;
begin
    Result := True;
    for i := 0 to 3 do begin
        FrameIDChar := Char(FrameID[i]);
        //if NOT (FrameIDChar in ['A'..'Z'] + ['0'..'9']) then begin
        if NOT (((Ord(FrameIDChar) >= Ord('A')) AND (Ord(FrameIDChar) <= Ord('Z')))
        OR ((Ord(FrameIDChar) >= Ord('0')) AND (Ord(FrameIDChar) <= Ord('9'))))
        then begin
            Result := False;
            Break;
        end;
    end;
end;

function ValidID3v2FrameID2(FrameID: TFrameID): Boolean;
var
    FrameIDChar: Char;
    i: Integer;
begin
    Result := True;
    for i := 0 to 2 do begin
        FrameIDChar := Char(FrameID[i]);
        //if NOT (FrameIDChar in ['A'..'Z'] + ['0'..'9']) then begin
        if NOT (((Ord(FrameIDChar) >= Ord('A')) AND (Ord(FrameIDChar) <= Ord('Z')))
        OR ((Ord(FrameIDChar) >= Ord('0')) AND (Ord(FrameIDChar) <= Ord('9'))))
        then begin
            Result := False;
            Break;
        end;
    end;
end;

function GetID3v2FrameType(FrameID: TFrameID): TID3v2FrameType;
var
    TestForFrameID: TFrameID;
begin
    Result := ftBinary;

    if Char(FrameID[0]) = 'T' then begin
        Result := ftText;
    end;

    ConvertString2FrameID('TXXX', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID)
    //* TODO: all specified frames
    then begin
        Result := ftTextWithDescription;
    end;

    ConvertString2FrameID('COMM', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftTextWithDescriptionAndLangugageID;
    end;

    ConvertString2FrameID('USLT', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftTextWithDescriptionAndLangugageID;
    end;

    ConvertString2FrameID('TIPL', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftTextList;
    end;

    ConvertString2FrameID('TMCL', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftTextList;
    end;

    if Char(FrameID[0]) = 'W' then begin
        Result := ftURL;
    end;

    ConvertString2FrameID('WXXX', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftUserDefinedURL;
    end;

    ConvertString2FrameID('SESC', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftBinary;
    end;
    ConvertString2FrameID('SEBR', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftBinary;
    end;
    ConvertString2FrameID('SEFC', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftBinary;
    end;
    ConvertString2FrameID('GEOB', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftBinary;
    end;
    ConvertString2FrameID('APIC', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftBinary;
    end;
    ConvertString2FrameID('PCNT', TestForFrameID);
    if IsSameFrameID(FrameID, TestForFrameID) then begin
        Result := ftPlayCount;
    end;
end;

procedure ConvertString2FrameID(StringFrameID: String; var FrameID: TFrameID);
begin
    {$IFDEF NEXTGEN}
    FrameID[0] := Ord(StringFrameID[0]);
    FrameID[1] := Ord(StringFrameID[1]);
    FrameID[2] := Ord(StringFrameID[2]);
    FrameID[3] := Ord(StringFrameID[3]);
    {$ELSE}
    FrameID[0] := Ord(StringFrameID[1]);
    FrameID[1] := Ord(StringFrameID[2]);
    FrameID[2] := Ord(StringFrameID[3]);
    FrameID[3] := Ord(StringFrameID[4]);
    {$ENDIF}
end;

function ConvertFrameID2String(FrameID: TFrameID): String;
begin
    Result := Char(FrameID[0]) + Char(FrameID[1]) + Char(FrameID[2]) + Char(FrameID[3]);
end;

function IsSameFrameID(FrameID1: TFrameID; FrameID2: TFrameID): Boolean;
begin
    if (FrameID1[0] = FrameID2[0])
    AND (FrameID1[1] = FrameID2[1])
    AND (FrameID1[2] = FrameID2[2])
    AND (FrameID1[3] = FrameID2[3])
    then begin
        Result := True;
    end else begin
        Result := False;
    end;
end;

function IsSameFrameID(FrameID: TFrameID; StringFrameID: String): Boolean;
begin
    {$IFDEF NEXTGEN}
    if (FrameID[0] = Ord(StringFrameID[0]))
    AND (FrameID[1] = Ord(StringFrameID[1]))
    AND (FrameID[2] = Ord(StringFrameID[2]))
    AND (FrameID[3] = Ord(StringFrameID[3]))
    {$ELSE}
    if (FrameID[0] = Ord(StringFrameID[1]))
    AND (FrameID[1] = Ord(StringFrameID[2]))
    AND (FrameID[2] = Ord(StringFrameID[3]))
    AND (FrameID[3] = Ord(StringFrameID[4]))
    {$ENDIF}
    then begin
        Result := True;
    end else begin
        Result := False;
    end;
end;

function GetID3v2Size(PMemory: Pointer): Cardinal; overload;
type
    TID3v2Header = packed record
        ID: array [1..3] of Byte;
        Version: Byte;
        Revision: Byte;
        Flags: Byte;
        Size: Cardinal;
    end;
var
    Header: TID3v2Header;
begin
    // Get ID3v2 tag size (if exists)
    Result := 0;
    Move(PMemory^, Header, SizeOf(TID3v2Header));
    if (Header.ID[1] = Ord('I'))
    AND (Header.ID[2] = Ord('D'))
    AND (Header.ID[3] = Ord('3'))
    then begin
        UnSyncSafe(Header.Size, 4, Result);
        Inc(Result, 10);
    end;
end;

function GetID3v2Size(Stream: TStream): Cardinal; overload;
type
    TID3v2Header = packed record
        ID: array [1..3] of Byte;
        Version: Byte;
        Revision: Byte;
        Flags: Byte;
        Size: Cardinal;
    end;
var
    PreviousPosition: Int64;
    Header: TID3v2Header;
begin
    // Get ID3v2 tag size (if exists)
    Result := 0;
    PreviousPosition := Stream.Position;
    try
        Stream.Read(Pointer(@Header)^, SizeOf(TID3v2Header));
        if (Header.ID[1] = Ord('I'))
        AND (Header.ID[2] = Ord('D'))
        AND (Header.ID[3] = Ord('3'))
        then begin
            UnSyncSafe(Header.Size, 4, Result);
            Inc(Result, 10);
        end;
    finally
        Stream.Seek(PreviousPosition, soBeginning);
    end;
end;

function ValidRIFF(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
begin
    Result := False;
    PreviousPosition := TagStream.Position;
    try
        try
            TagStream.Seek(0, soBeginning);
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = RIFFID[0])
            AND (Identification[1] = RIFFID[1])
            AND (Identification[2] = RIFFID[2])
            AND (Identification[3] = RIFFID[3])
            then begin
                TagStream.Read(RIFFChunkSize, 4);
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = RIFFWAVEID[0])
                AND (ChunkID[1] = RIFFWAVEID[1])
                AND (ChunkID[2] = RIFFWAVEID[2])
                AND (ChunkID[3] = RIFFWAVEID[3])
                then begin
                    Result := True;
                    ChunkSize := 0;
                    while TagStream.Position < TagStream.Size do begin
                        TagStream.Read(ChunkID, 4);
                        TagStream.Read(ChunkSize, 4);
                        TagStream.Seek(ChunkSize, soCurrent);
                        if TagStream.Position > TagStream.Size then begin
                            Result := False;
                            Exit;
                        end;
                    end;
                end;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function ValidRF64(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
    RIFFChunkSize: DWord;
    ChunkID: TRIFFChunkID;
    ChunkSize: DWord;
    Waveds64: TWaveds64;
    //RF64Size: Int64;
begin
    Result := False;
    //RF64Size := 0;
    PreviousPosition := TagStream.Position;
    try
        try
            TagStream.Seek(0, soBeginning);
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = RF64ID[0])
            AND (Identification[1] = RF64ID[1])
            AND (Identification[2] = RF64ID[2])
            AND (Identification[3] = RF64ID[3])
            then begin
                TagStream.Read(RIFFChunkSize, 4);
                TagStream.Read(ChunkID, 4);
                if (ChunkID[0] = RIFFWAVEID[0])
                AND (ChunkID[1] = RIFFWAVEID[1])
                AND (ChunkID[2] = RIFFWAVEID[2])
                AND (ChunkID[3] = RIFFWAVEID[3])
                AND (RIFFChunkSize = $FFFFFFFF)
                then begin
                    TagStream.Read(ChunkID, 4);
                    if (ChunkID[0] = Ord('d'))
                    AND (ChunkID[1] = Ord('s'))
                    AND (ChunkID[2] = Ord('6'))
                    AND (ChunkID[3] = Ord('4'))
                    then begin
                        TagStream.Read(Waveds64, SizeOf(TWaveds64));
                        //RF64Size := MakeInt64(Waveds64.RIFFSizeLow, Waveds64.RIFFSizeHigh);
                        TagStream.Seek(Waveds64.ds64Size - SizeOf(TWaveds64) + 4 {table?}, soCurrent);
                    end;
                    Result := True;
                    ChunkSize := 0;
                    while TagStream.Position < TagStream.Size do begin
                        TagStream.Read(ChunkID, 4);
                        TagStream.Read(ChunkSize, 4);
                        if ((ChunkID[0] = Ord('d'))
                        AND (ChunkID[1] = Ord('a'))
                        AND (ChunkID[2] = Ord('t'))
                        AND (ChunkID[3] = Ord('a')))
                        AND (ChunkSize = $FFFFFFFF)
                        then begin
                            TagStream.Seek(MakeInt64(Waveds64.DataSizeLow, Waveds64.DataSizeHigh), soCurrent);
                        end else begin
                            TagStream.Seek(ChunkSize, soCurrent);
                        end;
                        if TagStream.Position > TagStream.Size then begin
                            Result := False;
                            Exit;
                        end;
                    end;
                end;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function ValidDSF(TagStream: TStream): Boolean;
var
    PreviousPosition: Int64;
    Identification: TRIFFID;
    DSFSize: UInt64;
begin
    Result := False;
    PreviousPosition := TagStream.Position;
    try
        try
            TagStream.Seek(0, soBeginning);
            FillChar(Identification, SizeOf(TRIFFID), 0);
            TagStream.Read(Identification[0], 4);
            if (Identification[0] = DSFID[0])
            AND (Identification[1] = DSFID[1])
            AND (Identification[2] = DSFID[2])
            AND (Identification[3] = DSFID[3])
            then begin
                Result := True;
                TagStream.Seek(8, soCurrent);
                TagStream.Read(DSFSize, 8);
                if DSFSize > TagStream.Size then begin
                    Result := False;
                    Exit;
                end;
            end;
        except
            Result := False;
        end;
    finally
        TagStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function TID3v2Tag.SaveDSF(TagStream: TStream; WriteTagTotalSize: Cardinal): Integer;
var
    TempStream: TFileStream;
    TagSize: DWord;
    ID3v2Pointer: UInt64;
    DSFFileSize: UInt64;
begin
    TempStream := nil;
    try
        TagSize := SeekDSF(TagStream);
        //* Update DSF file size
        TagStream.Seek(12, soBeginning);
        TagStream.Read(DSFFileSize, 8);
        Dec(DSFFileSize, TagSize);
        Inc(DSFFileSize, WriteTagTotalSize);
        TagStream.Seek(- 8, soCurrent);
        TagStream.Write(DSFFileSize, 8);
        //* Update ID3v2 pointer
        TagStream.Read(ID3v2Pointer, 8);
        if ID3v2Pointer = 0 then begin
            ID3v2Pointer := DSFFileSize - WriteTagTotalSize;
            TagStream.Seek(- 8, soCurrent);
            TagStream.Write(ID3v2Pointer, 8);
        end;
        //* Check if there is tail data
        TagStream.Seek(ID3v2Pointer, soBeginning);
        if TagStream.Position + TagSize < TagStream.Size then begin
            try
                TempStream := TFileStream.Create(ChangeFileExt(FileName, '.tmp'), fmCreate);
            except
                Result := ID3V2LIBRARY_ERROR_WRITING_FILE;
                Exit;
            end;
            TagStream.Seek(ID3v2Pointer + TagSize, soBeginning);
            TempStream.CopyFrom(TagStream, TagStream.Size - TagStream.Position);
        end;
        //* Save ID3v2 tag at ID3v2 pointer
        TagStream.Seek(ID3v2Pointer, soBeginning);
        //* Save the ID3v2 tag
        SaveTagToStream(TagStream, 0);
        //* Set end of file
        TagStream.Size := TagStream.Position;
        //* Copy remaining data if have it
        if Assigned(TempStream) then begin
            TempStream.Seek(0, soBeginning);
            TagStream.CopyFrom(TempStream, TempStream.Size);
            FreeAndNil(TempStream);
            SysUtils.DeleteFile(ChangeFileExt(FileName, '.tmp'));
        end;
        Result := ID3V2LIBRARY_SUCCESS;
    except
        Result := ID3V2LIBRARY_ERROR;
    end;
end;

{ TDSFInfo }

procedure TDSFInfo.Assign(DSFInfo: TDSFInfo);
begin
    FormatVersion := DSFInfo.FormatVersion;
    FormatID := DSFInfo.FormatID;
    ChannelType := DSFInfo.ChannelType;
    ChannelNumber := DSFInfo.ChannelNumber;
    SamplingFrequency := DSFInfo.SamplingFrequency;
    BitsPerSample := DSFInfo.BitsPerSample;
    SampleCount := DSFInfo.SampleCount;
    BlockSizePerChannel := DSFInfo.BlockSizePerChannel;
    PlayTime := DSFInfo.PlayTime;
end;

procedure TDSFInfo.Clear;
begin
    FormatVersion := 0;
    FormatID := 0;
    ChannelType := dsfctUnknown;
    ChannelNumber := 0;
    SamplingFrequency := 0;
    BitsPerSample := 0;
    SampleCount := 0;
    BlockSizePerChannel := 0;
    PlayTime := 0;
end;

function TDSFInfo.GetBitRate: Integer;
begin
    Result := Round((((SampleCount * ChannelNumber * BitsPerSample) / 8) / PlayTime) / 125);
end;

function TID3v2Tag.GetWAVEInformation(Stream: TStream): TWaveFmt;
var
    SourceHeader: TWaveHeader;
    ChunkIdent: TRIFFChunkID;
    ChunkSize: DWord;
    SourceISRF64: Boolean;
    Sourceds64: TWaveds64;
    PreviousPosition: Int64;
    DataSize32: DWord;
begin
    PreviousPosition := Stream.Position;
    try
        Stream.Seek(0, soBeginning);
        //* Check if WAV or RF64
        Stream.Read(SourceHeader, SizeOf(TWaveHeader));
        //* Check if RF64
        SourceISRF64 := (SourceHeader.ident1[0] = RF64ID[0])
            AND (SourceHeader.ident1[1] = RF64ID[1])
            AND (SourceHeader.ident1[2] = RF64ID[2])
            AND (SourceHeader.ident1[3] = RF64ID[3])
        ;
        //* Check WAVE
        Stream.Read(ChunkIdent, 4);
        if (ChunkIdent[0] <> RIFFWAVEID[0])
        OR (ChunkIdent[1] <> RIFFWAVEID[1])
        OR (ChunkIdent[2] <> RIFFWAVEID[2])
        OR (ChunkIdent[3] <> RIFFWAVEID[3])
        then begin
            Exit;
        end;
        //* If RF64 then there's a ds64 chunk
        if SourceISRF64 then begin
            Stream.Read(ChunkIdent, 4);
            if (ChunkIdent[0] = Ord('d'))
            AND (ChunkIdent[1] = Ord('s'))
            AND (ChunkIdent[2] = Ord('6'))
            AND (ChunkIdent[3] = Ord('4'))
            then begin
                Stream.Read(Sourceds64, SizeOf(TWaveds64));
                //DataSize := MakeInt64(Sourceds64.DataSizeLow, Sourceds64.DataSizeHigh);
                SampleCount := MakeInt64(Sourceds64.SampleCountLow, Sourceds64.SampleCountHigh);
                Stream.Seek(Sourceds64.ds64Size - SizeOf(TWaveds64) + 4, soCurrent);
            end;
        end;
        //* Search for 'fmt '
        repeat
            Stream.Read(ChunkIdent, 4);
            if (ChunkIdent[0] <> Ord('f'))
            OR (ChunkIdent[1] <> Ord('m'))
            OR (ChunkIdent[2] <> Ord('t'))
            OR (ChunkIdent[3] <> Ord(' '))
            then begin
                //* Not it, go to next chunk
                Stream.Read(ChunkSize, 4);
                Stream.Seek(ChunkSize, soCurrent);
            end;
        until ((ChunkIdent[0] = Ord('f'))
            AND (ChunkIdent[1] = Ord('m'))
            AND (ChunkIdent[2] = Ord('t'))
            AND (ChunkIdent[3] = Ord(' ')))
        OR (Stream.Position >= Stream.Size);
        //* We are at 'fmt ' position, read the content
        Stream.Read(Result, SizeOf(TWaveFmt));
        //* If this is not a WAVE_FORMAT_EXTENSIBLE chunk clear this part
        if Result.FormatTag <> $FFFE then begin
            Result.cbSize := 0;
            Result.ValidBitsPerSample := 0;
            Result.ChannelMask := 0;
            FillChar(Result.SubFormat[0], SizeOf(Result.SubFormat), 0);
            Stream.Seek(- 24, soCurrent);
        end;
        //* Search for the 'data' chunk
        repeat
            Stream.Read(ChunkIdent, 4);
            if (ChunkIdent[0] <> Ord('d'))
            OR (ChunkIdent[1] <> Ord('a'))
            OR (ChunkIdent[2] <> Ord('t'))
            OR (ChunkIdent[3] <> Ord('a'))
            then begin
                //* Not it, go to next chunk
                Stream.Read(ChunkSize, 4);
                Stream.Seek(ChunkSize, soCurrent);
            end;
        until ((ChunkIdent[0] = Ord('d'))
            AND (ChunkIdent[1] = Ord('a'))
            AND (ChunkIdent[2] = Ord('t'))
            AND (ChunkIdent[3] = Ord('a')))
        OR (Stream.Position >= Stream.Size);
        //* We are at 'data' position, read the size
        Stream.Read(DataSize32, 4);
        //* If ordinary WAV use the chunk data size as the 'data size'
        if NOT SourceISRF64 then begin
            SampleCount := DataSize32 div Result.BlockAlign;
        end;
        //* Calculate play time
        FPlayTime := SampleCount / Result.SamplesPerSec;
        //* Calculate bit rate
        BitRate := Result.AvgBytesPerSec div 125;
    finally
        Stream.Seek(PreviousPosition, soBeginning);
    end;
end;

procedure TID3v2Tag.LoadWAVEAttributes(Stream: TStream);
begin
    FillChar(Self.WAVInfo, SizeOf(TWaveFmt), 0);
    Self.WAVInfo := GetWAVEInformation(Stream);
end;

function TID3v2Tag.MPEGProcessHeader(MPEGStream: TStream): TMPEGHeader;
var
    Data: Byte;
    Header: Longword;
    TmpHdr: Longword;
    Padding: Byte;
    PreviousPosition: Int64;
begin
    FillChar(Result, SizeOf(TMPEGHeader), 0);
    PreviousPosition := MPEGStream.Position;
    try
        Result.Position := MPEGStream.Position;
        MPEGStream.Read(Data, 1);
        Header := Data;
        MPEGStream.Read(Data, 1);
        Header := (Header SHL 8) OR Data;
        MPEGStream.Read(Data, 1);
        Header := (Header SHL 8) OR Data;
        MPEGStream.Read(Data, 1);
        Header := (Header SHL 8) OR Data;

        Result.Header := Header;

        TmpHdr := ((Header shl 11) shr 30);
        case TmpHdr of
            $0: Result.Version := tmpegv25;
            $1: Result.Version := tmpegvUnknown;           // Reserved
            $2: Result.Version := tmpegv2;
            $3: Result.Version := tmpegv1;
        end;
        TmpHdr := ((Header shl 13) shr 30);
        case TmpHdr of
            $0: Result.Layer := tmpeglUnknown;             // Reserved
            $1: Result.Layer := tmpegl3;
            $2: Result.Layer := tmpegl2;
            $3: Result.Layer := tmpegl1;
        end;
        TmpHdr := ((Header shl 15) shr 31);
        case TmpHdr of
            $0: Result.CRC := True;
            $1: Result.CRC := False;
        end;
        TmpHdr := ((Header shl 16) shr 28);
        if Result.Version = tmpegv1 then begin
            if Result.Layer = tmpegl3 then begin
                case TmpHdr of
                    $0: Result.BitRate := 65535;           // Free bitrate
                    $1: Result.BitRate := 32;
                    $2: Result.BitRate := 40;
                    $3: Result.BitRate := 48;
                    $4: Result.BitRate := 56;
                    $5: Result.BitRate := 64;
                    $6: Result.BitRate := 80;
                    $7: Result.BitRate := 96;
                    $8: Result.BitRate := 112;
                    $9: Result.BitRate := 128;
                    $A: Result.BitRate := 160;
                    $B: Result.BitRate := 192;
                    $C: Result.BitRate := 224;
                    $D: Result.BitRate := 256;
                    $E: Result.BitRate := 320;
                    $F: Result.BitRate := 0;               // Bad bitrate
                end;
            end;
            if Result.Layer = tmpegl2 then begin
                case TmpHdr of
                    $0: Result.BitRate := 65535;           // Free bitrate
                    $1: Result.BitRate := 32;
                    $2: Result.BitRate := 48;
                    $3: Result.BitRate := 56;
                    $4: Result.BitRate := 64;
                    $5: Result.BitRate := 80;
                    $6: Result.BitRate := 96;
                    $7: Result.BitRate := 112;
                    $8: Result.BitRate := 128;
                    $9: Result.BitRate := 160;
                    $A: Result.BitRate := 192;
                    $B: Result.BitRate := 224;
                    $C: Result.BitRate := 256;
                    $D: Result.BitRate := 320;
                    $E: Result.BitRate := 384;
                    $F: Result.BitRate := 0;               // Bad bitrate
                end;
            end;
            if Result.Layer = tmpegl1 then begin
                case TmpHdr of
                    $0: Result.BitRate := 65535;           // Free bitrate
                    $1: Result.BitRate := 32;
                    $2: Result.BitRate := 64;
                    $3: Result.BitRate := 96;
                    $4: Result.BitRate := 128;
                    $5: Result.BitRate := 160;
                    $6: Result.BitRate := 192;
                    $7: Result.BitRate := 224;
                    $8: Result.BitRate := 256;
                    $9: Result.BitRate := 288;
                    $A: Result.BitRate := 320;
                    $B: Result.BitRate := 352;
                    $C: Result.BitRate := 384;
                    $D: Result.BitRate := 416;
                    $E: Result.BitRate := 448;
                    $F: Result.BitRate := 0;               // Bad bitrate
                end;
            end;
            TmpHdr := ((Header shl 20) shr 30);
            case TmpHdr of
                $0: Result.SampleRate := 44100;
                $1: Result.SampleRate := 48000;
                $2: Result.SampleRate := 32000;
                $3: Result.SampleRate := 0;                // Reserved
            end;
        end;
        if (Result.Version = tmpegv2) OR (Result.Version = tmpegv25) then begin
            if (Result.Layer = tmpegl3) OR (Result.Layer = tmpegl2) then begin
                case TmpHdr of
                    $0: Result.BitRate := 65535;            // Free bitrate
                    $1: Result.BitRate := 8;
                    $2: Result.BitRate := 16;
                    $3: Result.BitRate := 24;
                    $4: Result.BitRate := 32;
                    $5: Result.BitRate := 40;
                    $6: Result.BitRate := 48;
                    $7: Result.BitRate := 56;
                    $8: Result.BitRate := 64;
                    $9: Result.BitRate := 80;
                    $A: Result.BitRate := 96;
                    $B: Result.BitRate := 112;
                    $C: Result.BitRate := 128;
                    $D: Result.BitRate := 144;
                    $E: Result.BitRate := 160;
                    $F: Result.BitRate := 0;                // Bad bitrate
                end;
            end;
            if Result.Layer = tmpegl1 then begin
                case TmpHdr of
                    $0: Result.BitRate := 65535;            // Free bitrate
                    $1: Result.BitRate := 32;
                    $2: Result.BitRate := 48;
                    $3: Result.BitRate := 56;
                    $4: Result.BitRate := 64;
                    $5: Result.BitRate := 80;
                    $6: Result.BitRate := 96;
                    $7: Result.BitRate := 112;
                    $8: Result.BitRate := 128;
                    $9: Result.BitRate := 144;
                    $A: Result.BitRate := 160;
                    $B: Result.BitRate := 176;
                    $C: Result.BitRate := 192;
                    $D: Result.BitRate := 224;
                    $E: Result.BitRate := 256;
                    $F: Result.BitRate := 0;                // Bad bitrate
                end;
            end;
            TmpHdr := ((Header shl 20) shr 30);
            if (Result.Version = tmpegv2) then begin
                case TmpHdr of
                    $0: Result.SampleRate := 22050;
                    $1: Result.SampleRate := 24000;
                    $2: Result.SampleRate := 16000;
                    $3: Result.SampleRate := 0;             // Reserved
                end;
            end;
            if (Result.Version = tmpegv25) then begin
                case TmpHdr of
                    $0: Result.SampleRate := 32000;
                    $1: Result.SampleRate := 16000;
                    $2: Result.SampleRate := 8000;
                    $3: Result.SampleRate := 0;             // Reserved
                end;
            end;
        end;
        TmpHdr := ((Header shl 22) shr 31);
        case TmpHdr of
            $0: Result.Padding := False;
            $1: Result.Padding := True;
        end;
        TmpHdr := ((Header shl 23) shr 31);
        case TmpHdr of
            $0: Result._Private := False;
            $1: Result._Private := True;
        end;
        TmpHdr := ((Header shl 24) shr 30);
        case TmpHdr of
            $0: begin
                Result.ChannelMode := tmpegcmStereo;
                Result.ModeExtension := tmpegmeNone;
            end;
            $1: begin
                Result.ChannelMode := tmpegcmJointStereo;
                TmpHdr := ((Header shl 26) shr 30);
                case TmpHdr of
                    $0: Result.ModeExtension := tmpegmeNone;
                    $1: Result.ModeExtension := tmpegmeIntensity;
                    $2: Result.ModeExtension := tmpegmeMS;
                    $3: Result.ModeExtension := tmpegmeIntensityMS;
                end;
            end;
            $2: begin
                Result.ChannelMode := tmpegcmDualChannel;
                Result.ModeExtension := tmpegmeNone;
            end;
            $3: begin
                Result.ChannelMode := tmpegcmMono;
                Result.ModeExtension := tmpegmeNone;
            end;
        end;
        TmpHdr := ((Header shl 28) shr 31);
        case TmpHdr of
            $0: Result.Copyrighted := False;
            $1: Result.Copyrighted := True;
        end;
        TmpHdr := ((Header shl 29) shr 31);
        case TmpHdr of
            $0: Result.Original := False;
            $1: Result.Original := True;
        end;
        TmpHdr := ((Header shl 30) shr 30);
        case TmpHdr of
            $0: Result.Emphasis := tmpegeNo;
            $1: Result.Emphasis := tmpege5015;
            $2: Result.Emphasis := tmpegeUnknown;
            $3: Result.Emphasis := tmpegeCCITJ17;
        end;
        if Result.Padding
            then Padding := 1
            else Padding := 0;
        try
            if (Result.Version = tmpegv1) then begin
                if Result.SampleRate <> 0 then begin
                    if Result.Layer = tmpegl1
                        then Result.FrameSize := Trunc((24000 * Result.BitRate / Result.SampleRate) + Padding);
                    if (Result.Layer = tmpegl2)
                    OR (Result.Layer = tmpegl3)
                        then Result.FrameSize := Trunc((144000 * Result.BitRate / Result.SampleRate ) + Padding);
                end else Result.FrameSize := 0;
            end;
            if (Result.Version = tmpegv2)
            OR (Result.Version = tmpegv25)
            then begin
                if Result.SampleRate <> 0 then begin
                    if Result.Layer = tmpegl1
                        then Result.FrameSize := Trunc((24000 * Result.BitRate / Result.SampleRate) + Padding);
                    if (Result.Layer = tmpegl2)
                    OR (Result.Layer = tmpegl3)
                        then Result.FrameSize := Trunc((72000 * Result.BitRate / Result.SampleRate) + Padding);
                end else Result.FrameSize := 0;
            end;
        except
            //* Devide by zero possible
        end;
    finally
        MPEGStream.Seek(PreviousPosition, soBeginning);
    end;
end;

function TID3v2Tag.GetAIFFInformation(Stream: TStream): TAIFFInformation;
var
    ChunkSize: DWord;
    PreviousPosition: Int64;
    ChunkID: TAIFFChunkID;
    AIFFSize: DWord;
    DataByte: Byte;
    DataWord: Word;
    DataDWord: DWord;
    {$IFDEF CPUX64}
    DataExtended: TExtendedX87;
    {$ELSE}
    DataExtended: Extended;
    {$ENDIF}
    AIFC: Boolean;
    i: Integer;
    DataSize: Int64;
    ChunksStartPosition: Int64;
    Bytes: TBytes;
begin
    DataSize := 0;
    PreviousPosition := Stream.Position;
    try
        Stream.Seek(0, soBeginning);
        //* Check if AIFF/AIFC
        Stream.Read(ChunkID, SizeOf(TAIFFChunkID));
        if ((ChunkID[0] = AIFFID[0])
        AND (ChunkID[1] = AIFFID[1])
        AND (ChunkID[2] = AIFFID[2])
        AND (ChunkID[3] = AIFFID[3]))
        then begin
            //* AIFF container size
            Stream.Read(AIFFSize, 4);
            AIFFSize := ReverseBytes(AIFFSize);
            //* Check if AIFC
            Stream.Read(ChunkID, SizeOf(TAIFFChunkID));
            if ((ChunkID[0] = AIFCChunkID[0])
            AND (ChunkID[1] = AIFCChunkID[1])
            AND (ChunkID[2] = AIFCChunkID[2])
            AND (ChunkID[3] = AIFCChunkID[3]))
            then begin
                AIFC := True;
            end else begin
                AIFC := False;
            end;
            //* If AIFF or AIFC continue
            if ((ChunkID[0] = AIFFChunkID[0])
            AND (ChunkID[1] = AIFFChunkID[1])
            AND (ChunkID[2] = AIFFChunkID[2])
            AND (ChunkID[3] = AIFFChunkID[3]))
            OR ((ChunkID[0] = AIFCChunkID[0])
            AND (ChunkID[1] = AIFCChunkID[1])
            AND (ChunkID[2] = AIFCChunkID[2])
            AND (ChunkID[3] = AIFCChunkID[3]))
            then begin
                //* Store chunks root position
                ChunksStartPosition := Stream.Position;
                //* Search for the COMM chunk
                repeat
                    Stream.Read(ChunkID, 4);
                    Stream.Read(ChunkSize, 4);
                    ChunkSize := ReverseBytes(ChunkSize);
                    if (ChunkID[0] <> Ord('C'))
                    OR (ChunkID[1] <> Ord('O'))
                    OR (ChunkID[2] <> Ord('M'))
                    OR (ChunkID[3] <> Ord('M'))
                    then begin
                        //* Go to next chunk
                        Stream.Seek(ChunkSize, soCurrent);
                    end else begin
                        //* Read in COMM content
                        Stream.Read(DataWord, 2);
                        Result.Channels := Swap16(DataWord);
                        Stream.Read(DataDWord, 4);
                        Result.SampleFrames := ReverseBytes(DataDWord);
                        Stream.Read(DataWord, 2);
                        Result.SampleSize := Swap16(DataWord);
                        Stream.Read(DataExtended, 10);
                        {$IFDEF CPUX64}
                        ReverseExtended(DataExtended, DataExtended);
                        {$ELSE}
                        {$IFDEF NEXTGEN}
                        //* Not supported
                        //ReverseExtended(DataExtended, DataExtended);
                        DataExtended := 0;
                        {$ELSE}
                        ReverseExtended(TExtendedBytes(DataExtended), TExtendedBytes(DataExtended));
                        {$ENDIF}
                        {$ENDIF}
                        Result.SampleRate := DataExtended;
                        //* If AIFC we have more content
                        if AIFC then begin
                            //* Read compression ID (4 chars)
                            Result.CompressionID := '';
                            for i := 1 to 4 do begin
                                Stream.Read(DataByte, 1);
                                Result.CompressionID := Result.CompressionID + Char(DataByte);
                            end;
                            //* Read compression description (string)
                            Stream.Read(DataByte, 1);
                            SetLength(Bytes, DataByte);
                            Stream.Read(Bytes[0], DataByte);
                            Result.Compression := TEncoding.ANSI.GetString(Bytes);
                        end;
                    end;
                until ((ChunkID[0] = Ord('C'))
                    AND (ChunkID[1] = Ord('O'))
                    AND (ChunkID[2] = Ord('M'))
                    AND (ChunkID[3] = Ord('M')))
                OR (Stream.Position >= AIFFSize);
                //* Go to root position to search for SSND
                Stream.Seek(ChunksStartPosition, soBeginning);
                //* Search for SSND
                repeat
                    Stream.Read(ChunkID, 4);
                    Stream.Read(ChunkSize, 4);
                    ChunkSize := ReverseBytes(ChunkSize);
                    if (ChunkID[0] <> Ord('S'))
                    OR (ChunkID[1] <> Ord('S'))
                    OR (ChunkID[2] <> Ord('N'))
                    OR (ChunkID[3] <> Ord('D'))
                    then begin
                        //* Go to next chunk
                        Stream.Seek(ChunkSize, soCurrent);
                    end else begin
                        //* We have the audio data size
                        DataSize := ChunkSize;
                    end;
                until ((ChunkID[0] = Ord('S'))
                    AND (ChunkID[1] = Ord('S'))
                    AND (ChunkID[2] = Ord('N'))
                    AND (ChunkID[3] = Ord('D')))
                OR (Stream.Position >= AIFFSize);
            end;
        end;
        //* Calculate play time
        FPlayTime := Result.SampleFrames / Result.SampleRate;
        //* Calculate bit rate
        BitRate := Trunc(DataSize/(125 * FPlayTime )+ 0.5); // bitrate (Kbps)
    finally
        Stream.Seek(PreviousPosition, soBeginning);
    end;
end;

function TID3v2Tag.GetMPEGHeaderInformation(Stream: TStream): Boolean;
Const
  //* "Xing"
  VBR_ID_1 = $58;
  VBR_ID_2 = $69;
  VBR_ID_3 = $6E;
  VBR_ID_4 = $67;
  //* "Info"
  CBR_ID_1 = $49;
  CBR_ID_2 = $6E;
  CBR_ID_3 = $66;
  CBR_ID_4 = $6F;
  //* "VBRI"
  VBRI_ID_1 = Ord('V');
  VBRI_ID_2 = Ord('B');
  VBRI_ID_3 = Ord('R');
  VBRI_ID_4 = Ord('I');
var
    PreviousPosition: Int64;
    DataByte: Byte;
    DataWord: Word;
    DataDWord: DWord;
    Flags: DWord;
    Offset: Int64;
begin
    //* Clear
    Result := False;
    MPEGInfo.VBR := False;
    MPEGInfo.FrameCount := 0;
    MPEGInfo.Quality := 0;
    MPEGInfo.Bytes := 0;
    //* Calculate info offset
    Offset := 0;
    case MPEGInfo.Version of
        //tmpegvUnknown: Exit;
        tmpegv1: begin
            case MPEGInfo.ChannelMode of
                //tmpegcmUnknown: Exit;
                tmpegcmMono: Offset := 17;
                tmpegcmDualChannel, tmpegcmJointStereo, tmpegcmStereo: Offset := 32;
            end;
        end;
        tmpegv2, tmpegv25: begin
            case MPEGInfo.ChannelMode of
                //tmpegcmUnknown: Exit;
                tmpegcmMono: Offset := 9;
                tmpegcmDualChannel, tmpegcmJointStereo, tmpegcmStereo: Offset := 17;
            end;
        end;
    end;
    //* Store current position in stream
    PreviousPosition := Stream.Position;
    try
        //* Check 'Xing'
        try
            Stream.Seek(4 + Offset, soCurrent);
            Stream.Read(DataByte, 1);
            if DataByte = VBR_ID_1 then begin
                Stream.Read(DataByte, 1);
                if DataByte = VBR_ID_2 then begin
                    Stream.Read(DataByte, 1);
                    if DataByte = VBR_ID_3 then begin
                        Stream.Read(DataByte, 1);
                        if DataByte = VBR_ID_4 then begin
                            MPEGInfo.VBR := True;
                            Stream.Read(Flags, 4);
                            Flags := ReverseBytes(Flags);
                            //* Total frames
                            if (Flags AND $1) > 0 then begin
                                Stream.Read(DataDWord, 4);
                                DataDWord := ReverseBytes(DataDWord);
                                MPEGInfo.FrameCount := DataDWord;
                            end;
                            //* Bytes
                            if (Flags AND $2) > 0 then begin
                                Stream.Read(DataDWord, 4);
                                DataDWord := ReverseBytes(DataDWord);
                                MPEGInfo.Bytes := DataDWord;
                            end;
                            //* TOC
                            if (Flags AND $4) > 0 then begin
                                Stream.Seek(100, soCurrent);
                            end;
                            //* Quality
                            if (Flags AND $8) > 0 then begin
                                Stream.Read(DataDWord, 4);
                                DataDWord := ReverseBytes(DataDWord);
                                MPEGInfo.Quality := DataDWord;
                            end;
                            Result := True;
                            Exit;
                        end;
                    end;
                end;
            end;
        finally
            Stream.Seek(PreviousPosition, soBeginning)
        end;
        //* Check 'Info'
        try
            Stream.Seek(4 + Offset, soCurrent);
            Stream.Read(DataByte, 1);
            if DataByte = CBR_ID_1 then begin
                Stream.Read(DataByte, 1);
                if DataByte = CBR_ID_2 then begin
                    Stream.Read(DataByte, 1);
                    if DataByte = CBR_ID_3 then begin
                        Stream.Read(DataByte, 1);
                        if DataByte = CBR_ID_4 then begin
                            MPEGInfo.VBR := True;
                            Stream.Read(Flags, 4);
                            Flags := ReverseBytes(Flags);
                            //* Total frames
                            if (Flags AND $1) > 0 then begin
                                Stream.Read(DataDWord, 4);
                                DataDWord := ReverseBytes(DataDWord);
                                MPEGInfo.FrameCount := DataDWord;
                            end;
                            //* Bytes
                            if (Flags AND $2) > 0 then begin
                                Stream.Read(DataDWord, 4);
                                DataDWord := ReverseBytes(DataDWord);
                                MPEGInfo.Bytes := DataDWord;
                            end;
                            //* TOC
                            if (Flags AND $4) > 0 then begin
                                Stream.Seek(100, soCurrent);
                            end;
                            //* Quality
                            if (Flags AND $8) > 0 then begin
                                Stream.Read(DataDWord, 4);
                                DataDWord := ReverseBytes(DataDWord);
                                MPEGInfo.Quality := DataDWord;
                            end;
                            Result := True;
                            Exit;
                        end;
                    end;
                end;
            end;
        finally
            Stream.Seek(PreviousPosition, soBeginning)
        end;
        //* Check 'VBRI'
        try
            Stream.Seek(4 + 32, soCurrent);
            Stream.Read(DataByte, 1);
            if DataByte = VBRI_ID_1 then begin
                Stream.Read(DataByte, 1);
                if DataByte = VBRI_ID_2 then begin
                    Stream.Read(DataByte, 1);
                    if DataByte = VBRI_ID_3 then begin
                        Stream.Read(DataByte, 1);
                        if DataByte = VBRI_ID_4 then begin
                            MPEGInfo.VBR := True;
                            //* Skip 'Version ID' and 'Delay'
                            Stream.Seek(4, soCurrent);
                            //* Quality
                            Stream.Read(DataWord, 2);
                            DataWord := Swap16(DataWord);
                            MPEGInfo.Quality := DataDWord;
                            //* Bytes
                            Stream.Read(DataDWord, 4);
                            DataDWord := ReverseBytes(DataDWord);
                            MPEGInfo.Bytes := DataDWord;
                            //* Total frames
                            Stream.Read(DataDWord, 4);
                            DataDWord := ReverseBytes(DataDWord);
                            MPEGInfo.FrameCount := DataDWord;
                            Result := True;
                            Exit;
                        end;
                    end;
                end;
            end;
        finally
            Stream.Seek(PreviousPosition, soBeginning)
        end;
    except
        Result := False;
    end;
end;

Initialization

    ID3v2ID[0] := Ord('I');
    ID3v2ID[1] := Ord('D');
    ID3v2ID[2] := Ord('3');

    RIFFID[0] := Ord('R');
    RIFFID[1] := Ord('I');
    RIFFID[2] := Ord('F');
    RIFFID[3] := Ord('F');

    RF64ID[0] := Ord('R');
    RF64ID[1] := Ord('F');
    RF64ID[2] := Ord('6');
    RF64ID[3] := Ord('4');

    RIFFWAVEID[0] := Ord('W');
    RIFFWAVEID[1] := Ord('A');
    RIFFWAVEID[2] := Ord('V');
    RIFFWAVEID[3] := Ord('E');

    RIFFID3v2ID[0] := Ord('i');
    RIFFID3v2ID[1] := Ord('d');
    RIFFID3v2ID[2] := Ord('3');
    RIFFID3v2ID[3] := Ord(' ');

    AIFFID[0] := Ord('F');
    AIFFID[1] := Ord('O');
    AIFFID[2] := Ord('R');
    AIFFID[3] := Ord('M');

    AIFFChunkID[0] := Ord('A');
    AIFFChunkID[1] := Ord('I');
    AIFFChunkID[2] := Ord('F');
    AIFFChunkID[3] := Ord('F');

    AIFCChunkID[0] := Ord('A');
    AIFCChunkID[1] := Ord('I');
    AIFCChunkID[2] := Ord('F');
    AIFCChunkID[3] := Ord('C');

    AIFFID3v2ID[0] := Ord('I');
    AIFFID3v2ID[1] := Ord('D');
    AIFFID3v2ID[2] := Ord('3');
    AIFFID3v2ID[3] := Ord(' ');

    DSFID[0] := Ord('D');
    DSFID[1] := Ord('S');
    DSFID[2] := Ord('D');
    DSFID[3] := Ord(' ');

    DSFfmt_ID[0] := Ord('f');
    DSFfmt_ID[1] := Ord('m');
    DSFfmt_ID[2] := Ord('t');
    DSFfmt_ID[3] := Ord(' ');

end.
