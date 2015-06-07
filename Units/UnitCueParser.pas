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
// handles extracting information from cue sheets
unit UnitCueParser;

interface

uses Classes, Windows, SysUtils, Messages, StrUtils, Generics.Collections;

type
  TCueTrackDurationInfo = packed record
    StartPos: Integer;
    EndPos: integer;
    PreGap: integer;
    PostGap: integer;
    Duration: integer;
  end;

type
  TCueTrackTagInfo = packed record
    Title: string;
    Artist: string;
    Album: string;
    TitleForFileName: string;
    ArtistForFileName: string;
    AlbumForFileName: string;
    Composer: string;
  end;

type
  TCueTrackInfo = packed record
    CueTrackTagInfo: TCueTrackTagInfo;
    CueTrackDurationInfo: TCueTrackDurationInfo;
  end;

type
  TExtraComments = packed record
    CommentName: string;
    CommentValue: string;
  end;

type
  TCueInfo = class(TObject)
  public
    SongFileName: string;
    Performer: string;
    Title: string;
    TrackCount: integer;
    ExtraComments: TList<TExtraComments>;
    constructor Create();
    destructor Destroy; override;
  end;

type
  TCueSplitter = class(TObject)
  private
    FCueInfo: TCueInfo;
    FCueTrackInfos: TList<TCueTrackInfo>;
    FCueFile: TStringList;
    FErrorMsg: integer;
    FTrackStartIndexes: TList<integer>;
    FFileDuration: integer;
    FCueSheetPath: string;

    function StringStartsWith(const Str: string; const StartStr: string): Boolean;
    function IsLineTrack(const Str: string): Boolean;

    function REMtoList(const Str: string): TExtraComments;
    function GetPerformer(const Str: string): string;
    function GetFile(const Str: string): string;
    function GetTitle(const Str: string): string;
    function GetTrackTagInfo(const InfoList: TStringList): TCueTrackInfo;
    function GetIndex(const Str: string): string;

    function IndexToMiliSeconds(const Str: string): Integer;
    function RemoveInvalidPathChars(const SourceStr: string): string;

    function GetTrackCount: integer;
    function GetSongFileName: string;
  public
    property ErrorMsg: integer read FErrorMsg;
    property CueInfo: TCueInfo read FCueInfo;
    property CueTracksInfos: TList<TCueTrackInfo> read FCueTrackInfos;
    property FileDuration: integer read FFileDuration write FFileDuration;
    property TrackCount: integer read GetTrackCount;
    property SongFileName: string read GetSongFileName;

    constructor Create(const CueSheetPath: string);
    destructor Destroy; override;

    procedure ParseCueSheet();
  end;

implementation

const
  CD_FRAMES_PER_SECOND = 75;

  // error codes
const
  CUE_ERROR_OK = 0;
  CUE_ERROR_CUE_FILE_NOT_FOUND = 1;
  CUE_ERROR_FILE_EMPTY = 2;
  CUE_ERROR_NO_TRACKS = 3;

  { TCueInfo }

constructor TCueInfo.Create;
begin
  ExtraComments := TList<TExtraComments>.Create;
  Self.SongFileName := 'Unkown';
  Self.Performer := 'Unkown';
  Self.Title := 'Unkown';
end;

destructor TCueInfo.Destroy;
begin
  inherited;
  ExtraComments.Free;
end;

{ TCueSplitter }

constructor TCueSplitter.Create(const CueSheetPath: string);
begin
  inherited Create;
  FCueInfo := TCueInfo.Create;
  FCueFile := TStringList.Create;
  FCueTrackInfos := TList<TCueTrackInfo>.Create;
  FTrackStartIndexes := TList<Integer>.Create;
  FCueSheetPath := CueSheetPath;

  FErrorMsg := CUE_ERROR_OK;
  if FileExists(CueSheetPath) then
  begin
    FCueFile.LoadFromFile(CueSheetPath);
  end
  else
  begin
    FErrorMsg := CUE_ERROR_CUE_FILE_NOT_FOUND;
  end;
end;

destructor TCueSplitter.Destroy;
begin
  inherited;
  FCueInfo.Free;
  FCueFile.Free;
  FCueTrackInfos.Free;
  FTrackStartIndexes.Free;
end;

function TCueSplitter.GetFile(const Str: string): string;
const
  FILE_LINE = 'FILE';
var
  LStr: string;
