{
  BASSOPUS 2.4 Delphi unit
  Copyright (c) 2012 Un4seen Developments Ltd.

  See the BASSOPUS.CHM file for more detailed documentation
}

unit BassOPUS;

interface

{$IFDEF MSWINDOWS}

uses BASS, Windows;
{$ELSE}

uses BASS;
{$ENDIF}

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_OPUS = $11200;

  // Additional attributes
  BASS_ATTRIB_OPUS_ORIGFREQ = $13000;

const
{$IFDEF MSWINDOWS}
  bassopusdll = 'basslib\bassopus.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassopusdll = 'libbassopus.so';
{$ENDIF}
{$IFDEF MACOS}
  bassopusdll = 'libbassopus.dylib';
{$ENDIF}
function BASS_OPUS_StreamCreateFile(mem: BOOL; fl: pointer; offset, length: QWORD; flags: DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
external bassopusdll;
function BASS_OPUS_StreamCreateURL(url: PAnsiChar; offset: DWORD; flags: DWORD; proc: DOWNLOADPROC; user: pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
external bassopusdll;
function BASS_OPUS_StreamCreateFileUser(system, flags: DWORD; var procs: BASS_FILEPROCS; user: pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
external bassopusdll;

implementation

end.
