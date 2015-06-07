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

unit UnitTagEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.StdCtrls,
  Vcl.Buttons, sBitBtn, Vcl.ComCtrls, sListView, sLabel, sEdit, Vcl.ImgList,
  acAlphaImageList, UnitTagTypes;

type
  TTagEditorForm = class(TForm)
    sSkinProvider1: TsSkinProvider;
    TagList: TsListView;
    CancelBtn: TsBitBtn;
    SaveBtn: TsBitBtn;
    sLabel1: TsLabel;
    TagEditEdit: TsEdit;
    sAlphaImageList1: TsAlphaImageList;
    ApplyBtn: TsBitBtn;
    procedure FormResize(Sender: TObject);
    procedure TagListClick(Sender: TObject);
    procedure TagEditEditExit(Sender: TObject);
    procedure TagEditEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBtnClick(Sender: TObject);
    procedure TagEditEditMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    IsScrolling: Boolean;
    PreviousWndProc: TWndMethod;
    procedure ListViewWndProc(var Message: TMessage);
  public
    { Public declarations }
    FileIndex: Integer;
  end;

var
  TagEditorForm: TTagEditorForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TTagEditorForm.ApplyBtnClick(Sender: TObject);
var
  LTag: TTagInfo;
begin

  with LTag do
  begin
    Title := TagList.Items[0].SubItems[0];
    Artist := TagList.Items[1].SubItems[0];
    Album := TagList.Items[2].SubItems[0];
    Genre := TagList.Items[3].SubItems[0];
    RecordDate := TagList.Items[4].SubItems[0];
    Comment := TagList.Items[5].SubItems[0];
    Performer := TagList.Items[6].SubItems[0];
    Composer := TagList.Items[7].SubItems[0];
    TrackNo := TagList.Items[8].SubItems[0];
    TrackTotal := TagList.Items[9].SubItems[0];
    DiscNo := TagList.Items[10].SubItems[0];
    DiscTotal := TagList.Items[11].SubItems[0];
    AlbumArtist := TagList.Items[12].SubItems[0];
    NameSort := TagList.Items[13].SubItems[0];
    AlbumSort := TagList.Items[14].SubItems[0];
    AlbumArtistSort := TagList.Items[15].SubItems[0];
    ComposerSort := TagList.Items[16].SubItems[0];
    AlbumComposer := TagList.Items[17].SubItems[0];

    TitleForFileName := MainForm.RemoveInvalidChars(Title);
    AlbumForFileName := MainForm.RemoveInvalidChars(Album);
    ArtistForFileName := MainForm.RemoveInvalidChars(Artist);
  end;

  MainForm.TagsList[FileIndex] := LTag;
  MainForm.FileList.Items[FileIndex].SubItems[6] := LTag.Title;
  MainForm.FileList.Items[FileIndex].SubItems[7] := LTag.Album;
  MainForm.FileList.Items[FileIndex].SubItems[8] := LTag.Artist;
  MainForm.FileList.Items[FileIndex].SubItems[9] := LTag.Genre;
end;

procedure TTagEditorForm.CancelBtnClick(Sender: TObject);
begin
  TagList.Items.Clear;
  Self.Close;
end;

procedure TTagEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TagList.Items.Clear;
  TagEditEdit.Text := '';
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TTagEditorForm.FormCreate(Sender: TObject);
begin
  PreviousWndProc := TagList.WindowProc;
  TagList.WindowProc := ListViewWndProc;
end;

procedure TTagEditorForm.FormResize(Sender: TObject);
begin
  TagList.Columns[0].Width := 100;
  TagList.Columns[1].Width := TagList.ClientWidth - TagList.Columns[0].Width;
end;

procedure TTagEditorForm.FormShow(Sender: TObject);
begin
  if MainForm.sSkinManager1.Active = False then
  begin
    Self.Color := clBtnFace;
  end;
end;

procedure TTagEditorForm.ListViewWndProc(var Message: TMessage);
begin
  PreviousWndProc(Message);
  case Message.Msg of
    WM_VSCROLL:
      begin
        if TWMVScroll(Message).ScrollCode = SB_ENDSCROLL then
        begin
          if IsScrolling then
          begin
            IsScrolling := False;
            // do something...
          end;
          if TagEditEdit.Visible then
          begin
            if TagList.ItemIndex > -1 then
            begin
              TagEditEdit.Left := TagList.Items[TagList.ItemIndex].GetPosition.X + TagList.Columns[0].Width + TagList.Margins.Left;
              TagEditEdit.Top := TagList.Items[TagList.ItemIndex].GetPosition.Y + TagList.Margins.Top * 2;
              TagEditEdit.Width := TagList.Columns[1].Width;
            end;
          end;
        end
        else if not IsScrolling then
        begin
          IsScrolling := True;
          if TagEditEdit.Visible then
          begin
            if TagList.ItemIndex > -1 then
            begin
              TagEditEdit.Left := TagList.Items[TagList.ItemIndex].GetPosition.X + TagList.Columns[0].Width + TagList.Margins.Left;
              TagEditEdit.Top := TagList.Items[TagList.ItemIndex].GetPosition.Y + TagList.Margins.Top * 2;
              TagEditEdit.Width := TagList.Columns[1].Width;
            end;
          end;
        end;
      end;
  end;