begin
  Result := '';
  LStr := Str;
  Delete(LStr, 1, Length(FILE_LINE));
  LStr := Trim(LStr);

  if LStr[1] = '"' then
  begin
    Delete(LStr, 1, 1);
  end;
  if Pos('"', LStr) > 0 then
  begin
    Delete(LStr, Pos('"', LStr), MaxInt);
  end;

  Result := Trim(LStr);
end;

function TCueSplitter.GetIndex(const Str: string): string;
const
  INDEX_LINE = 'INDEX';
var
  LStr: string;
begin
  LStr := Str;
  Delete(LStr, 1, Length(INDEX_LINE));
  LStr := Trim(LStr);

  if LStr[1] = '"' then
  begin
    Delete(LStr, 1, 1);
  end;
  if LStr[Length(LStr)] = '"' then
  begin
    Delete(LStr, Length(LStr), 1);
  end;
  LStr := Trim(LStr);
  Delete(LStr, 1, 3);

  Result := Trim(LStr);
end;

function TCueSplitter.GetPerformer(const Str: string): string;
const
  PERFORMER_LINE = 'PERFORMER';
var
  LStr: string;
begin
  LStr := Str;
  Delete(LStr, 1, Length(PERFORMER_LINE));
  LStr := Trim(LStr);

  if LStr[1] = '"' then
  begin
    Delete(LStr, 1, 1);
  end;
  if LStr[Length(LStr)] = '"' then
  begin
    Delete(LStr, Length(LStr), 1);
  end;

  Result := Trim(LStr);
  if Length(Result) < 1 then
  begin
    Result := 'Unkown';
  end;
end;

function TCueSplitter.GetSongFileName: string;
const
  FILE_LINE = 'FILE';
var
  i: integer;
  LLine: string;
begin
  if FCueFile.Count > 0 then
  begin
    // search for FILE
    for I := 0 to FCueFile.Count - 1 do
    begin
      LLine := Trim(FCueFile[i]);
      if Length(LLine) > 0 then
      begin
        if StringStartsWith(LLine, FILE_LINE) then
        begin
          Result := ExtractFileDir(FCueSheetPath) + '\' + GetFile(LLine);
          Break;
        end;
      end;
    end;
  end
  else
  begin
    FErrorMsg := CUE_ERROR_FILE_EMPTY;
  end;
end;

function TCueSplitter.GetTitle(const Str: string): string;
const
  TITLE_LINE = 'TITLE';
var
  LStr: string;
begin
  Result := '';
  LStr := Str;
  Delete(LStr, 1, Length(TITLE_LINE));
  LStr := Trim(LStr);

  if LStr[1] = '"' then
  begin
    Delete(LStr, 1, 1);
  end;
  if Pos('"', LStr) > 0 then
  begin
    Delete(LStr, Pos('"', LStr), MaxInt);
  end;

  Result := Trim(LStr);
  if Length(Result) < 1 then
  begin
    Result := 'Unkown';
  end;
end;

function TCueSplitter.GetTrackCount: integer;
begin
  Result := FTrackStartIndexes.Count;
end;

function TCueSplitter.GetTrackTagInfo(const InfoList: TStringList): TCueTrackInfo;
const
  TITLE_LINE = 'TITLE';
  PERFORMER_LINE = 'PERFORMER';
  INDEX_LINE = 'INDEX';
var
  I: Integer;
  LLine: string;
begin
  if InfoList.Count > 0 then
  begin
    for I := 0 to InfoList.Count - 1 do
    begin
      LLine := Trim(InfoList[i]);
      if StringStartsWith(LLine, TITLE_LINE) then
      begin
        // title
        Result.CueTrackTagInfo.Title := GetTitle(LLine);
      end
      else if StringStartsWith(LLine, PERFORMER_LINE) then
      begin
        // performer
        Result.CueTrackTagInfo.Artist := GetPerformer(LLine);
      end
      else if StringStartsWith(LLine, INDEX_LINE) then
      begin
        // index
        Result.CueTrackDurationInfo.StartPos := IndexToMiliSeconds(GetIndex(LLine));
      end;
    end;
  end;
  if Length(Result.CueTrackTagInfo.Title) < 1 then
  begin
    Result.CueTrackTagInfo.Title := 'Unkown';
  end;
  Result.CueTrackTagInfo.TitleForFileName := RemoveInvalidPathChars(Result.CueTrackTagInfo.Title);

  if Length(Result.CueTrackTagInfo.Artist) < 1 then
  begin
    Result.CueTrackTagInfo.Artist := FCueInfo.Performer;
  end;
  Result.CueTrackTagInfo.ArtistForFileName := RemoveInvalidPathChars(Result.CueTrackTagInfo.Artist);

  Result.CueTrackTagInfo.Album := FCueInfo.Title;
  if Length(Result.CueTrackTagInfo.Album) < 1 then
  begin
    Result.CueTrackTagInfo.Album := 'Unkown';
  end;
  Result.CueTrackTagInfo.AlbumForFileName := RemoveInvalidPathChars(Result.CueTrackTagInfo.Album);
