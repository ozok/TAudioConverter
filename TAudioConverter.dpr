program TAudioConverter;
{$IFOPT D-}{$WEAKLINKRTTI ON}{$ENDIF}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  SysUtils,
  Messages,
  Windows,
  UnitMain in 'Forms\UnitMain.pas' {MainForm},
  UnitLog in 'Forms\UnitLog.pas' {LogForm},
  windows7taskbar in 'Units\windows7taskbar.pas',
  MediaInfoDLL in 'Units\MediaInfoDLL.pas',
  UnitInfo in 'Forms\UnitInfo.pas' {InfoForm},
  UnitAbout in 'Forms\UnitAbout.pas' {AboutForm},
  UnitUpdater in 'Forms\UnitUpdater.pas' {UpdaterForm},
  UnitSox in 'Forms\UnitSox.pas' {FiltersForm},
  UnitProgress in 'Forms\UnitProgress.pas' {ProgressForm},
  Encoder in 'Encoder\Encoder.pas',
  UnitSettings in 'Forms\UnitSettings.pas' {SettingsForm},
  FileInfo in 'FileInfo\FileInfo.pas',
  UnitTag in 'Forms\UnitTag.pas' {TagForm},
  UnitTrimmer in 'Forms\UnitTrimmer.pas' {TrimmerForm},
  CueParser in 'FileInfo\CueParser.pas',
  TagTypes in 'Types\TagTypes.pas',
  AudioDurationExtractor in 'FileInfo\AudioDurationExtractor.pas',
  FFProbeInformer in 'FileInfo\FFProbeInformer.pas',
  ImageTypeExtractor in 'Image\ImageTypeExtractor.pas',
  ArtworkExtractor in 'Artwork\ArtworkExtractor.pas' {$R *.res},
  UnitCodecSettings in 'Forms\UnitCodecSettings.pas' {CodecSettingsForm},
  RGInfoExtractor in 'FileInfo\RGInfoExtractor.pas',
  CustomEnums in 'Types\CustomEnums.pas',
  Unit3rdParty in 'Forms\Unit3rdParty.pas' {ComponentsForm},
  WMATagExtractor in 'FileInfo\WMATagExtractor.pas',
  UnitTagEditor in 'Forms\UnitTagEditor.pas' {TagEditorForm},
  bass in 'BassUnits\bass.pas',
  bass_aac in 'BassUnits\bass_aac.pas',
  bass_ac3 in 'BassUnits\bass_ac3.pas',
  bass_alac in 'BassUnits\bass_alac.pas',
  bass_ape in 'BassUnits\bass_ape.pas',
  bass_mpc in 'BassUnits\bass_mpc.pas',
  bass_ofr in 'BassUnits\bass_ofr.pas',
  bass_spx in 'BassUnits\bass_spx.pas',
  bass_tta in 'BassUnits\bass_tta.pas',
  bassflac in 'BassUnits\bassflac.pas',
  bassopus in 'BassUnits\bassopus.pas',
  basswma in 'BassUnits\basswma.pas',
  basswv in 'BassUnits\basswv.pas',
  Player in 'Player\Player.pas',
  ArtworkDownloader in 'Artwork\ArtworkDownloader.pas',
  ImageResize in 'Image\ImageResize.pas',
  TagReader in 'FileInfo\TagReader.pas',
  Presets in 'Types\Presets.pas',
  APEv2Library in 'TagLibraries\APEv2Library.pas',
  FlacTagLibrary in 'TagLibraries\FlacTagLibrary.pas',
  ID3v1Library in 'TagLibraries\ID3v1Library.pas',
  ID3v2Library in 'TagLibraries\ID3v2Library.pas',
  MP4TagLibrary in 'TagLibraries\MP4TagLibrary.pas',
  OggVorbisAndOpusTagLibrary in 'TagLibraries\OggVorbisAndOpusTagLibrary.pas',
  WMATagLibrary in 'TagLibraries\WMATagLibrary.pas',
  UnitMergeTag in 'Forms\UnitMergeTag.pas' {MergeTagForm},
  WAVTagLibrary in 'TagLibraries\WAVTagLibrary.pas',
  CustomTypes in 'Types\CustomTypes.pas';

{$R *.res}

{
  This procedure and WMCopyData and CreateParams procedures in UnitMain are
  copied from http://stackoverflow.com/questions/8688078/preventing-multiple-instances-but-also-handle-the-command-line-parameters.
  Thanks to David Heffernan.
}
procedure Main;
var
  i: Integer;
  Arg: string;
  Window: HWND;
  CopyDataStruct: TCopyDataStruct;
begin
  Window := FindWindow(SWindowClassName, nil);
  if Window = 0 then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    // ReportMemoryLeaksOnShutdown := True;
    Application.Title := 'TAudioConverter';
    Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLogForm, LogForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TUpdaterForm, UpdaterForm);
  Application.CreateForm(TFiltersForm, FiltersForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TTagForm, TagForm);
  Application.CreateForm(TTrimmerForm, TrimmerForm);
  Application.CreateForm(TCodecSettingsForm, CodecSettingsForm);
  Application.CreateForm(TComponentsForm, ComponentsForm);
  Application.CreateForm(TTagEditorForm, TagEditorForm);
  Application.CreateForm(TMergeTagForm, MergeTagForm);
  Application.Run;
  end
  else
  begin
    FillChar(CopyDataStruct, Sizeof(CopyDataStruct), 0);
    for i := 1 to ParamCount do
    begin
      Arg := ParamStr(i);
      CopyDataStruct.cbData := (Length(Arg) + 1) * Sizeof(Char);
      CopyDataStruct.lpData := PChar(Arg);
      SendMessage(Window, WM_COPYDATA, 0, NativeInt(@CopyDataStruct));
    end;
    SetForegroundWindow(Window);
  end;
end;

begin
  Main;

end.
