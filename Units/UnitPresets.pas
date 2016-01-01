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
unit UnitPresets;

interface

uses
  Generics.Collections, IniFiles, System.SysUtils;

type
  TPreset = class(TObject)
    EncodeType: Integer;
    FileName: string;
    ListName: string;
  public
    procedure ReadIni(const IniPath: string);
  end;

  TLamePresetList = TList<TPreset>;

implementation

{ TPreset }

procedure TPreset.ReadIni(const IniPath: string);
var
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(IniPath);
  try
    Self.EncodeType := LIniFile.ReadInteger('general', 'encoder', -1);
    Self.FileName := IniPath;
    Self.ListName := ExtractFileName(ChangeFileExt(IniPath, ''));
  finally
    LIniFile.Free;
  end;
end;

end.

