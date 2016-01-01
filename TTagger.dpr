program TTagger;
{$IFOPT D-}{$WEAKLINKRTTI ON}{$ENDIF}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  IniFiles,
  APEv2Library in 'TagLibraries\APEv2Library.pas',
  FlacTagLibrary in 'TagLibraries\FlacTagLibrary.pas',
  ID3v1Library in 'TagLibraries\ID3v1Library.pas',
  ID3v2Library in 'TagLibraries\ID3v2Library.pas',
  MP4TagLibrary in 'TagLibraries\MP4TagLibrary.pas',
  OggVorbisAndOpusTagLibrary in 'TagLibraries\OggVorbisAndOpusTagLibrary.pas',
  WMATagLibrary in 'TagLibraries\WMATagLibrary.pas',
  ImgSize in 'Units\ImgSize.pas',
  WAVTagLibrary in 'TagLibraries\WAVTagLibrary.pas',
  uTExtendedX87 in 'TagLibraries\uTExtendedX87.pas';

type
  TTags = packed record
    TagType: string;
    Title: string;
    Artist: string;
    Album: string;
    Genre: string;
    Date: string;
    TrackNo: string;
    TrackTotal: string;
    DiscNo: string;
    DiscTotal: string;
    Comment: string;
    AlbumArtist: string;
    Composer: string;
    NameSort: string;
    ArtistSort: string;
    AlbumArtistSort: string;
    AlbumSort: string;
    Cover: string;
    Tool: string;
    WriteToolTag: Boolean;
    REPLAYGAIN_ALBUM_GAIN: string;
    REPLAYGAIN_ALBUM_PEAK: string;
    REPLAYGAIN_TRACK_GAIN: string;
    REPLAYGAIN_TRACK_PEAK: string;
  end;

var
  FIniFilePath, FOutputFileName: string;
  FApeTagger: TAPEv2Tag;
  FMp4Tagger: TMP4Tag;
  FWMATagger: TWMATag;
  FFLACTagger: TFlacTag;
  FID3v2Tagger: TID3v2Tag;
  FOggTagger: TOpusTag;
  FWAVTagger: TWAVTag;
  FTag: TTags;

procedure WriteError(const ErrorStr: string);
begin
  Writeln('Error: ' + ErrorStr);
end;

function ReadTagsFromTagFile(const IniPath: string): Boolean;
var
  IniFile: TMemIniFile;
begin

  IniFile := TMemIniFile.Create(IniPath);
  try
    with FTag do
    begin
      // read tags
      TagType := IniFile.ReadString('taginfo', 'type', '');
      Title := IniFile.ReadString('tag', 'Title', '');
      Album := IniFile.ReadString('tag', 'Album', '');
      Artist := IniFile.ReadString('tag', 'Artist', '');
      Genre := IniFile.ReadString('tag', 'Genre', '');
      Date := IniFile.ReadString('tag', 'Date', '');
      TrackNo := IniFile.ReadString('tag', 'TrackNo', '');
      TrackTotal := IniFile.ReadString('tag', 'TrackTotal', '');
      DiscNo := IniFile.ReadString('tag', 'DiscNo', '');
      DiscTotal := IniFile.ReadString('tag', 'DiscTotal', '');
      Comment := IniFile.ReadString('tag', 'Comment', '');
      AlbumArtist := IniFile.ReadString('tag', 'AlbumArtist', '');
      Composer := IniFile.ReadString('tag', 'Composer', '');
      NameSort := IniFile.ReadString('tag', 'NameSort', '');
      ArtistSort := IniFile.ReadString('tag', 'ArtistSort', '');
      AlbumArtistSort := IniFile.ReadString('tag', 'AlbumArtistSort', '');
      AlbumSort := IniFile.ReadString('tag', 'AlbumSort', '');
      Cover := IniFile.ReadString('tag', 'Cover', '');
      Tool := IniFile.ReadString('tag', 'tool', '');
      WriteToolTag := IniFile.ReadBool('tag', 'writetool', True);
      REPLAYGAIN_ALBUM_GAIN := IniFile.ReadString('tag', 'REPLAYGAIN_ALBUM_GAIN', '');
      REPLAYGAIN_ALBUM_PEAK := IniFile.ReadString('tag', 'REPLAYGAIN_ALBUM_PEAK', '');
      REPLAYGAIN_TRACK_GAIN := IniFile.ReadString('tag', 'REPLAYGAIN_TRACK_GAIN', '');
      REPLAYGAIN_TRACK_PEAK := IniFile.ReadString('tag', 'REPLAYGAIN_TRACK_PEAK', '');

      // check if tag type is valid
      if (LowerCase(TagType) = 'apev2') or (LowerCase(TagType) = 'mp4') or (LowerCase(TagType) = 'flac') or (LowerCase(TagType) = 'wma') or (LowerCase(TagType) = 'id3v2') or (LowerCase(TagType) = 'ogg') or (LowerCase(TagType) = 'alac') or (LowerCase(TagType) = 'wav') then
      begin
        Result := True;
      end
      else
      begin
        Result := False;
      end;
    end;
  finally
    FreeAndNil(IniFile);
  end;

