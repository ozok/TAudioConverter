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

unit UnitAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPI, sSkinProvider, sButton, Vcl.Buttons,
  sBitBtn, JvExControls, JvXPCore, JvXPButtons, acPNG, sMemo, sLabel, Vcl.ComCtrls,
  sPageControl;

type
  TAboutForm = class(TForm)
    Image1: TImage;
    Label1: TsLabel;
    Label2: TsLabel;
    Label3: TsLabel;
    Label4: TsLabel;
    CloseBtn: TsBitBtn;
    Memo2: TsMemo;
    sSkinProvider1: TsSkinProvider;
    DonateBtn: TsBitBtn;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    HomepageBtn: TsBitBtn;
    SourceBtn: TsBitBtn;
    sBitBtn1: TsBitBtn;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sMemo1: TsMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBtnClick(Sender: TObject);
    procedure HomepageBtnClick(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure SourceBtnClick(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DonateBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

const
  Build = '3899';

implementation

uses
  UnitMain;

{$R *.dfm}

procedure TAboutForm.CloseBtnClick(Sender: TObject);
begin

  Self.Close;

end;

procedure TAboutForm.DonateBtnClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=USMWJE4WFDFX2', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'TAudioConverter 0.9.9 Build: ' + Build;
end;

procedure TAboutForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Self.Close;
  end;
end;

procedure TAboutForm.HomepageBtnClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://taudioconverter.sourceforge.net/', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.sBitBtn1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://www.hydrogenaudio.org/forums/index.php?showtopic=98327&st=0', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.sButton1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://forum.doom9.org/showthread.php?t=164606', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.sButton2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://doom10.org/index.php?topic=2194.0', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.SourceBtnClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'https://bitbucket.org/ozok/taudioconverter-audio-converter/src', nil, nil, SW_SHOWNORMAL);
end;

end.

