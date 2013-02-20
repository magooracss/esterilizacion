unit frm_egresoesterilizar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RackCtls, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DbCtrls, ExtCtrls, DBGrids, Grids;

type

  { TfrmEgresoEsterilizacion }

  TfrmEgresoEsterilizacion = class(TForm)
    btnAsentarSalida: TBitBtn;
    btnSalir: TBitBtn;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo2: TDBMemo;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    ds_alumnos: TDatasource;
    DS_EsterilizacionTodas: TDatasource;
    ds_responsables: TDatasource;
    DS_Esterilizacion: TDatasource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    edCodigo: TEdit;
    edTarjetaAlumno: TEdit;
    edTarjetaResponsable: TEdit;
    gbAlumno: TGroupBox;
    gbResponsable: TGroupBox;
    gbEgresoMaterial: TGroupBox;
    gbMaterial: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ledAnos: TLEDDisplay;
    ledBalanza: TLEDDisplay;
    ledDias: TLEDDisplay;
    ledHoras: TLEDDisplay;
    ledMeses: TLEDDisplay;
    ledMinutos: TLEDDisplay;
    panelbotonera: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    procedure btnBuscarAlumnoClick(Sender: TObject);
    procedure btnBuscarResponsableClick(Sender: TObject);
    procedure btnAsentarSalidaClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnRecalcularPesoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure edCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edTarjetaAlumnoKeyPress(Sender: TObject; var Key: char);
    procedure edTarjetaResponsableKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ledBalanzaDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    HoraEgreso: TTime;
    FechaEgreso: TDate;
    procedure BuscarAlumno (elCodigo: string);
    procedure Inicializar;
    procedure EstablecerHora;
    procedure ObtenerPeso;
    procedure BuscarResponsable (elCodigo: string);
  public
    { public declarations }
  end;

var
  frmEgresoEsterilizacion: TfrmEgresoEsterilizacion;

implementation
{$R *.lfm}
uses
  dmesterilizacion
  ,dmalumnos
  ,balanza
  ,dmresponsables
  ;

{ TfrmEgresoEsterilizacion }


(*******************************************************************************
**** Pantalla
*******************************************************************************)
procedure TfrmEgresoEsterilizacion.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmEgresoEsterilizacion.Inicializar;
begin
  EstablecerHora;
  ObtenerPeso;
  DM_Esterilizacion.Inicializar;
  edCodigo.Clear;
end;

procedure TfrmEgresoEsterilizacion.EstablecerHora;
var
  h,min,s,ms,d,m,y: word;
  momento: TDateTime;
begin

  momento:= Now;

  DecodeDate(momento,y,m,d);
  DecodeTime(momento,h,min,s,ms);

  horaEgreso:= momento;
  FechaEgreso:= momento;

  ledHoras.Value:= h;
  ledMinutos.Value:= min;

  ledDias.Value:= d;
  ledMeses.Value:= m;
  ledAnos.Value:= y;
end;

procedure TfrmEgresoEsterilizacion.FormCreate(Sender: TObject);
begin
  Inicializar;
end;


(*******************************************************************************
**** Balanza
********************************************************************************)
procedure TfrmEgresoEsterilizacion.ObtenerPeso;
var
  bal:TBalanza;
begin
  try
    bal:= TBalanza.Create;
    ledBalanza.Value:= bal.leerPeso;
  finally
    bal.Free;
  end;
end;

procedure TfrmEgresoEsterilizacion.btnRecalcularPesoClick(Sender: TObject);
begin

end;

procedure TfrmEgresoEsterilizacion.Timer1Timer(Sender: TObject);
begin
  ObtenerPeso;
end;

procedure TfrmEgresoEsterilizacion.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
end;


procedure TfrmEgresoEsterilizacion.ledBalanzaDblClick(Sender: TObject);
begin
  ObtenerPeso;
end;

(*******************************************************************************
**** BUSQUEDA DE ALUMNOS
*******************************************************************************)

procedure TfrmEgresoEsterilizacion.btnBuscarAlumnoClick(Sender: TObject);
begin
  BuscarAlumno(edTarjetaAlumno.Text);
