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
// handles running encoders/decoders and returning their outputs
unit Encoder;

interface

uses
  Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, Psapi,
  tlhelp32, Dialogs, Generics.Collections, CustomEnums, ComCtrls;

type
  TEncoderStatus = (esEncoding, esStopped, esDone);

type
  TEncoder = class(TObject)
  private
    FProcess: TJvCreateProcess;
    FCommandLines: TStringList;
    FPaths: TStringList;
    FCommandIndex: integer;
    FConsoleOutput: string;
    FEncoderStatus: TEncoderStatus;
    FStoppedByUser: Boolean;
    FFileNames: TStringList;
    FProcessTypes: TEncoderTypeList;
    FDurations: TStringList;
    FInfos: TStringList;
    FFileIndexes: TStringList;
    FTempFiles: TStringList;
    FUsingSox: Boolean;
    FItem: TListItem;
    FListItems: TStringList;
    FUpdateCounter: integer;
    procedure ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    function GetProcessID: integer;
    function GetFileName: string;
    function GetCurrentProcessType: TEncoderType;
    function GetCurrentDuration: string;
    function GetInfo: string;
    function GetCommandCount: integer;
    function GetExeName: string;
    function GetFileIndex: Integer;
    function GetListItem: string;
    function GetPercentage: integer;
  public
    property ConsoleOutput: string read FConsoleOutput;
    property EncoderStatus: TEncoderStatus read FEncoderStatus;
    property CommandLines: TStringList read FCommandLines write FCommandLines;
    property Paths: TStringList read FPaths write FPaths;
    property FileNames: TStringList read FFileNames;
    property FilesDone: integer read FCommandIndex;
    property ProcessID: integer read GetProcessID;
    property CurrentFile: string read GetFileName;
    property Durations: TStringList read FDurations write FDurations;
    property ProcessTypes: TList<TEncoderType> read FProcessTypes write FProcessTypes;
    property CurrentProcessType: TEncoderType read GetCurrentProcessType;
    property CurrentDuration: string read GetCurrentDuration;
    property Info: string read GetInfo;
    property Infos: TStringList read FInfos write FInfos;
    property CommandCount: integer read GetCommandCount;
    property ExeName: string read GetExeName;
    property FileIndexes: TStringList read FFileIndexes write FFileIndexes;
    property FileIndex: Integer read GetFileIndex;
    property TempFiles: TStringList read FTempFiles write FTempFiles;
    property UsingSox: Boolean read FUsingSox write FUsingSox;
    property ListItems: TStringList read FListItems write FListItems;
    constructor Create();
    destructor Destroy(); override;
    procedure Start();
    procedure Stop();
    procedure ResetValues();
    function GetConsoleOutput(): TStrings;
    procedure TerminateProcessTree(const ProcessID: Cardinal);
  end;

implementation

uses
  UnitMain;

{ TEncoder }

constructor TEncoder.Create;
begin
  inherited Create;

  // this the process that's run
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

  // create and assign default values
  FCommandLines := TStringList.Create;
  FPaths := TStringList.Create;
  FFileNames := TStringList.Create;
  FEncoderStatus := esStopped;
  FStoppedByUser := False;
  FProcessTypes := TEncoderTypeList.Create;
  FDurations := TStringList.Create;
  FInfos := TStringList.Create;
  FFileIndexes := TStringList.Create;
  FCommandIndex := 0;
  FTempFiles := TStringList.Create;
  FUsingSox := False;
  FListItems := TStringList.Create;
end;

destructor TEncoder.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FCommandLines);
  FreeAndNil(FPaths);
  FreeAndNil(FInfos);
  FreeAndNil(FFileNames);
  FreeAndNil(FProcessTypes);
  FreeAndNil(FDurations);
  FreeAndNil(FFileIndexes);
  FreeAndNil(FTempFiles);
  FreeAndNil(FListItems);
  FProcess.Free;
end;

function TEncoder.GetCommandCount: integer;
begin
  Result := FCommandLines.Count;
end;

function TEncoder.GetConsoleOutput: TStrings;
begin
  Result := FProcess.ConsoleOutput;
end;

function TEncoder.GetCurrentDuration: string;
begin
  if FCommandIndex < FDurations.Count then
    Result := FDurations[FCommandIndex];
end;

function TEncoder.GetCurrentProcessType: TEncoderType;
begin
  Result := etFFMpeg;
  if FCommandIndex < FProcessTypes.Count then
    Result := FProcessTypes[FCommandIndex];
end;

function TEncoder.GetExeName: string;
begin
  if FCommandIndex < Paths.Count then
    Result := Paths[FCommandIndex];
end;

function TEncoder.GetFileIndex: Integer;
begin
  if FCommandIndex < FFileIndexes.Count then
    Result := StrToInt(FFileIndexes[FCommandIndex])
  else
    Result := -1;
end;

function TEncoder.GetFileName: string;
begin
  if FCommandIndex < FFileNames.Count then
    Result := FFileNames[FCommandIndex];
end;

