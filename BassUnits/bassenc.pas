{
  BASSenc 2.4 Delphi unit
  Copyright (c) 2003-2016 Un4seen Developments Ltd.

  See the BASSENC.CHM file for more detailed documentation
}

Unit BASSenc;

interface

{$IFDEF MSWINDOWS}
uses BASS, Windows;
{$ELSE}
uses BASS;
{$ENDIF}

const
  // Additional error codes returned by BASS_ErrorGetCode
  BASS_ERROR_ACM_CANCEL         = 2000; // ACM codec selection cancelled
  BASS_ERROR_CAST_DENIED        = 2100; // access denied (invalid password)

  // Additional BASS_SetConfig options
  BASS_CONFIG_ENCODE_PRIORITY   = $10300;
  BASS_CONFIG_ENCODE_QUEUE      = $10301;
  BASS_CONFIG_ENCODE_CAST_TIMEOUT = $10310;

  // Additional BASS_SetConfigPtr options
  BASS_CONFIG_ENCODE_ACM_LOAD   = $10302;
  BASS_CONFIG_ENCODE_CAST_PROXY = $10311;

  // BASS_Encode_Start flags
  BASS_ENCODE_NOHEAD            = 1;	// don't send a WAV header to the encoder
  BASS_ENCODE_FP_8BIT           = 2;	// convert floating-point sample data to 8-bit integer
  BASS_ENCODE_FP_16BIT          = 4;	// convert floating-point sample data to 16-bit integer
  BASS_ENCODE_FP_24BIT          = 6;	// convert floating-point sample data to 24-bit integer
  BASS_ENCODE_FP_32BIT          = 8;	// convert floating-point sample data to 32-bit integer
  BASS_ENCODE_FP_AUTO           = 14;	// convert floating-point sample data back to channel's format
  BASS_ENCODE_BIGEND            = 16;	// big-endian sample data
  BASS_ENCODE_PAUSE             = 32;	// start encording paused
  BASS_ENCODE_PCM               = 64;	// write PCM sample data (no encoder)
  BASS_ENCODE_RF64              = 128;	// send an RF64 header
  BASS_ENCODE_MONO              = $100; // convert to mono (if not already)
  BASS_ENCODE_QUEUE             = $200; // queue data to feed encoder asynchronously
  BASS_ENCODE_WFEXT             = $400; // WAVEFORMATEXTENSIBLE "fmt" chunk
  BASS_ENCODE_CAST_NOLIMIT      = $1000; // don't limit casting data rate
  BASS_ENCODE_LIMIT             = $2000; // limit data rate to real-time
  BASS_ENCODE_AIFF              = $4000; // send an AIFF header rather than WAV
  BASS_ENCODE_DITHER            = $8000; // apply dither when converting floating-point sample data to integer
  BASS_ENCODE_AUTOFREE          = $40000; // free the encoder when the channel is freed

  // BASS_Encode_GetACMFormat flags
  BASS_ACM_DEFAULT              = 1; // use the format as default selection
  BASS_ACM_RATE                 = 2; // only list formats with same sample rate as the source channel
  BASS_ACM_CHANS                = 4; // only list formats with same number of channels (eg. mono/stereo)
  BASS_ACM_SUGGEST              = 8; // suggest a format (HIWORD=format tag)

  // BASS_Encode_GetCount counts
  BASS_ENCODE_COUNT_IN          = 0; // sent to encoder
  BASS_ENCODE_COUNT_OUT         = 1; // received from encoder
  BASS_ENCODE_COUNT_CAST        = 2; // sent to cast server
  BASS_ENCODE_COUNT_QUEUE       = 3; // queued
  BASS_ENCODE_COUNT_QUEUE_LIMIT = 4; // queue limit
  BASS_ENCODE_COUNT_QUEUE_FAIL  = 5; // failed to queue

  // BASS_Encode_CastInit content MIME types
  BASS_ENCODE_TYPE_MP3          = 'audio/mpeg';
  BASS_ENCODE_TYPE_OGG          = 'application/ogg';
  BASS_ENCODE_TYPE_AAC          = 'audio/aacp';

  // BASS_Encode_CastGetStats types
  BASS_ENCODE_STATS_SHOUT       = 0; // Shoutcast stats
  BASS_ENCODE_STATS_ICE         = 1; // Icecast mount-point stats
  BASS_ENCODE_STATS_ICESERV     = 2; // Icecast server stats

  // Encoder notifications
  BASS_ENCODE_NOTIFY_ENCODER    = 1; // encoder died
  BASS_ENCODE_NOTIFY_CAST       = 2; // cast server connection died
  BASS_ENCODE_NOTIFY_CAST_TIMEOUT = $10000; // cast timeout
  BASS_ENCODE_NOTIFY_QUEUE_FULL = $10001; // queue is out of space
  BASS_ENCODE_NOTIFY_FREE       = $10002; // encoder has been freed

  // BASS_Encode_ServerInit flags
  BASS_ENCODE_SERVER_NOHTTP     = 1; // no HTTP headers
  BASS_ENCODE_SERVER_META       = 2; // Shoutcast metadata

