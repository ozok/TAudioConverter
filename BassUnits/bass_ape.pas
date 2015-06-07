Unit BASS_APE;

interface

uses windows, bass;

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_APE = $10700;

const
  bassapedll = 'basslib\bass_ape.dll';

function BASS_APE_StreamCreateFile(mem: BOOL; f: Pointer; offset, length: QWORD; flags: DWORD): HSTREAM; stdcall; external bassapedll;
function BASS_APE_StreamCreateFileUser(system, flags: DWORD; var procs: BASS_FILEPROCS; user: Pointer): HSTREAM; stdcall; external bassapedll;

implementation

end.
