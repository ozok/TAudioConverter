{
  BASSFLAC 2.4 Delphi unit
  Copyright (c) 2004-2009 Un4seen Developments Ltd.

  See the BASSFLAC.CHM file for more detailed documentation
}

unit BassFLAC;

interface

uses Windows, Bass;

const
  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_FLAC = $10900;
  BASS_CTYPE_STREAM_FLAC_OGG = $10901;

  // Additional tag type
  BASS_TAG_FLAC_CUE = 12; // cuesheet : TAG_FLAC_CUE structure
  BASS_TAG_FLAC_PICTURE = $12000;
  // + index #, picture : TAG_FLAC_PICTURE structure

type
  TAG_FLAC_PICTURE = record
    apic: DWORD; // ID3v2 "APIC" picture type
    mime: PAnsiChar; // mime type
    desc: PAnsiChar; // description
    width: DWORD;
    height: DWORD;
    depth: DWORD;
    colors: DWORD;
    length: DWORD; // data length
    data: Pointer;
  end;

const
  bassflacdll = 'basslib\bassflac.dll';

function BASS_FLAC_StreamCreateFile(mem: BOOL; f: Pointer; offset, length: QWORD; flags: DWORD): HSTREAM; stdcall; external bassflacdll;
function BASS_FLAC_StreamCreateURL(URL: PAnsiChar; offset: DWORD; flags: DWORD; proc: DOWNLOADPROC; user: Pointer): HSTREAM; stdcall; external bassflacdll;
function BASS_FLAC_StreamCreateFileUser(system, flags: DWORD; var procs: BASS_FILEPROCS; user: Pointer): HSTREAM; stdcall; external bassflacdll;

implementation

end.
