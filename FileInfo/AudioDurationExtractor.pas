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

unit AudioDurationExtractor;

interface

uses
  Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, IniFiles;

type
  TFFProbeStatus = (ffpReading, ffpDone);

type
  TAudioDurationExtractor = class(TObject)
  private
    FProcess: TJvCreateProcess;
    FStatus: TFFProbeStatus;
    FFileName: string;
    FFFProbePath: string;
    FTempFolder: string;
    FDuration: Extended;
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    function IsStringNumeric(Str: string): Boolean;
  public
    property FFProbeStatus: TFFProbeStatus read FStatus;
    property Duration: Extended read FDuration;
    constructor Create(const FileName: string; const FFProbePath: string; const TempFolder: string);
    destructor Destroy(); override;
    procedure Start();
  end;

implementation

{ TAudioDurationExtractor }

constructor TAudioDurationExtractor.Create(const FileName: string; const FFProbePath: string; const TempFolder: string);
begin
  inherited Create;

  FDuration := 0;
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

  FStatus := ffpReading;
  FFileName := FileName;
  FFFProbePath := FFProbePath;
  FTempFolder := TempFolder;

end;

destructor TAudioDurationExtractor.Destroy;
begin
  inherited Destroy;
  FProcess.Free;
end;

function TAudioDurationExtractor.IsStringNumeric(Str: string): Boolean;
var
  p: PChar;
begin

  if Length(Str) < 1 then
  begin
    Result := False;
    exit;
  end;

  p := PChar(Str);
  Result := False;

  while p^ <> #0 do
  begin

    if (not CharInSet(p^, ['0'..'9'])) then
    begin
      exit;
    end;

    Inc(p);
  end;

  Result := true;

end;

procedure TAudioDurationExtractor.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
var
  I: Integer;
  InfoFile: TMemIniFile;
  Sections: TStringList;
  duration_ts, time_base: Int64;
  time_base_str: string;
  duration_ts_str: string;
begin
  FStatus := ffpReading;

  if FileExists(FTempFolder + '\info.ini') then
  begin
    DeleteFile(FTempFolder + '\info.ini')
  end;

  FProcess.ConsoleOutput.SaveToFile(FTempFolder + '\info.ini');
  InfoFile := TMemIniFile.Create(FTempFolder + '\info.ini');
  Sections := TStringList.Create;
  try
    InfoFile.ReadSections(Sections);
    if Sections.Count > 0 then
    begin
      for I := 0 to Sections.Count - 1 do
      begin
        with InfoFile do
        begin
          duration_ts_str := ReadString(Sections[i], 'duration_ts', '0');
          time_base_str := ReadString(Sections[i], 'time_base', '0');
          time_base_str := ReplaceStr(time_base_str, '1/', '');

          if IsStringNumeric(duration_ts_str) and IsStringNumeric(time_base_str) then
          begin
            time_base := StrToInt64(time_base_str);
            duration_ts := StrToInt64(duration_ts_str);
            if time_base > 0 then
            begin
              FDuration := (duration_ts / time_base) * 1000;
            end;
            Break;
          end;
        end;
      end;
    end;
  finally
    InfoFile.Free;
    FreeAndNil(Sections);
    FStatus := ffpDone;
  end;

end;

procedure TAudioDurationExtractor.Start;
begin

  FProcess.ApplicationName := FFFProbePath;
  FProcess.CommandLine := '  -print_format ini -show_streams -pretty -i "' + FFileName + '"';
  FProcess.Run;

end;

end.

