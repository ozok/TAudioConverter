unit UnitPlayer;

interface

uses System.Classes, BASS, BASS_AAC, BASSFLAC, BassWMA, BASSWV, BASS_AC3,
  BASS_ALAC, BASS_APE, BASS_MPC, BASS_OFR, BASS_SPX, BASS_TTA, BassOPUS,
  Windows, SysUtils, StrUtils, Generics.Collections, MediaInfoDll;

type
  TPlayerStatus = (psPlaying = 0, psPaused = 1, psStopped = 2, psStalled = 3, psUnkown = 4);

type
  TPlayer = class
  private
    FBassHandle: HSTREAM;
    FPlayerStatus: TPlayerStatus;
    FErrorMsg: integer;
    FBassError: Integer;
    FFileName: string;
    FVolumeLevel: integer;
    FPositionAsSec: integer;
    FStartPoint: Integer;
    FEndPoint: Integer;

    function GetBassStreamStatus: TPlayerStatus;
    function GetTotalLength(): int64;
    function GetPosition(): int64;
    function GetLevels: Cardinal;
    function GetPositionStr: string;
    function GetSecondDuration: Integer;
    function IsM4AALAC: Boolean;
    function HasReachedEnd: Boolean;
  public
    property PlayerStatus: TPlayerStatus read FPlayerStatus;
    property PlayerStatus2: TPlayerStatus read GetBassStreamStatus;
    property ErrorMsg: Integer read FErrorMsg;
    property FileName: string read FFileName write FFileName;
    property TotalLength: int64 read GetTotalLength;
    property Position: int64 read GetPosition;
    property Levels: Cardinal read GetLevels;
    property PositionStr: string read GetPositionStr;
    property DurationAsSec: integer read GetSecondDuration;
    property PositionAsSec: integer read FPositionAsSec;
    property StartPoint: Integer read FStartPoint write FStartPoint;
    property EndPoint: Integer read FEndPoint write FEndPoint;
    property BassError: Integer read FBassError;
    property ReachedEnd: Boolean read HasReachedEnd;

    constructor Create(const WinHandle: Cardinal);
    destructor Destroy; override;

    procedure Play;
    procedure Stop;
    procedure Pause;
    procedure Resume;
    procedure SetVolume(const Volume: integer);
    function SetPosition(const Position: int64): Boolean;
    function IntToTime(IntTime: Integer): string;
    function CalcPositions(const Position: int64): integer;
  end;

const
  MY_ERROR_OK = 0;
  MY_ERROR_BASS_NOT_LOADED = 1;
  MY_ERROR_COULDNT_STOP_STREAM = 2;
  MY_ERROR_STREAM_ZERO = 3;
  MY_ERROR_UNKOWN_FORMAT = 4;

implementation

{ TPlayer }

function TPlayer.CalcPositions(const Position: int64): integer;
begin
  // Result := Round(BASS_ChannelSeconds2Bytes(FBassHandle, Position));
end;

constructor TPlayer.Create(const WinHandle: Cardinal);
begin
  FPlayerStatus := psStopped;
  FErrorMsg := MY_ERROR_OK;

  if not BASS_Init(-1, 44100, 0, WinHandle, nil) then
  begin
    FErrorMsg := MY_ERROR_BASS_NOT_LOADED;
    FBassError := BASS_ErrorGetCode;
  end;
end;

destructor TPlayer.Destroy;
begin
  BASS_StreamFree(FBassHandle);
  BASS_Free();
  inherited;
end;

function TPlayer.GetBassStreamStatus: TPlayerStatus;
begin
  case BASS_ChannelIsActive(FBassHandle) of
    BASS_ACTIVE_STOPPED:
      REsult := psStopped;
    BASS_ACTIVE_PLAYING:
      REsult := psPlaying;
    BASS_ACTIVE_STALLED:
      REsult := psStalled;
    BASS_ACTIVE_PAUSED:
      REsult := psPaused;
  else
    REsult := psUnkown;
  end;
end;

function TPlayer.GetLevels: Cardinal;
begin
  REsult := BASS_ChannelGetLevel(FBassHandle);
end;

function TPlayer.GetPosition: int64;
begin
  REsult := 0;
  if FBassHandle > 0 then
  begin
    REsult := BASS_ChannelGetPosition(FBassHandle, BASS_POS_BYTE);
  end;
end;

function TPlayer.GetPositionStr: string;
begin
  if FBassHandle > 0 then
  begin
    FPositionAsSec := Round(BASS_ChannelBytes2Seconds(FBassHandle, BASS_ChannelGetPosition(FBassHandle, BASS_POS_BYTE)));
    REsult := IntToTime(FPositionAsSec);
  end;
end;

function TPlayer.GetSecondDuration: Integer;
begin
  REsult := 0;
  if FBassHandle > 0 then
  begin
    REsult := Round(BASS_ChannelBytes2Seconds(FBassHandle, BASS_ChannelGetLength(FBassHandle, BASS_POS_BYTE)));
  end;
end;

function TPlayer.GetTotalLength: int64;
begin
  REsult := 0;
  if FBassHandle > 0 then
  begin
    REsult := BASS_ChannelGetLength(FBassHandle, BASS_POS_BYTE);
  end;
end;

function TPlayer.HasReachedEnd: Boolean;
begin
  REsult := FPositionAsSec >= FEndPoint;
end;

