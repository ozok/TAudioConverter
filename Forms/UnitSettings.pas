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

unit UnitSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.StdCtrls,
  sComboBox, sCheckBox, sEdit, sButton, IniFiles, Registry, ShellAPI, JvSpin,
  Vcl.ExtCtrls, sPanel, sDialogs, Vcl.ComCtrls, sPageControl, sTrackBar, sLabel,
  sSpinEdit, sGroupBox;

type
  TSettingsForm = class(TForm)
    sSkinProvider1: TsSkinProvider;
    ResetTmpBtn: TsButton;
    SelectTmpBtn: TsButton;
    TempEdit: TsEdit;
    CheckUpdateBtn: TsCheckBox;
    TagsBtn: TsCheckBox;
    ProcessCountList: TsComboBox;
    SkinList: TsComboBox;
    PostEncode2List: TsComboBox;
    ResetProcessBtn: TsButton;
    FolderStructBtn: TsCheckBox;
    ShellRegisterBtn: TsButton;
    ShellUnregisterBtn: TsButton;
    SeeLogBtn: TsButton;
    AACExtList: TsComboBox;
    ArtworkBtn: TsCheckBox;
    SkinBtn: TsCheckBox;
    OpenDialog1: TsOpenDialog;
    Artwork2Btn: TsCheckBox;
    FolderSuffixBtn: TsCheckBox;
    ArtworkSuffixBtn: TsCheckBox;
    ArtworkList: TsComboBox;
    ArtworkPriortyList: TsComboBox;
    AlwaysTopBtn: TsCheckBox;
    SettingsPage: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    CustomFolderEdit: TsEdit;
    FolderStructList: TsComboBox;
    sButton1: TsButton;
    CustomFileNameEdit: TsEdit;
    LogEnableBtn: TsCheckBox;
    PlayWavBtn: TsCheckBox;
    OverWriteList: TsComboBox;
    DontTrimBtn: TsCheckBox;
    IgnoreCueBtn: TsCheckBox;
    sTabSheet5: TsTabSheet;
    ReplayGainBtn: TsCheckBox;
    ReplayGainBar: TsTrackBar;
    ReplayGainEdit: TsEdit;
    RGResetBtn: TsButton;
    sLabel1: TsLabel;
    RGAutoLowerBtn: TsCheckBox;
    RGLToLBtn: TsCheckBox;
    sTabSheet4: TsTabSheet;
    FileLenghtList: TsComboBox;
    FileLengthEdit: TsSpinEdit;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    ShowExtraColumnsBtn: TsCheckBox;
    ClrListAfterEncodeBtn: TsCheckBox;
    sTabSheet6: TsTabSheet;
    CDParanoidBtn: TsCheckBox;
    CDJitterBtn: TsCheckBox;
    CDServerEdit: TsEdit;
    CDEmailEdit: TsEdit;
    DirDepthEdit: TsSpinEdit;
    sTabSheet7: TsTabSheet;
    ShowTextToolbarBtn: TsCheckBox;
    FileExtFilterEdit: TsEdit;
    ToolTagBtn: TsCheckBox;
    sGroupBox1: TsGroupBox;
    ResizeArtworkbtn: TsCheckBox;
    WidthEdit: TsSpinEdit;
    HeightEdit: TsSpinEdit;
    sLabel4: TsLabel;
    CDDownloadCoverBtn: TsCheckBox;
    DecodeBtn: TsCheckBox;
    UseMediaInfoBtn: TsCheckBox;
    RevertDefBtn: TsCheckBox;
    sButton2: TsButton;
    CDCustomFileNameEdit: TsEdit;
    CDOutputFolderEdit: TsEdit;
    sCheckBox1: TsCheckBox;
    sButton3: TsButton;
    procedure PostEncode2ListChange(Sender: TObject);
    procedure SkinListChange(Sender: TObject);
    procedure ResetProcessBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SelectTmpBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShellRegisterBtnClick(Sender: TObject);
    procedure ShellUnregisterBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SeeLogBtnClick(Sender: TObject);
    procedure SkinBtnClick(Sender: TObject);
    procedure ResetTmpBtnClick(Sender: TObject);
    procedure FolderStructBtnClick(Sender: TObject);
    procedure ArtworkBtnClick(Sender: TObject);
    procedure ArtworkListChange(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FolderStructListChange(Sender: TObject);
    procedure ReplayGainBarChange(Sender: TObject);
    procedure ReplayGainBtnClick(Sender: TObject);
    procedure RGResetBtnClick(Sender: TObject);
    procedure FileLenghtListChange(Sender: TObject);
    procedure ShowExtraColumnsBtnClick(Sender: TObject);
    procedure DontTrimBtnClick(Sender: TObject);
    procedure ShowTextToolbarBtnClick(Sender: TObject);
    procedure TagsBtnClick(Sender: TObject);
    procedure ResizeArtworkbtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
  private
    { Private declarations }
    // save/load options
    procedure LoadOptions();
    procedure SaveOptions();

    // shell extension
    procedure ShellExtensionRegister();
    procedure ShellExtensionUnRegister();
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

uses
  UnitMain, UnitAbout, UnitInfo, UnitLog, UnitProgress, UnitSox, UnitTag,
  UnitUpdater;

{ TForm1 }

procedure TSettingsForm.ArtworkBtnClick(Sender: TObject);
begin

  ArtworkList.Enabled := ArtworkBtn.Checked;

  if ArtworkBtn.Checked then
  begin
    ArtworkList.OnChange(self);
  end
  else
  begin
    Artwork2Btn.Enabled := False;
    ArtworkSuffixBtn.Enabled := False;
    ArtworkPriortyList.Enabled := False;
  end;

end;

procedure TSettingsForm.ArtworkListChange(Sender: TObject);
begin

  if ArtworkList.ItemIndex = 0 then
  begin
    Artwork2Btn.Enabled := True;
    ArtworkSuffixBtn.Enabled := True;
    ArtworkPriortyList.Enabled := False;
  end
  else if ArtworkList.ItemIndex = 2 then
  begin
    Artwork2Btn.Enabled := True;
    ArtworkSuffixBtn.Enabled := True;
    ArtworkPriortyList.Enabled := True;
  end
  else
  begin
    Artwork2Btn.Enabled := False;
    ArtworkSuffixBtn.Enabled := False;
    ArtworkPriortyList.Enabled := True;
  end;

end;

procedure TSettingsForm.DontTrimBtnClick(Sender: TObject);
begin
  MainForm.TrimBtn.Enabled := not DontTrimBtn.Checked;
end;

procedure TSettingsForm.FileLenghtListChange(Sender: TObject);
begin
  FileLengthEdit.Enabled := FileLenghtList.ItemIndex <> 0;
end;

procedure TSettingsForm.FolderStructBtnClick(Sender: TObject);
begin

  FolderStructList.Enabled := FolderStructBtn.Checked;

  if FolderStructBtn.Checked then
  begin
    FolderStructListChange(self);
  end
  else
  begin
    CustomFolderEdit.Enabled := False;
    CustomFileNameEdit.Enabled := False;
  end;

end;

procedure TSettingsForm.FolderStructListChange(Sender: TObject);
begin

  case FolderStructList.ItemIndex of
    0:
      begin
        CustomFolderEdit.Enabled := False;
        CustomFileNameEdit.Enabled := False;
        DirDepthEdit.Enabled := False;
      end;
    1:
      begin
        CustomFolderEdit.Enabled := False;
        CustomFileNameEdit.Enabled := False;
        DirDepthEdit.Enabled := False;
      end;
    2:
      begin
        CustomFolderEdit.Enabled := True;
        CustomFileNameEdit.Enabled := True;
        DirDepthEdit.Enabled := False;
      end;
    3:
      begin
        CustomFolderEdit.Enabled := False;
        CustomFileNameEdit.Enabled := False;
        DirDepthEdit.Enabled := True;
      end;
  end;

end;

procedure TSettingsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  SaveOptions;
  MainForm.Enabled := True;
  MainForm.BringToFront;

  if AlwaysTopBtn.Checked then
  begin
    MainForm.FormStyle := fsStayOnTop;
    SettingsForm.FormStyle := fsStayOnTop;
    SettingsForm.FormStyle := fsStayOnTop;
    AboutForm.FormStyle := fsStayOnTop;
    InfoForm.FormStyle := fsStayOnTop;
    LogForm.FormStyle := fsStayOnTop;
    ProgressForm.FormStyle := fsStayOnTop;
    FiltersForm.FormStyle := fsStayOnTop;
    TagForm.FormStyle := fsStayOnTop;
    UpdaterForm.FormStyle := fsStayOnTop;
  end
  else
  begin
    MainForm.FormStyle := fsNormal;
    SettingsForm.FormStyle := fsNormal;
    AboutForm.FormStyle := fsNormal;
    InfoForm.FormStyle := fsNormal;
    LogForm.FormStyle := fsNormal;
    ProgressForm.FormStyle := fsNormal;
    FiltersForm.FormStyle := fsNormal;
    TagForm.FormStyle := fsNormal;
    UpdaterForm.FormStyle := fsNormal;
  end;

end;

procedure TSettingsForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  // skins
  for I := 0 to MainForm.sSkinManager1.InternalSkins.Count - 1 do
  begin
    SkinList.Items.Add(MainForm.sSkinManager1.InternalSkins[i].Name);
  end;
  SkinList.ItemIndex := 1;

  LoadOptions;
end;

procedure TSettingsForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
  begin
    self.Close;
  end;

end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  RevertDefBtn.Enabled := MainForm.IsPortable;
end;

procedure TSettingsForm.LoadOptions;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin
      TempEdit.Text := ReadString('Settings', 'Temp', MainForm.SystemInfo.Folders.Temp + '\TAudioConverter\');

      CheckUpdateBtn.Checked := ReadBool('Settings', 'Update', True);

      PostEncode2List.ItemIndex := ReadInteger('Settings', 'Post', 0);

      ProcessCountList.ItemIndex := ReadInteger('Settings', 'Process', MainForm.DecideNumOfProcesses - 1);
      TagsBtn.Checked := ReadBool('Settings', 'Tags', True);
      SkinList.ItemIndex := ReadInteger('Settings', 'Skin', 2);
      SkinBtn.Checked := ReadBool('Settings', 'Skin3', True);
      FolderStructBtn.Checked := ReadBool('Settings', 'folder', True);
      FolderStructList.ItemIndex := ReadInteger('Settings', 'folder3', 0);
      AACExtList.ItemIndex := ReadInteger('Settings', 'AAC', 0);
      ArtworkBtn.Checked := ReadBool('Settings', 'artwork', False);
      Artwork2Btn.Checked := ReadBool('Settings', 'artwork2', False);
      ArtworkSuffixBtn.Checked := ReadBool('Settings', 'ArtWorkSuf', False);
      FolderSuffixBtn.Checked := ReadBool('Settings', 'FolderSuf', True);
      ArtworkList.ItemIndex := ReadInteger('settings', 'artworklist', 0);
      ArtworkPriortyList.ItemIndex := ReadInteger('settings', 'artworkpri', 0);
      ResizeArtworkbtn.Checked := ReadBool('settings', 'resizeart', False);
      WidthEdit.Text := ReadString('settings', 'artw', '300');
      HeightEdit.Text := ReadString('settings', 'arth', '300');
      AlwaysTopBtn.Checked := ReadBool('settings', 'ontop', False);
      CustomFolderEdit.Text := ReadString('settings', 'folderstr', '');
      CustomFileNameEdit.Text := ReadString('settings', 'filenamestr', '');
      LogEnableBtn.Checked := ReadBool('settings', 'keeplogs', False);
      OverWriteList.ItemIndex := ReadInteger('settings', 'skiplist', 0);
      PlayWavBtn.Checked := ReadBool('settings', 'playwav', True);
      DontTrimBtn.Checked := ReadBool('settings', 'trimming', True);
      IgnoreCueBtn.Checked := ReadBool('settings', 'ignorecue', False);
      ReplayGainBtn.Checked := ReadBool('settings', 'RG', False);
      ReplayGainBar.Position := ReadInteger('settings', 'RGvalue', 890);
      RGAutoLowerBtn.Checked := ReadBool('settings', 'RGlow', True);
      RGLToLBtn.Checked := ReadBool('settings', 'l2l', True);
      // ReplayGainList.ItemIndex := ReadInteger('settings', 'RGMethod', 0);
      FileLenghtList.ItemIndex := ReadInteger('settings', 'filelength1', 0);
      FileLengthEdit.Text := ReadString('settings', 'filelength2', '1800');
      ShowExtraColumnsBtn.Checked := ReadBool('settings', 'extracol', True);
      ClrListAfterEncodeBtn.Checked := ReadBool('settings', 'clrafter', False);
      ShowTextToolbarBtn.Checked := ReadBool('settings', 'toolbartext', True);
      DirDepthEdit.Text := ReadString('settings', 'dirdepth', '1');
      ToolTagBtn.Checked := ReadBool('settings', 'tooltag', True);
      FileExtFilterEdit.Text := ReadString('settings', 'extfilter', '');
      DecodeBtn.Checked := ReadBool('settings', 'decode', False);
      UseMediaInfoBtn.Checked := ReadBool('settings', 'mediainfo', False);

      CDParanoidBtn.Checked := ReadBool('settings', 'cdparanoid', False);
      CDJitterBtn.Checked := ReadBool('settings', 'jitter', False);
      CDServerEdit.Text := ReadString('settings', 'cdserver', 'http://Freedb.Freedb.org');
      CDEmailEdit.Text := ReadString('settings', 'cdemail', 'user@tac.com');
      CDDownloadCoverBtn.Checked := ReadBool('settings', 'cdcover', True);
      RevertDefBtn.Checked := ReadBool('settings', 'deleteinvalidoutput', True);

      if ReadInteger('Settings', 'Settings', 0) >= SettingsPage.PageCount then
      begin
        SettingsPage.ActivePageIndex := 0;
      end
      else
      begin
        SettingsPage.ActivePageIndex := ReadInteger('Settings', 'Settings', 0);
      end;
    end;

  finally
    SettingsFile.Free;
    FolderStructListChange(self);
    FolderStructBtn.OnClick(self);
    ArtworkBtn.OnClick(self);
    ReplayGainBtn.OnClick(self);
    ReplayGainBarChange(self);
    FileLenghtListChange(self);
    DontTrimBtnClick(self);
    ShowTextToolbarBtnClick(self);
    TagsBtnClick(self);
  end;

end;

procedure TSettingsForm.PostEncode2ListChange(Sender: TObject);
begin
  MainForm.PostEncodeList.ItemIndex := PostEncode2List.ItemIndex;
end;

procedure TSettingsForm.ReplayGainBtnClick(Sender: TObject);
begin
  ReplayGainBar.Enabled := ReplayGainBtn.Checked;
  ReplayGainEdit.Enabled := ReplayGainBtn.Checked;
  // ReplayGainList.Enabled := ReplayGainBtn.Checked;
  RGAutoLowerBtn.Enabled := ReplayGainBtn.Checked;
  // RGLToLBtn.Enabled := ReplayGainBtn.Checked;
  RGResetBtn.Enabled := ReplayGainBtn.Checked;
end;

procedure TSettingsForm.ReplayGainBarChange(Sender: TObject);
begin
  ReplayGainEdit.Text := FloatToStr(ReplayGainBar.Position / 10);
end;

procedure TSettingsForm.ResetProcessBtnClick(Sender: TObject);
begin
  ProcessCountList.ItemIndex := MainForm.DecideNumOfProcesses - 1;
end;

procedure TSettingsForm.ResetTmpBtnClick(Sender: TObject);
begin

  TempEdit.Text := MainForm.GetTempDirectory;

end;

procedure TSettingsForm.ResizeArtworkbtnClick(Sender: TObject);
begin
  HeightEdit.Enabled := ResizeArtworkbtn.Checked;
  WidthEdit.Enabled := ResizeArtworkbtn.Checked
end;

procedure TSettingsForm.SaveOptions;
var
  SettingsFile: TIniFile;
begin

  SettingsFile := TIniFile.Create(MainForm.AppDataFolder + 'settings.ini');
  try

    with SettingsFile do
    begin
      WriteString('Settings', 'Temp', TempEdit.Text);

      WriteBool('Settings', 'Update', CheckUpdateBtn.Checked);

      WriteInteger('Settings', 'Post', PostEncode2List.ItemIndex);

      WriteInteger('Settings', 'Process', ProcessCountList.ItemIndex);
      WriteBool('Settings', 'Tags', TagsBtn.Checked);
      WriteInteger('Settings', 'Skin', SkinList.ItemIndex);
      WriteBool('Settings', 'Skin3', SkinBtn.Checked);
      WriteBool('Settings', 'folder', FolderStructBtn.Checked);
      WriteInteger('Settings', 'folder3', FolderStructList.ItemIndex);
      WriteInteger('Settings', 'AAC', AACExtList.ItemIndex);
      WriteBool('Settings', 'artwork', ArtworkBtn.Checked);
      WriteBool('Settings', 'artwork2', Artwork2Btn.Checked);
      WriteBool('Settings', 'ArtWorkSuf', ArtworkSuffixBtn.Checked);
      WriteBool('Settings', 'FolderSuf', FolderSuffixBtn.Checked);
      WriteInteger('settings', 'artworklist', ArtworkList.ItemIndex);
      WriteInteger('settings', 'artworkpri', ArtworkPriortyList.ItemIndex);
      WriteBool('settings', 'resizeart', ResizeArtworkbtn.Checked);
      WriteString('settings', 'artw', WidthEdit.Text);
      WriteString('settings', 'arth', HeightEdit.Text);
      WriteBool('settings', 'ontop', AlwaysTopBtn.Checked);
      WriteString('settings', 'folderstr', CustomFolderEdit.Text);
      WriteString('settings', 'filenamestr', CustomFileNameEdit.Text);
      WriteBool('settings', 'keeplogs', LogEnableBtn.Checked);
      WriteInteger('settings', 'skiplist', OverWriteList.ItemIndex);
      WriteBool('settings', 'playwav', PlayWavBtn.Checked);
      WriteBool('settings', 'trimming', DontTrimBtn.Checked);
      WriteBool('settings', 'ignorecue', IgnoreCueBtn.Checked);
      WriteBool('settings', 'RG', ReplayGainBtn.Checked);
      WriteInteger('settings', 'RGvalue', ReplayGainBar.Position);
      WriteBool('settings', 'RGlow', RGAutoLowerBtn.Checked);
      WriteBool('settings', 'l2l', RGLToLBtn.Checked);
      // WriteInteger('settings', 'RGMethod', ReplayGainList.ItemIndex);
      WriteInteger('settings', 'filelength1', FileLenghtList.ItemIndex);
      WriteString('settings', 'filelength2', FileLengthEdit.Text);
      WriteBool('settings', 'extracol', ShowExtraColumnsBtn.Checked);
      WriteBool('settings', 'clrafter', ClrListAfterEncodeBtn.Checked);
      WriteBool('settings', 'toolbartext', ShowTextToolbarBtn.Checked);
      WriteString('settings', 'dirdepth', DirDepthEdit.Text);
      WriteBool('settings', 'tooltag', ToolTagBtn.Checked);
      WriteString('settings', 'extfilter', FileExtFilterEdit.Text);
      WriteBool('settings', 'decode', DecodeBtn.Checked);
      WriteBool('settings', 'mediainfo', UseMediaInfoBtn.Checked);
      WriteBool('settings', 'deleteinvalidoutput', RevertDefBtn.Checked);

      WriteBool('settings', 'cdparanoid', CDParanoidBtn.Checked);
      WriteBool('settings', 'jitter', CDJitterBtn.Checked);
      WriteString('settings', 'cdserver', CDServerEdit.Text);
      WriteString('settings', 'cdemail', CDEmailEdit.Text);
      WriteBool('settings', 'cdcover', CDDownloadCoverBtn.Checked);

      WriteInteger('Settings', 'Settings', SettingsPage.ActivePageIndex);
    end;

  finally
    SettingsFile.Free;
    SkinBtn.OnClick(self);
  end;

end;

procedure TSettingsForm.sButton1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(ExtractFileDir(Application.ExeName) + '\custompath.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TSettingsForm.sButton3Click(Sender: TObject);
begin
  CDEmailEdit.Text := 'user@tac.com';
  CDServerEdit.Text := 'http://Freedb.Freedb.org';
end;

procedure TSettingsForm.RGResetBtnClick(Sender: TObject);
begin
  ReplayGainBar.Position := 890;
  ReplayGainEdit.Text := '89';
end;

procedure TSettingsForm.SeeLogBtnClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar(MainForm.AppDataFolder), nil, nil, SW_SHOWNORMAL);
end;

procedure TSettingsForm.SelectTmpBtnClick(Sender: TObject);
begin
  Application.MessageBox('You are about to select a temp folder. Make sure you select an empty directory. Everything in temp folder will be deleted by TAC.', 'Warning', MB_ICONWARNING);
  if MainForm.OpenFolderDialog.Execute then
  begin
    if ExtractFileDir(Application.ExeName) <> MainForm.OpenFolderDialog.Directory then
    begin
      TempEdit.Text := MainForm.OpenFolderDialog.Directory;
    end
    else
    begin
      Application.MessageBox('Please select a folder other than TAC''s program folder.', 'Warning', MB_ICONWARNING);
    end;
  end;
end;

procedure TSettingsForm.ShellExtensionRegister();
begin
  // taken from http://www.delphidabbler.com/tips/15
  with TRegistry.Create do
  begin
    try
      RootKey := HKEY_CLASSES_ROOT;
      if OpenKey('*', True) then
      begin
        try
          if OpenKey('shell', True) then
          begin
            if OpenKey('TAC', True) then
            begin
              WriteString('', 'Encode with TAudioConverter');
              WriteString('Icon', '"' + Application.ExeName + '"');
              if OpenKey('command', True) then
              begin
                WriteString('', '"' + Application.ExeName + '" "%1"');
                Application.MessageBox('Register successful.', 'Info', MB_ICONINFORMATION);
              end
              else
              begin
                Application.MessageBox('Cannot register. Error:3', 'Error', MB_ICONERROR);
              end;
            end
            else
            begin
              Application.MessageBox('Cannot register. Error:2', 'Error', MB_ICONERROR);
            end;
          end
          else
          begin
            Application.MessageBox('Cannot register. Error:1', 'Error', MB_ICONERROR);
          end;
        finally
          CloseKey;
        end;
      end
      else
      begin
        Application.MessageBox('Cannot register. Error:0', 'Error', MB_ICONERROR);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TSettingsForm.ShellExtensionUnRegister;
begin
  // taken from http://www.delphidabbler.com/tips/15
  with TRegistry.Create do
  begin

    try
      RootKey := HKEY_CLASSES_ROOT;

      if OpenKey('*', True) then
      begin
        try

          if OpenKey('shell', True) then
          begin

            if DeleteKey('TAC') then
            begin
              Application.MessageBox('Unregister succesfull.', 'Unregister', MB_ICONINFORMATION);
            end
            else
            begin
              Application.MessageBox('Cannot unregister. Error:2', 'Error', MB_ICONERROR);
            end;

          end
          else
          begin
            Application.MessageBox('Cannot unregister. Error:1', 'Error', MB_ICONERROR);
          end;

        finally
          CloseKey;
        end;

      end
      else
      begin
        Application.MessageBox('Cannot unregister. Error:0', 'Error', MB_ICONERROR);
      end;

    finally
      Free;
    end;

  end;

end;

procedure TSettingsForm.ShellRegisterBtnClick(Sender: TObject);
begin

  ShellExtensionRegister();

end;

procedure TSettingsForm.ShellUnregisterBtnClick(Sender: TObject);
begin

  ShellExtensionUnRegister;

end;

procedure TSettingsForm.ShowExtraColumnsBtnClick(Sender: TObject);
begin
  if ShowExtraColumnsBtn.Checked then
  begin
    with MainForm.FileList do
    begin
      Columns[3].Width := 80;
      Columns[4].Width := 80;
      Columns[5].Width := 80;
      Columns[6].Width := 80;
      Columns[7].Width := 160;
      Columns[8].Width := 80;
      Columns[9].Width := 80;
      Columns[10].Width := 80;
    end;
  end
  else
  begin
    with MainForm.FileList do
    begin
      Columns[3].Width := 0;
      Columns[4].Width := 0;
      Columns[5].Width := 0;
      Columns[6].Width := 0;
      Columns[7].Width := 0;
      Columns[8].Width := 0;
      Columns[9].Width := 0;
      Columns[10].Width := 0;
    end;
  end;
end;

procedure TSettingsForm.ShowTextToolbarBtnClick(Sender: TObject);
begin
  with MainForm do
  begin
    AddBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    UpBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    DownBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    RemoveBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    RemoveAllBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    InfoBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    TagEditorBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    TrimBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    StartBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    RefreshBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    CDOptionsBtn.ShowCaption := ShowTextToolbarBtn.Checked;
    RipBtn.ShowCaption := ShowTextToolbarBtn.Checked;
  end;
end;

procedure TSettingsForm.SkinBtnClick(Sender: TObject);
begin

  SkinList.Enabled := not SkinBtn.Checked;
  MainForm.sSkinManager1.Active := not SkinBtn.Checked;
  if MainForm.sSkinManager1.Active then
  begin
    MainForm.sSkinManager1.RepaintForms(False);
    MainForm.ProgressPanel.Repaint;
    self.Repaint;
    MainForm.Repaint;
  end;

end;

procedure TSettingsForm.SkinListChange(Sender: TObject);
begin

  MainForm.sSkinManager1.SkinName := MainForm.sSkinManager1.InternalSkins[SkinList.ItemIndex].Name;

end;

procedure TSettingsForm.TagsBtnClick(Sender: TObject);
begin
  ToolTagBtn.Enabled := TagsBtn.Checked;
end;

end.

