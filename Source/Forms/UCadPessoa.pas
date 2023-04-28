unit UCadPessoa;

interface

uses

  DataBase.Generics,
  Database.Dao.Pessoa,
  Database.Dao.Endereco,
  Database.Dao.Endereco_Integracao,
  Database.Entity.Pessoa,
  Database.Entity.Endereco,
  Database.Entity.Endereco_Integracao,

  REST.Json,
  System.JSON,
  System.Threading,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TFrmCadPessoa = class(TForm)
    PanelButtons: TPanel;
    BtnIncluir: TButton;
    BtnEditar: TButton;
    BtnExcluir: TButton;
    BtnGravar: TButton;
    BtnCancel: TButton;
    PageControl1: TPageControl;
    TabCadastro: TTabSheet;
    TabConsulta: TTabSheet;
    PanelCrud: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    flNatureza: TComboBox;
    idPessoa: TEdit;
    dsDocumento: TEdit;
    dtRegistro: TDateTimePicker;
    nmPrimeiro: TEdit;
    nmSegundo: TEdit;
    dscep: TEdit;
    nmlogradouro: TEdit;
    dsuf: TEdit;
    nmbairro: TEdit;
    dscomplemento: TEdit;
    nmcidade: TEdit;
    DBGrid1: TDBGrid;
    Qry: TFDQuery;
    DsPessoa: TDataSource;
    Qrydsdocumento: TWideStringField;
    Qrydtregistro: TDateField;
    Qryflnatureza: TSmallintField;
    Qryidpessoa: TLargeintField;
    Qrynmprimeiro: TWideStringField;
    Qrynmsegundo: TWideStringField;
    Qrydscep: TWideStringField;
    Qrydscomplemento: TWideStringField;
    Qrydsuf: TWideStringField;
    Qryidendereco: TLargeintField;
    Qrynmbairro: TWideStringField;
    Qrynmcidade: TWideStringField;
    Qrynmlogradouro: TWideStringField;
    DBNavigator1: TDBNavigator;
    TabJson: TTabSheet;
    mJson: TMemo;
    BtnImportar: TButton;
    mResponse: TMemo;
    LabelContador: TLabel;
    ComboTipoConsulta: TComboBox;
    Label13: TLabel;
    EditConsulta: TEdit;
    Label14: TLabel;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dscepExit(Sender: TObject);
    procedure DsPessoaDataChange(Sender: TObject; Field: TField);
    procedure PageControl1Change(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure EditConsultaChange(Sender: TObject);
  private
    { Private declarations }

    Pessoa:Tpessoa;
    Endereco:TEndereco;
    Endereco_Integracao :TEndereco_Integracao;

    StatusImportando   : Boolean;


    Function  ValidaDados:Boolean;
    Procedure LimpaCampos;
    Procedure Get_Pessoa(Tipo:LongInt; Search:String);



  public
    { Public declarations }
  end;

var
  FrmCadPessoa: TFrmCadPessoa;

implementation

{$R *.dfm}

uses UDM;

procedure TFrmCadPessoa.BtnCancelClick(Sender: TObject);
begin
PanelCrud.Enabled  := False;
BtnEditar.Enabled  := True;
BtnExcluir.Enabled := True;
BtnIncluir.Enabled := True;
BtnCancel.Enabled  := False;
end;

procedure TFrmCadPessoa.BtnEditarClick(Sender: TObject);
begin
PanelCrud.Enabled  := True;
BtnEditar.Enabled  := False;
BtnExcluir.Enabled := False;
BtnIncluir.Enabled := False;
BtnCancel.Enabled  := True;
end;

procedure TFrmCadPessoa.BtnExcluirClick(Sender: TObject);
begin

 if StrToIntDef(idPessoa.Text,0) > 0 then
 begin

     if Application.MessageBox('Prezado Usuario,Você Deseja Excluir esse Registro?','ATENÇÃO',MB_YESNOCANCEL + MB_ICONINFORMATION + MB_DEFBUTTON2) = IdYes then
   begin

      Delete_Pessoa(StrToIntDef(idPessoa.Text,0),Endereco.idendereco);
      Get_Pessoa(ComboTipoConsulta.ItemIndex,Trim(EditConsulta.Text));
      PanelCrud.Enabled  := False;
      BtnEditar.Enabled  := True;
      BtnExcluir.Enabled := True;
      BtnIncluir.Enabled := True;
      BtnCancel.Enabled  := False;

   end;

 end;

end;

procedure TFrmCadPessoa.BtnGravarClick(Sender: TObject);
begin

  PanelCrud.Enabled   := True;
 if  ValidaDados then
    begin

      Pessoa.idpessoa                       := StrToIntDef(idPessoa.Text,0);
      Pessoa.flnatureza                     := flNatureza.ItemIndex;
      Pessoa.dsdocumento                    := dsDocumento.Text;
      Pessoa.nmprimeiro                     := Trim(nmPrimeiro.Text);
      Pessoa.nmsegundo                      := Trim(nmSegundo.Text);
      Pessoa.dtregistro                     := dtRegistro.Date;

      Endereco.idpessoa                     := Pessoa.idpessoa;
      Endereco.dscep                        := Trim(dscep.Text);

      Endereco_Integracao.idendereco        := endereco.idendereco;
      Endereco_Integracao.dsuf              := Trim(dsuf.Text);
      Endereco_Integracao.nmcidade          := Trim(nmcidade.Text);
      Endereco_Integracao.nmbairro          := Trim(nmbairro.Text);
      Endereco_Integracao.nmlogradouro      := Trim(nmlogradouro.Text);
      Endereco_Integracao.dscomplemento     := Trim(dscomplemento.Text);


      if Set_Pessoa(Pessoa) then
      begin

        Set_Endereco(Endereco);
        Set_Endereco_Integracao(Endereco_Integracao);

        PanelCrud.Enabled  := True;
        BtnEditar.Enabled  := True;
        BtnExcluir.Enabled := True;
        BtnIncluir.Enabled := True;
        BtnCancel.Enabled  := True;
        LimpaCampos;
        Application.MessageBox('Dados Gravados Com Sucesso','ATENÇÃO',0);

      end;

    end;

end;

procedure TFrmCadPessoa.BtnIncluirClick(Sender: TObject);
begin

PanelCrud.Enabled  := True;
BtnEditar.Enabled  := False;
BtnExcluir.Enabled := False;
BtnIncluir.Enabled := False;
BtnCancel.Enabled  := True;

idPessoa.Text     := IntToStr(Get_Sequence('pessoa_idpessoa_seq'));
dtRegistro.Date   := Now;


end;

procedure TFrmCadPessoa.BtnImportarClick(Sender: TObject);
var
  JsonArray: TJSONArray;
  I:Integer;
begin


 try

  mJson.Lines.Clear;
  mJson.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'RegistrosJson.json');






  TThread.CreateAnonymousThread(
  procedure
  var I: Integer;
  begin

    JsonArray:= TJSONArray.Create;
    JsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mJson.Lines.Text), 0) as TJSONArray;

    LabelContador.Caption   := 'Qtde Registros.: '+ IntToStr(jsonArray.Size);
    StatusImportando        := True;

    PanelCrud.Enabled  := False;
    BtnEditar.Enabled  := False;
    BtnExcluir.Enabled := False;
    BtnIncluir.Enabled := False;
    BtnCancel.Enabled  := False;
    BtnGravar.Enabled  := False;




   for I := 0 to jsonArray.Size - 1 do
    begin

      Sleep(Random(100));

      Pessoa.idpessoa                       := Get_Sequence('pessoa_idpessoa_seq');;
      Pessoa.flnatureza                     := JsonArray.Get(I).GetValue<integer>('flnatureza', 0);
      Pessoa.dsdocumento                    := JsonArray.Get(I).GetValue<string>('dsdocumento', '');
      Pessoa.nmprimeiro                     := JsonArray.Get(I).GetValue<string>('nmprimeiro', '');
      Pessoa.nmsegundo                      := JsonArray.Get(I).GetValue<string>('nmsegundo', '');
      Pessoa.dtregistro                     := StrToDateDef(JsonArray.Get(I).GetValue<string>('dtregistro', ''),Now);

      Endereco.idpessoa                     := Pessoa.idpessoa;
      Endereco.dscep                        := Trim(JsonArray.Get(I).GetValue<string>('dscep', ''));

      Endereco_Integracao.idendereco        := endereco.idendereco;
      Endereco_Integracao.dsuf              := Trim(JsonArray.Get(I).GetValue<string>('dsuf', ''));
      Endereco_Integracao.nmcidade          := Trim(JsonArray.Get(I).GetValue<string>('nmcidade', ''));
      Endereco_Integracao.nmbairro          := Trim(JsonArray.Get(I).GetValue<string>('nmbairro', ''));
      Endereco_Integracao.nmlogradouro      := Trim(JsonArray.Get(I).GetValue<string>('nmlogradouro', ''));
      Endereco_Integracao.dscomplemento     := Trim(JsonArray.Get(I).GetValue<string>('dscomplemento', ''));


      Set_Pessoa(Pessoa);
      Set_Endereco(Endereco);
      Set_Endereco_Integracao(Endereco_Integracao);


      mResponse.Lines.Add('Cliente.: '+IntToStr(Pessoa.idpessoa)+' - '+ Pessoa.nmprimeiro);


    end;

   JsonArray.Free;

    PanelCrud.Enabled  := True;
    BtnEditar.Enabled  := True;
    BtnExcluir.Enabled := True;
    BtnIncluir.Enabled := True;
    BtnCancel.Enabled  := True;
    BtnGravar.Enabled  := True;

  end
  ).Start;



 except on E: Exception do

 DM.GravaLog(e.Message);


 end;



