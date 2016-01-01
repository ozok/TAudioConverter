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

unit UnitTag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  IniFiles, sSkinProvider, sBitBtn, sCheckBox, sEdit, sLabel, sSpinEdit;

type
  TTagForm = class(TForm)
    ArtistEdit: TsEdit;
    AlbumEdit: TsEdit;
    GenreEdit: TsEdit;
    PerformerEdit: TsEdit;
    UseValuesBtn: TsCheckBox;
    CloseBtn: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    DateEdit: TsSpinEdit;
    procedure CloseBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure UseValuesBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TagForm: TTagForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TTagForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TTagForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  SettingsFile: TIniFile;
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try
    SettingsFile.WriteBool('settings', 'customtag', UseValuesBtn.Checked);
  finally
    SettingsFile.Free;
  end;
end;

procedure TTagForm.FormCreate(Sender: TObject);
var
  SettingsFile: TIniFile;
begin
  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try
    UseValuesBtn.Checked := SettingsFile.ReadBool('settings', 'customtag', false);
  finally
    SettingsFile.Free;
    UseValuesBtnClick(self);
  end;
end;

procedure TTagForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    self.Close;
  end;
end;

procedure TTagForm.FormShow(Sender: TObject);
begin
  if MainForm.sSkinManager1.Active = false then
  begin
    self.Color := clBtnFace;
  end;
end;

procedure TTagForm.UseValuesBtnClick(Sender: TObject);
begin
  ArtistEdit.Enabled := UseValuesBtn.Checked;
  AlbumEdit.Enabled := UseValuesBtn.Checked;
  PerformerEdit.Enabled := UseValuesBtn.Checked;
  DateEdit.Enabled := UseValuesBtn.Checked;
  GenreEdit.Enabled := UseValuesBtn.Checked;
end;

end.

