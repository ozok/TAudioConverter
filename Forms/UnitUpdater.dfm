object UpdaterForm: TUpdaterForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Update Checker'
  ClientHeight = 436
  ClientWidth = 794
  Color = 13353918
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    794
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object ChangeList: TsListBox
    Left = 8
    Top = 16
    Width = 778
    Height = 381
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    BoundLabel.Active = True
    BoundLabel.Caption = 'What'#39's new:'
    BoundLabel.Layout = sclTopLeft
    SkinData.SkinSection = 'EDIT'
  end
  object HomeBtn: TsBitBtn
    Left = 578
    Top = 403
    Width = 208
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Download the latest version'
    TabOrder = 1
    OnClick = HomeBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object UpdateThread: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = True
    FreeOnTerminate = True
    OnExecute = UpdateThreadExecute
    Left = 192
    Top = 88
  end
  object Downloader: TJvHttpUrlGrabber
    FileName = 'output.txt'
    OutputMode = omStream
    Agent = 'JEDI-VCL'
    Port = 0
    ProxyAddresses = 'proxyserver'
    ProxyIgnoreList = '<local>'
    OnDoneStream = DownloaderDoneStream
    Left = 280
    Top = 88
  end
  object WNDownloader: TJvHttpUrlGrabber
    FileName = 'output.txt'
    OutputMode = omStream
    Agent = 'JEDI-VCL'
    Port = 0
    ProxyAddresses = 'proxyserver'
    ProxyIgnoreList = '<local>'
    OnDoneStream = WNDownloaderDoneStream
    Left = 472
    Top = 80
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
    Left = 104
    Top = 184
  end
end
