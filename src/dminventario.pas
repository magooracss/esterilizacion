unit dminventario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, LR_Class, LR_DBSet, ZDataset
  ,dmGeneral, db
  ,dmconexion
  ;

type

  TEstado = (Iniciado, Finalizado);

  { TDM_Inventario }

  TDM_Inventario = class(TDataModule)
    frDataSet: TfrDBDataSet;
    qBusArtPrestadoBVISIBLE: TSmallintField;
    qBusArtPrestadoFDEVUELTO: TDateField;
    qBusArtPrestadoFEGRESO: TDateField;
    qBusArtPrestadoHDEVUELTO: TTimeField;
    qBusArtPrestadoHEGRESO: TTimeField;
    qBusArtPrestadoIDPRESTAMO: TStringField;
    qBusArtPrestadoREFALUMNO: TStringField;
    qBusArtPrestadoREFINVENTARIO: TStringField;
    qBusArtPrestadoREFRESPDEV: TStringField;
    qBusArtPrestadoREFRESPEGRESO: TStringField;
    qInventarioCompleto: TZQuery;
    qArticuloCB: TZQuery;
    qInventarioCompletoBVISIBLE: TSmallintField;
    qInventarioCompletoBVISIBLE1: TSmallintField;
    qInventarioCompletoCODIGO: TStringField;
    qInventarioCompletoCODIGO1: TStringField;
    qInventarioCompletoCODIGODEBARRAS: TStringField;
    qInventarioCompletoCODIGODEBARRAS1: TStringField;
    qInventarioCompletoDESCRIPCION: TStringField;
    qInventarioCompletoDESCRIPCION1: TStringField;
    qInventarioCompletoESTADO: TStringField;
    qInventarioCompletoESTADO1: TStringField;
    qInventarioCompletoIDINVENTARIO: TLongintField;
    qInventarioCompletoIDINVENTARIO1: TLongintField;
    qBusArtPrestado: TZQuery;
    qPrestamoSEL: TZQuery;
    qInventarioSELBVISIBLE: TSmallintField;
    qInventarioSELCODIGO: TStringField;
    qInventarioSELCODIGODEBARRAS: TStringField;
    qInventarioSELDESCRIPCION: TStringField;
    qInventarioSELESTADO: TStringField;
    qInventarioSELIDINVENTARIO: TLongintField;
    qPrestamosActivosCODIGO: TStringField;
    qPrestamosActivosDESCRIPCION: TStringField;
    qPrestamosActivosFEGRESO: TDateField;
    qPrestamosActivosHEGRESO: TTimeField;
    qPrestamosActivosLXAPYNOMALUMNOS: TStringField;
    qPrestamosActivosLXAPYNOMRESP: TStringField;
    qPrestamoSELBVISIBLE: TSmallintField;
    qPrestamoSELFDEVUELTO: TDateField;
    qPrestamoSELFEGRESO: TDateField;
    qPrestamoSELHDEVUELTO: TTimeField;
    qPrestamoSELHEGRESO: TTimeField;
    qPrestamoSELIDPRESTAMO: TStringField;
    qPrestamoSELREFALUMNO: TStringField;
    qPrestamoSELREFINVENTARIO: TStringField;
    qPrestamoSELREFRESPDEV: TStringField;
    qPrestamoSELREFRESPEGRESO: TStringField;
    qUItimoIDInventarioGEN_ID: TLargeintField;
    RepEtiqueta: TfrReport;
    tbPrestamoINS: TZQuery;
    tbPrestamoUPD: TZQuery;
    tbPrestamos: TRxMemoryData;

    tbInventariobVisible: TLongintField;
    tbInventarioCodigo: TStringField;
    tbInventarioCodigoDeBarras: TStringField;
    tbInventarioDEL: TZQuery;
    tbInventarioDescripcion: TStringField;
    tbInventarioEstado: TStringField;
    tbInventarioidInventario: TLongintField;
    tbInventarioINS: TZQuery;
    qInventarioSEL: TZQuery;
    tbInventarioUPD: TZQuery;
    tbInventario: TRxMemoryData;
    tbPrestamosbVisible: TLongintField;
    tbPrestamosfDevuelto: TDateTimeField;
    tbPrestamosfEgreso: TDateTimeField;
    tbPrestamoshDevuelto: TDateTimeField;
    tbPrestamoshEgreso: TDateTimeField;
    tbPrestamosidPrestamo: TStringField;
    tbPrestamosrefAlumno: TStringField;
    tbPrestamosrefInventario: TLongintField;
    tbPrestamosrefRespDev: TStringField;
    tbPrestamosrefRespEgreso: TStringField;
    qPrestamosActivos: TZQuery;
    qUItimoIDInventario: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbInventarioAfterInsert(DataSet: TDataSet);
    procedure tbPrestamosAfterInsert(DataSet: TDataSet);
  private
    _idInventario: integer;
    function GetidInventarioActual: integer;
    function GetIdPrestamo: GUID_ID;
  public
    property idInventario: integer read GetidInventarioActual write _idInventario ;
    property idInventarioActual: integer read GetidInventarioActual;
    property prestamoID: GUID_ID read GetIdPrestamo;

    procedure NuevoArticulo;
    procedure ModificarArticulo (refInventario: integer);

    procedure LevantarInventario;

    procedure GenerarCB (refInventario: integer);
    procedure Grabar;

    procedure LevantarPrestamosOtorgados;
    function BuscarArticuloCB (codigo: string): boolean;
    procedure grabarPrestamo (refAlumno, refResponsable: GUID_ID
                             ; refArticulo: integer
                             ;Hora: TTime; Fecha: TDate
                             ;estado : TEstado);
    function AlumnoArticuloPrestado (refAlumno: GUID_ID
                                    ; refArticulo: integer): boolean;

    procedure EtiquetaArticulo;
    procedure LevantarPrestamoID (refPrestamo: GUID_ID);
    procedure LevantarArticuloID (articulo: integer);
    procedure ImprimirTicketPrestamo (refPrestamo: GUID_ID; operacion: TEstado);

    procedure Inicializar;
    function UltimoID: Integer;
  end;

