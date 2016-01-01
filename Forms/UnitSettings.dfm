object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings [ESC to close]'
  ClientHeight = 235
  ClientWidth = 645
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
  PixelsPerInch = 96
  TextHeight = 13
  object SettingsPage: TsPageControl
    Left = 0
    Top = 0
    Width = 645
    Height = 235
    ActivePage = sTabSheet1
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    object sTabSheet1: TsTabSheet
      Caption = 'General'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sLabel3: TsLabel
        Left = 8
        Top = 97
        Width = 597
        Height = 13
        Caption = 
          'TAC will delete everything in temp folder, regardless of their e' +
          'xtension! Don'#39't select a folder with files in it!'
        Color = 13353918
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        UseSkinColor = False
      end
      object CheckUpdateBtn: TsCheckBox
        Left = 8
        Top = 14
        Width = 154
        Height = 19
        Caption = 'Check updates on start up'
        Checked = True
        State = cbChecked
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ResetTmpBtn: TsButton
        Left = 546
        Top = 70
        Width = 75
        Height = 21
        Caption = 'Reset'
        TabOrder = 1
        OnClick = ResetTmpBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object SeeLogBtn: TsButton
        Left = 465
        Top = 8
        Width = 155
        Height = 25
        Caption = 'See Logs'
        TabOrder = 2
        OnClick = SeeLogBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object SelectTmpBtn: TsButton
        Left = 465
        Top = 70
        Width = 75
        Height = 21
        Caption = 'Browse'
        TabOrder = 3
        OnClick = SelectTmpBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object ShellRegisterBtn: TsButton
        Left = 8
        Top = 39
        Width = 156
        Height = 25
        Caption = 'Register shell extension'
        TabOrder = 4
        OnClick = ShellRegisterBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object ShellUnregisterBtn: TsButton
        Left = 170
        Top = 39
        Width = 156
        Height = 25
        Caption = 'Unregister shell extension'
        TabOrder = 5
        OnClick = ShellUnregisterBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object TempEdit: TsEdit
        Left = 80
        Top = 70
        Width = 379
        Height = 21
        Color = 15921906
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Temp Folder:'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clBlack
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
      end
      object PlayWavBtn: TsCheckBox
        Left = 8
        Top = 116
        Width = 198
        Height = 19
        Caption = 'Play a sound after encoding is done'
        Checked = True
        State = cbChecked
        TabOrder = 7
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object RevertDefBtn: TsCheckBox
        Left = 8
        Top = 141
        Width = 315
        Height = 19
        Caption = 'Revert to default output folder if output folder doesn'#39't exist'
        TabOrder = 8
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sTabSheet2: TsTabSheet
      Caption = 'Encoding'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        637
        207)
      object AACExtList: TsComboBox
        Left = 457
        Top = 65
        Width = 156
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'AAC extension:'
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
        Text = 'M4A'
        Items.Strings = (
          'M4A'
          'M4B'
          'AAC'
          'MP4'
          'M4R')
      end
      object FolderStructBtn: TsCheckBox
        Left = 3
        Top = 142
        Width = 185
        Height = 19
        Caption = 'Create folder structure in output'
        Anchors = [akLeft, akBottom]
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = FolderStructBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object FolderSuffixBtn: TsCheckBox
        Left = 3
        Top = 12
        Width = 208
        Height = 19
        Caption = 'Add encoder suffix to created folders'
        Checked = True
        State = cbChecked
        TabOrder = 2
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object PostEncode2List: TsComboBox
        Left = 457
        Top = 11
        Width = 156
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Post-Encode Action:'
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
        TabOrder = 3
        Text = 'Close TAudioConverter'
        OnChange = PostEncode2ListChange
        Items.Strings = (
          'Do nothing'
          'Close TAudioConverter'
          'Open output folder'
          'Shutdown PC'
          'Restart PC'
          'Log Off')
      end
      object ProcessCountList: TsComboBox
        Left = 457
        Top = 38
        Width = 81
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Number of processes:'
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
        Text = '1'
        Items.Strings = (
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
          '11'
          '12'
          '13'
          '14'
          '15'
          '16')
      end
      object ResetProcessBtn: TsButton
        Left = 544
        Top = 38
        Width = 69
        Height = 21
        Caption = 'Reset'
        TabOrder = 5
        OnClick = ResetProcessBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object CustomFolderEdit: TsEdit
        Left = 3
        Top = 183
        Width = 254
        Height = 21
        Anchors = [akLeft, akBottom]
        Color = 15921906
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Custom output folder structure:'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clBlack
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
      end
      object FolderStructList: TsComboBox
        Left = 193
        Top = 141
        Width = 145
        Height = 21
        Anchors = [akLeft, akBottom]
        Alignment = taLeftJustify
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
        TabOrder = 8
        Text = 'Full folder tree'
        OnChange = FolderStructListChange
        Items.Strings = (
          'Full folder tree'
          'Only one parent folder'
          'Custom folder tree'
          'Custom folder depth')
      end
      object sButton1: TsButton
        Left = 544
        Top = 183
        Width = 69
        Height = 21
        Anchors = [akLeft, akBottom]
        Caption = 'Help'
        TabOrder = 9
        OnClick = sButton1Click
        SkinData.SkinSection = 'BUTTON'
      end
      object CustomFileNameEdit: TsEdit
        Left = 263
        Top = 183
        Width = 275
        Height = 21
        Anchors = [akLeft, akBottom]
        Color = 15921906
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Custom file name:'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clBlack
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
      end
      object LogEnableBtn: TsCheckBox
        Left = 3
        Top = 62
        Width = 154
        Height = 19
        Caption = 'Do not keep encoding logs'
        TabOrder = 10
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object OverWriteList: TsComboBox
        Left = 457
        Top = 92
        Width = 156
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'If file exists at output:'
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
        TabOrder = 11
        Text = 'Add index to new files'
        Items.Strings = (
          'Add index to new files'
          'Skip it'
          'Overwrite it')
      end
      object DontTrimBtn: TsCheckBox
        Left = 3
        Top = 87
        Width = 116
        Height = 19
        Caption = 'Don'#39't use trimming'
        Checked = True
        State = cbChecked
        TabOrder = 12
        OnClick = DontTrimBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ClrListAfterEncodeBtn: TsCheckBox
        Left = 3
        Top = 37
        Width = 159
        Height = 19
        Caption = 'Clear file list after encoding'
        TabOrder = 13
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object DirDepthEdit: TsSpinEdit
        Left = 344
        Top = 141
        Width = 75
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akBottom]
        Color = 15921906
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 14
        Text = '1'
        SkinData.SkinSection = 'EDIT'
        MaxValue = 0
        MinValue = 1
        Value = 1
      end
      object DecodeBtn: TsCheckBox
        Left = 3
        Top = 112
        Width = 207
        Height = 19
        Caption = 'Check if input needs decoding to wav'
        TabOrder = 15
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sTabSheet3: TsTabSheet
      Caption = 'Artwork && Tags'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sLabel4: TsLabel
        Left = 276
        Top = 156
        Width = 178
        Height = 13
        Caption = 'For embedded artwork and CD ripper'
      end
      object Artwork2Btn: TsCheckBox
        Left = 8
        Top = 62
        Width = 155
        Height = 19
        Caption = 'Copy external artwork too'
        Checked = True
        State = cbChecked
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ArtworkBtn: TsCheckBox
        Left = 8
        Top = 11
        Width = 100
        Height = 19
        Caption = 'Enable artwork'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = ArtworkBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ArtworkList: TsComboBox
        Left = 114
        Top = 9
        Width = 191
        Height = 21
        Alignment = taLeftJustify
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
        Text = 'Extract artwork to output folder'
        OnChange = ArtworkListChange
        Items.Strings = (
          'Extract artwork to output folder'
          'Embed artwork to output file')
      end
      object ArtworkPriortyList: TsComboBox
        Left = 311
        Top = 9
        Width = 172
        Height = 21
        Alignment = taLeftJustify
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
        Text = 'Embedded artwork first'
        Items.Strings = (
          'Embedded artwork first'
          'External artwork first')
      end
      object ArtworkSuffixBtn: TsCheckBox
        Left = 8
        Top = 37
        Width = 443
        Height = 19
        Caption = 
          'Add file name to artwork (i.e. 1 - song - artist.jpg) when extra' +
          'cting embedded artwork'
        TabOrder = 4
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object TagsBtn: TsCheckBox
        Left = 8
        Top = 87
        Width = 137
        Height = 19
        Caption = 'Copy tags from source'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = TagsBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ToolTagBtn: TsCheckBox
        Left = 8
        Top = 112
        Width = 164
        Height = 19
        Caption = 'Write tag tool when possible'
        TabOrder = 6
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ResizeArtworkbtn: TsCheckBox
        Left = 8
        Top = 152
        Width = 103
        Height = 19
        Caption = 'Resize artwork:'
        TabOrder = 7
        OnClick = ResizeArtworkbtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object WidthEdit: TsSpinEdit
        Left = 114
        Top = 152
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
        NumbersOnly = True
        ParentFont = False
        TabOrder = 8
        Text = '300'
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Width:'
        BoundLabel.Layout = sclTopLeft
        MaxValue = 0
        MinValue = 0
        Value = 300
      end
      object HeightEdit: TsSpinEdit
        Left = 195
        Top = 152
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
        NumbersOnly = True
        ParentFont = False
        TabOrder = 9
        Text = '300'
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Height:'
        BoundLabel.Layout = sclTopLeft
        MaxValue = 0
        MinValue = 0
        Value = 300
      end
    end
    object sTabSheet5: TsTabSheet
      Caption = 'ReplayGain'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sLabel1: TsLabel
        Left = 8
        Top = 68
        Width = 385
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Target normal level (dB)'
      end
      object ReplayGainBtn: TsCheckBox
        Left = 8
        Top = 14
        Width = 112
        Height = 19
        Caption = 'Apply ReplayGain'
        TabOrder = 0
        OnClick = ReplayGainBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ReplayGainBar: TsTrackBar
        Left = 3
        Top = 39
        Width = 390
        Height = 23
        Enabled = False
        Max = 1000
        Min = 750
        Position = 890
        ShowSelRange = False
        TabOrder = 1
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = ReplayGainBarChange
        SkinData.SkinSection = 'TRACKBAR'
        BarOffsetV = 0
        BarOffsetH = 0
      end
      object ReplayGainEdit: TsEdit
        Left = 399
        Top = 41
        Width = 50
        Height = 21
        Alignment = taCenter
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '89.0'
        SkinData.SkinSection = 'EDIT'
      end
      object RGResetBtn: TsButton
        Left = 8
        Top = 95
        Width = 75
        Height = 25
        Caption = 'Reset'
        TabOrder = 3
        OnClick = RGResetBtnClick
        SkinData.SkinSection = 'BUTTON'
      end
      object RGAutoLowerBtn: TsCheckBox
        Left = 455
        Top = 43
        Width = 172
        Height = 19
        Caption = 'Auto lower to prevent clipping'
        Enabled = False
        TabOrder = 4
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object RGLToLBtn: TsCheckBox
        Left = 8
        Top = 126
        Width = 239
        Height = 19
        Caption = 'Copy to lossless output from lossless source'
        TabOrder = 5
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sTabSheet4: TsTabSheet
      Caption = 'File Adding'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sLabel2: TsLabel
        Left = 373
        Top = 40
        Width = 177
        Height = 13
        Caption = 'seconds (Doesn'#39't include cue sheets)'
      end
      object IgnoreCueBtn: TsCheckBox
        Left = 3
        Top = 12
        Width = 201
        Height = 19
        Caption = 'Ignore cue sheets when adding files'
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object FileLenghtList: TsComboBox
        Left = 84
        Top = 37
        Width = 177
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'File length filter:'
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
        TabOrder = 1
        Text = 'Don'#39't add files shorter than:'
        OnChange = FileLenghtListChange
        Items.Strings = (
          'Add all files'
          'Don'#39't add files longer than:'
          'Don'#39't add files shorter than:')
      end
      object FileLengthEdit: TsSpinEdit
        Left = 267
        Top = 37
        Width = 100
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
        TabOrder = 2
        Text = '1800'
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Caption = 'seconds'
        BoundLabel.Layout = sclTopRight
        MaxValue = 0
        MinValue = 0
        Value = 1800
      end
      object FileExtFilterEdit: TsEdit
        Left = 3
        Top = 96
        Width = 631
        Height = 21
        Color = 15921906
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Filter out audio types (seperated with ";") (mp3;wma;wav)'
        BoundLabel.Layout = sclTopLeft
      end
      object UseMediaInfoBtn: TsCheckBox
        Left = 3
        Top = 123
        Width = 235
        Height = 19
        Caption = 'Use MediaInfo to read tags from audio files'
        TabOrder = 4
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sTabSheet6: TsTabSheet
      Caption = 'CD Ripper'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        637
        207)
      object CDParanoidBtn: TsCheckBox
        Left = 8
        Top = 39
        Width = 99
        Height = 19
        Caption = 'Paranoid mode'
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object CDJitterBtn: TsCheckBox
        Left = 8
        Top = 14
        Width = 134
        Height = 19
        Caption = 'Enable jitter detection'
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object sGroupBox1: TsGroupBox
        Left = 8
        Top = 64
        Width = 393
        Height = 80
        Caption = 'Freedb'
        TabOrder = 2
        SkinData.SkinSection = 'GROUPBOX'
        Checked = False
        object CDEmailEdit: TsEdit
          Left = 88
          Top = 17
          Width = 233
          Height = 21
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'user@tac.com'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'User email:'
        end
        object CDServerEdit: TsEdit
          Left = 88
          Top = 44
          Width = 233
          Height = 21
          Color = 15921906
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'http://Freedb.Freedb.org'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Freedb server:'
        end
        object sButton3: TsButton
          Left = 327
          Top = 17
          Width = 63
          Height = 48
          Caption = 'Reset'
          TabOrder = 2
          OnClick = sButton3Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object CDDownloadCoverBtn: TsCheckBox
        Left = 8
        Top = 150
        Width = 136
        Height = 19
        Caption = 'Download album cover'
        TabOrder = 3
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object sButton2: TsButton
        Left = 565
        Top = 108
        Width = 69
        Height = 21
        Anchors = [akLeft, akBottom]
        Caption = 'Help'
        TabOrder = 4
        Visible = False
        OnClick = sButton1Click
        SkinData.SkinSection = 'BUTTON'
      end
      object CDCustomFileNameEdit: TsEdit
        Left = 417
        Top = 81
        Width = 217
        Height = 21
        Anchors = [akLeft, akBottom]
        Color = 15921906
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Visible = False
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Custom file name:'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clBlack
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
      end
      object CDOutputFolderEdit: TsEdit
        Left = 417
        Top = 48
        Width = 217
        Height = 21
        Anchors = [akLeft, akBottom]
        Color = 15921906
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Visible = False
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Active = True
        BoundLabel.Caption = 'Custom output folder structure:'
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clBlack
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
      end
      object sCheckBox1: TsCheckBox
        Left = 417
        Top = 14
        Width = 228
        Height = 19
        Caption = 'Use following pattern to create file names'
        TabOrder = 7
        Visible = False
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object sTabSheet7: TsTabSheet
      Caption = 'Interface'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SkinBtn: TsCheckBox
        Left = 198
        Top = 13
        Width = 62
        Height = 19
        Caption = 'Disable'
        TabOrder = 0
        OnClick = SkinBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object SkinList: TsComboBox
        Left = 36
        Top = 12
        Width = 156
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Skin:'
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
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        OnChange = SkinListChange
      end
      object AlwaysTopBtn: TsCheckBox
        Left = 8
        Top = 39
        Width = 96
        Height = 19
        Caption = 'Always on top'
        TabOrder = 2
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ShowExtraColumnsBtn: TsCheckBox
        Left = 8
        Top = 64
        Width = 168
        Height = 19
        Caption = 'Show extra columns in file list'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = ShowExtraColumnsBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ShowTextToolbarBtn: TsCheckBox
        Left = 8
        Top = 89
        Width = 165
        Height = 19
        Caption = 'Show text in toolbar buttons'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = ShowTextToolbarBtnClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
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
    Left = 240
    Top = 24
  end
  object OpenDialog1: TsOpenDialog
    Left = 344
    Top = 32
  end
end
