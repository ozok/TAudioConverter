unit UnitWMATagExtractor;

interface

uses
  Classes, Windows, SysUtils, Messages, StrUtils, UnitTagTypes, WMATagLibrary;

type
  TWMATagExtractor = class(TObject)
  private
    FFileName: string;
    FTags: TTagInfo;
    procedure ReadTags();
    function GetCoverStream: TStream;
  public
    property Tags: TTagInfo read FTags;
    property CoverStream: TStream read GetCoverStream;
    constructor Create(const FileName: string);
    destructor Destroy(); override;
  end;

implementation

{ TWMATagExtractor }

constructor TWMATagExtractor.Create(const FileName: string);
begin
  inherited Create;

  FFileName := FileName;
  ReadTags;
end;

destructor TWMATagExtractor.Destroy;
begin
  inherited Destroy;
end;

function TWMATagExtractor.GetCoverStream: TStream;
begin

  Result := TStream.Create;

end;

procedure TWMATagExtractor.ReadTags;
var
  LWMATag: TWMATag;
begin
  LWMATag := TWMATag.Create;
  try
    if LWMATag.LoadFromFile(FFileName) = 0 then
    begin
      with FTags do
      begin
        Title := LWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        Artist := LWMATag.ReadFrameByNameAsText(g_wszWMAuthor);
        Genre := LWMATag.ReadFrameByNameAsText(g_wszWMGenre);
        TrackNo := LWMATag.ReadFrameByNameAsText(g_wszWMTrackNumber);
        // Performer := LWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        RecordDate := LWMATag.ReadFrameByNameAsText(g_wszWMYear);
        Composer := LWMATag.ReadFrameByNameAsText(g_wszWMWriter);
        Album := LWMATag.ReadFrameByNameAsText(g_wszWMAlbumTitle);
        Comment := LWMATag.ReadFrameByNameAsText(g_wszWMDescription);
        ArtistSort := LWMATag.ReadFrameByNameAsText(g_wszWMArtistSortOrder);
        AlbumSort := LWMATag.ReadFrameByNameAsText(g_wszWMAlbumSortOrder);
        // ComposerSort := LWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        AlbumArtistSort := LWMATag.ReadFrameByNameAsText(g_wszWMAlbumArtistSortOrder);
        NameSort := LWMATag.ReadFrameByNameAsText(g_wszWMTitleSortOrder);
        // TrackTotal := LWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        AlbumArtist := LWMATag.ReadFrameByNameAsText(g_wszWMAlbumArtist);
        // DiscNo := LWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        // DiscTotal := LWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        AlbumComposer := LWMATag.ReadFrameByNameAsText(g_wszWMWriter);
      end;
    end;

  finally
    LWMATag.Free;
  end;
end;

end.

