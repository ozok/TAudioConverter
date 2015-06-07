program TArtworkExtractor;
{$IFOPT D-}{$WEAKLINKRTTI ON}{$ENDIF}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  Soap.EncdDecd,
  MediaInfoDLL in 'Units\MediaInfoDLL.pas',
  WMATagLibrary in 'TagLibraries\WMATagLibrary.pas',
  OggVorbisAndOpusTagLibrary in 'TagLibraries\OggVorbisAndOpusTagLibrary.pas';

var
  FFileName: string;
  FDestFile: string;
  i: integer;

procedure WriteError(const ErrorStr: string);
begin
  Writeln('Error: ' + ErrorStr);
end;

procedure PrintUsage;
begin
  Writeln('Usage to extract artwork : tartworkextractor.exe sourceaudiofile basefilename');
  Writeln('Usage to get artwork kind: tartworkextractor.exe sourceaudiofile');
  Writeln('');
end;

// gets artwork as base64
function GetArtwork(const FileName: string): AnsiString;
var
  MediaInfoHandle: Cardinal;
begin

  Result := '';

  if (FileExists(FileName)) then
  begin

    // New handle for mediainfo
    MediaInfoHandle := MediaInfo_New();

    if MediaInfoHandle <> 0 then
    begin

      try
        // Open a file in complete mode
        MediaInfo_Open(MediaInfoHandle, PwideChar(FileName));
        MediaInfo_Option(0, 'Complete', '1');

        // get artwork
        Result := MediaInfo_Get(MediaInfoHandle, Stream_General, 0, 'Cover_Data', Info_Text, Info_Name);

      finally
        MediaInfo_Close(MediaInfoHandle);
      end;

    end;

  end;

end;

// saves artwork to dest. folder
procedure SaveArtwork(const ArtworkData: AnsiString; const FOutputFileName: string);
Const
  JPEG = '/9j/';
  PNG = 'iVBOR';
var
  OutputFileName: string;
  ImageStream: TBytesStream;
  ArtworkLength: Integer;
begin

  ArtworkLength := Length(ArtworkData);

  if ArtworkLength > 0 then
  begin
    Writeln('Length of artwork data is ' + FloatToStr(ArtworkLength) + '.');

    ImageStream := TBytesStream.Create(DecodeBase64(ArtworkData));
    try

      if Copy(ArtworkData, 1, Length(JPEG)) = JPEG then
      begin
        OutputFileName := FOutputFileName + '.jpg';
      end
      else if Copy(ArtworkData, 1, Length(PNG)) = PNG then
      begin
        OutputFileName := FOutputFileName + '.png';
      end;
      Writeln('Saving image file as ' + ExtractFileName(OutputFileName) + '.');

      if Length(OutputFileName) > 0 then
      begin
        ImageStream.SaveToFile(OutputFileName);
      end;

    finally
      ImageStream.Clear;
      FreeAndNil(ImageStream);
    end;
  end
  else
  begin
    WriteError('Artwork data is empty.');
  end;

end;

function GetImageExt(const ArtworkData: AnsiString): string;
Const
  JPEG = '/9j/';
  PNG = 'iVBOR';
var
  ArtworkLength: Integer;
begin

  ArtworkLength := Length(ArtworkData);

  if ArtworkLength > 0 then
  begin

    if Copy(ArtworkData, 1, Length(JPEG)) = JPEG then
    begin
      Result := 'jpg';
    end
    else if Copy(ArtworkData, 1, Length(PNG)) = PNG then
    begin
      Result := 'png'
    end;

  end
  else
  begin
    Result := 'ff1';
  end;
end;

function GetWMACoverType(const FileName: string): string;
var
  LWmaTag: TWMATag;
  i: Integer;
  PictureStream: TStream;
  MIMEType: string;
  PictureType: Byte;
  Description: string;
