unit Database.Entity.Endereco;

interface


uses

UDM,
DataBase.Generics,



FireDAC.Comp.Client;




  type

  TEndereco = Class


  Private
    Fidendereco: LongInt;
    Fdscep: String;
    Fidpessoa: LongInt;
    procedure Setdscep(const Value: String);
    procedure Setidendereco(const Value: LongInt);
    procedure Setidpessoa(const Value: LongInt);

  Public



  Property idendereco       : LongInt  read Fidendereco write Setidendereco;
  Property idpessoa         : LongInt  read Fidpessoa write Setidpessoa;
  Property dscep            : String  read Fdscep write Setdscep;




  end;




  Function Cria_Tabela_Endereco : Boolean;





implementation

uses
  System.SysUtils;




Function Cria_Tabela_Endereco : Boolean;
Var
  Tabela : TFDQuery;
begin

 Result := False;

 try

  Tabela             := TFDQuery.Create(nil);
  Tabela.Connection  := DM.Connection;


   if not TabelaExiste('endereco') then
   begin



    Tabela.SQL.Clear;

    Tabela.Sql.Add(' CREATE TABLE endereco (                        ');

    Tabela.Sql.Add(' idendereco        bigserial NOT NULL,          ');
    Tabela.Sql.Add(' idpessoa          int8 NOT NULL,               ');
    Tabela.Sql.Add(' dscep             VARCHAR(15),                 ');


    Tabela.Sql.Add(' CONSTRAINT endereco_pk PRIMARY KEY (idendereco),                                   ');
    Tabela.Sql.Add(' CONSTRAINT endereco_fk_pessoa  FOREIGN KEY (idpessoa) REFERENCES pessoa on DELETE cascade ');
    Tabela.Sql.Add('  );                                                                                ');



      Tabela.Connection.StartTransaction;
      try
        Tabela.ExecSQL;
        Tabela.Connection.Commit;
        Result:= True;
      except

        on E: Exception do begin
           DM.GravaLog(e.Message);
          Tabela.Connection.Rollback;
//          Telegram_Send('DataBase.Tables - CREATE TABLE pessoa - '+ E.Message);
//          Log Sendo enviado para tabela de Log,Telegram ou qualquer forma de Log
//          Sendo assim tem um Historico de Logs de Erros na Aplicação
          raise Exception.Create(E.Message);


        end;

      end;



    end
    else
    begin

       // Verificar Campos na tabelas criado posterior ao Banco de Dados

    end;









 finally

 Tabela.Free;

 end;




end;





{ TEndereco }

procedure TEndereco.Setdscep(const Value: String);
begin
  Fdscep := Value;
end;

procedure TEndereco.Setidendereco(const Value: LongInt);
begin
  Fidendereco := Value;
end;

procedure TEndereco.Setidpessoa(const Value: LongInt);
begin
  Fidpessoa := Value;
end;

end.

