Unit BASS_TTA;

interface

uses windows, bass;

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_TTA        = $10f00;


const
  bassttadll = 'bass_tta.dll';


function BASS_TTA_StreamCreateFile(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; stdcall; external bassttadll;
function BASS_TTA_StreamCreateFileUser(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; stdcall; external bassttadll;

implementation

end.