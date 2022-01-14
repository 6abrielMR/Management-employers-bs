unit EDetailsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IniFiles,
  Vcl.DBCtrls, Data.DB;

type
  TfrmEDetails = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    Label1: TLabel;
    EIdEdit: TEdit;
    Label2: TLabel;
    EFirstnameEdit: TEdit;
    ELastnameEdit: TEdit;
    Label3: TLabel;
    EEmailEdit: TEdit;
    Label4: TLabel;
    EHoursEdit: TEdit;
    Label5: TLabel;
    btnActive: TCheckBox;
    Panel2: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnActiveClick(Sender: TObject);
    procedure EIdEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    configFile: TIniFile;
  end;

var
  frmEDetails: TfrmEDetails;

implementation

{$R *.dfm}

uses DataModule;

procedure TfrmEDetails.btnActiveClick(Sender: TObject);
begin
  if (btnActive.Checked) then
    btnActive.Caption := 'Activo'
  else
    btnActive.Caption := 'Inactivo';
end;

procedure TfrmEDetails.btnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmEDetails.btnSaveClick(Sender: TObject);
var
  isActivated: String;

begin
  if (EIdEdit.Text <> '') and (EFirstnameEdit.Text <> '') and
    (ELastnameEdit.Text <> '') and (EEmailEdit.Text <> '') and
    (EHoursEdit.Text <> '') then
  begin
    if (btnActive.Checked) then
      isActivated := 'True'
    else
      isActivated := 'False';
    if (self.Caption = configFile.ReadString('Caption', 'Update', '')) then
    begin
      with DataModule1.UpdateQuery do
      begin
        active := false;
        sql.Clear;
        sql.Text := Format(configFile.ReadString('Sql', 'Update', ''),
          [QuotedStr(EIdEdit.Text), QuotedStr(LowerCase(EFirstnameEdit.Text)),
          QuotedStr(LowerCase(ELastnameEdit.Text)), QuotedStr(EEmailEdit.Text),
          StrToInt(EHoursEdit.Text), isActivated]);
        Open;
        Close;
      end;
      ShowMessage('Update record succesfully');
      Close;
    end
    else
    begin
      with DataModule1.InserQuery do
      begin
        active := false;
        sql.Clear;
        sql.Text := Format(configFile.ReadString('Sql', 'Insert', ''),
          [QuotedStr(EIdEdit.Text), QuotedStr(LowerCase(EFirstnameEdit.Text)),
          QuotedStr(LowerCase(ELastnameEdit.Text)), QuotedStr(EEmailEdit.Text),
          StrToInt(EHoursEdit.Text), isActivated]);
        Open;
        Close;
      end;
      ShowMessage('New record succesfully added');
      Close;
    end;
  end;
end;

procedure TfrmEDetails.EIdEditChange(Sender: TObject);
begin
  EIdEdit.Text := UpperCase(EIdEdit.Text);
end;

procedure TfrmEDetails.FormShow(Sender: TObject);
begin
  configFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\config.ini');
  if (self.Caption = configFile.ReadString('Caption', 'Add', '')) then
  begin
    EIdEdit.Clear;
    EIdEdit.Enabled := true;
    EHoursEdit.Clear;
    EFirstnameEdit.Clear;
    ELastnameEdit.Clear;
    EEmailEdit.Clear;
    btnActive.Checked := false;
    btnActive.Caption := 'Inactivo';
  end
  else if (self.Caption = configFile.ReadString('Caption', 'Update', '')) then
  begin
    with DataModule1.FindByIdQuery do
    begin
      active := false;
      sql.Clear;
      sql.Text := Format(configFile.ReadString('Sql', 'FindById', ''),
        [QuotedStr(self.Hint)]);
      active := true;
    end;

    EIdEdit.Text := DataModule1.FindByIdQuery.FieldByName('id').AsString;
    EIdEdit.Enabled := false;
    EHoursEdit.Text := DataModule1.FindByIdQuery.FieldByName('hours').AsString;
    EFirstnameEdit.Text := DataModule1.FindByIdQuery.FieldByName
      ('firstname').AsString;
    ELastnameEdit.Text := DataModule1.FindByIdQuery.FieldByName
      ('lastname').AsString;
    EEmailEdit.Text := DataModule1.FindByIdQuery.FieldByName('email').AsString;

    if (DataModule1.FindByIdQuery.FieldByName('active').AsBoolean) then
    begin
      btnActive.Checked := true;
      btnActive.Caption := 'Activo';
    end
    else
    begin
      btnActive.Checked := false;
      btnActive.Caption := 'Inactivo';
    end;

  end;

end;

end.
