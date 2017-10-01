{*
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
 *}

unit UnitInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sSkinProvider, sListBox, Vcl.Buttons, sBitBtn, Vcl.ComCtrls,
  JvExControls, JvXPCore, JvXPButtons, acPNG, sDialogs, sListView, Vcl.ImgList,
  acAlphaImageList, sTreeView, sPageControl, sMemo, System.ImageList;

type
  TInfoForm = class(TForm)
    CloseBtn: TsBitBtn;
    SaveDialog1: TsSaveDialog;
    SaveBtn: TsBitBtn;
    sSkinProvider1: TsSkinProvider;
    InfoList: TsTreeView;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    FFProbeList: TsMemo;
    sTabSheet3: TsTabSheet;
    TagList: TsListView;
    sAlphaImageList1: TsAlphaImageList;
    procedure CloseBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InfoTMP: TStringList;
  end;

var
  InfoForm: TInfoForm;

implementation

{$R *.dfm}

procedure TInfoForm.CloseBtnClick(Sender: TObject);
begin

  Self.Close;

end;

procedure TInfoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  InfoList.Items.Clear;
  FFProbeList.Lines.Clear;
  TagList.Items.Clear;
  InfoTMP.Clear;

end;

procedure TInfoForm.FormCreate(Sender: TObject);
begin

  InfoTMP := TStringList.Create;

end;

procedure TInfoForm.FormDestroy(Sender: TObject);
begin

  FreeAndNil(InfoTMP);

end;

procedure TInfoForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
  begin
    Close;
  end;

end;

procedure TInfoForm.FormResize(Sender: TObject);
begin
  TagList.Columns[0].Width := TagList.ClientWidth div 2 - 10;
  TagList.Columns[1].Width := TagList.ClientWidth div 2 - 10;
end;

procedure TInfoForm.SaveBtnClick(Sender: TObject);
var
  LTMPLst: TStringList;
  I: Integer;
begin
  if InfoList.Items.Count > 0 then
  begin
    case sPageControl1.ActivePageIndex of
      0:
        SaveDialog1.FileName := 'TAC_mediainfo.txt';
      1:
        SaveDialog1.FileName := 'TAC_ffprobe.txt';
      2:
        SaveDialog1.FileName := 'TAC_tags.txt';
    end;

    if SaveDialog1.Execute then
    begin
      if sPageControl1.ActivePageIndex = 0 then
      begin
        InfoTMP.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
      end
      else if sPageControl1.ActivePageIndex = 1 then
      begin
        FFProbeList.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
      end
      else
      begin
        LTMPLst := TStringList.Create;
        try
          for I := 0 to TagList.Items.Count - 1 do
          begin
            LTMPLst.Add(TagList.Items[i].Caption + ': ' + TagList.Items[i].SubItems[0]);
          end;
        finally
          LTMPLst.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);
          LTMPLst.Free;
        end;
      end;
    end;

  end;

end;

end.

