program Project1;

uses
  Vcl.Forms,
  EListForm in 'EListForm.pas' {Form1},
  EDetailsForm in 'EDetailsForm.pas' {frmEDetails},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  EGraphicsForm in 'EGraphicsForm.pas' {frmGraphics};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmEDetails, frmEDetails);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmGraphics, frmGraphics);
  Application.Run;
end.
