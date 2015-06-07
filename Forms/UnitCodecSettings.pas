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

unit UnitCodecSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sPageControl,
  sSkinProvider, Vcl.StdCtrls, sButton, sTrackBar, sLabel, sEdit, sSpinEdit,
  sCheckBox, sComboBox, Vcl.ExtCtrls, sPanel, IniFiles, ShellAPI, Vcl.Buttons,
  sBitBtn, sGroupBox;

type
  TCodecSettingsForm = class(TForm)
    WavPackMethodList: TsComboBox;
    WavPackExtraBtn: TsCheckBox;
    WavPackCorrectionBtn: TsCheckBox;
    WavPackBitrateEdit: TsSpinEdit;
    OggencodeList: TsComboBox;
    OggManagedBitrateBtn: TsCheckBox;
    OggQualityEdit: TsSpinEdit;
    OggBitrateEdit: TsSpinEdit;
    sLabel2: TsLabel;
    FHGMethodList: TsComboBox;
    FHGProfileList: TsComboBox;
    FHGQualityEdit: TsSpinEdit;
    FHGBitrateEdit: TsSpinEdit;
    AiffPanel: TsPanel;
    AftenEncodeList: TsComboBox;
    AftenQualityBar: TsTrackBar;
    AftenQualityEdit: TsEdit;
    AftenBitrateEdit: TsSpinEdit;
    FLACCLLevelList: TsComboBox;
    LameEncodeList: TsComboBox;
    LameTagList: TsComboBox;
    LameQualityEdit: TsSpinEdit;
    LameBitrateEdit: TsSpinEdit;
    LameVBREdit: TsEdit;
    LameVBRBar: TsTrackBar;
    LameChannelList: TsComboBox;
    OpusEncodeMethodList: TsComboBox;
    OpusCompEdit: TsSpinEdit;
    OpusBitrateEdit: TsSpinEdit;
    sLabel5: TsLabel;
    QaacEncodeMethodList: TsComboBox;
    QaacQualityList: TsComboBox;
    QaacHEBtn: TsCheckBox;
    QaacvQualityEdit: TsSpinEdit;
    QaacBitrateEdit: TsSpinEdit;
    NeroMethodList: TsComboBox;
    NeroProfileList: TsComboBox;
    NeroBitrateEdit: TsSpinEdit;
    NeroQualityBar: TsTrackBar;
    NeroQualityEdit: TsEdit;
    AlacPanel: TsPanel;
    WMAMethodList: TsComboBox;
    WMACodecList: TsComboBox;
    WMAQualityList: TsComboBox;
    WMABitrateEdit: TsSpinEdit;
    TAKPresetList: TsComboBox;
    TTAPanel: TsPanel;
    WavePanel: TsPanel;
    FAACBitrateEdit: TsComboBox;
    FDKProfileList: TsComboBox;
    FDKBitrateEdit: TsSpinEdit;
    FDKGaplessList: TsComboBox;
    FDKMethodList: TsComboBox;
    FDKVBREdit: TsEdit;
    FDKVBRBar: TsTrackBar;
    MACLevelList: TsComboBox;
    sLabel1: TsLabel;
    MPCQualityBar: TsTrackBar;
    MPCQualityEdit: TsEdit;
    LossyWAVQualityList: TsComboBox;
    LossyWAVEncoderOptBtn: TsCheckBox;
    FLACCompList: TsComboBox;
    FLACEMSBtn: TsCheckBox;
    sSkinProvider1: TsSkinProvider;
    CodecPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    sTabSheet5: TsTabSheet;
    sTabSheet6: TsTabSheet;
    sTabSheet7: TsTabSheet;
    sTabSheet8: TsTabSheet;
    sTabSheet9: TsTabSheet;
    sTabSheet10: TsTabSheet;
    sTabSheet11: TsTabSheet;
    sTabSheet12: TsTabSheet;
    sTabSheet13: TsTabSheet;
    sTabSheet14: TsTabSheet;
    sTabSheet15: TsTabSheet;
    sTabSheet16: TsTabSheet;
    sTabSheet17: TsTabSheet;
    sTabSheet18: TsTabSheet;
    sTabSheet19: TsTabSheet;
    sTabSheet20: TsTabSheet;
    sLabel3: TsLabel;
    QaacNoDelayBtn: TsCheckBox;
    LameUseTTaggerBtn: TsCheckBox;
    FLACUseTTaggerBtn: TsCheckBox;
    FLACCLUseTTaggerBtn: TsCheckBox;
    OggMinBitrateEdit: TsSpinEdit;
    OggMaxBitrateEdit: TsSpinEdit;
    OggUseTTaggerBtn: TsCheckBox;
    OpusUseTTaggerBtn: TsCheckBox;
    sTabSheet21: TsTabSheet;
    DCABitrateBar: TsTrackBar;
    DCABitrateEdit: TsSpinEdit;
    FLACVerifyBtn: TsCheckBox;
    TAKMd5Btn: TsCheckBox;
    TAKVerifyBtn: TsCheckBox;
    TAKLevelList: TsComboBox;
    CustomCodecOptionsEdit: TsEdit;
    sBitBtn1: TsBitBtn;
    AftenDialogEdit: TsSpinEdit;
    AftenDialogBtn: TsCheckBox;
    sLabel4: TsLabel;
    GroupBox1: TsGroupBox;
    sGroupBox1: TsGroupBox;
    BitDepthList: TsComboBox;
    ChannelList: TsComboBox;
    SampleList: TsComboBox;
    FDKVBRBitEdit: TsEdit;
    procedure FDKMethodListChange(Sender: TObject);
    procedure QaacHEBtnClick(Sender: TObject);
    procedure QaacEncodeMethodListChange(Sender: TObject);
    procedure WMAMethodListChange(Sender: TObject);
    procedure FHGMethodListChange(Sender: TObject);
    procedure NeroMethodListChange(Sender: TObject);
    procedure MPCQualityBarChange(Sender: TObject);
    procedure NeroQualityBarChange(Sender: TObject);
    procedure AftenEncodeListChange(Sender: TObject);
    procedure AftenQualityBarChange(Sender: TObject);
    procedure LameEncodeListChange(Sender: TObject);
    procedure LameVBRBarChange(Sender: TObject);
    procedure OggencodeListChange(Sender: TObject);
    procedure WavPackMethodListChange(Sender: TObject);
    procedure FDKVBRBarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sLabel2Click(Sender: TObject);
    procedure OggManagedBitrateBtnClick(Sender: TObject);
    procedure OggBitrateEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LameUseTTaggerBtnClick(Sender: TObject);
    procedure DCABitrateBarChange(Sender: TObject);
    procedure DCABitrateEditChange(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure AftenDialogBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LossyWAVQualityListChange(Sender: TObject);
  private
    { Private declarations }

    // save load custom codec options
    procedure LoadCustom;
    procedure SaveCustom;
  public
    { Public declarations }

    // custom codec options
    FDKAACCMD: string;
    FFMpegAACCMD: string;
    FHGAACCMD: string;
    NeroAACCMD: string;
    QAACCMD: string;
    AC3CMD: string;
    LameCMD: string;
    MPCCMD: string;
    OggCMD: string;
    OpusCMD: string;
    WMACMD: string;
    DcaencCMD: string;
    ALACCMD: string;
    FLACCMD: string;
    FLACCLCMD: string;
    APECMD: string;
    TAKCMD: string;
    TTACMD: string;
    WavPackCMD: string;
    AIFFCMD: string;
    WAVCMD: string;

    // save/load options
    procedure LoadOptions();
    procedure SaveOptions();
  end;

var
  CodecSettingsForm: TCodecSettingsForm;

implementation

{$R *.dfm}

uses UnitMain, UnitSettings, UnitAbout, UnitInfo, UnitLog, UnitProgress,
  UnitSox, UnitTag, UnitUpdater;
{ TCodecSettingsForm }

procedure TCodecSettingsForm.AftenDialogBtnClick(Sender: TObject);
begin
  AftenDialogEdit.Enabled := AftenDialogBtn.Checked;
end;

procedure TCodecSettingsForm.AftenEncodeListChange(Sender: TObject);
begin
  if AftenEncodeList.ItemIndex = 0 then
  begin
    AftenQualityEdit.Enabled := True;
    AftenBitrateEdit.Enabled := False;
    AftenQualityBar.Enabled := True;
  end
  else
  begin
    AftenQualityEdit.Enabled := False;
    AftenBitrateEdit.Enabled := True;
    AftenQualityBar.Enabled := False;
  end;
end;

procedure TCodecSettingsForm.AftenQualityBarChange(Sender: TObject);
begin
  AftenQualityEdit.Text := FloatToStr(AftenQualityBar.Position);
end;

procedure TCodecSettingsForm.DCABitrateBarChange(Sender: TObject);
begin
  DCABitrateEdit.Text := FloatToStr(DCABitrateBar.Position)
end;

procedure TCodecSettingsForm.DCABitrateEditChange(Sender: TObject);
begin
  if Length(DCABitrateEdit.Text) > 0 then
  begin
    DCABitrateBar.Position := DCABitrateEdit.Value;
  end;
end;

procedure TCodecSettingsForm.FDKMethodListChange(Sender: TObject);
begin
  FDKBitrateEdit.Enabled := FDKMethodList.ItemIndex = 0;
  FDKVBREdit.Enabled := not FDKBitrateEdit.Enabled;
  FDKVBRBar.Enabled := not FDKBitrateEdit.Enabled;
  FDKVBRBitEdit.Enabled := not FDKBitrateEdit.Enabled;
end;

procedure TCodecSettingsForm.FDKVBRBarChange(Sender: TObject);
begin
  FDKVBREdit.Text := FloatToStr(FDKVBRBar.Position);
  case FDKVBRBar.Position of
    1:
      FDKVBRBitEdit.Text := '32 kbps/channel';
    2:
      FDKVBRBitEdit.Text := '40 kbps/channel';
    3:
      FDKVBRBitEdit.Text := '48-56 kbps/channel';
    4:
      FDKVBRBitEdit.Text := '64 kbps/channel';
    5:
      FDKVBRBitEdit.Text := '80-96 kbps/channel';
  end;
end;

procedure TCodecSettingsForm.FHGMethodListChange(Sender: TObject);
begin
  if FHGMethodList.ItemIndex = 0 then
  begin
    FHGBitrateEdit.Enabled := True;
    FHGQualityEdit.Enabled := False;
    FHGProfileList.Enabled := True;
  end
  else
  begin
    FHGBitrateEdit.Enabled := False;
    FHGQualityEdit.Enabled := True;
    FHGProfileList.Enabled := False;
  end;
end;

procedure TCodecSettingsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveOptions;
  case CodecPages.ActivePageIndex of
    0:
      begin
        CodecSettingsForm.FDKAACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    1:
      begin
        CodecSettingsForm.FFMpegAACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    2:
      begin
        CodecSettingsForm.FHGAACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    3:
      begin
        CodecSettingsForm.NeroAACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    4:
      begin
        CodecSettingsForm.QAACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    5:
      begin
        CodecSettingsForm.AC3CMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    6:
      begin
        CodecSettingsForm.LameCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    7:
      begin
        CodecSettingsForm.MPCCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    8:
      begin
        CodecSettingsForm.OggCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    9:
      begin
        CodecSettingsForm.OpusCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    10:
      begin
        CodecSettingsForm.WMACMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    11:
      begin
        CodecSettingsForm.DcaencCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    12:
      begin
        CodecSettingsForm.ALACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    13:
      begin
        CodecSettingsForm.FLACCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    14:
      begin
        CodecSettingsForm.FLACCLCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    15:
      begin
        CodecSettingsForm.APECMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    16:
      begin
        CodecSettingsForm.TAKCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    17:
      begin
        CodecSettingsForm.TTACMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    18:
      begin
        CodecSettingsForm.WavPackCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    19:
      begin
        CodecSettingsForm.AIFFCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
    20:
      begin
        CodecSettingsForm.WAVCMD := CodecSettingsForm.CustomCodecOptionsEdit.Text;
      end;
  end;
  SaveCustom;
  MainForm.UpdateSummaryLabel;
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TCodecSettingsForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  LoadOptions;
  LoadCustom;
  // hide tabs
  for I := 0 to CodecPages.PageCount - 1 do
  begin
    CodecPages.Pages[i].TabVisible := False;
  end;
end;

procedure TCodecSettingsForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
  begin
    self.Close;
  end;

end;

procedure TCodecSettingsForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  if MainForm.sSkinManager1.Active = False then
  begin
    self.Color := clBtnFace;
  end;
  if LossyWAVQualityList.Enabled then
  begin
    LossyWAVQualityListChange(self);
  end;
  // if skinning is disabled
  // then make sure edites etc are while
  if not MainForm.sSkinManager1.Active then
  begin
    for I := 0 to self.ComponentCount - 1 do
    begin
      if self.Components[i] is TsSpinEdit then
      begin
        TsSpinEdit(self.Components[i]).Color := clWindow;
      end;
      if self.Components[i] is TsEdit then
      begin
        TsEdit(self.Components[i]).Color := clWindow;
      end;
      if self.Components[i] is TsComboBox then
      begin
        TsComboBox(self.Components[i]).Color := clWindow;
      end;
    end;
  end;
end;

procedure TCodecSettingsForm.LameEncodeListChange(Sender: TObject);
begin
  if LameEncodeList.ItemIndex = 2 then
  begin
    LameVBREdit.Enabled := True;
    LameBitrateEdit.Enabled := False;
    LameVBRBar.Enabled := True;
  end
  else
  begin
    LameVBREdit.Enabled := False;
    LameBitrateEdit.Enabled := True;
    LameVBRBar.Enabled := False;
  end;
end;

procedure TCodecSettingsForm.LameUseTTaggerBtnClick(Sender: TObject);
begin
  LameTagList.Enabled := not LameUseTTaggerBtn.Checked;
end;

procedure TCodecSettingsForm.LameVBRBarChange(Sender: TObject);
begin
  LameVBREdit.Text := FloatToStr(LameVBRBar.Position / 100);
end;

procedure TCodecSettingsForm.LoadCustom;
var
  SettingsFile: TIniFile;
begin
  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + '\custom.ini');
  try
    with SettingsFile do
    begin
      FDKAACCMD := ReadString('cmd', 'fdk', '');
      FFMpegAACCMD := ReadString('cmd', 'ffmpegaac', '');
      FHGAACCMD := ReadString('cmd', 'fhg', '');
      NeroAACCMD := ReadString('cmd', 'nero', '');
      QAACCMD := ReadString('cmd', 'qaac', '');
      AC3CMD := ReadString('cmd', 'ac3', '');
      LameCMD := ReadString('cmd', 'lame', '');
      MPCCMD := ReadString('cmd', 'mpc', '');
      OggCMD := ReadString('cmd', 'ogg', '');
      OpusCMD := ReadString('cmd', 'opus', '');
      WMACMD := ReadString('cmd', 'wma', '');
      DcaencCMD := ReadString('cmd', 'dcaenc', '');
      ALACCMD := ReadString('cmd', 'alac2', '');
      FLACCMD := ReadString('cmd', 'flac', '');
      FLACCLCMD := ReadString('cmd', 'flaccl', '');
      APECMD := ReadString('cmd', 'ape', '');
      TAKCMD := ReadString('cmd', 'tak', '');
      TTACMD := ReadString('cmd', 'tta', '');
      WavPackCMD := ReadString('cmd', 'wv', '');
      AIFFCMD := ReadString('cmd', 'aiff', '');
      WAVCMD := ReadString('cmd', 'wav', '');
    end;
  finally
    SettingsFile.Free;
  end;
