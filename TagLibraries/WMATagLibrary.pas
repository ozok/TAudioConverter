// ********************************************************************************************************************************
// *                                                                                                                              *
// *     WMA Tag Library 1.0.9.12 © 3delite 2013-2015                                                                             *
// *     See WMA Tag Library ReadMe.txt for details                                                                               *
// *                                                                                                                              *
// * Two licenses are available for commercial usage of this component:                                                           *
// * Shareware License: €25                                                                                                       *
// * Commercial License: €100                                                                                                     *
// *                                                                                                                              *
// *     http://www.shareit.com/product.html?productid=300579129                                                                  *
// *                                                                                                                              *
// * Using the component in free programs is free.                                                                                *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
// *                                                                                                                              *
// * This component is also available as a part of Tags Library:                                                                  *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
// *                                                                                                                              *
// * There is an ID3v2 Library available at:                                                                                      *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
// *                                                                                                                              *
// * and an MP4 Tag Library available at:                                                                                         *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
// *                                                                                                                              *
// * and an Ogg Vorbis and Opus Tag Library available at:                                                                         *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
// *                                                                                                                              *
// * and an APEv2 Tag Library available at:                                                                                       *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
// *                                                                                                                              *
// * and a Flac Tag Library available at:                                                                                         *
// *                                                                                                                              *
// *     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
// *                                                                                                                              *
// * and a WAV Tag Library available at:                                                                                          *
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

{
  WMA Tag Library is using some codes from:

  MetaData Example
  Loading & Editing Wma File Tags

  (C) 2004 Copyright Philip Hadar - Israel
  Philip@EverX.co.il
  WWW.EverX.co.il

  modifications / Delphi-Header by Chris Tr?ken
  Credits goes to Harold Oudshoorn for fixing that it will work fine under WMA-Codec 10

  (No MetaData.DLL is needed)

  Bug Fix it seams that sometimes the TagHeader will show wrong Durations
  Now the Duration is a simple Calculation (more acurate)
}

unit WMATagLibrary;

interface

uses
  SysUtils,
  Windows,
  // Dialogs,
  Classes;

Const
  WMATAGLIBRARY_SUCCESS = 0;
  WMATAGLIBRARY_ERROR = $FFFF;
  WMATAGLIBRARY_ERROR_FILENOTFOUND = 1;
  WMATAGLIBRARY_ERROR_COULDNTLOADDLL = 2;
  WMATAGLIBRARY_ERROR_COULDNOTCREATEMETADATAEDITOR = 3;
  WMATAGLIBRARY_ERROR_COULDNOTQIFORIWMHEADERINFO3 = 4;
  WMATAGLIBRARY_ERROR_COULDNOTQUERY_ATTRIBUTE_COUNT = 5;

type
  WMT_CODEC_INFO_TYPE = LongWord;

  WMT_ATTR_DATATYPE = (WMT_TYPE_DWORD, WMT_TYPE_STRING, WMT_TYPE_BINARY, WMT_TYPE_BOOL, WMT_TYPE_QWORD, WMT_TYPE_WORD, WMT_TYPE_GUID, WMT_TYPE_UNKNOWN);

  TWMTAttrDataType = WMT_ATTR_DATATYPE;