begin

  Result := '.ff4';
  LWmaTag := TWMATag.Create;
  try
    if LWmaTag.LoadFromFile(FileName) = 0 then
    begin
      for i := 0 to LWmaTag.Count - 1 do
      begin
        if LWmaTag.Frames[i].Name = g_wszWMPicture then
        begin
          PictureStream := TMemoryStream.Create;
          try
            if LWmaTag.GetCoverArtFromFrame(i, PictureStream, MIMEType, PictureType, Description) then
            begin
              MIMEType := LowerCase(MIMEType);
              PictureStream.Seek(0, soBeginning);
              if (MIMEType = 'image/jpeg') OR (MIMEType = 'image/jpg') then
              begin
                Result := '.jpg'
              end;
              if MIMEType = 'image/png' then
              begin
                Result := '.png'
              end;
            end;
          finally
            FreeAndNil(PictureStream);
          end;
        end;
      end;
    end
    else
    begin
      Result := '.ff3'
    end;
  finally
    LWmaTag.Free;
  end;

end;

procedure SaveWMAArtWork(const FOutputFileName: string);
var
  LWmaTag: TWMATag;
  i: Integer;
  PictureStream: TStream;
  MIMEType: string;
  PictureType: Byte;
  Description: string;
  LFS: TFileStream;
begin

  LWmaTag := TWMATag.Create;
  try
    if LWmaTag.LoadFromFile(FFileName) = 0 then
    begin
      for i := 0 to LWmaTag.Count - 1 do
      begin
        if LWmaTag.Frames[i].Name = g_wszWMPicture then
        begin
          PictureStream := TMemoryStream.Create;
          try
            if LWmaTag.GetCoverArtFromFrame(i, PictureStream, MIMEType, PictureType, Description) then
            begin
              MIMEType := LowerCase(MIMEType);
              PictureStream.Seek(0, soBeginning);
              if (MIMEType = 'image/jpeg') OR (MIMEType = 'image/jpg') then
              begin
                LFS := TFileStream.Create(FOutputFileName + '.jpg', fmCreate);
                try
                  LFS.CopyFrom(PictureStream, PictureStream.Size);
                finally
                  LFS.Free;
                end;
              end;
              if MIMEType = 'image/png' then
              begin
                LFS := TFileStream.Create(FOutputFileName + '.png', fmOpenWrite);
                try
                  LFS.CopyFrom(PictureStream, PictureStream.Size);
                finally
                  LFS.Free;
                end;
              end;
            end;
          finally
            FreeAndNil(PictureStream);
          end;
        end;
      end;
    end;
  finally
    LWmaTag.Free;
  end;
end;

function GetOggCoverType(const FileName: string): string;
var
  LOggTag: TOpusTag;
  i: Integer;
  LCoverArt: TOpusVorbisCoverArtInfo;
  LIndex: Integer;
  LStream: TStream;
begin

  Result := '';
  if FileExists(FileName) then
  begin
    LOggTag := TOpusTag.Create;
    if LOggTag.LoadFromFile(FileName) = OPUSTAGLIBRARY_SUCCESS then
    begin
      LIndex := LOggTag.FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE);
      if LIndex > -1 then
      begin
        LStream := TMemoryStream.Create;
        try
          if LOggTag.GetCoverArtFromFrame(LIndex, LStream, LCoverArt) then
          begin
            LCoverArt.MIMEType := LowerCase(LCoverArt.MIMEType);
            if (LCoverArt.MIMEType = 'image/jpeg') OR (LCoverArt.MIMEType = 'image/jpg') then
            begin
              Result := '.jpg';
            end;
            if (LCoverArt.MIMEType = 'image/png') then
            begin
              Result := '.png';
            end;
            if (LCoverArt.MIMEType = 'image/gif') then
            begin
              Result := '.gif';
            end;
            if LCoverArt.MIMEType = 'image/bmp' then
            begin
              Result := '.bmp';
            end;
          end;
        finally
          LStream.Free;
        end;
      end;
    end;
  end;
end;

