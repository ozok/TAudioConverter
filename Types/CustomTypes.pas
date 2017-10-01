unit CustomTypes;

interface

type
  TRenamePair = record
    Input: string;
    Output: string;
  end;

type
  TCompressionFileNamesPair = record
    SourcePath: string;
    DestinationPath: string;
  end;

type
  TIndexItem = class(TObject)
  private
    FRealIndex: Integer;
  public
    property RealIndex: Integer read FRealIndex write FRealIndex;
  end;

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