end;

procedure TCodecSettingsForm.LoadOptions;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin
      FAACBitrateEdit.Text := ReadString('Settings', 'FAACBitrate', '128');

      QaacEncodeMethodList.ItemIndex := ReadInteger('Settings', 'QaacEncode', 0);
      QaacvQualityEdit.Text := ReadString('Settings', 'QaacQuality', '64');
      QaacBitrateEdit.Text := ReadString('Settings', 'QaacBitrate', '128');
      QaacQualityList.ItemIndex := ReadInteger('Settings', 'QaacProfile', 2);
      QaacHEBtn.Checked := ReadBool('Settings', 'QaacHE', False);
      QaacNoDelayBtn.Checked := ReadBool('Settings', 'QaacND', False);

      OggencodeList.ItemIndex := ReadInteger('Settings', 'OggEncode', 0);
      OggQualityEdit.Text := ReadString('Settings', 'OggQuality', '6');
      OggBitrateEdit.Text := ReadString('Settings', 'OggBitrate', '128');
      OggManagedBitrateBtn.Checked := ReadBool('Settings', 'OggManaged', False);
      OggMaxBitrateEdit.Text := ReadString('Settings', 'OggMax', '160');
      OggMinBitrateEdit.Text := ReadString('Settings', 'OggMin', '112');
      OggUseTTaggerBtn.Checked := ReadBool('settings', 'OggTag', False);

      LameEncodeList.ItemIndex := ReadInteger('Settings', 'LAmeEncode', 2);
      LameVBREdit.Text := ReadString('Settings', 'LameVBR2', '2');
      LameBitrateEdit.Text := ReadString('Settings', 'LameBit', '128');
      LameQualityEdit.Text := ReadString('Settings', 'LameQ', '3');
      LameTagList.ItemIndex := ReadInteger('Settings', 'LameTag', 0);
      LameVBRBar.Position := ReadInteger('settings', 'LameQBar', 200);
      LameChannelList.ItemIndex := ReadInteger('settings', 'lamechannel', 0);
      LameUseTTaggerBtn.Checked := ReadBool('settings', 'lamettagger', True);

      AftenEncodeList.ItemIndex := ReadInteger('Settings', 'AftenEncode', 0);
      AftenQualityEdit.Text := ReadString('Settings', 'AftenQuality', '240');
      AftenBitrateEdit.Text := ReadString('Settings', 'AftenBitrate', '320');
      AftenDialogEdit.Text := ReadString('Settings', 'AfternDlg', '-31');
      AftenDialogBtn.Checked := ReadBool('settings', 'aftendlg2', False);

      FHGMethodList.ItemIndex := ReadInteger('Settings', 'FHGEncode', 0);
      FHGQualityEdit.Text := ReadString('Settings', 'FHGQuality', '6');
      FHGBitrateEdit.Text := ReadString('Settings', 'FHGBitrate', '128');
      FHGProfileList.ItemIndex := ReadInteger('Settings', 'FHGProfile', 0);

      OpusEncodeMethodList.ItemIndex := ReadInteger('Settings', 'OpusEnc', 0);
      OpusBitrateEdit.Text := ReadString('Settings', 'OpusBitrate', '128');
      OpusCompEdit.Text := ReadString('Settings', 'OpusQuality', '8');
      OpusUseTTaggerBtn.Checked := ReadBool('settings', 'OpusTag', False);

      NeroMethodList.ItemIndex := ReadInteger('Settings', 'NeroEncode', 0);
      NeroQualityEdit.Text := ReadString('Settings', 'NeroQuality2', FloatToStr(NeroQualityBar.Max / 2));
      NeroQualityBar.Position := StrToInt(NeroQualityEdit.Text);
      NeroBitrateEdit.Text := ReadString('Settings', 'NeroBitrate', '128');
      NeroProfileList.ItemIndex := ReadInteger('Settings', 'NeroProfile', 0);

      MACLevelList.ItemIndex := ReadInteger('Settings', 'MAC', 1);
      MPCQualityBar.Position := ReadInteger('Settings', 'MPC', 500);

      WavPackMethodList.ItemIndex := ReadInteger('Settings', 'WPMethod', 0);
      WavPackBitrateEdit.Text := ReadString('settings', 'WPBitrate', '256');
      WavPackExtraBtn.Checked := ReadBool('Settings', 'WPExtra', True);
      WavPackCorrectionBtn.Checked := ReadBool('Settings', 'WPCorrect', True);

      FDKProfileList.ItemIndex := ReadInteger('Settings', 'FDKProfile', 0);
      FDKBitrateEdit.Text := ReadString('Settings', 'FDKBitrate', '128');
      FDKGaplessList.ItemIndex := ReadInteger('Settings', 'FDKGapp', 0);
      FDKVBRBar.Position := ReadInteger('Settings', 'FDKVBR', 3);
      FDKMethodList.ItemIndex := ReadInteger('Settings', 'DFKMethod', 0);

      FLACCompList.ItemIndex := ReadInteger('Settings', 'FlacComp', 5);
      FLACEMSBtn.Checked := ReadBool('Settings', 'FlacEMS', False);
      FLACUseTTaggerBtn.Checked := ReadBool('settings', 'flactag', True);
      FLACVerifyBtn.Checked := ReadBool('settings', 'flacverify', False);

      WMAMethodList.ItemIndex := ReadInteger('Settings', 'WMAMethod', 1);
      WMACodecList.ItemIndex := ReadInteger('Settings', 'WMACodec', 0);
      WMAQualityList.ItemIndex := ReadInteger('Settings', 'WMAQaulity', 3);
      WMABitrateEdit.Text := ReadString('Settings', 'WMABitrate', '128');

      FLACCLLevelList.ItemIndex := ReadInteger('settings', 'flaccllvl', 7);
      FLACCLUseTTaggerBtn.Checked := ReadBool('settings', 'flaccltag', True);

      LossyWAVQualityList.ItemIndex := ReadInteger('settings', 'lossywav', 0);
      LossyWAVEncoderOptBtn.Checked := ReadBool('settings', 'lossyextra', False);

      SampleList.ItemIndex := ReadInteger('sox', 'Sample', 0);
      ChannelList.ItemIndex := ReadInteger('sox', 'Channel', 0);
      BitDepthList.ItemIndex := ReadInteger('Settings', 'Depth', 0);

      TAKPresetList.ItemIndex := ReadInteger('tak', 'takpreset', 4);
      TAKMd5Btn.Checked := ReadBool('tak', 'md5', False);
      TAKVerifyBtn.Checked := ReadBool('tak', 'verify', False);
      TAKLevelList.ItemIndex := ReadInteger('tak', 'level', 0);
    end;

  finally
    SettingsFile.Free;

    QaacEncodeMethodList.OnChange(self);
    OggencodeList.OnChange(self);
    AftenEncodeList.OnChange(self);
    LameEncodeList.OnChange(self);
    FHGMethodList.OnChange(self);
    MPCQualityBar.OnChange(self);
    NeroMethodList.OnChange(self);
    WMAMethodList.OnChange(self);
    WavPackMethodList.OnChange(self);
    FDKMethodListChange(self);
    FDKVBRBarChange(self);
    LameUseTTaggerBtnClick(self);
    AftenDialogBtnClick(self);
    LossyWAVQualityListChange(self);
  end;
