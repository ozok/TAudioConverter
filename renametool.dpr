program renametool;
{$IFOPT D-}{$WEAKLINKRTTI ON}{$ENDIF}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, System.Classes, Winapi.Windows;

const
  _ERROR_CANNOT_DELETE_OLD = 1;
  _ERROR_WRONG_LINE_COUNT = 2;
  _ERROR_WRONG_PARAMCOUNT = 3;
  _ERROR_RENAME_FAILED = 4;
  VERSION = '1.0';

var
  // overwrite option: 1-add index, 2-skip, 3-overwrite
  // source
  // dest
  FRenameFile: TStringList;
  LDestName: string;
  LDestExt: string;
  LFileIndex: Integer;

begin
  Writeln('RenameTool ' + VERSION);
  try
    { accepts single command indicating a text file }
    if ParamCount = 1 then
    begin
      FRenameFile := TStringList.Create;
      try
        // load text file
        FRenameFile.LoadFromFile(ParamStr(1), TEncoding.UTF8);
        if FRenameFile.Count = 3 then
        begin
          LDestName := FRenameFile[2];
          // if overwrite is selected
          // and dest already exists, delete it.
          if FRenameFile[0] = '3' then
          begin
            if FileExists(FRenameFile[2]) then
            begin
              // delete old file
              if not DeleteFile(PWideChar(FRenameFile[2])) then
              begin
                Writeln('Cannot delete old file.');
                ExitCode := _ERROR_CANNOT_DELETE_OLD;
                Halt;
              end;
            end;
          end
          // skip it
          else if FRenameFile[0] = '2' then
          begin
            if FileExists(FRenameFile[2]) then
            begin
              Writeln('Skipping ' + LDestName);
              Halt;
            end;
          end
          // add index
          else if FRenameFile[0] = '1' then
          begin
            LFileIndex := 0;
            LDestExt := ExtractFileExt(LDestName);
            // add index
            if FileExists(LDestName) then
            begin
              while FileExists(LDestName) do
              begin
                Inc(LFileIndex);
                LDestName := ChangeFileExt(LDestName, '_' + FloatToStr(LFileIndex) + LDestExt);
              end;
            end;
          end;

          // rename file
          if FileExists(FRenameFile[1]) then
          begin
            if not RenameFile(FRenameFile[1], LDestName) then
            begin
              Writeln('Cannot rename ' + FRenameFile[1] + ' to ' + LDestName);
              ExitCode := _ERROR_RENAME_FAILED;
            end
            else
            begin
              Writeln('Renamed ' + FRenameFile[1] + ' to ' + LDestName);
              ExitCode := 0;
            end;
          end;
        end
        else
        begin
          Writeln('Only 3 lines');
          ExitCode := _ERROR_WRONG_LINE_COUNT;
        end;
      finally
        FRenameFile.Free;
      end;
    end
    else
    begin
      Writeln('Not enough params: ' + FloatToStr(ParamCount));
      ExitCode := _ERROR_WRONG_PARAMCOUNT;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
