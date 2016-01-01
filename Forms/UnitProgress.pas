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

unit UnitProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, sBitBtn, sSkinProvider, sGauge, JvExControls, JvXPCore,
  JvXPButtons, acPNG, sEdit, sLabel, Vcl.ExtCtrls, sPanel;

type
  TProgressForm = class(TForm)
    AbortBtn: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    CurrentFileLabel: TsLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AbortBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProgressForm: TProgressForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TProgressForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  CurrentFileLabel.Caption := '';

end;

procedure TProgressForm.FormShow(Sender: TObject);
begin

  Self.Width := MainForm.Width - 30;
  Self.Left := MainForm.Left + 15;

end;

procedure TProgressForm.AbortBtnClick(Sender: TObject);
begin

  if MainForm.FileSearch.Searching then
  begin
    MainForm.FileSearch.Abort;
  end
  else
  begin
    MainForm.AddingStopped := True;
  end;

end;

end.

