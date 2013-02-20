unit frm_permisosAE;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  ExtCtrls, Buttons, DbCtrls, StdCtrls;

type

  { TfrmPermisosAE }

  TfrmPermisosAE = class(TForm)
    BitBtn1: TBitBtn;
    btnUsrNuevo: TBitBtn;
    BitBtn3: TBitBtn;
    usrnombre: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    ds_usuarios: TDatasource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnUsrNuevoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmPermisosAE: TfrmPermisosAE;

implementation
uses
  dmvalidar
  ;

{ TfrmPermisosAE }

procedure TfrmPermisosAE.Label5Click(Sender: TObject);
begin

end;

procedure TfrmPermisosAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPermisosAE.BitBtn1Click(Sender: TObject);
begin
  DM_Validar.Grabar;
  ModalResult:=mrOK;
end;

procedure TfrmPermisosAE.BitBtn3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Elimino el usuario seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
 begin
   DM_Validar.EliminarUsuarioSeleccionado;
 end;
end;

procedure TfrmPermisosAE.btnUsrNuevoClick(Sender: TObject);
begin
  DM_Validar.UsuarioNuevo;
  usrnombre.SetFocus;
end;

procedure TfrmPermisosAE.Inicializar;
begin
  DM_Validar.levantarUsuarios;
end;

{$R *.lfm}

end.