end;

procedure TCodecSettingsForm.LossyWAVQualityListChange(Sender: TObject);
begin
  LossyWAVEncoderOptBtn.Enabled := LossyWAVQualityList.ItemIndex <> 0;
end;

procedure TCodecSettingsForm.MPCQualityBarChange(Sender: TObject);
begin
  MPCQualityEdit.Text := FloatToStr(MPCQualityBar.Position / 100);
end;

procedure TCodecSettingsForm.NeroMethodListChange(Sender: TObject);
begin
  NeroBitrateEdit.Enabled := NeroMethodList.ItemIndex <> 0;
  NeroQualityEdit.Enabled := NeroMethodList.ItemIndex = 0;
  NeroQualityBar.Enabled := NeroQualityEdit.Enabled;
end;

procedure TCodecSettingsForm.NeroQualityBarChange(Sender: TObject);
begin
  NeroQualityEdit.Text := FloatToStr(NeroQualityBar.Position);
end;

procedure TCodecSettingsForm.OggBitrateEditChange(Sender: TObject);
begin
  if Length(OggBitrateEdit.Text) > 0 then
  begin
    OggMaxBitrateEdit.MinValue := StrToInt(OggBitrateEdit.Text);
    OggMinBitrateEdit.MaxValue := StrToInt(OggBitrateEdit.Text);
  end;
