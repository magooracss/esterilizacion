unit frm_ingresoesterilizar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RackCtls, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DbCtrls, ExtCtrls, EditBtn
  ,dmGeneral;

type

  { TfrmIngresoEsterilizar }

  TfrmIngresoEsterilizar = class(TForm)
    btnReimprimir: TBitBtn;
    btnImprimirComprobante: TBitBtn;
    btnSalir: TBitBtn;
    ckReimpresion: TCheckBox;
    DBMemo1: TDBMemo;
    ds_responsable: TDatasource;
    txNotasEntrega: TDBMemo;
    DBText1: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    ds_alumnos: TDatasource;
    DBText2: TDBText;
    edTarjetaAlumno: TEdit;
    edTarjetaResponsable: TEdit;
    gbAlumno: TGroupBox;
    GroupBox1: TGroupBox;
    gbResponsable: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ledBalanza: TLEDDisplay;
    ledHoras: TLEDDisplay;
    ledMinutos: TLEDDisplay;
    ledDias: TLEDDisplay;
    ledMeses: TLEDDisplay;
    ledAnos: TLEDDisplay;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnBuscarResponsableClick(Sender: TObject);
    procedure btnImprimirComprobanteClick(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ckReimpresionChange(Sender: TObject);
    procedure edTarjetaAlumnoExit(Sender: TObject);
    procedure edTarjetaAlumnoKeyPress(Sender: TObject; var Key: char);
    procedure edTarjetaResponsableKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ledBalanzaDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    horaIngreso: TTime;
    FechaIngreso: TDate;
    ultImpresion
    ,ultResponsable: GUID_ID;
    procedure BuscarAlumno (codBarra: string);
    procedure BuscarResponsable (codBarra: string);
    procedure EstablecerHora;
    procedure ObtenerPeso;

    procedure AsentarComprobante;
    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmIngresoEsterilizar: TfrmIngresoEsterilizar;

implementation
{$R *.lfm}
uses
  dmalumnos
  ,balanza
  ,dmresponsables
  ,dmesterilizacion
  ;

{ TfrmIngresoEsterilizar }
(*******************************************************************************
**** PARAMETROS DE PANTALLA
********************************************************************************)
procedure TfrmIngresoEsterilizar.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
end;

procedure TfrmIngresoEsterilizar.FormCreate(Sender: TObject);
begin
  ultImpresion:= GUIDNULO;
  ultResponsable:= GUIDNULO;
  DM_Esterilizacion.NuevoIngreso;
end;

procedure TfrmIngresoEsterilizar.FormShow(Sender: TObject);
begin
  Inicializar;
end;


procedure TfrmIngresoEsterilizar.EstablecerHora;
var
  h,min,s,ms,d,m,y: word;
  momento: TDateTime;
begin

  momento:= Now;

  DecodeDate(momento,y,m,d);
  DecodeTime(momento,h,min,s,ms);

  horaIngreso:= momento;
  FechaIngreso:= momento;

  ledHoras.Value:= h;
  ledMinutos.Value:= min;

  ledDias.Value:= d;
  ledMeses.Value:= m;
  ledAnos.Value:= y;
end;


procedure TfrmIngresoEsterilizar.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmIngresoEsterilizar.ckReimpresionChange(Sender: TObject);
begin
  btnReimprimir.Enabled:= ckReimpresion.Checked;
end;

(*******************************************************************************
**** Balanza
********************************************************************************)
procedure TfrmIngresoEsterilizar.ObtenerPeso;
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

procedure TfrmIngresoEsterilizar.Timer1Timer(Sender: TObject);
begin
  ObtenerPeso;
  EstablecerHora;
end;

procedure TfrmIngresoEsterilizar.ledBalanzaDblClick(Sender: TObject);
begin
  ObtenerPeso;
end;

(*******************************************************************************
**** BUSQUEDA DE ALUMNOS
********************************************************************************)

procedure TfrmIngresoEsterilizar.BitBtn1Click(Sender: TObject);
begin
  BuscarAlumno(edTarjetaAlumno.Text);
end;

procedure TfrmIngresoEsterilizar.edTarjetaAlumnoExit(Sender: TObject);
begin
//  BuscarAlumno(edTarjetaAlumno.Text);
end;

procedure TfrmIngresoEsterilizar.edTarjetaAlumnoKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
    BuscarAlumno(edTarjetaAlumno.Text);
end;

procedure TfrmIngresoEsterilizar.BuscarAlumno(codBarra: string);
begin
  if dm_alumnos.BuscarAlumnoCB (TRIM(codBarra)) then
    edTarjetaResponsable.SetFocus
  else
  begin
   ShowMessage('Problemas al buscar el alumno en la Base de Datos');
   edTarjetaAlumno.SetFocus;
  end
end;

(*******************************************************************************
**** BUSQUEDA DE RESPONSABLES
********************************************************************************)

procedure TfrmIngresoEsterilizar.btnBuscarResponsableClick(Sender: TObject);
begin
  BuscarResponsable(edTarjetaResponsable.Text);
end;

procedure TfrmIngresoEsterilizar.BuscarResponsable(codBarra: string);
begin
  if DM_Responsables.BuscarResponsableCB (TRIM(codBarra)) then
   btnImprimirComprobante.SetFocus
  else
  begin
   ShowMessage('Problemas al buscar el responsable en la Base de Datos');
   edTarjetaResponsable.SetFocus;
  end;
end;

procedure TfrmIngresoEsterilizar.edTarjetaResponsableKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
    BuscarResponsable(edTarjetaResponsable.Text);
end;

(*******************************************************************************
**** ASENTAR COMPROBANTES
********************************************************************************)
procedure TfrmIngresoEsterilizar.AsentarComprobante;
begin
  DM_Esterilizacion.actualizarDatos(dm_alumnos.tbAlumnosidAlumno.asString
                                    ,horaIngreso
                                    ,FechaIngreso
                                    ,ledBalanza.Value
                                    ,DM_Responsables.tbResponsableidResponsable.AsString
                                    );
  DM_Esterilizacion.Grabar;
  ultImpresion:= DM_Esterilizacion.idEsterilizacionActual;
  ultResponsable:= DM_Responsables.tbResponsableidResponsable.AsString;
  DM_Esterilizacion.ImprimirTicket  (DM_Esterilizacion.idEsterilizacionActual);
  DM_Esterilizacion.ImprimirEtiqueta (DM_Esterilizacion.idEsterilizacionActual);
end;


procedure TfrmIngresoEsterilizar.btnImprimirComprobanteClick(Sender: TObject);
begin
  AsentarComprobante;
  Inicializar;
end;

procedure TfrmIngresoEsterilizar.btnReimprimirClick(Sender: TObject);
begin
  DM_Esterilizacion.ImprimirTicket  (ultImpresion);
  DM_Esterilizacion.ImprimirEtiqueta (ultImpresion);
  DM_Esterilizacion.AsentarReimpresion (ultResponsable);
end;

(*******************************************************************************
**** LIMPIAR TODO PARA NUEVA CARGA
********************************************************************************)

procedure TfrmIngresoEsterilizar.Inicializar;
begin
  DM_Esterilizacion.NuevoIngreso;
  EstablecerHora;
  ObtenerPeso;
  dm_alumnos.inicializar;
  edTarjetaAlumno.Clear;
  edTarjetaAlumno.SetFocus;
  ckReimpresion.Checked:= False;
  btnReimprimir.Enabled:= False;
end;

end.

