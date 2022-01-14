object frmEDetails: TfrmEDetails
  Left = 0
  Top = 0
  Caption = 'frmEDetails'
  ClientHeight = 331
  ClientWidth = 436
  Color = clWhite
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
  object Label1: TLabel
    Left = 56
    Top = 46
    Width = 24
    Height = 13
    Caption = 'ID E:'
  end
  object Label2: TLabel
    Left = 56
    Top = 102
    Width = 47
    Height = 13
    Caption = 'Firstname'
  end
  object Label3: TLabel
    Left = 56
    Top = 158
    Width = 46
    Height = 13
    Caption = 'Lastname'
  end
  object Label4: TLabel
    Left = 56
    Top = 214
    Width = 66
    Height = 13
    Caption = 'Email Address'
  end
  object Label5: TLabel
    Left = 256
    Top = 46
    Width = 32
    Height = 13
    Caption = 'Hours:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 436
    Height = 43
    Align = alBottom
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object btnCancel: TButton
      Left = 342
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnSave: TButton
      Left = 254
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object Panel2: TPanel
      Left = 184
      Top = 32
      Width = 185
      Height = 41
      Caption = 'Panel2'
      TabOrder = 0
    end
  end
  object EIdEdit: TEdit
    Left = 144
    Top = 43
    Width = 73
    Height = 21
    MaxLength = 3
    TabOrder = 1
    OnChange = EIdEditChange
  end
  object EFirstnameEdit: TEdit
    Left = 144
    Top = 99
    Width = 233
    Height = 21
    TabOrder = 3
  end
  object ELastnameEdit: TEdit
    Left = 144
    Top = 155
    Width = 233
    Height = 21
    TabOrder = 4
  end
  object EEmailEdit: TEdit
    Left = 144
    Top = 211
    Width = 233
    Height = 21
    TabOrder = 5
  end
  object EHoursEdit: TEdit
    Left = 304
    Top = 43
    Width = 73
    Height = 21
    TabOrder = 2
  end
  object btnActive: TCheckBox
    Left = 56
    Top = 261
    Width = 97
    Height = 17
    Caption = 'Inactivo'
    TabOrder = 6
    OnClick = btnActiveClick
  end
end
