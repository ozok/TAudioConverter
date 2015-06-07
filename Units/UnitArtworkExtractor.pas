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
// copies artwork from source to destination using "TArtworkExtractor"
unit UnitArtworkExtractor;

interface

uses Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, IniFiles;

type
  TArtworkExtractorStatus = (aeReading, aeDone);

type
  TArtworkExtractor = class(TObject)
  private
    FProcess: TJvCreateProcess;
    FStatus: TArtworkExtractorStatus;
    FFileName: string;
    FDestFile: string;
    FArtworkExtractorPath: string;
    FExtension: string;

    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);

  public
    property AEStatus: TArtworkExtractorStatus read FStatus;
    property Extension: string read FExtension;

    constructor Create(const FileName: string; const DesFile: string; const ArtworkExtractorPath: string);
    destructor Destroy(); override;

    procedure Start();
  end;

implementation

{ TArtworkExtractor }

constructor TArtworkExtractor.Create(const FileName: string; const DesFile: string; const ArtworkExtractorPath: string);
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

  FStatus := aeReading;
  FFileName := FileName;
  FDestFile := DesFile;
  FArtworkExtractorPath := ArtworkExtractorPath;
  FExtension := 'fff';

end;

destructor TArtworkExtractor.Destroy;
begin
  inherited Destroy;
  FProcess.Free;
end;

procedure TArtworkExtractor.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
begin
  FStatus := aeReading;
  try
    if FProcess.ConsoleOutput.Count > 0 then
    begin
      FExtension := FProcess.ConsoleOutput[0];
    end
    else
    begin
      FExtension := 'fff';
    end;
  finally
    FStatus := aeDone;
  end;
end;

procedure TArtworkExtractor.Start;
begin

  FProcess.ApplicationName := FArtworkExtractorPath;
  FProcess.CommandLine := ' " " " " "' + FFileName + '" "' + FDestFile + '"';
  FProcess.Run;

end;

end.
