{ *
  * Copyright (C) 2012-2017 ozok <ozok26@gmail.com>
  *
  * This file is part of TAudioConverter.
  *
  * TAudioConverter is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * TAudioConverter is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with TAudioConverter.  If not, see <http://www.gnu.org/licenses/>.
  *
  * }

unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, JvExMask, XPMan, ExtCtrls, Menus, JvBaseDlg,
  JvBrowseFolder, JvExStdCtrls, JvToolEdit, JvComponentBase, JvThread, ComCtrls,
  JvExComCtrls, ShellAPI, StrUtils, MediaInfoDll, JvComputerInfoEx, IniFiles,
  JvDragDrop, JvUrlListGrabber, JvUrlGrabbers, CommCtrl, sSkinProvider,
  sSkinManager, sPanel, sButton, sLabel, sListBox, sCheckBox, sComboBox, sEdit,
  sGauge, System.Types, sBitBtn, Vcl.ImgList, acAlphaImageList, JvSearchFiles,
  acPNG, JvTrayIcon, UnitEncoder, TlHelp32, UnitFileInfo, sDialogs, sTrackBar,
  sTreeView, sListView, sSpinEdit, MMSystem, acAlphaHints, acProgressBar,
  UnitCueParser, UnitTagTypes, Generics.Collections, UnitAudioDurationExtractor,
  UnitFFProbeInformer, UnitImageTypeExtractor, UnitArtworkExtractor, Vcl.ToolWin,
  sToolBar, UnitRGInfoExtractor, UnitCommonTypes, UnitWMATagExtractor,
  sPageControl, UnitTypes, ACS_Classes, ACS_Wave, ACS_CDROM, mr_cddb, UnitPlayer,
  UnitArtworkDownloader, UnitImageResize, JvAppStorage, JvAppIniStorage,
  JvFormPlacement, UnitTagReader, sBevel, UnitPresets, acSlider, System.ImageList;

type
  TRenamePair = record
    Input: string;
    Output: string;
  end;

type
  TCompressionFileNamesPair = record
    SourcePath: string;
    DestinationPath: string;
  end;

type
  TIndexItem = class(TObject)
  private
    FRealIndex: Integer;
  public
    property RealIndex: Integer read FRealIndex write FRealIndex;
  end;

type
  TMainForm = class(TForm)
    OutputBtn: TsBitBtn;
    StopBtn: TsBitBtn;
    XPManifest1: TXPManifest;
    AddMenu: TPopupMenu;
    AddFiles1: TMenuItem;
    AddFolder1: TMenuItem;
    OpenDialog: TsOpenDialog;
    OpenFolderDialog: TJvBrowseForFolderDialog;
    PositionTimer: TTimer;
    SystemInfo: TJvComputerInfoEx;
    DragDrop: TJvDragDrop;
    UpdateThread: TJvThread;
    UpdateChecker: TJvHttpUrlGrabber;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    AddFiles2: TMenuItem;
    AddFolder2: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Up1: TMenuItem;
    Down1: TMenuItem;
    Remove1: TMenuItem;
    RemoveAll1: TMenuItem;
    ools1: TMenuItem;
    LogsOutput1: TMenuItem;
    Info1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    CheckUpdate1: TMenuItem;
    ListMenu: TPopupMenu;
    AddFiles3: TMenuItem;
    AddFolder3: TMenuItem;
    Remove2: TMenuItem;
    Clear1: TMenuItem;
    OpenDirectory1: TMenuItem;
    Info2: TMenuItem;
    SameAsSourceBtn: TsCheckBox;
    ProgressPanel: TsPanel;
    Log2Btn: TsBitBtn;
    FileSearch: TJvSearchFiles;
    AddFolderTree1: TMenuItem;
    Play1: TMenuItem;
    AddFolderTree2: TMenuItem;
    SummaryView: TsTreeView;
    OpenOut2Btn: TsBitBtn;
    AddFolderTree3: TMenuItem;
    ProgressImages: TsAlphaImageList;
    ListImage: TsAlphaImageList;
    PostEncodeList: TsComboBox;
    Timer: TTimer;
    TotalProgressBar: TsProgressBar;
    StatusList: TsAlphaImageList;
    TrayIcon: TJvTrayIcon;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    ChangeLog1: TMenuItem;
    DirectoryEdit: TsEdit;
    SelectDirBtn: TsButton;
    SeeLogtxt1: TMenuItem;
    MainPanel: TsPanel;
    DownloadNeroAACTools1: TMenuItem;
    SelectAll1: TMenuItem;
    sAlphaHints1: TsAlphaHints;
    S1: TMenuItem;
    T1: TMenuItem;
    SendtoTrayBtn: TsBitBtn;
    B1: TMenuItem;
    D1: TMenuItem;
    E1: TMenuItem;
    CodecSettingsBtn: TsBitBtn;
    CreateCMDPanel: TsPanel;
    ProgressInfoLabel: TsLabel;
    CreateCMDBar: TsProgressBar;
    R1: TMenuItem;
    TagEditMenu: TPopupMenu;
    E2: TMenuItem;
    E3: TMenuItem;
    C1: TMenuItem;
    N1: TMenuItem;
    G1: TMenuItem;
    E4: TMenuItem;
    FunctionPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sPanel1: TsPanel;
    AddBtn: TsBitBtn;
    UpBtn: TsBitBtn;
    DownBtn: TsBitBtn;
    TrimBtn: TsBitBtn;
    RemoveBtn: TsBitBtn;
    RemoveAllBtn: TsBitBtn;
    InfoBtn: TsBitBtn;
    TagEditorBtn: TsBitBtn;
    AudioTrackList: TsComboBox;
    FileList: TsListView;
    TopPanel: TsPanel;
    RefreshBtn: TsBitBtn;
    EjectBtn: TsBitBtn;
    CloseTrayBtn: TsBitBtn;
    TracksList: TsListView;
    CodecSettingsPanel: TsPanel;
    CommentEdit: TsEdit;
    GenreEdit: TsEdit;
    ArtistEdit: TsEdit;
    TitleEdit: TsEdit;
    AlbumArtistEdit: TsEdit;
    AlbumEdit: TsEdit;
    DateEdit: TsSpinEdit;
    TrackNoEdit: TsSpinEdit;
    CDDBInfo: TCDDBInfo;
    CDIn: TCDIn;
    WaitPanel: TsPanel;
    ProgressStatePanel: TsPanel;
    StatusLabel: TsLabel;
    RipProgregressBar: TsProgressBar;
    StopCDBtn: TsBitBtn;
    ItemProgressBar: TsProgressBar;
    CDPRogressList: TsListView;
    CDProgressTimer: TTimer;
    CDProgressImages: TsAlphaImageList;
    AudioEffectsBtn: TsBitBtn;
    LogsBtn: TsBitBtn;
    SettingsBtn: TsBitBtn;
    AudioMethodList: TsComboBox;
    CDOptionsBtn: TsBitBtn;
    TimeEdit: TsEdit;
    DummyList: TsAlphaImageList;
    StartBtn: TsBitBtn;
    RipBtn: TsBitBtn;
    TotalProgressLabel: TsLabel;
    ProgressList: TsListView;
    sPanel2: TsPanel;
    VolumeBar: TsTrackBar;
    PositionBar: TsTrackBar;
    PlaybackTimer: TTimer;
    PositionLabel: TsLabel;
    VolumeLabel: TsLabel;
    PauseBtn: TsBitBtn;
    StopPlaybackBtn: TsBitBtn;
    sPanel3: TsPanel;
    CoverImg: TImage;
    FilterbtnImgs: TsAlphaImageList;
    AppIniFileStorage: TJvAppIniFileStorage;
    FormStorage: TJvFormStorage;
    MergeSaveDlg: TsSaveDialog;
    MergeTimer: TTimer;
    MergePanel: TsPanel;
    MergeProgressBar: TsProgressBar;
    C2: TMenuItem;
    FileCountLabel: TsLabel;
    ColumnImgs: TsAlphaImageList;
    sBevel1: TsBevel;
    AudioTopPanel: TsPanel;
    sPanel4: TsPanel;
    DriversList: TsComboBox;
    sPanel5: TsPanel;
    CDTopBar: TsPanel;
    E5: TMenuItem;
    EncodeModePages: TsPageControl;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    ProfilesList: TsComboBox;
    AudioCodecList: TsComboBox;
    PrevCodecBtn: TsButton;
    NextCodecBtn: TsButton;
    SummaryLabel: TsLabel;
    ModeSelectionList: TsComboBox;
    WaveOut: TWaveOut;
    procedure AddFiles1Click(Sender: TObject);
    procedure AddFolder1Click(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure PositionTimerTimer(Sender: TObject);
    procedure LogsBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OutputBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure RemoveAllBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DragDropDrop(Sender: TObject; Pos: TPoint; Value: TStrings);
    procedure InfoBtnClick(Sender: TObject);
    procedure UpdateThreadExecute(Sender: TObject; Params: Pointer);
    procedure UpdateListboxScrollBox(ListBox: TsListBox);
    procedure UpdateBtnClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure OpenDirectory1Click(Sender: TObject);
    procedure AudioEffectsBtnClick(Sender: TObject);
    procedure FileListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FileListClick(Sender: TObject);
    procedure AudioTrackListChange(Sender: TObject);
    procedure AddFolderTree1Click(Sender: TObject);
    procedure FileSearchProgress(Sender: TObject);
    procedure FileSearchFindFile(Sender: TObject; const AName: string);
    procedure Play1Click(Sender: TObject);
    procedure FileListAdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure CloseTrayBtnClick(Sender: TObject);
    procedure SameAsSourceBtnClick(Sender: TObject);
    procedure TrayIconBalloonClick(Sender: TObject);
    procedure FileListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChangeLog1Click(Sender: TObject);
    procedure PostEncodeListChange(Sender: TObject);
    procedure EmalBtnClick(Sender: TObject);
    procedure SelectDirBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure sLabel3Click(Sender: TObject);
    procedure SeeLogtxt1Click(Sender: TObject);
    procedure WikiBtnClick(Sender: TObject);
    procedure DonationBtnClick(Sender: TObject);
    procedure DownloadNeroAACTools1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure TagEditorBtnClick(Sender: TObject);
    procedure AftenBitrateEditMouseLeave(Sender: TObject);
    procedure BlogBtnClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SendtoTrayBtnClick(Sender: TObject);
    procedure TrimBtnClick(Sender: TObject);
    procedure UpdateCheckerDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
    procedure CodecSettingsBtnClick(Sender: TObject);
    procedure AudioCodecListChange(Sender: TObject);
    procedure AudioMethodListChange(Sender: TObject);
    procedure MainSummarListDblClick(Sender: TObject);
    procedure PrevCodecBtnClick(Sender: TObject);
    procedure NextCodecBtnClick(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure E2Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure E3Click(Sender: TObject);
    procedure DriversListChange(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure EjectBtnClick(Sender: TObject);
    procedure TitleEditChange(Sender: TObject);
    procedure TrackNoEditChange(Sender: TObject);
    procedure TracksListClick(Sender: TObject);
    procedure WaveOutDone(Sender: TComponent);
    procedure WaveOutProgress(Sender: TComponent);
    procedure WaveOutThreadException(Sender: TComponent);
    procedure DateEditChange(Sender: TObject);
    procedure CommentEditChange(Sender: TObject);
    procedure ArtistEditChange(Sender: TObject);
    procedure AlbumEditChange(Sender: TObject);
    procedure AlbumArtistEditChange(Sender: TObject);
    procedure GenreEditChange(Sender: TObject);
    procedure StopCDBtnClick(Sender: TObject);
    procedure CDProgressTimerTimer(Sender: TObject);
    procedure FunctionPagesChange(Sender: TObject);
    procedure CDOptionsBtnClick(Sender: TObject);
    procedure EncodingSettingsBtnClick(Sender: TObject);
    procedure T1Click(Sender: TObject);
    procedure RipBtnClick(Sender: TObject);
    procedure PlaybackTimerTimer(Sender: TObject);
    procedure VolumeBarChange(Sender: TObject);
    procedure PauseBtnClick(Sender: TObject);
    procedure StopPlaybackBtnClick(Sender: TObject);
    procedure PositionBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure VolumeBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sSkinManager1Activate(Sender: TObject);
    procedure sSkinManager1Deactivate(Sender: TObject);
    procedure CreateLogBtnClick(Sender: TObject);
    procedure MergeTimerTimer(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure FileListColumnClick(Sender: TObject; Column: TListColumn);
    procedure FileListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ProfilesListChange(Sender: TObject);
    procedure E5Click(Sender: TObject);
    procedure ModeSelectionListChange(Sender: TObject);
  private
    { Private declarations }
    AudioIndexes: TStringList;
    AudioTracks: TStringList;
    // CurrentFileIndexes: TStringList;
    Files: TStringList;
    FilesToCheck: TStringList;
    ExtensionsForCopy: TStringList;
    CopyExtension: TStringList;
    CompressionPairs: TList<TCompressionFileNamesPair>;

{$REGION 'EncoderPaths'}
    FFFMpegPath, FQaacPath, FOggEncPath, FLamePath, FFLACPath: string;
    FFHGPath, FOpusPath: string;
    FMPCPath: string;
    FMACPath: string;
    FTTAPath: string;
    FTAKPath: string;
    FNeroEncPath: string;
    FNeroTagPath: string;
    FWmaEncodePath: string;
    FWavPackPath: string;
    FFdkAACPath: string;
    FSoxPath: string;
    FFLACCLPath: string;
    FLossyWAVPath: string;
    FTTaggerPath: string;
    FFFProbePath: string;
    FArtworkExtractorPath: string;
    FAACGainPath: string;
    FMp3GainPath: string;
    FVorbisGainPath: string;
    FWVGainPath: string;
    FMetaFlacPath: string;
    FMPCGainPath: string;
    FDCAENCPath: string;
    FRenameToolPath: string;
{$ENDREGION}
    FTotalLength: Int64;
    FMergeTotalDuration: Integer;
    FLastDirectory: string;
    FTimePassed: Int64;
    FEncoders: array[0..15] of TEncoder;
    FMergeProcess: TEncoder;
    FTotalCMDCount: integer;
    FAudioEncoderType: TEncoderType;
    FPlayer: TPlayer;
    FPlaybackIndex: Integer;
    FPrevStateIndex: Integer;
    // current playback time
    // can be cue or trimmed
    FPlaybackDuration: Integer;

    // ====CD Ripper====
    FTrackIndex: integer;
    FSelectedTracksCount: integer;
    FRippedTracks: integer;
    FTrackInfoList: TList<TTrackInfo>;
    FTracksToBeRipped: TList<TTrackIndexes>;
    FMergeFileList: TStringList;

    // column sort
    FDescending: Boolean;
    FSortedColumn: Integer;

    // tag reader object
    FTagReader: TTagReader;

    // presets
    FPresets: TLamePresetList;
    FPresetFilesList: TStringList;
    procedure GetTracks;
    procedure LoadDrivers;
    function PadInteger(const Int: integer): string;
    procedure FillCDProgressList;
    function PlayItem(const ItemIndex: Integer): integer;
    procedure LoadPresets;
    procedure LaunchProcesses(const ProcessCount: integer);
    function SubStringOccurences(const subString, sourceString: string): integer;

    // get full info for selected file
    procedure GetFullInfo(const FileName: string);

    // hh:mm:ss to int
    function TimeToInt(const TimeStr: string): Integer;

    // gets duration of a file in seconds
    function GetDurationEx(const FileName: string): integer;

    // deletes temp. files
    procedure DeleteTempFiles(const DeleteCDTemp: Boolean);

    // checks output files to detect errors
    function CheckOutputFiles: Boolean;

    // checks a single output file
    // function CheckOutputFile(const FileIndex: integer): Boolean;

    // disable/enable UI
    procedure DisableUI();
    procedure EnableUI();

    // adds command line
    procedure AddCommandLine(Index: Integer; AdvancedOptions: string; const EncoderIndex: integer);
    procedure AddMergeCommandLine(Index: Integer; AdvancedOptions: string; const EncoderIndex: integer);
    procedure CreateMergeCMD(const FileName: string);

    // fills summary list
    procedure FillSummaryList();

    // shuts down, logs off or reboots
    function ShutDown(RebootParam: Longword): Boolean;

    // gets audio codec
    function CodecToExtension(const AudioCodec: string): string;

    // save/load options
    procedure LoadOptions();
    procedure SaveOptions();

    // adds a file to the file list extracting audio info
    procedure AddFile(const FileName: string);

    // tags
    function CreateTagCMD(const FileName: string; const FileIndex: integer): string;
    function CDCreateTagCMD(const TotalTracks: Integer; const TrackIndex: Integer): string;
    procedure CreateMergeTagTextFile;
    function GetFileFolderName(const FileName: string; const FileIndex: Integer): string;
    function ParseFolderStr(const FolderStr: string; const FileName: string; const FileIndex: Integer): string;
    function GetCustomFileName(const FileNameStr: string; const FileName: string; const FileIndex: Integer): string;
    function GetCueCustomFileName(const Tags: TTagInfo; const FileNameStr: string): string;
    procedure SaveLogs();
    procedure DeleteLogs();

    // removes '"' from tags
    function RemoveQuotation(const Source: string): string;

    // checks if source is audio only
    function IsAudioOnly(const FileName: string): Boolean;

    // creates cmd for ffmpeg according to bit depth
    function CreateBitDepthCMD(const FileName: string): string;

    // for debugging
    procedure Log(const MSG: string);

    // removes non-digit chars
    function RemoveNonDigits(const InputStr: string): string;

    // creates command line for embeding artwork
    function CreateArtworkCMD(const FileName: string; const FileIndex: integer): string;
    function CDCreateArtworkCMD(const CoverPath: string): string;
    // saves artwork to dest. folder
    procedure SaveArtwork(const SourceFileName: string; const OutputFolder: string; const FileIndex: integer; const DestFile: string);
    procedure SaveExternalArtwork(const FileDir: string; const OutputFolder: string);

    // writes given line to given file
    procedure WriteLnToFile(const FileName: string; const Line: string);
    function CanUseLossyWAV: Boolean;

    // reads tags from file
    function ReadTags(const FileName: string; const AudioOnly: Boolean): TTagInfo;

    // returns number of channels file has
    function GetChannelCount(const FileName: string; const AudioID: integer): integer;

    // checks if source is lossless
    function IsSourceLossless(const FileName: string): Boolean;
    function IsAACFileALAC(const FileName: string): Boolean;

    // log compression percentages
    procedure CompressionPercentages;
    procedure DebugMsg(const Str: string);
    function CalcFileSize(const FilePath: string): int64;
    function CreateTempFileName(): string;
    // adds temp wav files' commands
    procedure AddCDTracks;
    procedure AddCDTrack(const Track: integer; const TrackCount: integer; const EncoderIndex: Integer);
    procedure CalcTotalCompression;
    function PadTrackIndex(const TrackNo: integer): string;
    function IsHEv2Selected: Boolean;

    // checks if file is in filtered extensions
    function CanAddFile(const FileName: string): Boolean;

    // checks if source file needs decoding
    function FileNeedsDecoding(const FilePath: string): Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMCopyData(var Message: TWMCopyData); message WM_COPYDATA;
  public
    { Public declarations }
    AppFolder: string;
    AppDataFolder: string;
    MyDoc: string;
    AddingStopped: Boolean;
    IsPortable: Boolean;
    StartPositions, EndPositions, ConstantDurations: TStringList;
    Durations: TStringList;
    TagsList: TList<TTagInfo>;

    // returns % done
{$REGION 'ProgresFuncs'}
    function x264Percentage(const x264Output: string): Integer;
    function FFMpegPercentage(const FFMpegOutput: string; const DurationStr: string): Integer;
    function MkvExtractPercentage(const MkvExtractOutput: string): Integer;
    function SoXPercentage(const SoxOutput: string): Integer;
    function LamePercentage(const LameOutput: string): Integer;
    function FLACPercentage(const FLACOutput: string): Integer;
    function OpusPercentage(const OpusOutput: string; const DurationStr: string): integer;
    function MPCPercentage(const MPCOutput: string): integer;
    function ApePercentage(const APEOutput: string): integer;
    function TAKPercentage(const TAKOutput: string): integer;
    function NeroPercentage(const NeroOutput: string; const DurationStr: string): integer;
    function WMAEncoderPercentage(const WMAOutput: string): integer;
    function FDKPercentage(const FDKOutput: string): integer;
    function LossyWAVPercentage(const LossyWAVOutput: string): integer;
    function dcaencPercentage(const dcaencOutput: string): integer;
    function GetPercentage(const EncoderIndex: integer): integer;
    function GetMergeProgress: integer;
    procedure UpdateProgress;
{$ENDREGION}
    // decides best number of processes
    function DecideNumOfProcesses(): integer;

    // gets temp directory
    function GetTempDirectory: string;

    // writes given message to specified log
    procedure AddToLog(const LogID: ShortInt; const MSG: string);

    // converts int to hh:mm:ss
    function IntToTime(IntTime: Integer): string;
    procedure AssignLabelToProgressBar(Lbl: TsLabel; PB: TsProgressBar);

    // check if string is numeric
    function IsStringNumeric(Str: string): Boolean;

    // removes invalid chars from string
    function RemoveInvalidChars(const Str: string): string;
    function PadString(const Str: string): string;
    function PadString2(const Str: string): string;
    procedure UpdateSummaryLabel;
    procedure GenerateSummaryString;
  end;

const
  SWindowClassName = 'TAudioConverterUniqueName';
  Portable = True;
  Build64Bit = False;
  BuildInt = 3899;
  BITRATE_COLUMN_INDEX = 2;

var
  MainForm: TMainForm;

implementation

uses
  UnitLog, windows7taskbar, UnitInfo, UnitAbout, UnitUpdater, UnitSox,
  UnitProgress, UnitSettings, UnitTag, UnitTrimmer, UnitCodecSettings,
  Unit3rdParty, UnitTagEditor, UnitMergeTag;

{$R *.dfm}

procedure TMainForm.AboutBtnClick(Sender: TObject);
begin

  Self.Enabled := False;
  AboutForm.show;

end;

procedure TMainForm.AddBtnClick(Sender: TObject);
var
  P: TPoint;
begin
  P := AddBtn.ClientToScreen(Point(0, 0));

  AddMenu.Popup(P.X, P.Y + AddBtn.Height)
end;

procedure TMainForm.AddCDTrack(const Track: integer; const TrackCount: integer; const EncoderIndex: Integer);
var
  i: Integer;
  // OutAudioFile: string;
  TmpAudioFileName: string;
  FileName: string;
  AudioStr: string;
  // i, j: Integer;
  FileIndex: integer;
  Encoder: TEncoder;
  DepthStr: string;
  StreamIndexCMD: string;
  // CopyExt: string;
  FileDuration: string;
  OutputExt: string;
  TmpLst: TStringList;
  FileToDeleteStr: string;
  DurationStr: string;
  RP: TRenamePair;
  CopyRGFromLossLessSource: Boolean;
  VolumeStr: string;
  SpeedStr: string;
  FS: TFormatSettings;
  LStartPos, LDur: integer;
  LProgressItem: string;
  LCompressionPair: TCompressionFileNamesPair;
  LRenameFile: TStringList;
begin
  if not FTrackInfoList[Track - 1].WillBeRipped then
    Exit;

  // decide which process to use
  Encoder := FEncoders[EncoderIndex - 1];

  FileName := FTrackInfoList[Track - 1].TempFileName;

  // add to progress list
  LProgressItem := PadInteger(StrToInt(FTrackInfoList[Track - 1].TrackTagInfo.TrackNo)) + ' - ' + FTrackInfoList[Track - 1].TrackTagInfo.Artist + ' - ' + FTrackInfoList[Track - 1].TrackTagInfo.Album + ' - ' + FTrackInfoList[Track - 1].TrackTagInfo.Title;

  TmpAudioFileName := FileName;

{$REGION 'OutputExt'}
  // dest audio extension
  case FAudioEncoderType of
    etFFMpegAAC:
      begin
        if (SettingsForm.AACExtList.ItemIndex = 0) and (SettingsForm.AACExtList.ItemIndex = 3) then
        begin
          OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
        end
        else
        begin
          OutputExt := '.m4a';
        end;
      end;
    etFDKAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etFFMpegAC3:
      begin
        OutputExt := '.ac3';
      end;
    etOgg:
      begin
        OutputExt := '.ogg';
      end;
    etLAME:
      begin
        OutputExt := '.mp3';
        ;
      end;
    etWAV:
      begin
        OutputExt := '.wav';
      end;
    etFLAC:
      begin
        OutputExt := '.flac';
      end;
    etQAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etOpus:
      begin
        OutputExt := '.opus';
      end;
    etMPC:
      begin
        OutputExt := '.mpc';
      end;
    etAPE:
      begin
        OutputExt := '.ape';
      end;
    etTTA:
      begin
        OutputExt := '.tta';
      end;
    etTAK:
      begin
        OutputExt := '.tak';
      end;
    etFHGAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etNeroAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etWMA:
      begin
        OutputExt := '.wma';
      end;
    etWavPack:
      begin
        OutputExt := '.wv';
      end;
    etFFmpegALAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etAIFF:
      begin
        OutputExt := '.aiff';
      end;
    etFLACCL:
      begin
        OutputExt := '.flac';
      end;
    etDCA:
      begin
        OutputExt := '.dts';
      end;
  end;
{$ENDREGION}
{$REGION 'OutputFolder'}
  // generate output file path
  TmpAudioFileName := FileName;

  RP.Output := PadInteger(StrToInt(FTrackInfoList[Track - 1].TrackTagInfo.TrackNo)) + ' - ' + RemoveInvalidChars(FTrackInfoList[Track - 1].TrackTagInfo.Artist) + ' - ' + RemoveInvalidChars(FTrackInfoList[Track - 1].TrackTagInfo.Album) + ' - ' + RemoveInvalidChars(FTrackInfoList[Track - 1].TrackTagInfo.Title);
  RP.Output := ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\' + ExtractFileName(RP.Output) + OutputExt;
  RP.Input := ChangeFileExt(TmpAudioFileName, OutputExt);
  RP.Input := ExcludeTrailingPathDelimiter(DirectoryEdit.Text) + '\' + ExtractFileName(TmpAudioFileName) + OutputExt;

  // if file already exists and skipping is selected
  if FileExists(RP.Output) and (SettingsForm.OverWriteList.ItemIndex = 1) then
  begin
    AddToLog(0, RP.Output + ' already exists, so it is skipped.');
    Exit;
  end;

  // this is here because file index is not added otherwise.
  if FAudioEncoderType = etWAV then
  begin
    RP.Output := ChangeFileExt(TmpAudioFileName, '.wav');
    RP.Input := ExcludeTrailingPathDelimiter(ExtractFileDir(TmpAudioFileName)) + '\' + CreateTempFileName + '.wav'
  end;

  // overwrite settings
  if SettingsForm.OverWriteList.ItemIndex = 0 then
  begin
    FileIndex := 0;

    // add index
    if FileExists(RP.Output) then
    begin
      while FileExists(RP.Output) do
      begin
        Inc(FileIndex);
        if FAudioEncoderType = etWAV then
        begin
          RP.Output := ChangeFileExt(RP.Output, '_' + FloatToStr(FileIndex) + OutputExt);
        end
        else
        begin
          RP.Output := ChangeFileExt(TmpAudioFileName, '_' + FloatToStr(FileIndex) + OutputExt);
        end;
      end;
    end;
  end
  else
  begin
    // ignore
    if FileExists(RP.Output) then
    begin
      AddToLog(0, RP.Output + ' already exists, overwriting.');
    end;
  end;
//  RP.Output := StringReplace(RP.Output, '\\\', '\', [rfReplaceAll]);
  RP.Output := ExtractFilePath(RP.Output) + ExtractFileName(RP.Output);
  // create dest folder
  if not DirectoryExists(ExtractFileDir(RP.Output)) then
  begin
    try
      ForceDirectories(ExtractFileDir(RP.Output))
    except
      on E: Exception do
      begin
        AddToLog(0, 'Could not create folder: ' + ExtractFileDir(RP.Output) + '. Exception message: ' + E.Message);
      end;
    end;
  end;
{$ENDREGION}
  // get duration of file.
  // convert to seconds first.
  FileDuration := FloatToStr(FTrackInfoList[Track - 1].Duration);

  // audio encoding
{$REGION 'Audio Encoding'}
  // file path pair to calculate compression.
  // only for audio to audio.
  LCompressionPair.SourcePath := FileName;
  LCompressionPair.DestinationPath := RP.Output;
  CompressionPairs.Add(LCompressionPair);

  // todo: audio filters

  // in order to show speed
  FTotalLength := FTotalLength + StrToInt(FileDuration);

  // lossyWAV
  if (CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0) and CanUseLossyWAV then
  begin
    AudioStr := '';
    AudioStr := AudioStr + '" " "' + TmpAudioFileName + '" ';
    case CodecSettingsForm.LossyWAVQualityList.ItemIndex of
      1:
        AudioStr := AudioStr + ' -q I';
      2:
        AudioStr := AudioStr + ' -q E';
      3:
        AudioStr := AudioStr + ' -q H';
      4:
        AudioStr := AudioStr + ' -q S';
      5:
        AudioStr := AudioStr + ' -q C';
      6:
        AudioStr := AudioStr + ' -q P';
      7:
        AudioStr := AudioStr + ' -q X';
    end;
    AudioStr := AudioStr + ' -o "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '"';
    TmpAudioFileName := ChangeFileExt(TmpAudioFileName, '.lossy.wav');

    Encoder.CommandLines.Add(AudioStr);
    Encoder.Paths.Add(FLossyWAVPath);
    Encoder.FileNames.Add(FileName);
    Encoder.Infos.Add('lossyWAV');
    Encoder.Durations.Add('1');
    Encoder.TempFiles.Add('');
    FileToDeleteStr := FileToDeleteStr + TmpAudioFileName + '|';
    Encoder.ProcessTypes.Add(etLossyWAV);
    Encoder.FileIndexes.Add(FloatToStr(Track - 1));
    Encoder.ListItems.Add(LProgressItem);
  end;

  // audio encoding
  AudioStr := '';

  case FAudioEncoderType of
    etFFMpegAAC: // ffmpeg aac
      begin

        // encoding mode
        AudioStr := AudioStr + ' -b:a ' + CodecSettingsForm.FAACBitrateEdit.Text + '000';

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FFMpegAACCMD;
        AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + ' -y -i "' + TmpAudioFileName + '" ' + AudioStr + ' "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etFFMpegAAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' -r -t -p';
          if SettingsForm.RGAutoLowerBtn.Checked then
          begin
            AudioStr := AudioStr + ' -k ';
          end
          else
          begin
            AudioStr := AudioStr + ' /c ';
          end;
          AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FAACGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('ReplayGain');
          Encoder.ProcessTypes.Add(etAACGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etQAAC: // qaac
      begin
        // encoding mode
        case CodecSettingsForm.QaacEncodeMethodList.ItemIndex of
          0: // abr
            begin
              AudioStr := AudioStr + ' --abr ' + CodecSettingsForm.QaacBitrateEdit.Text;
            end;
          1: // tvbr
            begin
              AudioStr := AudioStr + ' --tvbr ' + CodecSettingsForm.QaacvQualityEdit.Text;
            end;
          2: // cvbr
            begin
              AudioStr := AudioStr + ' --cvbr ' + CodecSettingsForm.QaacBitrateEdit.Text;
            end;
          3: // cbr
            begin
              AudioStr := AudioStr + ' --cbr ' + CodecSettingsForm.QaacBitrateEdit.Text;
            end;
        end;

        // profile
        if CodecSettingsForm.QaacHEBtn.Checked then
        begin
          AudioStr := AudioStr + ' --he';
        end;

        if CodecSettingsForm.QaacNoDelayBtn.Checked then
        begin
          AudioStr := AudioStr + ' --no-delay';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.QAACCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' --ignorelength --rate keep "' + TmpAudioFileName + '" -o "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FQaacPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add('1');
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etQAAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' -r -t -p';
          if SettingsForm.RGAutoLowerBtn.Checked then
          begin
            AudioStr := AudioStr + ' -k ';
          end
          else
          begin
            AudioStr := AudioStr + ' /c ';
          end;
          AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FAACGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('ReplayGain');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etAACGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;

      end;
    etFFMpegAC3: // ac3
      begin
        // encoding mode
        case CodecSettingsForm.AftenEncodeList.ItemIndex of
          0: // quality
            begin
              AudioStr := AudioStr + ' -q:a ' + CodecSettingsForm.AftenQualityEdit.Text;
            end;
          1: // cbr
            begin
              AudioStr := AudioStr + ' -b:a ' + CodecSettingsForm.AftenBitrateEdit.Text + '000';
            end;
        end;

        if CodecSettingsForm.AftenDialogBtn.Checked then
        begin
          AudioStr := AudioStr + ' -dialnorm ' + CodecSettingsForm.AftenDialogEdit.Text;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.AC3CMD;
        AudioStr := ' -y -i "' + TmpAudioFileName + '" ' + AudioStr + ' -acodec ac3 "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etFFMpegAC3);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);
      end;
    etOgg: // oggenc
      begin
        // encoding mode
        case CodecSettingsForm.OggencodeList.ItemIndex of
          0: // quality
            begin
              AudioStr := AudioStr + ' -q ' + CodecSettingsForm.OggQualityEdit.Text;
            end;
          1: // bitrate
            begin
              AudioStr := AudioStr + ' -b ' + CodecSettingsForm.OggBitrateEdit.Text;

              // managed bitrate mode
              if CodecSettingsForm.OggManagedBitrateBtn.Checked then
              begin
                AudioStr := AudioStr + ' --managed ';
              end
              else
              begin
                AudioStr := AudioStr + ' -m ' + CodecSettingsForm.OggMinBitrateEdit.Text + ' -M ' + CodecSettingsForm.OggMaxBitrateEdit.Text;
              end;

            end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.OggCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + '  "' + TmpAudioFileName + '" -o "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FOggEncPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etOgg);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked and CodecSettingsForm.OggUseTTaggerBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;

        // replaygain
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          AudioStr := ' -s ';
          AudioStr := AudioStr + ' -a "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FVorbisGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('ReplayGain');
          Encoder.ProcessTypes.Add(etVorbisGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etLAME: // lame
      begin

        case CodecSettingsForm.LameEncodeList.ItemIndex of
          0: // cbr
            begin
              AudioStr := AudioStr + ' --cbr -b ' + CodecSettingsForm.LameBitrateEdit.Text;
            end;
          1: // abr
            begin
              AudioStr := AudioStr + ' --abr ' + CodecSettingsForm.LameBitrateEdit.Text;
            end;
          2: // vbr
            begin
              AudioStr := AudioStr + ' -V ' + ReplaceStr(CodecSettingsForm.LameVBREdit.Text, ',', '.');
            end;
        end;

        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' --nohist  -q ' + CodecSettingsForm.LameQualityEdit.Text;

        // tags
        case CodecSettingsForm.LameTagList.ItemIndex of
          1:
            AudioStr := AudioStr + ' --id3v1-only ';
          2:
            AudioStr := AudioStr + ' --id3v2-only ';
        end;

        // channels
        if CodecSettingsForm.LameChannelList.ItemIndex > 0 then
        begin
          case CodecSettingsForm.LameChannelList.ItemIndex of
            1:
              AudioStr := AudioStr + ' -m s ';
            2:
              AudioStr := AudioStr + ' -m j ';
            3:
              AudioStr := AudioStr + ' -m f ';
            4:
              AudioStr := AudioStr + ' -m d ';
            5:
              AudioStr := AudioStr + ' -m m ';
            6:
              AudioStr := AudioStr + ' -m l ';
            7:
              AudioStr := AudioStr + ' -m r ';
          end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.LameCMD;
        AudioStr := AudioStr + '  "' + TmpAudioFileName + '" -o "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FLamePath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etLAME);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        if CodecSettingsForm.LameUseTTaggerBtn.Checked then
        begin
          // write tag
          if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
          begin
            AudioStr := '';
            AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

            Encoder.CommandLines.Add(AudioStr);
            Encoder.Paths.Add(FTTaggerPath);
            Encoder.FileNames.Add(FileName);
            Encoder.TempFiles.Add('');
            Encoder.Durations.Add('1');
            Encoder.Infos.Add('Writing Tags');
            Encoder.ProcessTypes.Add(etTTagger);
            Encoder.FileIndexes.Add(FloatToStr(Track - 1));
            Encoder.ListItems.Add(LProgressItem);
          end;
        end;

        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' -r -t -p';
          if SettingsForm.RGAutoLowerBtn.Checked then
          begin
            AudioStr := AudioStr + ' -k ';
          end
          else
          begin
            AudioStr := AudioStr + ' /c ';
          end;
          AudioStr := AudioStr + ' /d ' + StringReplace(FloatToStr((SettingsForm.ReplayGainBar.Position - 890) / 10), ',', '.', [rfReplaceAll]);
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FMp3GainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('ReplayGain');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etMP3Gain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;

      end;
    etWAV: // wav
      begin

      end;
    etFLAC: // flac
      begin

        AudioStr := AudioStr + ' -' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex);

        if CodecSettingsForm.FLACEMSBtn.Checked then
        begin
          AudioStr := AudioStr + ' -e ';
        end;

        // if CodecSettingsForm.FLACReplaygainBtn.Checked then
        // begin
        // AudioStr := AudioStr + ' --replay-gain'
        // end;

        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' -f';
        end;

        if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
        begin
          if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
          begin
            AudioStr := AudioStr + ' -b 512 --keep-foreign-metadata '
          end;
        end;

        if CodecSettingsForm.FLACVerifyBtn.Checked then
        begin
          AudioStr := AudioStr + ' --verify ';
        end;

        // last cmd
        AudioStr := AudioStr + CodecSettingsForm.FLACCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + '  "' + TmpAudioFileName + '" -o "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFLACPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFLAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        if CodecSettingsForm.FLACUseTTaggerBtn.Checked then
        begin
          // write tag
          if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
          begin
            AudioStr := '';
            AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

            Encoder.CommandLines.Add(AudioStr);
            Encoder.Paths.Add(FTTaggerPath);
            Encoder.FileNames.Add(FileName);
            Encoder.TempFiles.Add('');
            Encoder.Durations.Add('1');
            Encoder.Infos.Add('Writing Tags');
            Encoder.ProcessTypes.Add(etTTagger);
            Encoder.FileIndexes.Add(FloatToStr(Track - 1));
            Encoder.ListItems.Add(LProgressItem);
          end;
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          CopyRGFromLossLessSource := IsSourceLossless(FileName) and SettingsForm.RGLToLBtn.Checked;
          if CopyRGFromLossLessSource then
          begin
            // get rg values from source
          end
          else
          begin
            // replaygain
            AudioStr := '';
            AudioStr := ' --add-replay-gain "' + RP.Input + '"';

            Encoder.CommandLines.Add(AudioStr);
            Encoder.Paths.Add(FMetaFlacPath);
            Encoder.FileNames.Add(FileName);
            Encoder.TempFiles.Add('');
            Encoder.Infos.Add('ReplayGain');
            Encoder.Durations.Add('1');
            Encoder.ProcessTypes.Add(etMetaFlac);
            Encoder.FileIndexes.Add(FloatToStr(Track - 1));
            Encoder.ListItems.Add(LProgressItem);
          end;
        end;
      end;
    etFHGAAC: // FHG
      begin

        // encoding mode
        case CodecSettingsForm.FHGMethodList.ItemIndex of
          0: // cbr
            begin
              AudioStr := AudioStr + ' --cbr ' + CodecSettingsForm.FHGBitrateEdit.Text;

              // profile
              case CodecSettingsForm.FHGProfileList.ItemIndex of
                0:
                  AudioStr := AudioStr + ' --profile auto';
                1:
                  AudioStr := AudioStr + ' --profile lc';
                2:
                  AudioStr := AudioStr + ' --profile he';
                3:
                  AudioStr := AudioStr + ' --profile hev2';
              end;
            end;
          1: // vbr
            begin
              AudioStr := AudioStr + ' --vbr ' + CodecSettingsForm.FHGQualityEdit.Text;
            end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FHGAACCMD;
        AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + AudioStr + ' "' + TmpAudioFileName + '" "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFHGPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFHGAAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' -r -t -p';
          if SettingsForm.RGAutoLowerBtn.Checked then
          begin
            AudioStr := AudioStr + ' -k ';
          end
          else
          begin
            AudioStr := AudioStr + ' /c ';
          end;
          AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FAACGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('ReplayGain');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etAACGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;

      end;
    etOpus: // opus
      begin

        // encoding mode
        case CodecSettingsForm.OpusEncodeMethodList.ItemIndex of
          0: // vbr
            begin
              AudioStr := AudioStr + ' --vbr ';
            end;
          1: // cvbr
            begin
              AudioStr := AudioStr + ' --cvbr ';
            end;
          2: // cbr
            begin
              AudioStr := AudioStr + ' --hard-cbr ';
            end;
        end;

        AudioStr := AudioStr + ' --comp ' + CodecSettingsForm.OpusCompEdit.Text;
        AudioStr := AudioStr + ' --bitrate ' + CodecSettingsForm.OpusBitrateEdit.Text;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.OpusCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' "' + TmpAudioFileName + '" "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FOpusPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etOpus);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked and CodecSettingsForm.OpusUseTTaggerBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('Writing Tags');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etMPC: // mpc
      begin
        AudioStr := AudioStr + ' --quality ' + CodecSettingsForm.MPCQualityEdit.Text + ' --unicode ';
        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' --overwrite '
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.MPCCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' "' + TmpAudioFileName + '" "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FMPCPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etMPC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FMPCGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('ReplayGain');
          Encoder.ProcessTypes.Add(etMPCGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etAPE: // ape
      begin

        case CodecSettingsForm.MACLevelList.ItemIndex of
          0:
            AudioStr := AudioStr + ' -c1000';
          1:
            AudioStr := AudioStr + ' -c2000';
          2:
            AudioStr := AudioStr + ' -c3000';
          3:
            AudioStr := AudioStr + ' -c4000';
          4:
            AudioStr := AudioStr + ' -c5000';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.APECMD;
        AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + ' "' + TmpAudioFileName + '" "' + RP.Input + '" ' + AudioStr;

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FMACPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etAPE);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etTTA: // tta
      begin

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.TTACMD;
        AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + ' -e "' + TmpAudioFileName + '" -o "' + RP.Input + '" ';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FTTAPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etTTA);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etTAK: // tak
      begin

        // last cmd
        AudioStr := '" " -e -p' + FloatToStr(CodecSettingsForm.TAKPresetList.ItemIndex);
        case CodecSettingsForm.TAKLevelList.ItemIndex of
          1:
            AudioStr := AudioStr + 'e ';
          2:
            AudioStr := AudioStr + 'm ';
        end;

        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' -overwrite';
        end;

        if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
        begin
          if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
          begin
            AudioStr := AudioStr + ' -fsl512 '
          end;
        end;

        if CodecSettingsForm.TAKMd5Btn.Checked then
        begin
          AudioStr := AudioStr + ' -md5 ';
        end;

        if CodecSettingsForm.TAKVerifyBtn.Checked then
        begin
          AudioStr := AudioStr + ' -v '
        end;

        AudioStr := AudioStr + ' ' + CodecSettingsForm.TAKCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' "' + TmpAudioFileName + '" "' + RP.Input + '" ';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FTAKPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etTAK);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etNeroAAC: // neroaac
      begin

        // encoding mode
        case CodecSettingsForm.NeroMethodList.ItemIndex of
          0: // quality
            begin
              AudioStr := AudioStr + ' -q ' + ReplaceStr(FloatToStr(CodecSettingsForm.NeroQualityBar.Position / 100), ',', '.');
            end;
          1: // abr
            begin
              AudioStr := AudioStr + ' -br ' + CodecSettingsForm.NeroBitrateEdit.Text + '000';
            end;
          2: // cbr
            begin
              AudioStr := AudioStr + ' -cbr ' + CodecSettingsForm.NeroBitrateEdit.Text + '000';
            end;
        end;

        // profile
        case CodecSettingsForm.NeroProfileList.ItemIndex of
          1:
            AudioStr := AudioStr + ' -lc';
          2:
            AudioStr := AudioStr + ' -he';
          3:
            AudioStr := AudioStr + ' -hev2';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.NeroAACCMD;
        AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + AudioStr + ' -if "' + TmpAudioFileName + '" -of "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FNeroEncPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etNeroAAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' -r -t -p';
          if SettingsForm.RGAutoLowerBtn.Checked then
          begin
            AudioStr := AudioStr + ' -k ';
          end
          else
          begin
            AudioStr := AudioStr + ' /c ';
          end;
          AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FAACGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('ReplayGain');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etAACGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;

      end;
    etFFmpegALAC: // alac
      begin
        // last cmd
        AudioStr := ' -y -i "' + TmpAudioFileName + '" -c:a alac -vn "' + RP.Input + '" ' + CDCreateTagCMD(TrackCount, Track - 1) + ' ' + CodecSettingsForm.ALACCMD;

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFFmpegALAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('Writing Tags');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etWMA: // wmaencoder
      begin
        case CodecSettingsForm.WMAMethodList.ItemIndex of
          0:
            begin
              AudioStr := AudioStr + ' --quality ' + CodecSettingsForm.WMAQualityList.Text;
            end;
          1:
            begin
              AudioStr := AudioStr + ' --bitrate ' + CodecSettingsForm.WMABitrateEdit.Text
            end;
        end;

        case CodecSettingsForm.WMACodecList.ItemIndex of
          0:
            AudioStr := AudioStr + ' --codec std ';
          1:
            AudioStr := AudioStr + ' --codec pro ';
          2:
            AudioStr := AudioStr + ' --codec lsl ';
          3:
            AudioStr := AudioStr + ' --codec voice ';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.WMACMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' "' + TmpAudioFileName + '" "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FWmaEncodePath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etWMA);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etWavPack: // wavpack
      begin
        case CodecSettingsForm.WavPackMethodList.ItemIndex of
          0:
            begin
              AudioStr := AudioStr + ' ';
            end;
          1:
            begin
              AudioStr := AudioStr + ' -b' + CodecSettingsForm.WavPackBitrateEdit.Text;

              if CodecSettingsForm.WavPackCorrectionBtn.Checked then
              begin
                AudioStr := AudioStr + ' -c '
              end;
            end;
        end;

        AudioStr := AudioStr + ' -h ';
        if CodecSettingsForm.WavPackExtraBtn.Checked then
        begin
          AudioStr := AudioStr + ' -x '
        end;
        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' -y ';
        end;

        // for lossywav
        if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
        begin
          if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
          begin
            AudioStr := AudioStr + ' --blocksize=512 --merge-blocks '
          end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.WavPackCMD;
        AudioStr := AudioStr + CDCreateTagCMD(TrackCount, Track - 1) + ' "' + TmpAudioFileName + '" "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FWavPackPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etWavPack);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etFDKAAC: // fdk-aac
      begin
        // bitrate
        if CodecSettingsForm.FDKMethodList.ItemIndex = 0 then
        begin
          AudioStr := AudioStr + ' -m 0 -b ' + CodecSettingsForm.FDKBitrateEdit.Text;
        end
        else
        begin
          AudioStr := AudioStr + ' -m ' + FloatToStr(CodecSettingsForm.FDKVBRBar.Position)
        end;

        // profile
        case CodecSettingsForm.FDKProfileList.ItemIndex of
          0:
            AudioStr := AudioStr + ' -p 2';
          1:
            AudioStr := AudioStr + ' -p 5';
          2:
            AudioStr := AudioStr + ' -p 29';
          3:
            AudioStr := AudioStr + ' -p 23';
          4:
            AudioStr := AudioStr + ' -p 39';
          5:
            AudioStr := AudioStr + ' -p 129';
          6:
            AudioStr := AudioStr + ' -p 132';
          7:
            AudioStr := AudioStr + ' -p 156';
        end;

        // gapless
        AudioStr := AudioStr + ' -G ' + FloatToStr(CodecSettingsForm.FDKGaplessList.ItemIndex) + ' --moov-before-mdat --ignorelength ';

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FDKAACCMD;
        AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + AudioStr + ' "' + TmpAudioFileName + '" -o "' + RP.Input + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFdkAACPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFDKAAC);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
        begin
          AudioStr := '';
          AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FTTaggerPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Durations.Add('1');
          Encoder.Infos.Add('Writing Tags');
          Encoder.ProcessTypes.Add(etTTagger);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' -r -t -p';
          if SettingsForm.RGAutoLowerBtn.Checked then
          begin
            AudioStr := AudioStr + ' -k ';
          end
          else
          begin
            AudioStr := AudioStr + ' /c ';
          end;
          AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
          // AudioStr := AudioStr + ' -d ' + StringReplace(FloatToStr((SettingsForm.ReplayGainBar.Position - 890) / 10), ',', '.', [rfReplaceAll]);
          AudioStr := AudioStr + ' "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FAACGainPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('ReplayGain');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etAACGain);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;

      end;
    etAIFF: // aiff
      begin
        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.AIFFCMD;
        AudioStr := ' -y -i "' + FileName + '" -f aiff ' + CDCreateTagCMD(TrackCount, Track - 1) + ' "' + RP.Input + '"';

        Encoder.Paths.Add(FFFMpegPath);
        Encoder.CommandLines.Add(AudioStr);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etAIFF);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);
      end;
    etFLACCL: // flaccl
      begin
        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FLACCLCMD;
        AudioStr := ' -' + CodecSettingsForm.FLACCLLevelList.Text + ' "' + TmpAudioFileName + '" -o "' + RP.Input + '"';

        Encoder.Paths.Add(FFLACCLPath);
        Encoder.CommandLines.Add(AudioStr);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etFLACCL);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);

        // write tag
        if CodecSettingsForm.FLACCLUseTTaggerBtn.Checked then
        begin
          // use ttagger
          if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
          begin
            // to create tag.txt file
            AudioStr := CDCreateTagCMD(TrackCount, Track - 1);
            AudioStr := '';
            AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Track - 1) + 'tag.txt" "' + RP.Input + '"';

            Encoder.CommandLines.Add(AudioStr);
            Encoder.Paths.Add(FTTaggerPath);
            Encoder.FileNames.Add(FileName);
            Encoder.TempFiles.Add('');
            Encoder.Infos.Add('Writing Tags');
            Encoder.Durations.Add('1');
            Encoder.ProcessTypes.Add(etTTagger);
            Encoder.FileIndexes.Add(FloatToStr(Track - 1));
            Encoder.ListItems.Add(LProgressItem);
          end;
        end
        else
        begin
          // use flac.exe
          AudioStr := CDCreateTagCMD(TrackCount, Track - 1) + '  "' + RP.Input + '" -f -o "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FFLACPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add(FileToDeleteStr);
          Encoder.Infos.Add('Writing tags');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etFLAC);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
        if SettingsForm.ReplayGainBtn.Checked then
        begin
          // replaygain
          AudioStr := '';
          AudioStr := ' --add-replay-gain "' + RP.Input + '"';

          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FMetaFlacPath);
          Encoder.FileNames.Add(FileName);
          Encoder.TempFiles.Add('');
          Encoder.Infos.Add('ReplayGain');
          Encoder.Durations.Add('1');
          Encoder.ProcessTypes.Add(etMetaFlac);
          Encoder.FileIndexes.Add(FloatToStr(Track - 1));
          Encoder.ListItems.Add(LProgressItem);
        end;
      end;
    etDCA: // dca
      begin
        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.DcaencCMD;
        AudioStr := ' -i "' + TmpAudioFileName + '" -o "' + RP.Input + '" -b ' + CodecSettingsForm.DCABitrateEdit.Text;

        Encoder.Paths.Add(FDCAENCPath);
        Encoder.CommandLines.Add(AudioStr);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etDCA);
        Encoder.FileIndexes.Add(FloatToStr(Track - 1));
        Encoder.ListItems.Add(LProgressItem);
      end;
  end;
{$ENDREGION}
  FilesToCheck.Add(RP.Output);
  // RenamePairs.Add(RP);
  // RenamePairs.Add(RP);
  // rename tool
  LRenameFile := TStringList.Create;
  try
    LRenameFile.Add(FloatToStr(SettingsForm.OverWriteList.ItemIndex + 1));
    LRenameFile.Add(RP.Input);
    LRenameFile.Add(RP.Output);
    LRenameFile.SaveToFile(ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\rename' + FloatToStr(Track) + '.txt', TEncoding.UTF8);
  finally
    LRenameFile.Free;
  end;
  AudioStr := '" " "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\rename' + FloatToStr(Track) + '.txt"';

  Encoder.Paths.Add(FRenameToolPath);
  Encoder.CommandLines.Add(AudioStr);
  Encoder.FileNames.Add(FileName);
  Encoder.TempFiles.Add('');
  Encoder.Durations.Add(FileDuration);
  Encoder.Infos.Add('Renaming');
  Encoder.ProcessTypes.Add(etRenameTool);
  Encoder.FileIndexes.Add(FloatToStr(Track - 1));
  Encoder.ListItems.Add(LProgressItem);
end;

procedure TMainForm.AddCDTracks;
var
  I: Integer;
  NumberOfProcesses: Integer;
begin
  if (SettingsForm.ProcessCountList.ItemIndex + 1) > FTrackInfoList.Count then
  begin
    NumberOfProcesses := FTrackInfoList.Count;
  end
  else
  begin
    NumberOfProcesses := SettingsForm.ProcessCountList.ItemIndex + 1;
  end;

  for I := 0 to FTrackInfoList.Count - 1 do
  begin
    Application.ProcessMessages;
    AddCDTrack(I + 1, FTrackInfoList.Count, (I mod NumberOfProcesses) + 1);
  end;
end;

procedure TMainForm.AddCommandLine(Index: Integer; AdvancedOptions: string; const EncoderIndex: integer);
var
  // OutAudioFile: string;
  LTmpAudioFileName: string;
  FileName: string;
  AudioStr: string;
  // i, j: Integer;
  FileIndex: integer;
  Encoder: TEncoder;
  DepthStr: string;
  StreamIndexCMD: string;
  // CopyExt: string;
  FileDuration: string;
  OutputExt: string;
  TmpLst: TStringList;
  FileToDeleteStr: string;
  DurationStr: string;
  RP: TRenamePair;
  CopyRGFromLossLessSource: Boolean;
  VolumeStr: string;
  SpeedStr: string;
  FS: TFormatSettings;
  LStartPos, LDur: integer;
  LCompressionPair: TCompressionFileNamesPair;
  LRenameFile: TStringList;
  LProgressItem: string;
  LOutputFolder: string;
  LOutputFileName: string;
begin
  // decide which process to use
  Encoder := FEncoders[EncoderIndex - 1];

  // paths and files
  FileName := Files[Index];
  LOutputFileName := FileName;

{$REGION 'Progress list fill'}
  // if file is cue
  if TagsList[Index].FileType = 'cue' then
  begin
    LProgressItem := TagsList[Index].TrackNo + ' - ' + TagsList[Index].ArtistForFileName + ' - ' + TagsList[Index].AlbumForFileName + ' - ' + TagsList[Index].TitleForFileName;
  end
  else if TagsList[Index].FileType = 'cd' then
  begin
    LProgressItem := TagsList[Index].TrackNo + ' - ' + TagsList[Index].ArtistForFileName + ' - ' + TagsList[Index].AlbumForFileName + ' - ' + TagsList[Index].TitleForFileName;
  end
  else
  begin
    // if file doesn't exist just ignore it
    if not FileExists(FileName) then
    begin
      AddToLog(0, FileName + ' doesn''t exist, ignored.');
    end
    else
    begin
      LProgressItem := ExtractFileName(FileName);
    end;
  end;
{$ENDREGION}
{$REGION 'OutputExt'}
  // dest audio extension
  case AudioMethodList.ItemIndex of
    0: // encode audio
      begin
        case FAudioEncoderType of
          etFFMpegAAC:
            begin
              if (SettingsForm.AACExtList.ItemIndex = 0) and (SettingsForm.AACExtList.ItemIndex = 3) then
              begin
                OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
              end
              else
              begin
                OutputExt := '.m4a';
              end;
            end;
          etFDKAAC:
            begin
              OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
            end;
          etFFMpegAC3:
            begin
              OutputExt := '.ac3';
            end;
          etOgg:
            begin
              OutputExt := '.ogg';
            end;
          etLAME:
            begin
              OutputExt := '.mp3';
              ;
            end;
          etWAV:
            begin
              OutputExt := '.wav';
            end;
          etFLAC:
            begin
              OutputExt := '.flac';
            end;
          etQAAC:
            begin
              OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
            end;
          etOpus:
            begin
              OutputExt := '.opus';
            end;
          etMPC:
            begin
              OutputExt := '.mpc';
            end;
          etAPE:
            begin
              OutputExt := '.ape';
            end;
          etTTA:
            begin
              OutputExt := '.tta';
            end;
          etTAK:
            begin
              OutputExt := '.tak';
            end;
          etFHGAAC:
            begin
              OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
            end;
          etNeroAAC:
            begin
              OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
            end;
          etWMA:
            begin
              OutputExt := '.wma';
            end;
          etWavPack:
            begin
              OutputExt := '.wv';
            end;
          etFFmpegALAC:
            begin
              OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
            end;
          etAIFF:
            begin
              OutputExt := '.aiff';
            end;
          etFLACCL:
            begin
              OutputExt := '.flac';
            end;
          etDCA:
            begin
              OutputExt := '.dts';
            end;
        end;
      end;
    1: // copy audio
      begin
        OutputExt := CodecToExtension(CopyExtension[Index]);
      end;
  end;

{$ENDREGION}
{$REGION 'OutputFolder'}
  if not SameAsSourceBtn.Checked then
  begin
    // output folder
    LOutputFolder := ExcludeTrailingPathDelimiter(DirectoryEdit.Text);
  end
  else
  begin
    // same as source
    LOutputFolder := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
  end;
  if TagsList[Index].FileType = 'cue' then
  begin
    // use one of the folder creation options
    if SettingsForm.FolderStructBtn.Checked then
    begin
      if SettingsForm.FolderStructList.ItemIndex <> 2 then
      begin
        // use source file name as base for output file name
        LOutputFileName := LOutputFolder + '\' + GetFileFolderName(FileName, Index) + '\' + GetCueCustomFileName(TagsList[Index], '%tracknumber% - %title% - %album%');
        RP.Output := ChangeFileExt(LOutputFileName, OutputExt);
      end
      else
      begin
        // custom tree
        LOutputFileName := LOutputFolder + '\' + GetFileFolderName(FileName, Index) + '\' + GetCustomFileName(SettingsForm.CustomFileNameEdit.Text, FileName, Index);
        RP.Output := LOutputFileName + OutputExt;
      end;
    end
    else
    begin
      // if source is a cue sheet a file name must be provided by using tags because all files have the same source file name
      // todo: add option to specify tag fields here
      LOutputFileName := LOutputFolder + '\' + GetCueCustomFileName(TagsList[Index], '%tracknumber% - %title% - %album%');
      RP.Output := LOutputFileName + OutputExt;
    end;
  end
  else
  begin
    if SettingsForm.FolderStructBtn.Checked then
    begin
      if SettingsForm.FolderStructList.ItemIndex <> 2 then
      begin
        // use source file name as base for output file name
        LOutputFileName := LOutputFolder + '\' + GetFileFolderName(FileName, Index) + '\' + ExtractFileName(FileName);
        RP.Output := ChangeFileExt(LOutputFileName, OutputExt);
      end
      else
      begin
        // custom tree
        LOutputFileName := LOutputFolder + '\' + GetFileFolderName(FileName, Index) + '\' + GetCustomFileName(SettingsForm.CustomFileNameEdit.Text, FileName, Index);
        RP.Output := LOutputFileName + OutputExt;
      end;
    end
    else
    begin
      // if no folder struct option is selected, simply use source' filename
      LOutputFileName := LOutputFolder + '\' + ChangeFileExt(ExtractFileName(FileName), OutputExt);
      RP.Output := LOutputFileName;
    end;
  end;
  LTmpAudioFileName := ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + CreateTempFileName + '.wav';
  RP.Output := StringReplace(RP.Output, '\\\\', '\', [rfReplaceAll]);
  RP.Output := StringReplace(RP.Output, '\\\', '\', [rfReplaceAll]);
  RP.Output := StringReplace(RP.Output, '\\', '\', [rfReplaceAll]);
  RP.Input := ExcludeTrailingPathDelimiter(ExtractFileDir(RP.Output)) + '\' + ChangeFileExt(ExtractFileName(LTmpAudioFileName), '') + OutputExt;

  // if file already exists and skipping is selected
  if FileExists(RP.Output) and (SettingsForm.OverWriteList.ItemIndex = 1) then
  begin
    AddToLog(0, RP.Output + ' already exists, so it is skipped.');
    Exit;
  end;

  // this is here because file index is not added otherwise.
  // if FAudioEncoderType = etWAV then
  // begin
  // RP.Output := ChangeFileExt(LTmpAudioFileName, '.wav');
  // RP.Input := ExcludeTrailingPathDelimiter(ExtractFileDir(LTmpAudioFileName)) + '\' + CreateTempFileName + '.wav'
  // end;

  // overwrite settings
  if SettingsForm.OverWriteList.ItemIndex = 0 then
  begin
    FileIndex := 0;

    // add index
    if FileExists(RP.Output) then
    begin
      while FileExists(RP.Output) do
      begin
        Inc(FileIndex);
        if FAudioEncoderType = etWAV then
        begin
          RP.Output := ChangeFileExt(RP.Output, '_' + FloatToStr(FileIndex) + OutputExt);
        end
        else
        begin
          RP.Output := ChangeFileExt(LTmpAudioFileName, '_' + FloatToStr(FileIndex) + OutputExt);
        end;
      end;
    end;
  end
  else
  begin
    // overwrite
    if FileExists(RP.Output) then
    begin
      AddToLog(0, RP.Output + ' already exists, overwriting.');
    end;
  end;

  // create dest folder
  if not DirectoryExists(ExtractFileDir(RP.Output)) then
  begin

    try
      ForceDirectories(ExtractFileDir(RP.Output))
    except
      on E: Exception do
      begin
        AddToLog(0, 'Could not create folder: ' + ExtractFileDir(RP.Output) + '. Exception message: ' + E.Message);
      end;
    end;
  end;

  // create artwork in output folder
  if SettingsForm.ArtworkBtn.Checked then
  begin
    // copy artwork to output folder
    if SettingsForm.ArtworkList.ItemIndex = 0 then
    begin
      SaveArtwork(FileName, ExtractFileDir(RP.Output), Index, RP.Output);

      // copy external artowk
      if SettingsForm.Artwork2Btn.Checked then
      begin
        SaveExternalArtwork(ExtractFileDir(FileName), ExtractFileDir(RP.Output));
      end;
    end;

  end;
{$ENDREGION}
  // get duration of file.
  // convert to seconds first.
  FileDuration := FloatToStr(StrToInt(Durations[Index]) div 1000);

  // audio encoding
  case AudioMethodList.ItemIndex of
    0: // encode audio
      begin
{$REGION 'Audio Encoding'}
        // file path pair to calculate compression.
        // only for audio to audio.
        if IsAudioOnly(FileName) then
        begin
          LCompressionPair.SourcePath := FileName;
          LCompressionPair.DestinationPath := RP.Output;
          CompressionPairs.Add(LCompressionPair);
        end;

        // there must a selected audio stream
        if AudioIndexes[Index] <> '-1' then
        begin
          // don't do decoding for cd source.
          // todo: find a way to do trimming with it.
          if TagsList[Index].FileType <> 'cd' then
          begin
            // bit depth
            case CodecSettingsForm.BitDepthList.ItemIndex of
              0:
                DepthStr := CreateBitDepthCMD(FileName);
              1:
                DepthStr := '-acodec pcm_s16le';
              2:
                DepthStr := '-acodec pcm_s24le';
              3:
                DepthStr := '-acodec pcm_s32le';
            end;

            // stream index
            if IsAudioOnly(FileName) then
            begin
              StreamIndexCMD := ' ';
            end
            else
            begin
              StreamIndexCMD := '-map 0:' + AudioIndexes[Index] + ' ';
            end;

            // audio decoding
            AudioStr := ' -y -i "' + FileName + '" -threads 1 -vn ' + DepthStr + ' -f wav ' + StreamIndexCMD;
            if FAudioEncoderType = etWAV then
            begin
              AudioStr := AudioStr + ' ' + CodecSettingsForm.WAVCMD;
            end;

            // lame cannot encode to multi channel
            // channel must be stereo for aac-hev2
            // todo: check other FEncoders to see if they support multi channel
            // todo: read channel info when adding the file
            if (FAudioEncoderType = etLAME) or IsHEv2Selected then
            begin
              if GetChannelCount(FileName, StrToInt(AudioIndexes[Index])) > 2 then
              begin
                AudioStr := AudioStr + ' -ac 2';
              end;
            end
            else
            begin
              case CodecSettingsForm.ChannelList.ItemIndex of
                1:
                  AudioStr := AudioStr + ' -ac 1';
                2:
                  AudioStr := AudioStr + ' -ac 2';
                3:
                  AudioStr := AudioStr + ' -ac 6';
              end;
            end;

            // sample rate
            if CodecSettingsForm.SampleList.ItemIndex > 0 then
            begin
              AudioStr := AudioStr + ' -af aresample=resampler=soxr -ar ' + CodecSettingsForm.SampleList.Text;
            end;

            // we have to have trimming values for
            // cue sheets
            if TagsList[Index].FileType = 'cue' then
            begin
              FS.DecimalSeparator := '.';
              LStartPos := StrToInt(StartPositions[Index]);
              LDur := StrToInt(EndPositions[Index]) - StrToInt(StartPositions[Index]);
              DurationStr := ' -ss ' + IntToTime(LStartPos div 1000) + FormatFloat('#.###', ((LStartPos / 1000) - (LStartPos div 1000)), FS) + ' -t ' + IntToTime(LDur div 1000) + FormatFloat('#.###', ((LDur / 1000) - (LDur div 1000)), FS);
            end
            else
            begin
              // disable trimming
              if SettingsForm.DontTrimBtn.Checked then
              begin
                DurationStr := ' ';
              end
              else
              begin
                FS.DecimalSeparator := '.';
                LStartPos := StrToInt(StartPositions[Index]);
                LDur := StrToInt(EndPositions[Index]) - StrToInt(StartPositions[Index]);
                if LDur <> StrToInt(ConstantDurations[Index]) then
                begin
                  DurationStr := ' -ss ' + IntToTime(LStartPos div 1000) + FormatFloat('#.###', ((LStartPos / 1000) - (LStartPos div 1000)), FS) + ' -t ' + IntToTime(LDur div 1000) + FormatFloat('#.###', ((LDur / 1000) - (LDur div 1000)), FS);
                end;
              end;
            end;

            // temp wav file is used if encoder isn't wav
            if FAudioEncoderType <> etWAV then
            begin
              LTmpAudioFileName := ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + CreateTempFileName + '.wav';
            end;

            if FAudioEncoderType = etWAV then
            begin
              AudioStr := AudioStr + DurationStr + ' "' + RP.Input + '"';
            end
            else
            begin
              AudioStr := AudioStr + DurationStr + ' "' + LTmpAudioFileName + '"';
            end;
            Encoder.CommandLines.Add(AudioStr);
            Encoder.Paths.Add(FFFMpegPath);
            Encoder.FileNames.Add(FileName);
            Encoder.Durations.Add(FileDuration);
            Encoder.Infos.Add('Decoding');
            Encoder.TempFiles.Add('');
            Encoder.ListItems.Add(LProgressItem);
            FileToDeleteStr := LTmpAudioFileName + '|';

            Encoder.ProcessTypes.Add(etFFMpeg);
            Encoder.FileIndexes.Add(FloatToStr(Index));
          end;

          // in order to show speed
          FTotalLength := FTotalLength + StrToInt(FileDuration);

          // audio filters
          AudioStr := '';

          with FiltersForm do
          begin

            if EnableBtn.Checked then
            begin

              // normalize
              if NormBtn.Checked then
              begin
                AudioStr := AudioStr + ' --norm ';
              end;

              // volume
              if VolumeBtn.Checked then
              begin
                VolumeStr := ' -v ' + ReplaceText(FloatToStr(StrToInt(VolumeEdit.Text) / 100), ',', '.');
                // volume option must be in XYZ.0 format
                if Pos('.', VolumeStr) = 0 then
                begin
                  VolumeStr := VolumeStr + '.0'
                end;

                AudioStr := AudioStr + VolumeStr;
              end;

              // thread mode
              if FiltersForm.ThreadBtn.Checked then
              begin
                AudioStr := AudioStr + ' --multi-threaded ';
              end;

              // clipping guard
              if GuardBtn.Checked then
              begin
                AudioStr := AudioStr + ' -G ';
              end;

              // playback speed
              SpeedStr := ReplaceStr(SpeedEdit.Text, ',', '.');
              FS.DecimalSeparator := '.';
              SpeedStr := ReplaceStr(FloatToStr(StrToFloatDef(SpeedStr, 100, FS) / 100), ',', '.');

              // add sox cmd iff there is something to add
              if (AudioStr <> '') or (SpeedStr <> '1') then
              begin
                AudioStr := AudioStr + ' "' + LTmpAudioFileName + '"';
                LTmpAudioFileName := SettingsForm.TempEdit.Text + '\sox_' + FloatToStr(Index) + '.wav';

                AudioStr := AudioStr + ' -V6 --show-progress "' + LTmpAudioFileName + '" speed ' + SpeedStr;

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FSoxPath);
                Encoder.FileNames.Add(FileName);
                Encoder.Infos.Add('Applying effects');
                Encoder.ListItems.Add(LProgressItem);
                Encoder.Durations.Add('1');
                Encoder.TempFiles.Add('');
                FileToDeleteStr := FileToDeleteStr + LTmpAudioFileName + '|';
                Encoder.ProcessTypes.Add(etSox);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.UsingSox := True;
              end
              else
              begin
                Encoder.UsingSox := False;
              end;

            end;
          end;

          // lossyWAV
          if (CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0) and CanUseLossyWAV then
          begin
            AudioStr := '';
            AudioStr := AudioStr + '" " "' + LTmpAudioFileName + '" ';
            case CodecSettingsForm.LossyWAVQualityList.ItemIndex of
              1:
                AudioStr := AudioStr + ' -q I';
              2:
                AudioStr := AudioStr + ' -q E';
              3:
                AudioStr := AudioStr + ' -q H';
              4:
                AudioStr := AudioStr + ' -q S';
              5:
                AudioStr := AudioStr + ' -q C';
              6:
                AudioStr := AudioStr + ' -q P';
              7:
                AudioStr := AudioStr + ' -q X';
            end;
            AudioStr := AudioStr + ' -o "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '"';
            LTmpAudioFileName := ChangeFileExt(LTmpAudioFileName, '.lossy.wav');

            Encoder.CommandLines.Add(AudioStr);
            Encoder.ListItems.Add(LProgressItem);
            Encoder.Paths.Add(FLossyWAVPath);
            Encoder.FileNames.Add(FileName);
            Encoder.Infos.Add('lossyWAV');
            Encoder.Durations.Add('1');
            Encoder.TempFiles.Add('');
            FileToDeleteStr := FileToDeleteStr + LTmpAudioFileName + '|';
            Encoder.ProcessTypes.Add(etLossyWAV);
            Encoder.FileIndexes.Add(FloatToStr(Index));
          end;

          // audio encoding
          AudioStr := '';

          case FAudioEncoderType of
            etFFMpegAAC: // ffmpeg aac
              begin

                // encoding mode
                AudioStr := AudioStr + ' -b:a ' + CodecSettingsForm.FAACBitrateEdit.Text + '000';

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.FFMpegAACCMD;
                AudioStr := CreateTagCMD(FileName, Index) + ' -y -i "' + LTmpAudioFileName + '" ' + AudioStr + ' "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FFFMpegPath);
                Encoder.FileNames.Add(FileName);
                Encoder.Durations.Add(FileDuration);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etFFMpegAAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' -r -t -p';
                  if SettingsForm.RGAutoLowerBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -k ';
                  end
                  else
                  begin
                    AudioStr := AudioStr + ' /c ';
                  end;
                  AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FAACGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.ProcessTypes.Add(etAACGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etQAAC: // qaac
              begin
                // encoding mode
                case CodecSettingsForm.QaacEncodeMethodList.ItemIndex of
                  0: // abr
                    begin
                      AudioStr := AudioStr + ' --abr ' + CodecSettingsForm.QaacBitrateEdit.Text;
                    end;
                  1: // tvbr
                    begin
                      AudioStr := AudioStr + ' --tvbr ' + CodecSettingsForm.QaacvQualityEdit.Text;
                    end;
                  2: // cvbr
                    begin
                      AudioStr := AudioStr + ' --cvbr ' + CodecSettingsForm.QaacBitrateEdit.Text;
                    end;
                  3: // cbr
                    begin
                      AudioStr := AudioStr + ' --cbr ' + CodecSettingsForm.QaacBitrateEdit.Text;
                    end;
                end;

                // profile
                if CodecSettingsForm.QaacHEBtn.Checked then
                begin
                  AudioStr := AudioStr + ' --he';
                end;

                if CodecSettingsForm.QaacNoDelayBtn.Checked then
                begin
                  AudioStr := AudioStr + ' --no-delay';
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.QAACCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' --ignorelength --rate keep "' + LTmpAudioFileName + '" -o "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FQaacPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Durations.Add('1');
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etQAAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' -r -t -p';
                  if SettingsForm.RGAutoLowerBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -k ';
                  end
                  else
                  begin
                    AudioStr := AudioStr + ' /c ';
                  end;
                  AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FAACGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etAACGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

              end;
            etFFMpegAC3: // ac3
              begin
                // encoding mode
                case CodecSettingsForm.AftenEncodeList.ItemIndex of
                  0: // quality
                    begin
                      AudioStr := AudioStr + ' -q:a ' + CodecSettingsForm.AftenQualityEdit.Text;
                    end;
                  1: // cbr
                    begin
                      AudioStr := AudioStr + ' -b:a ' + CodecSettingsForm.AftenBitrateEdit.Text + '000';
                    end;
                end;

                if CodecSettingsForm.AftenDialogBtn.Checked then
                begin
                  AudioStr := AudioStr + ' -dialnorm ' + CodecSettingsForm.AftenDialogEdit.Text;
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.AC3CMD;
                AudioStr := ' -y -i "' + LTmpAudioFileName + '" ' + AudioStr + ' -acodec ac3 "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FFFMpegPath);
                Encoder.FileNames.Add(FileName);
                Encoder.Durations.Add(FileDuration);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etFFMpegAC3);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);
              end;
            etOgg: // oggenc
              begin
                // encoding mode
                case CodecSettingsForm.OggencodeList.ItemIndex of
                  0: // quality
                    begin
                      AudioStr := AudioStr + ' -q ' + CodecSettingsForm.OggQualityEdit.Text;
                    end;
                  1: // bitrate
                    begin
                      AudioStr := AudioStr + ' -b ' + CodecSettingsForm.OggBitrateEdit.Text;

                      // managed bitrate mode
                      if CodecSettingsForm.OggManagedBitrateBtn.Checked then
                      begin
                        AudioStr := AudioStr + ' --managed ';
                      end
                      else
                      begin
                        AudioStr := AudioStr + ' -m ' + CodecSettingsForm.OggMinBitrateEdit.Text + ' -M ' + CodecSettingsForm.OggMaxBitrateEdit.Text;
                      end;

                    end;
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.OggCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + '  "' + LTmpAudioFileName + '" -o "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FOggEncPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etOgg);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked and CodecSettingsForm.OggUseTTaggerBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

                // replaygain
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  AudioStr := ' -s ';
                  AudioStr := AudioStr + ' -a "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FVorbisGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.ProcessTypes.Add(etVorbisGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etLAME: // lame
              begin

                case CodecSettingsForm.LameEncodeList.ItemIndex of
                  0: // cbr
                    begin
                      AudioStr := AudioStr + ' --cbr -b ' + CodecSettingsForm.LameBitrateEdit.Text;
                    end;
                  1: // abr
                    begin
                      AudioStr := AudioStr + ' --abr ' + CodecSettingsForm.LameBitrateEdit.Text;
                    end;
                  2: // vbr
                    begin
                      AudioStr := AudioStr + ' -V ' + ReplaceStr(CodecSettingsForm.LameVBREdit.Text, ',', '.');
                    end;
                end;

                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' --nohist  -q ' + CodecSettingsForm.LameQualityEdit.Text;

                // tags
                case CodecSettingsForm.LameTagList.ItemIndex of
                  1:
                    AudioStr := AudioStr + ' --id3v1-only ';
                  2:
                    AudioStr := AudioStr + ' --id3v2-only ';
                end;

                // channels
                if CodecSettingsForm.LameChannelList.ItemIndex > 0 then
                begin
                  case CodecSettingsForm.LameChannelList.ItemIndex of
                    1:
                      AudioStr := AudioStr + ' -m s ';
                    2:
                      AudioStr := AudioStr + ' -m j ';
                    3:
                      AudioStr := AudioStr + ' -m f ';
                    4:
                      AudioStr := AudioStr + ' -m d ';
                    5:
                      AudioStr := AudioStr + ' -m m ';
                    6:
                      AudioStr := AudioStr + ' -m l ';
                    7:
                      AudioStr := AudioStr + ' -m r ';
                  end;
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.LameCMD;
                AudioStr := AudioStr + '  "' + LTmpAudioFileName + '" -o "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FLamePath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etLAME);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                if CodecSettingsForm.LameUseTTaggerBtn.Checked then
                begin
                  // write tag
                  if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                  begin
                    AudioStr := '';
                    AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                    Encoder.CommandLines.Add(AudioStr);
                    Encoder.Paths.Add(FTTaggerPath);
                    Encoder.FileNames.Add(FileName);
                    Encoder.TempFiles.Add('');
                    Encoder.Durations.Add('1');
                    Encoder.Infos.Add('Writing Tags');
                    Encoder.ProcessTypes.Add(etTTagger);
                    Encoder.FileIndexes.Add(FloatToStr(Index));
                    Encoder.ListItems.Add(LProgressItem);
                  end;
                end;

                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' -r -t -p';
                  if SettingsForm.RGAutoLowerBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -k ';
                  end
                  else
                  begin
                    AudioStr := AudioStr + ' /c ';
                  end;
                  AudioStr := AudioStr + ' -d ' + StringReplace(FloatToStr((SettingsForm.ReplayGainBar.Position - 890) / 10), ',', '.', [rfReplaceAll]);
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FMp3GainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etMP3Gain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

              end;
            etWAV: // wav
              begin
                CreateTagCMD(FileName, Index);
                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etFLAC: // flac
              begin

                AudioStr := AudioStr + ' -' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex);

                if CodecSettingsForm.FLACEMSBtn.Checked then
                begin
                  AudioStr := AudioStr + ' -e ';
                end;

                // if CodecSettingsForm.FLACReplaygainBtn.Checked then
                // begin
                // AudioStr := AudioStr + ' --replay-gain'
                // end;

                if SettingsForm.OverWriteList.ItemIndex = 2 then
                begin
                  AudioStr := AudioStr + ' -f';
                end;

                if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
                begin
                  if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -b 512 --keep-foreign-metadata '
                  end;
                end;

                if CodecSettingsForm.FLACVerifyBtn.Checked then
                begin
                  AudioStr := AudioStr + ' --verify ';
                end;

                // last cmd
                AudioStr := AudioStr + CodecSettingsForm.FLACCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + '  "' + LTmpAudioFileName + '" -o "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FFLACPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etFLAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                if CodecSettingsForm.FLACUseTTaggerBtn.Checked then
                begin
                  // write tag
                  if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                  begin
                    AudioStr := '';
                    AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                    Encoder.CommandLines.Add(AudioStr);
                    Encoder.Paths.Add(FTTaggerPath);
                    Encoder.FileNames.Add(FileName);
                    Encoder.TempFiles.Add('');
                    Encoder.Durations.Add('1');
                    Encoder.Infos.Add('Writing Tags');
                    Encoder.ProcessTypes.Add(etTTagger);
                    Encoder.FileIndexes.Add(FloatToStr(Index));
                    Encoder.ListItems.Add(LProgressItem);
                  end;
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  CopyRGFromLossLessSource := IsSourceLossless(FileName) and SettingsForm.RGLToLBtn.Checked;
                  if CopyRGFromLossLessSource then
                  begin
                    // get rg values from source
                  end
                  else
                  begin
                    // replaygain
                    AudioStr := '';
                    AudioStr := ' --add-replay-gain "' + RP.Input + '"';

                    Encoder.CommandLines.Add(AudioStr);
                    Encoder.Paths.Add(FMetaFlacPath);
                    Encoder.FileNames.Add(FileName);
                    Encoder.TempFiles.Add('');
                    Encoder.Infos.Add('ReplayGain');
                    Encoder.Durations.Add('1');
                    Encoder.ProcessTypes.Add(etMetaFlac);
                    Encoder.FileIndexes.Add(FloatToStr(Index));
                    Encoder.ListItems.Add(LProgressItem);
                  end;
                end;
              end;
            etFHGAAC: // FHG
              begin

                // encoding mode
                case CodecSettingsForm.FHGMethodList.ItemIndex of
                  0: // cbr
                    begin
                      AudioStr := AudioStr + ' --cbr ' + CodecSettingsForm.FHGBitrateEdit.Text;

                      // profile
                      case CodecSettingsForm.FHGProfileList.ItemIndex of
                        0:
                          AudioStr := AudioStr + ' --profile auto';
                        1:
                          AudioStr := AudioStr + ' --profile lc';
                        2:
                          AudioStr := AudioStr + ' --profile he';
                        3:
                          AudioStr := AudioStr + ' --profile hev2';
                      end;
                    end;
                  1: // vbr
                    begin
                      AudioStr := AudioStr + ' --vbr ' + CodecSettingsForm.FHGQualityEdit.Text;
                    end;
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.FHGAACCMD;
                AudioStr := CreateTagCMD(FileName, Index) + AudioStr + ' "' + LTmpAudioFileName + '" "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FFHGPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etFHGAAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' -r -t -p';
                  if SettingsForm.RGAutoLowerBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -k ';
                  end
                  else
                  begin
                    AudioStr := AudioStr + ' /c ';
                  end;
                  AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FAACGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etAACGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

              end;
            etOpus: // opus
              begin

                // encoding mode
                case CodecSettingsForm.OpusEncodeMethodList.ItemIndex of
                  0: // vbr
                    begin
                      AudioStr := AudioStr + ' --vbr ';
                    end;
                  1: // cvbr
                    begin
                      AudioStr := AudioStr + ' --cvbr ';
                    end;
                  2: // cbr
                    begin
                      AudioStr := AudioStr + ' --hard-cbr ';
                    end;
                end;

                AudioStr := AudioStr + ' --comp ' + CodecSettingsForm.OpusCompEdit.Text;
                AudioStr := AudioStr + ' --bitrate ' + CodecSettingsForm.OpusBitrateEdit.Text;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.OpusCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' "' + LTmpAudioFileName + '" "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FOpusPath);
                Encoder.FileNames.Add(FileName);
                Encoder.Durations.Add(FileDuration);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etOpus);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked and CodecSettingsForm.OpusUseTTaggerBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etMPC: // mpc
              begin
                AudioStr := AudioStr + ' --quality ' + CodecSettingsForm.MPCQualityEdit.Text + ' --unicode ';
                if SettingsForm.OverWriteList.ItemIndex = 2 then
                begin
                  AudioStr := AudioStr + ' --overwrite '
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.MPCCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' "' + LTmpAudioFileName + '" "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FMPCPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etMPC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FMPCGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.ProcessTypes.Add(etMPCGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etAPE: // ape
              begin

                case CodecSettingsForm.MACLevelList.ItemIndex of
                  0:
                    AudioStr := AudioStr + ' -c1000';
                  1:
                    AudioStr := AudioStr + ' -c2000';
                  2:
                    AudioStr := AudioStr + ' -c3000';
                  3:
                    AudioStr := AudioStr + ' -c4000';
                  4:
                    AudioStr := AudioStr + ' -c5000';
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.APECMD;
                AudioStr := CreateTagCMD(FileName, Index) + ' "' + LTmpAudioFileName + '" "' + RP.Input + '" ' + AudioStr;

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FMACPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etAPE);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etTTA: // tta
              begin

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.TTACMD;
                AudioStr := CreateTagCMD(FileName, Index) + ' -e "' + LTmpAudioFileName + '" -o "' + RP.Input + '" ';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FTTAPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etTTA);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etTAK: // tak
              begin

                // last cmd
                AudioStr := '" " -e -p' + FloatToStr(CodecSettingsForm.TAKPresetList.ItemIndex);
                case CodecSettingsForm.TAKLevelList.ItemIndex of
                  1:
                    AudioStr := AudioStr + 'e ';
                  2:
                    AudioStr := AudioStr + 'm ';
                end;

                if SettingsForm.OverWriteList.ItemIndex = 2 then
                begin
                  AudioStr := AudioStr + ' -overwrite';
                end;

                if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
                begin
                  if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -fsl512 '
                  end;
                end;

                if CodecSettingsForm.TAKMd5Btn.Checked then
                begin
                  AudioStr := AudioStr + ' -md5 ';
                end;

                if CodecSettingsForm.TAKVerifyBtn.Checked then
                begin
                  AudioStr := AudioStr + ' -v '
                end;

                AudioStr := AudioStr + ' ' + CodecSettingsForm.TAKCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' "' + LTmpAudioFileName + '" "' + RP.Input + '" ';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FTAKPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etTAK);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etNeroAAC: // neroaac
              begin

                // encoding mode
                case CodecSettingsForm.NeroMethodList.ItemIndex of
                  0: // quality
                    begin
                      AudioStr := AudioStr + ' -q ' + ReplaceStr(FloatToStr(CodecSettingsForm.NeroQualityBar.Position / 100), ',', '.');
                    end;
                  1: // abr
                    begin
                      AudioStr := AudioStr + ' -br ' + CodecSettingsForm.NeroBitrateEdit.Text + '000';
                    end;
                  2: // cbr
                    begin
                      AudioStr := AudioStr + ' -cbr ' + CodecSettingsForm.NeroBitrateEdit.Text + '000';
                    end;
                end;

                // profile
                case CodecSettingsForm.NeroProfileList.ItemIndex of
                  1:
                    AudioStr := AudioStr + ' -lc';
                  2:
                    AudioStr := AudioStr + ' -he';
                  3:
                    AudioStr := AudioStr + ' -hev2';
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.NeroAACCMD;
                AudioStr := CreateTagCMD(FileName, Index) + AudioStr + ' -if "' + LTmpAudioFileName + '" -of "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FNeroEncPath);
                Encoder.FileNames.Add(FileName);
                Encoder.Durations.Add(FileDuration);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etNeroAAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' -r -t -p';
                  if SettingsForm.RGAutoLowerBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -k ';
                  end
                  else
                  begin
                    AudioStr := AudioStr + ' /c ';
                  end;
                  AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FAACGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etAACGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

              end;
            etFFmpegALAC: // alac
              begin
                // last cmd
                AudioStr := ' -y -i "' + LTmpAudioFileName + '" -c:a alac -vn "' + RP.Input + '" ' + CreateTagCMD(FileName, Index) + ' ' + CodecSettingsForm.ALACCMD;

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FFFMpegPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etFFmpegALAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etWMA: // wmaencoder
              begin
                case CodecSettingsForm.WMAMethodList.ItemIndex of
                  0:
                    begin
                      AudioStr := AudioStr + ' --quality ' + CodecSettingsForm.WMAQualityList.Text;
                    end;
                  1:
                    begin
                      AudioStr := AudioStr + ' --bitrate ' + CodecSettingsForm.WMABitrateEdit.Text
                    end;
                end;

                case CodecSettingsForm.WMACodecList.ItemIndex of
                  0:
                    AudioStr := AudioStr + ' --codec std ';
                  1:
                    AudioStr := AudioStr + ' --codec pro ';
                  2:
                    AudioStr := AudioStr + ' --codec lsl ';
                  3:
                    AudioStr := AudioStr + ' --codec voice ';
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.WMACMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' "' + LTmpAudioFileName + '" "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FWmaEncodePath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etWMA);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etWavPack: // wavpack
              begin
                case CodecSettingsForm.WavPackMethodList.ItemIndex of
                  0:
                    begin
                      AudioStr := AudioStr + ' ';
                    end;
                  1:
                    begin
                      AudioStr := AudioStr + ' -b' + CodecSettingsForm.WavPackBitrateEdit.Text;

                      if CodecSettingsForm.WavPackCorrectionBtn.Checked then
                      begin
                        AudioStr := AudioStr + ' -c '
                      end;
                    end;
                end;

                AudioStr := AudioStr + ' -h ';
                if CodecSettingsForm.WavPackExtraBtn.Checked then
                begin
                  AudioStr := AudioStr + ' -x '
                end;
                if SettingsForm.OverWriteList.ItemIndex = 2 then
                begin
                  AudioStr := AudioStr + ' -y ';
                end;

                // for lossywav
                if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
                begin
                  if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' --blocksize=512 --merge-blocks '
                  end;
                end;

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.WavPackCMD;
                AudioStr := AudioStr + CreateTagCMD(FileName, Index) + ' "' + LTmpAudioFileName + '" "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FWavPackPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etWavPack);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

                // replaygain
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // do not copy from lossless source.
                  // if copying is done, it is done on writing tags step.
                  if (not TagsList[Index].IsLossless) and (not SettingsForm.RGLToLBtn.Checked) then
                  begin
                    AudioStr := ' -l ';
                    AudioStr := AudioStr + ' -a "' + RP.Input + '"';

                    Encoder.CommandLines.Add(AudioStr);
                    Encoder.Paths.Add(FWVGainPath);
                    Encoder.FileNames.Add(FileName);
                    Encoder.TempFiles.Add('');
                    Encoder.Infos.Add('ReplayGain');
                    Encoder.Durations.Add('1');
                    Encoder.ProcessTypes.Add(etWVGain);
                    Encoder.FileIndexes.Add(FloatToStr(Index));
                    Encoder.ListItems.Add(LProgressItem);
                  end;
                end;
              end;
            etFDKAAC: // fdk-aac
              begin
                // bitrate
                if CodecSettingsForm.FDKMethodList.ItemIndex = 0 then
                begin
                  AudioStr := AudioStr + ' -m 0 -b ' + CodecSettingsForm.FDKBitrateEdit.Text;
                end
                else
                begin
                  AudioStr := AudioStr + ' -m ' + FloatToStr(CodecSettingsForm.FDKVBRBar.Position)
                end;

                // profile
                case CodecSettingsForm.FDKProfileList.ItemIndex of
                  0:
                    AudioStr := AudioStr + ' -p 2';
                  1:
                    AudioStr := AudioStr + ' -p 5';
                  2:
                    AudioStr := AudioStr + ' -p 29';
                  3:
                    AudioStr := AudioStr + ' -p 23';
                  4:
                    AudioStr := AudioStr + ' -p 39';
                  5:
                    AudioStr := AudioStr + ' -p 129';
                  6:
                    AudioStr := AudioStr + ' -p 132';
                  7:
                    AudioStr := AudioStr + ' -p 156';
                end;

                // gapless
                AudioStr := AudioStr + ' -G ' + FloatToStr(CodecSettingsForm.FDKGaplessList.ItemIndex) + ' --moov-before-mdat --ignorelength ';

                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.FDKAACCMD;
                AudioStr := CreateTagCMD(FileName, Index) + AudioStr + ' "' + LTmpAudioFileName + '" -o "' + RP.Input + '"';

                Encoder.CommandLines.Add(AudioStr);
                Encoder.Paths.Add(FFdkAACPath);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Infos.Add('Encoding');
                Encoder.Durations.Add('1');
                Encoder.ProcessTypes.Add(etFDKAAC);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                begin
                  AudioStr := '';
                  AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FTTaggerPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Durations.Add('1');
                  Encoder.Infos.Add('Writing Tags');
                  Encoder.ProcessTypes.Add(etTTagger);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' -r -t -p';
                  if SettingsForm.RGAutoLowerBtn.Checked then
                  begin
                    AudioStr := AudioStr + ' -k ';
                  end
                  else
                  begin
                    AudioStr := AudioStr + ' /c ';
                  end;
                  AudioStr := AudioStr + ' /d ' + ReplaceStr(SettingsForm.ReplayGainEdit.Text, ',', '.');
                  // AudioStr := AudioStr + ' -d ' + StringReplace(FloatToStr((SettingsForm.ReplayGainBar.Position - 890) / 10), ',', '.', [rfReplaceAll]);
                  AudioStr := AudioStr + ' "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FAACGainPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etAACGain);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;

              end;
            etAIFF: // aiff
              begin
                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.AIFFCMD;
                AudioStr := ' -y -i "' + FileName + '" -f aiff ' + CreateTagCMD(FileName, Index) + ' "' + RP.Input + '"';

                Encoder.Paths.Add(FFFMpegPath);
                Encoder.CommandLines.Add(AudioStr);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Durations.Add(FileDuration);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etAIFF);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);
              end;
            etFLACCL: // flaccl
              begin
                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.FLACCLCMD;
                AudioStr := ' -' + CodecSettingsForm.FLACCLLevelList.Text + ' "' + LTmpAudioFileName + '" -o "' + RP.Input + '"';

                Encoder.Paths.Add(FFLACCLPath);
                Encoder.CommandLines.Add(AudioStr);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Durations.Add(FileDuration);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etFLACCL);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);

                // write tag
                if CodecSettingsForm.FLACCLUseTTaggerBtn.Checked then
                begin
                  // use ttagger
                  if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
                  begin
                    // to create tag.txt file
                    AudioStr := CreateTagCMD(FileName, Index);
                    AudioStr := '';
                    AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\' + FloatToStr(Index) + 'tag.txt" "' + RP.Input + '"';

                    Encoder.CommandLines.Add(AudioStr);
                    Encoder.Paths.Add(FTTaggerPath);
                    Encoder.FileNames.Add(FileName);
                    Encoder.TempFiles.Add('');
                    Encoder.Infos.Add('Writing Tags');
                    Encoder.Durations.Add('1');
                    Encoder.ProcessTypes.Add(etTTagger);
                    Encoder.FileIndexes.Add(FloatToStr(Index));
                    Encoder.ListItems.Add(LProgressItem);
                  end;
                end
                else
                begin
                  // use flac.exe
                  AudioStr := CreateTagCMD(FileName, Index) + '  "' + RP.Input + '" -f -o "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FFLACPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add(FileToDeleteStr);
                  Encoder.Infos.Add('Writing tags');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etFLAC);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
                if SettingsForm.ReplayGainBtn.Checked then
                begin
                  // replaygain
                  AudioStr := '';
                  AudioStr := ' --add-replay-gain "' + RP.Input + '"';

                  Encoder.CommandLines.Add(AudioStr);
                  Encoder.Paths.Add(FMetaFlacPath);
                  Encoder.FileNames.Add(FileName);
                  Encoder.TempFiles.Add('');
                  Encoder.Infos.Add('ReplayGain');
                  Encoder.Durations.Add('1');
                  Encoder.ProcessTypes.Add(etMetaFlac);
                  Encoder.FileIndexes.Add(FloatToStr(Index));
                  Encoder.ListItems.Add(LProgressItem);
                end;
              end;
            etDCA: // dca
              begin
                // last cmd
                AudioStr := AudioStr + ' ' + CodecSettingsForm.DcaencCMD;
                AudioStr := ' -i "' + LTmpAudioFileName + '" -o "' + RP.Input + '" -b ' + CodecSettingsForm.DCABitrateEdit.Text;

                Encoder.Paths.Add(FDCAENCPath);
                Encoder.CommandLines.Add(AudioStr);
                Encoder.FileNames.Add(FileName);
                Encoder.TempFiles.Add(FileToDeleteStr);
                Encoder.Durations.Add(FileDuration);
                Encoder.Infos.Add('Encoding');
                Encoder.ProcessTypes.Add(etDCA);
                Encoder.FileIndexes.Add(FloatToStr(Index));
                Encoder.ListItems.Add(LProgressItem);
              end;
          end;

        end;
{$ENDREGION}
      end;
    1: // copy audio
      begin
{$REGION 'Copy Audio'}
        // in order to show speed
        FTotalLength := FTotalLength + StrToInt(FileDuration);

        // ffmepg command line
        if AudioIndexes[Index] <> '-1' then
        begin
          if OutputExt = '.wav' then
          begin
            // wav
            AudioStr := ' -y -i "' + FileName + '" -vn -acodec copy -map 0:' + AudioIndexes[Index] + ' ' + CreateBitDepthCMD(FileName);
          end
          else if OutputExt = '.flac' then
          begin
            // flac
            AudioStr := ' -y -i "' + FileName + '" -vn -acodec copy -map 0:' + AudioIndexes[Index] + ' -f flac ';
          end
          else
          begin
            // others
            AudioStr := ' -y -i "' + FileName + '" -vn -acodec copy -map 0:' + AudioIndexes[Index] + ' ';
          end;

          // trimming
          FS.DecimalSeparator := '.';
          LStartPos := StrToInt(StartPositions[Index]);
          LDur := StrToInt(EndPositions[Index]) - StrToInt(StartPositions[Index]);
          // we must use trim values for cue sheets
          if TagsList[Index].FileType = 'cue' then
          begin
            DurationStr := ' -ss ' + IntToTime(LStartPos div 1000) + FormatFloat('#.###', ((LStartPos / 1000) - (LStartPos div 1000)), FS) + ' -t ' + IntToTime(LDur div 1000) + FormatFloat('#.###', ((LDur / 1000) - (LDur div 1000)), FS);
          end
          else
          begin
            // do not use trimming if user didn't change it
            if LDur <> StrToInt(ConstantDurations[Index]) then
            begin
              DurationStr := ' -ss ' + IntToTime(LStartPos div 1000) + FormatFloat('#.###', ((LStartPos / 1000) - (LStartPos div 1000)), FS) + ' -t ' + IntToTime(LDur div 1000) + FormatFloat('#.###', ((LDur / 1000) - (LDur div 1000)), FS);
            end;
          end;

          // file path pair to calculate compression.
          // only for audio to audio (expect cue sheets).
          if IsAudioOnly(FileName) and (TagsList[Index].FileType <> 'cue') then
          begin
            LCompressionPair.SourcePath := FileName;
            LCompressionPair.DestinationPath := RP.Output;
            CompressionPairs.Add(LCompressionPair);
          end;

          AudioStr := AudioStr + DurationStr + ' "' + RP.Input + '"';
          Encoder.CommandLines.Add(AudioStr);
          Encoder.Paths.Add(FFFMpegPath);
          Encoder.FileNames.Add(FileName);
          Encoder.Durations.Add(FileDuration);
          Encoder.Infos.Add('Extracting');
          Encoder.ProcessTypes.Add(etFFMpeg);
          Encoder.FileIndexes.Add(FloatToStr(Index));
          Encoder.ListItems.Add(LProgressItem);

          // write tags
          if OutputExt = '.flac' then
          begin
            // todo: write tags
          end;
        end;
{$ENDREGION}
      end;
  end;

  FilesToCheck.Add(RP.Output);
  // RenamePairs.Add(RP);
  // rename tool
  LRenameFile := TStringList.Create;
  try
    LRenameFile.Add(FloatToStr(SettingsForm.OverWriteList.ItemIndex + 1));
    LRenameFile.Add(RP.Input);
    LRenameFile.Add(RP.Output);
    LRenameFile.SaveToFile(ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\rename' + FloatToStr(Index) + '.txt', TEncoding.UTF8);
  finally
    LRenameFile.Free;
  end;
  AudioStr := '" " "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\rename' + FloatToStr(Index) + '.txt"';

  Encoder.Paths.Add(FRenameToolPath);
  Encoder.CommandLines.Add(AudioStr);
  Encoder.FileNames.Add(FileName);
  Encoder.TempFiles.Add('');
  Encoder.Durations.Add(FileDuration);
  Encoder.Infos.Add('Renaming');
  Encoder.ProcessTypes.Add(etRenameTool);
  Encoder.FileIndexes.Add(FloatToStr(Index));
  Encoder.ListItems.Add(LProgressItem);
end;

procedure TMainForm.AddFile(const FileName: string);
var
  MediaInfoHandle: Cardinal;
  // VDuration: string;
  ABitrate: string;
  ASampleRate: string;
  AChannels: string;
  ACodec: string;
  ALang: string;
  AudioCount: string;
  VideoCount: string;
  AudioID: string;
  i, j: Integer;
  NewItemStr: string;
  ADuration: string;
  BitDepth: string;
  FileDuration: integer;
  FileSize: string;
  FileInfo: TFileInfo;
  FAudioIndexes: TStringList;
  ExtensionLine: string;
  ListItem: TListItem;
  AudioOnly: Boolean;
  CueParser: TCueSplitter;
  FTmpList: TStringList;
  LTag: TTagInfo;
  AudioDurationExtractor: TAudioDurationExtractor;
  FS: TFormatSettings;
  LIndexItem: TIndexItem;
  LIsAudioOnly: Boolean;
begin

  if (FileExists(FileName)) and CanAddFile(FileName) then
  begin
    // parse cue sheet
    if (LowerCase(ExtractFileExt(FileName)) = '.cue') then
    begin
      if not SettingsForm.IgnoreCueBtn.Checked then
      begin
        CueParser := TCueSplitter.Create(FileName);
        CueParser.FileDuration := GetDurationEx(CueParser.SongFileName);
        try
          CueParser.ParseCueSheet;
          if CueParser.ErrorMsg <> 0 then
          begin
            AddToLog(0, 'Error with cue ' + FileName + '. Error code: ' + FloatToStr(CueParser.ErrorMsg));
          end
          else
          begin
            if FileExists(CueParser.SongFileName) then
            begin
              // New handle for mediainfo
              MediaInfoHandle := MediaInfo_New();

              if MediaInfoHandle <> 0 then
              begin

                try
                  // Open a file in complete mode
                  MediaInfo_Open(MediaInfoHandle, PwideChar(CueParser.SongFileName));
                  MediaInfo_Option(0, 'Complete', '1');

                  if MediaInfoHandle <> 0 then
                  begin
                    // get file size
                    FileSize := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'FileSize/String', Info_Text, Info_Name);

                    FileDuration := GetDurationEx(CueParser.SongFileName);

                    // if mediainfo fails to get duration
                    // try ffprobe.
                    if FileDuration < 1 then
                    begin
                      AudioDurationExtractor := TAudioDurationExtractor.Create(CueParser.SongFileName, FFFProbePath, SettingsForm.TempEdit.Text);
                      AudioDurationExtractor.Start;
                      while AudioDurationExtractor.FFProbeStatus = ffpReading do
                      begin
                        Application.ProcessMessages;
                        Sleep(10);
                      end;
                      if AudioDurationExtractor.Duration > 0 then
                      begin
                        FileDuration := Round(AudioDurationExtractor.Duration);
                      end;
                    end;
                    // get number of audio tracks
                    AudioCount := MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'StreamCount', Info_Text, Info_Name);

                    if IsStringNumeric(AudioCount) then
                    begin

                      if (StrToInt(AudioCount) > 0) then
                      begin
                        i := 0;

                        // get info
                        ABitrate := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'BitRate/String', Info_Text, Info_Name);

                        ACodec := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Codec', Info_Text, Info_Name);

                        AChannels := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Channel(s)/String', Info_Text, Info_Name);

                        ASampleRate := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'SamplingRate/String', Info_Text, Info_Name);

                        ALang := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Language/String3', Info_Text, Info_Name);

                        ADuration := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Duration', Info_Text, Info_Name);
                        BitDepth := Trim(MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'BitDepth', Info_Text, Info_Name));

                        if Length(ABitrate) < 1 then
                        begin
                          ABitrate := '0';
                        end;

                        if Length(ACodec) < 1 then
                        begin
                          ACodec := 'unk';
                        end;

                        if Length(AChannels) < 1 then
                        begin
                          AChannels := '0';
                        end;

                        if Length(ASampleRate) < 1 then
                        begin
                          ASampleRate := '0';
                        end;

                        if Length(ALang) < 1 then
                        begin
                          ALang := 'unk';
                        end;

                        if Length(BitDepth) < 1 then
                        begin
                          BitDepth := 'unk';
                        end;

                        // get tags from cue file
                        if CueParser.TrackCount > 0 then
                        begin
                          // each track is treated as a file
                          for i := 0 to CueParser.TrackCount - 1 do
                          begin
                            Application.ProcessMessages;

                            AudioIndexes.Add('0');
                            ExtensionLine := ACodec;
                            CopyExtension.Add(ACodec);

                            NewItemStr := '1, ' + ACodec + ', ' + ABitrate + ', ' + AChannels + ', ' + ASampleRate + ', ' + ALang + ', ' + IntToTime(CueParser.CueTracksInfos[i].CueTrackDurationInfo.Duration div 1000) + ', ' + BitDepth + ' bit, ' + FileSize;

                            // add tags extracted from cue file to tags list
                            with LTag do
                            begin
                              with CueParser.CueTracksInfos[i] do
                              begin
                                Title := CueTrackTagInfo.Title;
                                TitleForFileName := CueTrackTagInfo.TitleForFileName;
                                Artist := CueTrackTagInfo.Artist;
                                ArtistForFileName := CueTrackTagInfo.ArtistForFileName;
                                Composer := CueTrackTagInfo.Composer;
                                // Album := CueParser.AlbumInfo.Title;
                                // AlbumForFileName := CueParser.AlbumInfo.TitleForFileName;
                                Album := CueTrackTagInfo.Album;
                                AlbumForFileName := CueTrackTagInfo.AlbumForFileName;
                                AlbumArtist := CueParser.CueInfo.Performer;
                                TrackNo := PadTrackIndex(i + 1);
                                TrackTotal := FloatToStr(CueParser.TrackCount);
                                FileType := 'cue';
                                IsLossless := IsSourceLossless(CueParser.SongFileName);
                              end;
                            end;
                            AudioTracks.Add(NewItemStr);
                            Files.Add(CueParser.SongFileName);
                            ListItem := FileList.Items.Add;

                            // add extracted cue track to file list
                            FS.DecimalSeparator := '.';
                            with ListItem do
                            begin
                              with CueParser.CueTracksInfos[i] do
                              begin
                                Caption := ExtractFileName(CueParser.SongFileName) + ' - ' + CueTrackTagInfo.Title;
                                SubItems.Add(IntToTime(CueTrackDurationInfo.StartPos div 1000) + '.' + PadString(FloatToStr((CueTrackDurationInfo.StartPos / 1000) - (CueTrackDurationInfo.StartPos div 1000))));
                                SubItems.Add(IntToTime(CueTrackDurationInfo.EndPos div 1000) + '.' + PadString(FloatToStr((CueTrackDurationInfo.EndPos / 1000) - (CueTrackDurationInfo.EndPos div 1000))));
                                LIndexItem := TIndexItem.Create;
                                LIndexItem.RealIndex := Index;
                                SubItems.AddObject(ABitrate, LIndexItem);
                                SubItems.Add(ASampleRate);
                                SubItems.Add(AChannels);
                                SubItems.Add(BitDepth + ' bit');
                                // SubItems.Add(IntToTime(CueTrackDurationInfo.EndPos));
                                SubItems.Add(CueTrackTagInfo.Title);
                                SubItems.Add(CueTrackTagInfo.Album);
                                SubItems.Add(CueTrackTagInfo.Artist);
                                // add genre if it exists in REM
                                for j := 0 to CueParser.CueInfo.ExtraComments.Count - 1 do
                                begin
                                  if 'genre' = LowerCase(CueParser.CueInfo.ExtraComments[j].CommentName) then
                                  begin
                                    SubItems.Add(CueParser.CueInfo.ExtraComments[j].CommentValue);
                                    LTag.Genre := CueParser.CueInfo.ExtraComments[j].CommentValue
                                  end
                                  else if 'date' = LowerCase(CueParser.CueInfo.ExtraComments[j].CommentName) then
                                  begin
                                    SubItems.Add(CueParser.CueInfo.ExtraComments[j].CommentValue);
                                    LTag.RecordDate := CueParser.CueInfo.ExtraComments[j].CommentValue;
                                  end;
                                end;
                                SubItems.Add(LTag.Genre);
                                StartPositions.Add(FloatToStr(CueTrackDurationInfo.StartPos));
                                EndPositions.Add(FloatToStr(CueTrackDurationInfo.EndPos));
                                Durations.Add(FloatToStr(CueTrackDurationInfo.Duration));
                                ConstantDurations.Add(FloatToStr(CueTrackDurationInfo.Duration));
                                StateIndex := 2;
                                ImageIndex := -1;
                              end;
                            end;
                            TagsList.Add(LTag);
                            ExtensionsForCopy.Add(ExtensionLine);
                          end;
                        end;
                      end
                      else
                      begin
                        AddToLog(0, 'Couldn''t add ' + CueParser.SongFileName + ' beause it has no audio streams [1].');
                      end;
                    end
                    else
                    begin
                      AddToLog(0, 'Couldn''t add ' + CueParser.SongFileName + ' beause it has no audio streams [2].');
                    end;
                  end
                  else
                  begin
                    AddToLog(0, 'Couldn''t add ' + CueParser.SongFileName + ' beause mediainfo can''t open it.');
                  end;
                finally
                  MediaInfo_Close(MediaInfoHandle);
                end;
              end
              else
              begin
                AddToLog(0, 'Couldn''t add ' + CueParser.SongFileName + ' beause mediainfo can''t be loaded.');
              end;
            end
            else
            begin
              AddToLog(0, 'Couldn''t add ' + CueParser.SongFileName + ' beause file indicated in cue sheet doesn''t exist: ' + CueParser.SongFileName);
            end;
          end;
        finally
          CueParser.Free;
        end;
      end;
    end
    else
    begin
      // audio-video files

      // check if file is audio only
      LIsAudioOnly := IsAudioOnly(FileName);

      // New handle for mediainfo
      MediaInfoHandle := MediaInfo_New();

      if MediaInfoHandle <> 0 then
      begin

        FileInfo := TFileInfo.Create(FileName, FFFProbePath, SettingsForm.TempEdit.Text);
        FAudioIndexes := TStringList.Create;
        try
          // Open a file in complete mode
          MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
          MediaInfo_Option(0, 'Complete', '1');

          // get length
          // VDuration := MediaInfo_Get(MediaInfoHandle, Stream_Video, 0,
          // 'Duration', Info_Text, Info_Name);

          // get file size
          FileSize := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'FileSize/String', Info_Text, Info_Name);

          // get duration.
          // if mediainfo fails try ffprobe.
          FileDuration := GetDurationEx(FileName);
          if FileDuration < 1 then
          begin
            AudioDurationExtractor := TAudioDurationExtractor.Create(FileName, FFFProbePath, SettingsForm.TempEdit.Text);
            AudioDurationExtractor.Start;
            while AudioDurationExtractor.FFProbeStatus = ffpReading do
            begin
              Application.ProcessMessages;
              Sleep(10);
            end;
            if AudioDurationExtractor.Duration > 0 then
            begin
              FileDuration := Round(AudioDurationExtractor.Duration);
            end;
          end;

          // file length filters
          if SettingsForm.FileLenghtList.ItemIndex = 1 then
          begin
            // dont add files longer than x
            if FileDuration > (StrToInt(SettingsForm.FileLengthEdit.Text) * 1000) then
            begin
              AddToLog(0, 'Longer than threshold: ' + ExtractFileName(FileName));
              Exit;
            end;
          end
          else if SettingsForm.FileLenghtList.ItemIndex = 2 then
          begin
            // dont add files shorter than x
            if FileDuration < (StrToInt(SettingsForm.FileLengthEdit.Text) * 1000) then
            begin
              AddToLog(0, 'Shorter than threshold: ' + ExtractFileName(FileName));
              Exit;
            end;
          end;

          Durations.Add(FloatToStr(FileDuration));
          // get number of audio tracks
          AudioCount := MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'StreamCount', Info_Text, Info_Name);

          if not IsStringNumeric(AudioCount) then
          begin
            AudioCount := '0';
          end;

          // if duration is valid
          if (LowerCase(ExtractFileExt(FileName)) <> '.avs') then
          begin

            if FileDuration > 0 then
            begin

              VideoCount := MediaInfo_Get(MediaInfoHandle, Stream_Video, 0, 'StreamCount', Info_Text, Info_Name);

              if not IsStringNumeric(VideoCount) then
              begin
                VideoCount := '0';
              end;

              if IsStringNumeric(VideoCount) or IsStringNumeric(AudioCount) then
              begin
                if StrToInt(AudioCount) > 0 then
                begin

                  // get id using ffmpeg
                  if not LIsAudioOnly then
                  begin
                    AudioOnly := False;
                    FileInfo.Start;
                    while FileInfo.FileInfoStatus = fsReading do
                    begin
                      Application.ProcessMessages;
                      Sleep(10);
                    end;
                    FAudioIndexes.AddStrings(FileInfo.AudioStreamIndexes);
                  end
                  else
                  begin
                    FAudioIndexes.Add('0');
                    AudioOnly := True;
                  end;

                  if FAudioIndexes.Count = StrToInt(AudioCount) then
                  begin

                    // fill audio track list
                    for i := 0 to StrToInt(AudioCount) - 1 do
                    begin
                      Application.ProcessMessages;

                      // get info
                      ABitrate := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'BitRate/String', Info_Text, Info_Name);

                      ACodec := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Codec', Info_Text, Info_Name);

                      AChannels := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Channel(s)/String', Info_Text, Info_Name);

                      ASampleRate := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'SamplingRate/String', Info_Text, Info_Name);

                      ALang := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Language/String3', Info_Text, Info_Name);

                      ADuration := MediaInfo_Get(MediaInfoHandle, Stream_Audio, i, 'Duration', Info_Text, Info_Name);
                      BitDepth := Trim(MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'BitDepth', Info_Text, Info_Name));

                      if Length(ABitrate) < 1 then
                      begin
                        ABitrate := '0';
                      end;

                      if Length(ACodec) < 1 then
                      begin
                        ACodec := 'unk';
                      end;

                      if Length(AChannels) < 1 then
                      begin
                        AChannels := '0';
                      end;

                      if Length(ASampleRate) < 1 then
                      begin
                        ASampleRate := '0';
                      end;

                      if Length(ALang) < 1 then
                      begin
                        ALang := 'unk';
                      end;

                      if Length(BitDepth) < 1 then
                      begin
                        BitDepth := 'unk';
                      end;

                      if Length(FAudioIndexes[i]) < 3 then
                      begin
                        AudioID := RemoveNonDigits(FAudioIndexes[i]);
                      end
                      else
                      begin
                        AudioID := RemoveNonDigits(FloatToStr(i + 1));
                      end;

                      // fill new item
                      if i = 0 then
                      begin

                        if LIsAudioOnly then
                        begin
                          AudioIndexes.Add('0');
                        end
                        else
                        begin
                          AudioIndexes.Add(AudioID);
                        end;

                        NewItemStr := AudioID + ', ' + ACodec + ', ' + ABitrate + ', ' + AChannels + ', ' + ASampleRate + ', ' + ALang + ', ' + IntToTime(FileDuration) + ', ' + BitDepth + ' bit, ' + FileSize;
                        ExtensionLine := ACodec;
                        CopyExtension.Add(ACodec);
                      end
                      else
                      begin

                        if LIsAudioOnly then
                        begin
                          AudioID := '0';
                        end;

                        NewItemStr := NewItemStr + '|' + AudioID + ', ' + ACodec + ', ' + ABitrate + ', ' + AChannels + ', ' + ASampleRate + ', ' + ALang + ', ' + IntToTime(FileDuration) + ', ' + BitDepth + ' bit, ' + FileSize;
                        ExtensionLine := ExtensionLine + ',' + ACodec;
                      end;

                    end;

                    AudioTracks.Add(NewItemStr);
                    Files.Add(FileName);
                    LTag := ReadTags(FileName, LIsAudioOnly);
                    TagsList.Add(LTag);

                    ListItem := FileList.Items.Add;
                    FS.DecimalSeparator := '.';
                    with ListItem do
                    begin
                      Caption := ExtractFileName(FileName);
                      SubItems.Add('00:00:00.000');
                      SubItems.Add(IntToTime(FileDuration div 1000) + '.' + PadString(FloatToStr((FileDuration / 1000) - (FileDuration div 1000))));
                      LIndexItem := TIndexItem.Create;
                      LIndexItem.RealIndex := Index;
                      SubItems.AddObject(ABitrate, LIndexItem);
                      SubItems.Add(ASampleRate);
                      SubItems.Add(AChannels);
                      if BitDepth = 'unk' then
                      begin
                        SubItems.Add('-');
                      end
                      else
                      begin
                        SubItems.Add(BitDepth + ' bit');
                      end;
                      SubItems.Add(LTag.Title);
                      SubItems.Add(LTag.Album);
                      SubItems.Add(LTag.Artist);
                      SubItems.Add(LTag.Genre);
                      StartPositions.Add('0');
                      EndPositions.Add(FloatToStr(FileDuration));
                      ConstantDurations.Add(FloatToStr(FileDuration));
                      if AudioOnly then
                      begin
                        StateIndex := 1;
                        ImageIndex := -1;
                      end
                      else
                      begin
                        StateIndex := 0;
                        ImageIndex := -1;
                      end;
                    end;

                    ExtensionsForCopy.Add(ExtensionLine);

                  end;

                end;
              end
              else
              begin
                AddToLog(0, 'Cannot add file: ' + FileName + ' [No video streams found: ' + VideoCount + ']');
              end;

            end
            else
            begin
              AddToLog(0, 'Cannot add file: ' + FileName + ' [Duration is not valid: ' + FloatToStr(FileDuration) + ']');
            end;

          end
          else
          begin
            AddToLog(0, 'File doesn''t have any audio streams: ' + ExtractFileName(FileName));
          end;

        finally
          MediaInfo_Close(MediaInfoHandle);
          FileInfo.Free;
          FreeAndNil(FAudioIndexes);
        end;

      end;
    end;

  end;

end;

procedure TMainForm.AddFiles1Click(Sender: TObject);
var
  i: Integer;
  LprevCount: integer;
  LNow: TDateTime;
begin
  // todo: wtf use a constant or someting.
  OpenDialog.InitialDir := FLastDirectory;
  OpenDialog.Filter := 'Supported|*.rmvb;*.mp4;*.mkv;*.avi;*.mov;*.m4v;*.mpeg;*' + '.mpg;*.flv;*.vob;*.divx;*.wmv;*.mp3;*.wav;*.m4a;*.mpa;*.mp2;*.mka;*.flac;*.ogg;*' + '.tta;*.mpc;*.aac;*.ac3;*.spx;*.opus;*.shn;*.wv;*.mpc;*.ape;*.wma;*.3gp;*.3ga;*.m2ts;' + '*.thd;*.amr;*.m4b;*.aac;*.tak;*.dts;*.mts;*.m2ts;*.aiff;*.aif;*.dtsma;*.cue|Video Files' + '|*.rmvb;*.mp4;*.mkv;*.avi;*.mov;*.m4v;*.mpeg;*.mpg;*.flv;*.vob;*.divx;*.wmv;*.3gp;*.' + 'm2ts;*.mts|Audio Files|*.mp3;*.wav;*.m4a;*.flac;*.ogg;*.tta;*.mpc;*.aac;*.ac3;*.spx;*.opus;*.shn;*.wv;*.mpc;*.ape;*.wma;*.3ga;' + '*.thd;*.amr;*.aac;*.m4b;*.tak;*.dts;*.aiff;*.aif;*.dtsma;*.mpa;*.mp2;*.mka|Cue Sheets|*.cue|All Files|*.*';
  AddingStopped := False;
  LprevCount := FileList.Items.Count;
  LNow := Now;
  if OpenDialog.Execute then
  begin
    Self.Enabled := False;
    ProgressForm.show;
    FileList.Items.BeginUpdate;
    try
      for i := 0 to OpenDialog.Files.Count - 1 do
      begin
        Application.ProcessMessages;
        if AddingStopped then
        begin
          Break;
        end
        else
        begin
          ProgressForm.CurrentFileLabel.Caption := ExtractFileName(OpenDialog.Files[i]);
          AddFile(OpenDialog.Files[i]);
        end;
      end;
    finally
      Self.Enabled := True;
      ProgressForm.Close;
      Self.BringToFront;
      FileList.Items.EndUpdate;
      FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
      AddToLog(0, 'Added ' + FloatToStr(FileList.Items.Count - LprevCount) + ' files to the list in ' + TimeToStr(Now - LNow));
    end;
    FLastDirectory := ExtractFileDir(OpenDialog.FileName);
  end;
end;

procedure TMainForm.AddFolder1Click(Sender: TObject);
var
  Search: TSearchRec;
  FileName: string;
  Extension: string;
  LprevCount: Integer;
  LNow: TDateTime;
begin
  OpenFolderDialog.Directory := FLastDirectory;
  LNow := Now;
  if OpenFolderDialog.Execute then
  begin
    FileList.Items.BeginUpdate;
    Self.Enabled := False;
    ProgressForm.show;
    AddingStopped := False;
    LprevCount := FileList.Items.Count;
    try
      if (FindFirst(OpenFolderDialog.Directory + '\*.*', faAnyFile, Search) = 0) then
      begin
        repeat
          Application.ProcessMessages;
          if AddingStopped then
            Break;
          if (Search.Name <> '.') and (Search.Name <> '..') then
          begin
            FileName := OpenFolderDialog.Directory + '\' + Search.Name;
            Extension := LowerCase(ExtractFileExt(FileName));
            if (Extension = '.mp4') or (Extension = '.mov') or (Extension = '.m4v') or (Extension = '.mkv') or (Extension = '.mpeg') or (Extension = '.mpg') or (Extension = '.flv') or (Extension = '.avi') or (Extension = '.vob') or (Extension = '.avs') or (Extension = '.divx') or (Extension = '.wmv') or (Extension = '.rmvb') or (Extension = '.mp3') or (Extension = '.wav') or (Extension = '.m4a') or (Extension = '.flac') or (Extension = '.ogg') or (Extension = '.tta') or (Extension = '.mpc') or (Extension =
              '.aac') or (Extension = '.ac3') or (Extension = '.spx') or (Extension = '.opus') or (Extension = '.shn') or (Extension = '.wv') or (Extension = '.mpc') or (Extension = '.ape') or (Extension = '.wma') or (Extension = '.3gp') or (Extension = '.3ga') or (Extension = '.m2ts') or (Extension = '.thd') or (Extension = '.amr') or (Extension = '.aac') or (Extension = '.m4b') or (Extension = '.tak') or (Extension = '.dts') or (Extension = '.mts') or (Extension = '.aif') or (Extension = '.aiff') or (Extension = '.dtsma') or (Extension = '.mpa') or (Extension = '.mp2') or (Extension = '.mka') or (Extension = '.cue') or (Extension = '.3gpp') then
            begin
              ProgressForm.CurrentFileLabel.Caption := ExtractFileName(FileName);
              AddFile(FileName);
              FLastDirectory := ExtractFileDir(FileName);
            end;
          end;
        until (FindNext(Search) <> 0) and (not AddingStopped);
        FindClose(Search);
      end;
    finally
      FileList.Items.EndUpdate;
      FLastDirectory := OpenFolderDialog.Directory;
      // UpdateListboxScrollBox(FileList);
      FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
      AddToLog(0, 'Added ' + FloatToStr(FileList.Items.Count - LprevCount) + ' files to the list in ' + TimeToStr(Now - LNow));

      Self.Enabled := True;
      ProgressForm.Close;
      Self.BringToFront;
    end;
  end;
end;

procedure TMainForm.AddFolderTree1Click(Sender: TObject);
var
  LprevCount: Integer;
  LNow: TDateTime;
begin
  OpenFolderDialog.Directory := FLastDirectory;
  AddingStopped := False;
  LprevCount := FileList.Items.Count;
  LNow := Now;
  if OpenFolderDialog.Execute then
  begin
    FileSearch.RootDirectory := OpenFolderDialog.Directory;

    FileList.Items.BeginUpdate;
    try
      Self.Enabled := False;
      ProgressForm.show;

      FLastDirectory := OpenFolderDialog.Directory;

      FileSearch.Search;
    finally
      FileList.Items.EndUpdate;
      // UpdateListboxScrollBox(FileList);
      FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
      AddToLog(0, 'Added ' + FloatToStr(FileList.Items.Count - LprevCount) + ' files to the list in ' + TimeToStr(Now - LNow));

      Self.Enabled := True;
      ProgressForm.Close;
      Self.BringToFront;
    end;
  end;
end;

procedure TMainForm.AddMergeCommandLine(Index: Integer; AdvancedOptions: string; const EncoderIndex: integer);
var
  LTmpAudioFileName: string;
  FileName: string;
  AudioStr: string;
  Encoder: TEncoder;
  DepthStr: string;
  StreamIndexCMD: string;
  FileDuration: string;
  FileToDeleteStr: string;
  DurationStr: string;
  VolumeStr: string;
  SpeedStr: string;
  FS: TFormatSettings;
  LStartPos, LDur: integer;
  LProgressItem: string;
begin
  // decide which process to use
  Encoder := FEncoders[EncoderIndex - 1];

  // paths and files
  FileName := Files[Index];
  LTmpAudioFileName := FileName;
  // merging is for audio-only files
  if IsAudioOnly(FileName) then
  begin
{$REGION 'Progress list fill'}
    // if file doesn't exist just ignore it
    if not FileExists(FileName) then
    begin
      AddToLog(0, FileName + ' doesn''t exist, ignored.');
      Exit;
    end
    else
    begin
      LProgressItem := ExtractFileName(FileName);
    end;
{$ENDREGION}
    // get duration of file.
    // convert to seconds first.
    FileDuration := FloatToStr(StrToInt(Durations[Index]) div 1000);
    FMergeTotalDuration := FMergeTotalDuration + (StrToInt(Durations[Index]) div 1000);

    if AudioIndexes[Index] <> '-1' then
    begin
      // todo: find a way to do trimming with it.
      if TagsList[Index].FileType <> 'cd' then
      begin
        // bit depth
        case CodecSettingsForm.BitDepthList.ItemIndex of
          0:
            DepthStr := CreateBitDepthCMD(FileName);
          1:
            DepthStr := '-acodec pcm_s16le';
          2:
            DepthStr := '-acodec pcm_s24le';
          3:
            DepthStr := '-acodec pcm_s32le';
        end;

        // stream index
        // since audio only then it must be empty
        StreamIndexCMD := ' ';

        // audio decoding
        AudioStr := ' -y -i "' + FileName + '" -threads 1 -vn ' + DepthStr + ' -f wav ' + StreamIndexCMD;
        if FAudioEncoderType = etWAV then
        begin
          AudioStr := AudioStr + ' ' + CodecSettingsForm.WAVCMD;
        end;

        // lame cannot encode to multi channel
        // channel must be stereo for aac-hev2
        // todo: check other FEncoders to see if they support multi channel
        // todo: read channel info when adding the file
        // todo: ogg doesnt seem to support >48000hz
        if (FAudioEncoderType = etLAME) or IsHEv2Selected then
        begin
          if GetChannelCount(FileName, StrToInt(AudioIndexes[Index])) > 2 then
          begin
            AudioStr := AudioStr + ' -ac 2';
          end;
        end
        else
        begin
          case CodecSettingsForm.ChannelList.ItemIndex of
            1:
              AudioStr := AudioStr + ' -ac 1';
            2:
              AudioStr := AudioStr + ' -ac 2';
            3:
              AudioStr := AudioStr + ' -ac 6';
          end;
        end;

        // sample rate
        if CodecSettingsForm.SampleList.ItemIndex > 0 then
        begin
          AudioStr := AudioStr + ' -af aresample=resampler=soxr -ar ' + CodecSettingsForm.SampleList.Text;
        end;

        // we have to have trimming values for
        // cue sheets
        if TagsList[Index].FileType = 'cue' then
        begin
          FS.DecimalSeparator := '.';
          LStartPos := StrToInt(StartPositions[Index]);
          LDur := StrToInt(EndPositions[Index]) - StrToInt(StartPositions[Index]);
          DurationStr := ' -ss ' + IntToTime(LStartPos div 1000) + FormatFloat('#.###', ((LStartPos / 1000) - (LStartPos div 1000)), FS) + ' -t ' + IntToTime(LDur div 1000) + FormatFloat('#.###', ((LDur / 1000) - (LDur div 1000)), FS);
        end
        else
        begin
          // disable trimming
          if SettingsForm.DontTrimBtn.Checked then
          begin
            DurationStr := ' ';
          end
          else
          begin
            FS.DecimalSeparator := '.';
            LStartPos := StrToInt(StartPositions[Index]);
            LDur := StrToInt(EndPositions[Index]) - StrToInt(StartPositions[Index]);
            if LDur <> StrToInt(ConstantDurations[Index]) then
            begin
              DurationStr := ' -ss ' + IntToTime(LStartPos div 1000) + FormatFloat('#.###', ((LStartPos / 1000) - (LStartPos div 1000)), FS) + ' -t ' + IntToTime(LDur div 1000) + FormatFloat('#.###', ((LDur / 1000) - (LDur div 1000)), FS);
            end;
          end;
        end;

        // temp wav file is used if encoder isn't wav
        if FAudioEncoderType <> etWAV then
        begin
          LTmpAudioFileName := ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + CreateTempFileName + '.wav';
        end;

        AudioStr := AudioStr + DurationStr + ' "' + LTmpAudioFileName + '"';
        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Decoding');
        Encoder.TempFiles.Add('');
        Encoder.ListItems.Add(LProgressItem);
        FileToDeleteStr := LTmpAudioFileName + '|';

        Encoder.ProcessTypes.Add(etFFMpeg);
        Encoder.FileIndexes.Add(FloatToStr(Index));
      end;

      // in order to show speed
      FTotalLength := FTotalLength + StrToInt(FileDuration);

      // audio filters
      AudioStr := '';

      with FiltersForm do
      begin

        if EnableBtn.Checked then
        begin

          // normalize
          if NormBtn.Checked then
          begin
            AudioStr := AudioStr + ' --norm ';
          end;

          // volume
          if VolumeBtn.Checked then
          begin
            VolumeStr := ' -v ' + ReplaceText(FloatToStr(StrToInt(VolumeEdit.Text) / 100), ',', '.');
            // volume option must be in XYZ.0 format
            if Pos('.', VolumeStr) = 0 then
            begin
              VolumeStr := VolumeStr + '.0'
            end;

            AudioStr := AudioStr + VolumeStr;
          end;

          // thread mode
          if FiltersForm.ThreadBtn.Checked then
          begin
            AudioStr := AudioStr + ' --multi-threaded ';
          end;

          // clipping guard
          if GuardBtn.Checked then
          begin
            AudioStr := AudioStr + ' -G ';
          end;

          // playback speed
          SpeedStr := ReplaceStr(SpeedEdit.Text, ',', '.');
          FS.DecimalSeparator := '.';
          SpeedStr := ReplaceStr(FloatToStr(StrToFloatDef(SpeedStr, 100, FS) / 100), ',', '.');

          // add sox cmd iff there is something to add
          if (AudioStr <> '') or (SpeedStr <> '1') then
          begin
            AudioStr := AudioStr + ' "' + LTmpAudioFileName + '"';
            LTmpAudioFileName := SettingsForm.TempEdit.Text + '\sox_' + FloatToStr(Index) + '.wav';

            AudioStr := AudioStr + ' -V6 --show-progress "' + LTmpAudioFileName + '" speed ' + SpeedStr;

            Encoder.CommandLines.Add(AudioStr);
            Encoder.Paths.Add(FSoxPath);
            Encoder.FileNames.Add(FileName);
            Encoder.Infos.Add('Applying effects');
            Encoder.Durations.Add('1');
            Encoder.TempFiles.Add('');
            Encoder.ListItems.Add(LProgressItem);
            FileToDeleteStr := FileToDeleteStr + LTmpAudioFileName + '|';
            Encoder.ProcessTypes.Add(etSox);
            Encoder.FileIndexes.Add(FloatToStr(Index));
            Encoder.UsingSox := True;
          end
          else
          begin
            Encoder.UsingSox := False;
          end;

        end;
      end;

      // lossyWAV
      if (CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0) and CanUseLossyWAV then
      begin
        AudioStr := '';
        AudioStr := AudioStr + '" " "' + LTmpAudioFileName + '" ';
        case CodecSettingsForm.LossyWAVQualityList.ItemIndex of
          1:
            AudioStr := AudioStr + ' -q I';
          2:
            AudioStr := AudioStr + ' -q E';
          3:
            AudioStr := AudioStr + ' -q H';
          4:
            AudioStr := AudioStr + ' -q S';
          5:
            AudioStr := AudioStr + ' -q C';
          6:
            AudioStr := AudioStr + ' -q P';
          7:
            AudioStr := AudioStr + ' -q X';
        end;
        AudioStr := AudioStr + ' -o "' + ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '"';
        LTmpAudioFileName := ChangeFileExt(LTmpAudioFileName, '.lossy.wav');

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FLossyWAVPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Infos.Add('lossyWAV');
        Encoder.Durations.Add('1');
        Encoder.TempFiles.Add('');
        FileToDeleteStr := FileToDeleteStr + LTmpAudioFileName + '|';
        Encoder.ProcessTypes.Add(etLossyWAV);
        Encoder.FileIndexes.Add(FloatToStr(Index));
      end;
    end;

    // add list of files to be merged
    FMergeFileList.Add('file ''' + LTmpAudioFileName + '''');
  end;
end;

procedure TMainForm.AddToLog(const LogID: ShortInt; const MSG: string);
var
  LogFolder: string;
begin

  if Portable then
  begin
    LogFolder := '\logs';
  end
  else
  begin
    LogFolder := '';
  end;

  if not DirectoryExists(AppDataFolder + LogFolder) then
  begin
    if not CreateDir(AppDataFolder + LogFolder) then
      Exit;
  end;

  case LogID of
    0: // tac log
      begin
        if Length(MSG) > 0 then
        begin
          WriteLnToFile(AppDataFolder + LogFolder + '\log_main.txt', '[' + DateTimeToStr(Now) + '] ' + MSG);
        end
        else
        begin
          WriteLnToFile(AppDataFolder + LogFolder + '\log_main.txt', MSG);
        end;
      end;
    17: // deleted log
      begin
        WriteLnToFile(AppDataFolder + LogFolder + '\log_deleted.txt', '[' + DateTimeToStr(Now) + '] ' + MSG);
      end;
    18: // command lines
      begin
        WriteLnToFile(AppDataFolder + LogFolder + '\log_cmd.txt', MSG);
      end;
    19: // compression level
      begin
        WriteLnToFile(AppDataFolder + LogFolder + '\log_comp.txt', MSG);
      end;
    20:
      begin
        WriteLnToFile(AppDataFolder + LogFolder + '\log_merge.txt', MSG);
      end;
  else
    begin
      if (0 < LogID) and (LogID < 17) then
      begin
        WriteLnToFile(AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(LogID) + '.txt', MSG);
      end;
    end;
  end;

end;

procedure TMainForm.AftenBitrateEditMouseLeave(Sender: TObject);
begin

  if Length((Sender as TsSpinEdit).Text) < 1 then
  begin
    (Sender as TsSpinEdit).Text := '128';
  end;

end;

procedure TMainForm.AlbumArtistEditChange(Sender: TObject);
var
  LT: TTrackInfo;
  I: Integer;
begin
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if TracksList.Items[I].Selected then
    begin
      LT := FTrackInfoList[I];
      LT.TrackTagInfo.AlbumArtist := AlbumArtistEdit.Text;
      FTrackInfoList[I] := LT;
    end;
  end;
end;

procedure TMainForm.AlbumEditChange(Sender: TObject);
var
  LT: TTrackInfo;
  I: Integer;
begin
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if TracksList.Items[I].Selected then
    begin
      LT := FTrackInfoList[I];
      LT.TrackTagInfo.Album := AlbumEdit.Text;
      FTrackInfoList[I] := LT;
      TracksList.Items[I].SubItems[1] := AlbumEdit.Text
    end;
  end;
end;

function TMainForm.ApePercentage(const APEOutput: string): integer;
var
  StrPos1: integer;
  TmpStr: string;
begin

  if Length(APEOutput) > 0 then
  begin
    // log(APEOutput);
    StrPos1 := 10;

    TmpStr := Copy(APEOutput, StrPos1, 3);
    if TmpStr = '100' then
    begin
      Result := 100;
      // Log('progress: ' + TmpStr);
    end
    else if IsStringNumeric(TmpStr) then
    begin
      Result := StrToInt(TmpStr);
      // Log('progress: ' + TmpStr);
    end;
  end
  else
  begin
    // Log('too short');
  end;

end;

procedure TMainForm.ArtistEditChange(Sender: TObject);
var
  LT: TTrackInfo;
  I: Integer;
begin
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if TracksList.Items[I].Selected then
    begin
      LT := FTrackInfoList[I];
      LT.TrackTagInfo.Artist := ArtistEdit.Text;
      FTrackInfoList[I] := LT;
      TracksList.Items[I].SubItems[2] := ArtistEdit.Text;
    end;
  end;
end;

procedure TMainForm.AssignLabelToProgressBar(Lbl: TsLabel; PB: TsProgressBar);
begin
  Lbl.Parent := PB;
  Lbl.AutoSize := False;
  Lbl.Left := 0;
  Lbl.Width := PB.Width;
  Lbl.Top := (PB.Height - Lbl.Height) div 2;
  Lbl.Alignment := taCenter;
  Lbl.Caption := '0%';
  Lbl.BringToFront;
  PB.SendToBack;
end;

procedure TMainForm.AudioCodecListChange(Sender: TObject);
begin
  case AudioCodecList.ItemIndex of
    0: // fdk
      FAudioEncoderType := etFDKAAC;
    1: // ffmpeg aac
      FAudioEncoderType := etFFMpegAAC;
    2: // fhg
      FAudioEncoderType := etFHGAAC;
    3: // neroaac
      FAudioEncoderType := etNeroAAC;
    4: // qaac
      FAudioEncoderType := etQAAC;
    5: // ffmpeg ac3
      FAudioEncoderType := etFFMpegAC3;
    6: // mp3
      FAudioEncoderType := etLAME;
    7: // mpc
      FAudioEncoderType := etMPC;
    8: // ogg
      FAudioEncoderType := etOgg;
    9: // opus
      FAudioEncoderType := etOpus;
    10: // wma
      FAudioEncoderType := etWMA;
    11: // dca
      FAudioEncoderType := etDCA;
    12: // alac
      FAudioEncoderType := etFFmpegALAC;
    13: // flac
      FAudioEncoderType := etFLAC;
    14: // flaccl
      FAudioEncoderType := etFLACCL;
    15: // ape
      FAudioEncoderType := etAPE;
    16: // tak
      FAudioEncoderType := etTAK;
    17: // tta
      FAudioEncoderType := etTTA;
    18: // wavpack
      FAudioEncoderType := etWavPack;
    19: // aiff
      FAudioEncoderType := etAIFF;
    20: // wav
      FAudioEncoderType := etWAV;
  end;
  UpdateSummaryLabel;
end;

procedure TMainForm.AudioEffectsBtnClick(Sender: TObject);
begin

  FiltersForm.show;

end;

procedure TMainForm.AudioMethodListChange(Sender: TObject);
begin
  CodecSettingsBtn.Enabled := AudioMethodList.ItemIndex <> 1;
  AudioCodecList.Enabled := AudioMethodList.ItemIndex <> 1;
  NextCodecBtn.Enabled := AudioMethodList.ItemIndex <> 1;
  PrevCodecBtn.Enabled := AudioMethodList.ItemIndex <> 1;
  AudioEffectsBtn.Enabled := AudioMethodList.ItemIndex <> 1;
  SummaryLabel.Enabled := AudioMethodList.ItemIndex <> 1;
  ProfilesList.Enabled := AudioMethodList.ItemIndex <> 1;
  UpdateSummaryLabel;
end;

procedure TMainForm.AudioTrackListChange(Sender: TObject);
var
  StrPos: integer;
  TmpLst: TStringList;
begin

  if AudioTrackList.Items.Count > 0 then
  begin

    if FileList.ItemIndex > -1 then
    begin
      StrPos := Pos(',', AudioTrackList.Text);
      AudioIndexes[FileList.ItemIndex] := Copy(AudioTrackList.Text, 1, StrPos - 1);
      TmpLst := TStringList.Create;
      try
        TmpLst.Delimiter := ',';
        TmpLst.StrictDelimiter := True;
        TmpLst.DelimitedText := ExtensionsForCopy[FileList.ItemIndex];

        CopyExtension[FileList.ItemIndex] := TmpLst[AudioTrackList.ItemIndex];
      finally
        FreeAndNil(TmpLst);
      end;

    end;

  end;

end;

procedure TMainForm.BlogBtnClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://ozok26.blogspot.com/', nil, nil, SW_SHOWNORMAL)
end;

procedure TMainForm.C1Click(Sender: TObject);
begin
  Self.Enabled := False;
  ComponentsForm.show;
end;

procedure TMainForm.C2Click(Sender: TObject);
begin
  CreateLogBtnClick(Self);
end;

function TMainForm.CalcFileSize(const FilePath: string): int64;
var
  FS: TFileStream;
begin
  Result := 0;
  if FileExists(FilePath) then
  begin
    FS := TFileStream.Create(FilePath, fmOpenRead or fmShareDenyWrite);
    try
      Result := FS.Size;
    finally
      FS.Free;
    end;
  end;
end;

procedure TMainForm.CalcTotalCompression;
var
  I: Integer;
  FirstFile, SecondFile: int64;
begin
  for I := 0 to CompressionPairs.Count - 1 do
  begin
    if FileExists(CompressionPairs[I].SourcePath) and FileExists(CompressionPairs[I].DestinationPath) then
    begin
      inc(FirstFile, CalcFileSize(CompressionPairs[I].SourcePath));
      inc(SecondFile, CalcFileSize(CompressionPairs[I].DestinationPath));
    end;
  end;
  if FirstFile > 0 then
  begin
    AddToLog(19, '[' + FormatFloat('#.###', (100 * SecondFile) / FirstFile) + '%] Total compression.');
  end;
end;

function TMainForm.CanAddFile(const FileName: string): Boolean;
var
  LSplitList: TStringList;
  LExt: string;
  I: Integer;
begin
  Result := True;

  LSplitList := TStringList.Create;
  try
    LSplitList.StrictDelimiter := True;
    LSplitList.Delimiter := ';';
    LSplitList.DelimitedText := SettingsForm.FileExtFilterEdit.Text;

    if LSplitList.Count > 0 then
    begin
      // get extension without the dot
      LExt := Trim(Copy(LowerCase(ExtractFileExt(FileName)), 2, MaxInt));
      // if ext. matches any that's been banned return false
      for I := 0 to LSplitList.Count - 1 do
      begin
        Application.ProcessMessages;
        if LExt = LSplitList[I] then
        begin
          Result := False;
          Break;
        end;
      end;
    end;
  finally
    LSplitList.Free;
  end;
end;

function TMainForm.CanUseLossyWAV: Boolean;
begin
  if CodecSettingsForm.LossyWAVQualityList.ItemIndex = 0 then
  begin
    Result := False;
    Exit;
  end;
  Result := (FAudioEncoderType = etFFmpegALAC) or (FAudioEncoderType = etFLAC) or (FAudioEncoderType = etFLACCL) or (FAudioEncoderType = etTAK) or (FAudioEncoderType = etTTA) or (FAudioEncoderType = etAPE) or ((FAudioEncoderType = etWavPack) and (CodecSettingsForm.WavPackMethodList.ItemIndex = 0));
end;

function TMainForm.CDCreateArtworkCMD(const CoverPath: string): string;
begin

  Result := '';

  // if artwork copying and embeding artwork is selected
  if SettingsForm.ArtworkBtn.Checked and (SettingsForm.ArtworkList.ItemIndex = 1) then
  begin
    // if image file exists, either extracted or external.
    // create command line
    if FileExists(CoverPath) then
    begin
      Result := CoverPath;
      if FAudioEncoderType = etLAME then
      begin
        if (not CodecSettingsForm.LameUseTTaggerBtn.Checked) then
        begin
          Result := ' --ti "' + CoverPath + '"';
        end
        else
        begin
          Result := CoverPath;
        end;
      end
      else if (FAudioEncoderType = etFLAC) then
      begin
        if not CodecSettingsForm.FLACUseTTaggerBtn.Checked then
        begin
          Result := ' --picture="' + CoverPath + '"';
        end
        else
        begin
          Result := CoverPath;
        end
      end
      else if (FAudioEncoderType = etFLACCL) then
      begin
        if (not CodecSettingsForm.FLACCLUseTTaggerBtn.Checked) then
        begin
          Result := ' --picture="' + CoverPath + '"';
          DebugMsg('art 5');
        end
        else
        begin
          Result := CoverPath;
        end;
      end
      else if (FAudioEncoderType = etOpus) then
      begin
        if (not CodecSettingsForm.OpusUseTTaggerBtn.Checked) then
        begin
          Result := ' --picture "' + CoverPath + '" ';
        end
        else
        begin
          Result := CoverPath;
        end;
      end;
    end;
  end;
end;

function TMainForm.CDCreateTagCMD(const TotalTracks: Integer; const TrackIndex: Integer): string;
var
  FTagIniFile: TMemIniFile;
  LArtist, LGenre, LPerformer, LAlbum, LRecordDate, LTrackNo, LComment, LTitle: string;

  procedure WriteTagsToIni(const AudioEncoder: TEncoderType; const TotalTracks: Integer; const Track: Integer);
  begin
    with FTagIniFile do
    begin
      // write tags if it is enabled
      if SettingsForm.TagsBtn.Checked then
      begin
        WriteString('tag', 'Title', FTrackInfoList[Track].TrackTagInfo.Title);
        WriteString('tag', 'Artist', FTrackInfoList[Track].TrackTagInfo.Artist);
        WriteString('tag', 'Album', FTrackInfoList[Track].TrackTagInfo.Album);
        WriteString('tag', 'Genre', FTrackInfoList[Track].TrackTagInfo.Genre);
        WriteString('tag', 'Date', FTrackInfoList[Track].TrackTagInfo.Date);
        WriteString('tag', 'TrackNo', FTrackInfoList[Track].TrackTagInfo.TrackNo);
        WriteString('tag', 'TrackTotal', FloatToStr(TotalTracks));
        // write tool tag
        WriteBool('tag', 'writetag', SettingsForm.ToolTagBtn.Checked);
        if SettingsForm.ToolTagBtn.Checked then
        begin
          case AudioEncoder of
            etFDKAAC:
              WriteString('tag', 'tool', 'FDKAAC');
            etFFMpegAAC:
              WriteString('tag', 'tool', 'FFMpeg');
            etFHGAAC:
              WriteString('tag', 'tool', 'FHGAAC');
            etNeroAAC:
              WriteString('tag', 'tool', 'NeroAAC');
            etQAAC:
              WriteString('tag', 'tool', 'QAAC');
            etFFMpegAC3:
              WriteString('tag', 'tool', 'FFMpeg');
            etLAME:
              WriteString('tag', 'tool', 'Lame');
            etMPC:
              WriteString('tag', 'tool', 'MPC');
            etOgg:
              WriteString('tag', 'tool', 'OggEnc2');
            etOpus:
              WriteString('tag', 'tool', 'OpusEnc');
            etWMA:
              WriteString('tag', 'tool', 'WMAEncode');
            etFFmpegALAC:
              WriteString('tag', 'tool', 'RefALAC');
            etFLAC:
              WriteString('tag', 'tool', 'FLAC');
            etFLACCL:
              WriteString('tag', 'tool', 'FLACCL');
            etAPE:
              WriteString('tag', 'tool', 'MAC');
            etTAK:
              WriteString('tag', 'tool', 'TAKc');
            etTTA:
              WriteString('tag', 'tool', 'TTAenc');
            etWavPack:
              WriteString('tag', 'tool', 'WavPack');
            etAIFF:
              WriteString('tag', 'tool', 'FFMpeg');
            etWAV:
              WriteString('tag', 'tool', 'FFMpeg');
            etDCA:
              WriteString('tag', 'tool', 'dcaenc');
          end;
        end;
        WriteString('tag', 'Comment', FTrackInfoList[Track].TrackTagInfo.Comment);
        WriteString('tag', 'AlbumArtist', '');
        WriteString('tag', 'Composer', '');
        WriteString('tag', 'NameSort', '');
        WriteString('tag', 'ArtistSort', '');
        WriteString('tag', 'AlbumArtistSort', '');
        WriteString('tag', 'AlbumSort', '');
        WriteString('tag', 'REPLAYGAIN_ALBUM_GAIN', '');
        WriteString('tag', 'REPLAYGAIN_ALBUM_PEAK', '');
        WriteString('tag', 'REPLAYGAIN_TRACK_GAIN', '');
        WriteString('tag', 'REPLAYGAIN_TRACK_PEAK', '');
      end;
      WriteString('tag', 'Cover', FTrackInfoList[TrackIndex].TrackTagInfo.CoverPath);
      UpdateFile;
    end;
  end;

begin

  Result := ' ';
  // get tags from cdinfofile
  LTitle := FTrackInfoList[TrackIndex].TrackTagInfo.Title;
  LArtist := FTrackInfoList[TrackIndex].TrackTagInfo.Artist;
  LGenre := FTrackInfoList[TrackIndex].TrackTagInfo.Genre;
  LPerformer := FTrackInfoList[TrackIndex].TrackTagInfo.Artist;
  LAlbum := FTrackInfoList[TrackIndex].TrackTagInfo.Album;
  LRecordDate := FTrackInfoList[TrackIndex].TrackTagInfo.Date;
  LTrackNo := FTrackInfoList[TrackIndex].TrackTagInfo.TrackNo;
  LComment := FTrackInfoList[TrackIndex].TrackTagInfo.Comment;

  FTagIniFile := TMemIniFile.Create(SettingsForm.TempEdit.Text + '\' + FloatToStr(TrackIndex) + 'tag.txt', TEncoding.UTF8);
  try
    with FTagIniFile do
    begin
      // write tag type.
      // also for some codecs, just create tag command line.
      case FAudioEncoderType of
        etFDKAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
            WriteTagsToIni(etFDKAAC, TotalTracks, TrackIndex);
          end;
        etFFMpegAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
            WriteTagsToIni(etFFMpegAAC, TotalTracks, TrackIndex);
          end;
        etFHGAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
            WriteTagsToIni(etFHGAAC, TotalTracks, TrackIndex);
          end;
        etNeroAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
            WriteTagsToIni(etNeroAAC, TotalTracks, TrackIndex);
          end;
        etQAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
            WriteTagsToIni(etQAAC, TotalTracks, TrackIndex);
          end;
        etLAME:
          begin
            WriteString('taginfo', 'type', 'id3v2');
            if CodecSettingsForm.LameUseTTaggerBtn.Checked then
            begin
              WriteTagsToIni(etLAME, TotalTracks, TrackIndex);
            end
            else
            begin
              Result := ' --id3v2-ucs2 --ta "' + LArtist + '" --tt "' + LTitle + '" --tg "' + LGenre + '" --tl "' + LAlbum + '" --ty "' + LRecordDate + '" --tn "' + LTrackNo + '" --tc "' + LComment + '"';
            end;
          end;
        etMPC:
          begin
            Result := ' --ape2 --artist "' + LArtist + '" --title "' + LTitle + '" --album "' + LAlbum + '" --year "' + LRecordDate + '" --track "' + LTrackNo + '" --genre "' + LGenre + '" --comment "' + LComment + '"'
          end;
        etOgg:
          begin
            WriteString('taginfo', 'type', 'ogg');
            if CodecSettingsForm.OggUseTTaggerBtn.Checked then
            begin
              WriteTagsToIni(etOgg, TotalTracks, TrackIndex);
            end
            else
            begin
              Result := ' -a "' + LArtist + '" -t "' + LTitle + '" -l "' + LAlbum + '" --genre "' + LGenre + '" -d "' + LRecordDate + '" -N "' + LTrackNo + '" -c "comment=' + LComment + '"';
            end;
          end;
        etOpus:
          begin
            WriteString('taginfo', 'type', 'ogg');
            if CodecSettingsForm.OpusUseTTaggerBtn.Checked then
            begin
              WriteTagsToIni(etOgg, TotalTracks, TrackIndex); // same thing
            end
            else
            begin
              Result := ' --artist "' + LArtist + '" --title "' + LTitle + '" --comment "genre=' + LGenre + '" --comment "composer=' + LTitle + '" --comment "album=' + LAlbum + '" --comment "date=' + LRecordDate + '" --comment "TRACKNUMBER=' + LTrackNo + '" --comment "comment=' + LComment + '"';
            end;
          end;
        etWMA:
          begin
            WriteString('taginfo', 'type', 'wma');
            WriteTagsToIni(etWMA, TotalTracks, TrackIndex);
          end;
        etFFmpegALAC:
          begin
            WriteString('taginfo', 'type', 'alac');
            WriteTagsToIni(etFFmpegALAC, TotalTracks, TrackIndex);
          end;
        etFLAC..etFLACCL:
          begin
            WriteString('taginfo', 'type', 'flac');
            if CodecSettingsForm.FLACUseTTaggerBtn.Checked then
            begin
              WriteTagsToIni(etFLAC, TotalTracks, TrackIndex);
            end
            else
            begin
              Result := ' --tag=artist="' + LArtist + '" --tag=title="' + LTitle + '" --tag=genre="' + LGenre + '" --tag=composer="' + LArtist + '" --tag=album="' + LAlbum + '" --tag=date="' + LRecordDate + '" --tag=TRACKNUMBER="' + LTrackNo + '" --tag=comment="' + LComment + '" ';
            end;
          end;
        etAPE:
          begin
            WriteString('taginfo', 'type', 'apev2');
            WriteTagsToIni(etAPE, TotalTracks, TrackIndex);
          end;
        etTAK:
          begin
            WriteString('taginfo', 'type', 'apev2');
            WriteTagsToIni(etTAK, TotalTracks, TrackIndex);
          end;
        etTTA:
          begin
            WriteString('taginfo', 'type', 'apev2');
            WriteTagsToIni(etTTA, TotalTracks, TrackIndex);
          end;
        etWavPack:
          begin
            WriteString('taginfo', 'type', 'apev2');
            WriteTagsToIni(etWavPack, TotalTracks, TrackIndex);
          end;
      end;
    end;
  finally
    FTagIniFile.Free;
    // some FEncoders might be selected to write their own cover art and tags
    if ((FAudioEncoderType = etLAME) and (not CodecSettingsForm.LameUseTTaggerBtn.Checked)) or ((FAudioEncoderType = etFLAC) and (not CodecSettingsForm.FLACUseTTaggerBtn.Checked)) or ((FAudioEncoderType = etFLACCL) and (not CodecSettingsForm.FLACCLUseTTaggerBtn.Checked)) or ((FAudioEncoderType = etOpus) and (not CodecSettingsForm.OpusUseTTaggerBtn.Checked)) then
    begin
      Result := Result + CDCreateArtworkCMD(FTrackInfoList[TrackIndex].TrackTagInfo.CoverPath);
    end;
  end;
end;

procedure TMainForm.CDProgressTimerTimer(Sender: TObject);
var
  I: Integer;
  LStr: string;
  LInt: integer;
begin
  for I := 0 to FTrackInfoList.Count - 1 do
  begin
    Application.ProcessMessages;

    if FTrackInfoList[I].WillBeRipped then
    begin
      case FTrackInfoList[I].TrackState of
        tsWaiting:
          begin
            LInt := 1;
            LStr := 'Waiting';
          end;
        tsRipped:
          begin
            LInt := 2;
            LStr := 'Ripped';
          end;
        tsConverted:
          begin
            LInt := 0;
            LStr := 'Converting';
          end;
        tsErrorWhileRipping:
          begin
            LInt := 3;
            LStr := 'Ripping error';
          end;
        tsErrorWhileConverting:
          begin
            LInt := 3;
            LStr := 'Converting error';
          end;
        tsRipping:
          begin
            LInt := 0;
            LStr := 'Ripping';
          end;
      end;

      if Assigned(CDPRogressList.Items[FTrackInfoList[I].Index - 1]) then
      begin
        if CDPRogressList.Items[FTrackInfoList[I].Index - 1].StateIndex <> LInt then
        begin
          CDPRogressList.Items[FTrackInfoList[I].Index - 1].StateIndex := LInt
        end;
        if CDPRogressList.Items[FTrackInfoList[I].Index - 1].SubItems[0] <> LStr then
        begin
          CDPRogressList.Items[FTrackInfoList[I].Index - 1].SubItems[0] := LStr
        end;
      end;
    end;
  end;
end;

procedure TMainForm.ChangeLog1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar(ExtractFileDir(Application.ExeName) + '\ChangeLog.txt'), nil, nil, SW_SHOWNORMAL);
end;

// function TMainForm.CheckOutputFile(const FileIndex: integer): Boolean;
// var
// OutputName: string;
// begin
//
// if FileIndex < FilesToCheck.Count then
// Result := FileExists(FilesToCheck[FileIndex]);
//
// end;

function TMainForm.CheckOutputFiles: Boolean;
var
  i: integer;
  MsgStr: string;
begin

  Result := True;
  MsgStr := '';

  // check each file
  for i := 0 to FilesToCheck.Count - 1 do
  begin

    if (not FileExists(FilesToCheck[i])) and (CalcFileSize(FilesToCheck[i]) < 1) then
    begin

      // add to log
      AddToLog(0, 'Cannot find output file ' + FilesToCheck[i]);

      Result := False;

      MsgStr := MsgStr + #10#13 + '-' + ExtractFileName(FilesToCheck[i])

    end;

  end;

  // show a warning to the user
  if Result = False then
  begin
    TrayIcon.Active := True;
    TrayIcon.BalloonHint('TAudioConverter', 'Following files could not be created: ' + MsgStr + #10#13 + #10#13 + 'See log for more detail.', btError, 5000);
    if sSkinManager1.Active then
    begin
      sSkinManager1.RepaintForms(True);
    end;
  end
  else
  begin
    // add to log
    AddToLog(0, 'TAudioConverter could locate all the output files');
  end;

end;

procedure TMainForm.CodecSettingsBtnClick(Sender: TObject);
begin
  Self.Enabled := False;
  if (FAudioEncoderType = etFFmpegALAC) or (FAudioEncoderType = etFLAC) or (FAudioEncoderType = etFLACCL) or (FAudioEncoderType = etTAK) or (FAudioEncoderType = etTTA) or (FAudioEncoderType = etAPE) or ((FAudioEncoderType = etWavPack) and (CodecSettingsForm.WavPackMethodList.ItemIndex = 0)) then
  begin
    CodecSettingsForm.LossyWAVQualityList.Enabled := True;
    CodecSettingsForm.LossyWAVEncoderOptBtn.Enabled := CodecSettingsForm.LossyWAVQualityList.ItemIndex <> 0;
  end
  else
  begin
    CodecSettingsForm.LossyWAVQualityList.Enabled := False;
    CodecSettingsForm.LossyWAVEncoderOptBtn.Enabled := False;
  end;
  CodecSettingsForm.CodecPages.ActivePageIndex := AudioCodecList.ItemIndex;
  case AudioCodecList.ItemIndex of
    0:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' FDKAAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.FDKAACCMD;
      end;
    1:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' FFMpeg AAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.FFMpegAACCMD;
      end;
    2:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' FHGAAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.FHGAACCMD;
      end;
    3:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' NeroAAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.NeroAACCMD;
      end;
    4:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' QAAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.QAACCMD;
      end;
    5:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' AC3';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.AC3CMD;
      end;
    6:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' MP3';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.LameCMD;
      end;
    7:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' Musepack';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.MPCCMD;
      end;
    8:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' Ogg Vorbis';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.OggCMD;
      end;
    9:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' Opus';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.OpusCMD;
      end;
    10:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' WMA';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.WMACMD;
      end;
    11:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' dcaenc';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.DcaencCMD;
      end;
    12:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' ALAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.ALACCMD;
      end;
    13:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' FLAC';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.FLACCMD;
      end;
    14:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' FLACCL';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.FLACCLCMD;
      end;
    15:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' Monkey''s Audio';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.APECMD;
      end;
    16:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' TAK';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.TAKCMD;
      end;
    17:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' TTA';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.TTACMD;
      end;
    18:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' WavPack';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.WavPackCMD;
      end;
    19:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' AIFF';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.AIFFCMD;
      end;
    20:
      begin
        CodecSettingsForm.Caption := 'Settings for ' + ' WAV';
        CodecSettingsForm.CustomCodecOptionsEdit.Text := CodecSettingsForm.WAVCMD;
      end;
  end;
  CodecSettingsForm.show;
end;

function TMainForm.CodecToExtension(const AudioCodec: string): string;
var
  TmpStr: string;
begin

  TmpStr := Trim(AudioCodec);

  if ContainsText(TmpStr, 'vorbis') then
  begin
    Result := '.ogg';
  end
  else if (TmpStr = 'MPEG-1 Audio layer 2') or ContainsText(TmpStr, 'mp2') then
  begin
    Result := '.mp2'
  end
  else if (TmpStr = 'MPEG-1 Audio layer 3') or ContainsText(TmpStr, 'mp3') or ContainsText(TmpStr, 'lame') or ContainsText(TmpStr, 'mpeg') or ContainsText(TmpStr, 'mpa1l3') then
  begin
    Result := '.mp3';
  end
  else if ContainsText(TmpStr, 'aac') then
  begin
    Result := '.' + LowerCase(SettingsForm.AACExtList.Text);
  end
  else if ContainsText(TmpStr, 'truehd') then
  begin
    Result := '.thd';
  end
  else if ContainsText(TmpStr, 'ac3') then
  begin
    Result := '.ac3';
  end
  else if ContainsText(TmpStr, 'wavpack') then
  begin
    Result := '.wv';
  end
  else if ContainsText(TmpStr, 'wav') or ContainsText(TmpStr, 'pcm') then
  begin
    Result := '.wav';
  end
  else if ContainsText(TmpStr, 'mpa1l2') then
  begin
    Result := '.mp2';
  end
  else if ContainsText(TmpStr, 'amr') then
  begin
    Result := '.amr';
  end
  else if ContainsText(TmpStr, 'flac') then
  begin
    Result := '.flac';
  end
  else if ContainsText(TmpStr, 'dts') then
  begin
    Result := '.dts';
  end
  else if ContainsText(TmpStr, 'monkey') then
  begin
    Result := '.ape';
  end;

end;

procedure TMainForm.CommentEditChange(Sender: TObject);
var
  LT: TTrackInfo;
  I: Integer;
begin
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if TracksList.Items[I].Selected then
    begin
      LT := FTrackInfoList[I];
      LT.TrackTagInfo.Comment := CommentEdit.Text;
      FTrackInfoList[I] := LT;
    end;
  end;
end;

procedure TMainForm.CompressionPercentages;
var
  I: Integer;
  LSourceSize, LDestSize: int64;
begin

  for I := 0 to CompressionPairs.Count - 1 do
  begin
    Application.ProcessMessages;

    if FileExists(CompressionPairs[I].SourcePath) then
    begin
      if FileExists(CompressionPairs[I].DestinationPath) then
      begin
        LSourceSize := CalcFileSize(CompressionPairs[I].SourcePath);
        LDestSize := CalcFileSize(CompressionPairs[I].DestinationPath);
        if LSourceSize > 0 then
        begin
          if LDestSize > 0 then
          begin
            AddToLog(19, '[' + FormatFloat('#.###', (100 * LDestSize) / LSourceSize) + '%] ' + CompressionPairs[I].SourcePath + ' to ' + CompressionPairs[I].DestinationPath);
          end
          else
          begin
            AddToLog(19, 'Destination is empty ' + CompressionPairs[I].DestinationPath);
          end;
        end
        else
        begin
          AddToLog(19, 'Source is empty ' + CompressionPairs[I].SourcePath);
        end;
      end
      else
      begin
        AddToLog(19, 'Destination doesn''t exist ' + CompressionPairs[I].DestinationPath);
      end;
    end
    else
    begin
      AddToLog(19, 'Source doesn''t exist ' + CompressionPairs[I].SourcePath);
    end;
  end;
  CalcTotalCompression;
  AddToLog(19, '===========================End===========================');
  AddToLog(19, '');

end;

function TMainForm.CreateArtworkCMD(const FileName: string; const FileIndex: integer): string;
var
  ImageFiles: TStringList;
  ImageFile: string;
  Extension: string;
  Search: TSearchRec;
  UseExternal: Boolean;
  ArtworkExtractor: TArtworkExtractor;
  LIR: TImageResizer;
begin

  Result := '';

  // if artwork copying and embeding artwork is selected
  if SettingsForm.ArtworkBtn.Checked and (SettingsForm.ArtworkList.ItemIndex = 1) then
  begin
    if FileExists(FileName) then
    begin
      ImageFiles := TStringList.Create;
      try
        case SettingsForm.ArtworkPriortyList.ItemIndex of
          0:
            begin
              // first try embedded artwork
              if (TagsList[FileIndex].CoverImageType <> 'fff') and (Length(TagsList[FileIndex].CoverImageType) > 0) then
              begin
                // extract embedded artwork
                ImageFile := ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + FloatToStr(FileIndex) + '.' + TagsList[FileIndex].CoverImageType;
                ArtworkExtractor := TArtworkExtractor.Create(FileName, ChangeFileExt(ImageFile, ''), FArtworkExtractorPath);
                try
                  ArtworkExtractor.Start;
                  while ArtworkExtractor.AEStatus = aeReading do
                  begin
                    Application.ProcessMessages;
                    Sleep(10);
                  end;
                finally
                  ArtworkExtractor.Free;
                end;

                if FileExists(ImageFile) then
                begin
                  // resize embedded artwork
                  if SettingsForm.ResizeArtworkbtn.Checked then
                  begin
                    LIR := TImageResizer.Create(ImageFile, ImageFile);
                    try
                      LIR.Width := StrToInt(SettingsForm.WidthEdit.Text);
                      LIR.Height := StrToInt(SettingsForm.HeightEdit.Text);
                      LIR.Resize;
                    finally
                      LIR.Free;
                    end;
                  end;
                  UseExternal := False;
                end
                else
                begin
                  UseExternal := True;
                end;

              end
              else
              begin
                // AddToLog(0, 'No embedded artwork');
                UseExternal := True;
              end;

              // that means no embedded artwork in source
              if UseExternal then
              begin
                // if cannot extract embedded artwork then
                // try external files
                // get all image files in the file's folder
                if (FindFirst(ExtractFileDir(FileName) + '\*.*', faAnyFile, Search) = 0) then
                begin
                  repeat
                    Application.ProcessMessages;

                    if (Search.Name = '.') or (Search.Name = '..') then
                      Continue;

                    Extension := LowerCase(ExtractFileExt(Search.Name));

                    if (Extension = '.png') or (Extension = '.jpeg') or (Extension = '.jpg') then
                    begin
                      if ContainsText(Search.Name, 'FRONT') or ContainsText((Search.Name), 'BACK') or ContainsText((Search.Name), 'DISC') or ContainsText((Search.Name), 'CD') or ContainsText((Search.Name), 'INLAY') or ContainsText((Search.Name), 'CASE') or ContainsText((Search.Name), 'BOX') or ContainsText((Search.Name), 'TRAY') or ContainsText((Search.Name), 'FOLDER') or ContainsText((Search.Name), 'COVER') or ContainsText((Search.Name), 'ALBUM') then
                      begin
                        ImageFiles.Add(ExtractFileDir(FileName) + '\' + Search.Name);
                      end;
                    end;

                  until (FindNext(Search) <> 0) and (not AddingStopped);
                  FindClose(Search);
                end;

                // if some files found
                if ImageFiles.Count > 0 then
                begin
                  ImageFile := ImageFiles[0];
                end
                else
                begin
                  ImageFile := '';
                end;
              end;
            end;
          1:
            begin
              // try external artwork first
              if (FindFirst(ExtractFileDir(FileName) + '\*.*', faAnyFile, Search) = 0) then
              begin
                repeat
                  Application.ProcessMessages;
                  Extension := LowerCase(ExtractFileExt(Search.Name));

                  if (Extension = '.png') or (Extension = '.jpeg') or (Extension = '.jpg') or (Extension = '.gif') or (Extension = '.bmp') then
                  begin
                    if ContainsText(Search.Name, 'FRONT') or ContainsText((Search.Name), 'BACK') or ContainsText((Search.Name), 'DISC') or ContainsText((Search.Name), 'CD') or ContainsText((Search.Name), 'INLAY') or ContainsText((Search.Name), 'CASE') or ContainsText((Search.Name), 'BOX') or ContainsText((Search.Name), 'TRAY') or ContainsText((Search.Name), 'FOLDER') or ContainsText((Search.Name), 'COVER') or ContainsText((Search.Name), 'ALBUM') then
                    begin
                      ImageFiles.Add(ExtractFileDir(FileName) + '\' + Search.Name);
                    end;
                  end;

                until (FindNext(Search) <> 0) and (not AddingStopped);
                FindClose(Search);
              end;

              // if some files found
              if ImageFiles.Count > 0 then
              begin
                ImageFile := ImageFiles[0];
              end
              else
              begin
                // if no external found
                // try internal
                if (TagsList[FileIndex].CoverImageType <> 'fff') and (Length(TagsList[FileIndex].CoverImageType) > 0) then
                begin
                  // extract embedded artwork
                  ImageFile := ExcludeTrailingPathDelimiter(SettingsForm.TempEdit.Text) + '\' + FloatToStr(FileIndex) + '.' + TagsList[FileIndex].CoverImageType;
                  ArtworkExtractor := TArtworkExtractor.Create(FileName, ChangeFileExt(ImageFile, ''), FArtworkExtractorPath);
                  try
                    ArtworkExtractor.Start;
                    while ArtworkExtractor.AEStatus = aeReading do
                    begin
                      Application.ProcessMessages;
                      Sleep(10);
                    end;
                  finally
                    ArtworkExtractor.Free;
                  end;

                  if not FileExists(ImageFile) then
                  begin
                    ImageFile := '';
                  end;

                end
                else
                begin
                  ImageFile := '';
                end;
              end;

            end;
        end;

        // if image file exists, either extracted or external.
        // create command line
        if FileExists(ImageFile) then
        begin
          Result := ImageFile;
          if FAudioEncoderType = etLAME then
          begin
            if (not CodecSettingsForm.LameUseTTaggerBtn.Checked) then
            begin
              Result := ' --ti "' + ImageFile + '"';
            end
            else
            begin
              Result := ImageFile;
            end;
          end
          else if (FAudioEncoderType = etFLAC) then
          begin
            if not CodecSettingsForm.FLACUseTTaggerBtn.Checked then
            begin
              Result := ' --picture="' + ImageFile + '"';
            end
            else
            begin
              Result := ImageFile;
            end
          end
          else if (FAudioEncoderType = etFLACCL) then
          begin
            if (not CodecSettingsForm.FLACCLUseTTaggerBtn.Checked) then
            begin
              Result := ' --picture="' + ImageFile + '"';
              DebugMsg('art 5');
            end
            else
            begin
              Result := ImageFile;
            end;
          end
          else if (FAudioEncoderType = etOpus) then
          begin
            if (not CodecSettingsForm.OpusUseTTaggerBtn.Checked) then
            begin
              Result := ' --picture "' + ImageFile + '" ';
            end
            else
            begin
              Result := ImageFile;
            end;
          end;
        end;
      finally
        FreeAndNil(ImageFiles);
      end;
    end;
  end;
end;

function TMainForm.CreateBitDepthCMD(const FileName: string): string;
var
  MediaInfoHandle: Cardinal;
  BitDepth: string;
begin

  Result := ' ';

  if (FileExists(FileName)) then
  begin

    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();

    if MediaInfoHandle <> 0 then
    begin

      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
        MediaInfo_Option(0, 'Complete', '1');

        BitDepth := Trim(MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'BitDepth', Info_Text, Info_Name));

        if Length(BitDepth) < 1 then
        begin
          Result := ' ';
        end
        else
        begin
          if BitDepth = '8' then
          begin
            Result := ' ';
          end
          else if BitDepth = '16' then
          begin
            Result := '-acodec pcm_s16le';
          end
          else if BitDepth = '24' then
          begin
            Result := '-acodec pcm_s24le';
          end
          else if BitDepth = '32' then
          begin
            Result := '-acodec pcm_s32le';
          end;

        end;

      finally
        MediaInfo_Close(MediaInfoHandle);
      end;

    end;
  end;

end;

procedure TMainForm.CreateLogBtnClick(Sender: TObject);
begin
  with LogForm do
  begin
    OutputList.Lines.Clear;
    if FileExists(MainForm.AppDataFolder + LogFolder + '\log_main.txt') then
    begin
      OutputList.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_main.txt');
    end;
    EncoderOutput.Lines.Clear;
    if FileExists(MainForm.AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt') then
    begin
      EncoderOutput.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt');
    end;
    DeletedLog.Lines.Clear;
    if FileExists(MainForm.AppDataFolder + LogFolder + '\log_deleted.txt') then
    begin
      DeletedLog.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_deleted.txt');
    end;
    CommandLinesList.Lines.Clear;
    if FileExists(MainForm.AppDataFolder + LogFolder + '\log_cmd.txt') then
    begin
      CommandLinesList.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_cmd.txt');
    end;
    CompressionLog.Lines.Clear;
    if FileExists(MainForm.AppDataFolder + LogFolder + '\log_comp.txt') then
    begin
      CompressionLog.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_comp.txt');
    end;
    MergeLog.Lines.Clear;
    if FileExists(MainForm.AppDataFolder + LogFolder + '\log_merge.txt') then
    begin
      MergeLog.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_merge.txt');
    end;
  end;
  LogForm.CreateLogBtnClick(Self);
end;

procedure TMainForm.CreateMergeCMD(const FileName: string);
var
  // OutAudioFile: string;
  AudioStr: string;
  // i, j: Integer;
  FileIndex: integer;
  Encoder: TEncoder;
  // CopyExt: string;
  FileDuration: string;
  OutputExt: string;
  FileToDeleteStr: string;
  LOutputFilePath: string;
  LTempAudioFile: string;
begin
  Encoder := FMergeProcess;

{$REGION 'OutputExt'}
  // dest audio extension
  case FAudioEncoderType of
    etFFMpegAAC:
      begin
        if (SettingsForm.AACExtList.ItemIndex = 0) and (SettingsForm.AACExtList.ItemIndex = 3) then
        begin
          OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
        end
        else
        begin
          OutputExt := '.m4a';
        end;
      end;
    etFDKAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etFFMpegAC3:
      begin
        OutputExt := '.ac3';
      end;
    etOgg:
      begin
        OutputExt := '.ogg';
      end;
    etLAME:
      begin
        OutputExt := '.mp3';
        ;
      end;
    etWAV:
      begin
        OutputExt := '.wav';
      end;
    etFLAC:
      begin
        OutputExt := '.flac';
      end;
    etQAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etOpus:
      begin
        OutputExt := '.opus';
      end;
    etMPC:
      begin
        OutputExt := '.mpc';
      end;
    etAPE:
      begin
        OutputExt := '.ape';
      end;
    etTTA:
      begin
        OutputExt := '.tta';
      end;
    etTAK:
      begin
        OutputExt := '.tak';
      end;
    etFHGAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etNeroAAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etWMA:
      begin
        OutputExt := '.wma';
      end;
    etWavPack:
      begin
        OutputExt := '.wv';
      end;
    etFFmpegALAC:
      begin
        OutputExt := '.' + LowerCase(SettingsForm.AACExtList.Text);
      end;
    etAIFF:
      begin
        OutputExt := '.aiff';
      end;
    etFLACCL:
      begin
        OutputExt := '.flac';
      end;
    etDCA:
      begin
        OutputExt := '.dts';
      end;
  end;

{$ENDREGION}
{$REGION 'OutputFolder'}
  // generate output file path
  LOutputFilePath := ChangeFileExt(FileName, OutputExt);

  // if file already exists and skipping is selected
  if FileExists(LOutputFilePath) and (SettingsForm.OverWriteList.ItemIndex = 1) then
  begin
    AddToLog(0, LOutputFilePath + ' already exists, so it is skipped.');
    Exit;
  end;

  // overwrite settings
  if SettingsForm.OverWriteList.ItemIndex = 0 then
  begin
    FileIndex := 0;
    // add index
    if FileExists(LOutputFilePath) then
    begin
      while FileExists(LOutputFilePath) do
      begin
        Inc(FileIndex);
        LOutputFilePath := ChangeFileExt(LOutputFilePath, '_' + FloatToStr(FileIndex) + OutputExt);
      end;
    end;
  end
  else
  begin
    // ignore and overwrite
    if FileExists(LOutputFilePath) then
    begin
      AddToLog(0, LOutputFilePath + ' already exists, overwriting.');
    end;
  end;

  // create dest folder
  if not DirectoryExists(ExtractFileDir(LOutputFilePath)) then
  begin
    try
      ForceDirectories(ExtractFileDir(LOutputFilePath))
    except
      on E: Exception do
      begin
        AddToLog(0, 'Could not create folder: ' + ExtractFileDir(LOutputFilePath) + '. Exception message: ' + E.Message);
      end;
    end;
  end;
{$ENDREGION}

  // audio encoding
{$REGION 'Audio Encoding'}
  LTempAudioFile := SettingsForm.TempEdit.Text + '\merge.wav';

  // merge using the text file
  AudioStr := ' -y -f concat -i "' + SettingsForm.TempEdit.Text + '\mergelist.txt' + '" -threads 0 -c copy -loglevel panic "' + LTempAudioFile + '"';

  Encoder.CommandLines.Add(AudioStr);
  Encoder.Paths.Add(FFFMpegPath);
  Encoder.FileNames.Add(FileName);
  // Encoder.ProcessTypes.Add(etFFMpeg);
  Encoder.Durations.Add(FileDuration);
  Encoder.Infos.Add('Merging to wav, this may take a while please wait');
  Encoder.TempFiles.Add('');
  Encoder.ListItems.Add('Merging to wav');
  FileToDeleteStr := '';
  Encoder.ProcessTypes.Add(etFFMpeg);
  Encoder.FileIndexes.Add(FloatToStr(-1));

  // audio encoding
  AudioStr := '';

  case FAudioEncoderType of
    etFFMpegAAC: // ffmpeg aac
      begin

        // encoding mode
        AudioStr := AudioStr + ' -b:a ' + CodecSettingsForm.FAACBitrateEdit.Text + '000';

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FFMpegAACCMD;
        AudioStr := ' -y -i "' + LTempAudioFile + '" ' + AudioStr + ' "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etFFMpegAAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etQAAC: // qaac
      begin
        // encoding mode
        case CodecSettingsForm.QaacEncodeMethodList.ItemIndex of
          0: // abr
            begin
              AudioStr := AudioStr + ' --abr ' + CodecSettingsForm.QaacBitrateEdit.Text;
            end;
          1: // tvbr
            begin
              AudioStr := AudioStr + ' --tvbr ' + CodecSettingsForm.QaacvQualityEdit.Text;
            end;
          2: // cvbr
            begin
              AudioStr := AudioStr + ' --cvbr ' + CodecSettingsForm.QaacBitrateEdit.Text;
            end;
          3: // cbr
            begin
              AudioStr := AudioStr + ' --cbr ' + CodecSettingsForm.QaacBitrateEdit.Text;
            end;
        end;

        // profile
        if CodecSettingsForm.QaacHEBtn.Checked then
        begin
          AudioStr := AudioStr + ' --he';
        end;

        if CodecSettingsForm.QaacNoDelayBtn.Checked then
        begin
          AudioStr := AudioStr + ' --no-delay';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.QAACCMD;
        AudioStr := AudioStr + ' --ignorelength --rate keep "' + LTempAudioFile + '" -o "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FQaacPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add('1');
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etQAAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etFFMpegAC3: // ac3
      begin
        // encoding mode
        case CodecSettingsForm.AftenEncodeList.ItemIndex of
          0: // quality
            begin
              AudioStr := AudioStr + ' -q:a ' + CodecSettingsForm.AftenQualityEdit.Text;
            end;
          1: // cbr
            begin
              AudioStr := AudioStr + ' -b:a ' + CodecSettingsForm.AftenBitrateEdit.Text + '000';
            end;
        end;

        if CodecSettingsForm.AftenDialogBtn.Checked then
        begin
          AudioStr := AudioStr + ' -dialnorm ' + CodecSettingsForm.AftenDialogEdit.Text;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.AC3CMD;
        AudioStr := ' -y -i "' + LTempAudioFile + '" ' + AudioStr + ' -acodec ac3 "' + LTempAudioFile + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etFFMpegAC3);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etOgg: // oggenc
      begin
        // encoding mode
        case CodecSettingsForm.OggencodeList.ItemIndex of
          0: // quality
            begin
              AudioStr := AudioStr + ' -q ' + CodecSettingsForm.OggQualityEdit.Text;
            end;
          1: // bitrate
            begin
              AudioStr := AudioStr + ' -b ' + CodecSettingsForm.OggBitrateEdit.Text;

              // managed bitrate mode
              if CodecSettingsForm.OggManagedBitrateBtn.Checked then
              begin
                AudioStr := AudioStr + ' --managed ';
              end
              else
              begin
                AudioStr := AudioStr + ' -m ' + CodecSettingsForm.OggMinBitrateEdit.Text + ' -M ' + CodecSettingsForm.OggMaxBitrateEdit.Text;
              end;

            end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.OggCMD + ' "' + LTempAudioFile + '" -o "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FOggEncPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etOgg);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etLAME: // lame
      begin

        case CodecSettingsForm.LameEncodeList.ItemIndex of
          0: // cbr
            begin
              AudioStr := AudioStr + ' --cbr -b ' + CodecSettingsForm.LameBitrateEdit.Text;
            end;
          1: // abr
            begin
              AudioStr := AudioStr + ' --abr ' + CodecSettingsForm.LameBitrateEdit.Text;
            end;
          2: // vbr
            begin
              AudioStr := AudioStr + ' -V ' + ReplaceStr(CodecSettingsForm.LameVBREdit.Text, ',', '.');
            end;
        end;

        AudioStr := AudioStr + ' --nohist  -q ' + CodecSettingsForm.LameQualityEdit.Text;

        // tags
        case CodecSettingsForm.LameTagList.ItemIndex of
          1:
            AudioStr := AudioStr + ' --id3v1-only ';
          2:
            AudioStr := AudioStr + ' --id3v2-only ';
        end;

        // channels
        if CodecSettingsForm.LameChannelList.ItemIndex > 0 then
        begin
          case CodecSettingsForm.LameChannelList.ItemIndex of
            1:
              AudioStr := AudioStr + ' -m s ';
            2:
              AudioStr := AudioStr + ' -m j ';
            3:
              AudioStr := AudioStr + ' -m f ';
            4:
              AudioStr := AudioStr + ' -m d ';
            5:
              AudioStr := AudioStr + ' -m m ';
            6:
              AudioStr := AudioStr + ' -m l ';
            7:
              AudioStr := AudioStr + ' -m r ';
          end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.LameCMD + '  "' + LTempAudioFile + '" -o "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FLamePath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etLAME);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etWAV: // wav
      begin

      end;
    etFLAC: // flac
      begin
        AudioStr := AudioStr + ' -' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex);

        if CodecSettingsForm.FLACEMSBtn.Checked then
        begin
          AudioStr := AudioStr + ' -e ';
        end;

        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' -f';
        end;

        if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
        begin
          if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
          begin
            AudioStr := AudioStr + ' -b 512 --keep-foreign-metadata '
          end;
        end;

        if CodecSettingsForm.FLACVerifyBtn.Checked then
        begin
          AudioStr := AudioStr + ' --verify ';
        end;

        // last cmd
        AudioStr := AudioStr + CodecSettingsForm.FLACCMD + '  "' + LTempAudioFile + '" -o "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFLACPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFLAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etFHGAAC: // FHG
      begin

        // encoding mode
        case CodecSettingsForm.FHGMethodList.ItemIndex of
          0: // cbr
            begin
              AudioStr := AudioStr + ' --cbr ' + CodecSettingsForm.FHGBitrateEdit.Text;

              // profile
              case CodecSettingsForm.FHGProfileList.ItemIndex of
                0:
                  AudioStr := AudioStr + ' --profile auto';
                1:
                  AudioStr := AudioStr + ' --profile lc';
                2:
                  AudioStr := AudioStr + ' --profile he';
                3:
                  AudioStr := AudioStr + ' --profile hev2';
              end;
            end;
          1: // vbr
            begin
              AudioStr := AudioStr + ' --vbr ' + CodecSettingsForm.FHGQualityEdit.Text;
            end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FHGAACCMD + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFHGPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFHGAAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etOpus: // opus
      begin

        // encoding mode
        case CodecSettingsForm.OpusEncodeMethodList.ItemIndex of
          0: // vbr
            begin
              AudioStr := AudioStr + ' --vbr ';
            end;
          1: // cvbr
            begin
              AudioStr := AudioStr + ' --cvbr ';
            end;
          2: // cbr
            begin
              AudioStr := AudioStr + ' --hard-cbr ';
            end;
        end;

        AudioStr := AudioStr + ' --comp ' + CodecSettingsForm.OpusCompEdit.Text;
        AudioStr := AudioStr + ' --bitrate ' + CodecSettingsForm.OpusBitrateEdit.Text;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.OpusCMD;
        AudioStr := AudioStr + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FOpusPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etOpus);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etMPC: // mpc
      begin
        AudioStr := AudioStr + ' --quality ' + CodecSettingsForm.MPCQualityEdit.Text + ' --unicode ';
        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' --overwrite '
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.MPCCMD;
        AudioStr := AudioStr + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FMPCPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etMPC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etAPE: // ape
      begin

        case CodecSettingsForm.MACLevelList.ItemIndex of
          0:
            AudioStr := AudioStr + ' -c1000';
          1:
            AudioStr := AudioStr + ' -c2000';
          2:
            AudioStr := AudioStr + ' -c3000';
          3:
            AudioStr := AudioStr + ' -c4000';
          4:
            AudioStr := AudioStr + ' -c5000';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.APECMD + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '" ' + AudioStr;

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FMACPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etAPE);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etTTA: // tta
      begin

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.TTACMD + ' -e "' + LTempAudioFile + '" -o "' + LOutputFilePath + '" ';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FTTAPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etTTA);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etTAK: // tak
      begin

        // last cmd
        AudioStr := '" " -e -p' + FloatToStr(CodecSettingsForm.TAKPresetList.ItemIndex);
        case CodecSettingsForm.TAKLevelList.ItemIndex of
          1:
            AudioStr := AudioStr + 'e ';
          2:
            AudioStr := AudioStr + 'm ';
        end;

        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' -overwrite';
        end;

        if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
        begin
          if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
          begin
            AudioStr := AudioStr + ' -fsl512 '
          end;
        end;

        if CodecSettingsForm.TAKMd5Btn.Checked then
        begin
          AudioStr := AudioStr + ' -md5 ';
        end;

        if CodecSettingsForm.TAKVerifyBtn.Checked then
        begin
          AudioStr := AudioStr + ' -v '
        end;

        AudioStr := AudioStr + ' ' + CodecSettingsForm.TAKCMD;
        AudioStr := AudioStr + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '" ';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FTAKPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etTAK);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etNeroAAC: // neroaac
      begin

        // encoding mode
        case CodecSettingsForm.NeroMethodList.ItemIndex of
          0: // quality
            begin
              AudioStr := AudioStr + ' -q ' + ReplaceStr(FloatToStr(CodecSettingsForm.NeroQualityBar.Position / 100), ',', '.');
            end;
          1: // abr
            begin
              AudioStr := AudioStr + ' -br ' + CodecSettingsForm.NeroBitrateEdit.Text + '000';
            end;
          2: // cbr
            begin
              AudioStr := AudioStr + ' -cbr ' + CodecSettingsForm.NeroBitrateEdit.Text + '000';
            end;
        end;

        // profile
        case CodecSettingsForm.NeroProfileList.ItemIndex of
          1:
            AudioStr := AudioStr + ' -lc';
          2:
            AudioStr := AudioStr + ' -he';
          3:
            AudioStr := AudioStr + ' -hev2';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.NeroAACCMD + ' -if "' + LTempAudioFile + '" -of "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FNeroEncPath);
        Encoder.FileNames.Add(FileName);
        Encoder.Durations.Add(FileDuration);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etNeroAAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etFFmpegALAC: // alac
      begin
        // last cmd
        AudioStr := ' -y -i "' + LTempAudioFile + '" -c:a alac -vn "' + LOutputFilePath + '" ' + CodecSettingsForm.ALACCMD;

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFFMpegPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFFmpegALAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etWMA: // wmaencoder
      begin
        case CodecSettingsForm.WMAMethodList.ItemIndex of
          0:
            begin
              AudioStr := AudioStr + ' --quality ' + CodecSettingsForm.WMAQualityList.Text;
            end;
          1:
            begin
              AudioStr := AudioStr + ' --bitrate ' + CodecSettingsForm.WMABitrateEdit.Text
            end;
        end;

        case CodecSettingsForm.WMACodecList.ItemIndex of
          0:
            AudioStr := AudioStr + ' --codec std ';
          1:
            AudioStr := AudioStr + ' --codec pro ';
          2:
            AudioStr := AudioStr + ' --codec lsl ';
          3:
            AudioStr := AudioStr + ' --codec voice ';
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.WMACMD;
        AudioStr := AudioStr + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FWmaEncodePath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etWMA);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etWavPack: // wavpack
      begin
        case CodecSettingsForm.WavPackMethodList.ItemIndex of
          0:
            begin
              AudioStr := AudioStr + ' ';
            end;
          1:
            begin
              AudioStr := AudioStr + ' -b' + CodecSettingsForm.WavPackBitrateEdit.Text;

              if CodecSettingsForm.WavPackCorrectionBtn.Checked then
              begin
                AudioStr := AudioStr + ' -c '
              end;
            end;
        end;

        AudioStr := AudioStr + ' -h ';
        if CodecSettingsForm.WavPackExtraBtn.Checked then
        begin
          AudioStr := AudioStr + ' -x '
        end;
        if SettingsForm.OverWriteList.ItemIndex = 2 then
        begin
          AudioStr := AudioStr + ' -y ';
        end;

        // for lossywav
        if CodecSettingsForm.LossyWAVQualityList.ItemIndex > 0 then
        begin
          if CodecSettingsForm.LossyWAVEncoderOptBtn.Checked then
          begin
            AudioStr := AudioStr + ' --blocksize=512 --merge-blocks '
          end;
        end;

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.WavPackCMD;
        AudioStr := AudioStr + ' "' + LTempAudioFile + '" "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FWavPackPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etWavPack);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etFDKAAC: // fdk-aac
      begin
        // bitrate
        if CodecSettingsForm.FDKMethodList.ItemIndex = 0 then
        begin
          AudioStr := AudioStr + ' -m 0 -b ' + CodecSettingsForm.FDKBitrateEdit.Text;
        end
        else
        begin
          AudioStr := AudioStr + ' -m ' + FloatToStr(CodecSettingsForm.FDKVBRBar.Position)
        end;

        // profile
        case CodecSettingsForm.FDKProfileList.ItemIndex of
          0:
            AudioStr := AudioStr + ' -p 2';
          1:
            AudioStr := AudioStr + ' -p 5';
          2:
            AudioStr := AudioStr + ' -p 29';
          3:
            AudioStr := AudioStr + ' -p 23';
          4:
            AudioStr := AudioStr + ' -p 39';
          5:
            AudioStr := AudioStr + ' -p 129';
          6:
            AudioStr := AudioStr + ' -p 132';
          7:
            AudioStr := AudioStr + ' -p 156';
        end;

        // gapless
        AudioStr := AudioStr + ' -G ' + FloatToStr(CodecSettingsForm.FDKGaplessList.ItemIndex) + ' --moov-before-mdat ';

        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FDKAACCMD + ' "' + LTempAudioFile + '" -o "' + LOutputFilePath + '"';

        Encoder.CommandLines.Add(AudioStr);
        Encoder.Paths.Add(FFdkAACPath);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Infos.Add('Encoding');
        Encoder.Durations.Add('1');
        Encoder.ProcessTypes.Add(etFDKAAC);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etAIFF: // aiff
      begin
        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.AIFFCMD;
        AudioStr := ' -y -i "' + FileName + '" -f aiff ' + ' "' + LOutputFilePath + '" ' + AudioStr;

        Encoder.Paths.Add(FFFMpegPath);
        Encoder.CommandLines.Add(AudioStr);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etAIFF);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etFLACCL: // flaccl
      begin
        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.FLACCLCMD;
        AudioStr := ' -' + CodecSettingsForm.FLACCLLevelList.Text + ' "' + LTempAudioFile + '" -o "' + LOutputFilePath + '"';

        Encoder.Paths.Add(FFLACCLPath);
        Encoder.CommandLines.Add(AudioStr);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etFLACCL);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
    etDCA: // dca
      begin
        // last cmd
        AudioStr := AudioStr + ' ' + CodecSettingsForm.DcaencCMD;
        AudioStr := ' -i "' + LTempAudioFile + '" -o "' + LTempAudioFile + '" -b ' + CodecSettingsForm.DCABitrateEdit.Text;

        Encoder.Paths.Add(FDCAENCPath);
        Encoder.CommandLines.Add(AudioStr);
        Encoder.FileNames.Add(FileName);
        Encoder.TempFiles.Add(FileToDeleteStr);
        Encoder.Durations.Add(FileDuration);
        Encoder.Infos.Add('Encoding');
        Encoder.ProcessTypes.Add(etDCA);
        Encoder.FileIndexes.Add('-1');
        Encoder.ListItems.Add('Merging');
      end;
  end;
{$ENDREGION}
  if MergeTagForm.UseValuesBtn.Checked then
  begin
    // write tag
    if FileExists(FTTaggerPath) and SettingsForm.TagsBtn.Checked then
    begin
      // write merge tags to a file
      CreateMergeTagTextFile;
      AudioStr := '';
      AudioStr := '" " "' + SettingsForm.TempEdit.Text + '\mergetag.txt" "' + LOutputFilePath + '"';

      Encoder.CommandLines.Add(AudioStr);
      Encoder.Paths.Add(FTTaggerPath);
      Encoder.FileNames.Add(FileName);
      Encoder.TempFiles.Add('');
      Encoder.Durations.Add('1');
      Encoder.Infos.Add('Writing Tags');
      Encoder.ProcessTypes.Add(etTTagger);
      Encoder.FileIndexes.Add('-1');
      Encoder.ListItems.Add('Merging');
    end;
  end;

  FilesToCheck.Add(LOutputFilePath);
end;

procedure TMainForm.CreateMergeTagTextFile;
var
  FTagIniFile: TMemIniFile;
begin
  FTagIniFile := TMemIniFile.Create(SettingsForm.TempEdit.Text + '\mergetag.txt', TEncoding.UTF8);
  try
    with FTagIniFile do
    begin
      case FAudioEncoderType of
        etFDKAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
          end;
        etFFMpegAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
          end;
        etFHGAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
          end;
        etNeroAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
          end;
        etQAAC:
          begin
            WriteString('taginfo', 'type', 'mp4');
          end;
        etLAME:
          begin
            WriteString('taginfo', 'type', 'id3v2');
          end;
        etMPC:
          begin
            WriteString('taginfo', 'type', 'apev2');
          end;
        etOgg:
          begin
            WriteString('taginfo', 'type', 'ogg');
          end;
        etOpus:
          begin
            WriteString('taginfo', 'type', 'ogg');
            ;
          end;
        etWMA:
          begin
            WriteString('taginfo', 'type', 'wma');
          end;
        etFFmpegALAC:
          begin
            WriteString('taginfo', 'type', 'alac');
          end;
        etFLAC..etFLACCL:
          begin
            WriteString('taginfo', 'type', 'flac');
          end;
        etAPE:
          begin
            WriteString('taginfo', 'type', 'apev2');
          end;
        etTAK:
          begin
            WriteString('taginfo', 'type', 'apev2');
          end;
        etTTA:
          begin
            WriteString('taginfo', 'type', 'apev2');
          end;
        etWavPack:
          begin
            WriteString('taginfo', 'type', 'apev2');
          end;
      end;

      // write tags if it is enabled
      if SettingsForm.TagsBtn.Checked then
      begin
        WriteString('tag', 'Title', MergeTagForm.TitleEdit.Text);
        WriteString('tag', 'Artist', MergeTagForm.ArtistEdit.Text);
        WriteString('tag', 'Album', MergeTagForm.AlbumEdit.Text);
        WriteString('tag', 'Genre', MergeTagForm.GenreEdit.Text);
        WriteString('tag', 'Date', MergeTagForm.DateEdit.Text);
        // write tool tag
        WriteBool('tag', 'writetag', SettingsForm.ToolTagBtn.Checked);
{$REGION 'ToolTagWrite'}
        if SettingsForm.ToolTagBtn.Checked then
        begin
          case FAudioEncoderType of
            etFDKAAC:
              WriteString('tag', 'tool', 'FDKAAC');
            etFFMpegAAC:
              WriteString('tag', 'tool', 'FFMpeg');
            etFHGAAC:
              WriteString('tag', 'tool', 'FHGAAC');
            etNeroAAC:
              WriteString('tag', 'tool', 'NeroAAC');
            etQAAC:
              WriteString('tag', 'tool', 'QAAC');
            etFFMpegAC3:
              WriteString('tag', 'tool', 'FFMpeg');
            etLAME:
              WriteString('tag', 'tool', 'Lame');
            etMPC:
              WriteString('tag', 'tool', 'MPC');
            etOgg:
              WriteString('tag', 'tool', 'OggEnc2');
            etOpus:
              WriteString('tag', 'tool', 'OpusEnc');
            etWMA:
              WriteString('tag', 'tool', 'WMAEncode');
            etFFmpegALAC:
              WriteString('tag', 'tool', 'RefALAC');
            etFLAC:
              WriteString('tag', 'tool', 'FLAC');
            etFLACCL:
              WriteString('tag', 'tool', 'FLACCL');
            etAPE:
              WriteString('tag', 'tool', 'MAC');
            etTAK:
              WriteString('tag', 'tool', 'TAKc');
            etTTA:
              WriteString('tag', 'tool', 'TTAenc');
            etWavPack:
              WriteString('tag', 'tool', 'WavPack');
            etAIFF:
              WriteString('tag', 'tool', 'FFMpeg');
            etWAV:
              WriteString('tag', 'tool', 'FFMpeg');
            etDCA:
              WriteString('tag', 'tool', 'dcaenc');
          end;
        end;
{$ENDREGION}
      end;
      // if artwork is enabled
      if SettingsForm.ArtworkBtn.Checked then
      begin
        // embedding artwork is selected
        if SettingsForm.ArtworkList.ItemIndex = 1 then
        begin
          // external artwork
          WriteString('tag', 'Cover', MergeTagForm.ArtworkPathEdit.Text);
        end
        else
        begin
          WriteString('tag', 'Cover', '');
        end;
      end
      else
      begin
        WriteString('tag', 'Cover', '');
      end;
      UpdateFile;
    end;
  finally
    FTagIniFile.Free;
  end;

end;

procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WinClassName := SWindowClassName;
end;

function TMainForm.CreateTagCMD(const FileName: string; const FileIndex: integer): string;
var
  FTagIniFile: TMemIniFile;
  LArtist, LGenre, LPerformer, LAlbum, LRecordDate: string;

  procedure WriteTagsToIni(const AudioEncoder: TEncoderType; const FileName: string; const FileIndex: integer);
  begin
    with TagsList[FileIndex] do
    begin
      with FTagIniFile do
      begin
        // write tags if it is enabled
        if SettingsForm.TagsBtn.Checked then
        begin
          WriteString('tag', 'Title', Title);
          WriteString('tag', 'Artist', LArtist);
          WriteString('tag', 'Album', LAlbum);
          WriteString('tag', 'Genre', LGenre);
          WriteString('tag', 'Date', LRecordDate);
          WriteString('tag', 'TrackNo', TrackNo);
          WriteString('tag', 'TrackTotal', TrackTotal);
          // write tool tag
          WriteBool('tag', 'writetag', SettingsForm.ToolTagBtn.Checked);
{$REGION 'ToolTagWrite'}
          if SettingsForm.ToolTagBtn.Checked then
          begin
            case AudioEncoder of
              etFDKAAC:
                WriteString('tag', 'tool', 'FDKAAC');
              etFFMpegAAC:
                WriteString('tag', 'tool', 'FFMpeg');
              etFHGAAC:
                WriteString('tag', 'tool', 'FHGAAC');
              etNeroAAC:
                WriteString('tag', 'tool', 'NeroAAC');
              etQAAC:
                WriteString('tag', 'tool', 'QAAC');
              etFFMpegAC3:
                WriteString('tag', 'tool', 'FFMpeg');
              etLAME:
                WriteString('tag', 'tool', 'Lame');
              etMPC:
                WriteString('tag', 'tool', 'MPC');
              etOgg:
                WriteString('tag', 'tool', 'OggEnc2');
              etOpus:
                WriteString('tag', 'tool', 'OpusEnc');
              etWMA:
                WriteString('tag', 'tool', 'WMAEncode');
              etFFmpegALAC:
                WriteString('tag', 'tool', 'FFMpeg');
              etFLAC:
                WriteString('tag', 'tool', 'FLAC');
              etFLACCL:
                WriteString('tag', 'tool', 'FLACCL');
              etAPE:
                WriteString('tag', 'tool', 'MAC');
              etTAK:
                WriteString('tag', 'tool', 'TAKc');
              etTTA:
                WriteString('tag', 'tool', 'TTAenc');
              etWavPack:
                WriteString('tag', 'tool', 'WavPack');
              etAIFF:
                WriteString('tag', 'tool', 'FFMpeg');
              etWAV:
                WriteString('tag', 'tool', 'FFMpeg');
              etDCA:
                WriteString('tag', 'tool', 'dcaenc');
            end;
          end;
{$ENDREGION}
          if AudioEncoder = etOgg then
          begin
            if (Length(DiscNo) > 0) and (Length(DiscTotal) > 0) then
            begin
              WriteString('tag', 'DiscNo', DiscNo + '/' + DiscTotal);
            end;
          end
          else
          begin
            WriteString('tag', 'DiscNo', DiscNo);
            WriteString('tag', 'DiscTotal', DiscTotal);
          end;
          WriteString('tag', 'Comment', Comment);
          WriteString('tag', 'AlbumArtist', AlbumArtist);
          WriteString('tag', 'Composer', Composer);
          WriteString('tag', 'NameSort', NameSort);
          WriteString('tag', 'ArtistSort', ArtistSort);
          WriteString('tag', 'AlbumArtistSort', AlbumArtistSort);
          WriteString('tag', 'AlbumSort', AlbumSort);
          // copy rg tag lossless to lossless.
          if TagsList[FileIndex].IsLossless and SettingsForm.RGLToLBtn.Checked then
          begin
            WriteString('tag', 'REPLAYGAIN_ALBUM_GAIN', TagsList[FileIndex].RGInfo.ALBUM_GAIN);
            WriteString('tag', 'REPLAYGAIN_ALBUM_PEAK', TagsList[FileIndex].RGInfo.ALBUM_PEAK);
            WriteString('tag', 'REPLAYGAIN_TRACK_GAIN', TagsList[FileIndex].RGInfo.TRACK_GAIN);
            WriteString('tag', 'REPLAYGAIN_TRACK_PEAK', TagsList[FileIndex].RGInfo.TRACK_PEAK);
          end
          else
          begin
            WriteString('tag', 'REPLAYGAIN_ALBUM_GAIN', '');
            WriteString('tag', 'REPLAYGAIN_ALBUM_PEAK', '');
            WriteString('tag', 'REPLAYGAIN_TRACK_GAIN', '');
            WriteString('tag', 'REPLAYGAIN_TRACK_PEAK', '');
          end;
        end;
        // if artwork is enabled
        if SettingsForm.ArtworkBtn.Checked then
        begin
          // embedding artwork is selected
          if SettingsForm.ArtworkList.ItemIndex = 1 then
          begin
            // external artwork
            WriteString('tag', 'Cover', CreateArtworkCMD(Files[FileIndex], FileIndex));
          end
          else
          begin
            WriteString('tag', 'Cover', '');
          end;
        end
        else
        begin
          WriteString('tag', 'Cover', '');
        end;
        UpdateFile;
      end;
    end;
  end;

begin

  Result := ' ';

  with TagsList[FileIndex] do
  begin
    try
      // use entered values instead of copied ones
      if TagForm.UseValuesBtn.Checked then
      begin
        with TagForm do
        begin
          if Length(ArtistEdit.Text) > 0 then
          begin
            LArtist := ArtistEdit.Text;
          end
          else
          begin
            LArtist := Artist;
          end;
          if Length(GenreEdit.Text) > 0 then
          begin
            LGenre := GenreEdit.Text;
          end
          else
          begin
            LGenre := Genre;
          end;
          if Length(PerformerEdit.Text) > 0 then
          begin
            LPerformer := PerformerEdit.Text;
          end
          else
          begin
            LPerformer := Performer;
          end;
          if Length(AlbumEdit.Text) > 0 then
          begin
            LAlbum := AlbumEdit.Text;
          end
          else
          begin
            LAlbum := Album;
          end;
          if Length(DateEdit.Text) > 0 then
          begin
            LRecordDate := DateEdit.Text;
          end
          else
          begin
            LRecordDate := RecordDate;
          end;
        end;
      end
      else
      begin
        LArtist := Artist;
        LGenre := Genre;
        LPerformer := Performer;
        LAlbum := Album;
        LRecordDate := RecordDate;
      end;

      FTagIniFile := TMemIniFile.Create(SettingsForm.TempEdit.Text + '\' + FloatToStr(FileIndex) + 'tag.txt', TEncoding.UTF8);
      try
        with FTagIniFile do
        begin
          // write tag type.
          // also for some codecs, just create tag command line.
          case FAudioEncoderType of
            etFDKAAC:
              begin
                WriteString('taginfo', 'type', 'mp4');
                WriteTagsToIni(etFDKAAC, FileName, FileIndex);
              end;
            etFFMpegAAC:
              begin
                WriteString('taginfo', 'type', 'mp4');
                WriteTagsToIni(etFFMpegAAC, FileName, FileIndex);
              end;
            etFHGAAC:
              begin
                WriteString('taginfo', 'type', 'mp4');
                WriteTagsToIni(etFHGAAC, FileName, FileIndex);
              end;
            etNeroAAC:
              begin
                WriteString('taginfo', 'type', 'mp4');
                WriteTagsToIni(etNeroAAC, FileName, FileIndex);
              end;
            etQAAC:
              begin
                WriteString('taginfo', 'type', 'mp4');
                WriteTagsToIni(etQAAC, FileName, FileIndex);
              end;
            etLAME:
              begin
                WriteString('taginfo', 'type', 'id3v2');
                if CodecSettingsForm.LameUseTTaggerBtn.Checked then
                begin
                  WriteTagsToIni(etLAME, FileName, FileIndex);
                end
                else
                begin
                  Result := ' --id3v2-ucs2 --ta "' + LArtist + '" --tt "' + Title + '" --tg "' + LGenre + '" --tl "' + LAlbum + '" --ty "' + LRecordDate + '" --tn "' + TrackNo + '" --tc "' + Comment + '"';
                end;
              end;
            etMPC:
              begin
                Result := ' --ape2 --artist "' + LArtist + '" --title "' + Title + '" --album "' + LAlbum + '" --year "' + LRecordDate + '" --track "' + TrackNo + '" --genre "' + LGenre + '" --comment "' + Comment + '"'
              end;
            etOgg:
              begin
                WriteString('taginfo', 'type', 'ogg');
                if CodecSettingsForm.OggUseTTaggerBtn.Checked then
                begin
                  WriteTagsToIni(etOgg, FileName, FileIndex);
                end
                else
                begin
                  Result := ' -a "' + LArtist + '" -t "' + Title + '" -l "' + LAlbum + '" --genre "' + LGenre + '" -d "' + LRecordDate + '" -N "' + TrackNo + '" -c "comment=' + Comment + '"';
                end;
              end;
            etOpus:
              begin
                WriteString('taginfo', 'type', 'ogg');
                if CodecSettingsForm.OpusUseTTaggerBtn.Checked then
                begin
                  WriteTagsToIni(etOgg, FileName, FileIndex); // same thing
                end
                else
                begin
                  Result := ' --artist "' + LArtist + '" --title "' + Title + '" --comment "genre=' + LGenre + '" --comment "composer=' + Composer + '" --comment "album=' + LAlbum + '" --comment "date=' + LRecordDate + '" --comment "TRACKNUMBER=' + TrackNo + '" --comment "comment=' + Comment + '"';
                end;
              end;
            etWMA:
              begin
                WriteString('taginfo', 'type', 'wma');
                WriteTagsToIni(etWMA, FileName, FileIndex);
              end;
            etFFmpegALAC:
              begin
                WriteString('taginfo', 'type', 'alac');
                WriteTagsToIni(etFFmpegALAC, FileName, FileIndex);
              end;
            etFLAC..etFLACCL:
              begin
                WriteString('taginfo', 'type', 'flac');
                if CodecSettingsForm.FLACUseTTaggerBtn.Checked then
                begin
                  WriteTagsToIni(etFLAC, FileName, FileIndex);
                end
                else
                begin
                  Result := ' --tag=artist="' + Artist + '" --tag=title="' + Title + '" --tag=genre="' + Genre + '" --tag=composer="' + Composer + '" --tag=album="' + Album + '" --tag=date="' + RecordDate + '" --tag=TRACKNUMBER="' + TrackNo + '" --tag=comment="' + Comment + '" ';
                  if Length(ArtistSort) > 1 then
                  begin
                    Result := Result + ' --tag=ALBUMARTIST="' + ArtistSort + '"';
                  end;
                  if Length(ComposerSort) > 1 then
                  begin
                    Result := Result + ' --tag=COMPOSER="' + ComposerSort + '"';
                  end;
                  if TagsList[FileIndex].IsLossless and SettingsForm.RGLToLBtn.Checked then
                  begin
                    Result := Result + ' --tag=REPLAYGAIN_ALBUM_GAIN="' + TagsList[FileIndex].RGInfo.ALBUM_GAIN + '" --tag=REPLAYGAIN_ALBUM_PEAK="' + TagsList[FileIndex].RGInfo.ALBUM_PEAK + '" --tag=REPLAYGAIN_TRACK_GAIN="' + TagsList[FileIndex].RGInfo.TRACK_GAIN + '" --tag=REPLAYGAIN_TRACK_PEAK="' + TagsList[FileIndex].RGInfo.TRACK_PEAK + '" ';
                  end;
                end;
              end;
            etAPE:
              begin
                WriteString('taginfo', 'type', 'apev2');
                WriteTagsToIni(etAPE, FileName, FileIndex);
              end;
            etTAK:
              begin
                WriteString('taginfo', 'type', 'apev2');
                WriteTagsToIni(etTAK, FileName, FileIndex);
              end;
            etTTA:
              begin
                WriteString('taginfo', 'type', 'apev2');
                WriteTagsToIni(etTTA, FileName, FileIndex);
              end;
            etWavPack:
              begin
                WriteString('taginfo', 'type', 'apev2');
                WriteTagsToIni(etWavPack, FileName, FileIndex);
              end;
            etWAV:
              begin
                WriteString('taginfo', 'type', 'wav');
                WriteTagsToIni(etWAV, FileName, FileIndex);
              end;
          end;
        end;

      finally
        FTagIniFile.Free;
      end;

    finally
      // some FEncoders might be selected to write their own cover art and tags
      if ((FAudioEncoderType = etLAME) and (not CodecSettingsForm.LameUseTTaggerBtn.Checked)) or ((FAudioEncoderType = etFLAC) and (not CodecSettingsForm.FLACUseTTaggerBtn.Checked)) or ((FAudioEncoderType = etFLACCL) and (not CodecSettingsForm.FLACCLUseTTaggerBtn.Checked)) or ((FAudioEncoderType = etOpus) and (not CodecSettingsForm.OpusUseTTaggerBtn.Checked)) then
      begin
        Result := Result + CreateArtworkCMD(FileName, FileIndex);
      end;
    end;
  end;
end;

function TMainForm.CreateTempFileName: string;
var
  LGUID: TGUID;
begin
  CreateGUID(LGUID);
  Result := GUIDToString(LGUID);
end;

procedure TMainForm.DateEditChange(Sender: TObject);
var
  LT: TTrackInfo;
  I: Integer;
begin
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if TracksList.Items[I].Selected then
    begin
      LT := FTrackInfoList[I];
      LT.TrackTagInfo.Date := DateEdit.Text;
      FTrackInfoList[I] := LT;
    end;
  end;
end;

function TMainForm.dcaencPercentage(const dcaencOutput: string): integer;
var
  LPos1, LPos2: integer;
  LStr: string;
begin
  Result := 0;

  if Length(dcaencOutput) > 0 then
  begin
    LPos1 := Pos('[', dcaencOutput);
    LPos2 := Pos(']', dcaencOutput);
    if LPos2 > LPos1 then
    begin
      LStr := Trim(Copy(dcaencOutput, LPos1 + 1, LPos2 - LPos1 - 4));
      if IsStringNumeric(LStr) then
      begin
        Result := StrToInt(LStr);
        DebugMsg(LStr);
      end
      else
        DebugMsg('dcaenc output not numeric');
    end
    else
      DebugMsg('dcaenc output index');
  end
  else
    DebugMsg('dcaenc output is too short');

end;

procedure TMainForm.DebugMsg(const Str: string);
begin
  OutputDebugString(PChar('[TAudioConverter]: ' + Str));
end;

function TMainForm.DecideNumOfProcesses: integer;
begin
  Result := SystemInfo.CPU.ProcessorCount;
end;

procedure TMainForm.DeleteLogs;
var
  LogFolder: string;
  i: Integer;
begin

  if Portable then
  begin
    LogFolder := '\logs'
  end
  else
  begin
    LogFolder := '';
  end;

  if FileExists(AppDataFolder + LogFolder + '\log_main.txt') then
  begin
    DeleteFile(AppDataFolder + LogFolder + '\log_main.txt')
  end;

  for i := 1 to 16 do
  begin
    if FileExists(AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(i) + '.txt') then
    begin
      DeleteFile(AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(i) + '.txt')
    end;
  end;

  if FileExists(AppDataFolder + LogFolder + '\log_deleted.txt') then
  begin
    DeleteFile(AppDataFolder + LogFolder + '\log_deleted.txt')
  end;

  if FileExists(AppDataFolder + LogFolder + '\log_cmd.txt') then
  begin
    DeleteFile(AppDataFolder + LogFolder + '\log_cmd.txt')
  end;

  if FileExists(AppDataFolder + LogFolder + '\log_comp.txt') then
  begin
    DeleteFile(AppDataFolder + LogFolder + '\log_comp.txt')
  end;

  if FileExists(AppDataFolder + LogFolder + '\log_merge.txt') then
  begin
    DeleteFile(AppDataFolder + LogFolder + '\log_merge.txt')
  end;

end;

procedure TMainForm.DeleteTempFiles(const DeleteCDTemp: Boolean);
var
  Search: TSearchRec;
  DeletedCount: Integer;
begin

  AddToLog(0, 'Started deleting temp files...');
  AddToLog(0, 'Temp Folder: ' + SettingsForm.TempEdit.Text);

  DeletedCount := 0;

  // clear temp folder
  if (FindFirst(SettingsForm.TempEdit.Text + '\*.*', faAnyFile, Search) = 0) then
  begin
    repeat
      Application.ProcessMessages;

      if (Search.Name = '.') or (Search.Name = '..') or (Search.Name = 'TCDRipper') then
        Continue;

      if FileExists(SettingsForm.TempEdit.Text + '\' + Search.Name) then
      begin

        if SettingsForm.TempEdit.Text <> ExtractFileDir(Application.ExeName) then
        begin
          if not DeleteFile(SettingsForm.TempEdit.Text + '\' + Search.Name) then
          begin
            AddToLog(17, 'Can''t delete: ' + SettingsForm.TempEdit.Text + '\' + Search.Name);
          end
          else
          begin
            Inc(DeletedCount);
            AddToLog(17, 'Deleted: ' + SettingsForm.TempEdit.Text + '\' + Search.Name);
          end;
        end;

      end
      else
      begin
        AddToLog(0, 'Cannot find to delete: ' + SettingsForm.TempEdit.Text + '\' + Search.Name);
      end;

    until (FindNext(Search) <> 0);
    FindClose(Search);
  end;
  // clear cdripper temp folder.
  // this code is not needed anymore but user might be coming from an older version
  // so tcripper folder might still exist.
  if DeleteCDTemp then
  begin
    if (FindFirst(SettingsForm.TempEdit.Text + '\TCDRipper\*.*', faAnyFile, Search) = 0) then
    begin
      repeat
        Application.ProcessMessages;

        if (Search.Name = '.') or (Search.Name = '..') then
          Continue;

        if FileExists(SettingsForm.TempEdit.Text + '\TCDRipper\' + Search.Name) then
        begin

          if SettingsForm.TempEdit.Text <> ExtractFileDir(Application.ExeName) then
          begin
            if not DeleteFile(SettingsForm.TempEdit.Text + '\TCDRipper\' + Search.Name) then
            begin
              AddToLog(17, 'Can''t delete: ' + SettingsForm.TempEdit.Text + '\TCDRipper\' + Search.Name);
            end
            else
            begin
              Inc(DeletedCount);
              AddToLog(17, 'Deleted: ' + SettingsForm.TempEdit.Text + '\TCDRipper\' + Search.Name);
            end;
          end;

        end;

      until (FindNext(Search) <> 0);
      FindClose(Search);
    end;
  end;

  AddToLog(0, 'Deleted ' + IntToStr(DeletedCount) + ' file(s).');
  AddToLog(0, 'Finished deleting temp files.');
  AddToLog(0, '');

end;

procedure TMainForm.DisableUI;
var
  i: integer;
begin

  StartBtn.Enabled := False;
  StopBtn.Enabled := True;
  DirectoryEdit.Enabled := False;
  SameAsSourceBtn.Enabled := False;
  ProgressPanel.Visible := True;
  ProgressPanel.BringToFront;

  DragDrop.DropTarget := nil;

  for i := 0 to MainMenu.Items.Count - 1 do
  begin
    MainMenu.Items.Items[i].Enabled := False;
  end;

  Self.Repaint;
end;

procedure TMainForm.DonationBtnClick(Sender: TObject);
begin

  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=USMWJE4WFDFX2', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.DownBtnClick(Sender: TObject);
var
  index, i: Integer;
  lv, lv2: TListItem;
  SelectedItems: TStringList;
  LII: TIndexItem;
begin

  try
    SelectedItems := TStringList.Create;

    i := FileList.Items.Count - 1;

    while i > -1 do
    begin
      Application.ProcessMessages;

      if FileList.Items.Item[i].Selected then
      begin

        index := i;
        SelectedItems.Add(FloatToStr(i + 1));

        if (index >= 0) and (index < FileList.Items.Count - 1) then
        begin

          lv2 := FileList.Items[index];
          try
            // queue list
            lv := FileList.Items.Insert(index + 2);
            lv.Assign(lv2);
            lv2.Delete;

            AudioTracks.Exchange(i, i + 1);
            AudioIndexes.Exchange(i, i + 1);
            Files.Exchange(i, i + 1);
            Durations.Exchange(i, i + 1);
            ExtensionsForCopy.Exchange(i, i + 1);
            CopyExtension.Exchange(i, i + 1);
            StartPositions.Exchange(i, i + 1);
            EndPositions.Exchange(i, i + 1);
            ConstantDurations.Exchange(i, i + 1);
            TagsList.Exchange(i, i + 1);
          finally

          end;

        end;

      end
      else
      begin
        Dec(i);
      end;

    end;

    if SelectedItems.Count > 0 then
    begin

      for i := 0 to SelectedItems.Count - 1 do
      begin
        index := StrToInt(SelectedItems.Strings[i]);

        if index < FileList.Items.Count then
        begin
          FileList.Items.Item[index].Selected := True;
          FileList.Items.Item[index].Focused := True;
        end;

      end;

    end;

  finally
    FreeAndNil(SelectedItems);

    // update remaning items' indexes
    for i := 0 to FileList.Items.Count - 1 do
    begin
      LII := FileList.Items[i].SubItems.Objects[BITRATE_COLUMN_INDEX] as TIndexItem;
      LII.RealIndex := i;
      FileList.Items[i].SubItems.Objects[BITRATE_COLUMN_INDEX] := LII;
    end;
  end;

end;

procedure TMainForm.DownloadNeroAACTools1Click(Sender: TObject);
begin
  Application.MessageBox('You must copy NeroAACEnc.exe next to TAudioConverter.exe to get it working.', 'Info', MB_ICONINFORMATION);
  ShellExecute(Application.Handle, 'open', 'http://www.nero.com/enu/company/about-nero/nero-aac-codec.php', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.DragDropDrop(Sender: TObject; Pos: TPoint; Value: TStrings);
var
  i: Integer;
  Extension: string;
  DirectoriesToSearch: TStringList;
  LprevCount: Integer;
  LNow: TDateTime;
begin

  Self.Enabled := False;
  ProgressForm.show;
  AddingStopped := False;
  DirectoriesToSearch := TStringList.Create;
  LprevCount := FileList.Items.Count;
  LNow := Now;
  try

    for i := 0 to Value.Count - 1 do
    begin
      Application.ProcessMessages;

      Extension := LowerCase(ExtractFileExt(Value[i]));

      if AddingStopped then
      begin
        Break;
      end
      else
      begin
        // decide if file or directory
        if DirectoryExists(Value[i]) then
        begin
          DirectoriesToSearch.Add(Value[i]);
        end
        else
        begin
          if (Extension = '.mp4') or (Extension = '.mov') or (Extension = '.m4v') or (Extension = '.mkv') or (Extension = '.mpeg') or (Extension = '.mpg') or (Extension = '.flv') or (Extension = '.avi') or (Extension = '.vob') or (Extension = '.avs') or (Extension = '.divx') or (Extension = '.wmv') or (Extension = '.rmvb') or (Extension = '.mp3') or (Extension = '.wav') or (Extension = '.m4a') or (Extension = '.flac') or (Extension = '.ogg') or (Extension = '.tta') or (Extension = '.mpc') or (Extension =
            '.aac') or (Extension = '.ac3') or (Extension = '.spx') or (Extension = '.opus') or (Extension = '.shn') or (Extension = '.wv') or (Extension = '.mpc') or (Extension = '.ape') or (Extension = '.wma') or (Extension = '.3gp') or (Extension = '.3ga') or (Extension = '.m2ts') or (Extension = '.thd') or (Extension = '.amr') or (Extension = '.aac') or (Extension = '.m4b') or (Extension = '.tak') or (Extension = '.dts') or (Extension = '.mts') or (Extension = '.aif') or (Extension = '.aiff') or (Extension = '.dtsma') or (Extension = '.mpa') or (Extension = '.mp2') or (Extension = '.mka') or (Extension = '.ts') or (Extension = '.3gpp') or (Extension = '.cue') then
          begin
            AddFile(Value[i]);
            ProgressForm.CurrentFileLabel.Caption := ExtractFileName(Value[i]);
            FLastDirectory := ExtractFileDir(Value[i]);
          end
          else if Extension = '.cue' then
          begin
            if not SettingsForm.IgnoreCueBtn.Checked then
            begin
              AddFile(Value[i]);
              ProgressForm.CurrentFileLabel.Caption := ExtractFileName(Value[i]);
              FLastDirectory := ExtractFileDir(Value[i]);
            end;
          end;

        end;

      end;

    end;

    FileList.Items.BeginUpdate;
    try
      // add directory content
      if DirectoriesToSearch.Count > 0 then
      begin

        for i := 0 to DirectoriesToSearch.Count - 1 do
        begin
          Application.ProcessMessages;

          FileSearch.RootDirectory := DirectoriesToSearch[i];
          FileSearch.Search;

          FLastDirectory := DirectoriesToSearch[i];
        end;

      end;
    finally
      FileList.Items.EndUpdate;
    end;

  finally
    Self.Enabled := True;
    ProgressForm.Close;
    Self.BringToFront;
    FreeAndNil(DirectoriesToSearch);
    FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
    AddToLog(0, 'Added ' + FloatToStr(FileList.Items.Count - LprevCount) + ' files to the list in ' + TimeToStr(Now - LNow));
  end;

end;

procedure TMainForm.DriversListChange(Sender: TObject);
begin
  CDIn.CurrentDrive := DriversList.ItemIndex;
  GetTracks;
end;

procedure TMainForm.E2Click(Sender: TObject);
begin
  Self.Enabled := False;
  TagForm.show;
end;

procedure TMainForm.E3Click(Sender: TObject);
var
  LItem: TListItem;
begin
  if FileList.ItemIndex > -1 then
  begin
    with TagEditorForm do
    begin
      LItem := TagList.Items.Add;
      LItem.Caption := 'Title';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Title);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Artist';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Artist);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Album';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Album);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Genre';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Genre);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Date';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].RecordDate);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Comment';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Comment);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Performer';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Performer);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Composer';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].Composer);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Track';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].TrackNo);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Total Track';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].TrackTotal);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Disc';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].DiscNo);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Total Disc';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].DiscTotal);

      LItem := TagList.Items.Add;
      LItem.Caption := 'Album Artist';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].AlbumArtist);

      LItem := TagList.Items.Add;
      LItem.Caption := 'TitleSort';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].NameSort);

      LItem := TagList.Items.Add;
      LItem.Caption := 'AlbumSort';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].AlbumSort);

      LItem := TagList.Items.Add;
      LItem.Caption := 'AlbumArtistSort';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].AlbumArtistSort);

      LItem := TagList.Items.Add;
      LItem.Caption := 'ComposerSort';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].ComposerSort);

      LItem := TagList.Items.Add;
      LItem.Caption := 'AlbumComposer';
      LItem.SubItems.Add(TagsList[FileList.ItemIndex].AlbumComposer);
    end;
    TagEditorForm.FileIndex := FileList.ItemIndex;
    Self.Enabled := False;
    TagEditorForm.show;
  end;
end;

procedure TMainForm.E5Click(Sender: TObject);
begin
  Self.Enabled := False;
  MergeTagForm.show;
end;

procedure TMainForm.EjectBtnClick(Sender: TObject);
begin
  if DriversList.ItemIndex > -1 then
  begin
    if not CDIn.IsBusy then
    begin
      CDIn.Eject;
    end;
  end;
end;

procedure TMainForm.EmalBtnClick(Sender: TObject);
const
  NewLine = '%0D%0A';
var
  mail: PChar;
  mailbody: string;
begin
  mailbody := AboutForm.Label1.Caption;
  if Portable then
  begin
    mailbody := mailbody + NewLine + 'Portable version';
  end
  else
  begin
    mailbody := mailbody + NewLine + 'Installed version';
  end;

  if not Build64Bit then
  begin
    mailbody := mailbody + NewLine + '32-bit' + NewLine;
  end
  else
  begin
    mailbody := mailbody + NewLine + '64-bit' + NewLine;
  end;

  mailbody := mailbody + NewLine + 'Bugs: ' + NewLine + NewLine + NewLine + 'Suggestions: ' + NewLine + NewLine + NewLine;
  mail := PwideChar('mailto:ozok26@gmail.com?subject=TAudioConverter&body=' + mailbody);

  ShellExecute(0, 'open', mail, nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.EnableUI;
var
  i: integer;
begin

  StartBtn.Enabled := True;
  StopBtn.Enabled := False;
  // DirectoryEdit.Enabled := True;
  MergePanel.Visible := False;
  SameAsSourceBtn.Enabled := True;
  SameAsSourceBtnClick(Self);
  ProgressPanel.Visible := False;
  ProgressPanel.SendToBack;
  if sSkinManager1.Active then
  begin
    sSkinManager1.RepaintForms(True);
  end;

  for i := 0 to MainMenu.Items.Count - 1 do
  begin
    MainMenu.Items.Items[i].Enabled := True;
  end;
  DragDrop.DropTarget := MainForm;

  OutputBtn.Top := DirectoryEdit.Top;

  if SettingsForm.AlwaysTopBtn.Checked then
  begin
    MainForm.FormStyle := fsStayOnTop;
    SettingsForm.FormStyle := fsStayOnTop;
    SettingsForm.FormStyle := fsStayOnTop;
    AboutForm.FormStyle := fsStayOnTop;
    InfoForm.FormStyle := fsStayOnTop;
    LogForm.FormStyle := fsStayOnTop;
    ProgressForm.FormStyle := fsStayOnTop;
    FiltersForm.FormStyle := fsStayOnTop;
    TagForm.FormStyle := fsStayOnTop;
    UpdaterForm.FormStyle := fsStayOnTop;
  end
  else
  begin
    MainForm.FormStyle := fsNormal;
    SettingsForm.FormStyle := fsNormal;
    AboutForm.FormStyle := fsNormal;
    InfoForm.FormStyle := fsNormal;
    LogForm.FormStyle := fsNormal;
    ProgressForm.FormStyle := fsNormal;
    FiltersForm.FormStyle := fsNormal;
    TagForm.FormStyle := fsNormal;
    UpdaterForm.FormStyle := fsNormal;
  end;

end;

procedure TMainForm.EncodingSettingsBtnClick(Sender: TObject);
begin
  Self.Enabled := False;
  SettingsForm.SettingsPage.ActivePageIndex := 1;
  SettingsForm.show;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin

  Application.Terminate;

end;

function TMainForm.FDKPercentage(const FDKOutput: string): integer;
var
  TmpStr: string;
  TmpInt: Integer;
  FConsoleOutput: string;
  StrPos: Integer;
begin

  Result := 0;

  FConsoleOutput := Trim(FDKOutput);

  if Length(FConsoleOutput) > 0 then
  begin

    if Copy(FConsoleOutput, 1, 1) = '[' then
    begin
      StrPos := Pos('%]', FConsoleOutput);

      if StrPos > -1 then
      begin
        TmpStr := Copy(FConsoleOutput, 2, StrPos);
        TmpStr := ReplaceText(TmpStr, '%]', '');

        if TryStrToInt(TmpStr, TmpInt) then
        begin
          Result := TmpInt;
        end
        else
          Log(TmpStr);

      end;

    end;

  end;

end;

function TMainForm.FFMpegPercentage(const FFMpegOutput: string; const DurationStr: string): Integer;
var
  pos1: Integer;
  pos2: Integer;
  Text: string;
  prog: string;
  last: string;
  PositionInt: Integer;
begin
  Result := 0;
  if (Length(FFMpegOutput) > 0) then
  begin
    Text := FFMpegOutput;
    // pos1 := Pos('frame=', FFmpegOutput);
    // pos2 := Pos('fps=', FFmpegOutput);
    // prog := Copy(Text, pos1 + 1, (pos2 - pos1 - 1));
    // last := Copy(prog, 6, Length(prog) - 4);
    pos1 := Pos('time=', FFMpegOutput);
    pos2 := Pos('bitrate=', FFMpegOutput);
    prog := Copy(Text, pos1 + 1, (pos2 - pos1 - 1));
    last := Copy(prog, 5, Length(prog) - 4);

    PositionInt := TimeToInt(LeftBStr(Trim(last), 8));

    if IsStringNumeric(DurationStr) then
    begin
      if (StrToInt(DurationStr) > 0) then
      begin
        Result := (100 * PositionInt) div StrToInt(DurationStr);
      end;
    end;
  end;
end;

procedure TMainForm.FileListAdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  if (Item.Index mod 2) = 0 then
  begin
    Sender.Canvas.Font.Color := clBlack;
  end
  else
  begin
    Sender.Canvas.Font.Color := clGrayText;
  end;
end;

procedure TMainForm.FileListClick(Sender: TObject);
var
  index: Integer;
  StrPos: integer;
  i: integer;
begin

  index := FileList.ItemIndex;

  AudioTrackList.Items.Clear;

  if index > -1 then
  begin
    AudioTrackList.Items.DelimitedText := AudioTracks[index];

    if AudioTrackList.Items.Count > 0 then
    begin

      for i := 0 to AudioTrackList.Items.Count - 1 do
      begin
        Application.ProcessMessages;

        StrPos := Pos(',', AudioTrackList.Items[i]);
        if AudioIndexes[index] = Copy(AudioTrackList.Items[i], 1, StrPos - 1) then
        begin
          AudioTrackList.ItemIndex := i;
        end
        else
        begin
          AudioTrackList.ItemIndex := 0;
        end;

      end;

    end;
  end
  else
  begin
    AudioTrackList.Items.Clear;
  end;

end;

procedure TMainForm.FileListColumnClick(Sender: TObject; Column: TListColumn);
var
  I: Integer;
  LII: TIndexItem;
  // dummy lists
  LAudioTracks, LAudioIndexes, LFiles, LDurations, LExtensionsForCopy, LCopyExtension, LStartPositions, LEndPositions, LConstantDurations: TStringList;
  LTagsList: TList<TTagInfo>;
  // dummy tag item
  LTag: TTagInfo;
begin
  if FileList.Items.Count = 0 then
    Exit;

  Self.Enabled := False;
  try
    for I := 0 to FileList.Columns.Count - 1 do
    begin
      FileList.Columns[I].ImageIndex := -1;
    end;
    if Column.Index <> FSortedColumn then
    begin
      FSortedColumn := Column.Index;
      FDescending := False;
    end
    else
    begin
      FDescending := not FDescending;
    end;
    if FDescending then
    begin
      Column.ImageIndex := 0;
    end
    else
    begin
      Column.ImageIndex := 1;
    end;
    TsListView(Sender).SortType := stText;
    // re-arrange items' durations, start-end etc
    LAudioTracks := TStringList.Create;
    LAudioIndexes := TStringList.Create;
    LFiles := TStringList.Create;
    LDurations := TStringList.Create;
    LExtensionsForCopy := TStringList.Create;
    LCopyExtension := TStringList.Create;
    LStartPositions := TStringList.Create;
    LEndPositions := TStringList.Create;
    LConstantDurations := TStringList.Create;
    LTagsList := TList<TTagInfo>.Create;
    try
      // fill dummy lists with dummy data
      for I := 0 to FileList.Items.Count - 1 do
      begin
        Application.ProcessMessages;
        LAudioTracks.Add('');
        LAudioIndexes.Add('');
        LFiles.Add('');
        LDurations.Add('');
        LExtensionsForCopy.Add('');
        LCopyExtension.Add('');
        LStartPositions.Add('');
        LEndPositions.Add('');
        LConstantDurations.Add('');
        LTagsList.Add(LTag);
      end;
      // copy existing data to dummy lists
      for I := 0 to FileList.Items.Count - 1 do
      begin
        // get the object
        LII := FileList.Items[I].SubItems.Objects[BITRATE_COLUMN_INDEX] as TIndexItem;

        LAudioTracks[I] := AudioTracks[LII.RealIndex];
        LAudioIndexes[I] := AudioIndexes[LII.RealIndex];
        LFiles[I] := Files[LII.RealIndex];
        LDurations[I] := Durations[LII.RealIndex];
        LExtensionsForCopy[I] := ExtensionsForCopy[LII.RealIndex];
        LCopyExtension[I] := CopyExtension[LII.RealIndex];
        LStartPositions[I] := StartPositions[LII.RealIndex];
        LEndPositions[I] := EndPositions[LII.RealIndex];
        LConstantDurations[I] := ConstantDurations[LII.RealIndex];
        LTagsList[I] := TagsList[LII.RealIndex];
        if FPlaybackIndex = LII.RealIndex then
        begin
          FPlaybackIndex := I;
        end;
        // re-assign object to list
        LII.RealIndex := I;
        FileList.Items[I].SubItems.Objects[BITRATE_COLUMN_INDEX] := LII;
      end;
      // clear the real lists
      AudioTracks.Clear;
      AudioIndexes.Clear;
      Files.Clear;
      Durations.Clear;
      ExtensionsForCopy.Clear;
      CopyExtension.Clear;
      StartPositions.Clear;
      EndPositions.Clear;
      ConstantDurations.Clear;
      TagsList.Clear;
      // add data from dummy lists to real lists
      AudioTracks.AddStrings(LAudioTracks);
      AudioIndexes.AddStrings(LAudioIndexes);
      Files.AddStrings(LFiles);
      Durations.AddStrings(LDurations);
      ExtensionsForCopy.AddStrings(LExtensionsForCopy);
      CopyExtension.AddStrings(LCopyExtension);
      StartPositions.AddStrings(LStartPositions);
      EndPositions.AddStrings(LEndPositions);
      ConstantDurations.AddStrings(LConstantDurations);
      TagsList.AddRange(LTagsList.ToArray);
    finally
      LAudioTracks.Free;
      LAudioIndexes.Free;
      LFiles.Free;
      LDurations.Free;
      LExtensionsForCopy.Free;
      LCopyExtension.Free;
      LStartPositions.Free;
      LEndPositions.Free;
      LConstantDurations.Free;
      LTagsList.Free;
    end;
  finally
    Self.Enabled := True;
  end;
  (Sender as TsListView).SortType := stNone;
end;

procedure TMainForm.FileListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if FSortedColumn = 0 then
  begin
    Compare := CompareText(Item1.Caption, Item2.Caption)
  end
  else if FSortedColumn <> 0 then
  begin
    Compare := CompareText(Item1.SubItems[FSortedColumn - 1], Item2.SubItems[FSortedColumn - 1]);
  end;
  if FDescending then
  begin
    Compare := -Compare;
  end;
end;

procedure TMainForm.FileListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if (Control as TsListBox).Items.Count < 1 then
    Exit;
  with Control as TsListBox, Canvas do
  begin
    // item selected
    if odSelected in State then
    begin
      Brush.Color := Self.Color;
      Font.Color := clBlack;
      FillRect(Rect);
      TextOut(Rect.Left + 2, Rect.Top + 2, Items[Index])
    end
    else
    begin
      // item not selected
      Brush.Color := (Control as TsListBox).Color;
      Font.Color := (Control as TsListBox).Font.Color;
      FillRect(Rect);
      TextOut(Rect.Left + 2, Rect.Top + 2, Items[Index])
    end;
  end;
end;

procedure TMainForm.FileListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if (Key = VK_UP) or (Key = VK_DOWN) then
  begin
    FileList.OnClick(Self);
  end;

end;

function TMainForm.FileNeedsDecoding(const FilePath: string): Boolean;
var
  MediaInfoHandle: Cardinal;
  LCodec: string;
begin
  Result := True;
  if not IsAudioOnly(FilePath) then
  begin
    // video files
    Result := True;
  end
  else
  begin
    // if effects are activated then we must decode stream to wav
    if FiltersForm.EnableBtn.Checked then
    begin
      Result := True;
      Exit;
    end;

    if (FileExists(FilePath)) then
    begin

      // New handle for mediainfo
      MediaInfoHandle := MediaInfo_New();

      if MediaInfoHandle <> 0 then
      begin

        try
          // Open a file in complete mode
          MediaInfo_Open(MediaInfoHandle, PwideChar(FilePath));
          MediaInfo_Option(0, 'Complete', '1');

          LCodec := Trim(MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'Codec', Info_Text, Info_Name));
          LCodec := LowerCase(LCodec);
          if ContainsText(LCodec, 'wav') or ContainsText(LCodec, 'pcm') and (LCodec <> 'wavpack') then
          begin
            Result := False;
          end;
        finally
          MediaInfo_Close(MediaInfoHandle);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.FileSearchFindFile(Sender: TObject; const AName: string);
begin

  ProgressForm.CurrentFileLabel.Caption := ExtractFileName(AName);
  AddFile(AName);

end;

procedure TMainForm.FileSearchProgress(Sender: TObject);
begin

  Application.ProcessMessages;

end;

procedure TMainForm.FillCDProgressList;
var
  I: Integer;
  LListItem: TListItem;
begin
  ProgressList.Items.Clear;
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    if FTrackInfoList[I].WillBeRipped then
    begin
      LListItem := CDPRogressList.Items.Add;
      LListItem.Caption := PadInteger(I + 1) + ' - ' + TracksList.Items[I].SubItems[1] + ' - ' + TracksList.Items[I].SubItems[2] + ' - ' + TracksList.Items[I].SubItems[0];
      LListItem.SubItems.Add('Waiting');
      LListItem.StateIndex := 1;
    end
    else
    begin
      LListItem := CDPRogressList.Items.Add;
      LListItem.Caption := PadInteger(I + 1) + ' - ' + TracksList.Items[I].SubItems[1] + ' - ' + TracksList.Items[I].SubItems[2] + ' - ' + TracksList.Items[I].SubItems[0];
      LListItem.SubItems.Add('Ignored');
      LListItem.StateIndex := 3;
    end;
  end;
end;

procedure TMainForm.FillSummaryList;
var
  NewNode: TTreeNode;
  i: integer;
begin

  SummaryView.Items.Clear;

  with SummaryView.Items do
  begin
    // number of processes
    NewNode := AddChild(nil, 'Number of processes: ' + FloatToStr(SettingsForm.ProcessCountList.ItemIndex + 1));
    AddChild(nil, 'Copy tags: ' + BoolToStr(SettingsForm.TagsBtn.Checked, True));
    AddChild(nil, 'Use custom tags: ' + BoolToStr(TagForm.UseValuesBtn.Checked, True));
    AddChild(nil, 'Enable artwork: ' + BoolToStr(SettingsForm.ArtworkBtn.Checked, True));
    AddChild(nil, 'Overwrite mode: ' + SettingsForm.OverWriteList.Text);
    if SettingsForm.ArtworkList.ItemIndex = 0 then
    begin
      AddChild(nil, 'Copy artwork to output: True');
      AddChild(nil, 'Copy external artwork: ' + BoolToStr(SettingsForm.Artwork2Btn.Checked, True));
    end
    else
    begin
      AddChild(nil, 'Embedded artwork to output: True');
    end;
    AddChild(nil, 'Add encoder suffix: ' + BoolToStr(SettingsForm.FolderSuffixBtn.Checked, True));
    AddChild(nil, 'Same as source: ' + BoolToStr(SameAsSourceBtn.Checked, True));
    if SettingsForm.FolderStructBtn.Checked then
    begin
      AddChild(nil, 'File name method: ' + SettingsForm.FolderStructList.Text);
    end;
    // replay gain
    NewNode := AddChild(nil, 'Enable ReplayGain: ' + BoolToStr(SettingsForm.ReplayGainBtn.Checked, True));
    if SettingsForm.ReplayGainBtn.Checked then
    begin
      AddChild(NewNode, 'Target dB value: ' + SettingsForm.ReplayGainEdit.Text + 'dB');
      // AddChild(NewNode, 'Method: ' + SettingsForm.ReplayGainList.Text);
      AddChild(NewNode, 'Lower dB to prevent clipping: ' + BoolToStr(SettingsForm.RGAutoLowerBtn.Checked, True));
      NewNode.Expand(True);
    end;

    // audio
    NewNode := AddChild(nil, 'Audio');
    case AudioMethodList.ItemIndex of
      0:
        begin
          if CanUseLossyWAV then
          begin
            AddChild(NewNode, 'lossyWAV quality: ' + CodecSettingsForm.LossyWAVQualityList.Text);
            AddChild(NewNode, 'Using extra options for lossWAV: ' + BoolToStr(CodecSettingsForm.LossyWAVEncoderOptBtn.Checked, True));
          end;
          // codec
          case FAudioEncoderType of
            etFFMpegAAC:
              begin
                AddChild(NewNode, 'Encoder: FFMpeg AAC');
                AddChild(NewNode, 'Bitrate: ' + CodecSettingsForm.FAACBitrateEdit.Text + ' kbps');

              end;
            etQAAC:
              begin
                AddChild(NewNode, 'Encoder: QAAC');
                case CodecSettingsForm.QaacEncodeMethodList.ItemIndex of
                  0:
                    AddChild(NewNode, 'ABR: ' + CodecSettingsForm.QaacBitrateEdit.Text + ' kbps');
                  1:
                    AddChild(NewNode, 'TVBR: ' + CodecSettingsForm.QaacvQualityEdit.Text);
                  2:
                    AddChild(NewNode, 'CVBR: ' + CodecSettingsForm.QaacBitrateEdit.Text + ' kbps');
                  3:
                    AddChild(NewNode, 'CBR: ' + CodecSettingsForm.QaacBitrateEdit.Text + ' kbps');
                end;
                AddChild(NewNode, 'Encoding quality: ' + CodecSettingsForm.QaacQualityList.Text);
                AddChild(NewNode, 'HE AAC mode: ' + BoolToStr(CodecSettingsForm.QaacHEBtn.Checked, True));
              end;
            etFFMpegAC3:
              begin
                AddChild(NewNode, 'Encoder: FFMpeg AC3');
                case CodecSettingsForm.AftenEncodeList.ItemIndex of
                  0:
                    AddChild(NewNode, 'Quality: ' + CodecSettingsForm.AftenQualityEdit.Text);
                  1:
                    AddChild(NewNode, 'CBR: ' + CodecSettingsForm.AftenBitrateEdit.Text + ' kbps');
                end;
              end;
            etOgg:
              begin
                AddChild(NewNode, 'Encoder: Ogg Vorbis');
                case CodecSettingsForm.OggencodeList.ItemIndex of
                  0:
                    AddChild(NewNode, 'Quality: ' + CodecSettingsForm.OggQualityEdit.Text);
                  1:
                    begin
                      AddChild(NewNode, 'Bitrate: ' + CodecSettingsForm.OggBitrateEdit.Text + ' kbps');
                      AddChild(NewNode, 'Managed bitrate: ' + BoolToStr(CodecSettingsForm.OggManagedBitrateBtn.Checked, True));
                    end;
                end;
              end;
            etLAME:
              begin
                AddChild(NewNode, 'Encoder: Lame');
                case CodecSettingsForm.LameEncodeList.ItemIndex of
                  0:
                    AddChild(NewNode, 'CBR: ' + CodecSettingsForm.LameBitrateEdit.Text + ' kbps');
                  1:
                    AddChild(NewNode, 'ABR: ' + CodecSettingsForm.LameBitrateEdit.Text + ' kbps');
                  2:
                    AddChild(NewNode, 'VBR: ' + CodecSettingsForm.LameVBREdit.Text);
                end;
                AddChild(NewNode, 'Algorithm quality: ' + CodecSettingsForm.LameQualityEdit.Text);
              end;
            etWAV:
              begin
                AddChild(NewNode, 'Encoder: Wav');
              end;
            etFLAC:
              begin
                AddChild(NewNode, 'Encoder: FLAC');
                AddChild(NewNode, 'Compression Level: ' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex));
                if CodecSettingsForm.FLACEMSBtn.Checked then
                begin
                  AddChild(NewNode, 'Exhaustive model search: True');
                end
                else
                begin
                  AddChild(NewNode, 'Exhaustive model search: False');
                end;
              end;
            etFHGAAC:
              begin
                AddChild(NewNode, 'Encoder: FHG AAC');
                case CodecSettingsForm.FHGMethodList.ItemIndex of
                  0:
                    begin
                      AddChild(NewNode, 'CBR: ' + CodecSettingsForm.FHGBitrateEdit.Text + ' kbps');
                      AddChild(NewNode, 'Profile: ' + CodecSettingsForm.FHGProfileList.Text);
                    end;
                  1:
                    AddChild(NewNode, 'VBR: ' + CodecSettingsForm.FHGQualityEdit.Text);
                end;
              end;
            etOpus:
              begin
                AddChild(NewNode, 'Encoder: Opus');
                case CodecSettingsForm.OpusEncodeMethodList.ItemIndex of
                  0:
                    AddChild(NewNode, 'VBR: ' + CodecSettingsForm.OpusBitrateEdit.Text + ' kbps');
                  1:
                    AddChild(NewNode, 'CVBR: ' + CodecSettingsForm.OpusBitrateEdit.Text);
                  2:
                    AddChild(NewNode, 'CBR: ' + CodecSettingsForm.OpusBitrateEdit.Text);
                end;
                AddChild(NewNode, 'Complexity: ' + CodecSettingsForm.OpusCompEdit.Text);
              end;
            etMPC:
              begin
                AddChild(NewNode, 'Encoder: MPC');
                AddChild(NewNode, 'Quality: ' + CodecSettingsForm.MPCQualityEdit.Text);
              end;
            etAPE:
              begin
                AddChild(NewNode, 'Encoder: Monkey''s Audio');
                AddChild(NewNode, 'Compression Level: ' + CodecSettingsForm.MACLevelList.Text);
              end;
            etTTA:
              begin
                AddChild(NewNode, 'Encoder: TTA');
              end;
            etTAK:
              begin
                AddChild(NewNode, 'Encoder: TAK');
                AddChild(NewNode, 'Preset: ' + CodecSettingsForm.TAKPresetList.Text);
              end;
            etNeroAAC:
              begin
                AddChild(NewNode, 'Encoder: Nero AAC');
                case CodecSettingsForm.NeroMethodList.ItemIndex of
                  0:
                    AddChild(NewNode, 'Quality: ' + CodecSettingsForm.NeroQualityEdit.Text);
                  1:
                    AddChild(NewNode, 'ABR: ' + CodecSettingsForm.NeroBitrateEdit.Text + ' kbps');
                  2:
                    AddChild(NewNode, 'CBR: ' + CodecSettingsForm.NeroBitrateEdit.Text + ' kbps');
                end;
                AddChild(NewNode, 'Profile: ' + CodecSettingsForm.NeroProfileList.Text);
              end;
            etFFmpegALAC:
              begin
                AddChild(NewNode, 'Encoder: ALAC');
              end;
            etWMA:
              begin
                AddChild(NewNode, 'Encoder: WMAEncoder');
                case CodecSettingsForm.WMAMethodList.ItemIndex of
                  0:
                    AddChild(NewNode, 'Quality: ' + CodecSettingsForm.WMAQualityList.Text);
                  1:
                    AddChild(NewNode, 'Bitrate: ' + CodecSettingsForm.WMABitrateEdit.Text);
                end;
                AddChild(NewNode, 'Codec: ' + CodecSettingsForm.WMACodecList.Text);
              end;
            etWavPack:
              begin
                AddChild(NewNode, 'Encoder: WavPack');
                case CodecSettingsForm.WavPackMethodList.ItemIndex of
                  0:
                    AddChild(NewNode, 'Lossless');
                  1:
                    begin
                      AddChild(NewNode, 'Hybrid: ' + CodecSettingsForm.WavPackBitrateEdit.Text + ' kbps');
                      AddChild(NewNode, 'Create correction file: ' + BoolToStr(CodecSettingsForm.WavPackCorrectionBtn.Checked, True));
                    end;
                end;
                AddChild(NewNode, 'Extra encode processing: ' + BoolToStr(CodecSettingsForm.WavPackExtraBtn.Checked, True));
              end;
            etFDKAAC:
              begin
                AddChild(NewNode, 'Encoder: FDKAAC');
                AddChild(NewNode, 'Profile: ' + CodecSettingsForm.FDKProfileList.Text);
                AddChild(NewNode, 'Bitrate: ' + CodecSettingsForm.FDKBitrateEdit.Text);
                AddChild(NewNode, 'Gapless: ' + CodecSettingsForm.FDKGaplessList.Text);
              end;
            etAIFF:
              begin
                AddChild(NewNode, 'Encoder: AIFF');
              end;
            etFLACCL:
              begin
                AddChild(NewNode, 'Encoder: FLACCL');
                AddChild(NewNode, 'Compression Level: ' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex + 1));
              end;
            etDCA:
              begin
                AddChild(NewNode, 'Encoder: dcaenc');
                AddChild(NewNode, 'Bitrate: ' + CodecSettingsForm.DCABitrateEdit.Text);
              end;
          end;
          AddChild(NewNode, 'Bit Depth: ' + CodecSettingsForm.BitDepthList.Text);
          NewNode.Expand(True);
          // effects
          with FiltersForm do
          begin
            NewNode := AddChild(NewNode, 'Effects');
            if EnableBtn.Checked then
            begin
              if VolumeBtn.Checked then
              begin
                AddChild(NewNode, 'Change volume: ' + BoolToStr(VolumeBtn.Checked, True));
                AddChild(NewNode, 'Volume: ' + VolumeEdit.Text);
              end
              else
              begin
                AddChild(NewNode, 'Change volume: ' + BoolToStr(VolumeBtn.Checked, True));
              end;

              AddChild(NewNode, 'Samplerate: ' + CodecSettingsForm.SampleList.Text);
              AddChild(NewNode, 'Channels: ' + CodecSettingsForm.ChannelList.Text);
              AddChild(NewNode, 'Normalize: ' + BoolToStr(NormBtn.Checked, True));
              AddChild(NewNode, 'Guard against clipping: ' + BoolToStr(GuardBtn.Checked, True));
              AddChild(NewNode, 'Speed: ' + SpeedEdit.Text + '%');
              NewNode.Expand(True)
            end
            else
            begin
              AddChild(NewNode, 'Disabled')
            end;

          end;
        end;
      1:
        begin
          AddChild(NewNode, 'Copying audio');
        end;
      2:
        begin
          AddChild(NewNode, 'No audio');
        end;
    end;

  end;

  SummaryView.Items.Item[0].Selected := True;
  SummaryView.Items.Item[0].SelectedIndex := 0;

  AddToLog(0, '');
  AddToLog(0, '----Encoding Summary----');
  for i := 0 to SummaryView.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if SummaryView.Items.Item[i].HasChildren then
    begin
      if SummaryView.Items.Item[i].getFirstChild.HasChildren then
      begin
        AddToLog(0, '+' + SummaryView.Items.Item[i].Text);
      end
      else
      begin
        AddToLog(0, '    +' + SummaryView.Items.Item[i].Text);
      end;
    end
    else
    begin
      AddToLog(0, '        -' + SummaryView.Items.Item[i].Text);
    end;
  end;
  AddToLog(0, 'Temp: ' + SettingsForm.TempEdit.Text);
  if SameAsSourceBtn.Checked then
  begin
    AddToLog(0, 'Output: Same as source');
  end
  else
  begin
    AddToLog(0, 'Output: ' + DirectoryEdit.Text);
  end;
  AddToLog(0, '----Encoding Summary----');
  AddToLog(0, '');

end;

function TMainForm.FLACPercentage(const FLACOutput: string): Integer;
var
  StrPos1, StrPos2: integer;
  PercentStr: string;
begin
  Result := 0;
  if Length(FLACOutput) > 0 then
  begin
    StrPos1 := Pos(':', FLACOutput);
    StrPos2 := Pos('%', FLACOutput);

    PercentStr := Trim(Copy(FLACOutput, StrPos1 + 1, StrPos2 - StrPos1 - 1));

    if IsStringNumeric(PercentStr) then
    begin
      Result := StrToInt(PercentStr);
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  // profile changes weren't saved otherwise
  CodecSettingsForm.SaveOptions;

  for i := Low(FEncoders) to High(FEncoders) do
  begin
    FEncoders[i].Stop;
  end;

  if not UpdateThread.Terminated then
  begin
    UpdateThread.Terminate;
  end;

  while not UpdateThread.Terminated do
  begin
    Application.ProcessMessages;
    Sleep(10);
  end;

  SaveOptions();
  DeleteTempFiles(True);

  // release cd tray in anycase
  CDIn.LockTray := False;

  if FileExists(SystemInfo.Folders.Temp + '\cdcover.jpg') then
  begin
    DeleteFile(SystemInfo.Folders.Temp + '\cdcover.jpg')
  end;

  // leave no trace
  if Portable then
  begin
    // delete cdr.ini
    if FileExists(SystemInfo.Folders.AppData + '\cdr.ini') then
    begin
      DeleteFile(SystemInfo.Folders.AppData + '\cdr.ini')
    end;
    // delete temp/tac folder
    if DirectoryExists(SystemInfo.Folders.Temp + '\TAudioConverter') then
    begin
      if not RemoveDir(SystemInfo.Folders.Temp + '\TAudioConverter') then
      begin
        RaiseLastOSError;
      end;
    end;
  end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin

  FPlayer := TPlayer.Create(Self.Handle);
  case FPlayer.ErrorMsg of
    MY_ERROR_BASS_NOT_LOADED:
      begin
        Application.MessageBox(PChar('Couldn''t load bass.dll library. Bass code: ' + FloatToStr(FPlayer.BassError)), 'Fatal Error', MB_ICONERROR);
        Application.Terminate;
      end;
  end;

{$REGION 'backend check'}
  // check necessary files.
  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\fhgaacenc\fhgaacenc.exe') then
  begin
    Application.MessageBox('Can''t find fhgaacenc.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FFHGPath := ExtractFileDir(Application.ExeName) + '\tools\fhgaacenc\fhgaacenc.exe';
  end;
  if not FileExists(ExtractFileDir(Application.ExeName) + '\renametool.exe') then
  begin
    Application.MessageBox('Can''t find renametool.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FRenameToolPath := ExtractFileDir(Application.ExeName) + '\renametool.exe';
  end;
  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\lossywav\lossywav.exe') then
  begin
    Application.MessageBox('Can''t find lossywav.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FLossyWAVPath := ExtractFileDir(Application.ExeName) + '\tools\lossywav\lossywav.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\fdkaac\fdkaac.exe') then
  begin
    Application.MessageBox('Can''t find fdkaac.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FFdkAACPath := ExtractFileDir(Application.ExeName) + '\tools\fdkaac\fdkaac.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\wavpack\wavpack.exe') then
  begin
    Application.MessageBox('Can''t find wavpack.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FWavPackPath := ExtractFileDir(Application.ExeName) + '\tools\wavpack\wavpack.exe';
  end;

  FNeroEncPath := ExtractFileDir(Application.ExeName) + '\neroaacenc.exe';
  FNeroTagPath := ExtractFileDir(Application.ExeName) + '\neroaactag.exe';

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\ffmpeg\ffmpeg.exe') then
  begin
    Application.MessageBox('Can''t find ffmpeg.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FFFMpegPath := ExtractFileDir(Application.ExeName) + '\tools\ffmpeg\ffmpeg.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\ffmpeg\ffprobe.exe') then
  begin
    Application.MessageBox('Can''t find ffprobe.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FFFProbePath := ExtractFileDir(Application.ExeName) + '\tools\ffmpeg\ffprobe.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\ttaenc\ttaenc.exe') then
  begin
    Application.MessageBox('Can''t find ttaenc.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FTTAPath := ExtractFileDir(Application.ExeName) + '\tools\ttaenc\ttaenc.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\ttagger.exe') then
  begin
    Application.MessageBox('Can''t find ttagger.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FTTaggerPath := ExtractFileDir(Application.ExeName) + '\ttagger.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\TArtworkExtractor.exe') then
  begin
    Application.MessageBox('Can''t find TArtworkExtractor.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FArtworkExtractorPath := ExtractFileDir(Application.ExeName) + '\TArtworkExtractor.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\lame.exe') then
  begin
    Application.MessageBox('Can''t find lame.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FLamePath := ExtractFileDir(Application.ExeName) + '\tools\lame.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\dcaenc.exe') then
  begin
    Application.MessageBox('Can''t find dcaenc.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FDCAENCPath := ExtractFileDir(Application.ExeName) + '\tools\dcaenc.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\WMAEncode\WMAEncode.exe') then
  begin
    Application.MessageBox('Can''t find WMAEncode.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FWmaEncodePath := ExtractFileDir(Application.ExeName) + '\tools\WMAEncode\WMAEncode.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\flaccl\CUETools.FLACCL.cmd.exe') then
  begin
    Application.MessageBox('Can''t find CUETools.FLACCL.cmd.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FFLACCLPath := ExtractFileDir(Application.ExeName) + '\tools\flaccl\CUETools.FLACCL.cmd.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\mpc\mpcenc.exe') then
  begin
    Application.MessageBox('Can''t find mpcenc.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FMPCPath := ExtractFileDir(Application.ExeName) + '\tools\mpc\mpcenc.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\mpc\mpcgain.exe') then
  begin
    Application.MessageBox('Can''t find mpcgain.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FMPCGainPath := ExtractFileDir(Application.ExeName) + '\tools\mpc\mpcgain.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\sox\sox.exe') then
  begin
    Application.MessageBox('Can''t find sox.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FSoxPath := ExtractFileDir(Application.ExeName) + '\tools\sox\sox.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\flac.exe') then
  begin
    Application.MessageBox('Can''t find flac.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FFLACPath := ExtractFileDir(Application.ExeName) + '\tools\flac.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\metaflac.exe') then
  begin
    Application.MessageBox('Can''t find metaflac.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FMetaFlacPath := ExtractFileDir(Application.ExeName) + '\tools\metaflac.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\MAC.exe') then
  begin
    Application.MessageBox('Can''t find MAC.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FMACPath := ExtractFileDir(Application.ExeName) + '\tools\MAC.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\Takc.exe') then
  begin
    Application.MessageBox('Can''t find Takc.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FTAKPath := ExtractFileDir(Application.ExeName) + '\tools\Takc.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\opusenc.exe') then
  begin
    Application.MessageBox('Can''t find opusenc.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FOpusPath := ExtractFileDir(Application.ExeName) + '\tools\opusenc.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\qaac\qaac.exe') then
  begin
    Application.MessageBox('Can''t find qaac.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FQaacPath := ExtractFileDir(Application.ExeName) + '\tools\qaac\qaac.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\oggenc2.exe') then
  begin
    Application.MessageBox('Can''t find oggenc2.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FOggEncPath := ExtractFileDir(Application.ExeName) + '\tools\oggenc2.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\aacgain\aacgain.exe') then
  begin
    Application.MessageBox('Can''t find aacgain.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FAACGainPath := ExtractFileDir(Application.ExeName) + '\tools\aacgain\aacgain.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\mp3gain.exe') then
  begin
    Application.MessageBox('Can''t find mp3gain.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FMp3GainPath := ExtractFileDir(Application.ExeName) + '\tools\mp3gain.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\vorbisgain.exe') then
  begin
    Application.MessageBox('Can''t find vorbisgain.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FVorbisGainPath := ExtractFileDir(Application.ExeName) + '\tools\vorbisgain.exe';
  end;

  if not FileExists(ExtractFileDir(Application.ExeName) + '\tools\wavpack\wvgain.exe') then
  begin
    Application.MessageBox('Can''t find wvgain.exe. Please re-install.', 'Error', MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    FWVGainPath := ExtractFileDir(Application.ExeName) + '\tools\wavpack\wvgain.exe';
  end;

  if not MediaInfoDLL_Load(ExtractFileDir(Application.ExeName) + '\MediaInfo.dll') then
  begin
    Application.MessageBox('Cannot load MediaInfo.dll!', 'Fatal Error', MB_ICONERROR);
    Application.Terminate;
  end;

  if FileExists(ExtractFileDir(Application.ExeName) + '\updater.exe') then
  begin
    if not DeleteFile(ExtractFileDir(Application.ExeName) + '\updater.exe') then
    begin
      Application.MessageBox('Can''t delete updater.exe.', 'Error', MB_ICONERROR);
    end;
  end;
{$ENDREGION}
  AppFolder := ExtractFileDir(Application.ExeName) + '\';
  if Portable then
  begin
    AppDataFolder := AppFolder;
    MyDoc := AppFolder;
    AppIniFileStorage.FileName := AppFolder + '\pos.ini';
  end
  else
  begin
    AppDataFolder := SystemInfo.Folders.AppData + '\TAC\';
    MyDoc := SystemInfo.Folders.Personal + '\TAC\';
    AppIniFileStorage.FileName := AppDataFolder + '\pos.ini';
  end;

  if not DirectoryExists(AppDataFolder) then
  begin
    CreateDir(AppDataFolder);
  end;

  AudioIndexes := TStringList.Create;
  AudioTracks := TStringList.Create;
  Files := TStringList.Create;
  FilesToCheck := TStringList.Create;
  Durations := TStringList.Create;
  ExtensionsForCopy := TStringList.Create;
  CopyExtension := TStringList.Create;
  StartPositions := TStringList.Create;
  EndPositions := TStringList.Create;
  ConstantDurations := TStringList.Create;
  TagsList := TList<TTagInfo>.Create;
  CompressionPairs := TList<TCompressionFileNamesPair>.Create;
  FMergeFileList := TStringList.Create;
  FMergeProcess := TEncoder.Create;
  FTagReader := TTagReader.Create;
  FPresets := TLamePresetList.Create;
  FPresetFilesList := TStringList.Create;

  for i := Low(FEncoders) to High(FEncoders) do
  begin
    FEncoders[i] := TEncoder.Create;
  end;

  // windows 7 taskbar
  if CheckWin32Version(6, 1) then
  begin
    if not InitializeTaskbarAPI then
    begin
      Application.MessageBox('You seem to have Windows 7 or later but TAudioConverter can''t start taskbar progressbar!', 'Error', MB_ICONERROR);
    end;
  end;

  AudioTrackList.Items.Delimiter := '|';
  AudioTrackList.Items.StrictDelimiter := True;
  EncodeModePages.Pages[0].TabVisible := False;
  EncodeModePages.Pages[1].TabVisible := False;

  FAudioEncoderType := etFFMpegAAC;

  IsPortable := Portable;

  // AssignLabelToProgressBar(TotalProgressLabel, TotalProgressBar);

  // cd ripper
  FTrackInfoList := TList<TTrackInfo>.Create;
  FTracksToBeRipped := TList<TTrackIndexes>.Create;
  LoadDrivers;

  PositionBar.Max := MaxInt;
  FPlaybackIndex := -1;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin

  FreeAndNil(AudioTracks);
  FreeAndNil(AudioIndexes);
  FreeAndNil(Files);
  FreeAndNil(FilesToCheck);
  FreeAndNil(ExtensionsForCopy);
  FreeAndNil(Durations);
  FreeAndNil(CopyExtension);
  FreeAndNil(StartPositions);
  FreeAndNil(EndPositions);
  FreeAndNil(ConstantDurations);
  TagsList.Free;
  CompressionPairs.Free;
  FTrackInfoList.Free;
  FTracksToBeRipped.Free;
  FMergeFileList.Free;
  FMergeProcess.Free;
  FTagReader.Free;
  FPresets.Free;
  FPresetFilesList.Free;

  for I := Low(FEncoders) to High(FEncoders) do
  begin
    FEncoders[I].Free;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if not Assigned(SettingsForm.ShowExtraColumnsBtn) then
    Exit;

  // if SettingsForm.ShowExtraColumnsBtn.Checked then
  // begin
  // if FileList.ClientWidth > (FileList.Columns[0].Width + FileList.Columns[1].Width + FileList.Columns[2]
  // .Width + FileList.Columns[3].Width + FileList.Columns[4].Width +
  // FileList.Columns[5].Width + FileList.Columns[6].Width) then
  // begin
  // FileList.Column[0].Width := FileList.ClientWidth -
  // (FileList.Columns[1].Width + FileList.Columns[2].Width +
  // FileList.Columns[3].Width + FileList.Columns[4].Width + FileList.Columns
  // [5].Width + FileList.Columns[6].Width)
  // end
  // else
  // begin
  // Filelis
  // end;
  // end
  // else
  // begin
  // FileList.Columns[0].Width := FileList.ClientWidth - FileList.Columns[1].Width
  // - FileList.Columns[2].Width - 20;
  // end;
  ProgressList.Columns[0].Width := ProgressList.ClientWidth - ProgressList.Columns[1].Width - 20;
  TracksList.Columns[1].Width := TracksList.ClientWidth - (TracksList.Columns[2].Width + TracksList.Columns[3].Width + TracksList.Columns[4].Width + TracksList.Columns[0].Width + 20);
  // FileList.Columns[0].Width := FileList.ClientWidth - (FileList.Columns[2].Width + FileList.Columns[3].Width + FileList.Columns[4].Width + FileList.Columns[1].Width + 20 + FileList.Columns[5].Width +
  // FileList.Columns[6].Width - FileList.Columns[7].Width - FileList.Columns[8].Width - FileList.Columns[9].Width - FileList.Columns[10].Width);
  CDPRogressList.Columns[0].Width := CDPRogressList.ClientWidth - CDPRogressList.Columns[1].Width - 20;
  // AssignLabelToProgressBar(TotalProgressLabel, TotalProgressBar);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  SettingsFile: TIniFile;
  i: integer;
  SkinIndex: integer;
begin
  DebugMsg('TAudioConverter debug test message.');
  DebugMsg('Portable: ' + BoolToStr(Portable, True));
  // delete logs
  DeleteLogs;
  // load skin options
  SettingsFile := TIniFile.Create(AppDataFolder + 'settings.ini');
  try
    with SettingsFile do
    begin
      SkinIndex := ReadInteger('Settings', 'Skin', 3);
      sSkinManager1.Active := not ReadBool('Settings', 'Skin3', True);
    end;
  finally
    SettingsFile.Free;
    if sSkinManager1.Active then
    begin
      sSkinManager1.SkinName := sSkinManager1.InternalSkins[SkinIndex].Name;
    end;
  end;
  // load presets
  LoadPresets;
  // load general options
  LoadOptions();
  // delete any temp files
  DeleteTempFiles(True);
  // update check thread
  if SettingsForm.CheckUpdateBtn.Checked then
  begin
    UpdateThread.Execute(nil);
  end;
  // add files specified in commandline
  for i := 1 to ParamCount do
  begin
    AddFile(ParamStr(i));
    if FileExists(ParamStr(i)) then
    begin
      FLastDirectory := ExtractFileDir(ParamStr(i));
    end;
  end;
  // load default cd cover
  CoverImg.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\cd.png');
  // there should be a temp folder
  if not DirectoryExists(SettingsForm.TempEdit.Text) then
  begin
    if not CreateDir(SettingsForm.TempEdit.Text) then
    begin
      AddToLog(0, 'Cannot find temp folder: ' + SettingsForm.TempEdit.Text);
    end;
  end;
  Self.BringToFront;
  // if not temp dir exits prompt user to select
  if not DirectoryExists(SettingsForm.TempEdit.Text) then
  begin
    Application.MessageBox('Temporary files folder doesn''t exist. Please specify a valid path.', 'Warning', MB_ICONERROR);
    Self.Enabled := False;
    SettingsForm.SettingsPage.ActivePageIndex := 0;
    SettingsForm.show;
  end;
end;

procedure TMainForm.FunctionPagesChange(Sender: TObject);
begin
  case FunctionPages.ActivePageIndex of
    0:
      begin
        AudioMethodListChange(Self);
      end;
    1:
      begin
        CodecSettingsBtn.Enabled := True;
        AudioCodecList.Enabled := True;
        ProfilesList.Enabled := True;
        NextCodecBtn.Enabled := True;
        PrevCodecBtn.Enabled := True;
        AudioEffectsBtn.Enabled := True;
        SummaryLabel.Enabled := True;
        // DriversListChange(Self);
        AudioCodecListChange(Self);
        AudioEffectsBtn.Enabled := False;
      end;
  end;
end;

procedure TMainForm.GenerateSummaryString;
begin
  // codec
  case FAudioEncoderType of
    etFFMpegAAC:
      begin
        SummaryLabel.Caption := 'Bitrate: ' + CodecSettingsForm.FAACBitrateEdit.Text + ' kbps';
      end;
    etQAAC:
      begin
        case CodecSettingsForm.QaacEncodeMethodList.ItemIndex of
          0:
            SummaryLabel.Caption := 'ABR: ' + CodecSettingsForm.QaacBitrateEdit.Text + ' kbps';
          1:
            SummaryLabel.Caption := 'TVBR: ' + CodecSettingsForm.QaacvQualityEdit.Text;
          2:
            SummaryLabel.Caption := 'CVBR: ' + CodecSettingsForm.QaacBitrateEdit.Text + ' kbps';
          3:
            SummaryLabel.Caption := 'CBR: ' + CodecSettingsForm.QaacBitrateEdit.Text + ' kbps';
        end;
      end;
    etFFMpegAC3:
      begin
        case CodecSettingsForm.AftenEncodeList.ItemIndex of
          0:
            SummaryLabel.Caption := 'Quality: ' + CodecSettingsForm.AftenQualityEdit.Text;
          1:
            SummaryLabel.Caption := 'CBR: ' + CodecSettingsForm.AftenBitrateEdit.Text + ' kbps';
        end;
      end;
    etOgg:
      begin
        case CodecSettingsForm.OggencodeList.ItemIndex of
          0:
            SummaryLabel.Caption := 'Quality: ' + CodecSettingsForm.OggQualityEdit.Text;
          1:
            begin
              SummaryLabel.Caption := 'Bitrate: ' + CodecSettingsForm.OggBitrateEdit.Text + ' kbps';
            end;
        end;
      end;
    etLAME:
      begin
        case CodecSettingsForm.LameEncodeList.ItemIndex of
          0:
            SummaryLabel.Caption := 'CBR: ' + CodecSettingsForm.LameBitrateEdit.Text + ' kbps';
          1:
            SummaryLabel.Caption := 'ABR: ' + CodecSettingsForm.LameBitrateEdit.Text + ' kbps';
          2:
            SummaryLabel.Caption := 'VBR: ' + CodecSettingsForm.LameVBREdit.Text;
        end;
      end;
    etWAV:
      begin
        SummaryLabel.Caption := 'No options';
      end;
    etFLAC:
      begin
        SummaryLabel.Caption := 'Comp. Level: ' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex);
      end;
    etFHGAAC:
      begin
        case CodecSettingsForm.FHGMethodList.ItemIndex of
          0:
            begin
              SummaryLabel.Caption := 'CBR: ' + CodecSettingsForm.FHGBitrateEdit.Text + ' kbps';
            end;
          1:
            SummaryLabel.Caption := 'VBR: ' + CodecSettingsForm.FHGQualityEdit.Text;
        end;
      end;
    etOpus:
      begin
        case CodecSettingsForm.OpusEncodeMethodList.ItemIndex of
          0:
            SummaryLabel.Caption := 'VBR: ' + CodecSettingsForm.OpusBitrateEdit.Text + ' kbps';
          1:
            SummaryLabel.Caption := 'CVBR: ' + CodecSettingsForm.OpusBitrateEdit.Text + ' kbps';
          2:
            SummaryLabel.Caption := 'CBR: ' + CodecSettingsForm.OpusBitrateEdit.Text + ' kbps';
        end;
      end;
    etMPC:
      begin
        SummaryLabel.Caption := 'Quality: ' + CodecSettingsForm.MPCQualityEdit.Text;
      end;
    etAPE:
      begin
        SummaryLabel.Caption := 'Comp. Level: ' + CodecSettingsForm.MACLevelList.Text;
      end;
    etTTA:
      begin
        SummaryLabel.Caption := 'No options';
      end;
    etTAK:
      begin
        SummaryLabel.Caption := 'Preset: ' + CodecSettingsForm.TAKPresetList.Text;
      end;
    etNeroAAC:
      begin
        case CodecSettingsForm.NeroMethodList.ItemIndex of
          0:
            SummaryLabel.Caption := 'Quality: ' + CodecSettingsForm.NeroQualityEdit.Text;
          1:
            SummaryLabel.Caption := 'ABR: ' + CodecSettingsForm.NeroBitrateEdit.Text + ' kbps';
          2:
            SummaryLabel.Caption := 'CBR: ' + CodecSettingsForm.NeroBitrateEdit.Text + ' kbps';
        end;
      end;
    etFFmpegALAC:
      begin
        SummaryLabel.Caption := 'No options';
      end;
    etWMA:
      begin
        case CodecSettingsForm.WMAMethodList.ItemIndex of
          0:
            SummaryLabel.Caption := 'Quality: ' + CodecSettingsForm.WMAQualityList.Text;
          1:
            SummaryLabel.Caption := 'Bitrate: ' + CodecSettingsForm.WMABitrateEdit.Text + ' kbps';
        end;
      end;
    etWavPack:
      begin
        case CodecSettingsForm.WavPackMethodList.ItemIndex of
          0:
            SummaryLabel.Caption := 'Lossless';
          1:
            begin
              SummaryLabel.Caption := 'Hybrid: ' + CodecSettingsForm.WavPackBitrateEdit.Text + ' kbps';
            end;
        end;
      end;
    etFDKAAC:
      begin
        case CodecSettingsForm.FDKMethodList.ItemIndex of
          0:
            SummaryLabel.Caption := 'Bitrate: ' + CodecSettingsForm.FDKBitrateEdit.Text + ' kbps';
          1:
            SummaryLabel.Caption := 'VBR:' + CodecSettingsForm.FDKVBREdit.Text;
        end;
      end;
    etAIFF:
      begin
        SummaryLabel.Caption := 'No options';
      end;
    etFLACCL:
      begin
        SummaryLabel.Caption := 'Comp. Level: ' + FloatToStr(CodecSettingsForm.FLACCompList.ItemIndex + 1);
      end;
    etDCA:
      begin
        SummaryLabel.Caption := 'Bitrate: ' + CodecSettingsForm.DCABitrateEdit.Text + ' kbps';
      end;
  end;
  with CodecSettingsForm do
  begin
    SummaryLabel.Caption := 'Sample rate: ' + SampleList.Text + ' | Channels: ' + ChannelList.Text + ' | Bit depth: ' + BitDepthList.Text + ' | ' + SummaryLabel.Caption
  end;
end;

procedure TMainForm.GenreEditChange(Sender: TObject);
var
  LT: TTrackInfo;
  I: Integer;
begin
  for I := 0 to TracksList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if TracksList.Items[I].Selected then
    begin
      LT := FTrackInfoList[I];
      LT.TrackTagInfo.Genre := GenreEdit.Text;
      FTrackInfoList[I] := LT;
    end;
  end;
end;

function TMainForm.GetChannelCount(const FileName: string; const AudioID: integer): integer;
var
  MediaInfoHandle: Cardinal;
  AChannels: string;
begin
  Result := 2;
  if (FileExists(FileName)) then
  begin
    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();
    if MediaInfoHandle <> 0 then
    begin
      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
        MediaInfo_Option(0, 'Complete', '1');

        // get length
        AChannels := MediaInfo_Get(MediaInfoHandle, Stream_Audio, AudioID, 'Channel(s)', Info_Text, Info_Name);

        if Length(AChannels) < 1 then
        begin
          if Length(Trim(AChannels)) < 1 then
          begin
            AChannels := MediaInfo_Get(MediaInfoHandle, Stream_General, AudioID, 'Channel(s)', Info_Text, Info_Name);
          end
          else
          begin
            AChannels := '2';
          end;
        end;

        if not IsStringNumeric(AChannels) then
        begin
          AChannels := '2';
        end;
        Result := StrToInt(AChannels);

      finally
        MediaInfo_Close(MediaInfoHandle);
      end;
    end;
  end;
end;

function TMainForm.GetCueCustomFileName(const Tags: TTagInfo; const FileNameStr: string): string;
var
  Title, Artist, Album, TrackNo, Genre, Date, Performer, DiskNo, AlbumArtist: string;
  OutputStr: string;
  LFTotalLength: integer;
begin
  OutputStr := '';

  // initial values
  Title := 'unknown';
  Artist := 'unknown';
  Album := 'unknown';
  TrackNo := 'unknown';
  Genre := 'unknown';
  Date := 'unknown';
  Performer := 'unknown';
  DiskNo := 'unknown';
  AlbumArtist := 'unknown';

  if TagForm.UseValuesBtn.Checked then
  begin
    // read tags from tagform
    Artist := TagForm.ArtistEdit.Text;
    Album := TagForm.AlbumEdit.Text;
    Genre := TagForm.GenreEdit.Text;
    Performer := TagForm.PerformerEdit.Text;
    Date := TagForm.DateEdit.Text;
  end
  else
  begin
    Title := Tags.TitleForFileName;
    Artist := Tags.ArtistForFileName;
    Album := Tags.AlbumForFileName;
    TrackNo := Tags.TrackNo;
    Genre := Tags.Genre;
    Performer := Tags.Performer;
    Date := Tags.RecordDate;
    DiskNo := Tags.DiscNo;
    AlbumArtist := Tags.AlbumArtist;
  end;

  Title := Trim(Title);
  Artist := Trim(Artist);
  Album := Trim(Album);
  TrackNo := Trim(TrackNo);
  Genre := Trim(Genre);
  Performer := Trim(Performer);
  Date := Trim(Date);
  DiskNo := Trim(DiskNo);
  TrackNo := PadString2(TrackNo);
  DiskNo := PadString2(DiskNo);
  AlbumArtist := Trim(RemoveInvalidChars(AlbumArtist));

  if (Length(Artist) < 1) then
  begin
    if Length(Performer) > 0 then
    begin
      Artist := Performer;
    end;
  end;
  if Length(AlbumArtist) < 1 then
  begin
    AlbumArtist := Artist;
  end;

  // make sure string is not empty
  LFTotalLength := Length(Title) + Length(Artist) + Length(Album) + Length(Genre) + Length(Date) + Length(TrackNo) + Length(DiskNo) + Length(AlbumArtist);
  if LFTotalLength > 0 then
  begin
    // replace strings
    OutputStr := FileNameStr;
    OutputStr := ReplaceText(OutputStr, '%title%', Title);
    OutputStr := ReplaceText(OutputStr, '%artist%', Artist);
    OutputStr := ReplaceText(OutputStr, '%album%', Album);
    OutputStr := ReplaceText(OutputStr, '%genre%', Genre);
    OutputStr := ReplaceText(OutputStr, '%date%', Date);
    OutputStr := ReplaceText(OutputStr, '%tracknumber%', TrackNo);
    OutputStr := ReplaceText(OutputStr, '%discnumber%', DiskNo);
    OutputStr := ReplaceText(OutputStr, '%albumartist%', AlbumArtist);

    Result := Trim(OutputStr);
    Result := RemoveInvalidChars(Result);
    DebugMsg('Output file name: ' + OutputStr);
  end;
end;

function TMainForm.GetCustomFileName(const FileNameStr, FileName: string; const FileIndex: Integer): string;
var
  Title, Artist, Album, TrackNo, Genre, Date, Performer, DiskNo, AlbumArtist: string;
  OutputStr: string;
  LFTotalLength: integer;
begin
  Result := ExtractFileName(FileName);

  if SettingsForm.FolderStructBtn.Checked then
  begin
    if (Length(FileNameStr) > 0) then
    begin
      OutputStr := '';
      if (FileExists(FileName)) then
      begin

        // initial values
        Title := 'unknown';
        Artist := 'unknown';
        Album := 'unknown';
        TrackNo := 'unknown';
        Genre := 'unknown';
        Date := 'unknown';
        Performer := 'unknown';
        DiskNo := 'unknown';
        AlbumArtist := 'unknown';

        if TagForm.UseValuesBtn.Checked then
        begin
          // read tags from tagform
          Artist := TagForm.ArtistEdit.Text;
          Album := TagForm.AlbumEdit.Text;
          Genre := TagForm.GenreEdit.Text;
          Performer := TagForm.PerformerEdit.Text;
          Date := TagForm.DateEdit.Text;
        end
        else
        begin
          Title := TagsList[FileIndex].TitleForFileName;
          Artist := TagsList[FileIndex].ArtistForFileName;
          Album := TagsList[FileIndex].AlbumForFileName;
          TrackNo := TagsList[FileIndex].TrackNo;
          Genre := TagsList[FileIndex].Genre;
          Performer := TagsList[FileIndex].Performer;
          Date := TagsList[FileIndex].RecordDate;
          DiskNo := TagsList[FileIndex].DiscNo;
          AlbumArtist := TagsList[FileIndex].AlbumArtist;
        end;

        Title := Trim(Title);
        Artist := Trim(Artist);
        Album := Trim(Album);
        TrackNo := Trim(TrackNo);
        Genre := Trim(Genre);
        Performer := Trim(Performer);
        Date := Trim(Date);
        DiskNo := Trim(DiskNo);
        TrackNo := PadString2(TrackNo);
        DiskNo := PadString2(DiskNo);
        AlbumArtist := Trim(RemoveInvalidChars(AlbumArtist));

        if (Length(Artist) < 1) then
        begin
          if Length(Performer) > 0 then
          begin
            Artist := Performer;
          end;
        end;
        if Length(AlbumArtist) < 1 then
        begin
          AlbumArtist := Artist;
        end;

        // make sure string is not empty
        LFTotalLength := Length(Title) + Length(Artist) + Length(Album) + Length(Genre) + Length(Date) + Length(TrackNo) + Length(DiskNo) + Length(AlbumArtist);
        if LFTotalLength > 0 then
        begin
          // replace strings
          OutputStr := FileNameStr;
          OutputStr := ReplaceText(OutputStr, '%title%', Title);
          OutputStr := ReplaceText(OutputStr, '%artist%', Artist);
          OutputStr := ReplaceText(OutputStr, '%album%', Album);
          OutputStr := ReplaceText(OutputStr, '%genre%', Genre);
          OutputStr := ReplaceText(OutputStr, '%date%', Date);
          OutputStr := ReplaceText(OutputStr, '%tracknumber%', TrackNo);
          OutputStr := ReplaceText(OutputStr, '%discnumber%', DiskNo);
          OutputStr := ReplaceText(OutputStr, '%albumartist%', AlbumArtist);

          Result := Trim(OutputStr);
          Result := RemoveInvalidChars(Result);
          DebugMsg('Output file name: ' + OutputStr);
        end;
      end;
    end;
  end;

end;

function TMainForm.GetDurationEx(const FileName: string): integer;
var
  MediaInfoHandle: Cardinal;
  VDuration: string;
begin

  Result := 0;

  if (FileExists(FileName)) then
  begin

    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();

    if MediaInfoHandle <> 0 then
    begin

      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
        MediaInfo_Option(0, 'Complete', '1');

        // get length
        VDuration := MediaInfo_Get(MediaInfoHandle, Stream_Video, 0, 'Duration', Info_Text, Info_Name);

        if Length(VDuration) < 1 then
        begin
          if Length(Trim(VDuration)) < 1 then
          begin
            VDuration := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Duration', Info_Text, Info_Name);
            if Length(VDuration) < 1 then
            begin
              VDuration := '0';
            end;
          end
          else
          begin
            VDuration := '0';
          end;
        end;

        Result := StrToInt64(VDuration);

      finally
        MediaInfo_Close(MediaInfoHandle);
      end;

    end;

  end;

end;

function TMainForm.GetFileFolderName(const FileName: string; const FileIndex: Integer): string;
var
  TmpStr: string;
  FolderName: string;
  C: Char;
  LFolderDepth: integer;
  LFoundDepth: Integer;
begin

  Result := '';
  if (SettingsForm.FolderStructBtn.Checked) then
  begin
    case SettingsForm.FolderStructList.ItemIndex of
      0:
        // folder tree
        begin
          // if file is from a network it's path will start with "\"
          // so no need to delete it
          if Copy(FileName, 1, 1) = '\' then
          begin
            TmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
            FolderName := RemoveInvalidChars(TmpStr);
          end
          else
          begin
            // delete driver char
            TmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
            Delete(TmpStr, 1, 3);
            FolderName := RemoveInvalidChars(TmpStr);
          end;
        end;
      1:
        begin
          // just one level up
          TmpStr := ReverseString(ExcludeTrailingPathDelimiter(ExtractFileDir(FileName)));
          for C in TmpStr do
          begin
            if C <> '\' then
            begin
              FolderName := FolderName + C;
            end
            else
            begin
              Break;
            end;
          end;
          FolderName := RemoveInvalidChars(ReverseString(FolderName));
        end;
      2:
        // custom file name. (%title% etc)
        begin
          FolderName := ParseFolderStr(SettingsForm.CustomFolderEdit.Text, FileName, FileIndex);
          FolderName := RemoveInvalidChars(FolderName);

          // if (Length(FolderName) < 1) or (Length(ExtractFileName(FolderName)) < 1) then
          // begin
          // // delete driver char
          // if Copy(FileName, 1, 1) = '\' then
          // begin
          // TmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
          // FolderName := RemoveInvalidChars(TmpStr);
          // end
          // else
          // begin
          // // delete driver char
          // TmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
          // Delete(TmpStr, 1, 3);
          // FolderName := RemoveInvalidChars(TmpStr);
          // end;
          // end;

        end;
      3: // folder depth
        begin
          // delete driver char
          if Copy(FileName, 1, 1) = '\' then
          begin
            TmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
            Delete(TmpStr, 1, 1);
          end
          else
          begin
            // delete driver char
            TmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(FileName));
            Delete(TmpStr, 1, 3);
          end;
          TmpStr := ReverseString(TmpStr);

          LFolderDepth := SettingsForm.DirDepthEdit.Value;
          LFoundDepth := 0;
          for C in TmpStr do
          begin
            Application.ProcessMessages;
            if LFoundDepth = LFolderDepth then
            begin
              Break;
            end;

            FolderName := FolderName + C;
            if C = '\' then
            begin
              inc(LFoundDepth);
            end;
          end;
          FolderName := RemoveInvalidChars(ReverseString(FolderName));
        end;
    end;

    if Length(FolderName) > 0 then
    begin
      if SettingsForm.FolderSuffixBtn.Checked and (SettingsForm.FolderStructList.ItemIndex <> 2) then
      begin
        case FAudioEncoderType of
          etFFMpegAAC:
            begin
              Result := (FolderName) + '_FFMpegAAC';
            end;
          etQAAC:
            begin
              Result := (FolderName) + '_Qaac';
            end;
          etFFMpegAC3:
            begin
              Result := (FolderName) + '_AC3';
            end;
          etOgg:
            begin
              Result := (FolderName) + '_OggVorbis';
            end;
          etLAME:
            begin
              Result := (FolderName) + '_Lame';
            end;
          etWAV:
            begin
              Result := (FolderName) + '_WAV';
            end;
          etFLAC:
            begin
              Result := (FolderName) + '_FLAC';
            end;
          etFHGAAC:
            begin
              Result := (FolderName) + '_FHGAAC';
            end;
          etOpus:
            begin
              Result := (FolderName) + '_Opus';
            end;
          etMPC:
            begin
              Result := (FolderName) + '_MPC';
            end;
          etAPE:
            begin
              Result := (FolderName) + '_APE';
            end;
          etTTA:
            begin
              Result := (FolderName) + '_TTA';
            end;
          etTAK:
            begin
              Result := (FolderName) + '_TAK';
            end;
          etNeroAAC:
            begin
              Result := (FolderName) + '_NEROAAC';
            end;
          etFFmpegALAC:
            begin
              Result := (FolderName) + '_ALAC';
            end;
          etWMA:
            begin
              Result := (FolderName) + '_WMA';
            end;
          etWavPack:
            begin
              Result := (FolderName) + '_WavPack';
            end;
          etFDKAAC:
            begin
              Result := (FolderName) + '_FDKAAC';
            end;
          etAIFF:
            begin
              Result := (FolderName) + '_AIFF';
            end;
          etFLACCL:
            begin
              Result := (FolderName) + '_FLACCL';
            end;
          etDCA:
            begin
              Result := FolderName + '_DCAENC';
            end;
        end;

        // differen for copy
        if AudioMethodList.ItemIndex = 1 then
        begin
          Result := (FolderName) + '_COPY'
        end;
      end
      else
      begin
        Result := FolderName;
      end;

    end;
  end;

end;

procedure TMainForm.GetFullInfo(const FileName: string);
var
  MediaInfoHandle: Cardinal;
  i: Integer;
  DotPos: Integer;
  Line: string;
  NewNode: TTreeNode;
  FFProbeInformer: TFFProbeInformer;
begin
  if (FileExists(FileName)) then
  begin
    // ffprobe
    FFProbeInformer := TFFProbeInformer.Create(FileName, FFFProbePath);
    try
      FFProbeInformer.Start;
      while FFProbeInformer.FFProbeStatus = ffiReading do
      begin
        Application.ProcessMessages;
        Sleep(10);
      end;
      if FFProbeInformer.FFProbeOutput.Count > 0 then
      begin
        InfoForm.FFProbeList.Lines.AddStrings(FFProbeInformer.FFProbeOutput);
      end;
    finally
      FFProbeInformer.Free;
    end;
    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();
    if MediaInfoHandle <> 0 then
    begin
      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
        MediaInfo_Option(0, 'Complete', '');
        InfoForm.InfoTMP.Text := string(MediaInfo_Inform(MediaInfoHandle, 0));
        if InfoForm.InfoTMP.Count > 0 then
        begin
          for i := 0 to InfoForm.InfoTMP.Count - 1 do
          begin
            Application.ProcessMessages;
            Line := InfoForm.InfoTMP.Strings[i];
            DotPos := Pos(':', Line);
            if DotPos > 0 then
            begin
              InfoForm.InfoList.Items.AddChild(NewNode, Trim(Copy(Line, 1, DotPos - 1)) + ':' + Copy(Line, DotPos + 1, Length(Line)));
            end
            else
            begin
              if Length(Line) > 0 then
              begin
                NewNode := InfoForm.InfoList.Items.AddChild(nil, Line);
              end;
            end;
          end;
        end;
      finally
        MediaInfo_Close(MediaInfoHandle);
        InfoForm.InfoList.FullExpand;
      end;
    end;
  end;
end;

function TMainForm.GetMergeProgress: integer;
var
  Encoder: TEncoder;
begin
  Result := 0;
  Encoder := FMergeProcess;
  if Length(Encoder.ConsoleOutput) > 0 then
  begin
    if Encoder.ProcessId > 0 then
    begin
      // decide running process kind
      if (Encoder.CurrentProcessType = etFFMpeg) or (Encoder.CurrentProcessType = etFFMpegAC3) or (Encoder.CurrentProcessType = etFFMpegAC3) then
      begin
        // audio decoding
        Result := FFMpegPercentage(Encoder.ConsoleOutput, FloatToStr(FMergeTotalDuration));
      end
      else if Encoder.CurrentProcessType = etQAAC then
      begin
        // qaac
        Result := x264Percentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etOgg then
      begin
        // ogg vorbis
        Result := x264Percentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etSox then
      begin
        // sox
        Result := SoXPercentage(Encoder.ConsoleOutput)
      end
      else if Encoder.CurrentProcessType = etLAME then
      begin
        // lame
        Result := LamePercentage(Encoder.ConsoleOutput)
      end
      else if Encoder.CurrentProcessType = etFLAC then
      begin
        // flac
        Result := FLACPercentage(Encoder.ConsoleOutput)
      end
      else if Encoder.CurrentProcessType = etFHGAAC then
      begin
        // fhg
        Result := MkvExtractPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etOpus then
      begin
        // opus
        Result := OpusPercentage(Encoder.ConsoleOutput, FloatToStr(FMergeTotalDuration));
      end
      else if Encoder.CurrentProcessType = etMPC then
      begin
        // mpc
        Result := MPCPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etAPE then
      begin
        // ape
        DebugMsg('APE : ' + Encoder.ConsoleOutput);
        Result := ApePercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etTTA then
      begin
        // tta
        Result := ApePercentage(Encoder.ConsoleOutput);
        DebugMsg('TTA : ' + Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etTAK then
      begin
        // tak
        Result := TAKPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etNeroAAC then
      begin
        // nero
        Result := NeroPercentage(Encoder.ConsoleOutput, FloatToStr(FMergeTotalDuration));
      end
      else if Encoder.CurrentProcessType = etFFmpegALAC then
      begin
        // alac
        Result := x264Percentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etWMA then
      begin
        // wmaencoder
        Result := WMAEncoderPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etWavPack then
      begin
        // wavpack
        DebugMsg('Wavpack : ' + Encoder.ConsoleOutput);
        Log(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etFDKAAC then
      begin
        // fdkaac
        Result := FDKPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etLossyWAV then
      begin
        // lossywav
        Result := LossyWAVPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etTTagger then
      begin
        // ttagger
        Result := 0;
      end
      else if Encoder.CurrentProcessType = etAACGain then
      begin
        // aacgain
        Result := 0;
      end
      else if Encoder.CurrentProcessType = etDCA then
      begin
        // dcaen
        Result := dcaencPercentage(Encoder.ConsoleOutput);
      end;
    end;
  end;
end;

function TMainForm.GetPercentage(const EncoderIndex: integer): integer;
var
  Encoder: TEncoder;
begin
  Result := 0;
  Encoder := FEncoders[EncoderIndex - 1];
  if Length(Encoder.ConsoleOutput) > 0 then
  begin
    if Encoder.ProcessId > 0 then
    begin
      // DebugMsg('Encoder type: ' + FloatToStr(Ord(Encoder.CurrentProcessType)));
      // decide running process kind
      if (Encoder.CurrentProcessType = etFFMpeg) or (Encoder.CurrentProcessType = etFFMpegAC3) or (Encoder.CurrentProcessType = etFFMpegAC3) then
      begin
        // audio decoding
        Result := FFMpegPercentage(Encoder.ConsoleOutput, Encoder.CurrentDuration);
      end
      else if Encoder.CurrentProcessType = etQAAC then
      begin
        // qaac
        Result := x264Percentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etOgg then
      begin
        // ogg vorbis
        Result := x264Percentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etSox then
      begin
        // sox
        Result := SoXPercentage(Encoder.ConsoleOutput)
      end
      else if Encoder.CurrentProcessType = etLAME then
      begin
        // lame
        Result := LamePercentage(Encoder.ConsoleOutput)
      end
      else if Encoder.CurrentProcessType = etFLAC then
      begin
        // flac
        Result := FLACPercentage(Encoder.ConsoleOutput)
      end
      else if Encoder.CurrentProcessType = etFHGAAC then
      begin
        // fhg
        Result := MkvExtractPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etOpus then
      begin
        // opus
        Result := OpusPercentage(Encoder.ConsoleOutput, Encoder.CurrentDuration);
      end
      else if Encoder.CurrentProcessType = etMPC then
      begin
        // mpc
        Result := MPCPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etAPE then
      begin
        // ape
        DebugMsg('APE : ' + Encoder.ConsoleOutput);
        Result := ApePercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etTTA then
      begin
        // tta
        Result := ApePercentage(Encoder.ConsoleOutput);
        DebugMsg('TTA : ' + Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etTAK then
      begin
        // tak
        Result := TAKPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etNeroAAC then
      begin
        // nero
        Result := NeroPercentage(Encoder.ConsoleOutput, Encoder.CurrentDuration);
      end
      else if Encoder.CurrentProcessType = etFFmpegALAC then
      begin
        // alac
        Result := x264Percentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etWMA then
      begin
        // wmaencoder
        Result := WMAEncoderPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etWavPack then
      begin
        // wavpack
        DebugMsg('Wavpack : ' + Encoder.ConsoleOutput);
        Log(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etFDKAAC then
      begin
        // fdkaac
        Result := FDKPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etLossyWAV then
      begin
        // lossywav
        Result := LossyWAVPercentage(Encoder.ConsoleOutput);
      end
      else if Encoder.CurrentProcessType = etTTagger then
      begin
        // ttagger
        Result := 0;
      end
      else if Encoder.CurrentProcessType = etAACGain then
      begin
        // aacgain
        Result := 0;
      end
      else if Encoder.CurrentProcessType = etDCA then
      begin
        // dcaen
        Result := dcaencPercentage(Encoder.ConsoleOutput);
      end;
    end;
  end
  else
  begin
    DebugMsg('Encoder output is too short, can''t parse it. ' + Encoder.ConsoleOutput);
  end;
end;

function TMainForm.GetTempDirectory: string;
begin
  Result := SystemInfo.Folders.Temp + '\TAudioConverter\';
end;

procedure TMainForm.GetTracks;
var
  i: Integer;
  LTI: TCDTrackInfo;
  LListItem: TListItem;
  LTrackInfo: TTrackInfo;
  LUpperLimit: integer;
  LParams: TDownloadParams;
  LAD: TArtworkDownloader;
begin
  TracksList.Items.Clear;
  WaitPanel.Left := (Self.Width div 2) - (WaitPanel.Width div 2);
  WaitPanel.Top := (Self.Height div 2) - (WaitPanel.Height div 2);
  Self.Enabled := False;
  WaitPanel.Visible := True;
  WaitPanel.BringToFront;
  try
    if DriversList.ItemIndex > -1 then
    begin
      CDIn.CurrentDrive := DriversList.ItemIndex;
      if CDDBInfo.QueryAlbums > 0 then
      begin
        // found
        if (CDin.TracksCount = Length(CDDBInfo.Album.Title)) or (CDIn.TracksCount < Length(CDDBInfo.Album.Title)) then
        begin
          LUpperLimit := CDIn.TracksCount;
        end
        else if CDIn.TracksCount > Length(CDDBInfo.Album.Title) then
        begin
          LUpperLimit := Length(CDDBInfo.Album.Title)
        end;

        // clear
        TracksList.Items.Clear;
        FTrackInfoList.Clear;
        // add tracks to lists
        for i := 1 to LUpperLimit do
        begin
          LTI := CDIn.Tracks[i];

          LListItem := TracksList.Items.Add;
          LListItem.Caption := FloatToStr(i);
          LListItem.SubItems.Add(CDDBInfo.Album.Title[i - 1]);
          LListItem.SubItems.Add(CDDBInfo.Album.Album);
          LListItem.SubItems.Add(CDDBInfo.Album.Artist[i - 1]);
          LListItem.SubItems.Add(PadInteger(LTI.TrackLength.Minute) + ':' + PadInteger(LTI.TrackLength.Second) + ':' + PadInteger(LTI.TrackLength.Frame));
          LListItem.Checked := True;

          with LTrackInfo.TrackTagInfo do
          begin
            Title := CDDBInfo.Album.Title[i - 1];
            Artist := CDDBInfo.Album.Artist[i - 1];
            Album := CDDBInfo.Album.Album;
            TrackNo := FloatToStr(i);
            AlbumArtist := CDDBInfo.Album.AlbumArtist;
            Date := CDDBInfo.Album.Year;
            Genre := CDDBInfo.Album.Genre;
            Comment := CDDBInfo.Album.Comment;
          end;
          LTrackInfo.TempFileName := SettingsForm.TempEdit.Text + '\' + FloatToStr(i) + '.wav';
          LTrackInfo.TrackState := tsWaiting;
          LTrackInfo.Index := i;
          LTrackInfo.Duration := LTI.TrackLength.Minute * 60 + LTI.TrackLength.Second;

          FTrackInfoList.Add(LTrackInfo);
        end;
      end
      else
      begin
        // not found tags. use unkown
        TracksList.Items.Clear;
        FTrackInfoList.Clear;

        for i := 1 to CDIn.TracksCount do
        begin
          LTI := CDIn.Tracks[i];

          LListItem := TracksList.Items.Add;
          LListItem.Caption := FloatToStr(i);
          LListItem.SubItems.Add('Unkown');
          LListItem.SubItems.Add('Unkown');
          LListItem.SubItems.Add('Unkown');
          LListItem.SubItems.Add(PadInteger(LTI.TrackLength.Minute) + ':' + PadInteger(LTI.TrackLength.Second) + ':' + PadInteger(LTI.TrackLength.Frame));
          LListItem.Checked := True;

          with LTrackInfo.TrackTagInfo do
          begin
            Title := 'Unkown';
            Artist := 'Unkown';
            Album := 'Unkown';
            TrackNo := FloatToStr(i);
            AlbumArtist := 'Unkown';
            Date := 'Unkown';
            Genre := 'Unkown';
            Comment := '';
          end;
          LTrackInfo.TempFileName := SettingsForm.TempEdit.Text + '\' + FloatToStr(i) + '.wav';
          LTrackInfo.TrackState := tsWaiting;
          LTrackInfo.Index := i;
          LTrackInfo.Duration := LTI.TrackLength.Minute * 60 + LTI.TrackLength.Second;

          FTrackInfoList.Add(LTrackInfo);
        end;
      end;

      // download album cover
      // delete previous one
      if FileExists(SystemInfo.Folders.Temp + '\cdcover.jpg') then
      begin
        DeleteFile(SystemInfo.Folders.Temp + '\cdcover.jpg')
      end;
      CoverImg.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\cd.png');
      if SettingsForm.CDDownloadCoverBtn.Checked then
      begin
        // album and artist
        if TracksList.Items.Count > 0 then
        begin
          LParams.Album := CDDBInfo.Album.Album;
          LParams.Artist := CDDBInfo.Album.AlbumArtist;
          // image resize thing
          LParams.Resize := SettingsForm.ResizeArtworkbtn.Checked;
          LParams.Width := StrToInt(SettingsForm.WidthEdit.Text);
          LParams.Height := StrToInt(SettingsForm.HeightEdit.Text);
          LAD := TArtworkDownloader.Create(LParams);
          try
            LAD.Start;
            LAD.ImagePath := SystemInfo.Folders.Temp + '\cdcover.jpg';
            while (LAD.Status = downloading) do
            begin
              Application.ProcessMessages;
              Sleep(20);
            end;
            // incase of an error
            if LAD.Status = error then
            begin
              Application.MessageBox(PChar('Cover art downloader error code: ' + FloatToStr(LAD.ErrorCode) + #13#10 + 'Error message: ' + LAD.DownloaderErrorMsg), 'Error', MB_ICONERROR);
            end
            else
            begin
              // set cdcover.jpg as cover art
              if FileExists(SystemInfo.Folders.Temp + '\cdcover.jpg') then
              begin
                // load to image
                try
                  CoverImg.Picture.LoadFromFile(SystemInfo.Folders.Temp + '\cdcover.jpg');
                except
                  on E: Exception do
                    CoverImg.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\cd.png');
                end;
                // assign this image to all tracks
                for i := 0 to FTrackInfoList.Count - 1 do
                begin
                  LTrackInfo := FTrackInfoList[i];
                  LTrackInfo.TrackTagInfo.CoverPath := SystemInfo.Folders.Temp + '\cdcover.jpg';
                  FTrackInfoList[i] := LTrackInfo;
                end;
              end;
            end;
          finally
            LAD.Free;
          end;
        end;
      end;
    end
    else
    begin
      Application.MessageBox('Couldn''t find any drivers.', 'Error', MB_ICONERROR);
    end;
  finally
    WaitPanel.Visible := False;
    Self.Enabled := True;
  end;

end;

procedure TMainForm.InfoBtnClick(Sender: TObject);
var
  index: Integer;
  Litem: TListItem;
begin
  index := FileList.ItemIndex;

  if index > -1 then
  begin
    GetFullInfo(Files[index]);
    // display tags
    with TagsList[index] do
    begin
      with InfoForm do
      begin
        Litem := TagList.Items.Add;
        Litem.Caption := 'Title';
        Litem.SubItems.Add(Title);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Artist';
        Litem.SubItems.Add(Artist);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Album';
        Litem.SubItems.Add(Album);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Genre';
        Litem.SubItems.Add(Genre);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Date';
        Litem.SubItems.Add(RecordDate);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Comment';
        Litem.SubItems.Add(Comment);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Performer';
        Litem.SubItems.Add(Performer);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Composer';
        Litem.SubItems.Add(Composer);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Track';
        Litem.SubItems.Add(TrackNo);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Total Track';
        Litem.SubItems.Add(TrackTotal);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Disc';
        Litem.SubItems.Add(DiscNo);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Total Disc';
        Litem.SubItems.Add(DiscTotal);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Album Artist';
        Litem.SubItems.Add(AlbumArtist);

        Litem := TagList.Items.Add;
        Litem.Caption := 'TitleSort';
        Litem.SubItems.Add(NameSort);

        Litem := TagList.Items.Add;
        Litem.Caption := 'AlbumSort';
        Litem.SubItems.Add(AlbumSort);

        Litem := TagList.Items.Add;
        Litem.Caption := 'AlbumArtistSort';
        Litem.SubItems.Add(AlbumArtistSort);

        Litem := TagList.Items.Add;
        Litem.Caption := 'ComposerSort';
        Litem.SubItems.Add(ComposerSort);

        Litem := TagList.Items.Add;
        Litem.Caption := 'AlbumComposer';
        Litem.SubItems.Add(AlbumComposer);

        Litem := TagList.Items.Add;
        Litem.Caption := 'Artwork type';
        Litem.SubItems.Add(CoverImageType);
      end;
    end;
    InfoForm.show;
  end;
end;

function TMainForm.IntToTime(IntTime: Integer): string;
var
  hour: Integer;
  Second: Integer;
  Minute: Integer;
  strhour: string;
  strminute: string;
  strsecond: string;
begin

  if (Time > 0) then
  begin

    hour := IntTime div 3600;
    Minute := (IntTime div 60) - (hour * 60);
    Second := (IntTime mod 60);

    if (Second < 10) then
    begin
      strsecond := '0' + FloatToStr(Second);
    end
    else
    begin
      strsecond := FloatToStr(Second);
    end;

    if (Minute < 10) then
    begin
      strminute := '0' + FloatToStr(Minute);
    end
    else
    begin
      strminute := FloatToStr(Minute);
    end;

    if (hour < 10) then
    begin
      strhour := '0' + FloatToStr(hour);
    end
    else
    begin
      strhour := FloatToStr(hour);
    end;

    Result := strhour + ':' + strminute + ':' + strsecond;
  end
  else
  begin
    Result := '00:00:00';
  end;

end;

function TMainForm.IsAACFileALAC(const FileName: string): Boolean;
var
  MediaInfoHandle: Cardinal;
  FormatStr: string;
begin

  Result := False;

  if (FileExists(FileName)) and ((LowerCase(ExtractFileExt(FileName)) = '.m4a') or (LowerCase(ExtractFileExt(FileName)) = '.m4b') or (LowerCase(ExtractFileExt(FileName)) = '.aac') or (LowerCase(ExtractFileExt(FileName)) = '.mp4')) then
  begin

    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();

    if MediaInfoHandle <> 0 then
    begin

      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
        MediaInfo_Option(0, 'Complete', '1');

        // get format
        FormatStr := MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'Format', Info_Text, Info_Name);

        if Length(FormatStr) < 1 then
        begin
          if Length(Trim(FormatStr)) < 1 then
          begin
            FormatStr := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Format', Info_Text, Info_Name);
          end;
        end;

        if LowerCase(FormatStr) = 'alac' then
        begin
          Result := True;
        end
        else
        begin
          Result := False;
        end;
      finally
        MediaInfo_Close(MediaInfoHandle);
      end;

    end;

  end;
end;

function TMainForm.IsAudioOnly(const FileName: string): Boolean;
var
  MediaInfoHandle: Cardinal;
  VideoCount: string;
begin

  Result := False;

  if (FileExists(FileName)) then
  begin

    // avs file exception
    if LowerCase(ExtractFileExt(FileName)) = '.avs' then
    begin
      Result := False;
    end
    else
    begin
      // New handle for mediainfo
      MediaInfoHandle := MediaInfo_New();

      if MediaInfoHandle <> 0 then
      begin

        try
          // Open a file in complete mode
          MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
          MediaInfo_Option(0, 'Complete', '1');

          VideoCount := Trim(MediaInfo_Get(MediaInfoHandle, Stream_Video, 0, 'Count', Info_Text, Info_Name));

          if IsStringNumeric(VideoCount) then
          begin
            if StrToInt(VideoCount) > 0 then
            begin
              Result := False;
            end
            else
            begin
              Result := True;
            end;
          end
          else
          begin
            Result := True;
          end;

        finally
          MediaInfo_Close(MediaInfoHandle);
        end;

      end;

    end;

  end;

end;

function TMainForm.IsHEv2Selected: Boolean;
begin
  Result := False;
  if (FAudioEncoderType = etFDKAAC) then
  begin
    if CodecSettingsForm.FDKProfileList.ItemIndex = 2 then
    begin
      Result := True;
    end;
  end
  else if (FAudioEncoderType = etNeroAAC) then
  begin
    if CodecSettingsForm.NeroProfileList.ItemIndex = 3 then
    begin
      Result := True;
    end;
  end
  else if (FAudioEncoderType = etFHGAAC) then
  begin
    if CodecSettingsForm.FHGProfileList.ItemIndex = 3 then
    begin
      Result := True;
    end;
  end;
end;

function TMainForm.IsSourceLossless(const FileName: string): Boolean;
var
  Ext: string;
begin
  Ext := LowerCase(ExtractFileExt(FileName));
  Result := (Ext = '.flac') or (Ext = '.ape') or (Ext = '.tak') or (Ext = '.tta') or (Ext = '.wv') or (Ext = '.shn') or IsAACFileALAC(FileName);
end;

function TMainForm.IsStringNumeric(Str: string): Boolean;
var
  P: PChar;
begin

  if Length(Str) < 1 then
  begin
    Result := False;
    Exit;
  end;

  P := PChar(Str);
  Result := False;

  while P^ <> #0 do
  begin
    Application.ProcessMessages;

    if (not CharInSet(P^, ['0'..'9'])) then
    begin
      Exit;
    end;

    Inc(P);
  end;

  Result := True;
end;

function TMainForm.LamePercentage(const LameOutput: string): Integer;
var
  pos1: Integer;
  pos2: Integer;
  prog: string;
  Tmp: string;
begin
  Result := 0;
  if (Length(LameOutput) > 0) then
  begin
    Tmp := LameOutput;

    pos1 := Pos('(', Trim(Tmp));
    pos2 := Pos('%', Trim(Tmp));
    prog := Trim(Copy(Tmp, pos1 + 1, (pos2 - pos1 - 1)));

    if IsStringNumeric(prog) then
    begin
      Result := StrToInt(prog);
    end;
  end;
end;

procedure TMainForm.LaunchProcesses(const ProcessCount: integer);
var
  i: Integer;
begin

  for i := 0 to ProcessCount - 1 do
  begin
    FEncoders[i].Start;
  end;

end;

procedure TMainForm.LoadDrivers;
var
  i: Integer;
begin
  DriversList.Items.Clear;
  try
    if CDIn.DrivesCount > 0 then
    begin
      for i := 0 to CDIn.DrivesCount - 1 do
      begin
        CDIn.CurrentDrive := i;
        DriversList.Items.Add(CDIn.DriveName);
      end;
      if DriversList.Items.Count > 0 then
      begin
        DriversList.ItemIndex := 0;
        CDIn.CurrentDrive := 0;
      end;
    end;
  except
    on E: Exception do


  end;
end;

procedure TMainForm.LoadOptions;
var
  SettingsFile: TIniFile;
  SkinIndex: integer;
  LDummy: Boolean;
begin

  SettingsFile := TIniFile.Create(AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin
      DirectoryEdit.Text := ReadString('Settings', 'OutDir', MyDoc);
      // if dest. folder doesn't exist
      // set appdir as dest in portable version.
      if Portable and ReadBool('settings', 'deleteinvalidoutput', True) then
      begin
        if not DirectoryExists(DirectoryEdit.Text) then
        begin
          DirectoryEdit.Text := ExtractFileDir(Application.ExeName);
        end;
      end;
      AudioCodecList.ItemIndex := ReadInteger('Settings', 'Codec', 6);
      AudioMethodList.ItemIndex := ReadInteger('Settings', 'AudioMethod', 0);
      SameAsSourceBtn.Checked := ReadBool('Settings', 'SameAsSource', False);
      FLastDirectory := ReadString('Settings', 'LastDir', SystemInfo.Folders.Personal);
      PostEncodeList.ItemIndex := ReadInteger('Settings', 'Post', 0);
      SkinIndex := ReadInteger('Settings', 'Skin', 2);
      VolumeBar.Position := ReadInteger('settings', 'volume', 50);
      ProfilesList.ItemIndex := ReadInteger('settings', 'profile2', 0);
      EncodeModePages.ActivePageIndex := ReadInteger('seetings', 'modesliderindex', 0);
      ModeSelectionList.ItemIndex := EncodeModePages.ActivePageIndex;

      // stay on top
      if ReadBool('settings', 'ontop', False) then
      begin
        MainForm.FormStyle := fsStayOnTop;
        SettingsForm.FormStyle := fsStayOnTop;
        AboutForm.FormStyle := fsStayOnTop;
        InfoForm.FormStyle := fsStayOnTop;
        LogForm.FormStyle := fsStayOnTop;
        ProgressForm.FormStyle := fsStayOnTop;
        FiltersForm.FormStyle := fsStayOnTop;
        TagForm.FormStyle := fsStayOnTop;
        UpdaterForm.FormStyle := fsStayOnTop;
      end
      else
      begin
        MainForm.FormStyle := fsNormal;
        SettingsForm.FormStyle := fsNormal;
        AboutForm.FormStyle := fsNormal;
        InfoForm.FormStyle := fsNormal;
        LogForm.FormStyle := fsNormal;
        ProgressForm.FormStyle := fsNormal;
        FiltersForm.FormStyle := fsNormal;
        TagForm.FormStyle := fsNormal;
        UpdaterForm.FormStyle := fsNormal;
      end;

      if ReadBool('settings', 'extracol', True) then
      begin
        with MainForm.FileList do
        begin
          Columns[3].Width := 80;
          Columns[4].Width := 80;
          Columns[5].Width := 80;
          Columns[6].Width := 80;
        end;
      end
      else
      begin
        with MainForm.FileList do
        begin
          Columns[3].Width := 0;
          Columns[4].Width := 0;
          Columns[5].Width := 0;
          Columns[6].Width := 0;
        end;
      end;

    end;

  finally
    SettingsFile.Free;
    SameAsSourceBtn.OnClick(Self);
    AudioCodecListChange(Self);
    AudioMethodListChange(Self);
    sSkinManager1.SkinName := sSkinManager1.InternalSkins[SkinIndex].Name;
  end;
end;

procedure TMainForm.LoadPresets;
var
  LPresetFolder: string;
  LPreset: TPreset;
  lSearchRec: TSearchRec;
  lFind: integer;
begin
  LPresetFolder := ExtractFileDir(Application.ExeName) + '\profiles\';
  try
    lFind := FindFirst(LPresetFolder + '*.ini', faAnyFile, lSearchRec);
    while lFind = 0 do
    begin
      LPreset := TPreset.Create;
      LPreset.ReadIni(LPresetFolder + lSearchRec.Name);
      FPresets.Add(LPreset);
      ProfilesList.Items.Add(LPreset.ListName);
      lFind := SysUtils.FindNext(lSearchRec);
    end;
  finally
    FindClose(lSearchRec);
  end;
end;

procedure TMainForm.Log(const MSG: string);
begin
  LogForm.OutputList.Lines.Add(MSG);
end;

procedure TMainForm.LogsBtnClick(Sender: TObject);
begin

  LogForm.show;

end;

function TMainForm.LossyWAVPercentage(const LossyWAVOutput: string): integer;
const
  Progress = 'Progress  :';
var
  TmpStr: string;
  ProgressInt: integer;
begin
  Result := 0;
  if Length(LossyWAVOutput) > 0 then
  begin
    TmpStr := LossyWAVOutput;
    if Progress = Copy(TmpStr, 0, Length(Progress)) then
    begin
      Delete(TmpStr, 1, Length(Progress));
      TmpStr := Copy(TmpStr, 1, 3);
      if TryStrToInt(Trim(TmpStr), ProgressInt) then
      begin
        Result := ProgressInt;
      end;
    end;
  end;
end;

procedure TMainForm.MainSummarListDblClick(Sender: TObject);
begin
  if AudioMethodList.ItemIndex = 0 then
  begin
    CodecSettingsBtnClick(Self);
  end;
end;

procedure TMainForm.MergeTimerTimer(Sender: TObject);
var
  TotalProgress: integer;
  EncodingSpeed: Extended;
  LProcessProgress: Integer;
begin

  LProcessProgress := GetMergeProgress;
  TotalProgress := (100 * FMergeProcess.FilesDone) div FMergeProcess.CommandCount + (LProcessProgress div FMergeProcess.CommandCount);
  MainForm.Caption := FloatToStr(TotalProgress) + '% [TAudioConverter]';
  MergeProgressBar.Position := TotalProgress;
  MergePanel.Caption := FMergeProcess.Info + ' (' + FloatToStr(LProcessProgress) + '%)';
  SetProgressValue(Self.Handle, TotalProgress, 100);

  if FMergeProcess.FilesDone = FMergeProcess.CommandCount then
  begin
    MergeTimer.Enabled := False;
    Self.Caption := 'TAudioConverter';

    TotalProgressBar.Position := 0;
    SetProgressValue(Self.Handle, 0, 100);
    SetProgressState(Self.Handle, tbpsNone);
    Timer.Enabled := False;
    TimeEdit.Text := '00:00:00';

    if SettingsForm.PlayWavBtn.Checked then
    begin
      if FileExists(ExtractFileDir(Application.ExeName) + '\done.wav') then
      begin
        sndPlaySound('done.wav', SND_ASYNC);
      end;
    end;
    SaveLogs;
    EnableUI;

    // clear the list after an encode
    if SettingsForm.ClrListAfterEncodeBtn.Checked then
    begin
      FileList.Items.Clear;
      AudioTracks.Clear;
      AudioIndexes.Clear;
      AudioTrackList.Items.Clear;
      Files.Clear;
      Durations.Clear;
      ExtensionsForCopy.Clear;
      CopyExtension.Clear;
      StartPositions.Clear;
      EndPositions.Clear;
      ConstantDurations.Clear;
      TagsList.Clear;
      FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
      ;
    end;

    DeleteTempFiles(False);

    // post-encode action
    case PostEncodeList.ItemIndex of
      0:
        begin

          // checks if all the output files created
          if CheckOutputFiles then
          begin
            // calculate encoding speed
            if FTimePassed <= 0 then
            begin
              FTimePassed := 1;
            end;
            EncodingSpeed := FTotalLength / FTimePassed;
            TrayIcon.Active := True;
            TrayIcon.BalloonHint('TAudioConverter', 'TAudioConverter converted files with speed of x' + FormatFloat('#,##', EncodingSpeed) + ' (Converted ' + IntToTime(FTotalLength) + ' in ' + IntToTime(FTimePassed) + ').', btInfo, 5000);

            AddToLog(0, 'TAudioConverter converted files with speed x' + FormatFloat('#,##', EncodingSpeed) + ' (Converted ' + IntToTime(FTotalLength) + ' in ' + IntToTime(FTimePassed) + ').');
            AddToLog(0, '');
          end;
          SaveOptions;
          CompressionPercentages;
        end;
      1:
        begin
          SaveOptions;
          Application.Terminate;
        end;
      2:
        begin
          SaveOptions;
          CompressionPercentages;
          if not SameAsSourceBtn.Checked then
          begin
            if (DirectoryExists(DirectoryEdit.Text)) then
            begin
              ShellExecute(Application.Handle, 'open', PChar(DirectoryEdit.Text), nil, nil, SW_SHOWNORMAL);
            end
            else
            begin
              Application.MessageBox('Cannot open output folder because it does not exist!', 'Error', MB_ICONERROR);
            end;
          end;
        end;
      3:
        begin
          SaveOptions;
          ShutDown(EWX_SHUTDOWN or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
      4:
        begin
          SaveOptions;
          ShutDown(EWX_REBOOT or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
      5:
        begin
          SaveOptions;
          ShutDown(EWX_LOGOFF or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
    end;
    FTimePassed := 0;
  end;
end;

function TMainForm.MkvExtractPercentage(const MkvExtractOutput: string): Integer;
var
  TmpInt: Integer;
  FConsoleOutput: string;
begin
  Result := 0;
  FConsoleOutput := Trim(MkvExtractOutput);
  if Length(FConsoleOutput) > 0 then
  begin

    if Copy(FConsoleOutput, 0, 9) = 'Progress:' then
    begin
      FConsoleOutput := Trim(ReplaceStr(FConsoleOutput, '%', ''));
      FConsoleOutput := Trim(Copy(FConsoleOutput, 10, MaxInt));

      if TryStrToInt(FConsoleOutput, TmpInt) then
      begin
        Result := TmpInt;
      end;
    end;
  end;
end;

procedure TMainForm.ModeSelectionListChange(Sender: TObject);
begin
  EncodeModePages.ActivePageIndex := ModeSelectionList.ItemIndex;
  case EncodeModePages.ActivePageIndex of
    0:
      begin

      end;
    1:
      begin

      end;
  end;
end;

function TMainForm.MPCPercentage(const MPCOutput: string): integer;
var
  PercentStr: string;
begin
  Result := 0;
  if Length(MPCOutput) > 0 then
  begin
    PercentStr := Trim(Copy(MPCOutput, 1, 3));
    if IsStringNumeric(PercentStr) then
    begin
      if PercentStr = '100' then
      begin
        Result := 100;
      end;
    end
    else
    begin
      PercentStr := Trim(Copy(MPCOutput, 1, 2));
      if IsStringNumeric(PercentStr) then
      begin
        Result := StrToInt(PercentStr);
      end;
    end;
  end;
end;

function TMainForm.NeroPercentage(const NeroOutput: string; const DurationStr: string): integer;
var
  FConsoleOutput: string;
begin
  Result := 0;
  FConsoleOutput := Trim(NeroOutput);
  if Length(FConsoleOutput) > 0 then
  begin
    FConsoleOutput := Trim(ReplaceStr(FConsoleOutput, 'Processed', ''));
    FConsoleOutput := Trim(ReplaceStr(FConsoleOutput, 'seconds...', ''));
    FConsoleOutput := Trim(FConsoleOutput);
    // form1.Caption := FloatToStr(DurationIndex);
    if IsStringNumeric(FConsoleOutput) then
    begin
      if (StrToInt(DurationStr) > 0) then
      begin
        Result := (100 * StrToInt(FConsoleOutput)) div StrToInt(DurationStr);
      end;
    end
  end;
end;

procedure TMainForm.NextCodecBtnClick(Sender: TObject);
begin
  if AudioCodecList.ItemIndex < (AudioCodecList.Items.Count - 1) then
  begin
    AudioCodecList.ItemIndex := AudioCodecList.ItemIndex + 1;
    AudioCodecListChange(Self);
  end;
end;

procedure TMainForm.OpenDirectory1Click(Sender: TObject);
var
  FileDir: string;
  index: Integer;
begin

  index := FileList.ItemIndex;

  if index > -1 then
  begin
    FileDir := ExtractFileDir(Files[index]);

    if DirectoryExists(FileDir) then
    begin
      ShellExecute(Handle, 'open', 'explorer', PChar(' /n,/select, ' + '"' + Files[index] + '"'), nil, SW_SHOWNORMAL);
    end;
  end;
end;

function TMainForm.OpusPercentage(const OpusOutput: string; const DurationStr: string): integer;
var
  StrPos1, StrPos2: integer;
  PercentStr: string;
  PositionInt: integer;
begin
  Result := 0;
  if Length(OpusOutput) > 0 then
  begin
    StrPos1 := Pos(']', OpusOutput);
    StrPos2 := Pos('.', OpusOutput);

    PercentStr := Trim(Copy(OpusOutput, StrPos1 + 1, StrPos2 - StrPos1 - 1));
    PercentStr := IntToStr(TimeToInt(PercentStr));
    PositionInt := StrToInt(PercentStr);

    if IsStringNumeric(DurationStr) then
    begin
      if (StrToInt(DurationStr) > 0) then
      begin
        Result := (100 * PositionInt) div StrToInt(DurationStr);
      end;
    end;
  end;
end;

procedure TMainForm.OutputBtnClick(Sender: TObject);
begin

  if (DirectoryExists(DirectoryEdit.Text)) then
  begin
    ShellExecute(Application.Handle, 'open', PChar(DirectoryEdit.Text), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    Application.MessageBox('Cannot open output folder because it does not exist!', 'Error', MB_ICONERROR);
  end;

end;

function TMainForm.PadInteger(const Int: integer): string;
begin
  Result := IntToStr(Int);
  if Int < 10 then
  begin
    Result := '0' + IntToStr(Int)
  end;
end;

function TMainForm.PadString(const Str: string): string;
var
  LTmpStr: string;
begin
  LTmpStr := Str;
  Delete(LTmpStr, 1, 2);
  Result := LTmpStr;
  if Length(LTmpStr) = 1 then
  begin
    Result := LTmpStr + '00';
  end
  else if Length(LTmpStr) = 2 then
  begin
    Result := LTmpStr + '0';
  end
  else if Length(LTmpStr) = 0 then
  begin
    Result := '000';
  end;
  if Length(Result) > 3 then
  begin
    Result := Copy(Result, 1, 3);
  end;
end;

function TMainForm.PadString2(const Str: string): string;
begin
  Result := Str;
  if Length(Str) = 1 then
  begin
    Result := '0' + Str;
  end
end;

function TMainForm.PadTrackIndex(const TrackNo: integer): string;
begin
  Result := FloatToStr(TrackNo);
  if TrackNo < 10 then
  begin
    Result := '0' + FloatToStr(TrackNo)
  end;
end;

function TMainForm.ParseFolderStr(const FolderStr: string; const FileName: string; const FileIndex: Integer): string;
var
  Title, Artist, Album, TrackNo, Genre, Date, Performer, DiskNo, AlbumArtist: string;
  FFolderStr: string;
  OutputStr: string;
  LFTotalLength: integer;
begin
  Result := ExtractFileName(FileName);

  if (Length(FolderStr) > 0) then
  begin
    OutputStr := '';
    if (FileExists(FileName)) then
    begin

      // initial values
      Title := 'unknown';
      Artist := 'unknown';
      Album := 'unknown';
      TrackNo := 'unknown';
      Genre := 'unknown';
      Date := 'unknown';
      Performer := 'unknown';
      DiskNo := 'unknown';
      AlbumArtist := 'unknown';

      if TagForm.UseValuesBtn.Checked then
      begin
        // read tags from tagform
        Artist := TagForm.ArtistEdit.Text;
        Album := TagForm.AlbumEdit.Text;
        Genre := TagForm.GenreEdit.Text;
        Performer := TagForm.PerformerEdit.Text;
        Date := TagForm.DateEdit.Text;
      end
      else
      begin
        Title := TagsList[FileIndex].TitleForFileName;
        Artist := TagsList[FileIndex].ArtistForFileName;
        Album := TagsList[FileIndex].AlbumForFileName;
        TrackNo := TagsList[FileIndex].TrackNo;
        Genre := TagsList[FileIndex].Genre;
        Performer := TagsList[FileIndex].Performer;
        Date := TagsList[FileIndex].RecordDate;
        DiskNo := TagsList[FileIndex].DiscNo;
        AlbumArtist := TagsList[FileIndex].AlbumArtist;
      end;

      Title := Trim(Title);
      Artist := Trim(Artist);
      Album := Trim(Album);
      TrackNo := Trim(TrackNo);
      Genre := Trim(Genre);
      Performer := Trim(Performer);
      Date := Trim(Date);
      DiskNo := Trim(DiskNo);
      TrackNo := PadString2(TrackNo);
      DiskNo := PadString2(DiskNo);
      AlbumArtist := Trim(RemoveInvalidChars(AlbumArtist));

      if (Length(Artist) < 1) then
      begin
        if Length(Performer) > 0 then
        begin
          Artist := Performer;
        end;
      end;
      if Length(AlbumArtist) < 1 then
      begin
        AlbumArtist := Artist;
      end;

{$REGION 'FEncodersuffix'}
      // folder may need encoder suffix to it
      if SettingsForm.FolderSuffixBtn.Checked then
      begin
        case FAudioEncoderType of
          etFFMpegAAC:
            begin
              Result := (FFolderStr) + '_FFMpegAAC';
            end;
          etQAAC:
            begin
              Result := (FFolderStr) + '_Qaac';
            end;
          etFFMpegAC3:
            begin
              Result := (FFolderStr) + '_AC3';
            end;
          etOgg:
            begin
              Result := (FFolderStr) + '_OggVorbis';
            end;
          etLAME:
            begin
              Result := (FFolderStr) + '_Lame';
            end;
          etWAV:
            begin
              Result := (FFolderStr) + '_WAV';
            end;
          etFLAC:
            begin
              Result := (FFolderStr) + '_FLAC';
            end;
          etFHGAAC:
            begin
              Result := (FFolderStr) + '_FHGAAC';
            end;
          etOpus:
            begin
              Result := (FFolderStr) + '_Opus';
            end;
          etMPC:
            begin
              Result := (FFolderStr) + '_MPC';
            end;
          etAPE:
            begin
              Result := (FFolderStr) + '_APE';
            end;
          etTTA:
            begin
              Result := (FFolderStr) + '_TTA';
            end;
          etTAK:
            begin
              Result := (FFolderStr) + '_TAK';
            end;
          etNeroAAC:
            begin
              Result := (FFolderStr) + '_NEROAAC';
            end;
          etFFmpegALAC:
            begin
              Result := (FFolderStr) + '_ALAC';
            end;
          etWMA:
            begin
              Result := (FFolderStr) + '_WMA';
            end;
          etWavPack:
            begin
              Result := (FFolderStr) + '_WavPack';
            end;
          etFDKAAC:
            begin
              Result := (FFolderStr) + '_FDKAAC';
            end;
          etAIFF:
            begin
              Result := (FFolderStr) + '_AIFF';
            end;
          etFLACCL:
            begin
              Result := (FFolderStr) + '_FLACCL';
            end;
          etDCA:
            begin
              Result := FFolderStr + '_DCAENC';
            end;
        end;
      end;
{$ENDREGION}
      // make sure string is not empty
      LFTotalLength := Length(Title) + Length(Artist) + Length(Album) + Length(Genre) + Length(Date) + Length(TrackNo) + Length(DiskNo);
      if LFTotalLength > 0 then
      begin
        // replace strings
        OutputStr := FolderStr;
        OutputStr := ReplaceText(OutputStr, '%title%', Title);
        OutputStr := ReplaceText(OutputStr, '%artist%', Artist);
        OutputStr := ReplaceText(OutputStr, '%album%', Album);
        OutputStr := ReplaceText(OutputStr, '%genre%', Genre);
        OutputStr := ReplaceText(OutputStr, '%date%', Date);
        OutputStr := ReplaceText(OutputStr, '%tracknumber%', TrackNo);
        OutputStr := ReplaceText(OutputStr, '%discnumber%', DiskNo);
        OutputStr := ReplaceText(OutputStr, '%albumartist%', AlbumArtist);

        Result := Trim(OutputStr);
        DebugMsg('Output file name: ' + OutputStr);
      end
      else
      begin
        DebugMsg('output short');
      end;

    end;

  end
  else
  begin
    Result := '\';
  end;

end;

procedure TMainForm.PauseBtnClick(Sender: TObject);
begin
  if FPlayer.PlayerStatus = psPlaying then
  begin
    FPlayer.Pause;
    PlaybackTimer.Enabled := False;
    SetProgressState(Handle, tbpsPaused);
  end
  else if FPlayer.PlayerStatus = psPaused then
  begin
    FPlayer.Resume;
    FPlayer.SetVolume(VolumeBar.Position);
    PlaybackTimer.Enabled := True;
    SetProgressState(Handle, tbpsNormal);
  end;
end;

procedure TMainForm.Play1Click(Sender: TObject);
var
  index: Integer;
begin
  index := FileList.ItemIndex;
  if index > -1 then
  begin
    if (FPlaybackIndex > -1) and (FPlaybackIndex < FileList.Items.Count) then
    begin
      FileList.Items[FPlaybackIndex].StateIndex := FPrevStateIndex;
    end;

    if PlayItem(index) = MY_ERROR_UNKOWN_FORMAT then
    begin
      ShellExecute(Application.Handle, 'open', PChar(Files[index]), nil, nil, SW_SHOWNORMAL);
    end;
  end;
end;

procedure TMainForm.PlaybackTimerTimer(Sender: TObject);
begin
  if FPlayer.ReachedEnd then
  begin
    PlaybackTimer.Enabled := False;
    FPlayer.Stop;
    PositionBar.Position := 0;
    PositionLabel.Caption := '00:00:00/00:00:00';
    SetProgressValue(Handle, 0, PositionBar.Max);
    if (FileList.Items.Count > 0) and (FPlaybackIndex < FileList.Items.Count) then
    begin
      FileList.Items[FPlaybackIndex].StateIndex := FPrevStateIndex;
    end;
    FPlaybackIndex := -1;
    Exit;
  end;

  case FPlayer.PlayerStatus2 of
    psPlaying:
      begin
        PositionBar.Position := (MaxInt * FPlayer.Position) div FPlayer.TotalLength;
        SetProgressValue(Handle, PositionBar.Position, PositionBar.Max);
        PositionLabel.Caption := FPlayer.PositionStr + '/' + FPlayer.IntToTime(FPlayer.EndPoint);
      end;
    psPaused:
      ;
    psStopped:
      begin
        PositionTimer.Enabled := False;
        PositionLabel.Caption := '00:00:00/00:00:00';
        SetProgressValue(Handle, 0, PositionBar.Max);
        PositionBar.Position := 0;
        FileList.Items[FPlaybackIndex].StateIndex := FPrevStateIndex;
        FPlaybackIndex := -1;
      end;
    psStalled:
      ;
    psUnkown:
      ;
  end;
end;

function TMainForm.PlayItem(const ItemIndex: Integer): integer;
begin
  if FPlayer.ErrorMsg = MY_ERROR_OK then
  begin
    FPlaybackIndex := ItemIndex;
    FPrevStateIndex := FileList.Items[ItemIndex].StateIndex;
    FPlayer.FileName := Files[ItemIndex];
    FPlayer.StartPoint := StrToInt(StartPositions[ItemIndex]) div 1000;
    FPlayer.EndPoint := StrToInt(EndPositions[ItemIndex]) div 1000;
    // FPlaybackDuration :=
    FileList.Items[ItemIndex].StateIndex := 4;
    FPlayer.Play;
    FPlaybackDuration := (StrToInt(EndPositions[ItemIndex]) - StrToInt(StartPositions[ItemIndex])) div 1000;
    FPlayer.SetVolume(VolumeBar.Position);
    Result := FPlayer.ErrorMsg;
    if FPlayer.ErrorMsg = MY_ERROR_OK then
    begin
      PlaybackTimer.Enabled := True;
      SetProgressState(Handle, tbpsNormal);
      PositionBar.Position := 0;
      PositionBar.Max := MaxInt;
      PositionLabel.Caption := '00:00:00/' + FPlayer.IntToTime(StrToInt(EndPositions[ItemIndex]));
    end;
  end
  else
  begin
    Result := FPlayer.ErrorMsg
  end;
end;

procedure TMainForm.PositionBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewTractBarPosition: Integer;
begin
  if FPlayer.PlayerStatus2 = psPlaying then
  begin
    NewTractBarPosition := Round((X / PositionBar.ClientWidth) * MaxInt);

    if (NewTractBarPosition <> PositionBar.Position) then
    begin
      PositionBar.Position := NewTractBarPosition;
      PlaybackTimer.Enabled := False;
      FPlayer.Pause;
      try
        if not FPlayer.SetPosition((FPlayer.TotalLength * PositionBar.Position) div MaxInt) then
        begin
          PositionBar.Position := FPlayer.Position;
        end;
      finally
        Sleep(50);
        PlaybackTimer.Enabled := True;
        FPlayer.Resume;
      end;
    end;
  end;
end;

procedure TMainForm.PositionTimerTimer(Sender: TObject);
var
  LAllDone: Boolean;
  LEncodingSpeed: Extended;
begin
  MainForm.Caption := FloatToStr((100 * TotalProgressBar.Position) div TotalProgressBar.Max) + '% [TAudioConverter]';
  SetProgressValue(Self.Handle, TotalProgressBar.Position, TotalProgressBar.Max);

  // done all
  LAllDone := False;
  LAllDone := TotalProgressBar.Position = FTotalCMDCount;

  if LAllDone then
  begin
    // for merging start a seperate process
    // and timer.
    if AudioMethodList.ItemIndex = 2 then
    begin
      PositionTimer.Enabled := False;
      MergePanel.Left := (Self.Width div 2) - (MergePanel.Width div 2);
      MergePanel.Top := (Self.Height div 2) - (MergePanel.Height div 2);
      MergeProgressBar.Max := 100;
      MergeProgressBar.Position := 0;
      MergePanel.Visible := True;
      MergePanel.BringToFront;

      FMergeProcess.Start;
      MergeTimer.Enabled := True;
      Exit;
    end;
    PositionTimer.Enabled := False;

    Self.Caption := 'TAudioConverter';

    TotalProgressBar.Position := 0;
    SetProgressValue(Self.Handle, 0, 100);
    SetProgressState(Self.Handle, tbpsNone);
    Timer.Enabled := False;
    TimeEdit.Text := '00:00:00';

    if SettingsForm.PlayWavBtn.Checked then
    begin
      if FileExists(ExtractFileDir(Application.ExeName) + '\done.wav') then
      begin
        sndPlaySound('done.wav', SND_ASYNC);
      end;
    end;
    SaveLogs;
    EnableUI;
    // update logs if log form is visible
    if LogForm.Visible then
    begin
      LogForm.ReLoadBtnClick(Self);
    end;

    // clear the list after an encode
    if SettingsForm.ClrListAfterEncodeBtn.Checked then
    begin
      FileList.Items.Clear;
      AudioTracks.Clear;
      AudioIndexes.Clear;
      AudioTrackList.Items.Clear;
      Files.Clear;
      Durations.Clear;
      ExtensionsForCopy.Clear;
      CopyExtension.Clear;
      StartPositions.Clear;
      EndPositions.Clear;
      ConstantDurations.Clear;
      TagsList.Clear;
      FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
      ;
    end;

    DeleteTempFiles(False);

    // post-encode action
    case PostEncodeList.ItemIndex of
      0:
        begin
          // checks if all the output files created
          if CheckOutputFiles then
          begin
            // calculate encoding speed
            if FTimePassed <= 0 then
            begin
              FTimePassed := 1;
            end;
            LEncodingSpeed := FTotalLength / FTimePassed;
            TrayIcon.Active := True;
            TrayIcon.BalloonHint('TAudioConverter', 'TAudioConverter converted files with speed of x' + FormatFloat('#,##', LEncodingSpeed) + ' (Converted ' + IntToTime(FTotalLength) + ' in ' + IntToTime(FTimePassed) + ').', btInfo, 5000);

            AddToLog(0, 'TAudioConverter converted files with speed x' + FormatFloat('#,##', LEncodingSpeed) + ' (Converted ' + IntToTime(FTotalLength) + ' in ' + IntToTime(FTimePassed) + ').');
            AddToLog(0, '');
          end;
          SaveOptions;
          CompressionPercentages;
        end;
      1:
        begin
          SaveOptions;
          Application.Terminate;
        end;
      2:
        begin
          // checks if all the output files created
          if CheckOutputFiles then
          begin
            // calculate encoding speed
            if FTimePassed <= 0 then
            begin
              FTimePassed := 1;
            end;
            LEncodingSpeed := FTotalLength / FTimePassed;
            TrayIcon.Active := True;
            TrayIcon.BalloonHint('TAudioConverter', 'TAudioConverter converted files with speed of x' + FormatFloat('#,##', LEncodingSpeed) + ' (Converted ' + IntToTime(FTotalLength) + ' in ' + IntToTime(FTimePassed) + ').', btInfo, 5000);

            AddToLog(0, 'TAudioConverter converted files with speed x' + FormatFloat('#,##', LEncodingSpeed) + ' (Converted ' + IntToTime(FTotalLength) + ' in ' + IntToTime(FTimePassed) + ').');
            AddToLog(0, '');
          end;
          SaveOptions;
          CompressionPercentages;
          if not SameAsSourceBtn.Checked then
          begin
            if (DirectoryExists(DirectoryEdit.Text)) then
            begin
              ShellExecute(Application.Handle, 'open', PChar(DirectoryEdit.Text), nil, nil, SW_SHOWNORMAL);
            end
            else
            begin
              Application.MessageBox('Cannot open output folder because it does not exist!', 'Error', MB_ICONERROR);
            end;
          end;
        end;
      3:
        begin
          SaveOptions;
          ShutDown(EWX_SHUTDOWN or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
      4:
        begin
          SaveOptions;
          ShutDown(EWX_REBOOT or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
      5:
        begin
          SaveOptions;
          ShutDown(EWX_LOGOFF or EWX_FORCE or EWX_FORCEIFHUNG);
        end;
    end;
    FTimePassed := 0;
  end;
end;

procedure TMainForm.PostEncodeListChange(Sender: TObject);
begin

  SettingsForm.PostEncode2List.ItemIndex := PostEncodeList.ItemIndex;

end;

procedure TMainForm.PrevCodecBtnClick(Sender: TObject);
begin
  if AudioCodecList.ItemIndex > 0 then
  begin
    AudioCodecList.ItemIndex := AudioCodecList.ItemIndex - 1;
    AudioCodecListChange(Self);
  end;
end;

procedure TMainForm.ProfilesListChange(Sender: TObject);
var
  LIndex: Integer;
  LProfileFile: TIniFile;
begin
  LIndex := ProfilesList.ItemIndex;
  if LIndex > -1 then
  begin
    AudioCodecList.ItemIndex := FPresets[LIndex].EncodeType;
    // read preset from ini file
    LProfileFile := TIniFile.Create(FPresets[LIndex].FileName);
    with LProfileFile do
    begin
      case FPresets[LIndex].EncodeType of
        0:
          begin
            // fdkaac
            with CodecSettingsForm do
            begin
              FDKProfileList.ItemIndex := ReadInteger('general', 'FDKProfile', 0);
              FDKBitrateEdit.Text := ReadString('general', 'FDKBitrate', '128');
              FDKGaplessList.ItemIndex := ReadInteger('general', 'FDKGapp', 0);
              FDKVBRBar.Position := ReadInteger('general', 'FDKVBR', 3);
              FDKMethodList.ItemIndex := ReadInteger('general', 'DFKMethod', 0);
              FDKMethodListChange(Self);
            end;
          end;
        5:
          begin
            // ac3
            with CodecSettingsForm do
            begin
              AftenEncodeList.ItemIndex := ReadInteger('general', 'AftenEncode', 0);
              AftenQualityEdit.Text := ReadString('general', 'AftenQuality', '240');
              AftenBitrateEdit.Text := ReadString('general', 'AftenBitrate', '320');
              ;
              AftenEncodeListChange(Self);
            end;
          end;
        6:
          begin
            // lame
            with CodecSettingsForm do
            begin
              LameEncodeList.ItemIndex := ReadInteger('general', 'LAmeEncode', 2);
              LameVBREdit.Text := ReadString('general', 'LameVBR2', '2');
              LameBitrateEdit.Text := ReadString('general', 'LameBit', '128');
              LameQualityEdit.Text := ReadString('general', 'LameQ', '3');
              LameTagList.ItemIndex := ReadInteger('general', 'LameTag', 0);
              LameVBRBar.Position := ReadInteger('general', 'LameQBar', 200);
              LameChannelList.ItemIndex := ReadInteger('general', 'lamechannel', 0);
              LameUseTTaggerBtn.Checked := ReadBool('general', 'lamettagger', True);
              LameEncodeListChange(Self);
            end;
          end;
        7:
          begin
            // mpc
            with CodecSettingsForm do
            begin
              MPCQualityBar.Position := ReadInteger('general', 'MPC', 500);
              MPCQualityBarChange(Self);
            end;
          end;
        8:
          begin
            // ogg vorbis
            with CodecSettingsForm do
            begin
              OggencodeList.ItemIndex := ReadInteger('general', 'OggEncode', 0);
              OggQualityEdit.Text := ReadString('general', 'OggQuality', '6');
              OggBitrateEdit.Text := ReadString('general', 'OggBitrate', '128');
              OggManagedBitrateBtn.Checked := ReadBool('general', 'OggManaged', False);
              OggMaxBitrateEdit.Text := ReadString('general', 'OggMax', '160');
              OggMinBitrateEdit.Text := ReadString('general', 'OggMin', '112');
              OggUseTTaggerBtn.Checked := ReadBool('general', 'OggTag', False);
              OggencodeListChange(Self);
            end;
          end;
        9:
          begin
            // opus
            with CodecSettingsForm do
            begin
              OpusEncodeMethodList.ItemIndex := ReadInteger('general', 'OpusEnc', 0);
              OpusBitrateEdit.Text := ReadString('general', 'OpusBitrate', '128');
              OpusCompEdit.Text := ReadString('general', 'OpusQuality', '8');
            end;
          end;
        10:
          begin
            // wma
            with CodecSettingsForm do
            begin
              WMAMethodList.ItemIndex := ReadInteger('general', 'WMAMethod', 1);
              WMABitrateEdit.Text := ReadString('general', 'WMABitrate', '128');
            end;
          end;
        11:
          begin
            // alac
            with CodecSettingsForm do
            begin

            end;
          end;
        13:
          begin
            // flac
            with CodecSettingsForm do
            begin
              FLACCompList.ItemIndex := ReadInteger('general', 'FlacComp', 5);
            end;
          end;
        15: // ape
          begin
            with CodecSettingsForm do
            begin
              MACLevelList.ItemIndex := ReadInteger('general', 'MAC', 1);
            end;
          end;
      end;
      // common options
      with CodecSettingsForm do
      begin
        SampleList.ItemIndex := ReadInteger('general', 'Sample', 2);
        ChannelList.ItemIndex := ReadInteger('general', 'Channel', 0);
        BitDepthList.ItemIndex := ReadInteger('general', 'Depth', 0);
      end;
    end;
    // update ui
    AudioCodecListChange(Self);
  end;
end;

procedure TMainForm.R1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'https://bitbucket.org/ozok/taudioconverter-audio-converter/issues?status=new&status=open', nil, nil, SW_SHOWNORMAL);
  Application.MessageBox('Please use "Create log.zip" button under "Logs" window to send logs.', 'Report bug', MB_ICONINFORMATION);
end;

function TMainForm.ReadTags(const FileName: string; const AudioOnly: Boolean): TTagInfo;
var
  MediaInfoHandle: Cardinal;
  ImageType: TImageTypeExtractor;
  RGInfoExtractor: TRGInfoExtractor;
  LTagExtractor: TWMATagExtractor;
begin

  if (FileExists(FileName)) then
  begin
    // if SettingsForm.UseMediaInfoBtn.Checked or (LowerCase(ExtractFileExt(FileName)) = '.m4a') or (LowerCase(ExtractFileExt(FileName)) = '.mp4') or (LowerCase(ExtractFileExt(FileName)) = '.m4b') or (LowerCase(ExtractFileExt(FileName)) = '.aac') then
    if SettingsForm.UseMediaInfoBtn.Checked and (not AudioOnly) then
    begin
      // use mediainfo to read tags
      // New handle for mediainfo
      MediaInfoHandle := MediaInfo_New();
      if MediaInfoHandle <> 0 then
      begin
        try
          // Open a file in complete mode
          MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
          MediaInfo_Option(0, 'Complete', '1');
          with Result do
          begin
            Artist := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Performer', Info_Text, Info_Name);
            Genre := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Genre', Info_Text, Info_Name);
            Performer := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Album/Performer', Info_Text, Info_Name);
            Album := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Album', Info_Text, Info_Name);
            RecordDate := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Recorded_Date', Info_Text, Info_Name);
            Title := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Title', Info_Text, Info_Name);
            TrackNo := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Track/Position', Info_Text, Info_Name);
            TrackTotal := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Track/Position_Total', Info_Text, Info_Name);

            Composer := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Composer', Info_Text, Info_Name);
            AlbumComposer := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Album/Composer', Info_Text, Info_Name);
            Comment := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Comment', Info_Text, Info_Name);
            ArtistSort := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'ARTISTSORT', Info_Text, Info_Name);
            AlbumSort := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'ALBUMSORT', Info_Text, Info_Name);
            ComposerSort := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'COMPOSERSORT', Info_Text, Info_Name);
            AlbumArtistSort := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'ALBUMARTISTSORT', Info_Text, Info_Name);
            NameSort := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'NAMESORT', Info_Text, Info_Name);
            AlbumArtist := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Album/Performer', Info_Text, Info_Name);
            DiscNo := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Part/Position', Info_Text, Info_Name);
            DiscTotal := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Part/Total', Info_Text, Info_Name);
          end;

        finally
          MediaInfo_Close(MediaInfoHandle);
        end;
      end;
    end
    else
    begin
      // use libraries to read tags
      Result := FTagReader.ReadTags(FileName);
    end;

    with Result do
    begin
      if Length(Artist) < 1 then
      begin
        if Length(AlbumArtist) > 0 then
        begin
          Artist := AlbumArtist;
        end
        else if Length(Performer) > 0 then
        begin
          Artist := Performer;
        end
        else if Length(Composer) > 0 then
        begin
          Artist := Composer;
        end;
      end;

      if Length(AlbumArtist) < 0 then
      begin
        if Length(Artist) > 0 then
        begin
          AlbumArtist := Artist;
        end
        else if Length(AlbumComposer) > 0 then
        begin
          AlbumArtist := AlbumComposer;
        end;
      end;
      if Length(AlbumArtistSort) < 0 then
      begin
        if Length(Artist) > 0 then
        begin
          AlbumArtistSort := Artist;
        end
        else if Length(AlbumComposer) > 0 then
        begin
          AlbumArtistSort := AlbumComposer;
        end;
      end;
      if Length(DiscNo) < 1 then
      begin
        DiscNo := '';
      end;
      if Length(DiscTotal) < 1 then
      begin
        DiscTotal := '';
      end;

      Title := RemoveQuotation(Title);
      Artist := RemoveQuotation(Artist);
      Genre := RemoveQuotation(Genre);
      TrackNo := PadString2(RemoveQuotation(TrackNo));
      TrackTotal := PadString2(RemoveQuotation(TrackTotal));
      DiscNo := PadString2(DiscNo);
      DiscTotal := PadString2(DiscTotal);
      Performer := RemoveQuotation(Performer);
      RecordDate := RemoveQuotation(RecordDate);
      Composer := RemoveQuotation(Composer);
      Album := RemoveQuotation(Album);
      Comment := RemoveQuotation(Comment);
      ArtistSort := RemoveQuotation(ArtistSort);
      AlbumSort := RemoveQuotation(AlbumSort);
      ComposerSort := RemoveQuotation(ComposerSort);
      AlbumArtistSort := RemoveQuotation(AlbumArtistSort);
      NameSort := RemoveQuotation(NameSort);
      AlbumArtist := RemoveQuotation(AlbumArtist);
      IsLossless := IsSourceLossless(FileName);
      TitleForFileName := RemoveInvalidChars(Title);
      ArtistForFileName := RemoveInvalidChars(Artist);
      AlbumForFileName := RemoveInvalidChars(Album);

      FileType := 'audio';

      // use these routines if mediainfo is used.
      // otherwise, these infos will be read using tag libs
      // if SettingsForm.UseMediaInfoBtn.Checked or (LowerCase(ExtractFileExt(FileName)) = '.m4a') or (LowerCase(ExtractFileExt(FileName)) = '.mp4') or (LowerCase(ExtractFileExt(FileName)) = '.m4b') or (LowerCase(ExtractFileExt(FileName)) = '.aac') then
      if SettingsForm.UseMediaInfoBtn.Checked and (not AudioOnly) then
      begin
        // get cover image type
        ImageType := TImageTypeExtractor.Create(FileName, FArtworkExtractorPath);
        try
          ImageType.Start;
          while ImageType.IEStatus = ieReading do
          begin
            Application.ProcessMessages;
            Sleep(10);
          end;
          CoverImageType := ImageType.Extension;
        finally
          ImageType.Free;
        end;

        // extract rg info
        // if Source is lossless
        if IsSourceLossless(FileName) then
        begin
          RGInfoExtractor := TRGInfoExtractor.Create(FileName, FFFProbePath);
          RGInfoExtractor.Start;
          try
            while RGInfoExtractor.RGInfoStatus = rsReading do
            begin
              Application.ProcessMessages;
              Sleep(10);
            end;

            RGInfo := RGInfoExtractor.RGInfo;
          finally
            RGInfoExtractor.Free;
          end;
        end;
      end;
    end;
  end;

end;

procedure TMainForm.RefreshBtnClick(Sender: TObject);
begin
  GetTracks;
end;

procedure TMainForm.RemoveAllBtnClick(Sender: TObject);
begin
  if FPlayer.PlayerStatus2 <> psStopped then
    Exit;
  if FileList.Items.Count < 1 then
    Exit;

  if ID_YES = Application.MessageBox('Remove all from list?', 'Remove All', MB_ICONQUESTION or MB_YESNO) then
  begin
    FileList.Items.Clear;
    AudioTracks.Clear;
    AudioIndexes.Clear;
    AudioTrackList.Items.Clear;
    Files.Clear;
    Durations.Clear;
    ExtensionsForCopy.Clear;
    CopyExtension.Clear;
    StartPositions.Clear;
    EndPositions.Clear;
    ConstantDurations.Clear;
    TagsList.Clear;
    FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
    ;
    StopPlaybackBtnClick(Self);
  end;

end;

procedure TMainForm.RemoveBtnClick(Sender: TObject);
var
  i: Integer;
  LII: TIndexItem;
begin

  if FPlayer.PlayerStatus2 <> psStopped then
    Exit;

  FileList.Items.BeginUpdate;
  try
    for i := FileList.Items.Count - 1 downto 0 do
    begin
      Application.ProcessMessages;

      if FileList.Items[i].Selected then
      begin
        FileList.Items.Delete(i);
        AudioTracks.Delete(i);
        AudioIndexes.Delete(i);
        Files.Delete(i);
        Durations.Delete(i);
        ExtensionsForCopy.Delete(i);
        CopyExtension.Delete(i);
        StartPositions.Delete(i);
        EndPositions.Delete(i);
        ConstantDurations.Delete(i);
        TagsList.Delete(i);
        if i = FPlaybackIndex then
        begin
          StopPlaybackBtnClick(Self);
        end;
      end;
    end;

    // update remaning items' indexes
    for i := 0 to FileList.Items.Count - 1 do
    begin
      LII := FileList.Items[i].SubItems.Objects[BITRATE_COLUMN_INDEX] as TIndexItem;
      LII.RealIndex := i;
      FileList.Items[i].SubItems.Objects[BITRATE_COLUMN_INDEX] := LII;
    end;

  finally
    FileList.Items.EndUpdate;
    FileList.OnClick(Self);
    FileCountLabel.Caption := FloatToStr(FileList.Items.Count) + ' file(s)';
    ;
    // UpdateListboxScrollBox(FileList);
  end;

end;

function TMainForm.RemoveInvalidChars(const Str: string): string;
const
  InvalidChars =['<', '>', ':', '"', '|', '/', '?', '*'];
var
  TmpStr: string;
  C: Char;
begin

  Result := Str;
  for C in Str do
  begin
    Application.ProcessMessages;
    if not CharInSet(C, InvalidChars) then
    begin
      TmpStr := TmpStr + C;
    end;
  end;
  if Length(TmpStr) > 0 then
  begin
    Result := TmpStr;
  end;

end;

function TMainForm.RemoveNonDigits(const InputStr: string): string;
var
  C: Char;
  TmpStr: string;
begin

  Result := InputStr;
  for C in InputStr do
  begin
    Application.ProcessMessages;
    if CharInSet(C, ['0'..'9']) then
    begin
      TmpStr := TmpStr + C;
    end;
  end;

  if Length(TmpStr) > 0 then
  begin
    Result := TmpStr;
  end;

end;

function TMainForm.RemoveQuotation(const Source: string): string;
var
  Tmp: string;
  C: Char;
begin

  Result := Source;

  for C in Source do
  begin
    if C <> '"' then
    begin
      Tmp := Tmp + C;
    end;
  end;

  if Length(Tmp) > 0 then
  begin
    Result := Tmp;
  end;

end;

procedure TMainForm.RipBtnClick(Sender: TObject);
var
  i: Integer;
  LT: TTrackInfo;
  LTIndex: TTrackIndexes;
  LTrackInfo: TTrackInfo;
begin
  // cd ripper

  if not DirectoryExists(SettingsForm.TempEdit.Text) then
  begin
    if not CreateDir(SettingsForm.TempEdit.Text) then
    begin
      Application.MessageBox('Cannot find and create temp folder1!', 'Error', MB_ICONERROR);
      Exit;
    end;
  end;

  if not SameAsSourceBtn.Checked then
  begin
    if not DirectoryExists(DirectoryEdit.Text) then
    begin
      if not CreateDir(DirectoryEdit.Text) then
      begin
        Application.MessageBox('Cannot create output folder!', 'Error', MB_ICONERROR);
        Exit;
      end;
    end;
  end;

  // check nero exe
  if FAudioEncoderType = etNeroAAC then
  begin
    if not FileExists(FNeroEncPath) then
    begin
      Application.MessageBox('Cannot find neroaacenc.exe. Please download it and place it in program folder.', 'Error', MB_ICONERROR);
      Exit;
    end;
  end;

  if TracksList.Items.Count > 0 then
  begin
    // reset
    FSelectedTracksCount := 0;
    FRippedTracks := 0;
    FTracksToBeRipped.Clear;
    CDPRogressList.Items.Clear;
    ItemProgressBar.Position := 0;
    RipProgregressBar.Position := 0;
    StatusLabel.Caption := '';
    for i := 0 to FTrackInfoList.Count - 1 do
    begin
      LTrackInfo := FTrackInfoList[i];
      LTrackInfo.TrackState := tsWaiting;
      FTrackInfoList[i] := LTrackInfo;
    end;
    StopPlaybackBtnClick(Self);

    CDIn.EnableJitterCorrection := SettingsForm.CDJitterBtn.Checked;
    CDIn.Paranoid := SettingsForm.CDParanoidBtn.Checked;
    CDDBInfo.Email := SettingsForm.CDEmailEdit.Text;
    CDDBInfo.Server := SettingsForm.CDServerEdit.Text;

    for i := 0 to TracksList.Items.Count - 1 do
    begin
      LT := FTrackInfoList[i];
      LT.WillBeRipped := TracksList.Items[i].Checked;
      FTrackInfoList[i] := LT;

      if TracksList.Items[i].Checked then
      begin
        inc(FSelectedTracksCount);
        LTIndex.CDIndex := LT.Index;
        LTIndex.ListIndex := i;
        FTracksToBeRipped.Add(LTIndex);
      end;
    end;

    CDIn.LockTray := True;

    if FTracksToBeRipped.Count > 0 then
    begin
      FTrackIndex := 0;
      CDIn.StartTrack := FTracksToBeRipped[FTrackIndex].CDIndex;
      CDIn.EndTrack := FTracksToBeRipped[FTrackIndex].CDIndex;
      WaveOut.FileName := FTrackInfoList[FTracksToBeRipped[FTrackIndex].ListIndex].TempFileName;

      FillCDProgressList;
      ProgressStatePanel.Visible := True;
      ProgressStatePanel.BringToFront;
      CDProgressTimer.Enabled := True;
      Self.Caption := '0% [Rip to WAV] [TAudioConverter]';
      for i := 0 to MainMenu.Items.Count - 1 do
      begin
        MainMenu.Items[i].Enabled := False;
      end;

      ExitCode := 1;
      WaveOut.Run;
    end
    else
    begin
      CDIn.LockTray := False;
    end;
  end
  else
  begin
    Application.MessageBox('No tracks in the list. Insert the disc and click "Refresh".', 'Error', MB_ICONERROR);
  end;
end;

procedure TMainForm.SameAsSourceBtnClick(Sender: TObject);
begin
  DirectoryEdit.Enabled := not SameAsSourceBtn.Checked;
end;

procedure TMainForm.SaveArtwork(const SourceFileName: string; const OutputFolder: string; const FileIndex: integer; const DestFile: string);
const
  Jpeg = '/9j/';
  PNG = 'iVBOR';
var
  ImageFile: string;
  ArtworkExtractor: TArtworkExtractor;
begin

  // first try embedded artwork
  if (TagsList[FileIndex].CoverImageType <> 'fff') and (Length(TagsList[FileIndex].CoverImageType) > 0) then
  begin
    // extract embedded artwork
    ImageFile := ExcludeTrailingPathDelimiter(OutputFolder) + '\' + FloatToStr(FileIndex) + '.' + TagsList[FileIndex].CoverImageType;
    ArtworkExtractor := TArtworkExtractor.Create(SourceFileName, ChangeFileExt(DestFile, ''), FArtworkExtractorPath);
    try
      ArtworkExtractor.Start;
      while ArtworkExtractor.AEStatus = aeReading do
      begin
        Application.ProcessMessages;
        Sleep(10);
      end;
    finally
      ArtworkExtractor.Free;
    end;
  end;

end;

procedure TMainForm.SaveExternalArtwork(const FileDir, OutputFolder: string);
var
  Extension: string;
  Search: TSearchRec;
begin

  if DirectoryExists(FileDir) then
  begin
    // try external artwork first
    if (FindFirst(FileDir + '\*.*', faAnyFile, Search) = 0) then
    begin
      repeat
        Application.ProcessMessages;

        if (Search.Name = '.') or (Search.Name = '..') then
          Continue;

        Extension := LowerCase(ExtractFileExt(Search.Name));

        if (Extension = '.png') or (Extension = '.jpeg') or (Extension = '.jpg') then
        begin
          if ContainsText(Search.Name, 'FRONT') or ContainsText((Search.Name), 'BACK') or ContainsText((Search.Name), 'DISC') or ContainsText((Search.Name), 'CD') or ContainsText((Search.Name), 'INLAY') or ContainsText((Search.Name), 'CASE') or ContainsText((Search.Name), 'BOX') or ContainsText((Search.Name), 'TRAY') or ContainsText((Search.Name), 'FOLDER') or ContainsText((Search.Name), 'COVER') or ContainsText((Search.Name), 'ALBUM') then
          begin
            CopyFile(PChar(FileDir + '\' + Search.Name), PChar(ExcludeTrailingPathDelimiter(OutputFolder) + '\' + Search.Name), True);
          end;
        end;

      until (FindNext(Search) <> 0) and (not AddingStopped);
      FindClose(Search);
    end;

  end;

end;

procedure TMainForm.SaveLogs;
var
  i: integer;
  LogFolder: string;
  LTextWriter: TStreamWriter;
  j: Integer;
  LAppend: Boolean;
begin

  // keeping logs are disabled by user
  if SettingsForm.LogEnableBtn.Checked then
    Exit;

  if Portable then
  begin
    LogFolder := '\logs'
  end
  else
  begin
    LogFolder := '';
  end;

  if not DirectoryExists(AppDataFolder + LogFolder) then
  begin
    if not CreateDir(AppDataFolder + LogFolder) then
    begin
      AddToLog(0, 'Couldn''t create log folder.');
      Exit;
    end;
  end;

  Self.Enabled := False;
  ProgressForm.CurrentFileLabel.Caption := 'Creating logs please wait...';
  ProgressForm.AbortBtn.Enabled := False;
  ProgressForm.show;
  ProgressForm.BringToFront;
  try
    if not Assigned(LogForm) then
    begin
      Exit;
    end;

    with LogForm do
    begin
      // encoder logs
      for i := 0 to 15 do
      begin
        Application.ProcessMessages;
        if FEncoders[i].GetConsoleOutput.Count > 0 then
        begin
          LAppend := FileExists(AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(i + 1) + '.txt');
          LTextWriter := TStreamWriter.Create(AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(i + 1) + '.txt', LAppend, TEncoding.UTF8);
          try
            for j := 0 to FEncoders[i].GetConsoleOutput.Count - 1 do
            begin
              LTextWriter.WriteLine(FEncoders[i].GetConsoleOutput[j]);
            end;
          finally
            LTextWriter.WriteLine('===========================End===========================');
            LTextWriter.WriteLine('');
            LTextWriter.Close;
            LTextWriter.Free;
          end;
        end;
      end;
      // merge process
      if FMergeProcess.GetConsoleOutput.Count > 0 then
      begin
        LAppend := FileExists(AppDataFolder + LogFolder + '\log_merge.txt');
        LTextWriter := TStreamWriter.Create(AppDataFolder + LogFolder + '\log_merge.txt', LAppend, TEncoding.UTF8);
        try
          for j := 0 to FMergeProcess.GetConsoleOutput.Count - 1 do
          begin
            LTextWriter.WriteLine(FMergeProcess.GetConsoleOutput[j]);
          end;
        finally
          LTextWriter.WriteLine('===========================End===========================');
          LTextWriter.WriteLine('');
          LTextWriter.Close;
          LTextWriter.Free;
        end;
      end;
    end;
  finally
    ProgressForm.AbortBtn.Enabled := True;
    ProgressForm.Close;
    Self.Enabled := True;
    Self.BringToFront;
  end;

end;

procedure TMainForm.SaveOptions;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin
      WriteString('Settings', 'OutDir', DirectoryEdit.Text);
      WriteInteger('Settings', 'Codec', AudioCodecList.ItemIndex);
      WriteInteger('Settings', 'AudioMethod', AudioMethodList.ItemIndex);
      WriteBool('Settings', 'SameAsSource', SameAsSourceBtn.Checked);
      WriteString('Settings', 'LastDir', FLastDirectory);
      WriteInteger('Settings', 'Post', PostEncodeList.ItemIndex);
      WriteInteger('settings', 'volume', VolumeBar.Position);
      WriteInteger('settings', 'profile2', ProfilesList.ItemIndex);
      WriteInteger('seetings', 'modesliderindex', EncodeModePages.ActivePageIndex);
    end;

  finally
    SettingsFile.Free;
  end;

end;

procedure TMainForm.CloseTrayBtnClick(Sender: TObject);
begin
  if DriversList.ItemIndex > -1 then
  begin
    if not CDIn.IsBusy then
    begin
      CDIn.CloseTray;
    end;
  end;
end;

procedure TMainForm.CDOptionsBtnClick(Sender: TObject);
begin
  Self.Enabled := False;
  SettingsForm.SettingsPage.ActivePageIndex := 5;
  SettingsForm.show;
end;

procedure TMainForm.sButton1Click(Sender: TObject);
begin
  // http://www.cuetools.net/wiki/FLACCL
  ShellExecute(0, 'open', 'http://www.cuetools.net/wiki/FLACCL', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.sButton2Click(Sender: TObject);
begin
  // http://www.hydrogenaudio.org/forums/index.php?showtopic=66233
  ShellExecute(0, 'open', 'http://www.hydrogenaudio.org/forums/index.php?showtopic=66233', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.WaveOutDone(Sender: TComponent);
var
  LTI: TTrackInfo;
  i, j: Integer;
  NumberOfProcesses: Integer;
begin

  // check if temp file is created
  LTI := FTrackInfoList[FTracksToBeRipped[FTrackIndex].ListIndex];
  if FileExists(LTI.TempFileName) then
  begin
    LTI.TrackState := tsRipped;
    inc(FRippedTracks);
  end
  else
  begin
    LTI.TrackState := tsErrorWhileRipping;
  end;
  FTrackInfoList[FTracksToBeRipped[FTrackIndex].ListIndex] := LTI;

  // try next item
  inc(FTrackIndex);
  // while (not FTrackInfoList[FTrackIndex - 1].WillBeRipped) and (FTrackIndex < TracksList.Items.Count) do
  // begin
  // Inc(FTrackIndex);
  // end;
  if FTrackIndex < FTracksToBeRipped.Count then
  begin
    WaveOut.FileName := FTrackInfoList[FTracksToBeRipped[FTrackIndex].ListIndex].TempFileName;
    CDIn.StartTrack := FTracksToBeRipped[FTrackIndex].CDIndex;
    CDIn.EndTrack := FTracksToBeRipped[FTrackIndex].CDIndex;
    WaveOut.Run;
  end
  else
  begin
    CDIn.LockTray := False;
    RipProgregressBar.Position := RipProgregressBar.Max;

    // add cd tracks to list and start encoding
    // reset SummaryView.Items.Clear;
    FilesToCheck.Clear;
    FTimePassed := 0;
    for i := Low(FEncoders) to High(FEncoders) do
    begin
      FEncoders[i].ResetValues;
    end;
    CompressionPairs.Clear;
    FTotalCMDCount := 0;
    FTotalLength := 0;

    // delete all temp files
    // DeleteTempFiles(False);

    // decide number of processes
    if (SettingsForm.ProcessCountList.ItemIndex + 1) > FTracksToBeRipped.Count then
    begin
      NumberOfProcesses := FTracksToBeRipped.Count;
    end
    else
    begin
      NumberOfProcesses := SettingsForm.ProcessCountList.ItemIndex + 1;
    end;

    // build type
    if Build64Bit then
    begin
      AddToLog(0, 'TAudioConverter package is 64bit.');
    end
    else
    begin
      AddToLog(0, 'TAudioConverter package is 64bit.');
    end;
    // add
    // cpu saturation warning
    if NumberOfProcesses >= SystemInfo.CPU.ProcessorCount then
    begin
      AddToLog(0, '');
      AddToLog(0, 'Number of processes is more than/equal to your CPU''s core count. Consider lowering it.');
      AddToLog(0, '');
    end;

    ProgressList.Items.Clear;
    Self.Enabled := False;
    try

      // show progress info
      ProgressInfoLabel.Caption := 'Creating command lines, please wait...';
      CreateCMDPanel.Left := (Self.Width div 2) - (CreateCMDPanel.Width div 2);
      CreateCMDPanel.Top := (Self.Height div 2) - (CreateCMDPanel.Height div 2);
      CreateCMDBar.Max := FileList.Items.Count;
      CreateCMDBar.Position := 0;
      CreateCMDPanel.Visible := True;
      CreateCMDPanel.BringToFront;

      // create command lines for files in the list
      AddCDTracks;

      // add process info to log
      AddToLog(0, '');
      AddToLog(0, 'Number of commands per process are as follows:');
      for i := Low(FEncoders) to High(FEncoders) do
      begin
        AddToLog(0, 'Encoder' + FloatToStr(i + 1) + ': ' + FloatToStr(FEncoders[i].CommandCount));
      end;
      AddToLog(0, '');

    finally
      CreateCMDPanel.Visible := False;
      Self.Enabled := True;
      Self.Caption := '0% [TAudioConverter]';
    end;

    // add commandlines to the log
    if not SettingsForm.LogEnableBtn.Checked then
    begin
      AddToLog(0, 'Writing commands to logs');
      for i := Low(FEncoders) to High(FEncoders) do
      begin
        if FEncoders[i].CommandCount > 0 then
        begin
          AddToLog(18, 'Encoder' + FloatToStr(i + 1) + ' commands:');
          for j := 0 to FEncoders[i].CommandLines.Count - 1 do
          begin
            AddToLog(18, '  ' + FEncoders[i].CommandLines[j]);
          end;
        end;
      end;
    end;
    AddToLog(18, '===========================End===========================');
    AddToLog(18, '');

    // calculate the total number of processes.
    // exclude merge process
    for i := 0 to 15 do
    begin
      inc(FTotalCMDCount, FEncoders[i].CommandCount);
    end;

    if FTotalCMDCount > 0 then
    begin
      FillSummaryList();
      // FillProgressList();
      ProgressStatePanel.Visible := False;
      DisableUI;
      ProgressList.Columns[0].Width := ProgressList.ClientWidth - ProgressList.Columns[1].Width - 20;
      TotalProgressLabel.Caption := '0% 0 steps of ' + FloatToStr(FTotalCMDCount) + ' total steps so far';
      TotalProgressBar.Max := FTotalCMDCount;
      SetCurrentDir(DirectoryEdit.Text);
      LaunchProcesses(NumberOfProcesses);
      PositionTimer.Enabled := True;
      Timer.Enabled := True;
      SetProgressState(Self.Handle, tbpsNormal);
    end
    else
    begin
      Application.MessageBox('No commands created. This may be due to invalid source files or maybe output file already exists and you selected to skip if it exists.', 'Error', MB_ICONERROR);
    end;
  end;
end;

procedure TMainForm.WaveOutProgress(Sender: TComponent);
var
  LT: TTrackInfo;
begin
  if not Assigned(WaveOut) then
    Exit;

  ItemProgressBar.Position := WaveOut.Progress;
  RipProgregressBar.Position := ((100 * FRippedTracks) div FSelectedTracksCount) + (ItemProgressBar.Position div FSelectedTracksCount);
  StatusLabel.Caption := 'Ripping to wav [' + FloatToStr(FRippedTracks) + '/' + FloatToStr(FSelectedTracksCount) + '] | Progress: [' + FloatToStr(WaveOut.Progress) + '%/' + FloatToStr(RipProgregressBar.Position) + '%]';
  LT := FTrackInfoList[FTracksToBeRipped[FTrackIndex].ListIndex];
  LT.TrackState := tsRipping;
  FTrackInfoList[FTracksToBeRipped[FTrackIndex].ListIndex] := LT;
  Self.Caption := FloatToStr(RipProgregressBar.Position) + '% [Rip to WAV] [TAudioConverter]';
  SetProgressValue(Handle, RipProgregressBar.Position, 100);
end;

procedure TMainForm.WaveOutThreadException(Sender: TComponent);
begin
  AddToLog(0, '[' + FloatToStr(GetLastError) + '] CD ripper error: ' + WaveOut.ExceptionMessage);
end;

procedure TMainForm.WikiBtnClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://en.wikipedia.org/wiki/Audio_bit_depth', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.SeeLogtxt1Click(Sender: TObject);
begin

  SettingsForm.SeeLogBtn.OnClick(Self);

end;

procedure TMainForm.SelectAll1Click(Sender: TObject);
begin

  FileList.SelectAll;

end;

procedure TMainForm.SelectDirBtnClick(Sender: TObject);
begin

  if DirectoryExists(DirectoryEdit.Text) then
  begin
    OpenFolderDialog.Directory := DirectoryEdit.Text;
  end;

  if OpenFolderDialog.Execute then
  begin
    DirectoryEdit.Text := OpenFolderDialog.Directory;
  end;

end;

procedure TMainForm.SendtoTrayBtnClick(Sender: TObject);
begin
  TrayIcon.Active := True;
  TrayIcon.HideApplication;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin

  Self.Enabled := False;
  SettingsForm.show;

end;

function TMainForm.ShutDown(RebootParam: Longword): Boolean;
var
  TTokenHd: THandle;
  TTokenPvg: TTokenPrivileges;
  cbtpPrevious: DWORD;
  rTTokenPvg: TTokenPrivileges;
  pcbtpPreviousRequired: DWORD;
  tpResult: Boolean;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    tpResult := OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, TTokenHd);
    if tpResult then
    begin
      tpResult := LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME, TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;
      TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      cbtpPrevious := Sizeof(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if tpResult then
        AdjustTokenPrivileges(TTokenHd, False, TTokenPvg, cbtpPrevious, rTTokenPvg, pcbtpPreviousRequired);
    end;
  end;
  Result := ExitWindowsEx(RebootParam, 0);

end;

procedure TMainForm.sLabel3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://lame.cvs.sourceforge.net/viewvc/lame/lame/USAGE', nil, nil, SW_SHOWNORMAL);
end;

function TMainForm.SoXPercentage(const SoxOutput: string): Integer;
begin
  Result := 0;
  if (Length(SoxOutput) > 0) then
  begin
    if Copy(SoxOutput, 3, 3) = '100' then
    begin
      Result := 100;
    end
    else if IsStringNumeric(Copy(SoxOutput, 3, 2)) then
    begin
      Result := StrToInt(Copy(SoxOutput, 3, 2));
    end;
  end;
end;

procedure TMainForm.sSkinManager1Activate(Sender: TObject);
begin
  sAlphaHints1.Active := True;
end;

procedure TMainForm.sSkinManager1Deactivate(Sender: TObject);
begin
  sAlphaHints1.Active := False;
end;

procedure TMainForm.StartBtnClick(Sender: TObject);
var
  i: Integer;
  AdvancedOptions: string;
  NumberOfProcesses: integer;
  j: Integer;
  LDontMerge: Boolean;
  LMergeFileName: string;
begin
  // audio converter mode
  if FileList.Items.Count > 0 then
  begin

{$REGION 'merge decision block'}
    LDontMerge := True;
    if AudioMethodList.ItemIndex = 2 then
    begin
      if MergeSaveDlg.Execute then
      begin
        LMergeFileName := MergeSaveDlg.FileName;
        LDontMerge := False;
      end
      else
      begin
        Exit;
      end;
    end
    else
    begin
      LDontMerge := False;
    end;
{$ENDREGION}
    if Length(LMergeFileName) < 0 then
    begin
      Exit;
    end;

{$REGION 'Path check block'}
    if not DirectoryExists(SettingsForm.TempEdit.Text) then
    begin
      if not CreateDir(SettingsForm.TempEdit.Text) then
      begin
        Application.MessageBox('Cannot find and create temp folder1!', 'Error', MB_ICONERROR);
        Exit;
      end;
    end;

    if not SameAsSourceBtn.Checked then
    begin
      if not DirectoryExists(DirectoryEdit.Text) then
      begin
        if not CreateDir(DirectoryEdit.Text) then
        begin
          Application.MessageBox('Cannot create output folder!', 'Error', MB_ICONERROR);
          Exit;
        end;
      end;
    end;

    // check nero exe
    if FAudioEncoderType = etNeroAAC then
    begin
      if not FileExists(FNeroEncPath) then
      begin
        Application.MessageBox('Cannot find neroaacenc.exe. Please download it and place it in program folder.', 'Error', MB_ICONERROR);
        Exit;
      end;
    end;
{$ENDREGION}
    if DirectoryExists(DirectoryEdit.Text) or SameAsSourceBtn.Checked then
    begin
      // reset
{$REGION 'reset values block'}
      SummaryView.Items.Clear;
      FilesToCheck.Clear;
      FTimePassed := 0;
      for i := Low(FEncoders) to High(FEncoders) do
      begin
        FEncoders[i].ResetValues;
      end;
      FMergeProcess.ResetValues;
      CompressionPairs.Clear;
      FTotalCMDCount := 0;
      FTotalLength := 0;
      FMergeTotalDuration := 0;
      StopPlaybackBtnClick(Self);
      // delete previous mergelist
      if AudioMethodList.ItemIndex = 2 then
      begin
        FMergeFileList.Clear;
        if FileExists(SettingsForm.TempEdit.Text + '\mergelist.txt') then
        begin
          DeleteFile(SettingsForm.TempEdit.Text + '\mergelist.txt')
        end;
      end;
      // delete all temp files
      DeleteTempFiles(False);
{$ENDREGION}
      // decide number of processes
      if (SettingsForm.ProcessCountList.ItemIndex + 1) > FileList.Items.Count then
      begin
        NumberOfProcesses := FileList.Items.Count;
      end
      else
      begin
        NumberOfProcesses := SettingsForm.ProcessCountList.ItemIndex + 1;
      end;

      // cpu saturation warning
      if NumberOfProcesses >= SystemInfo.CPU.ProcessorCount then
      begin
        AddToLog(0, '');
        AddToLog(0, 'Number of processes is more than/equal to your CPU''s core count. Consider lowering it.');
        AddToLog(0, '');
      end;

      ProgressList.Items.Clear;
      Self.Enabled := False;
      try

        // show progress info
        ProgressInfoLabel.Caption := 'Creating command lines, please wait...';
        CreateCMDPanel.Left := (Self.Width div 2) - (CreateCMDPanel.Width div 2);
        CreateCMDPanel.Top := (Self.Height div 2) - (CreateCMDPanel.Height div 2);
        CreateCMDBar.Max := FileList.Items.Count;
        CreateCMDBar.Position := 0;
        CreateCMDPanel.Visible := True;
        CreateCMDPanel.BringToFront;

        // create command lines for files in the list
        for i := 0 to FileList.Items.Count - 1 do
        begin
          Application.ProcessMessages;

          CreateCMDBar.Position := i;
          if AudioMethodList.ItemIndex <> 2 then
          begin
            // encode or copy
            AddCommandLine(i, AdvancedOptions, (i mod NumberOfProcesses) + 1);
          end
          else
          begin
            // merge
            AddMergeCommandLine(i, AdvancedOptions, (i mod NumberOfProcesses) + 1);
          end;
        end;
        // build type
        if Build64Bit then
        begin
          AddToLog(0, 'TAudioConverter package is 64bit.');
        end
        else
        begin
          AddToLog(0, 'TAudioConverter package is 32bit.');
        end;
        // add merge video file warning.
        // save list of files to be merged
        // add command to merge temp files into single wav file and encode them
        if AudioMethodList.ItemIndex = 2 then
        begin
          AddToLog(0, 'Video files are ignored in merging mode.');
          FMergeFileList.SaveToFile(SettingsForm.TempEdit.Text + '\mergelist.txt');
          CreateMergeCMD(LMergeFileName);
        end;
        // add process info to log
        AddToLog(0, '');
        AddToLog(0, 'Number of commands per process are as follows:');
        for i := Low(FEncoders) to High(FEncoders) do
        begin
          AddToLog(0, 'Encoder' + FloatToStr(i + 1) + ': ' + FloatToStr(FEncoders[i].CommandCount));
        end;
        AddToLog(0, '');

      finally
        CreateCMDPanel.Visible := False;
        Self.Enabled := True;
        Self.Caption := '0% [TAudioConverter]';
      end;

      // add commandlines to the log
      if not SettingsForm.LogEnableBtn.Checked then
      begin
        AddToLog(0, 'Writing commands to logs');
        for i := Low(FEncoders) to High(FEncoders) do
        begin
          if FEncoders[i].CommandCount > 0 then
          begin
            AddToLog(18, 'Encoder' + FloatToStr(i + 1) + ' commands:');
            for j := 0 to FEncoders[i].CommandLines.Count - 1 do
            begin
              AddToLog(18, '  ' + FEncoders[i].CommandLines[j]);
            end;
          end;
        end;
        // merge commands
        if AudioMethodList.ItemIndex = 2 then
        begin
          AddToLog(18, 'Merging commands: ');
          for i := 0 to FMergeProcess.CommandCount - 1 do
          begin
            AddToLog(18, '  ' + FMergeProcess.CommandLines[i]);
          end;
        end;
      end;
      AddToLog(18, '===========================End===========================');
      AddToLog(18, '');

      // calculate number of tasks.
      // exclude merge process
      for i := Low(FEncoders) to High(FEncoders) - 1 do
      begin
        inc(FTotalCMDCount, FEncoders[i].CommandCount);
      end;

      if (FTotalCMDCount > 0) and (not LDontMerge) then
      begin
        FillSummaryList();
        // FillProgressList();
        DisableUI;
        ProgressList.Columns[0].Width := ProgressList.ClientWidth - ProgressList.Columns[1].Width - 20;
        TotalProgressLabel.Caption := '0% 0 steps of ' + FloatToStr(FTotalCMDCount) + ' total steps so far';
        TotalProgressBar.Max := FTotalCMDCount;
        // SetCurrentDir(DirectoryEdit.Text);
        LaunchProcesses(NumberOfProcesses);
        PositionTimer.Enabled := True;
        Timer.Enabled := True;
        SetProgressState(Self.Handle, tbpsNormal);
      end
      else
      begin
        Application.MessageBox('No commands created. This may be due to invalid source files or maybe output file already exists and you selected to skip if it exists.', 'Error', MB_ICONERROR);
      end;

    end
    else
    begin
      Application.MessageBox('Output folder does not exist!', 'Error', MB_ICONERROR);
    end;

  end
  else
  begin
    Application.MessageBox('Add files first!', 'Error', MB_ICONERROR);
  end;

end;

procedure TMainForm.StopBtnClick(Sender: TObject);
var
  I: Integer;
begin

  if ID_YES = Application.MessageBox('Stop encoding?', 'Stop', MB_ICONQUESTION or MB_YESNO) then
  begin
    PositionTimer.Enabled := False;
    MergeTimer.Enabled := False;
    for I := Low(FEncoders) to High(FEncoders) do
    begin
      FEncoders[I].Stop;
    end;
    FMergeProcess.Stop;

    TotalProgressBar.Position := 0;
    SetProgressValue(Self.Handle, 0, 100);
    SetProgressState(Self.Handle, tbpsNone);
    Timer.Enabled := False;
    FTimePassed := 0;
    TimeEdit.Text := '00:00:00';
    TotalProgressLabel.Caption := '0% 0 steps of 0 total steps so far';
    Self.Caption := 'TAudioConverter';

    SaveLogs;
    DeleteTempFiles(False);
    if LogForm.Visible then
    begin
      LogForm.ReLoadBtnClick(Self);
    end;

    EnableUI;
    Self.Caption := 'TAudioConverter';

    // post-encode action
    case PostEncodeList.ItemIndex of
      0:
        begin

        end;
      1:
        begin
          // Application.Terminate;
        end;
      2:
        begin
          OutputBtn.OnClick(Self);
        end;
    end;
  end;

end;

procedure TMainForm.StopCDBtnClick(Sender: TObject);
var
  i: Integer;
begin
  if ID_YES = Application.MessageBox('Stop ripping to wav?', 'Stop', MB_ICONQUESTION or MB_YESNO) then
  begin
    WaveOut.Stop(False);
    ItemProgressBar.Position := 0;
    RipProgregressBar.Position := 0;
    StatusLabel.Caption := '';
    ProgressStatePanel.Visible := False;
    ProgressList.Items.Clear;
    for i := 0 to MainMenu.Items.Count - 1 do
    begin
      MainMenu.Items[i].Enabled := True;
    end;
    Self.Caption := 'TAudioConverter';
  end;
end;

procedure TMainForm.StopPlaybackBtnClick(Sender: TObject);
begin
  if FPlayer.PlayerStatus2 <> psStopped then
  begin
    PlaybackTimer.Enabled := False;
    FPlayer.Stop;
    PositionBar.Position := 0;
    PositionLabel.Caption := '00:00:00/00:00:00';
    SetProgressValue(Handle, 0, PositionBar.Max);
    if (FileList.Items.Count > 0) and (FPlaybackIndex < FileList.Items.Count) then
    begin
      FileList.Items[FPlaybackIndex].StateIndex := FPrevStateIndex;
    end;
    FPlaybackIndex := -1;
  end;
end;

function TMainForm.SubStringOccurences(const subString, sourceString: string): integer;
var
  pEx: integer;
begin
  Result := 0;
  pEx := PosEx(subString, sourceString, 1);
  while pEx <> 0 do
  begin
    Inc(Result);
    pEx := PosEx(subString, sourceString, pEx + Length(subString));
  end;
end;

procedure TMainForm.T1Click(Sender: TObject);
begin
  if TrimBtn.Enabled then
    TrimBtnClick(Self);
end;

procedure TMainForm.TagEditorBtnClick(Sender: TObject);
var
  P: TPoint;
begin
  P := TagEditorBtn.ClientToScreen(Point(0, 0));

  TagEditMenu.Popup(P.X, P.Y + TagEditorBtn.Height)
  // Self.Enabled := False;
  // TagForm.show;
end;

function TMainForm.TAKPercentage(const TAKOutput: string): integer;
var
  StrPos1: integer;
  TmpStr: string;
begin
  Result := 0;
  if Length(TAKOutput) > 0 then
  begin
    StrPos1 := Pos('wav', TAKOutput);

    TmpStr := Trim(Copy(TAKOutput, StrPos1 + 3, MaxInt));
    if Length(TmpStr) > 0 then
    begin
      Result := SubStringOccurences('.', TmpStr) * 10;
    end;
  end;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  Inc(FTimePassed);
  TimeEdit.Text := IntToTime(FTimePassed);
end;

function TMainForm.TimeToInt(const TimeStr: string): Integer;
var
  TimeList: TStringList;
  hour: Integer;
  Minute: Integer;
  Second: Integer;
begin
  Result := 0;
  if Length(TimeStr) = 8 then
  begin
    TimeList := TStringList.Create;
    try
      TimeList.Delimiter := ':';
      TimeList.StrictDelimiter := True;
      TimeList.DelimitedText := TimeStr;
      hour := 0;
      Minute := 0;
      Second := 0;
      if TimeList.Count = 3 then
      begin
        if IsStringNumeric(TimeList[0]) then
        begin
          hour := StrToInt(TimeList[0]);
        end;
        if IsStringNumeric(TimeList[1]) then
        begin
          Minute := StrToInt(TimeList[1]);
        end;
        if IsStringNumeric(TimeList[2]) then
        begin
          Second := StrToInt(TimeList[2]);
        end;
        Result := (hour * 3600) + (Minute * 60) + Second;
      end;
    finally
      FreeAndNil(TimeList);
    end;
  end;
end;

procedure TMainForm.TitleEditChange(Sender: TObject);
var
  LT: TTrackInfo;
begin
  if (TracksList.ItemIndex > -1) and (TracksList.ItemIndex < FTrackInfoList.Count) then
  begin
    LT := FTrackInfoList[TracksList.ItemIndex];
    LT.TrackTagInfo.Title := TitleEdit.Text;
    FTrackInfoList[TracksList.ItemIndex] := LT;
    TracksList.Items[TracksList.ItemIndex].SubItems[0] := TitleEdit.Text
  end;
end;

procedure TMainForm.TrackNoEditChange(Sender: TObject);
var
  LT: TTrackInfo;
begin
  if (TracksList.ItemIndex > -1) and (TracksList.ItemIndex < FTrackInfoList.Count) then
  begin
    LT := FTrackInfoList[TracksList.ItemIndex];
    LT.TrackTagInfo.TrackNo := TrackNoEdit.Text;
    FTrackInfoList[TracksList.ItemIndex] := LT;
  end;
end;

procedure TMainForm.TracksListClick(Sender: TObject);
begin
  if (TracksList.ItemIndex > -1) and (TracksList.ItemIndex < FTrackInfoList.Count) then
  begin
    TitleEdit.Enabled := True;
    ArtistEdit.Enabled := True;
    AlbumEdit.Enabled := True;
    TrackNoEdit.Enabled := True;
    AlbumArtistEdit.Enabled := True;
    DateEdit.Enabled := True;
    GenreEdit.Enabled := True;
    CommentEdit.Enabled := True;
    with FTrackInfoList[TracksList.ItemIndex].TrackTagInfo do
    begin
      TitleEdit.Text := Title;
      ArtistEdit.Text := Artist;
      AlbumEdit.Text := Album;
      TrackNoEdit.Text := TrackNo;
      AlbumArtistEdit.Text := AlbumArtist;
      DateEdit.Text := Date;
      GenreEdit.Text := Genre;
      CommentEdit.Text := Comment;
    end;
  end
  else
  begin
    TitleEdit.Enabled := False;
    ArtistEdit.Enabled := False;
    AlbumEdit.Enabled := False;
    TrackNoEdit.Enabled := False;
    AlbumArtistEdit.Enabled := False;
    DateEdit.Enabled := False;
    GenreEdit.Enabled := False;
    CommentEdit.Enabled := False;
    TitleEdit.Text := '';
    ArtistEdit.Text := '';
    AlbumEdit.Text := '';
    TrackNoEdit.Text := '';
    AlbumArtistEdit.Text := '';
    DateEdit.Text := '';
    GenreEdit.Text := '';
    CommentEdit.Text := '';
  end;
end;

procedure TMainForm.TrayIconBalloonClick(Sender: TObject);
begin
  TrayIcon.HideBalloon;
end;

procedure TMainForm.TrimBtnClick(Sender: TObject);
var
  Index: integer;
begin
  Index := FileList.ItemIndex;
  if (Index > -1) and (TagsList[Index].FileType <> 'cue') then
  begin
    TrimmerForm.FileIndex := Index;
    TrimmerForm.StartPosition := StrToInt(StartPositions[Index]);
    TrimmerForm.EndPosition := StrToInt(EndPositions[Index]);
    TrimmerForm.Duration := StrToInt(Durations[Index]);
    Self.Enabled := False;
    TrimmerForm.show;
  end;
end;

procedure TMainForm.UpBtnClick(Sender: TObject);
var
  i: Integer;
  lv, lv2: TListItem;
  LII: TIndexItem;
begin

  for i := 0 to FileList.Items.Count - 1 do
  begin
    Application.ProcessMessages;

    if FileList.Items.Item[i].Selected then
    begin

      if i > 0 then
      begin

        lv2 := FileList.Items[i];
        try
          lv := FileList.Items.Insert(i - 1);
          lv.Assign(lv2);
          lv2.Delete;

          AudioTracks.Exchange(i, i - 1);
          AudioIndexes.Exchange(i, i - 1);
          Files.Exchange(i, i - 1);
          Durations.Exchange(i, i - 1);
          ExtensionsForCopy.Exchange(i, i - 1);
          CopyExtension.Exchange(i, i - 1);
          StartPositions.Exchange(i, i - 1);
          EndPositions.Exchange(i, i - 1);
          ConstantDurations.Exchange(i, i - 1);
          TagsList.Exchange(i, i - 1);
        finally
          lv.Selected := True;
          lv.Focused := True;
        end;

      end;

    end;

  end;

  // update remaning items' indexes
  for i := 0 to FileList.Items.Count - 1 do
  begin
    LII := FileList.Items[i].SubItems.Objects[BITRATE_COLUMN_INDEX] as TIndexItem;
    LII.RealIndex := i;
    FileList.Items[i].SubItems.Objects[BITRATE_COLUMN_INDEX] := LII;
  end;

end;

procedure TMainForm.UpdateBtnClick(Sender: TObject);
begin

  Self.Enabled := False;
  UpdaterForm.show;

end;

procedure TMainForm.UpdateCheckerDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
var
  VersionFile: TStringList;
  LatestVersion: Integer;
begin

  VersionFile := TStringList.Create;
  try

    if StreamSize > 0 then
    begin
      VersionFile.LoadFromStream(Stream);

      if VersionFile.Count = 1 then
      begin

        if IsStringNumeric(VersionFile.Strings[0]) then
        begin
          LatestVersion := StrToInt(VersionFile.Strings[0]);

          if LatestVersion > BuildInt then
          begin

            if ID_YES = Application.MessageBox('There is a new version. Would you like to go homepage and download it?', 'New Version', MB_ICONQUESTION or MB_YESNO) then
            begin
              ShellExecute(Application.Handle, 'open', 'http://www.downloadbestsoft.com/TAudioConverter.html', nil, nil, SW_SHOWNORMAL);
            end;

          end;

        end;

      end;
    end;

  finally
    FreeAndNil(VersionFile);
  end;

end;

procedure TMainForm.UpdateListboxScrollBox(ListBox: TsListBox);
var
  j: Integer;
  MaxWidth: Integer;
begin

  MaxWidth := 0;

  for j := 0 to ListBox.Items.Count - 1 do
  begin

    if MaxWidth < ListBox.Canvas.TextWidth(ListBox.Items[j]) then
    begin
      MaxWidth := ListBox.Canvas.TextWidth(ListBox.Items[j]);
    end;

  end;

  SendMessage(ListBox.Handle, LB_SETHORIZONTALEXTENT, MaxWidth + 5, 0);

end;

procedure TMainForm.UpdateProgress;
begin
  TotalProgressBar.Position := TotalProgressBar.Position + 1;
  TotalProgressLabel.Caption := FloatToStr((100 * TotalProgressBar.Position) div TotalProgressBar.Max) + '% ' + FloatToStr(TotalProgressBar.Position) + ' steps of ' + FloatToStr(FTotalCMDCount) + ' total steps so far';
end;

procedure TMainForm.UpdateSummaryLabel;
begin
  case AudioMethodList.ItemIndex of
    0:
      begin
        GenerateSummaryString;
      end;
    1:
      begin
        if FunctionPages.ActivePageIndex = 0 then
        begin
          SummaryLabel.Caption := 'Copying audio';
        end
        else
        begin
          GenerateSummaryString;
        end;
      end;
    2:
      begin
        GenerateSummaryString;
      end;
  end;
end;

procedure TMainForm.UpdateThreadExecute(Sender: TObject; Params: Pointer);
begin
  with UpdateChecker do
  begin
    Url := 'http://sourceforge.net/projects/taudioconverter/files/TAudioConverter.txt/download';
    Start;
  end;

  UpdateThread.CancelExecute;
end;

procedure TMainForm.VolumeBarChange(Sender: TObject);
begin
  if (FPlayer.PlayerStatus = psPlaying) or (FPlayer.PlayerStatus = psPaused) then
  begin
    FPlayer.SetVolume(VolumeBar.Position);
  end;
  VolumeLabel.Caption := FloatToStr(VolumeBar.Position) + '%'
end;

procedure TMainForm.VolumeBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewTractBarPosition: Integer;
begin
  NewTractBarPosition := Round((X / VolumeBar.ClientWidth) * VolumeBar.Max);

  if (NewTractBarPosition <> VolumeBar.Position) then
  begin
    VolumeBar.Position := NewTractBarPosition;
  end;
end;

function TMainForm.WMAEncoderPercentage(const WMAOutput: string): integer;
var
  TmpStr: string;
begin
  Result := 0;
  if Length(WMAOutput) > 0 then
  begin
    TmpStr := WMAOutput;
    TmpStr := ReplaceText(TmpStr, 'Start encoding...', '');
    TmpStr := Trim(ReplaceStr(TmpStr, '%', ''));

    if IsStringNumeric(TmpStr) then
    begin
      Result := StrToInt(TmpStr);
    end;
  end;
end;

procedure TMainForm.WMCopyData(var Message: TWMCopyData);
var
  Arg: string;
begin
  SetString(Arg, PChar(Message.CopyDataStruct.lpData), (Message.CopyDataStruct.cbData div Sizeof(Char)) - 1);

  // check if timer is enabled.
  // if it is, then reject new files.
  if not PositionTimer.Enabled then
  begin
    AddFile(Arg);

    if FileExists(Arg) then
    begin
      FLastDirectory := ExtractFileDir(Arg);
    end;

    // UpdateListboxScrollBox(FileList);
  end;
  Application.Restore;
  Application.BringToFront;

end;

procedure TMainForm.WriteLnToFile(const FileName, Line: string);
var
  // TF: TextFile;
  Writer: TStreamWriter;
begin

  { if file alread exists append line to it.
    else create it. }

  // append
  Writer := TStreamWriter.Create(FileName, True, TEncoding.Unicode);
  try
    Writer.WriteLine(Line);
  finally
    Writer.Flush;
    Writer.Close;
    Writer.Free;
  end;

end;

function TMainForm.x264Percentage(const x264Output: string): Integer;
var
  TmpStr: string;
  TmpInt: Integer;
  FConsoleOutput: string;
  StrPos: Integer;
begin

  Result := 0;

  FConsoleOutput := Trim(x264Output);

  if Length(FConsoleOutput) > 0 then
  begin

    if Copy(FConsoleOutput, 1, 1) = '[' then
    begin
      StrPos := Pos('%]', FConsoleOutput);

      if StrPos > -1 then
      begin
        TmpStr := Copy(FConsoleOutput, 2, StrPos);
        Delete(TmpStr, Length(TmpStr) - 3, 4);

        if TryStrToInt(TmpStr, TmpInt) then
        begin
          Result := TmpInt;
        end;

      end;

    end;

  end;

end;

end.


