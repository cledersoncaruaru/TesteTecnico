unit DataBase.Creator;

interface

uses
  UDM,

  Database.Entity.Pessoa,
  Database.Entity.Endereco,
  Database.Entity.Endereco_Integracao,

  FireDAC.Comp.Client,
  Winapi.Windows;


  Function DataBaseExiste(NomeDatabase:String):Boolean;
  Function Conectar(DataBase:String):Boolean;
  Function CheckdDataBase:Boolean;
  Function CreateDatabase(Name:String):Boolean;

//  Function CheckdDataBase:Boolean;




  Const PortaBD = 5432;
  Const Banco   = 'postgres_bd1';
  Const Usuario = 'postgres';
  Const Senha   = 'postgres';
  Const Server  = 'local';
  Const Driver  = 'PG';



implementation

uses
  System.SysUtils;


Function CreateDatabase(Name:String):Boolean;
Var
Qry   : TFDQuery;
begin


   try

    if not DataBaseExiste(Banco) then
    begin

      try

      Qry             := TFDQuery.Create(Nil);
      Qry.Connection  := DM.Connection;


      Qry.SQL.Add('create database '+Banco);
      Qry.Prepare;

       try
        Qry.ExecSQL;


       except on E: Exception do

       DM.GravaLog(e.Message);
       end;

      DM.Connection.Commit;


      finally

       Qry.Free;
      end;


    end;


    DM.Driver.VendorLib       := ExtractFilePath(ParamStr(0))+'libpq.dll';

    DM.Connection.Connected   := False;
    DM.Connection.LoginPrompt := False;
    DM.Connection.Params.Clear;
    //    DM.Connection.Params.Add('server='    + Server);
    DM.Connection.Params.Add('user_name=' + Usuario);
    DM.Connection.Params.Add('password='  + Senha);
    DM.Connection.Params.Add('port='      + IntToStr(PortaBD));
    DM.Connection.Params.Add('Database='  + Banco);
    DM.Connection.Params.Add('DriverID='  + Driver);
    DM.Connection.Connected;


   except on E: Exception do
    begin
       Result:= False;
      raise Exception.Create(E.Message);

       DM.GravaLog(e.Message);


    end;



   end;


end;


Function CheckdDataBase:Boolean;
begin

  Result :=  True;


 if NOT Cria_Tabela_Pessoa then
  Result := FALSE;

  if NOT Cria_Tabela_Endereco then
  Result := FALSE;

 if NOT Cria_Tabela_Endereco_Integracao then
  Result := FALSE;





end;


Function Conectar(DataBase:String):Boolean;
Var
Connection :TFDConnection;
begin


  Result                := False;
  DM.Driver.VendorLib   := ExtractFilePath(ParamStr(0))+'libpq.dll';


    try

    Connection :=TFDConnection.Create(Nil);

    Connection.Connected   := False;
    Connection.LoginPrompt := False;
    Connection.Params.Clear;
    //    DM.Connection.Params.Add('server='    + Server);
    Connection.Params.Add('user_name=' + Usuario);
    Connection.Params.Add('password='  + Senha);
    Connection.Params.Add('port='      + IntToStr(PortaBD));
    Connection.Params.Add('Database='  + 'postgres');
    Connection.Params.Add('DriverID='  + Driver);


      try

      Connection.Connected := True;


      CreateDatabase(DataBase);
      Connection.Connected := False;
      CheckdDataBase;

      except on E: Exception do
       begin
       raise Exception.Create(E.Message);
          Result:= False;
         DM.GravaLog(e.Message);
       end;
      end;

    finally

    Connection.Free;

    end;





end;


Function DataBaseExiste(NomeDatabase:String):Boolean;
var
  Qry : TFDQuery;
begin



  Qry := TFDQuery.Create(nil);
  Qry.Connection := DM.Connection;
  try
    Qry.SQL.Add('SELECT count(datname) FROM pg_database where upper(datname) = '+QuotedStr(UpperCase(NomeDatabase)));
    try

      Qry.open;
      if Qry.Fields[0].AsInteger > 0 then
        Result:= True;
    except

      on E: Exception do begin

       raise Exception.Create(E.Message);
        Result:= False;

        DM.GravaLog(e.Message);
      end;
    end;
  finally
    Qry.Free;
  end;



end;





end.
