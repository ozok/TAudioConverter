object TagForm: TTagForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Tag Editor'
  ClientHeight = 195
  ClientWidth = 464
  Color = 13353918
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    464
    195)
  PixelsPerInch = 96
  TextHeight = 13
  object ArtistEdit: TsEdit
    Left = 72
    Top = 33
    Width = 384
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = ' '
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Artist:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object AlbumEdit: TsEdit
    Left = 72
    Top = 60
    Width = 384
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = ' '
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Album:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object GenreEdit: TsEdit
    Left = 72
    Top = 114
    Width = 384
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = ' '
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Genre:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object PerformerEdit: TsEdit
    Left = 72
    Top = 87
    Width = 384
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = ' '
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Performer:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object UseValuesBtn: TsCheckBox
    Left = 8
    Top = 8
    Width = 223
    Height = 19
    Caption = 'Applying custom tags to all files in the list'
    TabOrder = 4
    OnClick = UseValuesBtnClick
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CloseBtn: TsBitBtn
    Left = 356
    Top = 162
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      00000000000000000000000000020000000C0000001E00002A32000037360000
      02200000000F0000000300000000000000000000000000000000000000000000
      0000000000000000000A000065470000ABB00000BAEC0000BBFF0000BAFF0000
      BCF40000B3C10000885E0000000E000000010000000000000000000000000000
      00000000000E00009A880000C0FA0000B2FF0002A7FF0009A5FF000BA5FF0006
      A7FF0000AFFF0000BFFF0000B1B0000032180000000100000000000000000000
      0008000099880000BAFF0002ABFF0013AAFF002CB3FF003EBBFF004AC0FF004B
      C1FF0036B8FF000BACFF0000B6FF0000B0BA0000100D00000000000000010000
      72420000B5FB0002AEFF011BACFF6682D0FF054DBFFF0061CEFF006CD4FF0069
      CEFF5C97DAFF1054C2FF0010B1FF0000B4FF00009B7500000002000000060000
      A0B20000B1FF0015B3FF788BCCFFFFFFFFFFADC6E6FF056EC9FF007CD4FF73AA
      DAFFFFFFFFFFB8CAE7FF0037B9FF0003B3FF0000ABE50000200B00001C100000
      A8F40004B7FF0031C7FF1249B5FFCDD6E8FFFFFFFFFFADC7E1FF77A4CDFFFFFF
      FFFFEDF0F6FF3268BBFF004ACCFF0011BDFF0000ADFF00008B3F0000732D0000
      A6FF000DBEFF0041D0FF005CD6FF1258B1FFCDD3E3FFFFFFFFFFFFFFFFFFEDEE
      F4FF3262ADFF0059D1FF0042D1FF0016C2FF0000ACFF0000956800007A310000
      A0FF0010BDFF0045D2FF005FDAFF005CC1FF7F8DB6FFFFFFFFFFFFFFFFFFB9BE
      D3FF0540A5FF004AD2FF002FCBFF000DBFFF0000A7FF0000906D000060160000
      99FE0009B9FF0744D1FF1155C6FF7992C4FFFFFFFFFFEEF1F7FFD4DAEAFFFFFF
      FFFFB0B8D7FF1536B1FF0C20C5FF0002BBFF0000A0FF00008A51000000030000
      8FCE0203AFFF3A58CFFF7F92CCFFFFFFFFFFF1F3F9FF5879C4FF3F64BEFFD6DB
      EEFFFFFFFFFFB2B5DCFF3738BEFF1010B9FF000095F900007914000000000000
      856500009EFF4248CAFF6E7FD1FFE2E5F6FF778BD4FF5F7CDBFF6078DCFF626D
      CCFFDBDBF2FF8888D4FF5454CDFF0303A7FF00008BA300000001000000000000
      4C0400008DC21111ABFF7A7DDAFF8289DEFF838BE1FF848AE1FF8487E1FF8484
      DFFF8181DBFF8181DCFF2929B8FF000092EA0000831B00000000000000000000
      000000007E1600008ECE1D1DAAFF8989DBFFA7A7E7FFA7A7E8FFA7A7E8FFA7A7
      E8FF9A9AE2FF3535B7FF000092EC000088370000000000000000000000000000
      00000000000000007D0B00008B89020294F43535B0FF6060C5FF6565C7FF4444
      B7FF090999FD00008DAB0000861E000000000000000000000000000000000000
      00000000000000000000000000000000840E00008E51000093790000947D0000
      905F00008B1D0000000000000000000000000000000000000000}
    TabOrder = 5
    OnClick = CloseBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object DateEdit: TsSpinEdit
    Left = 72
    Top = 141
    Width = 121
    Height = 21
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 6
    Text = '2014'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Date:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 0
    MinValue = 0
    Value = 2014
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    FormHeader.AdditionalHeight = 0
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 384
    Top = 96
  end
end
