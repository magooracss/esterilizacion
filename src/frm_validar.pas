unit frm_validar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, DbCtrls
  ,dmGeneral;

const
  MAX_INTENTOS = 3;

type

  { TfrmValidacion }

  TfrmValidacion = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    edUsuario: TEdit;
    edClave: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edClaveKeyPress(Sender: TObject; var Key: char);
    procedure edUsuarioKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private
    cClave: integer;
    procedure Validar (usuario, clave: string);
    procedure SalirOK;

  public
  end;

var
  frmValidacion: TfrmValidacion;

implementation
{$R *.lfm}
uses
  dmvalidar
  ;

{ TfrmValidacion }

procedure TfrmValidacion.FormCreate(Sender: TObject);
begin
  cClave:= 1;
  DM_Validar.inicializar;
end;



procedure TfrmValidacion.edUsuarioKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
    edClave.SetFocus;
end;

procedure TfrmValidacion.Validar(usuario, clave: string);
begin
   if DM_Validar.usuarioValido(usuario, clave) then
     salirOK
   else
   begin
     ShowMessage('La Clave es incorrecta');
     edClave.Clear;
     if cClave <= MAX_INTENTOS then
     begin
      edClave.SetFocus;
      INC (cClave);
     end
     else
      Application.Terminate;
   end;
end;

procedure TfrmValidacion.btnAceptarClick(Sender: TObject);
begin
  Validar (edUsuario.Text ,edClave.Text);
end;

procedure TfrmValidacion.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmValidacion.edClaveKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
    Validar (edUsuario.Text ,edClave.Text);
end;

procedure TfrmValidacion.SalirOK;
begin
  ModalResult:= mrOK;
end;


end.