var
  DM_Inventario: TDM_Inventario;

implementation
{$R *.lfm}
uses
  dmresponsables
  ,dmalumnos
  ,Dialogs
  ,SD_Configuracion
  ;


{ TDM_Inventario }

procedure TDM_Inventario.DataModuleCreate(Sender: TObject);
begin
  tbInventario.Open;
end;

procedure TDM_Inventario.tbInventarioAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idInventario').asInteger:= -1;
    FieldByName('Codigo').asString:= '';
    FieldByName('bVisible').asInteger:= 1;
  end;
end;


function TDM_Inventario.GetidInventarioActual: integer;
begin
  if ((tbInventario.Active) and (tbInventario.RecordCount > 0)) then
    Result:= tbInventarioidInventario.AsInteger
  else
    Result:= -1;
end;

function TDM_Inventario.GetIdPrestamo: GUID_ID;
begin
  Result:= tbPrestamosidPrestamo.asString;
end;

procedure TDM_Inventario.GenerarCB(refInventario: integer);
const
  longitud = 12;
var
  cad: string;
  i: integer;
begin
  cad:= EmptyStr;
  for i := 0 to longitud - 1 do
   cad:= cad + '0';

  ModificarArticulo(refInventario);
  with tbInventario do
  begin
    cad:= cad + IntToStr(tbInventarioidInventario.AsInteger);
    cad:= Copy(cad,Length(cad)-longitud+1, longitud);
    cad[1]:= '9';
    Edit;
    tbInventarioCodigo.AsString:= IntToStr(tbInventarioidInventario.asInteger);
    tbInventarioCodigoDeBarras.asString:= cad;
    Post;
  end;
  Grabar;
end;

procedure TDM_Inventario.NuevoArticulo;
begin
  DM_General.ReiniciarTabla(tbInventario);
  tbInventario.Insert;
end;

procedure TDM_Inventario.ModificarArticulo(refInventario:integer);
begin
  DM_General.ReiniciarTabla(tbInventario);
  with qInventarioSEL do
  begin
    if active then close;
    ParamByName('idInventario').asInteger:= refInventario;
    Open;
    tbInventario.LoadFromDataSet(qInventarioSEL, 0, lmAppend);
  end;
end;

