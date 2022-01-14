unit EGraphicsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
  VclTee.Series, Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart;

type
  TfrmGraphics = class(TForm)
    Chart1: TChart;
    Bars: TBarSeries;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetFirstnameOrHour(data: String; fetchData: Integer): String;
  end;

var
  frmGraphics: TfrmGraphics;
  value: Real;
  data: TArray<String>;

implementation

{$R *.dfm}

procedure TfrmGraphics.FormShow(Sender: TObject);
var
  i: Integer;

begin
  if (self.Hint <> '') then
  begin
    Bars.Clear;
    data := self.Hint.Split([';']);
    for i := 0 to Length(data) do
    begin
      if (data[i] <> '') then
      begin
        Bars.Add(StrToFloat(GetFirstnameOrHour(data[i], 1)),
          GetFirstnameOrHour(data[i], 0), RGB(Random(255), Random(255),
          Random(255)));
      end;
    end;

  end;
end;

function TfrmGraphics.GetFirstnameOrHour(data: string;
  fetchData: Integer): string;
begin
  if (fetchData = 0) then
    Result := data.Split([','])[0]
  else
    Result := data.Split([','])[1];
end;

end.
