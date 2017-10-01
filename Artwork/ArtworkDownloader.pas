unit ArtworkDownloader;

interface

uses
  Classes, Windows, SysUtils, Messages, StrUtils, IdBaseComponent,
  IdThreadComponent, Vcl.ComCtrls, IdThread, Generics.Collections,
  JvComponentBase, JvUrlListGrabber, JvUrlGrabbers, JvTypes, ImageResize;

type
  TDownloadStatus = (idle = 0, downloading = 1, done = 2, error = 3, gettinginfo = 4);

type
  TDownloadParams = packed record
    Artist: string;
    Album: string;
    Resize: Boolean;
    Width: Integer;
    Height: Integer;
  end;

type
  TArtworkDownloader = class(TObject)
  private
    FDownloadThread: TIdThreadComponent;
    FPageDownloader: TJvHttpUrlGrabber;
    FPicDownloader: TJvHttpUrlGrabber;
    FStatus: TDownloadStatus;
    FParams: TDownloadParams;
    FErrorCode: Integer;
    FProgress: Integer;
    FErrorMsg: string;
    FImageURL: string;
    FImagePath: string;

    // thread events
    procedure ThreadRun(Sender: TIdThreadComponent);
    procedure ThreadStopped(Sender: TIdThreadComponent);
    procedure ThreadTerminate(Sender: TIdThreadComponent);
    // downloader events
    procedure PageDownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
    procedure PageDownloaderProgress(Sender: TObject; Position, TotalSize: Int64; Url: string; var Continue: Boolean);
    procedure PageDownloaderError(Sender: TObject; ErrorMsg: string);
    procedure PageDownloaderDoneFile(Sender: TObject; FileName: string; FileSize: Integer; Url: string);
    procedure PageDownloaderProgress2(Sender: TObject; Position, TotalSize: Int64; Url: string; var Continue: Boolean);
    procedure PageDownloaderError2(Sender: TObject; ErrorMsg: string);
    function GetStatusStr: string;
    function GetErrorMsg: string;
  public
    property Status: TDownloadStatus read FStatus;
    property StatusStr: string read GetStatusStr;
    property Progress: Integer read FProgress;
    property ErrorCode: Integer read FErrorCode;
    property ErrorMsg: string read FErrorMsg;
    property ImageURL: string read FImageURL;
    property ImagePath: string read FImagePath write FImagePath;
    property DownloaderErrorMsg: string read GetErrorMsg;
    constructor Create(const Params: TDownloadParams);
    destructor Destroy; override;
    procedure Start();
    procedure Stop();
  end;

implementation

const
  // TAC last.fm API key
  API_KEY = '261fbb84f8c6cbd703a1fb3b21c97ad4';
  // request url
  REQ_STR = 'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=%s&artist=%s&album=%s';
  // line in the xml that contains the link to 300x300 image
  IMAGE_INFO_LINE = '<image size="extralarge">';
  // error codes
  ERROR_OK = 0;
  ERROR_JSON_EMPTY = 1;
  ERROR_URL_IS_EMPTY = 2;
  ERROR_IMAGE_EMPTY = 3;

  { TArtworkDownloader }

constructor TArtworkDownloader.Create(const Params: TDownloadParams);
var
  Def: TJvCustomUrlGrabberDefaultProperties;
begin
  // thread
  FDownloadThread := TIdThreadComponent.Create;
  FDownloadThread.Priority := tpIdle;
  FDownloadThread.StopMode := smTerminate;
  FDownloadThread.OnRun := ThreadRun;
  FDownloadThread.OnStopped := ThreadStopped;
  FDownloadThread.OnTerminate := ThreadTerminate;

  // page downloader
  Def := TJvCustomUrlGrabberDefaultProperties.Create(nil);
  FPageDownloader := TJvHttpUrlGrabber.Create(nil, '', Def);
  with FPageDownloader do
  begin
    OnDoneStream := PageDownloaderDoneStream;
    OnProgress := PageDownloaderProgress;
    OnError := PageDownloaderError;
    OutputMode := omStream;
    Agent := 'TAudioConverter';
  end;
  // image downloader
  FPicDownloader := TJvHttpUrlGrabber.Create(nil, '', Def);
  with FPicDownloader do
  begin
    OnDoneFile := PageDownloaderDoneFile;
    OnProgress := PageDownloaderProgress2;
    OnError := PageDownloaderError2;
    OutputMode := omFile;
    // Agent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0';
    Agent := 'TAudioConverter';
  end;

  // defaults
  FStatus := idle;
  FParams := Params;
  FErrorCode := ERROR_OK;
end;

destructor TArtworkDownloader.Destroy;
begin
  inherited Destroy;
  FDownloadThread.Free;
  FPageDownloader.Free;
  FPicDownloader.Free;