procedure TDM_Inventario.LevantarInventario;
begin
  DM_General.ReiniciarTabla(tbInventario);
  with qInventarioCompleto do
  begin
    if active then close;
    Open;

    tbInventario.LoadFromDataSet(qInventarioCompleto, 0, lmAppend);
  end;
end;

procedure TDM_Inventario.Grabar;
var
 qConsulta: TZQuery;
begin
 tbInventario.First;
 while (NOT tbInventario.Eof) do
 begin
   if qInventarioSEL.Active then
    qInventarioSEL.Close;

   qInventarioSEL.ParamByName('idInventario').asInteger:= tbInventarioidInventario.AsInteger;

   qInventarioSEL.Open;

   if (qInventarioSEL.RecordCount > 0) then
    qConsulta:= tbInventarioUPD
   else
    qConsulta:= tbInventarioINS;

   DM_General.CargarParametros(qConsulta, tbInventario);
   qConsulta.ExecSQL;
   tbInventario.Next;
 end;

end;

(*******************************************************************************
*** PRESTAMOS
*******************************************************************************)

procedure TDM_Inventario.tbPrestamosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idPrestamo').asString:= DM_General.CrearGUID;
    FieldByName('refAlumno').asString:= GUIDNULO;
    FieldByName('refInventario').asInteger:= 0;
    FieldByName('refRespEgreso').asString:= GUIDNULO;
    FieldByName('refRespDev').asString:= GUIDNULO;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Inventario.LevantarPrestamosOtorgados;
begin
  if qPrestamosActivos.Active then
     qPrestamosActivos.close;

  qPrestamosActivos.Open;
end;

function TDM_Inventario.BuscarArticuloCB(codigo: string): boolean;
begin
 DM_General.ReiniciarTabla(tbInventario);
  with qArticuloCB do
  begin
    if active then close;
    ParamByName('codigoBarras').asString:= TRIM(codigo);
    Open;
    tbInventario.LoadFromDataSet(qArticuloCB,0,lmAppend);
    Result:= (RecordCount > 0);
  end;
end;

procedure TDM_Inventario.grabarPrestamo(refAlumno, refResponsable: GUID_ID;
  refArticulo: integer; Hora: TTime; Fecha: TDate; estado: TEstado);
begin
  DM_General.ReiniciarTabla(tbPrestamos);
  case estado of
    Iniciado:
    begin
      tbPrestamos.Insert;
      tbPrestamosrefAlumno.AsString:= refAlumno;
      tbPrestamosrefInventario.asInteger:= refArticulo;
      tbPrestamosrefRespEgreso.asString:= refResponsable;
      tbPrestamoshEgreso.AsDateTime:= Hora;
      tbPrestamosfEgreso.AsDateTime:= Fecha;
    end;
    Finalizado:
    begin
      if AlumnoArticuloPrestado(refAlumno, refArticulo) then
        tbPrestamos.Edit;
      tbPrestamosrefRespDev.asString:= refResponsable;
      tbPrestamoshDevuelto.AsDateTime:= Hora;
      tbPrestamosfDevuelto.AsDateTime:= Fecha;
    end;
  end;
  DM_General.GrabarDatos(qPrestamoSEL, tbPrestamoINS, tbPrestamoUPD, tbPrestamos, 'idPrestamo' );
end;

function TDM_Inventario.AlumnoArticuloPrestado(refAlumno: GUID_ID;
  refArticulo: integer): boolean;
begin
  with qBusArtPrestado do
  begin
    if Active then close;
    ParamByName('refAlumno').asString:= refAlumno;
    ParamByName('refArticulo').asInteger:= refArticulo;
    Open;
    tbPrestamos.LoadFromDataSet(qBusArtPrestado, 0, lmAppend);
    Result:= (RecordCount > 0);
  end;
end;

procedure TDM_Inventario.EtiquetaArticulo;
begin
  DM_General.LevantarReporteEsp(_REP_ETIQUETA_INV, DM_Inventario.tbInventario, RepEtiqueta);
  DM_General.EjecutarReporteSilenciosoEsp(RepEtiqueta);
end;

