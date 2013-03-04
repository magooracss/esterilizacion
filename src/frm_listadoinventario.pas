unit frm_listadoinventario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmGeneral, db;

type

  { TfrmListadoInventario }

  TfrmListadoInventario = class(TForm)
    BitBtn1: TBitBtn;
    btnAgregar: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    DS_inventario: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure Inicializar;
  private
    procedure AbrirPantalla (idInventario: integer);
  public
    { public declarations }
  end;

var
  frmListadoInventario: TfrmListadoInventario;

implementation
{$R *.lfm}
uses
  frm_inventarioae
  ,dminventario
  ;

{ TfrmListadoInventario }

procedure TfrmListadoInventario.AbrirPantalla(idInventario: integer);
var
  pant: TfrmInventarioAE;
begin
  pant:= TfrmInventarioAE.Create(self);
  try
    pant.idInventario:= idInventario;
    pant.ShowModal;
  finally
    pant.Free;
  end;
  DM_Inventario.levantarInventario;

end;

procedure TfrmListadoInventario.btnAgregarClick(Sender: TObject);
begin
  AbrirPantalla(-1);
end;

procedure TfrmListadoInventario.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoInventario.btnModificarClick(Sender: TObject);
begin
  AbrirPantalla(DM_Inventario.idInventarioActual);
end;

procedure TfrmListadoInventario.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmListadoInventario.Inicializar;
begin
  DM_Inventario.levantarInventario;
end;


end.

