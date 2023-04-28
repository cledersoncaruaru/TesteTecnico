unit Database.Entity.Endereco_Integracao;

interface


uses

UDM,
DataBase.Generics,



FireDAC.Comp.Client;




  type

  TEndereco_Integracao = Class


  Private
    Fnmcidade: String;
    Fnmlogradouro: String;
    Fidendereco: LongInt;
    Fnmbairro: String;
    Fdsuf: String;
    Fdscomplemento: String;
    procedure Setdscomplemento(const Value: String);
    procedure Setdsuf(const Value: String);
    procedure Setidendereco(const Value: LongInt);
    procedure Setnmbairro(const Value: String);
    procedure Setnmcidade(const Value: String);
    procedure Setnmlogradouro(const Value: String);

  Public



  Property idendereco       : LongInt read Fidendereco write Setidendereco;
  Property dsuf             : String read Fdsuf write Setdsuf;
  Property nmcidade         : String read Fnmcidade write Setnmcidade;
  Property nmbairro         : String read Fnmbairro write Setnmbairro;
  Property nmlogradouro     : String read Fnmlogradouro write Setnmlogradouro;
  Property dscomplemento    : String read Fdscomplemento write Setdscomplemento;



  end;




  Function Cria_Tabela_Endereco_Integracao : Boolean;





implementation

uses
  System.SysUtils;




Function Cria_Tabela_Endereco_Integracao : Boolean;
Var
  Tabela : TFDQuery;
begin

 Result := False;

 try

  Tabela             := TFDQuery.Create(nil);
  Tabela.Connection  := DM.Connection;


   if not TabelaExiste('endereco_integracao') then
   begin



    Tabela.SQL.Clear;

    Tabela.Sql.Add(' CREATE TABLE endereco_integracao (        ');

    Tabela.Sql.Add(' idendereco        bigserial NOT NULL,     ');
    Tabela.Sql.Add(' dsuf              VARCHAR(50) NULL,       ');
    Tabela.Sql.Add(' nmcidade          VARCHAR(100),           ');
    Tabela.Sql.Add(' nmbairro          VARCHAR(50),            ');
    Tabela.Sql.Add(' nmlogradouro      VARCHAR(100),           ');
    Tabela.Sql.Add(' dscomplemento     VARCHAR(100),           ');


    Tabela.Sql.Add(' CONSTRAINT enderecointegracao_pk PRIMARY KEY (idendereco),                                   ');
    Tabela.Sql.Add(' CONSTRAINT enderecointegracao_fk_endereco  FOREIGN KEY (idendereco) REFERENCES endereco(idendereco) on DELETE cascade ');
    Tabela.Sql.Add('  );                                                                                           ');



      Tabela.Connection.StartTransaction;
      try
        Tabela.ExecSQL;
        Tabela.Connection.Commit;
        Result:= True;
      except

        on E: Exception do begin

          Tabela.Connection.Rollback;
          DM.GravaLog(e.Message);
//          Telegram_Send('DataBase.Tables - CREATE TABLE pessoa - '+ E.Message);
//          Log Sendo enviado para tabela de Log,Telegram ou qualquer forma de Log
//          Sendo assim tem um Historico de Logs de Erros na Aplica��o
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



{ TEndereco_Integracao }

procedure TEndereco_Integracao.Setdscomplemento(const Value: String);
begin
  Fdscomplemento := Value;
end;

procedure TEndereco_Integracao.Setdsuf(const Value: String);
begin
  Fdsuf := Value;
end;

procedure TEndereco_Integracao.Setidendereco(const Value: LongInt);
begin
  Fidendereco := Value;
end;

procedure TEndereco_Integracao.Setnmbairro(const Value: String);
begin
  Fnmbairro := Value;
end;

procedure TEndereco_Integracao.Setnmcidade(const Value: String);
begin
  Fnmcidade := Value;
end;

procedure TEndereco_Integracao.Setnmlogradouro(const Value: String);
begin
  Fnmlogradouro := Value;
end;

end.