end;

function TArtworkDownloader.GetErrorMsg: string;
begin
  case FErrorCode of
    ERROR_OK:
      Result := 'OK';
    ERROR_JSON_EMPTY:
      Result := 'No response from last.fm';
    ERROR_URL_IS_EMPTY:
      Result := 'Couldn''t find image';
    ERROR_IMAGE_EMPTY:
      Result := 'Downloaded image is invalid';
  end;
end;

function TArtworkDownloader.GetStatusStr: string;
begin
  case FStatus of
    idle:
      Result := 'idle';
    downloading:
      Result := 'downloading';
    done:
      Result := 'done';
    error:
      Result := 'error';
    gettinginfo:
      Result := 'gettinginfo';
  end;
end;

procedure TArtworkDownloader.PageDownloaderDoneFile(Sender: TObject; FileName: string; FileSize: Integer; Url: string);
var
  LIR: TImageResizer;
begin
  FStatus := downloading;
  if FileSize < 1 then
  begin
    FErrorCode := ERROR_IMAGE_EMPTY;
    FStatus := error;
  end
  else
  begin
    if FParams.Resize then
    begin
      LIR := TImageResizer.Create(FImagePath, FImagePath);
      try
        LIR.Width := FParams.Width;
        LIR.Height := FParams.Height;
      finally
        LIR.Free;
      end;
    end;
    FErrorCode := ERROR_OK;
    FStatus := done;
  end;
end;

procedure TArtworkDownloader.PageDownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
var
  LLine: string;
  LTmpList: TStringList;
  I: Integer;
begin
  FStatus := downloading;
  if StreamSize > 0 then
  begin
    FErrorCode := ERROR_OK;
    LTmpList := TStringList.Create;
    try
      LTmpList.LoadFromStream(Stream);
      for I := 0 to LTmpList.Count - 1 do
      begin
        LLine := Trim(LTmpList[i]);
        if IMAGE_INFO_LINE = Copy(LLine, 1, Length(IMAGE_INFO_LINE)) then
        begin
          FImageURL := LLine;
          FImageURL := StringReplace(FImageURL, IMAGE_INFO_LINE, '', [rfReplaceAll]);
          FImageURL := StringReplace(FImageURL, '</image>', '', [rfReplaceAll]);
          Break;
        end;
      end;

      FImageURL := Trim(FImageURL);
      if Length(FImageURL) < 1 then
      begin
        FErrorCode := ERROR_URL_IS_EMPTY;
        FStatus := error;
      end
      else
      begin
        FErrorCode := ERROR_OK;
        FStatus := downloading;
        FPicDownloader.Url := FImageURL;
        FPicDownloader.FileName := FImagePath;
        ;
        FPicDownloader.Start;
      end;
    finally
      LTmpList.Free;
    end;
  end
  else
  begin
    FStatus := error;
    FErrorCode := ERROR_JSON_EMPTY;
  end;
end;

procedure TArtworkDownloader.PageDownloaderError(Sender: TObject; ErrorMsg: string);
begin
  FErrorMsg := ErrorMsg;
end;

procedure TArtworkDownloader.PageDownloaderError2(Sender: TObject; ErrorMsg: string);
begin
  FErrorMsg := ErrorMsg;
end;

procedure TArtworkDownloader.PageDownloaderProgress(Sender: TObject; Position, TotalSize: Int64; Url: string; var Continue: Boolean);
begin
  if TotalSize > 0 then
    FProgress := (100 * Position) div TotalSize;
end;

procedure TArtworkDownloader.PageDownloaderProgress2(Sender: TObject; Position, TotalSize: Int64; Url: string; var Continue: Boolean);
begin
  if TotalSize > 0 then
    FProgress := (100 * Position) div TotalSize;
end;

procedure TArtworkDownloader.Start;
begin
  // start the thread.
  // it'll start downloading
  FStatus := downloading;
  FDownloadThread.Start;
end;

procedure TArtworkDownloader.Stop;
begin
  if not FDownloadThread.Stopped then
  begin
    FPageDownloader.Stop;
    FDownloadThread.Terminate;
  end;
end;

procedure TArtworkDownloader.ThreadRun(Sender: TIdThreadComponent);
begin
  FPageDownloader.Url := Format(REQ_STR, [API_KEY, FParams.Artist, FParams.Album]);
  FPageDownloader.Start;
end;

procedure TArtworkDownloader.ThreadStopped(Sender: TIdThreadComponent);
begin
  // FStatus := done;
end;

procedure TArtworkDownloader.ThreadTerminate(Sender: TIdThreadComponent);
begin
  // FStatus := done;
end;

end.

