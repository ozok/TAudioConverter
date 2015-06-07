Unit BASS_SPX;

interface

uses windows, bass;

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_SPX = $10C00;

const
  bassspxdll = 'basslib\bass_spx.dll';

function BASS_SPX_StreamCreateFile(mem: BOOL; f: Pointer; offset, length: QWORD; flags: DWORD): HSTREAM; stdcall; external bassspxdll;
function BASS_SPX_StreamCreateFileUser(system, flags: DWORD; var procs: BASS_FILEPROCS; user: Pointer): HSTREAM; stdcall; external bassspxdll;

implementation

end.
