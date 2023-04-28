unit UDM;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, REST.Types,
  FireDAC.Comp.DataSet, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TDM = class(TDataModule)
    Connection: TFDConnection;
    Driver: TFDPhysPgDriverLink;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }

    Procedure GravaLog(Log:String);



  end;

var
  DM: TDM;

implementation

uses
   System.SysUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.GravaLog(Log:String);
var
    NomeLog   : String;
    Arquivo   : TextFile;
begin

  NomeLog := ExtractFilePath(ParamStr(0))+'Log.txt';
  AssignFile(Arquivo,NomeLog);


  if FileExists (NomeLog) then
    Append(Arquivo)
  else
  ReWrite(Arquivo);
  try
  WriteLn(Arquivo,(''''+ FormatDateTime('dd/mm/yyyy', now) + ' - ' + FormatDateTime('hh:nn:ss',now) + '''' +' Log...    '+ Log));
  finally
  CloseFile(Arquivo);
  end;


end;


end.
