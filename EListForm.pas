unit EListForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, ShellAPI, IniFiles;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    btnCreate: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    Label1: TLabel;
    ESearchEdit: TEdit;
    DataSource1: TDataSource;
    btnGraphics: TButton;
    btnExport: TButton;
    btnRefresh: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnGraphicsClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ESearchEditChange(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    configFile: TIniFile;
    procedure SetGridColumnWidths(Grid: TDBGrid);
    procedure RefreshGrid;
    procedure FetchStateStl(lst: TStringList; fetchVals: Integer);
    procedure OpenFileExplorerLogs;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses DataModule, EDetailsForm, EGraphicsForm;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.btnCreateClick(Sender: TObject);
begin
  Form1.Caption := '';
  EDetailsForm.frmEDetails.Caption := configFile.ReadString('Caption',
    'Add', '');
  EDetailsForm.frmEDetails.ShowModal;
  RefreshGrid;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  with DataModule1.DeleteQuery do
  begin
    Form1.Caption := '';
    active := false;
    sql.Clear;
    sql.Text := Format(configFile.ReadString('Sql', 'Delete', 'SELECT;'),
      [QuotedStr(DBGrid1.Fields[0].Text)]);
    ExecSQL;
  end;
  ShowMessage('Deleted succesfully');
  RefreshGrid;
end;

procedure TForm1.btnExportClick(Sender: TObject);
var
  fld: TField;
  lst: TStringList;
  wasActive: Boolean;
  writer: TTextWriter;
  logFile: String;

begin
  logFile := Format(configFile.ReadString('Csv', 'LogFile', ''),
    [FormatDateTime(configFile.ReadString('Csv', 'FormatExportCsv', ''), Now)]);
  writer := TStreamWriter.Create(Format(configFile.ReadString('Csv', 'Path',
    ''), [logFile]));
  try
    lst := TStringList.Create;
    try
      FetchStateStl(lst, 0);
      wasActive := DataSource1.DataSet.active;
      try
        DataSource1.DataSet.active := true;
        DataSource1.DataSet.GetFieldNames(lst);
        FetchStateStl(lst, 2);
        writer.WriteLine(Format('%s;', [lst.DelimitedText]));
        DataSource1.DataSet.First;

        while not DataSource1.DataSet.Eof do
        begin
          FetchStateStl(lst, 1);
          for fld in DataSource1.DataSet.Fields do
            lst.Add(fld.Text);
          writer.WriteLine(Format('%s;', [lst.DelimitedText]));
          DataSource1.DataSet.Next;
        end;
      finally
        DataSource1.DataSet.active := wasActive;
      end;
    finally
      lst.Free;
    end;
  finally
    writer.Free;
    ShowMessage('Export completed!');
    OpenFileExplorerLogs;
  end;
end;

procedure TForm1.btnGraphicsClick(Sender: TObject);
var
  stl: TStringList;

begin
  with DataModule1.FDQuery1 do
  begin
    stl := TStringList.Create;
    try
      FetchStateStl(stl, 0);
      with DataModule1.GetHoursQuery do
      begin
        active := false;
        Open;
        while not Eof do
        begin
          FetchStateStl(stl, 2);
          stl.Add(Format('%s,%s', [FieldByName('firstname').AsString,
            FieldByName('hours').AsString]));
          Next;
        end;
        Close;
      end;
      EGraphicsForm.frmGraphics.Caption := configFile.ReadString('Caption',
        'Graphics', '');
      EGraphicsForm.frmGraphics.Hint := stl.DelimitedText;
      EGraphicsForm.frmGraphics.ShowModal;
    finally
      stl.Free;
    end;
  end;
end;

procedure TForm1.btnRefreshClick(Sender: TObject);
begin
  Form1.Caption := 'onBtnRefresh';
  RefreshGrid;
end;

procedure TForm1.btnUpdateClick(Sender: TObject);
begin
  Form1.Caption := '';
  EDetailsForm.frmEDetails.Caption := configFile.ReadString('Caption',
    'Update', '');
  EDetailsForm.frmEDetails.Hint := DBGrid1.Fields[0].Text;
  EDetailsForm.frmEDetails.ShowModal;
  RefreshGrid;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  f: TField;
  i: Integer;
begin
  f := Column.Field.DataSet.FieldByName('active');
  for i := 0 to DBGrid1.Columns.Count - 1 do
  begin
    DBGrid1.Columns[i].Title.Alignment := taCenter;
    DBGrid1.Columns[i].Alignment := taCenter;
  end;

  if Assigned(f) then
  begin
    if (f.Text = 'Activado') and (DataCol = 5) then
    begin
      DBGrid1.canvas.Brush.Color := $00A8DAA4;
    end
    else if (f.Text = 'Desactivado') and (DataCol = 5) then
    begin
      DBGrid1.canvas.Brush.Color := $0098A2EB;
    end
    else if (f.Text = '') and (DataCol = 5) then
    begin
      DBGrid1.canvas.Brush.Color := clSilver;
    end
    else
    begin
      DBGrid1.canvas.Brush.Color := clWhite;
    end;
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TForm1.ESearchEditChange(Sender: TObject);
begin
  Form1.Caption := '';
  RefreshGrid;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  configFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\config.ini');
  with DataModule1.FDQuery1 do
  begin
    active := false;
    active := true;
  end;
  SetGridColumnWidths(DBGrid1);

end;

procedure TForm1.SetGridColumnWidths(Grid: TDBGrid);
var
  n: Integer;
  widthColumns: Integer;
begin
  with Grid do
  begin
    widthColumns := Trunc(Grid.Width / Columns.Count) - configFile.ReadInteger
      ('Ui', 'Border', 0);
    for n := 0 to Columns.Count - 1 do
      Columns[n].Width := widthColumns;
  end;
end;

procedure TForm1.RefreshGrid;
begin
  with DataModule1.FDQuery1 do
  begin
    if (Form1.Caption = 'onBtnRefresh') then
    begin
      active := false;
      sql.Clear;
      sql.Text := configFile.ReadString('Sql', 'RefreshUsersAndData', '');
      active := true;
    end
    else
    begin
      active := false;
      sql.Clear;
      sql.Text := Format(configFile.ReadString('Sql', 'Refresh', ''),
        [QuotedStr('%' + UpperCase(Form1.ESearchEdit.Text) + '%')]);
      active := true;
    end;

  end;
  SetGridColumnWidths(DBGrid1);
end;

procedure TForm1.FetchStateStl(lst: TStringList; fetchVals: Integer);
begin
  case fetchVals of
    0:
      begin
        lst.QuoteChar := '"';
        lst.Delimiter := ';';
      end;
    1:
      begin
        lst.Clear;
        lst.Delimiter := ';';
      end;
    2:
      lst.Delimiter := ';';
  end;
end;

procedure TForm1.OpenFileExplorerLogs;
begin
  ShellExecute(Application.Handle, nil, 'explorer.exe',
    PChar(configFile.ReadString('Csv', 'DirPath', '')), nil, SW_NORMAL);
end;

end.
