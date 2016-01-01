object CodecSettingsForm: TCodecSettingsForm
  Left = 0
  Top = 0
  Anchors = [akLeft]
  BorderStyle = bsToolWindow
  Caption = 'Codec Settings'
  ClientHeight = 446
  ClientWidth = 424
  Color = 13353918
  DoubleBuffered = True
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    424
    446)
  PixelsPerInch = 96
  TextHeight = 13
  object LossyWAVEncoderOptBtn: TsCheckBox
    Left = 215
    Top = 384
    Width = 200
    Height = 19
    Hint = 
      'Options to set blocksize to 512 will be passed to encoders that ' +
      ' support it'
    Caption = 'Extra encoder options for lossyWAV'
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object LossyWAVQualityList: TsComboBox
    Left = 96
    Top = 383
    Width = 113
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'lossyWAV:'
    SkinData.SkinSection = 'COMBOBOX'
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = 15921906
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 1
    Text = 'Don'#39't use'
    OnChange = LossyWAVQualityListChange
    Items.Strings = (
      'Don'#39't use'
      'Insane'
      'Extreme'
      'High'
      'Standart'
      'Economic'
      'Portable'
      'Extraportable')
  end
  object sBitBtn1: TsBitBtn
    Left = 294
    Top = 413
    Width = 122
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 2
    OnClick = sBitBtn1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object GroupBox1: TsGroupBox
    Left = 8
    Top = 8
    Width = 408
    Height = 281
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Encoder Options'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 3
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    DesignSize = (
      408
      281)
    object CodecPages: TsPageControl
      Left = 6
      Top = 16
      Width = 394
      Height = 225
      ActivePage = sTabSheet7
      Anchors = [akLeft, akTop, akRight, akBottom]
      Style = tsFlatButtons
      TabOrder = 0
      SkinData.SkinSection = 'PAGECONTROL'
      object sTabSheet1: TsTabSheet
        Caption = 'FDKAAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object FDKBitrateEdit: TsSpinEdit
          Left = 128
          Top = 90
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object FDKGaplessList: TsComboBox
          Left = 88
          Top = 36
          Width = 177
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Gapless:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'iTunSMPB'
          Items.Strings = (
            'iTunSMPB'
            'ISO standard (edts + sgpd)'
            'Both')
        end
        object FDKMethodList: TsComboBox
          Left = 128
          Top = 63
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Method:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          Text = 'CBR'
          OnChange = FDKMethodListChange
          Items.Strings = (
            'CBR'
            'VBR')
        end
        object FDKProfileList: TsComboBox
          Left = 88
          Top = 8
          Width = 174
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Profile:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 3
          Text = 'MPEG-4 AAC LC'
          Items.Strings = (
            'MPEG-4 AAC LC'
            'MPEG-4 HE-AAC (SBR)'
            'MPEG-4 HE-AAC v2 (SBR+PS)'
            'MPEG-4 AAC LD'
            'MPEG-4 AAC ELD'
            'MPEG-2 AAC LC'
            'MPEG-2 HE-AAC (SBR)'
            'MPEG-2 HE-AAC v2 (SBR+PS)')
        end
        object FDKVBRBar: TsTrackBar
          Left = 39
          Top = 145
          Width = 226
          Height = 25
          Max = 5
          Min = 1
          Position = 3
          TabOrder = 4
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = FDKVBRBarChange
          SkinData.SkinSection = 'TRACKBAR'
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object FDKVBREdit: TsEdit
          Left = 128
          Top = 117
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '3'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'VBR:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object FDKVBRBitEdit: TsEdit
          Left = 210
          Top = 118
          Width = 125
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '48-56 kbps/channel'
          SkinData.SkinSection = 'EDIT'
        end
      end
      object sTabSheet2: TsTabSheet
        Caption = 'FFMpeg AAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object FAACBitrateEdit: TsComboBox
          Left = 88
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 7
          ParentFont = False
          TabOrder = 0
          Text = '128'
          Items.Strings = (
            '12'
            '32'
            '48'
            '64'
            '80'
            '96'
            '112'
            '128'
            '160'
            '192'
            '224'
            '256'
            '320'
            '620')
        end
      end
      object sTabSheet3: TsTabSheet
        Caption = 'FHGAAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sLabel2: TsLabel
          Left = 48
          Top = 116
          Width = 217
          Height = 13
          Cursor = crHandPoint
          Caption = 'Due copyright issues some files are removed.'
          ParentFont = False
          OnClick = sLabel2Click
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object FHGBitrateEdit: TsSpinEdit
          Left = 137
          Top = 62
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 576
          MinValue = 8
          Value = 128
        end
        object FHGMethodList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Mode:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'CBR'
          OnChange = FHGMethodListChange
          Items.Strings = (
            'CBR'
            'VBR')
        end
        object FHGProfileList: TsComboBox
          Left = 137
          Top = 89
          Width = 75
          Height = 21
          Alignment = taCenter
          BoundLabel.Active = True
          BoundLabel.Caption = 'Profile:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          Text = 'Auto'
          Items.Strings = (
            'Auto'
            'LC'
            'HE'
            'HEV2')
        end
        object FHGQualityEdit: TsSpinEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Hint = 'Higher value means higher quality but larger file'
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 3
          Text = '6'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 6
          MinValue = 1
          Value = 6
        end
      end
      object sTabSheet4: TsTabSheet
        Caption = 'NeroAAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sLabel4: TsLabel
          Left = 0
          Top = 181
          Width = 386
          Height = 13
          Align = alBottom
          Caption = 'Copy NeroAACEnc.exe next to TAudioConverter.exe.'
          ExplicitWidth = 260
        end
        object NeroBitrateEdit: TsSpinEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object NeroMethodList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Method:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Quality'
          OnChange = NeroMethodListChange
          Items.Strings = (
            'Quality'
            'Bitrate'
            'CBR')
        end
        object NeroProfileList: TsComboBox
          Left = 137
          Top = 119
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Profile:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          Text = 'Auto'
          Items.Strings = (
            'Auto'
            'LC'
            'HE'
            'HEv2')
        end
        object NeroQualityBar: TsTrackBar
          Left = 48
          Top = 88
          Width = 217
          Height = 25
          Hint = 'Bigger value: higher quality but larger file'
          Max = 100
          Position = 50
          TabOrder = 3
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = NeroQualityBarChange
          SkinData.SkinSection = 'TRACKBAR'
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object NeroQualityEdit: TsEdit
          Left = 137
          Top = 61
          Width = 75
          Height = 21
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '50'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
      end
      object sTabSheet5: TsTabSheet
        Caption = 'QAAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object sLabel5: TsLabel
          Left = 193
          Top = 94
          Width = 71
          Height = 13
          Caption = '(2 - Best/Slow)'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object QaacBitrateEdit: TsSpinEdit
          Left = 137
          Top = 62
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object QaacEncodeMethodList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Mode:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'ABR'
          OnChange = QaacEncodeMethodListChange
          Items.Strings = (
            'ABR'
            'TVBR'
            'CVBR'
            'CBR')
        end
        object QaacHEBtn: TsCheckBox
          Left = 137
          Top = 116
          Width = 93
          Height = 19
          Caption = 'HE AAC mode'
          TabOrder = 2
          OnClick = QaacHEBtnClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object QaacNoDelayBtn: TsCheckBox
          Left = 137
          Top = 141
          Width = 69
          Height = 19
          Caption = 'No delay'
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object QaacQualityList: TsComboBox
          Left = 137
          Top = 89
          Width = 50
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 2
          ParentFont = False
          TabOrder = 4
          Text = '2'
          Items.Strings = (
            '0'
            '1'
            '2')
        end
        object QaacvQualityEdit: TsSpinEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 5
          Text = '64'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'TVBR:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          EditorEnabled = False
          MaxValue = 127
          MinValue = 0
          Value = 64
        end
      end
      object sTabSheet6: TsTabSheet
        Caption = 'AC3'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object AftenBitrateEdit: TsSpinEdit
          Left = 137
          Top = 88
          Width = 88
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object AftenEncodeList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Mode:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 1
          ParentFont = False
          TabOrder = 1
          Text = 'CBR'
          OnChange = AftenEncodeListChange
          Items.Strings = (
            'Quality'
            'CBR')
        end
        object AftenQualityBar: TsTrackBar
          Left = 39
          Top = 30
          Width = 226
          Height = 25
          Max = 1023
          Position = 240
          TabOrder = 2
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = AftenQualityBarChange
          SkinData.SkinSection = 'TRACKBAR'
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object AftenQualityEdit: TsEdit
          Left = 137
          Top = 61
          Width = 88
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Text = '240'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object AftenDialogEdit: TsSpinEdit
          Left = 168
          Top = 115
          Width = 57
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 4
          Text = '-31'
          SkinData.SkinSection = 'EDIT'
          EditorEnabled = False
          MaxValue = -1
          MinValue = -31
          Value = -31
        end
        object AftenDialogBtn: TsCheckBox
          Left = 3
          Top = 116
          Width = 159
          Height = 19
          Caption = 'Dialogue Normalization(dB):'
          TabOrder = 5
          OnClick = AftenDialogBtnClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sTabSheet7: TsTabSheet
        Caption = 'LAME'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object LameBitrateEdit: TsSpinEdit
          Left = 137
          Top = 92
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object LameChannelList: TsComboBox
          Left = 136
          Top = 168
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Channels:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Auto'
          Items.Strings = (
            'Auto'
            'Simple stereo'
            'Joint stereo'
            'Forced MS stereo'
            'Dual mono'
            'Mono'
            'Left only'
            'Right only')
        end
        object LameEncodeList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Mode:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          Text = 'CBR'
          OnChange = LameEncodeListChange
          Items.Strings = (
            'CBR'
            'ABR'
            'VBR')
        end
        object LameQualityEdit: TsSpinEdit
          Left = 136
          Top = 116
          Width = 75
          Height = 21
          Hint = '0-Best/Slow'
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 3
          Text = '2'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Algorithm quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 9
          MinValue = 0
          Value = 2
        end
        object LameTagList: TsComboBox
          Left = 136
          Top = 141
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Tags:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 4
          Text = 'Create Both'
          Items.Strings = (
            'Create Both'
            'Id3v1 Only'
            'Id3v2 Only')
        end
        object LameUseTTaggerBtn: TsCheckBox
          Left = 263
          Top = 143
          Width = 88
          Height = 19
          Hint = 
            'Use TTagger instead of Lame. Better unicode handling but may cau' +
            'se  incompatibility'
          Caption = 'Use TTagger'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 5
          OnClick = LameUseTTaggerBtnClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object LameVBRBar: TsTrackBar
          Left = 39
          Top = 61
          Width = 226
          Height = 25
          DoubleBuffered = False
          Max = 900
          ParentDoubleBuffered = False
          Position = 200
          ShowSelRange = False
          TabOrder = 6
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = LameVBRBarChange
          SkinData.SkinSection = 'TRACKBAR'
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object LameVBREdit: TsEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = '2,00'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'VBR:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
      end
      object sTabSheet8: TsTabSheet
        Caption = 'MPC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          386
          194)
        object sLabel1: TsLabel
          Left = 0
          Top = 11
          Width = 77
          Height = 13
          Caption = 'Quality (0 - 10):'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel3: TsLabel
          Left = 64
          Top = 35
          Width = 273
          Height = 13
          Caption = 
            'Low Quality                                                     ' +
            'High Quality'
        end
        object MPCQualityBar: TsTrackBar
          Left = 83
          Top = 6
          Width = 241
          Height = 23
          Hint = 'Bigger means higher quality but larger file size'
          Anchors = [akLeft, akTop, akRight]
          Max = 1000
          Position = 500
          ShowSelRange = False
          TabOrder = 0
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = MPCQualityBarChange
          SkinData.SkinSection = 'TRACKBAR'
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object MPCQualityEdit: TsEdit
          Left = 330
          Top = 7
          Width = 50
          Height = 21
          Alignment = taCenter
          Anchors = [akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '5.00'
          SkinData.SkinSection = 'EDIT'
        end
      end
      object sTabSheet9: TsTabSheet
        Caption = 'OGG'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object OggBitrateEdit: TsSpinEdit
          Left = 137
          Top = 62
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          OnChange = OggBitrateEditChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object OggencodeList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Mode:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Quality'
          OnChange = OggencodeListChange
          Items.Strings = (
            'Quality'
            'Bitrate')
        end
        object OggManagedBitrateBtn: TsCheckBox
          Left = 218
          Top = 64
          Width = 106
          Height = 19
          Caption = 'Managed bitrate'
          TabOrder = 2
          OnClick = OggManagedBitrateBtnClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object OggMaxBitrateEdit: TsSpinEdit
          Left = 137
          Top = 116
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 3
          Text = '160'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Maximum Bitrate:'
          MaxValue = 0
          MinValue = 0
          Value = 160
        end
        object OggMinBitrateEdit: TsSpinEdit
          Left = 137
          Top = 89
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 4
          Text = '112'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Minimum Bitrate:'
          MaxValue = 0
          MinValue = 0
          Value = 112
        end
        object OggQualityEdit: TsSpinEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Hint = '- 2 Low, 10 High quality'
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 5
          Text = '6'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 10
          MinValue = -2
          Value = 6
        end
        object OggUseTTaggerBtn: TsCheckBox
          Left = 137
          Top = 143
          Width = 159
          Height = 19
          Caption = 'Use TTagger for tag writing'
          TabOrder = 6
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sTabSheet10: TsTabSheet
        Caption = 'Opus'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object OpusBitrateEdit: TsSpinEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 512
          MinValue = 0
          Value = 128
        end
        object OpusCompEdit: TsSpinEdit
          Left = 137
          Top = 62
          Width = 75
          Height = 21
          Hint = 'Higher complexity means longer encoding time'
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 1
          Text = '8'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Complexity:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 10
          MinValue = 0
          Value = 8
        end
        object OpusEncodeMethodList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Method:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          Text = 'VBR'
          Items.Strings = (
            'VBR'
            'CVBR'
            'CBR')
        end
        object OpusUseTTaggerBtn: TsCheckBox
          Left = 137
          Top = 89
          Width = 159
          Height = 19
          Caption = 'Use TTagger for tag writing'
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sTabSheet11: TsTabSheet
        Caption = 'WMA'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object WMABitrateEdit: TsSpinEdit
          Left = 137
          Top = 62
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '128'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 0
          MinValue = 0
          Value = 128
        end
        object WMACodecList: TsComboBox
          Left = 137
          Top = 89
          Width = 100
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Codec:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Standard'
          Items.Strings = (
            'Standard'
            'Professional'
            'Lossless'
            'Voice')
        end
        object WMAMethodList: TsComboBox
          Left = 136
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Encoding Method:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 1
          ParentFont = False
          TabOrder = 2
          Text = 'Bitrate'
          OnChange = WMAMethodListChange
          Items.Strings = (
            'Quality'
            'Bitrate')
        end
        object WMAQualityList: TsComboBox
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Alignment = taCenter
          BoundLabel.Active = True
          BoundLabel.Caption = 'Quality:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 3
          ParentFont = False
          TabOrder = 3
          Text = '75'
          Items.Strings = (
            '10'
            '25'
            '50'
            '75'
            '90'
            '98')
        end
      end
      object sTabSheet21: TsTabSheet
        Caption = 'dcaebc'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DCABitrateBar: TsTrackBar
          Left = 129
          Top = 6
          Width = 251
          Height = 25
          Max = 4096
          Min = 32
          Position = 1504
          ShowSelRange = False
          TabOrder = 0
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = DCABitrateBarChange
          SkinData.SkinSection = 'TRACKBAR'
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object DCABitrateEdit: TsSpinEdit
          Left = 48
          Top = 8
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 1
          Text = '1504'
          OnChange = DCABitrateEditChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          MaxValue = 4096
          MinValue = 32
          Value = 1504
        end
      end
      object sTabSheet12: TsTabSheet
        Caption = 'ALAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object AlacPanel: TsPanel
          Left = 0
          Top = 0
          Width = 386
          Height = 194
          Align = alClient
          BevelOuter = bvNone
          Caption = 'No Options'
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
        end
      end
      object sTabSheet13: TsTabSheet
        Caption = 'FLAC'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object FLACCompList: TsComboBox
          Left = 137
          Top = 8
          Width = 128
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Compression Lvl:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 5
          ParentFont = False
          TabOrder = 0
          Text = '5 - Default'
          Items.Strings = (
            '0 - Worst'
            '1'
            '2'
            '3'
            '4'
            '5 - Default'
            '6'
            '7'
            '8 - Best')
        end
        object FLACEMSBtn: TsCheckBox
          Left = 56
          Top = 35
          Width = 146
          Height = 19
          Caption = 'Exhaustive model search'
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object FLACUseTTaggerBtn: TsCheckBox
          Left = 56
          Top = 60
          Width = 144
          Height = 19
          Hint = 
            'TTagger has more options but can cause problems with some system' +
            's'
          Caption = 'Use TTagger for tagging'
          Checked = True
          State = cbChecked
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object FLACVerifyBtn: TsCheckBox
          Left = 56
          Top = 85
          Width = 55
          Height = 19
          Caption = 'Verify'
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sTabSheet14: TsTabSheet
        Caption = 'FLACCL'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object FLACCLLevelList: TsComboBox
          Left = 137
          Top = 8
          Width = 89
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Compression Level:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 7
          ParentFont = False
          TabOrder = 0
          Text = '7'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11')
        end
        object FLACCLUseTTaggerBtn: TsCheckBox
          Left = 56
          Top = 35
          Width = 144
          Height = 19
          Caption = 'Use TTagger for tagging'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sTabSheet15: TsTabSheet
        Caption = 'APE'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object MACLevelList: TsComboBox
          Left = 137
          Top = 8
          Width = 100
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Compression Lvl:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 1
          ParentFont = False
          TabOrder = 0
          Text = 'Normal'
          Items.Strings = (
            'Fast'
            'Normal'
            'High'
            'Extra'
            'Insane')
        end
      end
      object sTabSheet16: TsTabSheet
        Caption = 'TAK'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object TAKLevelList: TsComboBox
          Left = 137
          Top = 85
          Width = 145
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Evaluation level:'
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'None'
          Items.Strings = (
            'None'
            'Extra'
            'Max')
        end
        object TAKMd5Btn: TsCheckBox
          Left = 137
          Top = 35
          Width = 177
          Height = 19
          Caption = 'Add MD5 of the raw wave data'
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object TAKPresetList: TsComboBox
          Left = 137
          Top = 8
          Width = 100
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Preset:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 4
          ParentFont = False
          TabOrder = 2
          Text = '4 - Strongest'
          Items.Strings = (
            '0 - Fastest'
            '1'
            '2'
            '3'
            '4 - Strongest')
        end
        object TAKVerifyBtn: TsCheckBox
          Left = 137
          Top = 60
          Width = 218
          Height = 19
          Caption = 'Verify encoded frames (when encoding)'
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object sTabSheet17: TsTabSheet
        Caption = 'TTA'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object TTAPanel: TsPanel
          Left = 0
          Top = 0
          Width = 386
          Height = 194
          Align = alClient
          BevelOuter = bvNone
          Caption = 'No options'
          Color = 15790320
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
        end
      end
      object sTabSheet18: TsTabSheet
        Caption = 'WavPack'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object WavPackBitrateEdit: TsSpinEdit
          Left = 137
          Top = 35
          Width = 75
          Height = 21
          Alignment = taCenter
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          Text = '256'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Bitrate:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          MaxValue = 9600
          MinValue = 24
          Value = 256
        end
        object WavPackCorrectionBtn: TsCheckBox
          Left = 115
          Top = 62
          Width = 128
          Height = 19
          Caption = 'Create correction file'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object WavPackExtraBtn: TsCheckBox
          Left = 115
          Top = 87
          Width = 145
          Height = 19
          Caption = 'Extra encode processing'
          Checked = True
          State = cbChecked
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object WavPackMethodList: TsComboBox
          Left = 137
          Top = 8
          Width = 75
          Height = 21
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Mode:'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clBlack
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csDropDownList
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 3
          Text = 'Lossless'
          OnChange = WavPackMethodListChange
          Items.Strings = (
            'Lossless'
            'Hybrid')
        end
      end
      object sTabSheet19: TsTabSheet
        Caption = 'WAV'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object WavePanel: TsPanel
          Left = 0
          Top = 0
          Width = 386
          Height = 194
          Align = alClient
          BevelOuter = bvNone
          Caption = 'No options'
          Color = 14870243
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
        end
      end
      object sTabSheet20: TsTabSheet
        Caption = 'AIFF'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object AiffPanel: TsPanel
          Left = 0
          Top = 0
          Width = 386
          Height = 194
          Align = alClient
          BevelOuter = bvNone
          Caption = 'No options'
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
        end
      end
    end
    object CustomCodecOptionsEdit: TsEdit
      Left = 88
      Top = 247
      Width = 311
      Height = 21
      Color = 15921906
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'Custom options:'
    end
  end
  object sGroupBox1: TsGroupBox
    Left = 8
    Top = 295
    Width = 408
    Height = 82
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Decoder Options'
    TabOrder = 4
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    object BitDepthList: TsComboBox
      Left = 88
      Top = 20
      Width = 113
      Height = 21
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Bit Depth:'
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = 15921906
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Original'
      Items.Strings = (
        'Original'
        '16'
        '24'
        '32')
    end
    object ChannelList: TsComboBox
      Left = 88
      Top = 47
      Width = 113
      Height = 21
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Channels:'
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = 15921906
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = 'Original'
      Items.Strings = (
        'Original'
        'Mono'
        'Stereo'
        '5.1')
    end
    object SampleList: TsComboBox
      Left = 286
      Top = 20
      Width = 113
      Height = 21
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Sampling rate:'
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csDropDownList
      Color = 15921906
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Original'
      Items.Strings = (
        'Original'
        '48000'
        '44100'
        '32000'
        '22050'
        '11025'
        '8000'
        '96000'
        '192000')
    end
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
    Left = 344
    Top = 88
  end
end
