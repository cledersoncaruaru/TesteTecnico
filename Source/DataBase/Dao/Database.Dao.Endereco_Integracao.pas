unit Database.Dao.Endereco_Integracao;

interface


uses

UDM,
IdHTTP,
DataBase.Generics,
DataBase.Entity.Endereco_Integracao;



Function Set_Endereco_Integracao(Endereco_Integracao:TEndereco_Integracao):Boolean;
Function Get_Cep(Cep:String):Boolean;




implementation

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client;


Function Get_Cep(Cep:String):Boolean;
begin

  Result  := False;

   DM.RESTClient1.BaseURL  := 'https://viacep.com.br/ws/'+Cep+'/json';

   try

     DM.RESTRequest1.Execute;
     Result  := True;

   except on E: Exception do

   DM.GravaLog(e.Message);

   end;



end;



Function Set_Endereco_Integracao(Endereco_Integracao:TEndereco_Integracao):Boolean;
Var
Qry:TFDQuery;
ID_Endereco_Integracao:LongInt;
begin

  ID_Endereco_Integracao  :=0;

  try

   Qry              := TFDQuery.Create(Nil);
   Qry.Connection   := DM.Connection;


    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO endereco_integracao(idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento)   ');
    Qry.SQL.Add('VALUES');
    Qry.SQL.Add('(:idendereco, :dsuf, :nmcidade, :nmbairro, :nmlogradouro, :dscomplemento)                            ');
    Qry.SQL.Add('ON CONFLICT (idendereco) DO UPDATE                                                                   ');
    Qry.SQL.Add('SET                                                                                                  ');
    Qry.SQL.Add('dsuf = :dsuf,                                                                                        ');
    Qry.SQL.Add('nmcidade = :nmcidade,                                                                                ');
    Qry.SQL.Add('nmbairro = :nmbairro,                                                                                ');
    Qry.SQL.Add('nmlogradouro = :nmlogradouro,                                                                        ');
    Qry.SQL.Add('dscomplemento = :dscomplemento;                                                                      ');




   if Endereco_Integracao.idendereco <=0 then
   begin
      ID_Endereco_Integracao   := Get_Sequence('endereco_integracao_idendereco_seq');

   end
   else
   begin

   ID_Endereco_Integracao   := Endereco_Integracao.idendereco;

   end;


   Qry.ParamByName('idendereco').AsInteger      := ID_Endereco_Integracao;
   Qry.ParamByName('dsuf').AsString             := Endereco_Integracao.dsuf;
   Qry.ParamByName('nmcidade').AsString         := Endereco_Integracao.nmcidade;
   Qry.ParamByName('nmbairro').AsString         := Endereco_Integracao.nmbairro;
   Qry.ParamByName('nmlogradouro').AsString     := Endereco_Integracao.nmlogradouro;
   Qry.ParamByName('dscomplemento').AsString    := Endereco_Integracao.dscomplemento;


    try

     Qry.ExecSQL;
     DM.Connection.Commit;
    except on E: Exception do

    DM.GravaLog(E.Message);

    end;





  finally

  Qry.Free;

  end;







end;



end.

