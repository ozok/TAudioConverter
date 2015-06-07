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

unit UnitLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvListBox, Vcl.ComCtrls, sSkinProvider,
  Vcl.ExtCtrls, sPanel, sListBox, Vcl.Buttons, sBitBtn, JvExControls,
  JvEditorCommon,
  JvUnicodeEditor, JvUnicodeHLEditor, JvXPCore, JvXPButtons, acPNG, sComboBox,
  sDialogs, sMemo, sPageControl, System.Zip;

type
  TLogForm = class(TForm)
    SaveBtn: TsBitBtn;
    ClearBtn: TsBitBtn;
    SaveDialog1: TsSaveDialog;
    CloseBtn: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    ClearAllBtn: TsBitBtn;
    CreateLogBtn: TsBitBtn;
    ReLoadBtn: TsBitBtn;
    LogPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    OutputList: TsMemo;
    sTabSheet2: TsTabSheet;
    EncoderOutput: TsMemo;
    sTabSheet10: TsTabSheet;
    DeletedLog: TsMemo;
    sTabSheet11: TsTabSheet;
    CommandLinesList: TsMemo;
    sTabSheet12: TsTabSheet;
    CompressionLog: TsMemo;
    EncodersList: TsComboBox;
    sTabSheet3: TsTabSheet;
    MergeLog: TsMemo;
    procedure ClearBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ClearAllBtnClick(Sender: TObject);
    procedure CreateLogBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReLoadBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EncodersListChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LogFolder: string;
  end;

var
  LogForm: TLogForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TLogForm.ClearAllBtnClick(Sender: TObject);
var
  i: Integer;
begin

  OutputList.Lines.Clear;
  EncoderOutput.Lines.Clear;
  DeletedLog.Lines.Clear;
  CommandLinesList.Lines.Clear;
  CompressionLog.Lines.Clear;
  MergeLog.Lines.Clear;

  if FileExists(MainForm.AppDataFolder + '\log_main.txt') then
  begin
    DeleteFile(MainForm.AppDataFolder + '\log_main.txt')
  end;
  for I := 1 to 16 do
  begin
    if FileExists(MainForm.AppDataFolder + '\log_encoder' + FloatToStr(i) + '.txt') then
    begin
      DeleteFile(MainForm.AppDataFolder + '\log_encoder' + FloatToStr(i) + '.txt')
    end;
  end;
  if FileExists(MainForm.AppDataFolder + '\log_deleted.txt') then
  begin
    DeleteFile(MainForm.AppDataFolder + '\log_deleted.txt')
  end;
  if FileExists(MainForm.AppDataFolder + '\log_cmd.txt') then
  begin
    DeleteFile(MainForm.AppDataFolder + '\log_cmd.txt')
  end;
  if FileExists(MainForm.AppDataFolder + '\log_comp.txt') then
  begin
    DeleteFile(MainForm.AppDataFolder + '\log_comp.txt')
  end;
  if FileExists(MainForm.AppDataFolder + '\log_merge.txt') then
  begin
    DeleteFile(MainForm.AppDataFolder + '\log_merge.txt')
  end;

end;

procedure TLogForm.ClearBtnClick(Sender: TObject);
begin

  case LogPages.ActivePageIndex of
    0:
      begin
        OutputList.Lines.Clear;
        if FileExists(MainForm.AppDataFolder + '\log_main.txt') then
        begin
          DeleteFile(MainForm.AppDataFolder + '\log_main.txt')
        end;
      end;
    1:
      begin
        EncoderOutput.Lines.Clear;
        if FileExists(MainForm.AppDataFolder + '\log_encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt') then
        begin
          DeleteFile(MainForm.AppDataFolder + '\log_encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt')
        end;
      end;
    2:
      begin
        DeletedLog.Lines.Clear;
        if FileExists(MainForm.AppDataFolder + '\log_deleted.txt') then
        begin
          DeleteFile(MainForm.AppDataFolder + '\log_deleted.txt')
        end;
      end;
    3:
      begin
        CommandLinesList.Lines.Clear;
        if FileExists(MainForm.AppDataFolder + '\log_cmd.txt') then
        begin
          DeleteFile(MainForm.AppDataFolder + '\log_cmd.txt')
        end;
      end;
    4:
      begin
        CompressionLog.Lines.Clear;
        if FileExists(MainForm.AppDataFolder + '\log_comp.txt') then
        begin
          DeleteFile(MainForm.AppDataFolder + '\log_comp.txt')
        end;
      end;
    5:
      begin
        MergeLog.Lines.Clear;
        if FileExists(MainForm.AppDataFolder + '\log_merge.txt') then
        begin
          DeleteFile(MainForm.AppDataFolder + '\log_merge.txt')
        end;
      end;
  end;

end;

