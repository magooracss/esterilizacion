unit frm_inventarioae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls, Buttons, DBGrids
  , dmGeneral
  ;

type

  { TfrmInventarioAE }

  TfrmInventarioAE = class(TForm)
    btnImprimir: TBitBtn;
    btnGrabar: TBitBtn;
    DBText1: TDBText;
    DBText2: TDBText;
    ds_inventario: TDatasource;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    procedure btnGrabarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idInventario: integer;
  public
    property idInventario: integer read _idInventario write _idInventario;
    Procedure Inicializar;
  end;

var
  frmInventarioAE: TfrmInventarioAE;

implementation
{$R *.lfm}
uses
  dminventario
  ;

{ TfrmInventarioAE }

procedure TfrmInventarioAE.btnGrabarClick(Sender: TObject);
begin
  DM_Inventario.Grabar;
  if idInventario < 0 then
    idInventario:= DM_Inventario.UltimoID;
  DM_Inventario.GenerarCB(idInventario);
  ModalResult:= mrOK;
end;

procedure TfrmInventarioAE.btnImprimirClick(Sender: TObject);
begin
  DM_Inventario.EtiquetaArticulo;
end;

procedure TfrmInventarioAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmInventarioAE.Inicializar;
begin
  if _idInventario = -1 then
    DM_Inventario.NuevoArticulo
  else
    DM_Inventario.ModificarArticulo(_idInventario);
end;

end.