Const
  /// /////////////////////////////////////////////////////////////
  //
  // These are the special case attributes that give information
  // about the Windows Media file.
  //
  /// /////////////////////////////////////////////////////////////

  g_dwWMSpecialAttributes = 20;
  g_wszWMDuration: String = 'Duration';
  g_wszWMBitrate: String = 'Bitrate';
  g_wszWMSeekable: String = 'Seekable';
  g_wszWMStridable: String = 'Stridable';
  g_wszWMBroadcast: String = 'Broadcast';
  g_wszWMProtected: String = 'Is_Protected';
  g_wszWMTrusted: String = 'Is_Trusted';
  g_wszWMSignature_Name: String = 'Signature_Name';
  g_wszWMHasAudio: String = 'HasAudio';
  g_wszWMHasImage: String = 'HasImage';
  g_wszWMHasScript: String = 'HasScript';
  g_wszWMHasVideo: String = 'HasVideo';
  g_wszWMCurrentBitrate: String = 'CurrentBitrate';
  g_wszWMOptimalBitrate: String = 'OptimalBitrate';
  g_wszWMHasAttachedImages: String = 'HasAttachedImages';
  g_wszWMSkipBackward: String = 'Can_Skip_Backward';
  g_wszWMSkipForward: String = 'Can_Skip_Forward';
  g_wszWMNumberOfFrames: String = 'NumberOfFrames';
  g_wszWMFileSize: String = 'FileSize';
  g_wszWMHasArbitraryDataStream: String = 'HasArbitraryDataStream';
  g_wszWMHasFileTransferStream: String = 'HasFileTransferStream';
  g_wszWMContainerFormat: String = 'WM/ContainerFormat';

  /// /////////////////////////////////////////////////////////////
  //
  // The content description object supports 5 basic attributes.
  //
  /// /////////////////////////////////////////////////////////////

  g_dwWMContentAttributes = 5;
  g_wszWMTitle: String = 'Title';
  g_wszWMAuthor: String = 'Author';
  g_wszWMDescription: String = 'Description';
  g_wszWMRating: String = 'Rating';
  g_wszWMCopyright: String = 'Copyright';

  /// /////////////////////////////////////////////////////////////
  //
  // These are the additional attributes defined in the WM attribute
  // namespace that give information about the content.
  //
  /// /////////////////////////////////////////////////////////////

  g_wszWMAlbumTitle: String = 'WM/AlbumTitle';
  g_wszWMTrack: String = 'WM/Track';
  g_wszWMPromotionURL: String = 'WM/PromotionURL';
  g_wszWMAlbumCoverURL: String = 'WM/AlbumCoverURL';
  g_wszWMGenre: String = 'WM/Genre';
  g_wszWMYear: String = 'WM/Year';
  g_wszWMGenreID: String = 'WM/GenreID';
  g_wszWMMCDI: String = 'WM/MCDI';
  g_wszWMComposer: String = 'WM/Composer';
  g_wszWMLyrics: String = 'WM/Lyrics';
  g_wszWMTrackNumber: String = 'WM/TrackNumber';
  g_wszWMToolName: String = 'WM/ToolName';
  g_wszWMToolVersion: String = 'WM/ToolVersion';
  g_wszWMIsVBR: String = 'IsVBR';
  g_wszWMAlbumArtist: String = 'WM/AlbumArtist';

  /// /////////////////////////////////////////////////////////////
  //
  // Attributes introduced in V9
  //
  /// /////////////////////////////////////////////////////////////

  g_wszWMWriter: String = 'WM/Writer';
  g_wszWMConductor: String = 'WM/Conductor';
  g_wszWMProducer: String = 'WM/Producer';
  g_wszWMDirector: String = 'WM/Director';
  g_wszWMContentGroupDescription: String = 'WM/ContentGroupDescription';
  g_wszWMSubTitle: String = 'WM/SubTitle';
  g_wszWMPartOfSet: String = 'WM/PartOfSet';
  g_wszWMProtectionType: String = 'WM/ProtectionType';
  g_wszWMVideoHeight: String = 'WM/VideoHeight';
  g_wszWMVideoWidth: String = 'WM/VideoWidth';
  g_wszWMVideoFrameRate: String = 'WM/VideoFrameRate';
  g_wszWMMediaClassPrimaryID: String = 'WM/MediaClassPrimaryID';
  g_wszWMMediaClassSecondaryID: String = 'WM/MediaClassSecondaryID';
  g_wszWMPeriod: String = 'WM/Period';
  g_wszWMCategory: String = 'WM/Category';
  g_wszWMPicture: String = 'WM/Picture';
  g_wszWMLyrics_Synchronised: String = 'WM/Lyrics_Synchronised';
  g_wszWMOriginalLyricist: String = 'WM/OriginalLyricist';
  g_wszWMOriginalArtist: String = 'WM/OriginalArtist';
  g_wszWMOriginalAlbumTitle: String = 'WM/OriginalAlbumTitle';
  g_wszWMOriginalReleaseYear: String = 'WM/OriginalReleaseYear';
  g_wszWMOriginalFilename: String = 'WM/OriginalFilename';
  g_wszWMPublisher: String = 'WM/Publisher';
  g_wszWMEncodedBy: String = 'WM/EncodedBy';
  g_wszWMEncodingSettings: String = 'WM/EncodingSettings';
  g_wszWMEncodingTime: String = 'WM/EncodingTime';
  g_wszWMAuthorURL: String = 'WM/AuthorURL';
  g_wszWMUserWebURL: String = 'WM/UserWebURL';
  g_wszWMAudioFileURL: String = 'WM/AudioFileURL';
  g_wszWMAudioSourceURL: String = 'WM/AudioSourceURL';
  g_wszWMLanguage: String = 'WM/Language';
  g_wszWMParentalRating: String = 'WM/ParentalRating';
  g_wszWMBeatsPerMinute: String = 'WM/BeatsPerMinute';
  g_wszWMInitialKey: String = 'WM/InitialKey';
  g_wszWMMood: String = 'WM/Mood';
  g_wszWMText: String = 'WM/Text';
  g_wszWMDVDID: String = 'WM/DVDID';
  g_wszWMWMContentID: String = 'WM/WMContentID';
  g_wszWMWMCollectionID: String = 'WM/WMCollectionID';
  g_wszWMWMCollectionGroupID: String = 'WM/WMCollectionGroupID';
  g_wszWMUniqueFileIdentifier: String = 'WM/UniqueFileIdentifier';
  g_wszWMModifiedBy: String = 'WM/ModifiedBy';
  g_wszWMRadioStationName: String = 'WM/RadioStationName';
  g_wszWMRadioStationOwner: String = 'WM/RadioStationOwner';
  g_wszWMPlaylistDelay: String = 'WM/PlaylistDelay';
  g_wszWMCodec: String = 'WM/Codec';
  g_wszWMDRM: String = 'WM/DRM';
  g_wszWMISRC: String = 'WM/ISRC';
  g_wszWMProvider: String = 'WM/Provider';
  g_wszWMProviderRating: String = 'WM/ProviderRating';
  g_wszWMProviderStyle: String = 'WM/ProviderStyle';
  g_wszWMContentDistributor: String = 'WM/ContentDistributor';
  g_wszWMSubscriptionContentID: String = 'WM/SubscriptionContentID';
  g_wszWMWMADRCPeakReference: String = 'WM/WMADRCPeakReference';
  g_wszWMWMADRCPeakTarget: String = 'WM/WMADRCPeakTarget';
  g_wszWMWMADRCAverageReference: String = 'WM/WMADRCAverageReference';
  g_wszWMWMADRCAverageTarget: String = 'WM/WMADRCAverageTarget';

  /// /////////////////////////////////////////////////////////////
  //
  // Attributes introduced in V10
  //
  /// /////////////////////////////////////////////////////////////

  g_wszWMStreamTypeInfo: String = 'WM/StreamTypeInfo';
  g_wszWMPeakBitrate: String = 'WM/PeakBitrate';
  g_wszWMASFPacketCount: String = 'WM/ASFPacketCount';
  g_wszWMASFSecurityObjectsSize: String = 'WM/ASFSecurityObjectsSize';
  g_wszWMSharedUserRating: String = 'WM/SharedUserRating';
  g_wszWMSubTitleDescription: String = 'WM/SubTitleDescription';
  g_wszWMMediaCredits: String = 'WM/MediaCredits';
  g_wszWMParentalRatingReason: String = 'WM/ParentalRatingReason';
  g_wszWMOriginalReleaseTime: String = 'WM/OriginalReleaseTime';
  g_wszWMMediaStationCallSign: String = 'WM/MediaStationCallSign';
  g_wszWMMediaStationName: String = 'WM/MediaStationName';
  g_wszWMMediaNetworkAffiliation: String = 'WM/MediaNetworkAffiliation';
  g_wszWMMediaOriginalChannel: String = 'WM/MediaOriginalChannel';
  g_wszWMMediaOriginalBroadcastDateTime: String = 'WM/MediaOriginalBroadcastDateTime';
  g_wszWMMediaIsStereo: String = 'WM/MediaIsStereo';
  g_wszWMVideoClosedCaptioning: String = 'WM/VideoClosedCaptioning';
  g_wszWMMediaIsRepeat: String = 'WM/MediaIsRepeat';
  g_wszWMMediaIsLive: String = 'WM/MediaIsLive';
  g_wszWMMediaIsTape: String = 'WM/MediaIsTape';
  g_wszWMMediaIsDelay: String = 'WM/MediaIsDelay';
  g_wszWMMediaIsSubtitled: String = 'WM/MediaIsSubtitled';
  g_wszWMMediaIsPremiere: String = 'WM/MediaIsPremiere';
  g_wszWMMediaIsFinale: String = 'WM/MediaIsFinale';
  g_wszWMMediaIsSAP: String = 'WM/MediaIsSAP';
  g_wszWMProviderCopyright: String = 'WM/ProviderCopyright';

  /// /////////////////////////////////////////////////////////////
  //
  // Attributes introduced in V11
  //
  /// /////////////////////////////////////////////////////////////

  g_wszWMISAN: String = 'WM/ISAN';
  g_wszWMADID: String = 'WM/ADID';
  g_wszWMWMShadowFileSourceFileType: String = 'WM/WMShadowFileSourceFileType';
  g_wszWMWMShadowFileSourceDRMType: String = 'WM/WMShadowFileSourceDRMType';
  g_wszWMWMCPDistributor: String = 'WM/WMCPDistributor';
  g_wszWMWMCPDistributorID: String = 'WM/WMCPDistributorID';
  g_wszWMSeasonNumber: String = 'WM/SeasonNumber';
  g_wszWMEpisodeNumber: String = 'WM/EpisodeNumber';

  /// /////////////////////////////////////////////////////////////
  //
  // Attributes by 3delite
  //
  /// /////////////////////////////////////////////////////////////

  g_wszMusicBrainzAlbumType: String = 'MusicBrainz/Album Type';
  g_wszWMReleaseYear: String = 'WM/ReleaseYear';
  g_wszWMStudio: String = 'WM/Studio';
  g_wszWMProduced: String = 'WM/Produced';
  g_wszWMCatalogNo: String = 'WM/CatalogNo';
  g_wszWMSetSubTitle: String = 'WM/SetSubTitle';
  g_wszWMPartOfSeries: String = 'WM/PartOfSeries';
  g_wszWMMedia: String = 'WM/Media';
  g_wszWMArranger: String = 'WM/Arranger';
  g_wszWMEngineer: String = 'WM/Engineer';
  g_wszWMDJMixer: String = 'WM/DJMixer';
  g_wszWMMixer: String = 'WM/Mixer';
  g_wszWMPopularity: String = 'WM/Popularity';
  g_wszWMQuality: String = 'WM/Quality';
  g_wszWMSituation: String = 'WM/Situation';
  g_wszWMPreference: String = 'WM/Preference';
  g_wszWMTempo: String = 'WM/Tempo';
  g_wszWMArtistSortOrder: String = 'WM/ArtistSortOrder';
  g_wszWMTitleSortOrder: String = 'WM/TitleSortOrder';
  g_wszWMAlbumArtistSortOrder: String = 'WM/AlbumArtistSortOrder';
  g_wszWMAlbumSortOrder: String = 'WM/AlbumSortOrder';
  g_wszWMOriginalTitle: String = 'WM/OriginalTitle';
  g_wszWMBuyCDURL: String = 'WM/BuyCDURL';
  g_wszWMPublisherURL: String = 'WM/PublisherURL';
  g_wszWMRadioURL: String = 'WM/RadioURL';
  g_wszWMCopyrightURL: String = 'CopyrightURL';
  g_wszWMPaymentURL: String = 'WM/PaymentURL';
  g_wszWMFileOwner: String = 'WM/FileOwner';
  g_wszWMPlaycount: String = 'WM/Playcount';
  g_wszWMInvolvedPeople: String = 'WM/TIPL';
  g_wszWMMusicianCredits: String = 'WM/TMCL';

