unit frm_listadoprestamos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids;

type

  { TfrmListadoPrestamos }

  TfrmListadoPrestamos = class(TForm)
    ds_grilla: TDatasource;
    DBGrid1: TDBGrid;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmListadoPrestamos: TfrmListadoPrestamos;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ,dminventario
  ;


{ TfrmListadoPrestamos }

procedure TfrmListadoPrestamos.FormShow(Sender: TObject);
begin
   self.top:= StrToIntDef(LeerDato(SECCION_PRESTAMOS,FRM_Y), 0);
   self.Left:= StrToIntDef(LeerDato(SECCION_PRESTAMOS,FRM_X), 0);
   DM_Inventario.LevantarPrestamosOtorgados;
end;

procedure TfrmListadoPrestamos.Timer1Timer(Sender: TObject);
begin
  DM_Inventario.LevantarPrestamosOtorgados;
end;

procedure TfrmListadoPrestamos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  EscribirDato(SECCION_PRESTAMOS, FRM_Y, IntToStr(self.Top));
  EscribirDato(SECCION_PRESTAMOS, FRM_X, IntToStr(self.Left));
  CloseAction:= caFree;
end;

end.

