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
unit TagReader;

interface

uses
  Classes, Windows, SysUtils, Messages, StrUtils, TagTypes, WMATagLibrary,
  APEv2Library, MP4TagLibrary, FlacTagLibrary, ID3v2Library, ID3v1Library,
  OggVorbisAndOpusTagLibrary, WAVTagLibrary;

type
  TTagReader = class(TObject)
  private
    FWMATag: TWMATag;
    FAPETag: TAPEv2Tag;
    FID3v2Tag: TID3v2Tag;
    FID3v1Tag: TID3v1Tag;
    FFLACTag: TFlacTag;
    FMP4Tag: TMP4Tag;
    FOPUSTag: TOpusTag;
    FWAVTag: TWAVTag;
    LPicStream: TStream;
    function GetCoverStream: TStream;
    function SplitTrackNo(const Str: string): string;
    function SplitTotalTrackNo(const Str: string): string;
  public
    property CoverStream: TStream read GetCoverStream;
    constructor Create;
    destructor Destroy(); override;
    function ReadTags(const FileName: string): TTagInfo;
  end;

implementation

{ TTagReader }

constructor TTagReader.Create;
begin
  inherited Create;

  FWMATag := TWMATag.Create;
  FAPETag := TAPEv2Tag.Create;
  FID3v2Tag := TID3v2Tag.Create;
  FID3v1Tag := TID3v1Tag.Create;
  FFLACTag := TFlacTag.Create;
  FMP4Tag := TMP4Tag.Create;
  FOPUSTag := TOpusTag.Create;
  FWAVTag := TWAVTag.Create;
  LPicStream := TMemoryStream.Create;
end;

destructor TTagReader.Destroy;
begin
  inherited Destroy;
  FWMATag.Free;
  FAPETag.Free;
  FID3v2Tag.Free;
  FID3v1Tag.Free;
  FFLACTag.Free;
  FMP4Tag.Free;
  FOPUSTag.Free;
  FWAVTag.Free;
  LPicStream.Free;
end;

function TTagReader.GetCoverStream: TStream;
begin
  Result := TStream.Create;
end;

function TTagReader.ReadTags(const FileName: string): TTagInfo;
var
  I: Integer;
  LMIMEStr: string;
  LDesc: string;
  LPicType: Integer;
  FFLACTagCoverArt: TFlacTagCoverArtInfo;
  LPictureMagic: Word;
  LAPEPictureFormat: TAPEv2PictureFormat;
  LOpusCoverInfo: TOpusVorbisCoverArtInfo;
  LWMAPicType: Byte;
  // todo: convert image type. maybe destination doesn't support this format

  function MIME2Extension(const MIME: string): string;
  begin
    if (MIME = 'image/jpeg') or (MIME = 'image/jpg') then
    begin
      Result := 'jpg'
    end
    else if MIME = 'image/png' then
    begin
      Result := 'png'
    end
    else if MIME = 'image/bmp' then
    begin
      Result := 'bmp';
    end
    else if MIME = 'image/gif' then
    begin
      Result := 'gif';
    end;
  end;