procedure TLogForm.CloseBtnClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TLogForm.EncodersListChange(Sender: TObject);
begin

  EncoderOutput.Lines.Clear;
  if FileExists(MainForm.AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt') then
  begin
    EncoderOutput.Lines.LoadFromFile(MainForm.AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt');
  end;
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  OutputList.Lines.Clear;
  EncoderOutput.Lines.Clear;
  DeletedLog.Lines.Clear;
  CommandLinesList.Lines.Clear;
  CompressionLog.Lines.Clear;
  MergeLog.Lines.Clear;

end;

procedure TLogForm.FormCreate(Sender: TObject);
begin
  if MainForm.IsPortable then
  begin
    LogFolder := '\logs'
  end
  else
  begin
    LogFolder := ''
  end;
end;

procedure TLogForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
  begin
    CloseBtn.OnClick(Self);
  end;

end;

procedure TLogForm.FormShow(Sender: TObject);
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

procedure TLogForm.ReLoadBtnClick(Sender: TObject);
begin
  Self.OnShow(Self);
end;

procedure TLogForm.SaveBtnClick(Sender: TObject);
begin

  if OutputList.Lines.Count > 0 then
  begin
    if SaveDialog1.Execute then
    begin
      case LogPages.ActivePageIndex of
        0:
          begin
            SaveDialog1.FileName := 'TAC_Main.txt';
            OutputList.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          end;
        1:
          begin
            SaveDialog1.FileName := 'TAC_Encoder' + FloatToStr(EncodersList.ItemIndex + 1) + '.txt';
            EncoderOutput.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          end;
        2:
          begin
            SaveDialog1.FileName := 'TAC_Deleted.txt';
            DeletedLog.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          end;
        3:
          begin
            SaveDialog1.FileName := 'TAC_CMD.txt';
            CommandLinesList.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          end;
        4:
          begin
            SaveDialog1.FileName := 'TAC_Comp.txt';
            CompressionLog.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          end;
        5:
          begin
            SaveDialog1.FileName := 'TAC_merge.txt';
            MergeLog.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          end;
      end;

    end;
  end;

end;

procedure TLogForm.CreateLogBtnClick(Sender: TObject);
var
  ZipFile: TZipFile;
  I: Integer;
begin
  if CreateDir(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs') then
  begin
    OutputList.Lines.SaveToFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\tac.txt', TEncoding.Unicode);
    for I := 0 to EncodersList.Items.Count - 1 do
    begin
      if FileExists(MainForm.AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(i + 1) + '.txt') then
      begin
        CopyFile(PWideChar(MainForm.AppDataFolder + LogFolder + '\log_encoder' + FloatToStr(i + 1) + '.txt'),
          PWideChar(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\encoder' + FloatToStr(i + 1) + '.txt'), False);
      end;
    end;
    DeletedLog.Lines.SaveToFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\deleted.txt', TEncoding.Unicode);
    CommandLinesList.Lines.SaveToFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\cmd.txt', TEncoding.Unicode);
    CompressionLog.Lines.SaveToFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\comp.txt', TEncoding.Unicode);
    MergeLog.Lines.SaveToFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\merge.txt', TEncoding.Unicode);

    if FileExists(MainForm.SystemInfo.Folders.Desktop + '\tac_logs.zip') then
    begin
      DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_logs.zip')
    end;

    ZipFile := TZipFile.Create;
    try
      ZipFile.Open(MainForm.SystemInfo.Folders.Desktop + '\tac_logs.zip', zmWrite);

      ZipFile.Add(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\tac.txt');
      for I := 0 to EncodersList.Items.Count - 1 do
      begin
        if FileExists(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\encoder' + FloatToStr(i + 1) + '.txt') then
        begin
          ZipFile.Add(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\encoder' + FloatToStr(i + 1) + '.txt');
        end;
      end;
      ZipFile.Add(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\deleted.txt');
      ZipFile.Add(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\cmd.txt');
      ZipFile.Add(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\comp.txt');
      ZipFile.Add(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\merge.txt');
    finally
      FreeAndNil(ZipFile);

      DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\tac.txt');
      for I := 0 to EncodersList.Items.Count - 1 do
      begin
        if FileExists(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\encoder' + FloatToStr(i + 1) + '.txt') then
        begin
          DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\encoder' + FloatToStr(i + 1) + '.txt');
        end;
      end;
      DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\deleted.txt');
      DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\cmd.txt');
      DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\comp.txt');
      DeleteFile(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs\merge.txt');
      RemoveDir(MainForm.SystemInfo.Folders.Desktop + '\tac_bugs');

      if FileExists(MainForm.SystemInfo.Folders.Desktop + '\tac_logs.zip') then
      begin
        Application.MessageBox('Created tac_logs.zip in desktop folder.', 'Info', MB_ICONINFORMATION)
      end;

    end;
  end;
end;

end.
