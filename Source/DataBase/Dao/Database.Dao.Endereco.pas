unit Database.Dao.Endereco;

interface


uses

UDM,
DataBase.Generics,
DataBase.Entity.Endereco,

FireDAC.Comp.Client;



Function Set_Endereco(Endereco:TEndereco):Boolean;


implementation

uses
  System.SysUtils;


Function Set_Endereco(Endereco:TEndereco):Boolean;
Var
Qry:TFDQuery;
ID_Endereco:LongInt;
begin

ID_Endereco:=0;

  try

   Qry              := TFDQuery.Create(Nil);
   Qry.Connection   := DM.Connection;


   Qry.Close;
   Qry.SQL.Clear;
   Qry.SQL.Add('INSERT INTO endereco(idendereco, idpessoa, dscep) ');
   Qry.SQL.Add('VALUES');
   Qry.SQL.Add('(:idendereco, :idpessoa, :dscep)                  ');


    Qry.SQL.Add('ON CONFLICT (idendereco) DO UPDATE               ');
    Qry.SQL.Add('SET                                              ');
    Qry.SQL.Add('idpessoa = :idpessoa,                            ');
    Qry.SQL.Add('dscep = :dscep;                                  ');



   if Endereco.idendereco <=0 then
   begin
      ID_Endereco   := Get_Sequence('endereco_idendereco_seq');

   end
   else
   begin

   ID_Endereco   := Endereco.idendereco;

   end;


   Qry.ParamByName('idendereco').AsInteger      := ID_Endereco;
   Qry.ParamByName('idpessoa').AsInteger        := Endereco.idpessoa;
   Qry.ParamByName('dscep').AsString            := Endereco.dscep;


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

