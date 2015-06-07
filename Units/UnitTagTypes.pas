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
// contains types used for storing tag information
unit UnitTagTypes;

interface

uses Classes, UnitRGInfoExtractor;

type
  PTagInfo = ^TTagInfo;

  TTagInfo = record
    Title, Artist, Genre, TrackNo, Performer, RecordDate, Composer, Album, Comment, ArtistSort, AlbumSort, ComposerSort, AlbumArtistSort, NameSort, TrackTotal, AlbumArtist, DiscNo, DiscTotal,
      FileType, AlbumComposer: string;
    ArtistForFileName: string;
    TitleForFileName: string;
    AlbumForFileName: string;
    CoverImageType: string;
    RGInfo: TRGInfo;
    IsLossless: Boolean;
    Bitrate: integer;
    TagType: string;
  end;

type
  TTagsList = class(TList)
  private
    function Get(Index: Integer): PTagInfo;
  public
    destructor Destroy; override;
    function Add(Value: PTagInfo): Integer;
    property Items[Index: Integer]: PTagInfo read Get; default;
  end;

implementation

{ TTagsList }

function TTagsList.Add(Value: PTagInfo): Integer;
begin
  Result := inherited Add(Value);
end;

destructor TTagsList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    FreeMem(Items[i]);
  inherited;
end;

function TTagsList.Get(Index: Integer): PTagInfo;
begin
  Result := PTagInfo(inherited Get(Index));
end;

end.