const
  IID_IWMMetadataEditor: TGUID = '{96406bd9-2b2b-11d3-b36b-00c04f6108ff}';
  IID_IWMHeaderInfo: TGUID = '{96406bda-2b2b-11d3-b36b-00c04f6108ff}';
  IID_IWMHeaderInfo3: TGUID = '{15CC68E3-27CC-4ecd-B222-3F5D02D80BD5}';
  IID_IWMHeaderInfo2: TGUID = '{15cf9781-454e-482e-b393-85fae487a810}';

  LibNameWMVCORE = 'WMVCORE.DLL';

type
  IWMMetadataEditor = interface(IUnknown)
    ['{96406BD9-2B2B-11d3-B36B-00C04F6108FF}']
    function Open(pwszFilename: PWideChar): HRESULT; stdcall;
    function Close: HRESULT; stdcall;
    function Flush: HRESULT; stdcall;
  end;

type
  IWMHeaderInfo = interface(IUnknown)
    ['{96406BDA-2B2B-11d3-B36B-00C04F6108FF}']
    function GetAttributeCount(wStreamNum: Word; out pcAttributes: Word): HRESULT; stdcall;
    function GetAttributeByIndex(wIndex: Word; var pwStreamNum: Word; pwszName: PWideChar; var pcchNameLen: Word; out pType: TWMTAttrDataType; pValue: PBYTE; var pcbLength: Word): HRESULT; stdcall;
    function GetAttributeByName(var pwStreamNum: Word; pszName: PWideChar; out pType: TWMTAttrDataType; pValue: PBYTE; var pcbLength: Word): HRESULT; stdcall;
    function SetAttribute(wStreamNum: Word; pszName: PWideChar; Type_: TWMTAttrDataType; { in } pValue: PBYTE; cbLength: Word): HRESULT; stdcall;
    function GetMarkerCount(out pcMarkers: Word): HRESULT; stdcall;
    function GetMarker(wIndex: Word; pwszMarkerName: PWideChar; var pcchMarkerNameLen: Word; out pcnsMarkerTime: Int64): HRESULT; stdcall;
    function AddMarker(pwszMarkerName: PWideChar; cnsMarkerTime: Int64): HRESULT; stdcall;
    function RemoveMarker(wIndex: Word): HRESULT; stdcall;
    function GetScriptCount(out pcScripts: Word): HRESULT; stdcall;
    function GetScript(wIndex: Word; pwszType: PWideChar; var pcchTypeLen: Word; pwszCommand: PWideChar; var pcchCommandLen: Word; out pcnsScriptTime: Int64): HRESULT; stdcall;
    function AddScript(pwszType, pwszCommand: PWideChar; cnsScriptTime: Int64): HRESULT; stdcall;
    function RemoveScript(wIndex: Word): HRESULT; stdcall;
  end;

type
  IWMHeaderInfo2 = interface(IWMHeaderInfo)
    ['{15CF9781-454E-482e-B393-85FAE487A810}']
    function GetCodecInfoCount(out pcCodecInfos: LongWord): HRESULT; stdcall;
    function GetCodecInfo(wIndex: LongWord; var pcchName: Word; pwszName: PWideChar; var pcchDescription: Word; pwszDescription: PWideChar; out pCodecType: WMT_CODEC_INFO_TYPE; var pcbCodecInfo: Word;
      pbCodecInfo: PBYTE): HRESULT; stdcall;
  end;

type
  IWMHeaderInfo3 = interface(IWMHeaderInfo2)
    ['{15CC68E3-27CC-4ecd-B222-3F5D02D80BD5}']
    function GetAttributeCountEx(wStreamNum: Word; out pcAttributes: Word): HRESULT; stdcall;
    function GetAttributeIndices(wStreamNum: Word; pwszName: PWideChar; pwLangIndex: PWORD; pwIndices: PWORD; var pwCount: Word): HRESULT; stdcall;
    function GetAttributeByIndexEx(wStreamNum: Word; wIndex: Word; pwszName: PWideChar; var pwNameLen: Word; out pType: TWMTAttrDataType; out pwLangIndex: Word; pValue: PBYTE;
      var pdwDataLength: LongWord): HRESULT; stdcall;
    function ModifyAttribute(wStreamNum: Word; wIndex: Word; Type_: TWMTAttrDataType; wLangIndex: Word; pValue: PBYTE; dwLength: LongWord): HRESULT; stdcall;
    function AddAttribute(wStreamNum: Word; pszName: PWideChar; out pwIndex: Word; Type_: TWMTAttrDataType; wLangIndex: Word; pValue: PBYTE; dwLength: LongWord): HRESULT; stdcall;
    function DeleteAttribute(wStreamNum, wIndex: Word): HRESULT; stdcall;
    function AddCodecInfo(pwszName: PWideChar; pwszDescription: PWideChar; codecType: WMT_CODEC_INFO_TYPE; cbCodecInfo: Word; pbCodecInfo: PBYTE): HRESULT; stdcall;
  end;

