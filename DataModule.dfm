object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 254
  Width = 537
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=test'
      'User_Name=postgres'
      'Password=root'
      'Server=localhost'
      'DriverID=PG')
    ConnectedStoredUsage = []
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT id,firstname,lastname,email,hours,CAST(CASE WHEN active=t' +
        'rue THEN '#39'Activado'#39' ELSE '#39'Desactivado'#39' END AS VARCHAR(60)) AS ac' +
        'tive FROM employer ORDER BY id ASC;')
    Left = 56
    Top = 104
    object FDQuery1id: TWideStringField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 16
    end
    object FDQuery1firstname: TWideStringField
      FieldName = 'firstname'
      Origin = 'firstname'
      Size = 30
    end
    object FDQuery1lastname: TWideStringField
      FieldName = 'lastname'
      Origin = 'lastname'
      Size = 30
    end
    object FDQuery1email: TWideStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 60
    end
    object FDQuery1hours: TIntegerField
      FieldName = 'hours'
      Origin = 'hours'
    end
    object FDQuery1active: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'active'
      Origin = 'active'
      ReadOnly = True
      Size = 60
    end
  end
  object InserQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT insert_update(true,%s,%s,%s,%s,%d,%s);')
    Left = 152
    Top = 104
    object InserQueryinsert_update: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'insert_update'
      Origin = 'insert_update'
      ReadOnly = True
      Size = 0
    end
  end
  object FindByIdQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM employer WHERE id = id;')
    Left = 224
    Top = 104
  end
  object UpdateQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT insert_update(false,'#39'GGG'#39','#39'gabs'#39','#39'gabc'#39','#39'gab@email.com'#39',8' +
        ');')
    Left = 152
    Top = 168
  end
  object DeleteQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'DELETE FROM employer WHERE id = '#39'BBB'#39';')
    Left = 224
    Top = 168
  end
  object GetHoursQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT firstname, hours FROM employer ORDER BY id ASC;')
    Left = 304
    Top = 104
  end
end