end;

procedure TFrmCadPessoa.DBGrid1DblClick(Sender: TObject);
begin


PageControl1.ActivePageIndex   := 0;


end;

procedure TFrmCadPessoa.dscepExit(Sender: TObject);
begin

    if Get_Cep(dscep.Text) then
    begin
     nmlogradouro.Text  := DM.FDMemTable1.FieldByName('logradouro').AsString;
     nmbairro.Text      := DM.FDMemTable1.FieldByName('bairro').AsString;
     nmcidade.Text      := DM.FDMemTable1.FieldByName('localidade').AsString;
     dsuf.Text          := DM.FDMemTable1.FieldByName('uf').AsString;

    end;

end;

procedure TFrmCadPessoa.DsPessoaDataChange(Sender: TObject; Field: TField);
begin


idPessoa.Text              := DsPessoa.DataSet.FieldByName('idpessoa').AsString;
flNatureza.ItemIndex       := DsPessoa.DataSet.FieldByName('flnatureza').AsInteger;
dsDocumento.Text           := DsPessoa.DataSet.FieldByName('dsdocumento').AsString;
nmPrimeiro.Text            := DsPessoa.DataSet.FieldByName('nmprimeiro').AsString;
nmSegundo.Text             := DsPessoa.DataSet.FieldByName('nmsegundo').AsString;
dtRegistro.Date            := DsPessoa.DataSet.FieldByName('dtregistro').AsDateTime;
dscep.Text                 := DsPessoa.DataSet.FieldByName('dscep').AsString;
dsuf.Text                  := DsPessoa.DataSet.FieldByName('dsuf').AsString;
nmcidade.Text              := DsPessoa.DataSet.FieldByName('nmcidade').AsString;
nmbairro.Text              := DsPessoa.DataSet.FieldByName('nmbairro').AsString;
nmlogradouro.Text          := DsPessoa.DataSet.FieldByName('nmlogradouro').AsString;
dscomplemento.Text         := DsPessoa.DataSet.FieldByName('dscomplemento').AsString;

