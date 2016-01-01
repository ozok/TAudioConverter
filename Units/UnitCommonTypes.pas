unit UnitCommonTypes;

interface

uses
  Generics.Collections;

type
  TEncoderType = (etFDKAAC = 0, etFFMpegAAC = 1, etFHGAAC = 2, etNeroAAC = 3, etQAAC = 4, etFFMpegAC3 = 5, etLAME = 6, etMPC = 7, etOgg = 8, etOpus = 9, etWMA = 10, etFFmpegALAC = 11, etFLAC = 12, etFLACCL = 13, etAPE = 14, etTAK = 15, etTTA = 16, etWavPack = 17, etAIFF = 18, etWAV = 19, etDCA = 20, etFFMpeg = 21, etSox = 22, etLossyWAV = 23, etTTagger = 24, etAACGain = 25, etVorbisGain = 26, etMP3Gain = 27, etMetaFlac = 28, etMPCGain = 29, etWVGain = 30, etLyricDownloader = 31, etAtomicParsley = 32, etRenameTool);

  TEncoderTypeList = TList<TEncoderType>;

implementation

end.

