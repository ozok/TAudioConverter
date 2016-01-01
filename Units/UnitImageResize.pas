unit UnitImageResize;

interface

uses
  Classes, Windows, SysUtils, Messages, StrUtils, Jpeg, Graphics, PngImage,
  GIFImg;

type
  TImageResizer = class(TObject)
  private
    FWidth: Integer;
    FHeight: Integer;
    FSourcePath: string;
    FDestPath: string;
    function ResizeJpg(const inFile, outFile: TFileName; const aQuality: TJPEGQualityRange = 95): Boolean;
    procedure ResizePNG(const Infile: string; const OutFile: string);
    procedure ResizeBMP(const Infile: string; const OutFile: string);
    procedure ResizeGIF(const Infile: string; const OutFile: string);
  public
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    constructor Create(const SourceImg: string; const DestImg: string);
    destructor Destroy; override;
    procedure Resize;
  end;

implementation

{ TImageResizer }

constructor TImageResizer.Create(const SourceImg, DestImg: string);
begin
  FSourcePath := SourceImg;
  FDestPath := DestImg;
end;

destructor TImageResizer.Destroy;
begin
  inherited;
end;

procedure TImageResizer.Resize;
var
  LExt: string;
begin
  if not FileExists(FSourcePath) then
    Exit;

  LExt := LowerCase(ExtractFileExt(FSourcePath));
  if (LExt = '.jpeg') or (LExt = '.jpg') then
  begin
    ResizeJpg(FSourcePath, FDestPath)
  end
  else if LExt = '.png' then
  begin
    ResizePNG(FSourcePath, FDestPath);
  end
  else if LExt = '.bmp' then
  begin
    ResizeBMP(FSourcePath, FDestPath);
  end
  else if LExt = '.gif' then
  begin
    ResizeGIF(FSourcePath, FDestPath);
  end;
end;

procedure TImageResizer.ResizeBMP(const Infile, OutFile: string);
var
  LBmp: TBitmap;
  Ldest: TBitmap;
begin

  LBmp := TBitmap.Create;
  Ldest := TBitmap.Create;
  try
    LBmp.LoadFromFile(Infile);

    Ldest.Width := FWidth;
    Ldest.Height := FHeight;
    Ldest.PixelFormat := pf24bit;
    Ldest.Canvas.StretchDraw(Ldest.Canvas.ClipRect, LBmp);
    Ldest.SaveToFile(OutFile);
  finally
    Ldest.Free;
    LBmp.Free;
  end;

end;

procedure TImageResizer.ResizeGIF(const Infile, OutFile: string);
var
  LBmp: TBitmap;
  LGIF: TGIFImage;
begin

  LBmp := TBitmap.Create;
  LGIF := TGIFImage.Create;
  try
    LGIF.LoadFromFile(Infile);

    LBmp.Width := FWidth;
    LBmp.Height := FHeight;
    LBmp.PixelFormat := pf24bit;
    LBmp.Canvas.StretchDraw(LBmp.Canvas.ClipRect, LGIF);
    LGIF.Assign(LBmp);
    LGIF.SaveToFile(OutFile);

  finally
    LBmp.Free;
    LGIF.Free;
  end;

end;
// code is from http://jetcracker.wordpress.com/2012/03/05/my-old-trash-resizing-images-in-delphi/

function TImageResizer.ResizeJpg(const inFile, outFile: TFileName; const aQuality: TJPEGQualityRange): Boolean;
var
  Jpeg: TJPEGImage;
  BMP: TBitmap;
begin
  Result := FileExists(inFile);
  if not Result then
    Exit;

  Jpeg := TJPEGImage.Create;
  BMP := TBitmap.Create;
  try
    try
      // Load
      Jpeg.LoadFromFile(inFile);
    except
      Result := False;
      Exit;
    end;
    BMP.Width := FWidth;
    BMP.Height := FHeight;
    BMP.PixelFormat := pf24bit;
    // Change size
    with BMP.Canvas do
      StretchDraw(ClipRect, Jpeg);
    // Move from Bitmap to Jpeg
    Jpeg.Assign(BMP);
    // Change quality
    Jpeg.CompressionQuality := aQuality;
    Jpeg.Compress;
    try
      // Save file
      Jpeg.SaveToFile(outFile);
    except
      Result := False;
    end;
  finally
    FreeAndNil(Jpeg);
    FreeAndNil(BMP);
  end;
end;

procedure TImageResizer.ResizePNG(const Infile, OutFile: string);
var
  LBmp: TBitmap;
  LPng: TPngImage;
begin

  LBmp := TBitmap.Create;
  LPng := TPngImage.Create;
  try
    LPng.LoadFromFile(Infile);

    LBmp.Width := FWidth;
    LBmp.Height := FHeight;
    LBmp.PixelFormat := pf24bit;
    LBmp.Canvas.StretchDraw(LBmp.Canvas.ClipRect, LPng);
    LPng.Assign(LBmp);
    LPng.SaveToFile(OutFile);

  finally
    LBmp.Free;
    LPng.Free;
  end;

end;

end.

