object TrimmerForm: TTrimmerForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Trimmer'
  ClientHeight = 132
  ClientWidth = 645
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
    645
    132)
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 6
    Top = 13
    Width = 28
    Height = 13
    Caption = 'Start:'
  end
  object sLabel2: TsLabel
    Left = 8
    Top = 44
    Width = 22
    Height = 13
    Caption = 'End:'
  end
  object EndEdit: TsEdit
    Left = 562
    Top = 41
    Width = 75
    Height = 21
    TabStop = False
    Alignment = taCenter
    Anchors = [akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Text = '00:00:00.000'
    SkinData.SkinSection = 'EDIT'
  end
  object StartEdit: TsEdit
    Left = 562
    Top = 10
    Width = 75
    Height = 21
    TabStop = False
    Alignment = taCenter
    Anchors = [akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Text = '00:00:00.000'
    SkinData.SkinSection = 'EDIT'
  end
  object StartBar: TsTrackBar
    Left = 40
    Top = 8
    Width = 516
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    DoubleBuffered = False
    ParentDoubleBuffered = False
    ShowSelRange = False
    TabOrder = 0
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = StartBarChange
    SkinData.SkinSection = 'TRACKBAR'
    BarOffsetV = 0
    BarOffsetH = 0
  end
  object EndBar: TsTrackBar
    Left = 40
    Top = 39
    Width = 516
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    DoubleBuffered = False
    ParentDoubleBuffered = False
    ShowSelRange = False
    TabOrder = 1
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = EndBarChange
    SkinData.SkinSection = 'TRACKBAR'
    BarOffsetV = 0
    BarOffsetH = 0
  end
  object ResetBtn: TsBitBtn
    Left = 8
    Top = 94
    Width = 100
    Height = 30
    Anchors = [akLeft, akBottom]
    Caption = 'Reset'
    TabOrder = 4
    OnClick = ResetBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object SaveBtn: TsBitBtn
    Left = 537
    Top = 94
    Width = 100
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    TabOrder = 2
    OnClick = SaveBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object CancelBtn: TsBitBtn
    Left = 431
    Top = 94
    Width = 100
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object DurationEdit: TsEdit
    Left = 562
    Top = 68
    Width = 75
    Height = 21
    TabStop = False
    Alignment = taCenter
    Anchors = [akTop, akRight]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    Text = '00:00:00.000'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Selected duration:'
  end
  object OrigDurEdit: TsEdit
    Left = 96
    Top = 67
    Width = 75
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    Text = '00:00:00'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Original duration:'
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
    Left = 408
    Top = 56
  end
end
