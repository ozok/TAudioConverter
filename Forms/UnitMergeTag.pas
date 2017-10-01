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

unit UnitMergeTag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  IniFiles, sSkinProvider, sBitBtn, sCheckBox, sEdit, sLabel, sSpinEdit, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit;

type
  TMergeTagForm = class(TForm)
    ArtistEdit: TsEdit;
    AlbumEdit: TsEdit;
    GenreEdit: TsEdit;
    PerformerEdit: TsEdit;
    UseValuesBtn: TsCheckBox;
    CloseBtn: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    DateEdit: TsSpinEdit;
    TitleEdit: TsEdit;
    ArtworkPathEdit: TsFilenameEdit;
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
  MergeTagForm: TMergeTagForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TMergeTagForm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMergeTagForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  SettingsFile: TIniFile;
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try
    SettingsFile.WriteBool('settings', 'mergetag', UseValuesBtn.Checked);
  finally
    SettingsFile.Free;
  end;
end;

procedure TMergeTagForm.FormCreate(Sender: TObject);
var
  SettingsFile: TIniFile;
begin
  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try
    UseValuesBtn.Checked := SettingsFile.ReadBool('settings', 'mergetag', false);
  finally
    SettingsFile.Free;
    UseValuesBtnClick(self);
  end;
end;

procedure TMergeTagForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    self.Close;
  end;
end;

procedure TMergeTagForm.FormShow(Sender: TObject);
begin
  if MainForm.sSkinManager1.Active = false then
  begin
    self.Color := clBtnFace;
  end;
end;

procedure TMergeTagForm.UseValuesBtnClick(Sender: TObject);
begin
  ArtistEdit.Enabled := UseValuesBtn.Checked;
  AlbumEdit.Enabled := UseValuesBtn.Checked;
  PerformerEdit.Enabled := UseValuesBtn.Checked;
  DateEdit.Enabled := UseValuesBtn.Checked;
  GenreEdit.Enabled := UseValuesBtn.Checked;
  TitleEdit.Enabled := UseValuesBtn.Checked;
  ArtworkPathEdit.Enabled := UseValuesBtn.Checked;
end;

end.

