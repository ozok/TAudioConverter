{*
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
 *}
// gets info, mainly audio tracks, using "ffprobe.exe"
unit UnitFileInfo;

interface

uses Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, IniFiles;

type
  TStatus = (fsReading, fsDone);

type
  TFileInfo = class(TObject)
  private
    FProcess: TJvCreateProcess;
    FStatus: TStatus;
    FFileName: string;
    FFFprobePath: string;
    FAudioTrackIndexes: TStringList;
    FTempFolder: string;

    procedure ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);

  public
    property FileInfoStatus: TStatus read FStatus;
    property AudioStreamIndexes: TStringList read FAudioTrackIndexes;

    constructor Create(const FileName: string; const FFMpegPath: string; const TempFolder: string);
    destructor Destroy(); override;

    procedure Start();
  end;

implementation

{ TFileInfo }

constructor TFileInfo.Create(const FileName: string; const FFMpegPath: string; const TempFolder: string);
begin
  inherited Create;

  FProcess := TJvCreateProcess.Create(nil);
  with FProcess do
  begin
    OnRead := ProcessRead;
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

  FStatus := fsReading;
  FFileName := FileName;
  FFFprobePath := FFMpegPath;
  FAudioTrackIndexes := TStringList.Create;
  FTempFolder := TempFolder;

end;

destructor TFileInfo.Destroy;
begin
  inherited Destroy;
  FProcess.Free;
  FreeAndNil(FAudioTrackIndexes);
end;

procedure TFileInfo.ProcessRead(Sender: TObject; const S: string;
  const StartsOnNewLine: Boolean);
const
  Output = 'Output';
  Input = 'Input';
begin

end;

procedure TFileInfo.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
const
  Audio = 'audio';
var
  LIni: TMemIniFile;
  LSections: TStringList;
  I: Integer;
begin
  FStatus := fsReading;

  if FileExists(FTempFolder + '\fileinfo.ini') then
  begin
    DeleteFile(FTempFolder + '\fileinfo.ini')
  end;

  FProcess.ConsoleOutput.SaveToFile(FTempFolder + '\fileinfo.ini');

  LIni := TMemIniFile.Create(FTempFolder + '\fileinfo.ini');
  try
    LSections := TStringList.Create;
    try
      LIni.ReadSections(LSections);
      for I := 0 to LSections.Count-1 do
      begin
        if Audio = LIni.ReadString(LSections[i], 'codec_type', '') then
        begin
          FAudioTrackIndexes.Add(LIni.ReadString(LSections[i], 'index', '0'));
        end;
      end;
    finally
      LSections.Free;
    end;
  finally
    LIni.Free;
    FStatus := fsDone;
  end;

end;

procedure TFileInfo.Start;
begin

  FProcess.ApplicationName := FFFprobePath;
  FProcess.CommandLine := '  -print_format ini -show_streams -show_format -pretty -i "' + FFileName + '"';
  FProcess.Run;

end;

end.