begin
  Result.CoverImageType := 'fff';
  if FID3v2Tag.LoadFromFile(FileName) = 0 then
  begin
    if FID3v2Tag.Loaded then
    begin
      with Result do
      begin
        Title := FID3v2Tag.GetUnicodeText('TIT2');
        Artist := FID3v2Tag.GetUnicodeText('TPE1');
        ;
        Genre := FID3v2Tag.GetUnicodeText('TCON');
        TrackNo := FID3v2Tag.GetUnicodeText('TRCK');
        Performer := FID3v2Tag.GetUnicodeText('ARTIST');
        RecordDate := FID3v2Tag.GetUnicodeText('TYER');
        Composer := FID3v2Tag.GetUnicodeText('TCOM');
        Album := FID3v2Tag.GetUnicodeText('TALB');
        Comment := FID3v2Tag.GetUnicodeText('COMM');
        ArtistSort := FID3v2Tag.GetUnicodeText('TSOP');
        AlbumSort := FID3v2Tag.GetUnicodeText('TSOA');
        ComposerSort := FID3v2Tag.GetUnicodeText('TSOC');
        AlbumArtistSort := FID3v2Tag.GetUnicodeText('TSO2');
        NameSort := FID3v2Tag.GetUnicodeText('TSOT');
        TrackTotal := FID3v2Tag.GetUnicodeText('TRCK');
        AlbumArtist := FID3v2Tag.GetUnicodeText('TPE2');
        DiscNo := FID3v2Tag.GetUnicodeText('TOTALDISCS');
        DiscTotal := FID3v2Tag.GetUnicodeText('TOTALDISCS');
        AlbumComposer := FID3v2Tag.GetUnicodeText('COMPOSER');
        RGInfo.ALBUM_GAIN := FID3v2Tag.GetUnicodeText('REPLAYGAIN_ALBUM_GAIN');
        RGInfo.ALBUM_PEAK := FID3v2Tag.GetUnicodeText('REPLAYGAIN_ALBUM_PEAK');
        RGInfo.TRACK_GAIN := FID3v2Tag.GetUnicodeText('REPLAYGAIN_TRACK_GAIN');
        RGInfo.TRACK_PEAK := FID3v2Tag.GetUnicodeText('REPLAYGAIN_TRACK_PEAK');
        // artwork
        if FID3v2Tag.FrameExists('APIC') >= 0 then
        begin
          if FID3v2Tag.GetUnicodeCoverPictureStream(FID3v2Tag.FrameExists('APIC'), LPicStream, LMIMEStr, LDesc, LPicType) then
          begin
            LMIMEStr := Trim(LowerCase(LMIMEStr));
            if (LPicStream.Size > 0) and (Length(LMIMEStr) > 0) then
            begin
              Result.CoverImageType := MIME2Extension(LMIMEStr);
            end;
          end;
        end;
      end;
    end;
  end
  else if FMP4Tag.LoadFromFile(FileName) = 0 then
  begin
    if FMP4Tag.Loaded then
    begin
      with Result do
      begin
        Title := FMP4Tag.GetText('©nam');
        Artist := FMP4Tag.GetText('©ART');
        Genre := FMP4Tag.GetText('©gen');
        TrackNo := IntToStr(FMP4Tag.GetTrack);
        TrackTotal := IntToStr(FMP4Tag.GetTotalTracks);
        RecordDate := FMP4Tag.GetText('©day');
        Composer := FMP4Tag.GetText('©wrt');
        Album := FMP4Tag.GetText('©alb');
        Comment := FMP4Tag.GetText('©cmt');
        ArtistSort := FMP4Tag.GetText('soar');
        AlbumSort := FMP4Tag.GetText('soal');
        ComposerSort := FMP4Tag.GetText('soco');
        AlbumArtistSort := FMP4Tag.GetText('soaa');
        NameSort := FMP4Tag.GetText('sonm');
        AlbumArtist := FMP4Tag.GetText('aART');
        DiscNo := IntToStr(FMP4Tag.GetDisc);
        DiscTotal := IntToStr(FMP4Tag.GetTotalDiscs);
        // artwork
        for I := 0 to FMP4Tag.Count - 1 do
        begin
          if IsSameAtomName(FMP4Tag.Atoms[i].ID, 'covr') then
          begin
            FMP4Tag.Atoms[i].Datas[0].Data.Seek(0, soBeginning);
            FMP4Tag.Atoms[i].Datas[0].Data.Read(LPictureMagic, 2);
            if LPictureMagic = MAGIC_JPG then
            begin
              Result.CoverImageType := 'jpg'
            end
            else if LPictureMagic = MAGIC_PNG then
            begin
              Result.CoverImageType := 'png'
            end
            else if LPictureMagic = MAGIC_BMP then
            begin
              Result.CoverImageType := 'bmp'
            end
            else if LPictureMagic = MAGIC_GIF then
            begin
              Result.CoverImageType := 'gif'
            end;

            // get just first image
            Break;
          end;
        end;
      end;
    end;
  end
  else if FAPETag.LoadFromFile(FileName) = 0 then
  begin
    if FAPETag.Loaded then
    begin
      with Result do
      begin
        Title := FAPETag.ReadFrameByNameAsText('Title');
        Artist := FAPETag.ReadFrameByNameAsText('Artist');
        Genre := FAPETag.ReadFrameByNameAsText('Genre');
        TrackNo := FAPETag.ReadFrameByNameAsText('Track');
        Performer := FAPETag.ReadFrameByNameAsText('Performer');
        RecordDate := FAPETag.ReadFrameByNameAsText('Year');
        Composer := FAPETag.ReadFrameByNameAsText('Composer');
        Album := FAPETag.ReadFrameByNameAsText('Album');
        Comment := FAPETag.ReadFrameByNameAsText('Comment');
        ArtistSort := FAPETag.ReadFrameByNameAsText('ArtistSort');
        AlbumSort := FAPETag.ReadFrameByNameAsText('AlbumSort');
        ComposerSort := FAPETag.ReadFrameByNameAsText('ComposerSort');
        AlbumArtistSort := FAPETag.ReadFrameByNameAsText('AlbumArtistSort');
        NameSort := FAPETag.ReadFrameByNameAsText('NameSort');
        TrackTotal := FAPETag.ReadFrameByNameAsText('TrackTotal');
        AlbumArtist := FAPETag.ReadFrameByNameAsText('AlbumArtist');
        DiscNo := FAPETag.ReadFrameByNameAsText('DISCNUMBER');
        DiscTotal := FAPETag.ReadFrameByNameAsText('DiscTotal');
        AlbumComposer := FAPETag.ReadFrameByNameAsText('AlbumComposer');
        RGInfo.ALBUM_GAIN := FAPETag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_GAIN');
        RGInfo.ALBUM_PEAK := FAPETag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_PEAK');
        RGInfo.TRACK_GAIN := FAPETag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_GAIN');
        RGInfo.TRACK_PEAK := FAPETag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_PEAK');
        // artwork
        for I := 0 to Length(FAPETag.Frames) - 1 do
        begin
          if FAPETag.GetCoverArtFromFrame(i, LPicStream, LAPEPictureFormat, LDesc) then
          begin
            case LAPEPictureFormat of
              pfUnknown:
                Result.CoverImageType := 'fff';
              pfJPEG:
                Result.CoverImageType := 'jpg';
              pfPNG:
                Result.CoverImageType := 'png';
              pfBMP:
                Result.CoverImageType := 'bmp';
              pfGIF:
                Result.CoverImageType := 'gif';
            end;
            // get just first image
            Break;
          end;
        end;
      end;
    end;
  end
  else if FFLACTag.LoadFromFile(FileName) = 0 then
  begin
    if FFLACTag.Loaded then
    begin
      with Result do
      begin
        Title := FFLACTag.ReadFrameByNameAsText('TITLE');
        Artist := FFLACTag.ReadFrameByNameAsText('ARTIST');
        Genre := FFLACTag.ReadFrameByNameAsText('GENRE');
        TrackNo := FFLACTag.ReadFrameByNameAsText('TRACKNUMBER');
        Performer := FFLACTag.ReadFrameByNameAsText('PERFORMER');
        RecordDate := FFLACTag.ReadFrameByNameAsText('DATE');
        Composer := FFLACTag.ReadFrameByNameAsText('COMPOSER');
        Album := FFLACTag.ReadFrameByNameAsText('ALBUM');
        Comment := FFLACTag.ReadFrameByNameAsText('COMMENT');
        ArtistSort := FFLACTag.ReadFrameByNameAsText('ARTISTSORT');
        AlbumSort := FFLACTag.ReadFrameByNameAsText('ALBUMSORT');
        ComposerSort := FFLACTag.ReadFrameByNameAsText('COMPOSERSORT');
        AlbumArtistSort := FFLACTag.ReadFrameByNameAsText('ALBUMARTISTSORT');
        NameSort := FFLACTag.ReadFrameByNameAsText('TITLESORT');
        TrackTotal := FFLACTag.ReadFrameByNameAsText('TOTALTRACKS');
        AlbumArtist := FFLACTag.ReadFrameByNameAsText('ALBUMARTIS');
        DiscNo := FFLACTag.ReadFrameByNameAsText('DISCNUMBER');
        DiscTotal := FFLACTag.ReadFrameByNameAsText('DISCTOTAL');
        AlbumComposer := FFLACTag.ReadFrameByNameAsText('ALBUMCOMPOSER');
        RGInfo.ALBUM_GAIN := FFLACTag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_GAIN');
        RGInfo.ALBUM_PEAK := FFLACTag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_PEAK');
        RGInfo.TRACK_GAIN := FFLACTag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_GAIN');
        RGInfo.TRACK_PEAK := FFLACTag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_PEAK');
        if Length(DiscNo) < 1 then
        begin
          DiscNo := FFLACTag.ReadFrameByNameAsText('Part');
        end;
        // artwork
        if FFLACTag.GetCoverArt(0, LPicStream, FFLACTagCoverArt) then
        begin
          LMIMEStr := Trim(LowerCase(FFLACTagCoverArt.MIMEType));
          if (LPicStream.Size > 0) and (Length(LMIMEStr) > 0) then
          begin
            Result.CoverImageType := MIME2Extension(LMIMEStr);
          end;
        end;
      end;
    end;
  end
  else if FOPUSTag.LoadFromFile(FileName) = 0 then
  begin
    if FOPUSTag.Loaded then
    begin
      with Result do
      begin
        Title := FOPUSTag.ReadFrameByNameAsText('TITLE');
        Artist := FOPUSTag.ReadFrameByNameAsText('ARTIST');
        Genre := FOPUSTag.ReadFrameByNameAsText('GENRE');
        TrackNo := FOPUSTag.ReadFrameByNameAsText('TRACKNUMBER');
        Performer := FOPUSTag.ReadFrameByNameAsText('PERFORMER');
        RecordDate := FOPUSTag.ReadFrameByNameAsText('DATE');
        Composer := FOPUSTag.ReadFrameByNameAsText('COMPOSER');
        Album := FOPUSTag.ReadFrameByNameAsText('ALBUM');
        Comment := FOPUSTag.ReadFrameByNameAsText('COMMENT');
        ArtistSort := FOPUSTag.ReadFrameByNameAsText('ARTISTSORT');
        AlbumSort := FOPUSTag.ReadFrameByNameAsText('ALBUMSORT');
        ComposerSort := FOPUSTag.ReadFrameByNameAsText('COMPOSERSORT');
        AlbumArtistSort := FOPUSTag.ReadFrameByNameAsText('ALBUMARTISTSORT');
        NameSort := FOPUSTag.ReadFrameByNameAsText('TITLESORT');
        TrackTotal := FOPUSTag.ReadFrameByNameAsText('TRACKTOTAL');
        AlbumArtist := FOPUSTag.ReadFrameByNameAsText('ALBUMARTIS');
        DiscNo := FOPUSTag.ReadFrameByNameAsText('DISC');
        DiscTotal := FOPUSTag.ReadFrameByNameAsText('DISCTOTAL');
        AlbumComposer := FOPUSTag.ReadFrameByNameAsText('ALBUMCOMPOSER');
        RGInfo.ALBUM_GAIN := FOPUSTag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_GAIN');
        RGInfo.ALBUM_PEAK := FOPUSTag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_PEAK');
        RGInfo.TRACK_GAIN := FOPUSTag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_GAIN');
        RGInfo.TRACK_PEAK := FOPUSTag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_PEAK');
        // artwork
        if FOPUSTag.FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE) > -1 then
        begin
          if FOPUSTag.GetCoverArtFromFrame(FOPUSTag.FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE), LPicStream, LOpusCoverInfo) then
          begin
            Result.CoverImageType := MIME2Extension(LOpusCoverInfo.MIMEType);
          end;
        end;
      end;
    end;
  end
  else if FWMATag.LoadFromFile(FileName) = 0 then
  begin
    if FWMATag.Loaded then
    begin
      with Result do
      begin
        Title := FWMATag.ReadFrameByNameAsText(g_wszWMTitle);
        Artist := FWMATag.ReadFrameByNameAsText(g_wszWMAuthor);
        Genre := FWMATag.ReadFrameByNameAsText(g_wszWMGenre);
        TrackNo := FWMATag.ReadFrameByNameAsText(g_wszWMTrackNumber);
        RecordDate := FWMATag.ReadFrameByNameAsText(g_wszWMYear);
        Composer := FWMATag.ReadFrameByNameAsText(g_wszWMWriter);
        Album := FWMATag.ReadFrameByNameAsText(g_wszWMAlbumTitle);
        Comment := FWMATag.ReadFrameByNameAsText(g_wszWMDescription);
        ArtistSort := FWMATag.ReadFrameByNameAsText(g_wszWMArtistSortOrder);
        AlbumSort := FWMATag.ReadFrameByNameAsText(g_wszWMAlbumSortOrder);
        AlbumArtistSort := FWMATag.ReadFrameByNameAsText(g_wszWMAlbumArtistSortOrder);
        NameSort := FWMATag.ReadFrameByNameAsText(g_wszWMTitleSortOrder);
        AlbumArtist := FWMATag.ReadFrameByNameAsText(g_wszWMAlbumArtist);
        AlbumComposer := FWMATag.ReadFrameByNameAsText(g_wszWMWriter);
        // artwork type
        for I := 0 to FWMATag.Count - 1 do
        begin
          if FWMATag.Frames[i].Name = g_wszWMPicture then
          begin
            if FWMATag.GetCoverArtFromFrame(i, LPicStream, LMIMEStr, LWMAPicType, LDesc) then
            begin
              Result.CoverImageType := MIME2Extension(LMIMEStr)
            end;
            // get just first image
            Break;
          end;
        end;
      end;
    end;
  end
  else if FWAVTag.LoadFromFile(FileName) = 0 then
  begin
    if FWAVTag.Loaded then
    begin
      with Result do
      begin
        Title := FWAVTag.ReadFrameByNameAsText('INAM');
        Artist := FWAVTag.ReadFrameByNameAsText('IART');
        Genre := FWAVTag.ReadFrameByNameAsText('IGNR');
        TrackNo := FWAVTag.ReadFrameByNameAsText('ITRK');
        RecordDate := FWAVTag.ReadFrameByNameAsText('ICRD');
        Composer := FWAVTag.ReadFrameByNameAsText('ICOM');
        Album := FWAVTag.ReadFrameByNameAsText('IPRD');
        Comment := FWAVTag.ReadFrameByNameAsText('ICMT');
        RGInfo.ALBUM_GAIN := FWAVTag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_GAIN');
        RGInfo.ALBUM_PEAK := FWAVTag.ReadFrameByNameAsText('REPLAYGAIN_ALBUM_PEAK');
        RGInfo.TRACK_GAIN := FWAVTag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_GAIN');
        RGInfo.TRACK_PEAK := FWAVTag.ReadFrameByNameAsText('REPLAYGAIN_TRACK_PEAK');
        Result.CoverImageType := 'fff';
      end;
    end;
  end
  else if FID3v1Tag.LoadFromFile(FileName) = 0 then
  begin
    if FID3v1Tag.Loaded then
    begin
      with Result do
      begin
        Title := FID3v1Tag.Title;
        Artist := FID3v1Tag.Artist;
        Genre := FID3v1Tag.Genre;
        TrackNo := FloatToStr(FID3v1Tag.Track);
        RecordDate := FID3v1Tag.Year;
        Album := FID3v1Tag.Album;
        Comment := FID3v1Tag.Comment;
        Result.CoverImageType := 'fff';
      end;
    end;
  end;
  // tod: look for other seperators
  Result.TrackNo := SplitTrackNo(Result.TrackNo);
  Result.TrackTotal := SplitTotalTrackNo(Result.TrackTotal);
end;

function TTagReader.SplitTotalTrackNo(const Str: string): string;
begin
  Result := Str;
  if PosEx('/', Str) > 0 then
  begin
    Result := Copy(Str, PosEx('/', Str) + 1, MaxInt);
  end;
end;

function TTagReader.SplitTrackNo(const Str: string): string;
begin
  Result := Str;
  if PosEx('/', Str) > 0 then
  begin
    Result := Copy(Str, 1, PosEx('/', Str) - 1);
  end;
end;

end.

