Unit BASS_ALAC;

interface

{$IFDEF MSWINDOWS}

uses BASS, Windows;
{$ELSE}

uses BASS;
{$ENDIF}

const
  BASS_TAG_MP4 = 7; // iTunes/MP4 metadata

  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_ALAC = $10E00;

const
{$IFDEF MSWINDOWS}
  bassalacdll = 'basslib\bass_alac.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassalacdll = 'libbass_alac.so';
{$ENDIF}
{$IFDEF MACOS}
  bassalacdll = 'libbass_alac.dylib';
{$ENDIF}
function BASS_ALAC_StreamCreateFile(mem: BOOL; f: Pointer; offset, length: QWORD; flags: DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
external bassalacdll;
function BASS_ALAC_StreamCreateURL(url: PAnsiChar; offset: DWORD; flags: DWORD; proc: DOWNLOADPROC; user: Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
external bassalacdll;
function BASS_ALAC_StreamCreateFileUser(system, flags: DWORD; var procs: BASS_FILEPROCS; user: Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
external bassalacdll;

implementation

end.