type
  TWMATag = class;

  TWMATagFrame = class
  private
  public
    Name: String;
    Format: TWMTAttrDataType;
    Stream: TMemoryStream;
    Index: Integer;
    Parent: TWMATag;
    Constructor Create;
    Destructor Destroy; override;
    function GetAsText: String;
    function SetAsText(Text: String): Boolean;
    function GetAsList(var List: TStrings): Boolean;
    function SetAsList(List: TStrings): Boolean;
    function GetAsInteger: Int64;
    function SetAsInteger(Value: Int64; Format: TWMTAttrDataType): Boolean;
    function IsCoverArt: Boolean;
    procedure Clear;
    procedure Delete;
    function Assign(WMATagFrame: TWMATagFrame): Boolean;
  end;

  TWMATag = class
    FileName: String;
    Loaded: Boolean;
    Frames: Array of TWMATagFrame;
    function Count: Integer;
    function CoverArtCount: Integer;
    function LoadFromFile(FileName: String): Integer;
    function SaveToFile(FileName: String): Integer;
    function FrameExists(Name: String): Integer;
    function AddFrame(Name: String): TWMATagFrame;
    function ReadFrameByNameAsText(Name: String): String;
    function ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
    function ReadAsInteger(Name: String): Int64;
    procedure SetTextFrameText(Name: String; Text: String);
    procedure SetListFrameText(Name: String; List: TStrings);
    function SetAsInteger(Name: String; Value: Int64; Format: TWMTAttrDataType): Boolean;
    procedure Clear;
    function DeleteFrame(Index: Integer): Boolean;
    function DeleteFrameByName(Name: String): Boolean;
    procedure DeleteAllFrames;
    procedure DeleteAllCoverArts;
    function GetAttribIndex(Attrib: String): Integer;
    function LoadTags(FileName: String): Integer;
    function GetCoverArtFromFrame(Index: Integer; var PictureStream: TStream; var MIMEType: String; var PictureType: Byte; var Description: String): Boolean;
    function GetCoverArtInfo(Index: Integer; var MIMEType: String; var PictureType: Byte; var Description: String; var CoverArtSize: Cardinal): Boolean;
    function GetCoverArtInfoPointer(Index: Integer; var PictureType: Byte; var Data: Pointer; var DataSize: Integer; var Description: Pointer; var MIMEType: Pointer): Boolean;
    function AddCoverArtFrame(PictureStream: TStream; MIMEType: String; PictureType: Byte; Description: String): Integer;
    function SetCoverArtFrame(Index: Integer; PictureStream: TStream; MIMEType: String; PictureType: Byte; Description: String): Boolean;
    function ValidatePictureFrame(Index: Integer): Boolean;
    function Assign(Source: TWMATag): Boolean;
    function CalculateTagSize: Integer;
  private
    ppEditor: IWMMetadataEditor;
    ppHeaderInfo3: IWMHeaderInfo3;
    function GetDuration: Int64;
    function GetBitRate: Integer;
    function GetSeekable: Boolean;
    function GetStridable: Boolean;
    function GetBroadcast: Boolean;
    function GetIsProtected: Boolean;
    function GetIsTrusted: Boolean;
    function GetSignatureName: String;
    function GetHasAudio: Boolean;
    function GetHasImage: Boolean;
    function GetHasScript: Boolean;
    function GetHasVideo: Boolean;
    function GetCurrentBitrate: Integer;
    function GetOptimalBitrate: Integer;
    function GetHasAttachedImages: Boolean;
    function GetCanSkipBackward: Boolean;
    function GetCanSkipForward: Boolean;
    function GetNumberOfFrames: Int64;
    function GetFileSize: Int64;
    function GetHasArbitraryDataStream: Boolean;
    function GetHasFileTransferStream: Boolean;
    function GetContainerFormat: Boolean;
  public
    Destructor Destroy; override;
    property Duration: Int64 read GetDuration;
    property BitRate: Integer read GetBitRate;
    property Seekable: Boolean read GetSeekable;
    property Stridable: Boolean read GetStridable;
    property Broadcast: Boolean read GetBroadcast;
    property IsProtected: Boolean read GetIsProtected;
    property IsTrusted: Boolean read GetIsTrusted;
    property SignatureName: String read GetSignatureName;
    property HasAudio: Boolean read GetHasAudio;
    property HasImage: Boolean read GetHasImage;
    property HasScript: Boolean read GetHasScript;
    property HasVideo: Boolean read GetHasVideo;
    property CurrentBitrate: Integer read GetCurrentBitrate;
    property OptimalBitrate: Integer read GetOptimalBitrate;
    property HasAttachedImages: Boolean read GetHasAttachedImages;
    property CanSkipBackward: Boolean read GetCanSkipBackward;
    property CanSkipForward: Boolean read GetCanSkipForward;
    property NumberOfFrames: Int64 read GetNumberOfFrames;
    property FileSize: Int64 read GetFileSize;
    property HasArbitraryDataStream: Boolean read GetHasArbitraryDataStream;
    property HasFileTransferStream: Boolean read GetHasFileTransferStream;
    property ContainerFormat: Boolean read GetContainerFormat;
  end;

  PCardinal = ^Cardinal;

function DurationToStr(Duration: int64; ShowMs: Boolean): string;

function WMATagErrorCode2String(ErrorCode: Integer): String;

implementation

Uses
  ActiveX;

var
  DllHandleWMVCORE: THandle;
  _WMCreateEditor: function(out ppEditor: IWMMetadataEditor): HRESULT; stdcall;

Constructor TWMATagFrame.Create;
begin
  Inherited;
  Name := '';
  Stream := TMemoryStream.Create;
  Format := WMT_TYPE_UNKNOWN;
end;

procedure TWMATagFrame.Delete;
begin
  Parent.DeleteFrame(Index);
end;

Destructor TWMATagFrame.Destroy;
begin
  FreeAndNil(Stream);
  Inherited;
end;

function TWMATagFrame.GetAsText: String;
var
  i: Integer;
  Data: Word;
  Str: String;
begin
  Result := '';
  if Format = WMT_TYPE_STRING then
  begin
    Stream.Seek(0, soBeginning);
    for i := 0 to (Stream.Size div 2) - 1 do
    begin
      Stream.Read(Data, 2);
      if Data <> 0 then
      begin
        Str := Str + Char(Data);
      end;
    end;
    Stream.Seek(0, soBeginning);
    Result := Str;
  end
  else
  begin
    Result := IntToStr(GetAsInteger);
  end;
end;

function TWMATagFrame.IsCoverArt: Boolean;
begin
  Result := Name = g_wszWMPicture;
end;

function TWMATagFrame.SetAsText(Text: String): Boolean;
var
  OLEString: PWideChar;
begin
  try
    if Text = '' then
    begin
      OLEString := '';
    end
    else
    begin
      OLEString := StringToOleStr(Text);
    end;
    Stream.Clear;
    Stream.Write(Pointer(OLEString)^, (Length(OLEString) + 1) * 2);
    Stream.Seek(0, soBeginning);
    Format := WMT_TYPE_STRING;
    Result := True;
  except
    Result := False;
  end;
end;

function TWMATagFrame.SetAsInteger(Value: Int64; Format: TWMTAttrDataType): Boolean;
var
  ValueBool: DWord;
  ValueWord: Word;
  ValueDWord: DWord;
  ValueQWord: UInt64;
begin
  Result := False;
  Stream.Clear;
  case Format of
    WMT_TYPE_BOOL:
      begin
        ValueBool := Value;
        Stream.Write(ValueBool, 4);
        Self.Format := Format;
        Result := True;
      end;
    WMT_TYPE_DWORD:
      begin
        ValueDWord := Value;
        Stream.Write(ValueDWord, 4);
        Self.Format := Format;
        Result := True;
      end;
    WMT_TYPE_WORD:
      begin
        ValueWord := Value;
        Stream.Write(ValueWord, 2);
        Self.Format := Format;
        Result := True;
      end;
    WMT_TYPE_QWORD:
      begin
        ValueQWord := Value;
        Stream.Write(ValueQWord, 8);
        Self.Format := Format;
        Result := True;
      end;
    // WMT_TYPE_STRING: Stream.Read(Value, 4);
    // WMT_TYPE_BINARY: Stream.Read(Value, 4);
    // WMT_TYPE_GUID: Stream.Read(Value, 4);
    // WMT_TYPE_UNKNOWN
  end;
end;

function TWMATagFrame.SetAsList(List: TStrings): Boolean;
var
  i: Integer;
  Data: Byte;
  Name: String;
  Value: String;
begin
  try
    Stream.Clear;
    for i := 0 to List.Count - 1 do
    begin
      Name := List.Names[i];
      Value := List.ValueFromIndex[i];
      Stream.Write(Pointer(Name)^, Length(Name) * 2);
      Data := $0D;
      Stream.Write(Data, 1);
      Data := $0A;
      Stream.Write(Data, 1);
      Stream.Write(Pointer(Value)^, Length(Value) * 2);
      Data := $0D;
      Stream.Write(Data, 1);
      Data := $0A;
      Stream.Write(Data, 1);
    end;
    Stream.Seek(0, soBeginning);
    Format := WMT_TYPE_STRING;
    Result := True;
  except
    Result := False;
  end;
end;

function TWMATagFrame.GetAsInteger: Int64;
var
  Value: Int64;
begin
  Value := 0;
  Stream.Seek(0, soBeginning);
  case Format of
    WMT_TYPE_DWORD:
      Stream.Read(Value, 4);
    // WMT_TYPE_STRING: Stream.Read(Value, 4);
    // WMT_TYPE_BINARY: Stream.Read(Value, 4);
    WMT_TYPE_BOOL:
      Stream.Read(Value, 4);
    WMT_TYPE_QWORD:
      Stream.Read(Value, 8);
    WMT_TYPE_WORD:
      Stream.Read(Value, 2);
    // WMT_TYPE_GUID: Stream.Read(Value, 4);
    // WMT_TYPE_UNKNOWN
  end;
  Result := Value;