end;

procedure TCodecSettingsForm.OggencodeListChange(Sender: TObject);
begin
  if OggencodeList.ItemIndex = 0 then
  begin
    OggQualityEdit.Enabled := True;
    OggBitrateEdit.Enabled := False;
    OggManagedBitrateBtn.Enabled := False;
    OggMaxBitrateEdit.Enabled := False;
    OggMinBitrateEdit.Enabled := False;
  end
  else
  begin
    OggQualityEdit.Enabled := False;
    OggBitrateEdit.Enabled := True;
    OggManagedBitrateBtn.Enabled := True;
    OggManagedBitrateBtnClick(self);
  end;
end;

procedure TCodecSettingsForm.OggManagedBitrateBtnClick(Sender: TObject);
begin
  OggMinBitrateEdit.Enabled := not OggManagedBitrateBtn.Checked;
  OggMaxBitrateEdit.Enabled := not OggManagedBitrateBtn.Checked;
end;

procedure TCodecSettingsForm.QaacEncodeMethodListChange(Sender: TObject);
begin
  if QaacEncodeMethodList.ItemIndex = 1 then
  begin
    QaacvQualityEdit.Enabled := True;
    QaacBitrateEdit.Enabled := False;
  end
  else
  begin
    QaacvQualityEdit.Enabled := False;
    QaacBitrateEdit.Enabled := True;
  end;

  if QaacHEBtn.Checked then
  begin

    if QaacEncodeMethodList.ItemIndex = 1 then
    begin
      Application.MessageBox('TVBR is not available with HE AAC mode.', 'Warning', MB_ICONWARNING);
      QaacHEBtn.Checked := False;
    end;

  end;
