unit frm_ListadoResponsables;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids
  ,dmGeneral
  ;

type

  { TfrmListadoResponsables }

  TfrmListadoResponsables = class(TForm)
    btnSalir: TBitBtn;
    btnAgregar: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    DS_Responsables: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure btnAgregarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function getApyNomResponsableSeleccionado: string;
    function getIdResponsableSeleccionado: GUID_ID;
    procedure PantallaEdicion (idEdicion: GUID_ID);
  public
    property idResponsableSeleccionado: GUID_ID read getIdResponsableSeleccionado;
    property ApyNomResponsableSelecciondo: string read getApyNomResponsableSeleccionado;
  end;

var
  frmListadoResponsables: TfrmListadoResponsables;

implementation
{$R *.lfm}
uses
  dmresponsables
  ,frm_responsableae
  ;


{ TfrmListadoResponsables }

procedure TfrmListadoResponsables.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
// if NOT (fsModal in (sender as TForm).FormState)  then //Me fijo si se abrio como modal para no destruirlo
//   CloseAction:= caFree;
end;

procedure TfrmListadoResponsables.btnSalirClick(Sender: TObject);
begin
  //Dependiendo de cómo lo abro, lo cierro
//  if (fsModal in self.FormState)  then
    ModalResult:= mrOK
//  else
//    close;
end;

procedure TfrmListadoResponsables.FormCreate(Sender: TObject);
begin
  DM_Responsables.ObtenerTodosLosResponsables;
end;

function TfrmListadoResponsables.getApyNomResponsableSeleccionado: string;
begin
  with DS_Responsables.DataSet do
  begin
    if RecordCount > 0 then
      Result:= FieldByName('cApellidos').asString + FieldByName('cNombres').asString
    else
      Result:= EmptyStr;
  end;
end;

function TfrmListadoResponsables.getIdResponsableSeleccionado: GUID_ID;
begin
  with DS_Responsables.DataSet do
  begin
    if RecordCount > 0 then
      Result:= FieldByName('idResponsable').asString
    else
      Result:= GUIDNULO;
  end;
end;


(*******************************************************************************
*** Administra la pantalla de Modificación/Ingreso de un Responsable
********************************************************************************)

procedure TfrmListadoResponsables.PantallaEdicion(idEdicion: GUID_ID);
var
  pantalla: TfrmResponsableae;
begin
  pantalla:= TfrmResponsableae.Create(self);
  try
     pantalla.idResponsable:= idEdicion;
     pantalla.ShowModal;
     DM_Responsables.ObtenerTodosLosResponsables;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmListadoResponsables.btnAgregarClick(Sender: TObject);
begin
   PantallaEdicion(GUIDNULO);
end;

procedure TfrmListadoResponsables.btnModificarClick(Sender: TObject);
begin
  PantallaEdicion(DM_Responsables.SeleccionTodosLosResponsables);
end;

(*******************************************************************************
*** Borro un responsable
********************************************************************************)

procedure TfrmListadoResponsables.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Responsable seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Responsables.Borrar(DM_Responsables.SeleccionTodosLosResponsables);
    DM_Responsables.ObtenerTodosLosResponsables;
  end;
end;


end.

