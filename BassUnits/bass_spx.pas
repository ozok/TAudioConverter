Unit BASS_SPX;

interface

{$IFDEF MSWINDOWS}
uses BASS, Windows;
{$ELSE}
uses BASS;
{$ENDIF}

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_SPX        = $10c00;


const
{$IFDEF MSWINDOWS}
  bassspxdll = 'bass_spx.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassspxdll = 'libbass_spx.so';
{$ENDIF}
{$IFDEF MACOS}
  bassspxdll = 'libbass_spx.dylib';
{$ENDIF}


function BASS_SPX_StreamCreateFile(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassspxdll;
function BASS_SPX_StreamCreateURL(url:PChar; offset:DWORD; flags:DWORD; proc:DOWNLOADPROC; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassspxdll;
function BASS_SPX_StreamCreateFileUser(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassspxdll;

implementation

end.