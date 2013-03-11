unit frm_listadoalumnos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids, StdCtrls
  ,dmGeneral
  ;

type

  { TfrmListadoAlumnos }

  TfrmListadoAlumnos = class(TForm)
    btnSalir: TBitBtn;
    btnAgregar: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    DS_Alumnos: TDatasource;
    DBGrid1: TDBGrid;
    edBusqueda: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgCriterioBusqueda: TRadioGroup;
    procedure btnAgregarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure edBusquedaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _refCategoria: string;
    function GetApyNomAlumnoSeleccionado: string;
    function GetidAlumnoSeleccionado: GUID_ID;
    procedure PantallaEdicion (idEdicion: GUID_ID);
    procedure SetrefCategoria(AValue: string);
  public
    property idAlumnoSeleccionado: GUID_ID read GetidAlumnoSeleccionado;
    property ApyNomAlumnoSeleccionado: string read GetApyNomAlumnoSeleccionado;
    property refCategoria: string read _refCategoria write SetrefCategoria;
  end;

var
  frmListadoAlumnos: TfrmListadoAlumnos;

implementation
{$R *.lfm}
uses
  dmalumnos
  ,frm_alumnoae
  ;


{ TfrmListadoAlumnos }

procedure TfrmListadoAlumnos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
//  if NOT (fsModal in (sender as TfrmListadoAlumnos).FormState)  then //Me fijo si se abrio como modal para no destruirlo
//    CloseAction:= caFree;
end;

procedure TfrmListadoAlumnos.btnSalirClick(Sender: TObject);
begin
 //Dependiendo de cómo lo abro, lo cierro
//  if (fsModal in self.FormState)  then
    ModalResult:= mrOK
//  else
//    close;
end;

procedure TfrmListadoAlumnos.edBusquedaKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
    dm_alumnos.Buscar (edBusqueda.Text, rgCriterioBusqueda.ItemIndex)
end;

procedure TfrmListadoAlumnos.FormCreate(Sender: TObject);
begin
//  dm_alumnos:= Tdm_alumnos.Create(self);
//  dm_alumnos.ObtenerTodosLosAlumnos;
end;

procedure TfrmListadoAlumnos.FormShow(Sender: TObject);
begin
   if _refCategoria = CAT_ALUMNO then
    (Sender as TfrmListadoAlumnos).Caption:= 'Alumnos'
   else
     if _refCategoria = CAT_DOCENTE then
       (Sender as TfrmListadoAlumnos).Caption:= 'Docentes';
   dm_alumnos.ObtenerTodosLosAlumnos;
end;

function TfrmListadoAlumnos.GetApyNomAlumnoSeleccionado: string;
begin
  with DS_Alumnos.DataSet do
  begin
    if RecordCount > 0 then
      Result:= TRIM(FieldByName('cApellidos').asString) + ' ' + TRIM(FieldByName('cNombres').asString)
    else
      Result:= EmptyStr;
  end;
end;

function TfrmListadoAlumnos.GetidAlumnoSeleccionado: GUID_ID;
begin
  with DS_Alumnos.DataSet do
  begin
    if RecordCount > 0 then
      Result:= FieldByName('idAlumno').asString
    else
      Result:= GUIDNULO;
  end;
end;


(*******************************************************************************
*** Administra la pantalla de Modificación/Ingreso de un alumno - Docente
********************************************************************************)

procedure TfrmListadoAlumnos.PantallaEdicion(idEdicion: GUID_ID);
var
  pantalla: TfrmAlumnoae;
begin
  pantalla:= TfrmAlumnoae.Create(self);
  try
     pantalla.categoria:= refCategoria;
     pantalla.idAlumno:= idEdicion;
     pantalla.ShowModal;
     dm_alumnos.ObtenerTodosLosAlumnos;
  finally
    pantalla.Free;
  end;
end;

procedure TfrmListadoAlumnos.SetrefCategoria(AValue: string);
begin
  if _refCategoria=AValue then Exit;
  _refCategoria:=AValue;
  dm_alumnos.refCategoria:= AValue;
end;

procedure TfrmListadoAlumnos.btnAgregarClick(Sender: TObject);
begin
   PantallaEdicion(GUIDNULO);
end;

procedure TfrmListadoAlumnos.btnModificarClick(Sender: TObject);
begin
  PantallaEdicion(dm_alumnos.SeleccionTodosLosAlumnos);
end;

(*******************************************************************************
*** Borro un alumno
********************************************************************************)

procedure TfrmListadoAlumnos.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el Alumno seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    dm_alumnos.Borrar(dm_alumnos.SeleccionTodosLosAlumnos);
    dm_alumnos.ObtenerTodosLosAlumnos;
  end;
end;


end.

