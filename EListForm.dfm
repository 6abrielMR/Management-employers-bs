object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 491
  ClientWidth = 829
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 450
    Width = 829
    Height = 41
    Align = alBottom
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object btnCreate: TButton
      Left = 480
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 0
      OnClick = btnCreateClick
    end
    object btnUpdate: TButton
      Left = 568
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Update'
      TabOrder = 1
      OnClick = btnUpdateClick
    end
    object btnDelete: TButton
      Left = 656
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnClose: TButton
      Left = 737
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object btnGraphics: TButton
      Left = 392
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Graphics'
      TabOrder = 4
      OnClick = btnGraphicsClick
    end
    object btnExport: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Export'
      TabOrder = 5
      OnClick = btnExportClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 41
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 14
      Width = 37
      Height = 13
      Caption = 'Search:'
    end
    object ESearchEdit: TEdit
      Left = 67
      Top = 11
      Width = 214
      Height = 21
      TabOrder = 0
      OnChange = ESearchEditChange
    end
    object btnRefresh: TButton
      Left = 737
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Valid Hours'
      TabOrder = 1
      OnClick = btnRefreshClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 829
    Height = 409
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'firstname'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lastname'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'email'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hours'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'active'
        Width = 64
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = DataModule1.FDQuery1
    Left = 16
    Top = 456
  end
end
