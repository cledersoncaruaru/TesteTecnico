unit Database.Dao.Pessoa;

interface


uses

UDM,
DataBase.Generics,
DataBase.Entity.Pessoa,

FireDAC.Comp.Client;



 Function Set_Pessoa(Pessoa:TPessoa):Boolean;
 Function Delete_Pessoa(ID_Pessoa,ID_Endereco:LongInt):Boolean;





implementation

uses
  System.SysUtils;


 Function Delete_Pessoa(ID_Pessoa,ID_Endereco:LongInt):Boolean;
 Var
Qry:TFDQuery;
ID_Endereco_Integracao:LongInt;
begin

  Result := False;

  try

    Qry              := TFDQuery.Create(Nil);
    Qry.Connection   := DM.Connection;


    ID_Endereco_Integracao   := StrToIntDef( Get_Field_String_Param_Str('idendereco','endereco','idpessoa',IntToStr(ID_Pessoa)),0);


    Qry.Close;
    Qry.SQL.Clear;

    Qry.SQL.Add('DELETE FROM pessoa ');
    Qry.SQL.Add('WHERE idpessoa=:idpessoa');
    Qry.ParamByName('idpessoa').AsInteger          := ID_Pessoa;



    try

      Qry.ExecSQL;



      Qry.Close;
      Qry.SQL.Clear;

      Qry.SQL.Add('DELETE FROM endereco ');
      Qry.SQL.Add('WHERE idpessoa=:idpessoa');
      Qry.ParamByName('idpessoa').AsInteger          := ID_Pessoa;

      Qry.ExecSQL;


      Qry.Close;
      Qry.SQL.Clear;

      Qry.SQL.Add('DELETE FROM endereco_integracao');
      Qry.SQL.Add('WHERE idendereco=:idendereco');
      Qry.ParamByName('idendereco').AsInteger          := ID_Endereco_Integracao;

      Qry.ExecSQL;




     Result := True;


    except on E: Exception do

    DM.GravaLog(E.Message);

    end;





  finally

  Qry.Free;

  end;


end;


Function Set_Pessoa(Pessoa:TPessoa):Boolean;
Var
Qry:TFDQuery;
begin


  try

   Qry              := TFDQuery.Create(Nil);
   Qry.Connection   := DM.Connection;


   Qry.Close;
   Qry.SQL.Clear;

    Qry.SQL.Add('INSERT INTO pessoa (idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro)  ');
    Qry.SQL.Add('VALUES (:idpessoa, :flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtregistro)        ');
    Qry.SQL.Add('ON CONFLICT (idpessoa) DO UPDATE                                                           ');
    Qry.SQL.Add('SET                                                                                        ');
    Qry.SQL.Add('flnatureza = :flnatureza,                                                                  ');
    Qry.SQL.Add('dsdocumento = :dsdocumento,                                                                ');
    Qry.SQL.Add('nmprimeiro = :nmprimeiro,                                                                  ');
    Qry.SQL.Add('nmsegundo = :nmsegundo,                                                                    ');
    Qry.SQL.Add('dtregistro = :dtregistro;                                                                  ');





   Qry.ParamByName('idpessoa').AsInteger          := Pessoa.idpessoa;
   Qry.ParamByName('flnatureza').AsInteger        := Pessoa.flnatureza;
   Qry.ParamByName('dsdocumento').AsString        := Pessoa.dsdocumento;
   Qry.ParamByName('nmprimeiro').AsString         := Pessoa.nmprimeiro;
   Qry.ParamByName('nmsegundo').AsString          := Pessoa.nmsegundo;
   Qry.ParamByName('dtregistro').AsDate           := Pessoa.dtregistro;








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