end;

procedure TTagEditorForm.SaveBtnClick(Sender: TObject);
var
  LTag: TTagInfo;
begin

  with LTag do
  begin
    Title := TagList.Items[0].SubItems[0];
    Artist := TagList.Items[1].SubItems[0];
    Album := TagList.Items[2].SubItems[0];
    Genre := TagList.Items[3].SubItems[0];
    RecordDate := TagList.Items[4].SubItems[0];
    Comment := TagList.Items[5].SubItems[0];
    Performer := TagList.Items[6].SubItems[0];
    Composer := TagList.Items[7].SubItems[0];
    TrackNo := TagList.Items[8].SubItems[0];
    TrackTotal := TagList.Items[9].SubItems[0];
    DiscNo := TagList.Items[10].SubItems[0];
    DiscTotal := TagList.Items[11].SubItems[0];
    AlbumArtist := TagList.Items[12].SubItems[0];
    NameSort := TagList.Items[13].SubItems[0];
    AlbumSort := TagList.Items[14].SubItems[0];
    AlbumArtistSort := TagList.Items[15].SubItems[0];
    ComposerSort := TagList.Items[16].SubItems[0];
    AlbumComposer := TagList.Items[17].SubItems[0];

    TitleForFileName := MainForm.RemoveInvalidChars(Title);
    AlbumForFileName := MainForm.RemoveInvalidChars(Album);
    ArtistForFileName := MainForm.RemoveInvalidChars(Artist);
  end;

  MainForm.TagsList[FileIndex] := LTag;
  MainForm.FileList.Items[FileIndex].SubItems[6] := LTag.Title;
  MainForm.FileList.Items[FileIndex].SubItems[7] := LTag.Album;
  MainForm.FileList.Items[FileIndex].SubItems[8] := LTag.Artist;
  MainForm.FileList.Items[FileIndex].SubItems[9] := LTag.Genre;
  TagList.Items.Clear;
  Close;
end;

procedure TTagEditorForm.TagEditEditExit(Sender: TObject);
begin
  if TagEditEdit.Visible then
  begin
    if TagList.ItemIndex > -1 then
    begin
      TagList.Items[TagList.ItemIndex].SubItems[0] := TagEditEdit.Text;
      TagEditEdit.Visible := False;
    end;
  end;
end;

procedure TTagEditorForm.TagEditEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if TagEditEdit.Visible then
  begin
    if TagList.ItemIndex > -1 then
    begin
      if Key = VK_RETURN then
      begin
        TagList.Items[TagList.ItemIndex].SubItems[0] := TagEditEdit.Text;
        TagEditEdit.Visible := False;
      end
      else if Key = VK_ESCAPE then
      begin
        TagEditEdit.Visible := False;
      end;
    end;
  end;
end;

procedure TTagEditorForm.TagEditEditMouseLeave(Sender: TObject);
begin
  // TagEditEdit.Visible := False;
end;

procedure TTagEditorForm.TagListClick(Sender: TObject);
var
  LItemIndex: Integer;
  Litem: TListItem;
begin

  LItemIndex := TagList.ItemIndex;
  if LItemIndex > -1 then
  begin
    TagEditEdit.Left := TagList.Items[LItemIndex].GetPosition.X + TagList.Columns[0].Width + TagList.Margins.Left;
    TagEditEdit.Top := TagList.Items[LItemIndex].GetPosition.Y + TagList.Margins.Top * 2;
    TagEditEdit.Width := TagList.Columns[1].Width;
    TagEditEdit.Text := TagList.Items[LItemIndex].SubItems[0];
    Litem := TagList.Items[LItemIndex];
    if (Litem.Caption = 'Track') or (Litem.Caption = 'Total Track') or (Litem.Caption = 'Disc') or (Litem.Caption = 'Total Disc') or (Litem.Caption = 'Date') then
    begin
      TagEditEdit.NumbersOnly := True;
    end
    else
    begin
      TagEditEdit.NumbersOnly := False;
    end;
    TagEditEdit.Visible := True;
    TagEditEdit.BringToFront;
    TagEditEdit.SetFocus;
  end
  else
  begin
    if TagEditEdit.Visible then
    begin
      TagEditEdit.Visible := False;
    end;
  end;

end;

end.