end;

procedure TfrmEgresoEsterilizacion.edTarjetaAlumnoKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
    BuscarAlumno(edTarjetaAlumno.Text);
end;

procedure TfrmEgresoEsterilizacion.BuscarAlumno(elCodigo: string);
begin
  DM_Esterilizacion.Inicializar;
  if dm_alumnos.BuscarAlumnoCB (TRIM(elCodigo)) then
  begin
    edTarjetaResponsable.SetFocus;
    DM_Esterilizacion.MaterialSinEntregar(dm_alumnos.idAlumnoActual);
  end
  else
  begin
   ShowMessage('Problemas al buscar el alumno en la Base de Datos');
   edTarjetaAlumno.SetFocus;
  end
end;

(*******************************************************************************
**** BUSQUEDA DE RESPONSABLES
*******************************************************************************)

procedure TfrmEgresoEsterilizacion.BuscarResponsable(elCodigo: string);
begin
  if DM_Responsables.BuscarResponsableCB (TRIM(elCodigo)) then
   edCodigo.SetFocus
  else
  begin
   ShowMessage('Problemas al buscar el responsable en la Base de Datos');
   edTarjetaResponsable.SetFocus;
  end;
end;

procedure TfrmEgresoEsterilizacion.btnBuscarResponsableClick(Sender: TObject);
begin
  BuscarResponsable(edTarjetaResponsable.Text);
end;

procedure TfrmEgresoEsterilizacion.edTarjetaResponsableKeyPress(
  Sender: TObject; var Key: char);
begin
  if key = #13 then
    BuscarResponsable(edTarjetaResponsable.Text);
end;


(*******************************************************************************
**** ASENTAR SALIDA
*******************************************************************************)

procedure TfrmEgresoEsterilizacion.btnAsentarSalidaClick(Sender: TObject);
begin
  if ((TRIM(edTarjetaResponsable.Text) = EmptyStr) or (TRIM(edTarjetaAlumno.Text) = EmptyStr)) then
  begin
    ShowMessage('Falta completar datos para poder continuar. Vuelva a pasar las tarjetas por la lectora');
  end
  else
  begin

    DM_Esterilizacion.actualizarDatosSalida( HoraEgreso
                                            ,FechaEgreso
                                            ,ledBalanza.Value
                                            ,DM_Responsables.tbResponsableidResponsable.AsString
                                            );
    DM_Esterilizacion.Grabar;

    //Reinicio los pendientes del alumno sin el que grabè recièn
//    if DS_Esterilizacion.DataSet.RecordCount > 1 then
//    begin
//      BuscarAlumno(edTarjetaAlumno.Text);
//    end;

//    responsableActual:= edTarjetaResponsable.Text;
    Inicializar;
//    BuscarResponsable(responsableActual);
    dm_alumnos.inicializar;
    DM_Responsables.inicializar;
    edTarjetaAlumno.Clear;
    edTarjetaResponsable.Clear;
    edTarjetaAlumno.SetFocus;
    DM_Esterilizacion.MaterialSinEntregar(EmptyStr);
  end;
end;


(*******************************************************************************
**** NUEVO
*******************************************************************************)
procedure TfrmEgresoEsterilizacion.btnNuevoClick(Sender: TObject);
var
  responsableActual: String;
begin
  responsableActual:= edTarjetaResponsable.Text;
  Inicializar;
  BuscarResponsable(responsableActual);
  dm_alumnos.inicializar;
  edTarjetaAlumno.Clear;
  edTarjetaAlumno.SetFocus;
end;

(*******************************************************************************
**** Búsqueda de código
*******************************************************************************)
procedure TfrmEgresoEsterilizacion.edCodigoKeyPress(Sender: TObject;
  var Key: char);
begin
   if (Key = #13) then
    if (DM_Esterilizacion.BuscarProductoCodigo (edCodigo.Text, dm_alumnos.idAlumnoActual)) then
      btnAsentarSalida.SetFocus
    else
    begin
      ShowMessage ('El còdigo no existe o no pertenece a este alumno');
      edCodigo.Clear;
      edCodigo.SetFocus;
    end;
end;


end.

