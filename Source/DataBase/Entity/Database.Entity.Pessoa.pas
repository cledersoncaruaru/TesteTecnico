unit Database.Entity.Pessoa;

interface


uses

UDM,
DataBase.Generics,



FireDAC.Comp.Client;




  type

  TPessoa = Class


  Private
    Fnmprimeiro: String;
    Fnmsegundo: String;
    Fdsdocumento: String;
    Fidpessoa: LongInt;
    Fflnatureza: LongInt;
    Fdtregistro: TDate;
    procedure Setdsdocumento(const Value: String);
    procedure Setflnatureza(const Value: LongInt);
    procedure Setidpessoa(const Value: LongInt);
    procedure Setnmprimeiro(const Value: String);
    procedure Setnmsegundo(const Value: String);
    procedure Setdtregistro(const Value: TDate);




  Public



  Property idpessoa       : LongInt read Fidpessoa write Setidpessoa;
  Property flnatureza     : LongInt read Fflnatureza write Setflnatureza;
  Property dsdocumento    : String read Fdsdocumento write Setdsdocumento;
  Property nmprimeiro     : String read Fnmprimeiro write Setnmprimeiro;
  Property nmsegundo      : String read Fnmsegundo write Setnmsegundo;
  Property dtregistro     : TDate read Fdtregistro write Setdtregistro;




  end;




  Function Cria_Tabela_Pessoa : Boolean;





implementation

uses
  System.SysUtils;

{ TPessoa }


Function Cria_Tabela_Pessoa : Boolean;
Var
  Tabela : TFDQuery;
begin

 Result := False;

 try

  Tabela             := TFDQuery.Create(nil);
  Tabela.Connection  := DM.Connection;


   if not TabelaExiste('pessoa') then
   begin



    Tabela.SQL.Clear;

    Tabela.Sql.Add(' CREATE TABLE pessoa (                          ');

    Tabela.Sql.Add(' idpessoa          bigserial NOT NULL,          ');
    Tabela.Sql.Add(' flnatureza        int2 NOT NULL,               ');
    Tabela.Sql.Add(' dsdocumento       VARCHAR(20),                 ');
    Tabela.Sql.Add(' nmprimeiro        VARCHAR(100),                ');
    Tabela.Sql.Add(' nmsegundo         VARCHAR(100),                ');
    Tabela.Sql.Add(' dtregistro        date NULL,                   ');

    Tabela.Sql.Add(' CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa)    ');
    Tabela.Sql.Add('  );                                            ');

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



procedure TPessoa.Setdsdocumento(const Value: String);
begin
  Fdsdocumento := Value;
end;

procedure TPessoa.Setdtregistro(const Value: TDate);
begin
  Fdtregistro := Value;
end;

procedure TPessoa.Setflnatureza(const Value: LongInt);
begin
  Fflnatureza := Value;
end;

procedure TPessoa.Setidpessoa(const Value: LongInt);
begin
  Fidpessoa := Value;
end;

procedure TPessoa.Setnmprimeiro(const Value: String);
begin
  Fnmprimeiro := Value;
end;

procedure TPessoa.Setnmsegundo(const Value: String);
begin
  Fnmsegundo := Value;
end;

end.
