object ComponentsForm: TComponentsForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Components'
  ClientHeight = 566
  ClientWidth = 557
  Color = 13353918
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    557
    566)
  PixelsPerInch = 96
  TextHeight = 13
  object ComponentsList: TsListView
    Left = 8
    Top = 8
    Width = 541
    Height = 519
    SkinData.SkinSection = 'EDIT'
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 15921906
    Columns = <
      item
        Caption = 'Component Name'
      end
      item
        Caption = 'Version'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object sButton1: TsButton
    Left = 449
    Top = 533
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = sButton1Click
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
    Left = 440
    Top = 96
  end
end
