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

unit Unit3rdParty;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sListView,
  sSkinProvider, Vcl.StdCtrls, sButton;

type
  TComponentsForm = class(TForm)
    sSkinProvider1: TsSkinProvider;
    ComponentsList: TsListView;
    sButton1: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ComponentsForm: TComponentsForm;

implementation

{$R *.dfm}

uses
  UnitMain;

procedure TComponentsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TComponentsForm.FormCreate(Sender: TObject);
var
  LSplitList: TStringList;
  LItem: TListItem;
  LStreamReader: TStreamReader;
begin
  LSplitList := TStringList.Create;
  try
    LSplitList.StrictDelimiter := True;
    LSplitList.Delimiter := '|';

    LStreamReader := TStreamReader.Create(ExtractFileDir(Application.ExeName) + '\components.txt');
    try
      while not LStreamReader.EndOfStream do
      begin
        Application.ProcessMessages;

        LSplitList.DelimitedText := LStreamReader.ReadLine;

        if LSplitList.Count = 2 then
        begin
          LItem := ComponentsList.Items.Add;
          LItem.Caption := LSplitList[0];
          LItem.SubItems.Add(LSplitList[1]);
        end;
      end;
    finally
      LStreamReader.Close;
      LStreamReader.Free;
    end;
  finally
    LSplitList.Free;
  end;
end;

procedure TComponentsForm.FormResize(Sender: TObject);
begin
  ComponentsList.Columns[1].Width := 170;
  ComponentsList.Columns[0].Width := ComponentsList.ClientWidth - ComponentsList.Columns[1].Width - 20;
end;

procedure TComponentsForm.FormShow(Sender: TObject);
begin
  if MainForm.sSkinManager1.Active = false then
  begin
    self.Color := clBtnFace;
    ComponentsList.Color := clWindow;
  end;
end;

procedure TComponentsForm.sButton1Click(Sender: TObject);
begin
  Close;
end;

end.