function TEncoder.GetInfo: string;
begin
  if FCommandIndex < FInfos.Count then
    Result := FInfos[FCommandIndex];
end;

function TEncoder.GetListItem: string;
begin
  if FCommandIndex < FListItems.Count then
    Result := FListItems[FCommandIndex];
end;

function TEncoder.GetPercentage: integer;
begin
  Result := 0;
  if Length(FConsoleOutput) > 0 then
  begin
    if GetProcessID > 0 then
    begin
      // DebugMsg('Encoder type: ' + FloatToStr(Ord(Encoder.CurrentProcessType)));
      // decide running process kind
      // todo: case
      if (GetCurrentProcessType = etFFMpeg) or (GetCurrentProcessType = etFFMpegAC3) or (GetCurrentProcessType = etFFMpegAC3) then
      begin
        // audio decoding
        Result := MainForm.FFMpegPercentage(FConsoleOutput, GetCurrentDuration);
      end
      else if GetCurrentProcessType = etQAAC then
      begin
        // qaac
        Result := MainForm.x264Percentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etOgg then
      begin
        // ogg vorbis
        Result := MainForm.x264Percentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etSox then
      begin
        // sox
        Result := MainForm.SoXPercentage(FConsoleOutput)
      end
      else if GetCurrentProcessType = etLAME then
      begin
        // lame
        Result := MainForm.LamePercentage(FConsoleOutput)
      end
      else if GetCurrentProcessType = etFLAC then
      begin
        // flac
        Result := MainForm.FLACPercentage(FConsoleOutput)
      end
      else if GetCurrentProcessType = etFHGAAC then
      begin
        // fhg
        Result := MainForm.MkvExtractPercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etOpus then
      begin
        // opus
        Result := MainForm.OpusPercentage(FConsoleOutput, GetCurrentDuration);
      end
      else if GetCurrentProcessType = etMPC then
      begin
        // mpc
        Result := MainForm.MPCPercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etAPE then
      begin
        // ape
        Result := MainForm.ApePercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etTTA then
      begin
        // tta
        Result := MainForm.ApePercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etTAK then
      begin
        // tak
        Result := MainForm.TAKPercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etNeroAAC then
      begin
        // nero
        Result := MainForm.NeroPercentage(FConsoleOutput, FConsoleOutput);
      end
      else if GetCurrentProcessType = etFFmpegALAC then
      begin
        // alac
        Result := MainForm.FFMpegPercentage(FConsoleOutput, GetCurrentDuration);
      end
      else if GetCurrentProcessType = etWMA then
      begin
        // wmaencoder
        Result := MainForm.WMAEncoderPercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etWavPack then
      begin
        // wavpack
        Result := 0;
      end
      else if GetCurrentProcessType = etFDKAAC then
      begin
        // fdkaac
        Result := MainForm.FDKPercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etLossyWAV then
      begin
        // lossywav
        Result := MainForm.LossyWAVPercentage(FConsoleOutput);
      end
      else if GetCurrentProcessType = etTTagger then
      begin
        // ttagger
        Result := 0;
      end
      else if GetCurrentProcessType = etAACGain then
      begin
        // aacgain
        Result := 0;
      end
      else if GetCurrentProcessType = etDCA then
      begin
        // dcaen
        Result := MainForm.dcaencPercentage(FConsoleOutput);
      end;
    end;
  end;
end;

function TEncoder.GetProcessID: integer;
begin
  Result := FProcess.ProcessInfo.hProcess;
end;

procedure TEncoder.ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
var
  LProcessStr: string;
begin
  // just return backend's output
  FConsoleOutput := Trim(S);

  // update the item
  Inc(FUpdateCounter);
  // if FUpdateCounter = 5 then
  begin
    FUpdateCounter := 0;
    LProcessStr := GetInfo + ' ' + FloatToStr(GetPercentage) + '%';
    if FItem.SubItems.Count > 0 then
    begin
      if FItem.SubItems[0] <> LProcessStr then
      begin
        FItem.SubItems[0] := LProcessStr;
      end;
    end;
  end;
end;

procedure TEncoder.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
var
  i: integer;
  // delete queue is splitted by "|"
  TmpSplitList: TStringList;