end;

function TCueSplitter.IndexToMiliSeconds(const Str: string): Integer;
var
  LSplitList: TStringList;
  LMin, LSec, LFrame: integer;
begin

  Result := 0;
  if Length(Str) > 0 then
  begin
    LSplitList := TStringList.Create;
    try
      LSplitList.StrictDelimiter := True;
      LSplitList.Delimiter := ':';
      LSplitList.DelimitedText := Str;
      if LSplitList.Count = 3 then
      begin
        LMin := StrToInt(LSplitList[0]);
        LSec := StrToInt(LSplitList[1]);
        LFrame := StrToInt(LSplitList[2]);
        Result := (60 * 1000 * LMin) + (1000 * LSec) + Round((1000 / CD_FRAMES_PER_SECOND) * LFrame);
      end;
    finally
      LSplitList.Free;
    end;
  end;

end;

function TCueSplitter.IsLineTrack(const Str: string): Boolean;
var
  LSpltList: TStringList;
begin
  Result := False;
  LSpltList := TStringList.Create;
  try
    LSpltList.StrictDelimiter := True;
    LSpltList.Delimiter := ' ';
    LSpltList.DelimitedText := Str;
    if LSpltList.Count >= 3 then
    begin
      if (LSpltList[0] = 'TRACK') and (LSpltList[2] = 'AUDIO') then
      begin
        Result := True;
      end;
    end;
  finally
    LSpltList.Free;
  end;
end;

procedure TCueSplitter.ParseCueSheet;
const
  REM_LINE = 'REM';
  PERFORMER_LINE = 'PERFORMER';
  TRACK_LINE = 'TRACK';
  FILE_LINE = 'FILE';
  CUE_TITLE_LINE = 'TITLE';
var
  i: integer;
  LLine: string;
  LCueTrackInfo: TCueTrackInfo;
  LGeneralTitleIndex: integer;
  J: Integer;
  LTrackInfoTmpStrList: TStringList;