end;

procedure TCodecSettingsForm.QaacHEBtnClick(Sender: TObject);
begin
  if QaacHEBtn.Checked then
  begin

    if QaacEncodeMethodList.ItemIndex = 1 then
    begin
      Application.MessageBox('TVBR is not available with HE AAC mode.', 'Warning', MB_ICONWARNING);
      QaacHEBtn.Checked := False;
    end;

  end;
end;

procedure TCodecSettingsForm.SaveCustom;
var
  SettingsFile: TIniFile;
begin
  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + '\custom.ini');
  try
    with SettingsFile do
    begin
      WriteString('cmd', 'fdk', FDKAACCMD);
      WriteString('cmd', 'ffmpegaac', FFMpegAACCMD);
      WriteString('cmd', 'fhg', FHGAACCMD);
      WriteString('cmd', 'nero', NeroAACCMD);
      WriteString('cmd', 'qaac', QAACCMD);
      WriteString('cmd', 'ac3', AC3CMD);
      WriteString('cmd', 'lame', LameCMD);
      WriteString('cmd', 'mpc', MPCCMD);
      WriteString('cmd', 'ogg', OggCMD);
      WriteString('cmd', 'opus', OpusCMD);
      WriteString('cmd', 'wma', WMACMD);
      WriteString('cmd', 'dcaenc', DcaencCMD);
      WriteString('cmd', 'alac2', ALACCMD);
      WriteString('cmd', 'flac', FLACCMD);
      ReadString('cmd', 'flaccl', FLACCLCMD);
      WriteString('cmd', 'ape', APECMD);
      WriteString('cmd', 'tak', TAKCMD);
      WriteString('cmd', 'tta', TTACMD);
      WriteString('cmd', 'wv', WavPackCMD);
      WriteString('cmd', 'aiff', AIFFCMD);
      WriteString('cmd', 'wav', WAVCMD);
    end;
  finally
    SettingsFile.Free;
  end;
