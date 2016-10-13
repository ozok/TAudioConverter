Unit BASS_APE;

interface

{$IFDEF MSWINDOWS}
uses BASS, Windows;
{$ELSE}
uses BASS;
{$ENDIF}

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_APE        = $10700;

const
{$IFDEF MSWINDOWS}
  bassapedll = 'bass_ape.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassapedll = 'libbass_ape.so';
{$ENDIF}
{$IFDEF MACOS}
  bassapedll = 'libbass_ape.dylib';
{$ENDIF}

function BASS_APE_StreamCreateFile(mem: BOOL; f: Pointer; offset, length: QWORD; flags: DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassapedll;
function BASS_APE_StreamCreateFileUser(system: DWORD; flags: DWORD; procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassapedll;

implementation

end.