end;

function TWMATagFrame.GetAsList(var List: TStrings): Boolean;
var
  DataWord: Word;
  Str: String;
  Name: String;
  Value: String;
begin
  Result := False;
  List.Clear;
  if Format <> WMT_TYPE_STRING then
  begin
    Exit;
  end;
  Stream.Seek(0, soBeginning);
  while Stream.Position < Stream.Size do
  begin
    Str := '';
    repeat
      Stream.Read(DataWord, 2);
      if DataWord = $0A0D then
      begin
        Break;
      end;
      Str := Str + Char(DataWord);
    until Stream.Position >= Stream.Size;
    Name := Str;
    Str := '';
    repeat
      Stream.Read(DataWord, 2);
      if DataWord = $0A0D then
      begin
        Break;
      end;
      Str := Str + Char(DataWord);
    until Stream.Position >= Stream.Size;
    Value := Str;
    if (Trim(Name) <> '') AND (Trim(Value) <> '') then
    begin
      List.Append(Name + '=' + Value);
    end;
    Result := True;
  end;
  Stream.Seek(0, soBeginning);
end;

procedure TWMATagFrame.Clear;
begin
  Format := WMT_TYPE_UNKNOWN;
  Stream.Clear;
end;

function TWMATagFrame.Assign(WMATagFrame: TWMATagFrame): Boolean;
begin
  try
    Self.Clear;
    if WMATagFrame <> nil then
    begin
      Name := WMATagFrame.Name;
      Format := WMATagFrame.Format;
      WMATagFrame.Stream.Seek(0, soBeginning);
      Stream.CopyFrom(WMATagFrame.Stream, WMATagFrame.Stream.Size);
      Stream.Seek(0, soBeginning);
      WMATagFrame.Stream.Seek(0, soBeginning);
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TWMATag.Count: Integer;
begin
  Result := Length(Frames);
end;

function TWMATag.AddCoverArtFrame(PictureStream: TStream; MIMEType: String; PictureType: Byte; Description: String): Integer;
begin
  with AddFrame(g_wszWMPicture) do
  begin
    if SetCoverArtFrame(Index, PictureStream, MIMEType, PictureType, Description) then
    begin
      Result := Index;
    end
    else
    begin
      DeleteFrame(Index);
      Result := -1;
    end;
  end;
end;

function TWMATag.AddFrame(Name: String): TWMATagFrame;
begin
  Result := nil;
  try
    SetLength(Frames, Length(Frames) + 1);
    Frames[Length(Frames) - 1] := TWMATagFrame.Create;
    Frames[Length(Frames) - 1].Name := Name;
    Frames[Length(Frames) - 1].Index := Length(Frames) - 1;
    Frames[Length(Frames) - 1].Parent := Self;
    Result := Frames[Length(Frames) - 1];
  except
    // *
  end;
end;

function TWMATag.DeleteFrame(Index: Integer): Boolean;
var
  i: Integer;
  j: Integer;
begin
  Result := False;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  FreeAndNil(Frames[Index]);
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

function TWMATag.DeleteFrameByName(Name: String): Boolean;
var
  Index: Integer;
begin
  Result := False;
  Index := FrameExists(Name);
  if Index > -1 then
  begin
    Result := DeleteFrame(Index);
  end;
end;

destructor TWMATag.Destroy;
begin
  ppEditor := nil;
  ppHeaderInfo3 := nil;
  Clear;
  inherited;
end;

function TWMATag.FrameExists(Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  Name := UpperCase(Name);
  for i := 0 to Length(Frames) - 1 do
  begin
    if Name = UpperCase(Frames[i].Name) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TWMATag.ReadFrameByNameAsList(Name: String; var List: TStrings): Boolean;
var
  i: Integer;
  l: Integer;
begin
  Result := False;
  l := Length(Frames);
  i := 0;
  while (i <> l) AND (WideUpperCase(Frames[i].Name) <> WideUpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := False;
  end
  else
  begin
    if Frames[i].Format = WMT_TYPE_STRING then
    begin
      Result := Frames[i].GetAsList(List);
    end;
  end;
end;

function TWMATag.ReadFrameByNameAsText(Name: String): String;
var
  i: Integer;
  l: Integer;
begin
  Result := '';
  l := Length(Frames);
  i := 0;
  while (i <> l) AND (WideUpperCase(Frames[i].Name) <> WideUpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := '';
  end
  else
  begin
    if Frames[i].Format = WMT_TYPE_STRING then
    begin
      Result := Frames[i].GetAsText;
    end
    else
    begin
      Result := IntToStr(Frames[i].GetAsInteger);
    end;
  end;
end;

function TWMATag.ReadAsInteger(Name: String): Int64;
var
  i: Integer;
  l: Integer;
begin
  l := Length(Frames);
  i := 0;
  while (i <> l) AND (WideUpperCase(Frames[i].Name) <> WideUpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    Result := 0;
  end
  else
  begin
    // if Frames[i].Format = WMT_TYPE_STRING then begin
    Result := Frames[i].GetAsInteger;
    // end;
  end;
end;

function TWMATag.GetCanSkipBackward: Boolean;
begin
  Result := ReadAsInteger(g_wszWMSkipBackward) > 0;
end;

function TWMATag.GetCanSkipForward: Boolean;
begin
  Result := ReadAsInteger(g_wszWMSkipForward) > 0;
end;

function TWMATag.GetContainerFormat: Boolean;
begin
  Result := ReadAsInteger(g_wszWMContainerFormat) > 0;
end;

function TWMATag.GetCoverArtFromFrame(Index: Integer; var PictureStream: TStream; var MIMEType: String; var PictureType: Byte; var Description: String): Boolean;
var
  PictureDataLength: DWord;
  Data: Byte;
  DataWord: Word;
begin
  Result := False;
  MIMEType := '';
  Description := '';
  if (Index >= Length(Frames)) OR (Index < 0) OR (Frames[Index].Format <> WMT_TYPE_BINARY) then
  begin
    Exit;
  end;
  try
    // * Skip MIMEType pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soBeginning);
    // * Read picture type
    Frames[Index].Stream.Read(Data, 1);
    PictureType := Data;
    // * Skip description pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soFromCurrent);
    // * Read picture data length
    Frames[Index].Stream.Read(PictureDataLength, 4);
    // * Skip picture data pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soFromCurrent);
    // * Read MIMEType
    repeat
      Frames[Index].Stream.Read(DataWord, 2);
      if DataWord <> 0 then
      begin
        MIMEType := MIMEType + Char(DataWord);
      end;
    until DataWord = 0;
    // * Read description
    repeat
      Frames[Index].Stream.Read(DataWord, 2);
      if DataWord <> 0 then
      begin
        Description := Description + Char(DataWord);
      end;
    until DataWord = 0;
    // * Read picture data
    PictureStream.CopyFrom(Frames[Index].Stream, PictureDataLength);
    Frames[Index].Stream.Seek(0, soBeginning);
    PictureStream.Seek(0, soBeginning);
    Result := True;
  except
    Result := False;
  end;
end;

function TWMATag.GetCoverArtInfo(Index: Integer; var MIMEType: String; var PictureType: Byte; var Description: String; var CoverArtSize: Cardinal): Boolean;
var
  PictureDataLength: DWord;
  Data: Byte;
  DataWord: Word;
begin
  Result := False;
  MIMEType := '';
  Description := '';
  if (Index >= Length(Frames)) OR (Index < 0) OR (Frames[Index].Format <> WMT_TYPE_BINARY) then
  begin
    Exit;
  end;
  try
    // * Skip MIMEType pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soBeginning);
    // * Read picture type
    Frames[Index].Stream.Read(Data, 1);
    PictureType := Data;
    // * Skip description pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soFromCurrent);
    // * Read picture data length
    Frames[Index].Stream.Read(PictureDataLength, 4);
    // * Skip picture data pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soFromCurrent);
    // * Read MIMEType
    repeat
      Frames[Index].Stream.Read(DataWord, 2);
      if DataWord <> 0 then
      begin
        MIMEType := MIMEType + Char(DataWord);
      end;
    until DataWord = 0;
    // * Read description
    repeat
      Frames[Index].Stream.Read(DataWord, 2);
      if DataWord <> 0 then
      begin
        Description := Description + Char(DataWord);
      end;
    until DataWord = 0;
    CoverArtSize := PictureDataLength;
    Frames[Index].Stream.Seek(0, soBeginning);
    Result := True;
  except
    Result := False;
  end;
end;

function TWMATag.GetCoverArtInfoPointer(Index: Integer; var PictureType: Byte; var Data: Pointer; var DataSize: Integer; var Description: Pointer; var MIMEType: Pointer): Boolean;
var
  DataByte: Byte;
  DataWord: Word;
  MIMETypeString, DescriptionString: String;
begin
  Result := False;
  if (Index >= Length(Frames)) OR (Index < 0) OR (Frames[Index].Format <> WMT_TYPE_BINARY) then
  begin
    Exit;
  end;
  try
    Frames[Index].Stream.Seek(0, soBeginning);
    // * Skip MIMEType pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soBeginning);
    // * Read picture type
    Frames[Index].Stream.Read(DataByte, 1);
    PictureType := DataByte;
    // * Skip description pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soFromCurrent);
    // * Read picture data length
    Frames[Index].Stream.Read(DataSize, 4);
    // * Skip picture data pointer
    Frames[Index].Stream.Seek(SizeOf(Pointer), soFromCurrent);
    // * Read MIMEType
    MIMEType := Pointer(NativeUInt(Frames[Index].Stream.Memory) + Frames[Index].Stream.Position);
    repeat
      Frames[Index].Stream.Read(DataWord, 2);
      if DataWord <> 0 then
      begin
        MIMETypeString := MIMETypeString + Char(DataWord);
      end;
    until DataWord = 0;
    // * Read description
    Description := Pointer(NativeUInt(Frames[Index].Stream.Memory) + Frames[Index].Stream.Position);
    repeat
      Frames[Index].Stream.Read(DataWord, 2);
      if DataWord <> 0 then
      begin
        DescriptionString := DescriptionString + Char(DataWord);
      end;
    until DataWord = 0;
    Data := Pointer(NativeUInt(Frames[Index].Stream.Memory) + Frames[Index].Stream.Position);
    Frames[Index].Stream.Seek(0, soBeginning);
    Result := True;
  except
    Result := False;
  end;
end;

function TWMATag.GetCurrentBitrate: Integer;
begin
  Result := ReadAsInteger(g_wszWMCurrentBitrate);
end;

function TWMATag.GetDuration: Int64;
begin
  Result := ReadAsInteger(g_wszWMDuration);
end;

function TWMATag.GetFileSize: Int64;
begin
  Result := ReadAsInteger(g_wszWMFileSize);
end;

function TWMATag.GetHasArbitraryDataStream: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasArbitraryDataStream) > 0;
end;

function TWMATag.GetHasAttachedImages: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasAttachedImages) > 0;
end;

function TWMATag.GetHasAudio: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasAudio) > 0;
end;

function TWMATag.GetHasFileTransferStream: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasFileTransferStream) > 0;
end;

