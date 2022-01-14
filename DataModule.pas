unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Datasnap.DBClient, Datasnap.Win.MConnect,
  Datasnap.Win.SConnect;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    InserQuery: TFDQuery;
    FindByIdQuery: TFDQuery;
    UpdateQuery: TFDQuery;
    DeleteQuery: TFDQuery;
    GetHoursQuery: TFDQuery;
    FDQuery1id: TWideStringField;
    FDQuery1firstname: TWideStringField;
    FDQuery1lastname: TWideStringField;
    FDQuery1email: TWideStringField;
    FDQuery1hours: TIntegerField;
    FDQuery1active: TWideStringField;
    InserQueryinsert_update: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
