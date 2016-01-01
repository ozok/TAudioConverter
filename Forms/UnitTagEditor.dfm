object TagEditorForm: TTagEditorForm
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Tag Editor'
  ClientHeight = 409
  ClientWidth = 635
  Color = 13353918
  DoubleBuffered = True
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
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    635
    409)
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 8
    Top = 381
    Width = 328
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'Source file won'#39't be edited, values here will be applied to outp' +
      'ut file.'
    ExplicitTop = 382
  end
  object TagList: TsListView
    Left = 8
    Top = 8
    Width = 619
    Height = 362
    SkinData.SkinSection = 'EDIT'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 15921906
    Columns = <
      item
        Caption = 'Tag Field'
      end
      item
        Caption = 'Tag Value'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLines = True
    HideSelection = False
    RowSelect = True
    ParentFont = False
    StateImages = sAlphaImageList1
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = TagListClick
  end
  object CancelBtn: TsBitBtn
    Left = 360
    Top = 376
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = CancelBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object SaveBtn: TsBitBtn
    Left = 542
    Top = 376
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    TabOrder = 2
    OnClick = SaveBtnClick
    SkinData.SkinSection = 'BUTTON'
  end
  object TagEditEdit: TsEdit
    Left = 264
    Top = 216
    Width = 121
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Visible = False
    OnExit = TagEditEditExit
    OnKeyDown = TagEditEditKeyDown
    OnMouseLeave = TagEditEditMouseLeave
    SkinData.SkinSection = 'EDIT'
  end
  object ApplyBtn: TsBitBtn
    Left = 451
    Top = 376
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Apply'
    TabOrder = 4
    OnClick = ApplyBtnClick
    SkinData.SkinSection = 'BUTTON'
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
    Left = 280
    Top = 136
  end
  object sAlphaImageList1: TsAlphaImageList
    Height = 21
    Width = 1
    Items = <>
    Left = 312
    Top = 208
  end
end