function TWMATag.GetHasImage: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasImage) > 0;
end;

function TWMATag.GetHasScript: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasScript) > 0;
end;

function TWMATag.GetHasVideo: Boolean;
begin
  Result := ReadAsInteger(g_wszWMHasVideo) > 0;
end;

function TWMATag.GetIsProtected: Boolean;
begin
  Result := ReadAsInteger(g_wszWMProtected) > 0;
end;

function TWMATag.GetIsTrusted: Boolean;
begin
  Result := ReadAsInteger(g_wszWMTrusted) > 0;
end;

function TWMATag.GetNumberOfFrames: Int64;
begin
  Result := ReadAsInteger(g_wszWMNumberOfFrames);
end;

function TWMATag.GetOptimalBitrate: Integer;
begin
  Result := ReadAsInteger(g_wszWMOptimalBitrate);
end;

function TWMATag.GetSeekable: Boolean;
begin
  Result := ReadAsInteger(g_wszWMSeekable) > 0;
end;

function TWMATag.GetSignatureName: String;
begin
  Result := ReadFrameByNameAsText(g_wszWMSignature_Name);
end;

function TWMATag.GetStridable: Boolean;
begin
  Result := ReadAsInteger(g_wszWMStridable) > 0;
end;

function TWMATag.Assign(Source: TWMATag): Boolean;
var
  i: Integer;
begin
  Clear;
  FileName := Source.FileName;
  Loaded := Source.Loaded;
  for i := 0 to Length(Source.Frames) - 1 do
  begin
    AddFrame(Source.Frames[i].Name).Assign(Source.Frames[i]);
  end;
  Result := True;
end;

function TWMATag.CalculateTagSize: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Length(Frames) - 1 do
  begin
    Result := Result + (Length(Frames[i].Name) + 1) * 2 + Frames[i].Stream.Size + 4 + 1; // * Just guessing
  end;
end;

procedure TWMATag.Clear;
begin
  DeleteAllFrames;
  FileName := '';
  Loaded := False;
end;

procedure TWMATag.DeleteAllCoverArts;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
  begin
    if Frames[i].Name = g_wszWMPicture then
    begin
      DeleteFrame(i);
    end;
  end;
end;

function TWMATag.CoverArtCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Count - 1 downto 0 do
  begin
    if Frames[i].Name = g_wszWMPicture then
    begin
      Inc(Result);
    end;
  end;
end;

procedure TWMATag.DeleteAllFrames;
var
  i: Integer;
begin
  for i := 0 to Length(Frames) - 1 do
  begin
    FreeAndNil(Frames[i]);
    // Frames[i].Stream.Clear;
  end;
  SetLength(Frames, 0);
end;

function TWMATag.GetAttribIndex(Attrib: string): Integer;
var
  AttribName: PWideChar;
  P, Lang: PWORD;
  AttribLen: Word;
begin
  Result := -1;
  AttribName := StringToOleStr(Attrib);
  Lang := PWORD(0);
  ppHeaderInfo3.GetAttributeIndices($FFFF, AttribName, Lang, nil, AttribLen);
  if AttribLen <> 0 then
  begin
    P := AllocMem(AttribLen);
    try
      ppHeaderInfo3.GetAttributeIndices($FFFF, AttribName, Lang, P, AttribLen);
      Result := PWORD(P)^;
    finally
      FreeMem(P);
    end;
  end;
end;

function TWMATag.GetBitRate: Integer;
begin
  Result := Round(ReadAsInteger(g_wszWMBitrate) / 1024);
end;

function TWMATag.GetBroadcast: Boolean;
begin
  Result := ReadAsInteger(g_wszWMBroadcast) > 0;
end;

function TWMATag.LoadTags(FileName: String): Integer;
var
  AttributeCount: Word;
  pType: TWMTAttrDataType;
  pValue: PBYTE;
  I: Integer;
  HR: HRESULT;
  wIndex: Word;
  pwszName: PWideChar;
  pwNameLen: Word;
  pwLangIndex: Word;
  pdwDataLength: DWord;