begin
  if FCueFile.Count > 0 then
  begin
    // search for REMs
    for I := 0 to FCueFile.Count - 1 do
    begin
      LLine := Trim(FCueFile[i]);
      if Length(LLine) > 0 then
      begin
        if StringStartsWith(LLine, REM_LINE) then
        begin
          FCueInfo.ExtraComments.Add(REMtoList(LLine));
        end;
      end;
    end;
    // search for performer
    for I := 0 to FCueFile.Count - 1 do
    begin
      LLine := Trim(FCueFile[i]);
      if Length(LLine) > 0 then
      begin
        if StringStartsWith(LLine, PERFORMER_LINE) then
        begin
          FCueInfo.Performer := GetPerformer(LLine);
          Break;
        end;
      end;
    end;
    // search for FILE
    for I := 0 to FCueFile.Count - 1 do
    begin
      LLine := Trim(FCueFile[i]);
      if Length(LLine) > 0 then
      begin
        if StringStartsWith(LLine, FILE_LINE) then
        begin
          FCueInfo.SongFileName := GetFile(LLine);
          Break;
        end;
      end;
    end;
    // search for TITLE (general title)
    for I := 0 to FCueFile.Count - 1 do
    begin
      LLine := Trim(FCueFile[i]);
      if Length(LLine) > 0 then
      begin
        if StringStartsWith(LLine, CUE_TITLE_LINE) then
        begin
          FCueInfo.Title := GetTitle(LLine);
          LGeneralTitleIndex := i;
          Break;
        end;
      end;
    end;
    // search for tracks
    for I := LGeneralTitleIndex to FCueFile.Count - 1 do
    begin
      LLine := Trim(FCueFile[i]);
      if Length(LLine) > 0 then
      begin
        if StringStartsWith(LLine, TRACK_LINE) then
        begin
          if IsLineTrack(LLine) then
          begin
            FTrackStartIndexes.Add(i);
          end;
        end;
      end;
    end;
    // extract information about tracks
    if FTrackStartIndexes.Count > 0 then
    begin
      for I := 0 to FTrackStartIndexes.Count - 1 do
      begin
        if i < FTrackStartIndexes.Count - 1 then
        begin
          for J := FTrackStartIndexes[i] to FTrackStartIndexes[i + 1] do
          begin
            LTrackInfoTmpStrList := TStringList.Create;
            try
              LTrackInfoTmpStrList.Add(Trim(FCueFile[J]));
              LCueTrackInfo := GetTrackTagInfo(LTrackInfoTmpStrList);
            finally
              LTrackInfoTmpStrList.Free;
            end;
          end;
        end
        else
        begin
          for J := FTrackStartIndexes[i] to FCueFile.Count - 1 do
          begin
            LTrackInfoTmpStrList := TStringList.Create;
            try
              LTrackInfoTmpStrList.Add(Trim(FCueFile[J]));
              LCueTrackInfo := GetTrackTagInfo(LTrackInfoTmpStrList);
            finally
              LTrackInfoTmpStrList.Free;
            end;
          end;
        end;
        FCueTrackInfos.Add(LCueTrackInfo);
      end;
      // end positions and duration
      for I := 0 to FCueTrackInfos.Count - 1 do
      begin
        if i = 0 then
        begin
          LCueTrackInfo := FCueTrackInfos[i];
          if FCueTrackInfos.Count > 1 then
          begin
            LCueTrackInfo.CueTrackDurationInfo.EndPos := FCueTrackInfos[1].CueTrackDurationInfo.StartPos;
          end
          else
          begin
            LCueTrackInfo.CueTrackDurationInfo.EndPos := FFileDuration;
          end;
        end
        else if i = FCueTrackInfos.Count - 1 then
        begin
          LCueTrackInfo := FCueTrackInfos[i];
          LCueTrackInfo.CueTrackDurationInfo.EndPos := FFileDuration;
        end
        else
        begin
          LCueTrackInfo := FCueTrackInfos[i];
          LCueTrackInfo.CueTrackDurationInfo.EndPos := FCueTrackInfos[i + 1].CueTrackDurationInfo.StartPos;
        end;
        LCueTrackInfo.CueTrackDurationInfo.Duration := LCueTrackInfo.CueTrackDurationInfo.EndPos - LCueTrackInfo.CueTrackDurationInfo.StartPos;
        FCueTrackInfos[i] := LCueTrackInfo;
      end;
    end;
    if FErrorMsg = CUE_ERROR_OK then
    begin
      if FCueTrackInfos.Count < 1 then
      begin
        FErrorMsg := CUE_ERROR_NO_TRACKS;
      end;
    end;
  end
  else
  begin
    FErrorMsg := CUE_ERROR_FILE_EMPTY;
  end;
end;

function TCueSplitter.RemoveInvalidPathChars(const SourceStr: string): string;
const
  InvalidChars: array [0 .. 8] of Char = ('<', '>', ':', '"', '/', '\', '|', '?', '*');
var
  I: Integer;
  TempStr: string;
begin
  TempStr := SourceStr;
  for I := 0 to Length(InvalidChars) - 1 do
  begin
    TempStr := StringReplace(TempStr, InvalidChars[i], '', [rfReplaceAll]);
  end;

  if Length(TempStr) > 0 then
  begin
    Result := TempStr;
  end
  else
  begin
    Result := 'Unknown';
  end;
end;

function TCueSplitter.REMtoList(const Str: string): TExtraComments;
var
  LValueStartIndex: integer;
  LStr: string;
  i: integer;
begin

  LStr := Str;
  Delete(LStr, 1, 3);
  LStr := Trim(LStr);

  LValueStartIndex := 0;
  for I := 0 to Length(LStr) - 1 do
  begin
    if LStr[i] <> ' ' then
    begin
      Inc(LValueStartIndex);
    end
    else
    begin
      Break;
    end;
  end;

  Result.CommentName := Trim(Copy(LStr, 1, LValueStartIndex));
  Result.CommentValue := Trim(Copy(LStr, LValueStartIndex, MaxInt));
  if Result.CommentValue[1] = '"' then
  begin
    Delete(Result.CommentValue, 1, 1);
  end;
  if Result.CommentValue[Length(Result.CommentValue)] = '"' then
  begin
    Delete(Result.CommentValue, Length(Result.CommentValue), 1);
  end;

end;

function TCueSplitter.StringStartsWith(const Str, StartStr: string): Boolean;
begin
  Result := False;
  if UpperCase(Copy(Str, 1, Length(StartStr))) = StartStr then
  begin
    Result := True;
  end;
end;

end.
