unit UPrincipal;

interface

uses

  DataBase.Creator,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    CadastroPessoa1: TMenuItem;
    Pessoa1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Pessoa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses UCadPessoa;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin

Conectar('postgres');



end;

procedure TFrmPrincipal.Pessoa1Click(Sender: TObject);
begin


FrmCadPessoa := TFrmCadPessoa.Create(Self);
FrmCadPessoa.ShowModal;
FreeAndNil(FrmCadPessoa);



end;

end.