procedure SaveOggCover(const FOutputFileName: string);
var
  LOggTag: TOpusTag;
  i: Integer;
  LCoverArt: TOpusVorbisCoverArtInfo;
  LIndex: Integer;
  LStream: TStream;
  LFS: TFileStream;
  LExt: string;
begin

  LOggTag := TOpusTag.Create;
  if LOggTag.LoadFromFile(FFileName) = OPUSTAGLIBRARY_SUCCESS then
  begin
    LIndex := LOggTag.FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE);
    if LIndex > -1 then
    begin
      LStream := TMemoryStream.Create;
      try
        if LOggTag.GetCoverArtFromFrame(LIndex, LStream, LCoverArt) then
        begin
          LStream.Seek(0, soFromBeginning);

          LCoverArt.MIMEType := LowerCase(LCoverArt.MIMEType);
          if (LCoverArt.MIMEType = 'image/jpeg') OR (LCoverArt.MIMEType = 'image/jpg') then
          begin
            LExt := '.jpg';
          end;
          if (LCoverArt.MIMEType = 'image/png') then
          begin
            LExt := '.png';
          end;
          if (LCoverArt.MIMEType = 'image/gif') then
          begin
            LExt := '.gif';
          end;
          if LCoverArt.MIMEType = 'image/bmp' then
          begin
            LExt := '.bmp';
          end;

          LFS := TFileStream.Create(FOutputFileName + LExt, fmCreate);
          try
            LFS.CopyFrom(LStream, LStream.Size);
          finally
            LFS.Free;
          end;
        end;
      finally
        LStream.Free;
      end;
    end;
  end;
end;

procedure Main;
var
  FImageByteStream: TBytesStream;
  OutExt: string;
begin
  if ParamCount = 3 then
  begin
    Writeln('TArtworkExtractor - 0.1.2 Beta - (C) 2013-2014 ozok - GPLv2');
    Writeln('Simple tool to extract artwork from audio files.');
    FFileName := ParamStr(2);
    FDestFile := ParamStr(3); // file name without extension
    if not FileExists(FFileName) then
    begin
      WriteError('Can''t find source[1]: ' + FFileName);
      Exit;
    end;
    if not DirectoryExists(ExtractFileDir(FDestFile)) then
    begin
      WriteError('Can''t find output folder ' + ExtractFileDir(FDestFile));
      Exit;
    end;
    Writeln('Source     : ' + FFileName);
    Writeln('Destination: ' + ExtractFileDir(FDestFile));
    Writeln('Starting process.');
    if LowerCase(ExtractFileExt(FFileName)) = '.wma' then
    begin
      SaveWMAArtWork(FDestFile);
    end
    else if (LowerCase(ExtractFileExt(FFileName)) = '.ogg') or (LowerCase(ExtractFileExt(FFileName)) = '.opus') then
    begin
      SaveOggCover(FDestFile);
    end
    else
    begin
      SaveArtwork(GetArtwork(FFileName), FDestFile);
    end;
  end
  else if ParamCount = 2 then
  begin
    FFileName := ParamStr(2);
    if not FileExists(FFileName) then
    begin
      WriteError('Can''t find source[2]: ' + FFileName);
      Exit;
    end;
    if LowerCase(ExtractFileExt(FFileName)) = '.wma' then
    begin
      Writeln(GetWMACoverType(FFileName));
    end
    else if (LowerCase(ExtractFileExt(FFileName)) = '.ogg') or (LowerCase(ExtractFileExt(FFileName)) = '.opus') then
    begin
      Writeln(GetOggCoverType(FFileName));
    end
    else
    begin
      Writeln(GetImageExt(GetArtwork(FFileName)));
    end;
  end
  else
  begin
    WriteError('Wrong parameter count. (' + FloatToStr(ParamCount) + ').');
    PrintUsage;
  end;
end;

begin
  try
    if MediaInfoDLL_Load(ExtractFileDir(ParamStr(0)) + '\mediainfo.dll') then
    begin
      Main;
    end
    else
    begin
      WriteError('Cannot load mediainfo.dll.');
      Writeln('Exiting.');
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
