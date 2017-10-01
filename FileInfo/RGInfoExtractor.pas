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
// extracts RG info from source to copy (if source and dest. are lossless)
unit RGInfoExtractor;

interface

uses
  Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils;

type
  TRGInfoStatus = (rsReading, rsDone);

type
  TRGInfo = record
    ALBUM_GAIN: string;
    ALBUM_PEAK: string;
    TRACK_GAIN: string;
    TRACK_PEAK: string;
  end;

type
  TRGInfoExtractor = class(TObject)
  private
    FProcess: TJvCreateProcess;
    FStatus: TRGInfoStatus;
    FFileName: string;
    FFFProbePath: string;
    FRGInfo: TRGInfo;
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
  public
    property RGInfoStatus: TRGInfoStatus read FStatus;
    property RGInfo: TRGInfo read FRGInfo;
    constructor Create(const FileName: string; const FFProbePath: string);
    destructor Destroy(); override;
    procedure Start();
  end;

implementation

{ TRGInfoExtractor }

constructor TRGInfoExtractor.Create(const FileName, FFProbePath: string);
begin
  inherited Create;

  FProcess := TJvCreateProcess.Create(nil);
  with FProcess do
  begin
    OnTerminate := ProcessTerminate;
    ConsoleOptions := [coRedirect];
    CreationFlags := [cfUnicode];
    Priority := ppIdle;

    with StartupInfo do
    begin
      DefaultPosition := False;
      DefaultSize := False;
      DefaultWindowState := False;
      ShowWindow := swHide;
    end;

    WaitForTerminate := true;
  end;

  FStatus := rsReading;
  FFileName := FileName;
  FFFProbePath := FFProbePath;
end;

destructor TRGInfoExtractor.Destroy;
begin
  inherited;
  FProcess.Free;
end;

procedure TRGInfoExtractor.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
const
  ALBUM_GAIN_STR = '"REPLAYGAIN_ALBUM_GAIN":';
  ALBUM_PEAK_STR = '"REPLAYGAIN_ALBUM_PEAK":';
  TRACK_GAIN_STR = '"REPLAYGAIN_TRACK_GAIN":';
  TRACT_PEAK_STR = '"REPLAYGAIN_TRACK_PEAK":';
var
  I: Integer;
  FLine: string;
  LTmpStr: string;
begin

  FStatus := rsReading;
  try
    // default values are '' so when copying, we can ignore fields
    // that don't exist
    FRGInfo.ALBUM_GAIN := '';
    FRGInfo.ALBUM_PEAK := '';
    FRGInfo.TRACK_GAIN := '';
    FRGInfo.TRACK_PEAK := '';

    // scan ffprobe output for rg tags
    for I := 0 to FProcess.ConsoleOutput.Count - 1 do
    begin
      FLine := Trim(FProcess.ConsoleOutput[i]);

      if Copy(FLine, 1, Length(ALBUM_GAIN_STR)) = ALBUM_GAIN_STR then
      begin
        LTmpStr := FLine;
        LTmpStr := ReplaceStr(LTmpStr, ALBUM_GAIN_STR, '');
        LTmpStr := StringReplace(LTmpStr, '"', '', [rfReplaceAll]);
        LTmpStr := ReplaceStr(LTmpStr, ',', '');
        LTmpStr := ReplaceStr(LTmpStr, 'dB', '');
        FRGInfo.ALBUM_GAIN := Trim(LTmpStr);
      end
      else if Copy(FLine, 1, Length(ALBUM_PEAK_STR)) = ALBUM_PEAK_STR then
      begin
        LTmpStr := FLine;
        LTmpStr := ReplaceStr(LTmpStr, ALBUM_PEAK_STR, '');
        LTmpStr := StringReplace(LTmpStr, '"', '', [rfReplaceAll]);
        LTmpStr := ReplaceStr(LTmpStr, ',', '');
        LTmpStr := ReplaceStr(LTmpStr, 'dB', '');
        FRGInfo.ALBUM_PEAK := Trim(LTmpStr);
      end
      else if Copy(FLine, 1, Length(TRACK_GAIN_STR)) = TRACK_GAIN_STR then
      begin
        LTmpStr := FLine;
        LTmpStr := ReplaceStr(LTmpStr, TRACK_GAIN_STR, '');
        LTmpStr := StringReplace(LTmpStr, '"', '', [rfReplaceAll]);
        LTmpStr := ReplaceStr(LTmpStr, ',', '');
        LTmpStr := ReplaceStr(LTmpStr, 'dB', '');
        FRGInfo.TRACK_GAIN := Trim(LTmpStr);
      end
      else if Copy(FLine, 1, Length(TRACT_PEAK_STR)) = TRACT_PEAK_STR then
      begin
        LTmpStr := FLine;
        LTmpStr := ReplaceStr(LTmpStr, TRACT_PEAK_STR, '');
        LTmpStr := StringReplace(LTmpStr, '"', '', [rfReplaceAll]);
        LTmpStr := ReplaceStr(LTmpStr, ',', '');
        LTmpStr := ReplaceStr(LTmpStr, 'dB', '');
        FRGInfo.TRACK_PEAK := Trim(LTmpStr);
      end;
    end;
  finally
    FStatus := rsDone;
  end;

end;

procedure TRGInfoExtractor.Start;
begin
  FProcess.ApplicationName := FFFProbePath;
  FProcess.CommandLine := '  -print_format json -show_streams -show_format -pretty -i "' + FFileName + '"';
  FProcess.Run;
end;

end.

