unit DataBase.Generics;

interface

  uses
  UDM,
  System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.Client,
  Data.DB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet ;


  Function TabelaExiste ( NomeTabela : String ) : Boolean;
  Function GeneratorExiste ( NomeGenerator : String ) : Boolean;
  function Get_Sequence(nome_do_seguence:String):Integer;
  Function Get_Field_String_Param_Str (Field: String; Tabela:String; Param:string; vValue:String):String;



implementation


Function Get_Field_String_Param_Str (Field: String; Tabela:String; Param:string; vValue:String):String;
var
  Qry : TFDQuery;
begin

  Result := '';

  Qry := TFDQuery.Create(nil);
  Qry.Connection := DM.Connection;
  try

    Qry.SQL.Clear;
    Qry.SQL.Add('Select '+Field+' from '+Tabela+' where ' + Param+' = '+QuotedStr(vValue) );

    try

      Qry.Open;

      if not Qry.Fields[0].IsNull then
        Result := Qry.Fields[0].AsString;

      if Result ='-1' then
        Result:='0';

    except

    end;

  finally
    Qry.Free;
  end;

end;


function Get_Sequence(nome_do_seguence:String):Integer;
var
  Qry : TFDQuery;
begin
  Result :=0;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DM.Connection;

    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT nextval('+QuotedStr(LowerCase(nome_do_seguence)) +');  ');
    try
      Qry.Open;
      Result:= Qry.FieldByName('nextval').AsInteger;
    except
      on E: Exception do begin
//        Result :=0;
//        raise Exception.Create(E.Message);
      end;
    end;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;



Function GeneratorExiste ( NomeGenerator : String ) : Boolean;
var
  Qry  :TFDQuery;
begin

  Result:=False;

  Qry            := TFDQuery.Create(nil);
  Qry.Connection := DM.Connection;

  try

//    Qry.Sql.Add('SELECT RDB$GENERATOR_NAME FROM RDB$GENERATORS WHERE Upper(RDB$GENERATOR_NAME) = Upper('''+NomeGenerator+''')');
//    Qry.Sql.Add('CREATE SEQUENCE '+LowerCase(NomeGenerator));

//     Qry.Sql.Add('SELECT nextval('+LowerCase(NomeGenerator)+')');
//     Qry.Sql.Add('SELECT nextval('+LowerCase(NomeGenerator)+') ');
//    Qry.Sql.Add('     SELECT nextval(''pessoa'') ');

      Qry.Sql.Add('CREATE SEQUENCE mysequence '+QuotedStr(LowerCase(NomeGenerator)));
      Qry.Sql.Add(' INCREMENT 1                  ');
      Qry.Sql.Add('START 1;                      ');



    try

      Qry.Open;

      If Qry.RecordCount>0 Then
        Result:=TRUE;

    except

      on E: Exception do begin

//        raise Exception.Create(E.Message);
//        Telegram_Send('Phoenix.DataBase.Functions - GeneratorExiste - '+ E.Message);
         Result:=False;

      end;

    end;

  finally
    Qry.Free;
  end;



END;





function TabelaExiste(NomeTabela: String): Boolean;
var
  Qry : TFDQuery;
begin

  Result:= False;

  Qry := TFDQuery.Create(nil);

  Qry.Connection := DM.Connection;

  try

    Qry.Close;
    Qry.SQL.Clear;

    Qry.Sql.Add('SELECT tablename                                     ');
    Qry.Sql.Add('FROM pg_tables                                       ');
    Qry.Sql.Add('WHERE schemaname=''public''                          ');
    Qry.Sql.Add('AND tablename='+QuotedStr(LowerCase(NomeTabela))+'   ');




    try

      Qry.Open;

      If Qry.RecordCount>0 Then
        Result    := True;

    except

      on E: Exception do begin

        raise Exception.Create(E.Message);
//        Telegram_Send('DataBase.Generics - TabelaExiste - '+ E.Message);
//        Result:= False;

      end;

    end;

  finally
    Qry.Free;
  end;

end;



end.