Endereco.idendereco             := DsPessoa.DataSet.FieldByName('idendereco').AsInteger;
Endereco_Integracao.idendereco  := Endereco.idendereco;



end;

procedure TFrmCadPessoa.EditConsultaChange(Sender: TObject);
begin
Get_Pessoa(ComboTipoConsulta.ItemIndex, Trim(EditConsulta.Text));
end;

procedure TFrmCadPessoa.FormCreate(Sender: TObject);
begin

  Pessoa              := TPessoa.Create;
  Endereco            := TEndereco.Create;
  Endereco_Integracao := TEndereco_Integracao.Create;

  PanelCrud.Enabled  := False;
  BtnEditar.Enabled  := True;
  BtnExcluir.Enabled := True;
  BtnIncluir.Enabled := True;
  BtnCancel.Enabled  := False;

  Get_Pessoa(ComboTipoConsulta.ItemIndex,Trim(EditConsulta.Text));
  PageControl1.ActivePageIndex   := 0;

end;

procedure TFrmCadPessoa.FormDestroy(Sender: TObject);
begin

  Pessoa.Free;
  Endereco.Free;
  Endereco_Integracao.Free;

end;

procedure TFrmCadPessoa.Get_Pessoa(Tipo:LongInt; Search:String);
begin


  if not StatusImportando then
     begin

      Qry.Close;
      Qry.SQL.Clear;

      Qry.SQL.Add('SELECT                                                               ');
      Qry.SQL.Add('P.dsdocumento,                                                       ');
      Qry.SQL.Add('P.dtregistro,                                                        ');
      Qry.SQL.Add('P.flnatureza,                                                        ');
      Qry.SQL.Add('P.idpessoa,                                                          ');
      Qry.SQL.Add('P.nmprimeiro,                                                        ');
      Qry.SQL.Add('P.nmsegundo,                                                         ');
      Qry.SQL.Add('E.dscep,                                                             ');
      Qry.SQL.Add('E.idendereco,                                                        ');
      Qry.SQL.Add('EI.dscomplemento,                                                    ');
      Qry.SQL.Add('EI.dsuf,                                                             ');
      Qry.SQL.Add('EI.idendereco,                                                       ');
      Qry.SQL.Add('EI.nmbairro,                                                         ');
      Qry.SQL.Add('EI.nmcidade,                                                         ');
      Qry.SQL.Add('EI.nmlogradouro                                                      ');
      Qry.SQL.Add('FROM PESSOA P                                                        ');
      Qry.SQL.Add('INNER JOIN endereco E ON E.idpessoa = P.idpessoa                     ');
      Qry.SQL.Add('INNER JOIN endereco_integracao EI ON EI.idendereco = E.idendereco    ');
      Qry.SQL.Add('wHERE not P.idpessoa is null');

      case Tipo of

      0 : Qry.SQL.Add(' AND P.idpessoa::text like'+QuotedStr(Trim(EditConsulta.Text+'%') ));
      1 : Qry.SQL.Add(' AND P.nmprimeiro::text like'+QuotedStr(Trim(EditConsulta.Text+'%') ));
      2 : Qry.SQL.Add(' AND P.dsdocumento::text like'+QuotedStr(Trim(EditConsulta.Text+'%') ));

      end;

      Qry.Open();


     end;

