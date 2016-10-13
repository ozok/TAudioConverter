Unit BASS_AAC;

interface

{$IFDEF MSWINDOWS}
uses BASS, Windows;
{$ELSE}
uses BASS;
{$ENDIF}

const
  // additional error codes returned by BASS_ErrorGetCode
  BASS_ERROR_MP4_NOSTREAM = 6000; // non-streamable due to MP4 atom order ("mdat" before "moov")

  // additional BASS_SetConfig options
  BASS_CONFIG_MP4_VIDEO = $10700; // play the audio from MP4 videos
  BASS_CONFIG_AAC_MP4 = $10701; // support MP4 in BASS_AAC_StreamCreateXXX functions (no need for BASS_MP4_StreamCreateXXX)
  BASS_CONFIG_AAC_PRESCAN = $10702; // pre-scan ADTS AAC files for seek points and accurate length

  // additional BASS_AAC_StreamCreateFile/etc flags
  BASS_AAC_FRAME960 = $1000; // 960 samples per frame
  BASS_AAC_STEREO = $400000; // downmatrix to stereo

  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_AAC = $10b00; // AAC
  BASS_CTYPE_STREAM_MP4 = $10b01; // MP4

const
{$IFDEF MSWINDOWS}
  bassaacdll = 'bass_aac.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassaacdll = 'libbass_aac.so';
{$ENDIF}
{$IFDEF MACOS}
  bassaacdll = 'libbass_aac.dylib';
{$ENDIF}

function BASS_AAC_StreamCreateFile(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassaacdll;
function BASS_AAC_StreamCreateURL(URL:PChar; offset:DWORD; flags:DWORD; proc:DOWNLOADPROC; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassaacdll;
function BASS_AAC_StreamCreateFileUser(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassaacdll;
function BASS_MP4_StreamCreateFile(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassaacdll;
function BASS_MP4_StreamCreateFileUser(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassaacdll;

implementation

end.