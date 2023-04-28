program ProjetoTecnico;

uses
  Vcl.Forms,
  UPrincipal in 'Source\Forms\UPrincipal.pas' {FrmPrincipal},
  UDM in 'Source\DataModule\UDM.pas' {DM: TDataModule},
  DataBase.Creator in 'Source\DataBase\DataBase.Creator.pas',
  Database.Entity.Pessoa in 'Source\DataBase\Entity\Database.Entity.Pessoa.pas',
  DataBase.Generics in 'Source\DataBase\DataBase.Generics.pas',
  Database.Entity.Endereco in 'Source\DataBase\Entity\Database.Entity.Endereco.pas',
  Database.Entity.Endereco_Integracao in 'Source\DataBase\Entity\Database.Entity.Endereco_Integracao.pas',
  UCadPessoa in 'Source\Forms\UCadPessoa.pas' {FrmCadPessoa},
  Database.Dao.Pessoa in 'Source\DataBase\Dao\Database.Dao.Pessoa.pas',
  Database.Dao.Endereco in 'Source\DataBase\Dao\Database.Dao.Endereco.pas',
  Database.Dao.Endereco_Integracao in 'Source\DataBase\Dao\Database.Dao.Endereco_Integracao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