procedure TDM_Inventario.LevantarPrestamoID(refPrestamo: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbPrestamos);
  with qPrestamoSEL do
  begin
    if active then close;
    ParamByName('idPrestamo').asString:= refPrestamo;
    Open;
    tbPrestamos.LoadFromDataSet(qPrestamoSEL, 0, lmAppend);
    close;
  end;
  LevantarArticuloID(tbPrestamosrefInventario.AsInteger);
  dm_alumnos.LevantarAlumno(tbPrestamosrefAlumno.asString);
end;

procedure TDM_Inventario.LevantarArticuloID(articulo: integer);
begin
  DM_General.ReiniciarTabla(tbInventario);
  with qInventarioSEL do
  begin
    if active then close;
    ParamByName('idInventario').AsInteger:= articulo;
    Open;
    tbInventario.LoadFromDataSet(qInventarioSEL, 0, lmAppend);
    close;
  end;
end;

procedure TDM_Inventario.ImprimirTicketPrestamo(refPrestamo: GUID_ID;
  operacion: TEstado);
VAR
  f: TextFile;
begin
  LevantarPrestamoID (refPrestamo);
{$IFDEF DESARROLLO}
  if operacion = Iniciado then
    ShowMessage ('Imprimo Ticket Prestamo INICIADO: ' + tbInventarioDescripcion.asString)
  else
    ShowMessage ('Imprimo Ticket Prestamo FINALIZADO: '+ tbInventarioDescripcion.asString);
{$ELSE}
  AssignFile(F,(LeerDato('IMPRESORAS','TICKET')));  //Puerto de la Impresora: COM1, COM2, LPT1, LPT2, etc.
  Rewrite(F);
  Write(F,#27#70); //Letra negrita
  Writeln(F, '     FACULTAD DE ODONTOLOGIA');
  Writeln(F, '             UNLP ');
  Writeln(F, '        ESTERILIZACION');
  Writeln(F, '         ');
  Writeln(F, '         ');

  Writeln(F, '        ');

  Writeln(F, 'ALUMNO: ' + dm_alumnos.tbAlumnoscApellidos.AsString + ' ' + dm_alumnos.tbAlumnoscNombres.AsString);
  Writeln(F, 'LEGAJO:' + InttoStr(dm_alumnos.tbAlumnosnroAlumno.AsInteger));

  if operacion = Iniciado then
  begin
    DM_Responsables.LevantarResponsable (tbPrestamosrefRespEgreso.asString);
    Writeln(F,'FECHA: ' + DateToStr(tbPrestamosfEgreso.AsDateTime) + ' - ' + TimeToStr(tbPrestamoshEgreso.AsDateTime));
    Writeln(F,'Articulos prestados al Alumno');
    Writeln(F,'-----------------------------');
  end
  else
  begin
    DM_Responsables.LevantarResponsable (tbPrestamosrefRespDev.asString);
    Writeln(F,'FECHA: ' + DateToStr(tbPrestamosfEgreso.AsDateTime) + ' - ' + TimeToStr(tbPrestamoshEgreso.AsDateTime));
    Writeln(F,'Articulos devueltos por el Alumno');
    Writeln(F,'---------------------------------');
  end;
  Writeln(F,  TRIM (tbInventarioDescripcion.asString) + ' '+IntToStr(tbInventarioCodigo.asInteger)   );
  Writeln(F,'--------------------------------');
  Writeln(F,'Resp:' + DM_Responsables.tbResponsablelegajo.AsString + ' - ' + DM_Responsables.tbResponsablecApellidos.AsString);
  Writeln(F,' ');
  Writeln(F,' ');
  Writeln(F,' ');
  Writeln(F,' ');
  Writeln(F,' ');
  Writeln(F,' ');
  Writeln(F,' ');
  Writeln(F,' ');

//  Write(F,#27#105); //Corte de papel
  CloseFile(F);
 {$ENDIF}

end;

procedure TDM_Inventario.Inicializar;
begin
  DM_General.ReiniciarTabla(tbInventario);
  DM_General.ReiniciarTabla(tbPrestamos);
end;

function TDM_Inventario.UltimoID: Integer;
begin

  with qUItimoIDInventario do
  begin
    if active then close;
    Open;
    Result:= qUItimoIDInventarioGEN_ID.AsInteger;
    close;
  end;
end;


end.

