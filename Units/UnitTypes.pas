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
unit UnitTypes;

interface

type
  TTrackTagInfo = packed record
    Title: string;
    Artist: string;
    Album: string;
    TrackNo: string;
    AlbumArtist: string;
    Date: string;
    Genre: string;
    Comment: string;
    CoverPath: string;
  end;

type
  TTrackState = (tsWaiting = 0, tsRipped = 1, tsConverted = 2, tsErrorWhileRipping = 3, tsErrorWhileConverting = 4, tsRipping = 5);

type
  TTrackIndexes = record
    CDIndex: Integer;
    ListIndex: Integer;
  end;

type
  TTrackInfo = packed record
    TrackTagInfo: TTrackTagInfo;
    Duration: Integer;
    TempFileName: string;
    TrackState: TTrackState;
    WillBeRipped: Boolean;
    Index: integer;
  end;

implementation

end.