begin
  if DllHandleWMVCORE = 0 then
  begin
    Result := WMATAGLIBRARY_ERROR_COULDNTLOADDLL;
    Exit;
  end
  else
  begin
    _WMCreateEditor := GetProcAddress(DllHandleWMVCORE, 'WMCreateEditor');
  end;
  Clear;
  if NOT FileExists(FileName) then
  begin
    Result := WMATAGLIBRARY_ERROR_FILENOTFOUND;
    Exit;
  end;
  try
    HR := _WMCreateEditor(ppEditor);
    if Failed(HR) then
    begin
      Result := WMATAGLIBRARY_ERROR_COULDNOTCREATEMETADATAEDITOR;
      Exit;
    end;
    ppEditor.Open(PChar(FileName));
    HR := ppEditor.QueryInterface(IID_IWMHeaderInfo3, ppHeaderInfo3);
    if Failed(HR) then
    begin
      Result := WMATAGLIBRARY_ERROR_COULDNOTQIFORIWMHEADERINFO3;
      Exit;
    end;
    // HR := ppHeaderInfo3.GetAttributeCountEx(65535, AttributeCount);
    HR := ppHeaderInfo3.GetAttributeCountEx(0, AttributeCount);
    if Failed(HR) then
    begin
      Result := WMATAGLIBRARY_ERROR_COULDNOTQUERY_ATTRIBUTE_COUNT;
      Exit;
    end;
    if AttributeCount > 0 then
    begin
      Loaded := True;
    end;
    for I := 0 to AttributeCount - 1 do
    begin
      wIndex := Word(I);
      pwNameLen := 0;
      pType := WMT_TYPE_DWORD;
      pwLangIndex := 0;
      pdwDataLength := 0;
      ppHeaderInfo3.GetAttributeByIndexEx( { 65535 } 0, wIndex, nil, pwNameLen, pType, pwLangIndex, nil, pdwDataLength);
      pwszName := AllocMem(pwNameLen * 2);
      pValue := AllocMem(pdwDataLength);
      ppHeaderInfo3.GetAttributeByIndexEx( { 65535 } 0, wIndex, pwszName, pwNameLen, pType, pwLangIndex, pValue, pdwDataLength);
      // * 3delite
      if pValue = nil then
      begin
        Continue;
      end;
      with AddFrame(pwszName) do
      begin
        Format := pType;
        Stream.Write(Pointer(pValue)^, pdwDataLength);
        Stream.Seek(0, soBeginning);
        {
          if pwszName = 'WM/Picture' then begin
          ValidatePictureFrame(Index);
          end;
        }
      end;
      FreeMem(pwszName);
      FreeMem(pValue);
    end;
    Result := WMATAGLIBRARY_SUCCESS;
    ppHeaderInfo3 := nil;
  finally
    ppEditor.Close;
    ppEditor := nil;
    if DllHandleWMVCORE <> 0 then
    begin
      _WMCreateEditor := nil;
    end;
  end;
end;

function TWMATag.SaveToFile(FileName: String): Integer;
var
  nIndex, nLength: Integer;
  AttribName, pValue: PWideChar;
  pwIndex: Word;
  HR: HRESULT;
  i: Integer;
  AttributeCount: Word;
  DeleteAttributeCount: Integer;
  wIndex: Word;
begin
  if NOT FileExists(FileName) then
  begin
    Result := WMATAGLIBRARY_ERROR_FILENOTFOUND;
    Exit;
  end;
  if DllHandleWMVCORE = 0 then
  begin
    Result := WMATAGLIBRARY_ERROR_COULDNTLOADDLL;
    Exit;
  end
  else
  begin
    _WMCreateEditor := GetProcAddress(DllHandleWMVCORE, 'WMCreateEditor');
  end;
  HR := _WMCreateEditor(ppEditor);
  if Failed(HR) then
  begin
    Result := WMATAGLIBRARY_ERROR_COULDNOTCREATEMETADATAEDITOR;
    Exit;
  end;
  HR := ppEditor.QueryInterface(IID_IWMHeaderInfo3, ppHeaderInfo3);
  if Failed(HR) then
  begin
    Result := WMATAGLIBRARY_ERROR_COULDNOTQIFORIWMHEADERINFO3;
    Exit;
  end;
  ppEditor.Open(PChar(FileName));
  try
    pwIndex := 0;
    // * Delete all cover arts
    {
      repeat
      nIndex := GetAttribIndex('WM/Picture');
      if nIndex <> - 1 then begin
      ppHeaderInfo3.DeleteAttribute(0, nIndex);
      end;
      until nIndex = - 1;
    }

    // * Delete all existing attributes
    ppHeaderInfo3.GetAttributeCountEx( { 65535 } 0, AttributeCount);
    DeleteAttributeCount := AttributeCount;
    for i := DeleteAttributeCount - 1 downto 0 do
    begin
      wIndex := Word(I);
      ppHeaderInfo3.DeleteAttribute(0, wIndex);
    end;

    // * Delete all existing
    {
      for i := 0 to Length(Frames) - 1 do begin
      nIndex := GetAttribIndex(Frames[i].Name);
      if nIndex <> - 1 then begin
      ppHeaderInfo3.DeleteAttribute(0, nIndex);
      end;
      end;
    }
    // * Modify/delete attributes
    for i := 0 to Length(Frames) - 1 do
    begin
      if Frames[i].Name = 'WM/Picture' then
      begin
        Continue;
      end;
      AttribName := PChar(Frames[i].Name);
      // nIndex := GetAttribIndex(AttribName);
      if Frames[i].Format = WMT_TYPE_STRING then
      begin
        pValue := StringToOleStr(Frames[i].GetAsText);
        nLength := Length(pValue) * 2;
      end
      else
      begin
        pValue := Frames[i].Stream.Memory;
        nLength := Frames[i].Stream.Size;
      end;
      // * For unknown reason using 'Frames[i].Format' for the 'WMT_TYPE_*' does not work, so define explicitly for all the cases
      case Frames[i].Format of
        WMT_TYPE_DWORD:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_DWORD, 0, PByte(pValue), nLength);
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_DWORD, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
        WMT_TYPE_STRING:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_STRING, 0, PByte(pValue), nLength)
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_STRING, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
        WMT_TYPE_BINARY:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_BINARY, 0, PByte(pValue), nLength)
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_BINARY, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
        WMT_TYPE_BOOL:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_BOOL, 0, PByte(pValue), nLength)
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_BOOL, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
        WMT_TYPE_QWORD:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_QWORD, 0, PByte(pValue), nLength)
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_QWORD, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
        WMT_TYPE_WORD:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_WORD, 0, PByte(pValue), nLength)
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_WORD, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
        WMT_TYPE_GUID:
          begin
            {
              if nIndex >= 0 then begin
              if (pValue <> '')
              AND (nLength > 0)
              then begin
              ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_GUID, 0, PByte(pValue), nLength)
              end else begin
              ppHeaderInfo3.DeleteAttribute(0, nIndex);
              end;
              end else begin
            }
            if nLength <> 0 then
            begin
              ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_GUID, 0, PBYTE(pValue), nLength);
            end;
            // end;
          end;
      end;
    end;

    // * Add cover art attributes - must do separatelly from other attributs bocause the last cover art replaces the previous (bug in WMVCORE.DLL?)
    for i := 0 to Length(Frames) - 1 do
    begin
      if Frames[i].Name <> 'WM/Picture' then
      begin
        Continue;
      end;
      AttribName := PChar(Frames[i].Name);
      // * To get proper pointers
      ValidatePictureFrame(i);
      nIndex := -1;
      pValue := Frames[i].Stream.Memory;
      nLength := Frames[i].Stream.Size;
      if nIndex >= 0 then
      begin
        if (pValue <> '') AND (nLength > 0) then
        begin
          ppHeaderInfo3.ModifyAttribute(0, nIndex, WMT_TYPE_BINARY, 0, PBYTE(pValue), nLength)
        end
        else
        begin
          ppHeaderInfo3.DeleteAttribute(0, nIndex);
        end;
      end
      else
      begin
        if nLength <> 0 then
        begin
          ppHeaderInfo3.AddAttribute(0, AttribName, pwIndex, WMT_TYPE_BINARY, 0, PBYTE(pValue), nLength);
        end;
      end;
    end;

    ppEditor.Flush;
    Result := WMATAGLIBRARY_SUCCESS;
  finally
    ppHeaderInfo3 := nil;
    ppEditor.Close;
    ppEditor := nil;
    if DllHandleWMVCORE <> 0 then
    begin
      _WMCreateEditor := nil;
    end;
  end;