type
  HENCODE = DWORD;   // encoder handle

  ENCODEPROC = procedure(handle:HENCODE; channel:DWORD; buffer:Pointer; length:DWORD; user:Pointer); {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  {
    Encoding callback function.
    handle : The encoder
    channel: The channel handle
    buffer : Buffer containing the encoded data
    length : Number of bytes
    user   : The 'user' parameter value given when calling BASS_EncodeStart
  }

  ENCODEPROCEX = procedure(handle:HENCODE; channel:DWORD; buffer:Pointer; length:DWORD; offset:QWORD; user:Pointer); {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  {
    Encoding callback function with offset info.
    handle : The encoder
    channel: The channel handle
    buffer : Buffer containing the encoded data
    length : Number of bytes
    offset : File offset of the data
    user   : The 'user' parameter value given when calling BASS_Encode_StartCA
  }

  ENCODERPROC = function(handle:HENCODE; channel:DWORD; buffer:Pointer; length:DWORD; maxout:DWORD; user:Pointer): DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  {
    Encoder callback function.
    handle : The encoder
    channel: The channel handle
    buffer : Buffer containing the PCM data (input) and receiving the encoded data (output)
    length : Number of bytes in (-1=closing)
    maxout : Maximum number of bytes out
    user   : The 'user' parameter value given when calling BASS_Encode_StartUser
    RETURN : The amount of encoded data (-1=stop)
  }

  ENCODECLIENTPROC = function(handle:HENCODE; connect:BOOL; client:PAnsiChar; headers:PAnsiChar; user:Pointer): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  {
    Client connection notification callback function.
    handle : The encoder
    connect: TRUE/FALSE=client is connecting/disconnecting
    client : The client's address (xxx.xxx.xxx.xxx:port)
    headers: Request headers (optionally response headers on return)
    user   : The 'user' parameter value given when calling BASS_Encode_ServerInit
    RETURN : TRUE/FALSE=accept/reject connection (ignored if connect=FALSE)
  }

  ENCODENOTIFYPROC = procedure(handle:HENCODE; status:DWORD; user:Pointer); {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
  {
    Encoder death notification callback function.
    handle : The encoder
    status : Notification (BASS_ENCODE_NOTIFY_xxx)
    user   : The 'user' parameter value given when calling BASS_Encode_SetNotify
  }


const
{$IFDEF MSWINDOWS}
  bassencdll = 'bassenc.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassencdll = 'libbassenc.so';
{$ENDIF}
{$IFDEF MACOS}
  bassencdll = 'libbassenc.dylib';
{$ENDIF}

function BASS_Encode_GetVersion: DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;

function BASS_Encode_Start(handle:DWORD; cmdline:PChar; flags:DWORD; proc:ENCODEPROC; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_StartLimit(handle:DWORD; cmdline:PChar; flags:DWORD; proc:ENCODEPROC; user:Pointer; limit:DWORD): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_StartUser(handle:DWORD; filename:PChar; flags:DWORD; proc:ENCODERPROC; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_AddChunk(handle:HENCODE; id:PAnsiChar; buffer:Pointer; length:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_IsActive(handle:DWORD): DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_Stop(handle:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_SetPaused(handle:DWORD; paused:BOOL): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_Write(handle:DWORD; buffer:Pointer; length:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_SetNotify(handle:DWORD; proc:ENCODENOTIFYPROC; user:Pointer): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_GetCount(handle:HENCODE; count:DWORD): QWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_SetChannel(handle:DWORD; channel:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_GetChannel(handle:HENCODE): DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;

{$IFDEF MSWINDOWS}
function BASS_Encode_GetACMFormat(handle:DWORD; form:Pointer; formlen:DWORD; title:PChar; flags:DWORD): DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_StartACM(handle:DWORD; form:Pointer; flags:DWORD; proc:ENCODEPROC; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_StartACMFile(handle:DWORD; form:Pointer; flags:DWORD; filename:PChar): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
{$ENDIF}

{$IFDEF MACOS}
function BASS_Encode_StartCA(handle,ftype,atype,flags,bitrate:DWORD; proc:ENCODEPROCEX; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_StartCAFile(handle,ftype,atype,flags,bitrate:DWORD; filename:PChar): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
{$ENDIF}

function BASS_Encode_CastInit(handle:HENCODE; server,pass,content,name,url,genre,desc,headers:PAnsiChar; bitrate:DWORD; pub:BOOL): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_CastSetTitle(handle:HENCODE; title,url:PAnsiChar): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_CastSendMeta(handle:HENCODE; mtype:DWORD; data:Pointer; length:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_CastGetStats(handle:HENCODE; stype:DWORD; pass:PAnsiChar): PAnsiChar; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;

function BASS_Encode_ServerInit(handle:HENCODE; port:PAnsiChar; buffer,burst,flags:DWORD; proc:ENCODECLIENTPROC; user:Pointer): DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;
function BASS_Encode_ServerKick(handle:HENCODE; client:PAnsiChar): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencdll;

implementation

end.
