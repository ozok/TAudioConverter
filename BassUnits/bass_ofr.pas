Unit BASS_OFR;

interface

uses windows, bass;

const
  BASS_TAG_APE        = 6; // APE tags
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_OFR        = $10600;


const
  bassofrdll = 'bass_ofr.dll';


function BASS_OFR_StreamCreateFile(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; stdcall; external bassofrdll;
function BASS_OFR_StreamCreateFileUser(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; stdcall; external bassofrdll;

implementation

end.