function TPlayer.IntToTime(IntTime: Integer): string;
var
  hour: Integer;
  second: Integer;
  minute: Integer;
  strhour: string;
  strminute: string;
  strsecond: String;
begin

  if (Time > 0) then
  begin

    hour := IntTime div 3600;
    minute := (IntTime div 60) - (hour * 60);
    second := (IntTime mod 60);

    if (second < 10) then
    begin
      strsecond := '0' + FloatToStr(second);
    end
    else
    begin
      strsecond := FloatToStr(second);
    end;

    if (minute < 10) then
    begin
      strminute := '0' + FloatToStr(minute);
    end
    else
    begin
      strminute := FloatToStr(minute);
    end;

    if (hour < 10) then
    begin
      strhour := '0' + FloatToStr(hour);
    end
    else
    begin
      strhour := FloatToStr(hour);
    end;

    REsult := strhour + ':' + strminute + ':' + strsecond;
  end
  else
  begin
    REsult := '00:00:00';
  end;
end;

function TPlayer.IsM4AALAC: Boolean;
var
  MediaInfoHandle: Cardinal;
  LCodec: string;
begin
  REsult := False;

  if (FileExists(FFileName)) then
  begin

    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();

    if MediaInfoHandle <> 0 then
    begin

      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FFileName));
        MediaInfo_Option(0, 'Complete', '1');

        LCodec := Trim(MediaInfo_Get(MediaInfoHandle, Stream_Audio, 0, 'Codec', Info_Text, Info_Name));
        REsult := 'alac' = LCodec;
      finally
        MediaInfo_Close(MediaInfoHandle);
      end;
    end;
  end;
end;

procedure TPlayer.Pause;
begin
  if GetBassStreamStatus = psPlaying then
  begin
    if BASS_ChannelPause(FBassHandle) then
      FPlayerStatus := psPaused;
  end;
end;

procedure TPlayer.Play;
var
  LExt: string;
begin
  if FBassHandle > 0 then
  begin
    if not BASS_ChannelStop(FBassHandle) then
    begin
      FErrorMsg := MY_ERROR_COULDNT_STOP_STREAM;
      FBassError := BASS_ErrorGetCode;
      exit;
    end;
  end;

  FPositionAsSec := 0;

  LExt := LowerCase(ExtractFileExt(FFileName));
  if (LExt = '.aac') or (LExt = '.m4b') then
  begin
    FBassHandle := BASS_MP4_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.m4a') then
  begin
    if IsM4AALAC then
    begin
      FBassHandle := BASS_ALAC_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT)
    end
    else
    begin
      FBassHandle := BASS_MP4_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
    end;
  end
  else if (LExt = '.flac') then
  begin
    FBassHandle := BASS_FLAC_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.ape') then
  begin
    FBassHandle := BASS_APE_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.ac3') then
  begin
    FBassHandle := BASS_AC3_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.wv') then
  begin
    FBassHandle := BASS_WV_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.ofr') then
  begin
    FBassHandle := BASS_OFR_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.spx') then
  begin
    FBassHandle := BASS_SPX_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.tta') then
  begin
    FBassHandle := BASS_TTA_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.opus') then
  begin
    FBassHandle := BASS_OPUS_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else if (LExt = '.mp3') or (LExt = '.mp2') or (LExt = '.mp1') or (LExt = '.ogg') or (LExt = '.wav') or (LExt = '.aiff') or (LExt = '.aif') then
  begin
    FBassHandle := Bass_StreamCreateFile(False, PCHAR(FFileName), 0, 0, BASS_SAMPLE_FX or BASS_UNICODE or BASS_STREAM_PRESCAN or BASS_SAMPLE_FLOAT);
  end
  else
  begin
    FBassHandle := 0;
    FPlayerStatus := psStopped;
    FErrorMsg := MY_ERROR_UNKOWN_FORMAT;
    FBassError := BASS_ErrorGetCode;
  end;

  if FBassHandle > 0 then
  begin
    if BASS_ChannelPlay(FBassHandle, False) then
    begin
      BASS_ChannelSetPosition(FBassHandle, BASS_ChannelSeconds2Bytes(FBassHandle, FStartPoint), BASS_POS_BYTE);
      FErrorMsg := MY_ERROR_OK;
      FPlayerStatus := psPlaying;
    end
    else
    begin
      FErrorMsg := MY_ERROR_STREAM_ZERO;
      FBassError := BASS_ErrorGetCode;
      FPlayerStatus := psStopped;
    end;
  end;
end;

procedure TPlayer.Resume;
begin
  if GetBassStreamStatus = psPaused then
  begin
    if BASS_ChannelPlay(FBassHandle, False) then
      FPlayerStatus := psPlaying;
  end;
end;

function TPlayer.SetPosition(const Position: int64): Boolean;
begin
  REsult := BASS_ChannelSetPosition(FBassHandle, Position, BASS_POS_BYTE);
end;

procedure TPlayer.SetVolume(const Volume: integer);
begin
  if BASS_ChannelSetAttribute(FBassHandle, BASS_ATTRIB_VOL, Volume / 100.0) then
  begin
    FVolumeLevel := Volume;
  end;
end;

procedure TPlayer.Stop;
begin
  if GetBassStreamStatus <> psStopped then
  begin
    if BASS_ChannelStop(FBassHandle) then
      FPlayerStatus := psStopped;
  end;
end;

end.