end;

const
  // exit codes
  EXIT_CODE_NOT_ENOUGH_CMD = 1;
  EXIT_CODE_INPUT_NOT_FOUND = 2;
  EXIT_CODEC_OUTPUT_NOT_FOUND = 3;
  EXIT_CODE_TAG_NOT_WRITTEN = 4;

var
  i: integer;
  ArtIndex: Integer;
  FlacTagCoverArt: TFlacTagCoverArtInfo;
  NewPictureStream: TFileStream;
  WMAMime: string;
  LanguageID: TLanguageID;
  PicWidth, PicHeight: Word;
  OggOpusCoverInfo: TOpusVorbisCoverArtInfo;
  APECoverStream: TFileStream;
  LTool: string;

begin
  try
{$IFDEF WIN32}
    Writeln('TTagger 32-bit - 0.1.4 - (C) 2013-2014 ozok - GPLv2');
{$ENDIF}
{$IFDEF WIN64}
    Writeln('TTagger 64-bit - 0.1.4 - (C) 2013-2014 ozok - GPLv2');
{$ENDIF}
    Writeln('Tool to write tags to audio files.');
    Writeln('Uses tagging components from 3delite.hu.');
    Writeln('Usage: ttagger.exe tagsinifile.ini filetowritetags');
    Writeln('');
    if ParamCount = 2 then
    begin
      FIniFilePath := ParamStr(1);
      FOutputFileName := ParamStr(2);
      Writeln('Reading tags from ' + ExtractFileName(FIniFilePath) + ' and writing to ' + ExtractFileName(FOutputFileName));
      if FileExists(FIniFilePath) then
      begin
        if FileExists(FOutputFileName) then
        begin
          if ReadTagsFromTagFile(FIniFilePath) then
          begin
            with FTag do
            begin
              // APEv2
{$REGION APEv2}
              if TagType = 'apev2' then
              begin
                Writeln('Tag type to write is APEv2.');
                FApeTagger := TAPEv2Tag.Create;
                FApeTagger.LoadFromFile(FOutputFileName);
                try
                  Writeln('Starting to write tags.');

                  // cover art
                  if FileExists(Cover) then
                  begin
                    APECoverStream := TFileStream.Create(Cover, fmShareDenyWrite);
                    try
                      if FApeTagger.AddCoverArtFrame('Cover Art (Front)', APECoverStream, 'No description') > 0 then
                      begin
                        WriteError('Cannot write artwork file.');
                      end
                      else
                      begin
                        if not FApeTagger.SetCoverArtFrame(FApeTagger.FrameExists('Cover Art (Front)'), APECoverStream, 'No description') then
                        begin
                          WriteError('Cannot set ' + FloatToStr(FApeTagger.FrameExists('Cover')) + ' as artwork.');
                        end;
                      end;
                    finally
                      APECoverStream.Free;
                    end;
                  end
                  else
                    WriteError('Not found image');
                  // check for valid rg fields before writing
                  if Length(REPLAYGAIN_ALBUM_GAIN) > 0 then
                  begin
                    FApeTagger.AddTextFrame('REPLAYGAIN_ALBUM_GAIN', REPLAYGAIN_ALBUM_GAIN);
                  end;
                  if Length(REPLAYGAIN_ALBUM_PEAK) > 0 then
                  begin
                    FApeTagger.AddTextFrame('REPLAYGAIN_ALBUM_PEAK', REPLAYGAIN_ALBUM_PEAK);
                  end;
                  if Length(REPLAYGAIN_TRACK_GAIN) > 0 then
                  begin
                    FApeTagger.AddTextFrame('REPLAYGAIN_TRACK_GAIN', REPLAYGAIN_TRACK_GAIN);
                  end;
                  if Length(REPLAYGAIN_TRACK_PEAK) > 0 then
                  begin
                    FApeTagger.AddTextFrame('REPLAYGAIN_TRACK_PEAK', REPLAYGAIN_TRACK_PEAK);
                  end;

                  // other general tags
                  // todo: check tag fields
                  FApeTagger.AddTextFrame('Title', Title);
                  FApeTagger.AddTextFrame('Artist', Artist);
                  FApeTagger.AddTextFrame('Album', Album);
                  FApeTagger.AddTextFrame('Genre', Genre);
                  FApeTagger.AddTextFrame('Year', Date);
                  FApeTagger.AddTextFrame('Track', TrackNo);
                  FApeTagger.AddTextFrame('TrackTotal', TrackTotal);
                  FApeTagger.AddTextFrame('DISCNUMBER', DiscNo);
                  FApeTagger.AddTextFrame('DiscTotal', DiscTotal);
                  FApeTagger.AddTextFrame('Comment', Comment);
                  FApeTagger.AddTextFrame('AlbumArtist', AlbumArtist);
                  FApeTagger.AddTextFrame('Composer', Composer);
                  FApeTagger.AddTextFrame('NameSort', NameSort);
                  FApeTagger.AddTextFrame('ArtistSort', ArtistSort);
                  FApeTagger.AddTextFrame('AlbumArtistSort', AlbumArtistSort);
                  FApeTagger.AddTextFrame('AlbumSort', AlbumSort);
                  // todo: check that
                  // FApeTagger.AddTextFrame('Cover', Cover);
                  FApeTagger.AddTextFrame('Tool', Tool);

                  Writeln('Saving to file.');
                  if FApeTagger.SaveToFile(FOutputFileName) = APEV2LIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FApeTagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FApeTagger);
                end;
{$ENDREGION}
              end
              // mp4
{$REGION MP4}
              else if (TagType = 'mp4') or (TagType = 'alac') then
              begin
                Writeln('Tag type to write is ' + TagType + '.');
                FMp4Tagger := TMP4Tag.Create;
                try
                  Writeln('Starting to write tags.');
                  with FMp4Tagger do
                  begin
                    // try to read tool tag from the source
                    LTool := '';
                    LoadFromFile(FOutputFileName);
                    if not Loaded then
                    begin
                      WriteError('not ladded mp4');
                    end;
                    for I := 0 to Count - 1 do
                    begin
                      if '©too' = AtomNameToString(Atoms[i].ID) then
                      begin
                        LTool := Atoms[i].GetAsText;
                      end;
                    end;
                    if Length(LTool) > 0 then
                    begin
                      Tool := LTool;
                    end;
                    Writeln('tool: ' + Tool);
                    SetText('©nam', Title);
                    SetText('©ART', Artist);
                    SetText('©alb', Album);
                    SetGenre(Genre);
                    SetText('©day', Date);
                    SetTrack(StrToIntDef(TrackNo, 0), StrToIntDef(TrackTotal, 0));
                    SetDisc(StrToIntDef(DiscNo, 0), StrToIntDef(DiscTotal, 0));
                    SetText('©cmt', Comment);
                    SetText('aART', AlbumArtist);
                    SetText('©wrt', Composer);
                    SetText('sonm', NameSort);
                    SetText('soar', ArtistSort);
                    SetText('soaa', AlbumArtistSort);
                    SetText('soal', AlbumSort);
                    // if WriteToolTag then
                    // begin
                    // SetText('©too', Tool);
                    // end
                    // else
                    // begin
                    // SetText('©too', '');
                    // end;
                    if FileExists(Cover) then
                    begin
                      AddAtom('covr').AddData.Data.LoadFromFile(Cover);
                    end;

                    // RG values for alac
                    // todo: check if these are valid fields
                    if TagType = 'alac' then
                    begin
                      // check for valid rg fields before writing
                      if Length(REPLAYGAIN_ALBUM_GAIN) > 0 then
                      begin
                        AddAtom('REPLAYGAIN_ALBUM_GAIN').AddData.Data.Write(REPLAYGAIN_ALBUM_GAIN, Length(REPLAYGAIN_ALBUM_GAIN));
                      end;
                      if Length(REPLAYGAIN_ALBUM_PEAK) > 0 then
                      begin
                        AddAtom('REPLAYGAIN_ALBUM_PEAK').AddData.Data.Write(REPLAYGAIN_ALBUM_PEAK, Length(REPLAYGAIN_ALBUM_PEAK));
                      end;
                      if Length(REPLAYGAIN_TRACK_GAIN) > 0 then
                      begin
                        AddAtom('REPLAYGAIN_TRACK_GAIN').AddData.Data.Write(REPLAYGAIN_TRACK_GAIN, Length(REPLAYGAIN_TRACK_GAIN));
                      end;
                      if Length(REPLAYGAIN_TRACK_PEAK) > 0 then
                      begin
                        AddAtom('REPLAYGAIN_TRACK_PEAK').AddData.Data.Write(REPLAYGAIN_TRACK_PEAK, Length(REPLAYGAIN_TRACK_PEAK));
                      end;
                    end;
                  end;

                  Writeln('Saving to file.');
                  if FMp4Tagger.SaveToFile(FOutputFileName) = MP4TAGLIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FMp4Tagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FMp4Tagger);
                end;
              end
{$ENDREGION}
              else if TagType = 'flac' then
              begin
                Writeln('Tag type to write is FLAC.');
                FFLACTagger := TFlacTag.Create;
                try
                  Writeln('Starting to write tags.');
                  with FFLACTagger do
                  begin
                    // general tags
                    // todo: check tag fields using mp3tag
                    SetTextFrameText('TITLE', Title);
                    SetTextFrameText('ARTIST', Artist);
                    SetTextFrameText('ALBUM', Album);
                    SetTextFrameText('GENRE', Genre);
                    SetTextFrameText('DATE', Date);
                    SetTextFrameText('TRACKNUMBER', TrackNo);
                    SetTextFrameText('TOTALTRACKS', TrackTotal);
                    SetTextFrameText('DISCNUMBER', DiscNo);
                    SetTextFrameText('COMMENT', Comment);
                    SetTextFrameText('ALBUMARTIS', AlbumArtist);
                    SetTextFrameText('COMPOSER', Composer);
                    SetTextFrameText('TITLESORT', NameSort);
                    SetTextFrameText('ARTISTSORT', ArtistSort);
                    SetTextFrameText('ALBUMARTISTSORT', AlbumArtistSort);
                    SetTextFrameText('ALBUMSORT', AlbumSort);
                    SetTextFrameText('ENCODING', Tool);
                    // cover art
                    if FileExists(Cover) then
                    begin
                      // get picture dimensions
                      if (LowerCase(ExtractFileExt(Cover)) = '.png') then
                      begin
                        FlacTagCoverArt.MIMEType := 'image/png';
                        GetPNGSize(Cover, FlacTagCoverArt.Width, FlacTagCoverArt.Height);
                      end
                      else if (LowerCase(ExtractFileExt(Cover)) = '.jpg') or (LowerCase(ExtractFileExt(Cover)) = '.jpeg') then
                      begin
                        FlacTagCoverArt.MIMEType := 'image/jpeg';
                        GetJPGSize(Cover, FlacTagCoverArt.Width, FlacTagCoverArt.Height);
                      end;

                      ArtIndex := AddMetaDataCoverArt(nil, 0);
                      NewPictureStream := TFileStream.Create(Cover, fmShareDenyWrite);
                      try
                        with FlacTagCoverArt do
                        begin
                          PictureType := 3;
                          Description := '';
                          ColorDepth := 24;
                          NoOfColors := 0;
                        end;
                        SetCoverArt(ArtIndex, NewPictureStream, FlacTagCoverArt)
                      finally
                        NewPictureStream.Free;
                      end;
                    end;
                    // rg values from lossless source.
                    // check if such value exists before writing it, because
                    // this may mean a rgscan is due.
                    if Length(REPLAYGAIN_ALBUM_GAIN) > 0 then
                    begin
                      SetTextFrameText('REPLAYGAIN_ALBUM_GAIN', REPLAYGAIN_ALBUM_GAIN);
                    end;
                    if Length(REPLAYGAIN_ALBUM_PEAK) > 0 then
                    begin
                      SetTextFrameText('REPLAYGAIN_ALBUM_PEAK', REPLAYGAIN_ALBUM_PEAK);
                    end;
                    if Length(REPLAYGAIN_TRACK_GAIN) > 0 then
                    begin
                      SetTextFrameText('REPLAYGAIN_TRACK_GAIN', REPLAYGAIN_TRACK_GAIN);
                    end;
                    if Length(REPLAYGAIN_TRACK_PEAK) > 0 then
                    begin
                      SetTextFrameText('REPLAYGAIN_TRACK_PEAK', REPLAYGAIN_TRACK_PEAK);
                    end;
                  end;
                  Writeln('Saving to file.');
                  if FFLACTagger.SaveToFile(FOutputFileName) = FLACTAGLIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FFLACTagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FFLACTagger);
                end;
              end
              else if TagType = 'wma' then
              begin
                Writeln('Tag type to write is WMA.');
                FWMATagger := TWMATag.Create;
                try
                  Writeln('Starting to write tags.');
                  with FWMATagger do
                  begin
                    // general tags
                    // todo: add more
                    SetTextFrameText(g_wszWMTitle, Title);
                    SetTextFrameText(g_wszWMAuthor, Artist);
                    SetTextFrameText(g_wszWMGenre, Genre);
                    SetTextFrameText(g_wszWMTrack, TrackNo);
                    SetTextFrameText(g_wszWMYear, Date);
                    SetTextFrameText(g_wszWMComposer, Composer);
                    SetTextFrameText(g_wszWMAlbumTitle, Album);
                    SetTextFrameText(g_wszWMDescription, Comment);
                    SetTextFrameText(g_wszWMToolName, Tool);
                    // cover art
                    if FileExists(Cover) then
                    begin
                      NewPictureStream := TFileStream.Create(Cover, fmShareDenyWrite);
                      try
                        ArtIndex := AddFrame(g_wszWMPicture).Index;
                        if (LowerCase(ExtractFileExt(Cover)) = '.png') then
                        begin
                          WMAMime := 'image/png';
                        end
                        else if (LowerCase(ExtractFileExt(Cover)) = '.jpg') or (LowerCase(ExtractFileExt(Cover)) = '.jpeg') then
                        begin
                          WMAMime := 'image/jpeg';
                        end;
                        if not SetCoverArtFrame(ArtIndex, NewPictureStream, WMAMime, 3, 'Cover') then
                        begin
                          WriteError('Couldn''t write artwork.');
                        end;
                      finally
                        NewPictureStream.Free;
                      end;
                    end
                    else
                    begin
                      if Length(Cover) > 0 then
                      begin
                        WriteError('Image not found: ' + Cover);
                      end;
                    end;
                  end;
                  Writeln('Saving to file.');
                  if FWMATagger.SaveToFile(FOutputFileName) = WMATAGLIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FWMATagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FWMATagger);
                end;
              end
              else if TagType = 'id3v2' then
              begin
                Writeln('Tag type to write is ID3v2.');
                FID3v2Tagger := TID3v2Tag.Create;
                try
                  Writeln('Starting to write tags.');
                  with FID3v2Tagger do
                  begin
                    // general tags
                    SetUnicodeText('TPE1', Artist);
                    SetUnicodeText('TIT2', Title);
                    SetUnicodeText('TALB', Album);
                    SetUnicodeText('TCON', Genre);
                    SetUnicodeText('TYER', Date);
                    SetUnicodeText('TPE2', AlbumArtist);
                    SetUnicodeText('TSO2', AlbumArtistSort);
                    SetUnicodeText('TSOA', AlbumSort);
                    SetUnicodeText('TCOM', Composer);
                    SetUnicodeText('TENC', Tool);
                    LanguageID[0] := Ord('e');
                    LanguageID[1] := Ord('n');
                    LanguageID[2] := Ord('g');
                    SetUnicodeComment('COMM', Comment, LanguageID, '');
                    if Length(TrackTotal) > 0 then
                    begin
                      SetUnicodeText('TRCK', TrackNo + '/' + TrackTotal);
                    end
                    else
                    begin
                      SetUnicodeText('TRCK', TrackNo);
                    end;
                    if Length(DiscTotal) > 0 then
                    begin
                      SetUnicodeText('TPOS', DiscNo + '/' + DiscTotal);
                    end
                    else
                    begin
                      SetUnicodeText('TPOS', DiscNo);
                    end;
                    // cover art
                    if FileExists(Cover) then
                    begin
                      NewPictureStream := TFileStream.Create(Cover, fmShareDenyWrite);
                      try
                        ArtIndex := AddFrame('APIC');
                        if (LowerCase(ExtractFileExt(Cover)) = '.png') then
                        begin
                          WMAMime := 'image/png';
                        end
                        else if (LowerCase(ExtractFileExt(Cover)) = '.jpg') or (LowerCase(ExtractFileExt(Cover)) = '.jpeg') then
                        begin
                          WMAMime := 'image/jpeg';
                        end;
                        if not SetUnicodeCoverPictureFromStream(ArtIndex, 'Front', NewPictureStream, WMAMime, $03) then
                        begin
                          WriteError('Couldn''t write artwork.');
                        end;
                      finally
                        NewPictureStream.Free;
                      end;
                    end
                    else
                    begin
                      if Length(Cover) > 0 then
                      begin
                        WriteError('Image not found: ' + Cover);
                      end;
                    end;
                    SetUnicodeText('TPE2', AlbumArtist);
                  end;
                  Writeln('Saving to file.');
                  if FID3v2Tagger.SaveToFile(FOutputFileName) = ID3V2LIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FID3v2Tagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FID3v2Tagger);
                end;
              end
              else if TagType = 'ogg' then
              begin
                Writeln('Tag type to write is Ogg.');
                FOggTagger := TOpusTag.Create;
                try
                  Writeln('Starting to write tags.');
                  with FOggTagger do
                  begin
                    // general tags
                    SetTextFrameText('TITLE', Title);
                    SetTextFrameText('ARTIST', Artist);
                    SetTextFrameText('GENRE', Genre);
                    SetTextFrameText('TRACKNUMBER', TrackNo);
                    SetTextFrameText('TOTALTRACKS', TrackTotal);
                    SetTextFrameText('DATE', Date);
                    SetTextFrameText('DISCNUMBER', DiscNo);
                    SetTextFrameText('ALBUM', Album);
                    SetTextFrameText('COMMENT', Comment);
                    SetTextFrameText('ENCODING', Tool);
                    // cover art
                    if FileExists(Cover) then
                    begin
                      NewPictureStream := TFileStream.Create(Cover, fmShareDenyWrite);
                      try
                        if (LowerCase(ExtractFileExt(Cover)) = '.png') then
                        begin
                          WMAMime := 'image/png';
                          GetPNGSize(Cover, PicWidth, PicHeight);
                        end
                        else if (LowerCase(ExtractFileExt(Cover)) = '.jpg') or (LowerCase(ExtractFileExt(Cover)) = '.jpeg') then
                        begin
                          WMAMime := 'image/jpeg';
                          GetJPGSize(Cover, PicWidth, PicHeight);
                        end;

                        OggOpusCoverInfo.PictureType := 3;
                        OggOpusCoverInfo.MIMEType := WMAMime;
                        OggOpusCoverInfo.Description := 'Cover';
                        OggOpusCoverInfo.Width := PicWidth;
                        OggOpusCoverInfo.Height := PicHeight;
                        OggOpusCoverInfo.ColorDepth := 24;
                        OggOpusCoverInfo.NoOfColors := 0;
                        OggOpusCoverInfo.SizeOfPictureData := NewPictureStream.Size;

                        if AddCoverArtFrame(NewPictureStream, OggOpusCoverInfo) > 0 then
                        begin
                          WriteError('Couldn''t write artwork.');
                        end
                        else
                        begin
                          Writeln('Written artwork size: ' + FloatToStr(NewPictureStream.Size));
                        end;
                      finally
                        NewPictureStream.Free;
                      end;
                    end
                    else
                    begin
                      if Length(Cover) > 0 then
                      begin
                        WriteError('Image not found: ' + Cover);
                      end;
                    end;
                  end;
                  Writeln('Saving to file.');
                  if FOggTagger.SaveToFile(FOutputFileName) = OPUSTAGLIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FOggTagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FOggTagger);
                end;
              end
              else if TagType = 'wav' then
              begin
                Writeln('Tag type to write is WAV.');
                FWavTagger := TWAVTag.Create;
                try
                  Writeln('Starting to write tags.');
                  with FWavTagger do
                  begin
                    // general tags
                    SetTextFrameText('INAM', Title);
                    SetTextFrameText('IART', Artist);
                    SetTextFrameText('IGNR', Genre);
                    SetTextFrameText('ITRK', TrackNo);
                    SetTextFrameText('ICRD', Date);
                    SetTextFrameText('IPRD', Album);
                    SetTextFrameText('ICMT', Comment);
                    SetTextFrameText('ENCODING', Tool);
                  end;
                  Writeln('Saving to file.');
                  if FWavTagger.SaveToFile(FOutputFileName) = WAVTAGLIBRARY_SUCCESS then
                  begin
                    Writeln('Saved to file: ' + FOutputFileName);
                  end
                  else
                  begin
                    Writeln('Error saving to file: ' + FOutputFileName);
                    WriteError('Error code is ' + FloatToStr(FWavTagger.SaveToFile(FOutputFileName)));
                    ExitCode := EXIT_CODE_TAG_NOT_WRITTEN;
                  end;
                finally
                  FreeAndNil(FWavTagger);
                end;
              end;
            end;
          end;
        end
        else
        begin
          WriteError('Cannot find output file: ' + FOutputFileName);
          ExitCode := EXIT_CODEC_OUTPUT_NOT_FOUND;
        end;
      end
      else
      begin
        WriteError('Cannot find tag file: ' + FIniFilePath);
        ExitCode := EXIT_CODE_INPUT_NOT_FOUND;
      end;
    end
    else
    begin
      WriteError('Not enough parameters (' + FloatToStr(ParamCount) + ').');
      Writeln('Usage: ttagger.exe tagsfile.txt filetowritetags');
      ExitCode := EXIT_CODE_NOT_ENOUGH_CMD;
    end;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := MaxInt;
    end;
  end;

end.