begin
  MainForm.UpdateProgress;
  // add exit info to main log
  if ExitCode <> 0 then
  begin
    MainForm.AddToLog(0, '[' + ExtractFileName(FPaths[FCommandIndex]) + '] Exit code: ' + FloatToStr(ExitCode));
    FItem.SubItems[0] := 'Error';
    FItem.StateIndex := 3;
  end
  else
  begin
    FItem.SubItems[0] := 'Done ' + LowerCase(GetInfo);
    FItem.StateIndex := 2;
  end;

  // delete temp file
  if FCommandIndex < FTempFiles.Count then
  begin
    TmpSplitList := TStringList.Create;
    try
      TmpSplitList.StrictDelimiter := true;
      TmpSplitList.Delimiter := '|';
      TmpSplitList.DelimitedText := FTempFiles[FCommandIndex];
      if TmpSplitList.Count > 0 then
      begin
        for i := 0 to TmpSplitList.Count - 1 do
        begin
          if Length(TmpSplitList[i]) > 0 then
          begin
            if FileExists(TmpSplitList[i]) then
            begin
              if DeleteFile(TmpSplitList[i]) then
              begin
                MainForm.AddToLog(17, 'Encoder deleted: ' + TmpSplitList[i]);
              end
              else
              begin
                MainForm.AddToLog(17, 'Encoder failed to delete: ' + TmpSplitList[i]);
              end;
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(TmpSplitList);
    end;
  end;

  // status stopped
  FEncoderStatus := esStopped;
  // if not stopped by user,
  // run next command.
  if not FStoppedByUser then
  begin
    inc(FCommandIndex);
    if FCommandIndex < FCommandLines.Count then
    begin
      FProcess.CommandLine := FCommandLines[FCommandIndex];
      FProcess.ApplicationName := FPaths[FCommandIndex];
      if MainForm.ProgressStatePanel.Visible then
      begin
        // cd
        MainForm.CDProgressList.Items[StrToInt(FFileIndexes[FCommandIndex])].MakeVisible(False);
      end
      else
      begin
        // file
        if not MainForm.MergeTimer.Enabled then
        begin
          if Assigned(MainForm.ProgressList.Items[StrToInt(FFileIndexes[FCommandIndex])]) then
          begin
            FItem := MainForm.ProgressList.Items.Add;
            FItem.Caption := GetListItem;
            FItem.SubItems.Add('Running');
            FItem.StateIndex := 0;
            FItem.MakeVisible(False);
          end;
        end;
      end;
      FEncoderStatus := esEncoding;
      FConsoleOutput := '';
      FProcess.Run;
    end
    else
    begin
      FFileNames.Clear;
      FEncoderStatus := esDone;
    end;
  end;
end;

procedure TEncoder.ResetValues;
begin
  // reset all values so they can be used later
  FCommandLines.Clear;
  FPaths.Clear;
  FCommandIndex := 0;
  FConsoleOutput := '';
  FProcess.ConsoleOutput.Clear;
  FProcessTypes.Clear;
  FDurations.Clear;
  FStoppedByUser := False;
  FTempFiles.Clear;
  FFileIndexes.Clear;
  FInfos.Clear;
  FUsingSox := False;
  FListItems.Clear;
end;

procedure TEncoder.Start;
begin
  if FProcess.ProcessInfo.hProcess = 0 then
  begin
    if FCommandLines.Count > 0 then
    begin
      if FileExists(FPaths[0]) then
      begin
        FProcess.ApplicationName := FPaths[0];
        FProcess.CommandLine := FCommandLines[0];
        FEncoderStatus := esEncoding;
        FItem := MainForm.ProgressList.Items.Add;
        FItem.Caption := GetListItem;
        FItem.SubItems.Add('Running');
        FItem.StateIndex := 0;
        FProcess.Run;
      end
      else
        FConsoleOutput := 'encoder'
    end
    else
      FConsoleOutput := '0 cmd'
  end
  else
    FConsoleOutput := 'not 0'
end;

procedure TEncoder.Stop;
var
  FProcessIDTmp: DWORD;
begin
  if FProcess.ProcessInfo.hProcess > 0 then
  begin
    FProcessIDTmp := FProcess.ProcessInfo.dwProcessId;
    TerminateProcessTree(FProcessIDTmp);
    TerminateProcess(FProcess.ProcessInfo.hProcess, 0);

    FFileNames.Clear;
    FEncoderStatus := esStopped;
    FStoppedByUser := true;
  end;
end;

procedure TEncoder.TerminateProcessTree(const ProcessID: Cardinal);
var
  HandleSnapShot: THandle;
  EntryParentProc: TProcessEntry32;
  ParentProcessId: DWORD;
  ProcessHandles: TStringList;
  I: Integer;
  ProcessHndl: THandle;
begin
  HandleSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  ProcessHandles := TStringList.Create;
  try
    // enumerate the process
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
      EntryParentProc.dwSize := SizeOf(EntryParentProc);
      if Process32First(HandleSnapShot, EntryParentProc) then
      // find the first process
      begin
        repeat
          ParentProcessId := EntryParentProc.th32ParentProcessID;

          if ParentProcessId = ProcessID then
          begin
            ProcessHandles.Add(FloatToStr(EntryParentProc.th32ProcessID));
          end;

        until not Process32Next(HandleSnapShot, EntryParentProc);
      end;
      for I := 0 to ProcessHandles.Count - 1 do
      begin
        ProcessHndl := OpenProcess(PROCESS_ALL_ACCESS, true, StrToInt(ProcessHandles[I]));
        if TerminateProcess(ProcessHndl, 0) then
        begin
          FStoppedByUser := true;
        end;
        CloseHandle(ProcessHndl);
      end;
      CloseHandle(HandleSnapShot);
    end;
  finally

    FreeAndNil(ProcessHandles);
  end;

end;

end.

