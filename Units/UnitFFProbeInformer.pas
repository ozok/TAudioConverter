{ *
  * Copyright (C) 2012-2015 ozok <ozok26@gmail.com>
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
// gets info from file by running "ffprobe.exe"
unit UnitFFProbeInformer;

interface

uses
  Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils;

type
  TFFProbeInfoStatus = (ffiReading, ffiDone);

type
  TFFProbeInformer = class(TObject)
  private
    FProcess: TJvCreateProcess;
    FStatus: TFFProbeInfoStatus;
    FFileName: string;
    FFFProbePath: string;
    FFFProbeOutput: TStringList;
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
  public
    property FFProbeStatus: TFFProbeInfoStatus read FStatus;
    property FFProbeOutput: TStringList read FFFProbeOutput;
    constructor Create(const FileName: string; const FFProbePath: string);
    destructor Destroy(); override;
    procedure Start();
  end;

implementation

{ TFFProbeInformer }

constructor TFFProbeInformer.Create(const FileName: string; const FFProbePath: string);
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

  FStatus := ffiReading;
  FFileName := FileName;
  FFFProbePath := FFProbePath;
  FFFProbeOutput := TStringList.Create;

end;

destructor TFFProbeInformer.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FFFProbeOutput);
  FProcess.Free;
end;

procedure TFFProbeInformer.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
begin
  FStatus := ffiReading;
  try
    FFFProbeOutput.AddStrings(FProcess.ConsoleOutput);
  finally
    FStatus := ffiDone;
  end;
end;

procedure TFFProbeInformer.Start;
begin

  FProcess.ApplicationName := FFFProbePath;
  FProcess.CommandLine := '  -print_format json -show_streams -show_format -pretty -i "' + FFileName + '"';
  FProcess.Run;

end;

end.

