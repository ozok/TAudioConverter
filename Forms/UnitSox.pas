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

unit UnitSox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons, sBitBtn, Vcl.Mask, JvExMask, JvSpin, sComboBox, sCheckBox,
  Inifiles,
  JvExControls, JvXPCore, JvXPButtons, acPNG, sSkinProvider, sEdit, sSpinEdit,
  sGroupBox, sLabel;

type
  TFiltersForm = class(TForm)
    EnableBtn: TsCheckBox;
    VolumeBtn: TsCheckBox;
    CloseBtn: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    VolumeEdit: TsSpinEdit;
    sGroupBox1: TsGroupBox;
    NormBtn: TsCheckBox;
    ThreadBtn: TsCheckBox;
    GuardBtn: TsCheckBox;
    SpeedEdit: TJvSpinEdit;
    sLabel1: TsLabel;
    procedure CloseBtnClick(Sender: TObject);
    procedure VolumeBtnClick(Sender: TObject);
    procedure EnableBtnClick(Sender: TObject);

    procedure LoadSettings();
    procedure SaveSettings();
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FiltersForm: TFiltersForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFiltersForm.CloseBtnClick(Sender: TObject);
begin

  Self.Close;

end;

procedure TFiltersForm.EnableBtnClick(Sender: TObject);
begin

  VolumeBtn.Enabled := EnableBtn.Checked;
  VolumeEdit.Enabled := EnableBtn.Checked;
  NormBtn.Enabled := EnableBtn.Checked;
  ThreadBtn.Enabled := EnableBtn.Checked;
  GuardBtn.Enabled := EnableBtn.Checked;
  SpeedEdit.Enabled := EnableBtn.Checked;

  if EnableBtn.Checked then
  begin
    VolumeBtn.OnClick(Self);
  end;

  if EnableBtn.Checked then
  begin
    MainForm.AudioEffectsBtn.ImageIndex := 0;
    MainForm.AudioEffectsBtn.Hint := 'Audio Effects/Filters are enabled';
  end
  else
  begin
    MainForm.AudioEffectsBtn.ImageIndex := 1;
    MainForm.AudioEffectsBtn.Hint := 'Audio Effects/Filters are disabled';
  end;
end;

procedure TFiltersForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  SaveSettings();

end;

procedure TFiltersForm.FormCreate(Sender: TObject);
begin

  LoadSettings();
  VolumeEdit.MinValue := 0;
  VolumeEdit.MaxValue := MaxInt;

end;

procedure TFiltersForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
  begin
    Self.Close;
  end;

end;

procedure TFiltersForm.LoadSettings;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin

      EnableBtn.Checked := ReadBool('sox', 'Enable', False);
      VolumeBtn.Checked := ReadBool('sox', 'Vol', False);
      VolumeEdit.Text := ReadString('sox', 'VolEdit2', '100');
      NormBtn.Checked := ReadBool('sox', 'Norm', False);
      VolumeBtn.Checked := ReadBool('sox', 'Vol', False);
      GuardBtn.Checked := ReadBool('sox', 'guard', True);
      SpeedEdit.Text := ReadString('sox', 'speed', '100');
    end;

  finally
    SettingsFile.Free;

    EnableBtn.OnClick(Self);
  end;

end;

procedure TFiltersForm.SaveSettings;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin

      WriteBool('sox', 'Enable', EnableBtn.Checked);
      WriteBool('sox', 'Vol', VolumeBtn.Checked);
      WriteString('sox', 'VolEdit2', VolumeEdit.Text);
      WriteBool('sox', 'Norm', NormBtn.Checked);
      WriteBool('sox', 'Thread', ThreadBtn.Checked);
      WriteBool('sox', 'guard', GuardBtn.Checked);
      WriteString('sox', 'speed', SpeedEdit.Text);
    end;

  finally
    SettingsFile.Free;
  end;

end;

procedure TFiltersForm.VolumeBtnClick(Sender: TObject);
begin

  VolumeEdit.Enabled := VolumeBtn.Checked;

end;

end.