end;

procedure TCodecSettingsForm.SaveOptions;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin
      WriteString('Settings', 'FAACBitrate', FAACBitrateEdit.Text);

      WriteInteger('Settings', 'QaacEncode', QaacEncodeMethodList.ItemIndex);
      WriteString('Settings', 'QaacQuality', QaacvQualityEdit.Text);
      WriteString('Settings', 'QaacBitrate', QaacBitrateEdit.Text);
      WriteInteger('Settings', 'QaacProfile', QaacQualityList.ItemIndex);
      WriteBool('Settings', 'QaacHE', QaacHEBtn.Checked);
      WriteBool('Settings', 'QaacND', QaacNoDelayBtn.Checked);

      WriteInteger('Settings', 'OggEncode', OggencodeList.ItemIndex);
      WriteString('Settings', 'OggQuality', OggQualityEdit.Text);
      WriteString('Settings', 'OggBitrate', OggBitrateEdit.Text);
      WriteBool('Settings', 'OggManaged', OggManagedBitrateBtn.Checked);
      WriteString('Settings', 'OggMax', OggMaxBitrateEdit.Text);
      WriteString('Settings', 'OggMin', OggMinBitrateEdit.Text);
      WriteBool('settings', 'OggTag', OggUseTTaggerBtn.Checked);

      WriteInteger('Settings', 'LAmeEncode', LameEncodeList.ItemIndex);
      WriteString('Settings', 'LameVBR2', LameVBREdit.Text);
      WriteString('Settings', 'LameBit', LameBitrateEdit.Text);
      WriteString('Settings', 'LameQ', LameQualityEdit.Text);
      WriteInteger('Settings', 'LameTag', LameTagList.ItemIndex);
      WriteInteger('settings', 'LameQBar', LameVBRBar.Position);
      WriteInteger('settings', 'lamechannel', LameChannelList.ItemIndex);
      WriteBool('settings', 'lamettagger', LameUseTTaggerBtn.Checked);

      WriteInteger('Settings', 'AftenEncode', AftenEncodeList.ItemIndex);
      WriteString('Settings', 'AftenQuality', AftenQualityEdit.Text);
      WriteString('Settings', 'AftenBitrate', AftenBitrateEdit.Text);
      WriteString('Settings', 'AfternDlg', AftenDialogEdit.Text);
      WriteBool('settings', 'aftendlg2', AftenDialogBtn.Checked);

      WriteInteger('Settings', 'FHGEncode', FHGMethodList.ItemIndex);
      WriteString('Settings', 'FHGQuality', FHGQualityEdit.Text);
      WriteString('Settings', 'FHGBitrate', FHGBitrateEdit.Text);
      WriteInteger('Settings', 'FHGProfile', FHGProfileList.ItemIndex);

      WriteInteger('Settings', 'OpusEnc', OpusEncodeMethodList.ItemIndex);
      WriteString('Settings', 'OpusBitrate', OpusBitrateEdit.Text);
      WriteString('Settings', 'OpusQuality', OpusCompEdit.Text);
      WriteBool('settings', 'OpusTag', OpusUseTTaggerBtn.Checked);

      WriteInteger('Settings', 'NeroEncode', NeroMethodList.ItemIndex);
      WriteString('Settings', 'NeroQuality2', NeroQualityEdit.Text);
      WriteString('Settings', 'NeroBitrate', NeroBitrateEdit.Text);
      WriteInteger('Settings', 'NeroProfile', NeroProfileList.ItemIndex);

      WriteInteger('Settings', 'MAC', MACLevelList.ItemIndex);
      WriteInteger('Settings', 'MPC', MPCQualityBar.Position);

      WriteInteger('Settings', 'WPMethod', WavPackMethodList.ItemIndex);
      WriteString('settings', 'WPBitrate', WavPackBitrateEdit.Text);
      WriteBool('Settings', 'WPExtra', WavPackExtraBtn.Checked);
      WriteBool('Settings', 'WPCorrect', WavPackCorrectionBtn.Checked);

      WriteInteger('Settings', 'FDKProfile', FDKProfileList.ItemIndex);
      WriteString('Settings', 'FDKBitrate', FDKBitrateEdit.Text);
      WriteInteger('Settings', 'FDKGapp', FDKGaplessList.ItemIndex);
      WriteInteger('Settings', 'FDKVBR', FDKVBRBar.Position);
      WriteInteger('Settings', 'DFKMethod', FDKMethodList.ItemIndex);

      WriteInteger('Settings', 'FlacComp', FLACCompList.ItemIndex);
      WriteBool('Settings', 'FlacEMS', FLACEMSBtn.Checked);
      WriteBool('settings', 'flactag', FLACUseTTaggerBtn.Checked);
      WriteBool('settings', 'flacverify', FLACVerifyBtn.Checked);

      WriteInteger('Settings', 'Depth', BitDepthList.ItemIndex);

      WriteInteger('Settings', 'WMAMethod', WMAMethodList.ItemIndex);
      WriteInteger('Settings', 'WMACodec', WMACodecList.ItemIndex);
      WriteInteger('Settings', 'WMAQaulity', WMAQualityList.ItemIndex);
      WriteString('Settings', 'WMABitrate', WMABitrateEdit.Text);

      WriteInteger('settings', 'flaccllvl', FLACCLLevelList.ItemIndex);
      WriteBool('settings', 'flaccltag', FLACCLUseTTaggerBtn.Checked);

      WriteInteger('settings', 'lossywav', LossyWAVQualityList.ItemIndex);
      WriteBool('settings', 'lossyextra', LossyWAVEncoderOptBtn.Checked);

      WriteInteger('sox', 'Sample', SampleList.ItemIndex);
      WriteInteger('sox', 'Channel', ChannelList.ItemIndex);

      WriteInteger('tak', 'takpreset', TAKPresetList.ItemIndex);
      WriteBool('tak', 'md5', TAKMd5Btn.Checked);
      WriteBool('tak', 'verify', TAKVerifyBtn.Checked);
      WriteInteger('tak', 'level', TAKLevelList.ItemIndex);
    end;

  finally
    SettingsFile.Free;
  end;

end;

procedure TCodecSettingsForm.sBitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TCodecSettingsForm.sLabel2Click(Sender: TObject);
begin
  if FileExists(MainForm.AppFolder + '\Tools\fhgaacenc\Readme.txt') then
  begin

    ShellExecute(Application.Handle, 'open', PChar(MainForm.AppFolder + '\Tools\fhgaacenc\Readme.txt'), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TCodecSettingsForm.WavPackMethodListChange(Sender: TObject);
begin
  WavPackBitrateEdit.Enabled := WavPackMethodList.ItemIndex = 1;
  WavPackCorrectionBtn.Enabled := WavPackBitrateEdit.Enabled;
end;

procedure TCodecSettingsForm.WMAMethodListChange(Sender: TObject);
begin
  WMAQualityList.Enabled := WMAMethodList.ItemIndex = 0;
  WMABitrateEdit.Enabled := not WMAQualityList.Enabled;
end;

end.