end;

function TWMATag.SetAsInteger(Name: String; Value: Int64; Format: TWMTAttrDataType): Boolean;
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Frames);
  while (i < l) AND (WideUpperCase(Frames[i].Name) <> WideUpperCase(Name)) do
  begin
    inc(i);
  end;
  if i = l then
  begin
    AddFrame(Name).SetAsInteger(Value, Format);
  end
  else
  begin
    Frames[i].SetAsInteger(Value, Format);
  end;
  Result := True;
end;

procedure TWMATag.SetListFrameText(Name: String; List: TStrings);
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Frames);
  while (i < l) AND (WideUpperCase(Frames[i].Name) <> WideUpperCase(Name)) do
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

function TWMATag.SetCoverArtFrame(Index: Integer; PictureStream: TStream; MIMEType: String; PictureType: Byte; Description: String): Boolean;
var
  PictureDataLength: DWord;
  DataPointer: NativeUInt;
begin
  Result := False;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  Frames[Index].Format := WMT_TYPE_BINARY;
  Frames[Index].Stream.Clear;
  try
    DataPointer := 0;
    // * Pointer to MIMEType will be updated
    Frames[Index].Stream.Write(DataPointer, SizeOf(DataPointer));
    // * Write picture type
    Frames[Index].Stream.Write(PictureType, 1);
    // * Pointer to description will be updated
    Frames[Index].Stream.Write(DataPointer, SizeOf(DataPointer));
    // * Write picture size
    if Assigned(PictureStream) then
    begin
      PictureDataLength := PictureStream.Size;
    end
    else
    begin
      PictureDataLength := 0;
    end;
    Frames[Index].Stream.Write(PictureDataLength, 4);
    // * Pointer to picture data will be updated
    Frames[Index].Stream.Write(DataPointer, SizeOf(DataPointer));
    // * Write MIMEType
    Frames[Index].Stream.Write(PChar(MIMEType)^, (Length(MIMEType) + 1) * 2);
    // * Write description
    Frames[Index].Stream.Write(PChar(Description)^, (Length(Description) + 1) * 2);
    // * Write the cover art data
    if Assigned(PictureStream) then
    begin
      PictureStream.Seek(0, soBeginning);
      Frames[Index].Stream.CopyFrom(PictureStream, PictureStream.Size);
    end;
    Frames[Index].Stream.Seek(0, soBeginning);
    // * Update MIMEType pointer
    DataPointer := NativeUInt(Frames[Index].Stream.Memory) + 5 + (SizeOf(DataPointer) * 3);
    Frames[Index].Stream.Write(DataPointer, SizeOf(DataPointer));
    // * Update description pointer
    Frames[Index].Stream.Seek(1, soCurrent);
    DataPointer := NativeUInt(Frames[Index].Stream.Memory) + 5 + (SizeOf(DataPointer) * 3) + (Length(MIMEType) + 1) * 2;
    Frames[Index].Stream.Write(DataPointer, SizeOf(DataPointer));
    // * Update data pointer
    Frames[Index].Stream.Seek(4, soCurrent);
    DataPointer := NativeUInt(Frames[Index].Stream.Memory) + 5 + (SizeOf(DataPointer) * 3) + (Length(MIMEType) + 1) * 2 + (Length(Description) + 1) * 2;
    Frames[Index].Stream.Write(DataPointer, SizeOf(DataPointer));
    Frames[Index].Stream.Seek(0, soBeginning);
    Result := True;
  except
    Result := False;
  end;
end;

procedure TWMATag.SetTextFrameText(Name, Text: String);
var
  i: Integer;
  l: Integer;
begin
  i := 0;
  l := Length(Frames);
  while (i < l) AND (WideUpperCase(Frames[i].Name) <> WideUpperCase(Name)) do
  begin
    inc(i);
  end;
  if Text <> '' then
  begin
    if i = l then
    begin
      AddFrame(Name).SetAsText(Text);
    end
    else
    begin
      Frames[i].SetAsText(Text);
    end;
  end
  else
  begin
    if i <> l then
    begin
      DeleteFrame(i);
    end;
  end;
end;

function TWMATag.ValidatePictureFrame(Index: Integer): Boolean;
var
  PictureStream: TStream;
  MIMEType: String;
  PictureType: Byte;
  Description: String;
begin
  Result := False;
  if (Index >= Length(Frames)) OR (Index < 0) then
  begin
    Exit;
  end;
  PictureStream := TMemoryStream.Create;
  try
    if GetCoverArtFromFrame(Index, PictureStream, MIMEType, PictureType, Description) then
    begin
      Result := SetCoverArtFrame(Index, PictureStream, MIMEType, PictureType, Description);
    end;
  finally
    FreeAndNil(PictureStream);
  end;
end;

function TWMATag.LoadFromFile(FileName: String): Integer;
var
  fFileName: PWideChar;
begin
  try
    Loaded := False;
    Self.FileName := FileName;
    if NOT FileExists(FileName) then
    begin
      Result := WMATAGLIBRARY_ERROR_FILENOTFOUND;
      Exit;
    end;
    fFileName := StringToOleStr(FileName);
    Result := LoadTags(fFileName);
    SysFreeString(fFileName);
  except
    Result := WMATAGLIBRARY_ERROR;
  end;
end;

function DurationToStr(Duration: int64; ShowMs: Boolean): String;
begin
  if ShowMs then
  begin
    if Duration >= 3600000 then
      Result := Format('%d:%2.2d:%2.2d.%3.3d', [Duration div 3600000, (Duration mod 3600000) div 60000, (Duration mod 60000) div 1000, Duration mod 1000])
    else
      Result := Format('%d:%2.2d.%3.3d', [Duration div 60000, (Duration mod 60000) div 1000, Duration mod 1000]);
  end
  else
  begin
    if Duration >= 3600000 then
      Result := Format('%d:%2.2d:%2.2d', [Duration div 3600000, (Duration mod 3600000) div 60000, (Duration mod 60000) div 1000])
    else
      Result := Format('%d:%2.2d', [Duration div 60000, (Duration mod 60000) div 1000]);
  end;
end;

function WMATagErrorCode2String(ErrorCode: Integer): String;
begin
  Result := 'Unknown error code.';
  case ErrorCode of
    WMATAGLIBRARY_SUCCESS:
      Result := 'Success.';
    WMATAGLIBRARY_ERROR:
      Result := 'Unknown error occured.';
    WMATAGLIBRARY_ERROR_FILENOTFOUND:
      Result := 'Error opening file.';
    WMATAGLIBRARY_ERROR_COULDNTLOADDLL:
      Result := 'Error loading ' + LibNameWMVCORE + '.';
    WMATAGLIBRARY_ERROR_COULDNOTCREATEMETADATAEDITOR:
      Result := 'Error: could not create WMA meta data editor.';
    WMATAGLIBRARY_ERROR_COULDNOTQIFORIWMHEADERINFO3:
      Result := 'Error: could not query for WMA IWMHeaderInfo3.';
    WMATAGLIBRARY_ERROR_COULDNOTQUERY_ATTRIBUTE_COUNT:
      Result := 'Error: could not query WMA attribute count.';
  end;
end;

Initialization

  DllHandleWMVCORE := LoadLibrary(LibNameWMVCORE);

Finalization

FreeLibrary(DllHandleWMVCORE);

end.