end;

procedure TFrmCadPessoa.LimpaCampos;
Var
I: Integer;
begin

 for I := 0 to ComponentCount - 1 do

  begin

    if Components[I].ClassType = TEdit then

     TEdit(Components[I]).Text := '';


    if Components[I].ClassType = TComboBox then

    TComboBox(Components[I]).ItemIndex := 0;


    if Components[I].ClassType = TDateTimePicker then

     TDateTimePicker(Components[I]).DateTime := Now;



  end;




end;

procedure TFrmCadPessoa.PageControl1Change(Sender: TObject);
begin


  if PageControl1.ActivePageIndex = 1 then
  begin

   if not StatusImportando then
          Get_Pessoa(ComboTipoConsulta.ItemIndex,Trim(EditConsulta.Text));

  end;





end;


function TFrmCadPessoa.ValidaDados: Boolean;
Var
  I: Integer;

begin

   Result := True;

  for I := 0 to ComponentCount - 1 do

  begin

    if Components[I].ClassType = TEdit then

    if TEdit(Components[I]).Text = '' then
    begin

      if i <> 39 then
      begin

      Result := False;

      TEdit(Components[I]).TextHint      := 'Campo Obrigatório';
      TEdit(Components[I]).Color         := clGrayText;
      TEdit(Components[I]).Font.Color    := clWindow;
      TEdit(Components[I]).SetFocus;

      Exit;

      end;
    end
    else
    begin

      TEdit(Components[I]).Color         := clWindow;
      TEdit(Components[I]).Font.Color    := clWindowText;

    end;

    if Components[I].ClassType = TComboBox then

    if TComboBox(Components[I]).ItemIndex < 0  then

    begin

      Result := False;

      TComboBox(Components[I]).TextHint := 'Campo Obrigatório';
      TComboBox(Components[I]).SetFocus;

      Exit;

    end;


  end;



end;

end.
