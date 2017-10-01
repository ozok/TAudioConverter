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

unit UnitTrimmer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  sBitBtn, Vcl.ComCtrls, sTrackBar, sEdit, sSkinProvider, sLabel;

type
  TTrimmerForm = class(TForm)
    EndEdit: TsEdit;
    StartEdit: TsEdit;
    StartBar: TsTrackBar;
    EndBar: TsTrackBar;
    ResetBtn: TsBitBtn;
    SaveBtn: TsBitBtn;
    CancelBtn: TsBitBtn;
    DurationEdit: TsEdit;
    OrigDurEdit: TsEdit;
    sSkinProvider1: TsSkinProvider;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    procedure StartBarChange(Sender: TObject);
    procedure EndBarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ResetBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FileIndex: integer;
    EndPosition, StartPosition: integer;
    Duration: integer;
  end;

var
  TrimmerForm: TTrimmerForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TTrimmerForm.CancelBtnClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TTrimmerForm.EndBarChange(Sender: TObject);
var
  FS: TFormatSettings;
  LSelectedDur: integer;
begin
  if EndBar.Position >= (StartBar.Position + 1) then
  begin
    FS.DecimalSeparator := '.';
    EndEdit.Text := MainForm.IntToTime(EndBar.Position div 1000) + FormatFloat('#.###', ((EndBar.Position / 1000) - (EndBar.Position div 1000)), FS);
    EndPosition := EndBar.Position;
  end
  else
  begin
    EndBar.Position := StartBar.Position + 1
  end;
  LSelectedDur := (EndPosition - StartPosition);
  DurationEdit.Text := MainForm.IntToTime(LSelectedDur div 1000) + FormatFloat('#.###', ((LSelectedDur / 1000) - (LSelectedDur div 1000)), FS);
end;

procedure TTrimmerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TTrimmerForm.FormShow(Sender: TObject);
var
  FS: TFormatSettings;
begin
  StartBar.Max := Duration;
  EndBar.Max := Duration;
  StartBar.Min := 0;
  EndBar.Min := 0;
  StartBar.Position := StartPosition;
  EndBar.Position := EndPosition;
  FS.DecimalSeparator := '.';
  OrigDurEdit.Text := MainForm.IntToTime(Duration div 1000) + FormatFloat('#.###', ((Duration / 1000) - (Duration div 1000)), FS);
  StartBarChange(Self);
  EndBarChange(Self);
  if not MainForm.sSkinManager1.Active then
  begin
    Self.Color := clBtnFace;
    StartEdit.Color := clWindow;
    EndEdit.Color := clWindow;
    DurationEdit.Color := clWindow;
    OrigDurEdit.Color := clWindow;
  end;
end;

procedure TTrimmerForm.ResetBtnClick(Sender: TObject);
begin

  if ID_YES = Application.MessageBox('Do you want to reset position values?', 'Confirm', MB_ICONQUESTION or MB_YESNO) then
  begin
    StartPosition := StrToInt(MainForm.StartPositions[FileIndex]);
    EndPosition := StrToInt(MainForm.EndPositions[FileIndex]);

    StartBar.Max := Duration;
    EndBar.Max := Duration;
    StartBar.Min := 0;
    EndBar.Min := 0;
    StartBar.Position := 0;
    EndBar.Position := Duration;
    StartPosition := 0;
    EndPosition := Duration;
    StartBarChange(Self);
    EndBarChange(Self);
  end;

end;

procedure TTrimmerForm.SaveBtnClick(Sender: TObject);
begin
  MainForm.StartPositions[FileIndex] := FloatToStr(StartPosition);
  MainForm.EndPositions[FileIndex] := FloatToStr(EndPosition);
  MainForm.FileList.Items[FileIndex].SubItems[0] := StartEdit.Text;
  MainForm.FileList.Items[FileIndex].SubItems[1] := EndEdit.Text;
end;

procedure TTrimmerForm.StartBarChange(Sender: TObject);
var
  FS: TFormatSettings;
  LSelectedDur: integer;
begin
  if StartBar.Position <= (EndBar.Position - 1) then
  begin
    FS.DecimalSeparator := '.';
    StartEdit.Text := MainForm.IntToTime(StartBar.Position div 1000) + '.' + MainForm.PadString(FloatToStr((StartBar.Position / 1000) - (StartBar.Position div 1000)));
    StartPosition := StartBar.Position;
  end
  else
  begin
    StartBar.Position := EndBar.Position - 1;
  end;
  LSelectedDur := (EndPosition - StartPosition);
  FS.DecimalSeparator := '.';
  DurationEdit.Text := MainForm.IntToTime(LSelectedDur div 1000) + '.' + MainForm.PadString(FloatToStr((LSelectedDur / 1000) - (LSelectedDur div 1000)));
end;

end.

