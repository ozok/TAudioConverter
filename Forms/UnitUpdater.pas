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

unit UnitUpdater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  sListBox, sCheckListBox, Vcl.Buttons, sBitBtn, JvUrlListGrabber,
  JvUrlGrabbers,
  JvComponentBase, JvThread, sLabel, sGauge, ShellAPI, Vcl.ComCtrls,
  JvExControls, JvXPCore,
  JvXPButtons, acPNG, sSkinProvider;

type
  TUpdaterForm = class(TForm)
    UpdateThread: TJvThread;
    Downloader: TJvHttpUrlGrabber;
    ChangeList: TsListBox;
    WNDownloader: TJvHttpUrlGrabber;
    sSkinProvider1: TsSkinProvider;
    HomeBtn: TsBitBtn;
    procedure UpdateThreadExecute(Sender: TObject; Params: Pointer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HomeBtnClick(Sender: TObject);
    procedure DownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
    procedure WNDownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdaterForm: TUpdaterForm;

const
  // todo: change that and don't delete this todo
  Build = 3835;

implementation

{$R *.dfm}

uses UnitMain;

procedure TUpdaterForm.DownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
var
  VersionFile: TStringList;
  LatestVersion: Integer;
begin
  // check if there is a newer version
  VersionFile := TStringList.Create;
  try
    if StreamSize > 0 then
    begin
      VersionFile.LoadFromStream(Stream);
      if VersionFile.Count = 1 then
      begin
        if TryStrToInt(VersionFile[0], LatestVersion) then
        begin
          if LatestVersion > Build then
          begin
            // download what's new
            with WNDownloader do
            begin
              Url := 'http://sourceforge.net/projects/taudioconverter/files/TAudioConverterwn.txt/download';
              Start;
            end;
          end
          else
          begin
            Application.MessageBox('You have the latest version.', 'Info', MB_ICONINFORMATION);
            Self.Caption := 'Updater';
            Self.Close;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(VersionFile);
  end;
end;

procedure TUpdaterForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not UpdateThread.Terminated then
  begin
    UpdateThread.Terminate;
  end;

  while not UpdateThread.Terminated do
  begin
    Application.ProcessMessages;
    Sleep(10);
  end;

  MainForm.Enabled := true;
  MainForm.BringToFront;
end;

procedure TUpdaterForm.FormShow(Sender: TObject);
begin
  Self.Caption := 'Updater [Checking update please wait...]';
  ChangeList.Items.Clear;
  HomeBtn.Enabled := false;

  UpdateThread.Execute(nil)
end;

procedure TUpdaterForm.HomeBtnClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://www.fosshub.com/TAudioConverter.html', nil, nil, SW_SHOWNORMAL);
end;

procedure TUpdaterForm.UpdateThreadExecute(Sender: TObject; Params: Pointer);
begin
  // check update
  with Downloader do
  begin
    Url := 'http://sourceforge.net/projects/taudioconverter/files/TAudioConverter.txt/download';
    Start;
  end;

  UpdateThread.CancelExecute;
end;

procedure TUpdaterForm.WNDownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
begin
  if StreamSize > 0 then
  begin
    ChangeList.Items.LoadFromStream(Stream);
    MainForm.UpdateListboxScrollBox(ChangeList);

    Self.Caption := 'Updater';

    if ChangeList.Items.Count > 0 then
    begin
      HomeBtn.Enabled := true;
    end
    else
    begin
      Application.MessageBox('There seems to be a new version but TAudioConverter could not download what''s new info!.', 'Error', MB_ICONERROR);
    end;
  end;
end;

end.
