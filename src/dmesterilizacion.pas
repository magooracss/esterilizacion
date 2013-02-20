unit dmesterilizacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, LR_Class, LR_DBSet, LR_Shape, LR_BarC,
  LR_Desgn, ZDataset, dmGeneral, DB;

const
  EST_INGRESO = 0;
  EST_EGRESO = 1;
  EST_TODO = 2;

  EST_ESTADO_TODO = 0;
  EST_ESTADO_RECIBIDO = 1;
  EST_ESTADO_ENTREGADO = 2;


type

  { TDM_Esterilizacion }

  TDM_Esterilizacion = class(TDataModule)
    frHistorico: TfrDBDataSet;
    qBUSPorCB: TZQuery;
    qBUSPorCBREFULTREIMPRESION: TStringField;
    qBUSPorNroOrdenEgresoBVISIBLE: TSmallintField;
    qBUSPorNroOrdenEgresoBVISIBLE1: TSmallintField;
    qBUSPorNroOrdenEgresoCODBARRA: TStringField;
    qBUSPorNroOrdenEgresoCODBARRA1: TStringField;
    qBUSPorNroOrdenEgresoFECHAEGRESO: TDateField;
    qBUSPorNroOrdenEgresoFECHAEGRESO1: TDateField;
    qBUSPorNroOrdenEgresoFECHAINGRESO: TDateField;
    qBUSPorNroOrdenEgresoFECHAINGRESO1: TDateField;
    qBUSPorNroOrdenEgresoHORAEGRESO: TTimeField;
    qBUSPorNroOrdenEgresoHORAEGRESO1: TTimeField;
    qBUSPorNroOrdenEgresoHORAINGRESO: TTimeField;
    qBUSPorNroOrdenEgresoHORAINGRESO1: TTimeField;
    qBUSPorNroOrdenEgresoIDESTERILIZACION: TStringField;
    qBUSPorNroOrdenEgresoIDESTERILIZACION1: TStringField;
    qBUSPorNroOrdenEgresoNROORDEN: TLongintField;
    qBUSPorNroOrdenEgresoNROORDEN1: TLongintField;
    qBUSPorNroOrdenEgresoPESOEGRESO: TFloatField;
    qBUSPorNroOrdenEgresoPESOEGRESO1: TFloatField;
    qBUSPorNroOrdenEgresoPESOINGRESO: TFloatField;
    qBUSPorNroOrdenEgresoPESOINGRESO1: TFloatField;
    qBUSPorNroOrdenEgresoREFALUMNO: TStringField;
    qBUSPorNroOrdenEgresoREFALUMNO1: TStringField;
    qBUSPorNroOrdenEgresoREFRESPEGRESO: TStringField;
    qBUSPorNroOrdenEgresoREFRESPEGRESO1: TStringField;
    qBUSPorNroOrdenEgresoREFRESPINGRESO: TStringField;
    qBUSPorNroOrdenEgresoREFRESPINGRESO1: TStringField;
    qBUSPorNroOrdenEgresoREFULTACCESO: TStringField;
    qBUSPorNroOrdenEgresoREFULTACCESO1: TStringField;
    qBUSPorNroOrdenEgresoREFULTREIMPRESION: TStringField;
    qBUSPorNroOrdenEgresoTXOBSEGRESO: TMemoField;
    qBUSPorNroOrdenEgresoTXOBSEGRESO1: TMemoField;
    qBUSPorNroOrdenEgresoTXOBSINGRESO: TMemoField;
    qBUSPorNroOrdenEgresoTXOBSINGRESO1: TMemoField;
    qBUSPorNroOrdenEgresoULTACCESO: TDateTimeField;
    qBUSPorNroOrdenEgresoULTACCESO1: TDateTimeField;
    qListadoEsterilizacion: TZQuery;
    qMatSinEntregarLXRESPONSABLE: TStringField;
    qMatSinEntregarREFULTREIMPRESION: TStringField;
    RepEtiqueta: TfrReport;
    frBarCodeObject1: TfrBarCodeObject;
    frDataSet: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frShapeObject1: TfrShapeObject;
    qTodosLosAlumnosBVISIBLE2: TSmallintField;
    qTodosLosAlumnosBVISIBLE3: TSmallintField;
    qTodosLosAlumnosBVISIBLE4: TSmallintField;
    qTodosLosAlumnosCAPELLIDOS2: TStringField;
    qTodosLosAlumnosCAPELLIDOS3: TStringField;
    qTodosLosAlumnosCAPELLIDOS4: TStringField;
    qTodosLosAlumnosCNOMBRES2: TStringField;
    qTodosLosAlumnosCNOMBRES3: TStringField;
    qTodosLosAlumnosCNOMBRES4: TStringField;
    qTodosLosAlumnosCODBARRA2: TStringField;
    qTodosLosAlumnosCODBARRA3: TStringField;
    qTodosLosAlumnosCODBARRA4: TStringField;
    qTodosLosAlumnosDOCUMENTO2: TStringField;
    qTodosLosAlumnosDOCUMENTO3: TStringField;
    qTodosLosAlumnosDOCUMENTO4: TStringField;
    qTodosLosAlumnosIDALUMNO2: TStringField;
    qTodosLosAlumnosIDALUMNO3: TStringField;
    qTodosLosAlumnosIDALUMNO4: TStringField;
    qTodosLosAlumnosNROALUMNO2: TStringField;
    qTodosLosAlumnosNROALUMNO3: TStringField;
    qTodosLosAlumnosNROALUMNO4: TStringField;
    qTodosLosAlumnosREFFOTO2: TStringField;
    qTodosLosAlumnosREFFOTO3: TStringField;
    qTodosLosAlumnosREFFOTO4: TStringField;
    qTodosLosAlumnosREFTIPODOC2: TLongintField;
    qTodosLosAlumnosREFTIPODOC3: TLongintField;
    qTodosLosAlumnosREFTIPODOC4: TLongintField;
    qTodosLosAlumnosTXNOTAS2: TMemoField;
    qTodosLosAlumnosTXNOTAS3: TMemoField;
    qTodosLosAlumnosTXNOTAS4: TMemoField;
    RepTicket: TfrReport;
    tbEsterilizacionrefUltReimpresion: TStringField;
    tbEsterilizacionSELREFULTREIMPRESION: TStringField;
    tbListadoEsterilizacion: TRxMemoryData;
    tbEsterilizacionDEL: TZQuery;
    tbEsterilizacionINS: TZQuery;
    tbEsterilizacionlxResponsable: TStringField;
    tbEsterilizacionrefRespIngreso: TStringField;
    tbEsterilizacionSEL: TZQuery;
    qBUSPorNroOrdenEgreso: TZQuery;
    qMatSinEntregar: TZQuery;
    tbEsterilizacionSELBVISIBLE: TSmallintField;
    tbEsterilizacionSELBVISIBLE1: TSmallintField;
    tbEsterilizacionSELCODBARRA: TStringField;
    tbEsterilizacionSELCODBARRA1: TStringField;
    tbEsterilizacionSELFECHAEGRESO: TDateField;
    tbEsterilizacionSELFECHAEGRESO1: TDateField;
    tbEsterilizacionSELFECHAINGRESO: TDateField;
    tbEsterilizacionSELFECHAINGRESO1: TDateField;
    tbEsterilizacionSELHORAEGRESO: TTimeField;
    tbEsterilizacionSELHORAEGRESO1: TTimeField;
    tbEsterilizacionSELHORAINGRESO: TTimeField;
    tbEsterilizacionSELHORAINGRESO1: TTimeField;
    tbEsterilizacionSELIDESTERILIZACION: TStringField;
    tbEsterilizacionSELIDESTERILIZACION1: TStringField;
    tbEsterilizacionSELNROORDEN: TLongintField;
    tbEsterilizacionSELNROORDEN1: TLongintField;
    tbEsterilizacionSELPESOEGRESO: TFloatField;
    tbEsterilizacionSELPESOEGRESO1: TFloatField;
    tbEsterilizacionSELPESOINGRESO: TFloatField;
    tbEsterilizacionSELPESOINGRESO1: TFloatField;
    tbEsterilizacionSELREFALUMNO: TStringField;
    tbEsterilizacionSELREFALUMNO1: TStringField;
    tbEsterilizacionSELREFRESPEGRESO: TStringField;
    tbEsterilizacionSELREFRESPEGRESO1: TStringField;
    tbEsterilizacionSELREFRESPINGRESO: TStringField;
    tbEsterilizacionSELREFRESPINGRESO1: TStringField;
    tbEsterilizacionSELREFULTACCESO: TStringField;
    tbEsterilizacionSELREFULTACCESO1: TStringField;
    tbEsterilizacionSELTXOBSEGRESO: TMemoField;
    tbEsterilizacionSELTXOBSEGRESO1: TMemoField;
    tbEsterilizacionSELTXOBSINGRESO: TMemoField;
    tbEsterilizacionSELTXOBSINGRESO1: TMemoField;
    tbEsterilizacionSELULTACCESO: TDateTimeField;
    tbEsterilizacionSELULTACCESO1: TDateTimeField;
    tbEsterilizacionUPD: TZQuery;
    tbEsterilizacion: TRxMemoryData;
    tbEsterilizacionbVisible: TLongintField;
    tbEsterilizacioncodBarra: TStringField;
    tbEsterilizacionfechaEgreso: TDateField;
    tbEsterilizacionfechaIngreso: TDateField;
    tbEsterilizacionhoraEgreso: TTimeField;
    tbEsterilizacionhoraIngreso: TTimeField;
    tbEsterilizacionidEsterilizacion: TStringField;
    tbEsterilizacionnroOrden: TLongintField;
    tbEsterilizacionpesoEgreso: TFloatField;
    tbEsterilizacionpesoIngreso: TFloatField;
    tbEsterilizacionrefAlumno: TStringField;
    tbEsterilizacionrefRespEgreso: TStringField;
    tbEsterilizacionrefUltAcceso: TStringField;
    tbEsterilizaciontxObsEgreso: TStringField;
    tbEsterilizaciontxObsIngreso: TStringField;
    tbEsterilizacionultAcceso: TDateTimeField;
    tbListadoEsterilizacionAlumno: TStringField;
    tbListadoEsterilizacionEgr_Fecha: TDateField;
    tbListadoEsterilizacionEgr_Hora: TTimeField;
    tbListadoEsterilizacionEgr_Peso: TFloatField;
    tbListadoEsterilizacionEgr_Responsable: TStringField;
    tbListadoEsterilizacionIng_Fecha: TDateField;
    tbListadoEsterilizacionIng_Hora: TTimeField;
    tbListadoEsterilizacionIng_Peso: TFloatField;
    tbListadoEsterilizacionIng_Responsable: TStringField;
    tbListadoEsterilizacionOrden: TLongintField;
    tbListadoEsterilizacionReimp_Responsable: TStringField;
    procedure tbEsterilizacionAfterInsert(DataSet: TDataSet);
  private
    _idEsterilizacion: GUID_ID;
    function getCantRegHistorico: integer;
    { private declarations }
  public
    property idEsterilizacionActual: GUID_ID read _idEsterilizacion;
    property CantRegHistorico: integer read getCantRegHistorico;
    procedure NuevoIngreso;
    procedure ActualizarDatos(refAlumno: GUID_ID; horaIngreso: TTime;
      FechaIngreso: TDate; pesoIngreso: double; refResponsable: GUID_ID);
    procedure actualizarDatosSalida (horaEgreso: TTime;
      FechaEgreso: TDate; pesoEgreso: double; refResponsable: GUID_ID);
    procedure Grabar;

    procedure LevantarEsterilizacionPorID(refIdEsterilizacion: GUID_ID);
    procedure LevantarEsterilizacionPorNrOrden (elNroOrden: integer);
    procedure ImprimirEtiqueta(refIdEsterilizacion: GUID_ID);
    procedure ImprimirTicket(refIdEsterilizacion: GUID_ID);

    procedure reimprimirPorNroOrden (elNroOrden: integer);

    procedure MaterialSinEntregar (refAlumno: GUID_ID);

    procedure Inicializar;

    procedure ObtenerHistorico ( FechaIni, FechaFin: TDate
                                ; HoraIni, HoraFin: TTime
                                ; FechaTipo: integer
                                ; idAlumno, idResponsable: GUID_ID
                                ; RespTipo, Estado: integer );

    procedure ImprimirHistorico;

    function BuscarProductoCodigo (elCodigo: string
                                  ; refAlumno: GUID_ID):boolean;

    procedure AsentarReimpresion (responsable: GUID_ID);


  end;

var
  DM_Esterilizacion: TDM_Esterilizacion;

implementation

{$R *.lfm}
uses
    dmalumnos
  , dmresponsables
  , SD_Configuracion
  , printers
  , dateutils
{$IFDEF DESARROLLO}
  , dialogs
{$ENDIF}

  ;

{ TDM_Esterilizacion }

procedure TDM_Esterilizacion.tbEsterilizacionAfterInsert(DataSet: TDataSet);
begin
  _idEsterilizacion := DM_General.CrearGUID;

  tbEsterilizacionidEsterilizacion.AsString := _idEsterilizacion;
  tbEsterilizacionrefRespEgreso.AsString := GUIDNULO;
  tbEsterilizacionrefUltAcceso.AsString := GUIDNULO;
  tbEsterilizacionrefUltReimpresion.asString:= GUIDNULO;
  tbEsterilizacionultAcceso.AsDateTime := Now;
  tbEsterilizacionnroOrden.AsInteger := -1;
  tbEsterilizacionPesoIngreso.AsFloat:= 0.0;
  tbEsterilizacionpesoEgreso.AsFloat:= 0.0;
  tbEsterilizacionbVisible.AsInteger := 1;
end;

function TDM_Esterilizacion.getCantRegHistorico: integer;
begin
  Result:= 0;
  with tbListadoEsterilizacion do
  begin
    if active then
     Result:= RecordCount;
  end;
end;

procedure TDM_Esterilizacion.NuevoIngreso;
begin
  DM_General.ReiniciarTabla(tbEsterilizacion);
  tbEsterilizacion.Insert;
end;

procedure TDM_Esterilizacion.ActualizarDatos(refAlumno: GUID_ID;
  horaIngreso: TTime; FechaIngreso: TDate; pesoIngreso: double;
  refResponsable: GUID_ID);
begin
  with tbEsterilizacion do
  begin
    Edit;
    tbEsterilizacionrefAlumno.AsString := refAlumno;
    tbEsterilizacionhoraIngreso.AsDateTime := horaIngreso;
    tbEsterilizacionfechaIngreso.AsDateTime := FechaIngreso;
    tbEsterilizacionpesoIngreso.AsFloat := pesoIngreso;
    tbEsterilizacionrefRespIngreso.AsString := refResponsable;

    tbEsterilizacionrefUltAcceso.AsString := refResponsable;
    Post;
  end;
end;

procedure TDM_Esterilizacion.Grabar;
begin
  DM_General.GrabarDatos(tbEsterilizacionSEL, tbEsterilizacionINS
    , tbEsterilizacionUPD, tbEsterilizacion
    , 'idEsterilizacion');
  if (TRIM(tbEsterilizacioncodBarra.AsString) = EmptyStr) then
  begin
    LevantarEsterilizacionPorID(tbEsterilizacionidEsterilizacion.asString);
    tbEsterilizacion.Edit;
    tbEsterilizacioncodBarra.AsString:= IntToStr(tbEsterilizacionnroOrden.asInteger)
                                        +IntToStr(YearOf(Now)) +IntToStr(dm_alumnos.tbAlumnostarjetaLegajo.AsInteger);
    tbEsterilizacion.Post;
    DM_General.GrabarDatos(tbEsterilizacionSEL, tbEsterilizacionINS
      , tbEsterilizacionUPD, tbEsterilizacion
      , 'idEsterilizacion');
  end;
end;

procedure TDM_Esterilizacion.LevantarEsterilizacionPorID(refIdEsterilizacion: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbEsterilizacion);
  with tbEsterilizacionSEL do
  begin
    if active then
      Close;
    ParamByName('idEsterilizacion').AsString := refIdEsterilizacion;
    Open;
    tbEsterilizacion.LoadFromDataSet(tbEsterilizacionSEL, 0, lmAppend);
    _idEsterilizacion := tbEsterilizacionidEsterilizacion.AsString;
  end;
  DM_Responsables.LevantarResponsable(tbEsterilizacionrefRespIngreso.AsString);
  dm_alumnos.LevantarAlumno(tbEsterilizacionrefAlumno.AsString);
end;

procedure TDM_Esterilizacion.LevantarEsterilizacionPorNrOrden(
  elNroOrden: integer);
begin
  with qBUSPorNroOrdenEgreso do
  begin
    if active then close;
    ParamByName('nroOrden').AsInteger:= elNroOrden;
    Open;
    if RecordCount > 0 then
      LevantarEsterilizacionPorID(qBUSPorNroOrdenEgresoIDESTERILIZACION.asString)
    else
      _idEsterilizacion:= GUIDNULO;
  end;
end;


(*******************************************************************************
**** IMPRESIÒN DE ETIQUETAS Y TICKETS
*******************************************************************************)

procedure TDM_Esterilizacion.ImprimirEtiqueta(refIdEsterilizacion: GUID_ID);
begin
  LevantarEsterilizacionPorID(refIdEsterilizacion);
{$IFDEF DESARROLLO}
    ShowMessage ('Etiqueta');
{$ELSE}
  DM_General.LevantarReporteEsp(_REP_ETIQUETA, DM_Esterilizacion.tbEsterilizacion, RepEtiqueta);
  DM_General.EjecutarReporteSilenciosoEsp(RepEtiqueta);
{$ENDIF}
end;

procedure TDM_Esterilizacion.ImprimirTicket(refIdEsterilizacion: GUID_ID);
VAR
  f: TextFile;
begin
  LevantarEsterilizacionPorID(refIdEsterilizacion);
{$IFDEF DESARROLLO}
  ShowMessage ('Imprimo Ticket #' + IntToStr (tbEsterilizacionnroOrden.AsInteger));
{$ELSE}
  AssignFile(F,(LeerDato('IMPRESORAS','TICKET')));  //Puerto de la Impresora: COM1, COM2, LPT1, LPT2, etc.
  Rewrite(F);
//  Write(F,#27#35#48); //Draft
  Writeln(F,dm_alumnos.tbAlumnoscApellidos.AsString + ' ' + dm_alumnos.tbAlumnoscNombres.AsString);
  Writeln(F,'INGRESO: ' + DateToStr(tbEsterilizacionfechaIngreso.AsDateTime) + ' - ' + TimeToStr(tbEsterilizacionhoraIngreso.AsDateTime));
//  Write(F,#27#33#8); //Letra negrita
  Writeln(F,'PESO: ' + FormatFloat('#0.000', tbEsterilizacionpesoIngreso.asFloat));
  Writeln(F,'--------------------------------');
  Write(F,#27#33#16); //Tama#o on
  Writeln(F,'   ' + IntToStr (tbEsterilizacionnroOrden.AsInteger));
  Write(F,#27#33#0); //Tama#o off
//  Write(F,#27#35#48); //Draft
//  Write(F,#27#70); //Letra negrita
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

procedure TDM_Esterilizacion.reimprimirPorNroOrden(elNroOrden: integer);
begin
  LevantarEsterilizacionPorNrOrden (elNroOrden);
  ImprimirTicket(idEsterilizacionActual);
  ImprimirEtiqueta(idEsterilizacionActual);
end;

(*******************************************************************************
**** SALIDA DE MATERIAL
*******************************************************************************)


procedure TDM_Esterilizacion.MaterialSinEntregar(refAlumno: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbEsterilizacion);
  with qMatSinEntregar do
  begin
    if active then close;
    ParamByName('refAlumno').asString:= refAlumno;
    open;
  //  tbEsterilizacion.LoadFromDataSet(qMatSinEntregar, 0, lmAppend);
  end;
end;

procedure TDM_Esterilizacion.Inicializar;
begin
  DM_General.ReiniciarTabla(tbEsterilizacion);
end;

procedure TDM_Esterilizacion.actualizarDatosSalida(horaEgreso: TTime;
  FechaEgreso: TDate; pesoEgreso: double; refResponsable: GUID_ID);
begin
  with tbEsterilizacion do
  begin
    Edit;
    tbEsterilizacionhoraEgreso.AsDateTime := horaEgreso;
    tbEsterilizacionfechaEgreso.AsDateTime := FechaEgreso;
    tbEsterilizacionpesoEgreso.AsFloat := pesoEgreso;
    tbEsterilizacionrefRespEgreso.AsString := refResponsable;

    tbEsterilizacionrefUltAcceso.AsString := refResponsable;
    Post;
  end;

end;

procedure TDM_Esterilizacion.ObtenerHistorico(FechaIni, FechaFin: TDate;
  HoraIni, HoraFin: TTime; FechaTipo: integer; idAlumno,
  idResponsable: GUID_ID; RespTipo, Estado: integer);
var
  elSELECT, elFROM, elWHERE: string;
begin
  DM_General.ReiniciarTabla(tbListadoEsterilizacion);

  elSELECT:= 'SELECT  E.NroOrden as Orden'
                    +', (A.cApellidos ||'' ''|| A.cNombres) as Alumno '
                    +', E.FechaIngreso as Ing_Fecha '
                    +', E.HoraIngreso as Ing_Hora '
                    +', E.PesoIngreso as Ing_Peso '
                    +', (RI.cApellidos || '' '' || RI.cNombres) as Ing_Responsable '
                    +', E.FechaEgreso as Egr_Fecha '
                    +', E.HoraEgreso as Egr_Hora '
                    +', E.PesoEgreso as Egr_Peso '
                    +', (RE.cApellidos ||'' ''|| RE.cNombres) as Egr_Responsable '
                    +', (RP.cApellidos ||'' ''|| RP.cNombres) as Reimp_Responsable '
                    ;
  elFROM:= 'FROM tbEsterilizacion E'
            +' LEFT JOIN tbAlumnos A ON A.idAlumno = E.refAlumno'
            +' LEFT JOIN tbResponsables RI ON RI.idResponsable = E.refRespIngreso'
            +' LEFT JOIN tbResponsables RE ON RE.idResponsable = E.refRespEgreso'
            +' LEFT JOIN tbResponsables RP ON RP.idResponsable = E.refUltReimpresion';

  elWHERE:= 'WHERE (E.bVisible = 1)';

  case FechaTipo of
    EST_INGRESO:  elWHERE:= elWHERE + ' AND( (E.FechaIngreso >= ''' + FormatDateTime('mm/dd/yyyy',FechaIni) + ''')'
                                    + ' AND (E.FechaIngreso <= ''' + FormatDateTime('mm/dd/yyyy',FechaFin) + '''))'
                                    + ' AND( (E.HoraIngreso >= ''' + FormatDateTime('HH:MM',HoraIni) + ''')'
                                    + ' AND (E.HoraIngreso <= ''' + FormatDateTime('HH:MM',HoraFin) + '''))'
                                    ;

    EST_EGRESO: elWHERE:= elWHERE + ' AND( (E.FechaEgreso >= ''' + FormatDateTime('mm/dd/yyyy',FechaIni) + ''')'
                                  + ' AND (E.FechaEgreso <= ''' + FormatDateTime('mm/dd/yyyy',FechaFin) + '''))'
                                  + ' AND( (E.HoraEgreso >= ''' + FormatDateTime('HH:MM',HoraIni) + ''')'
                                  + ' AND (E.HoraEgreso <= ''' + FormatDateTime('HH:MM',HoraFin) + '''))'
                                  ;

    EST_TODO: elWHERE:= elWHERE + ' AND (( (E.FechaIngreso >= ''' + FormatDateTime('mm/dd/yyyy',FechaIni) + ''')'
                                + ' AND (E.FechaIngreso <= ''' + FormatDateTime('mm/dd/yyyy',FechaFin) + ''')'
                                + ' AND( (E.HoraIngreso >= ''' + FormatDateTime('HH:MM',HoraIni) + ''')'
                                + ' AND (E.HoraIngreso <= ''' + FormatDateTime('HH:MM',HoraFin) + ''')))'
                                + '  OR ( (E.FechaEgreso >= ''' + FormatDateTime('mm/dd/yyyy',FechaIni) + ''')'
                                + ' AND (E.FechaEgreso <= ''' + FormatDateTime('mm/dd/yyyy',FechaFin) + '''))'
                                + ' AND( (E.HoraEgreso >= ''' + FormatDateTime('HH:MM',HoraIni) + ''')'
                                + ' AND (E.HoraEgreso <= ''' + FormatDateTime('HH:MM',HoraFin) + ''')))';

  end;

  if (idAlumno <> GUIDNULO) then
    elWHERE:= elWHERE + ' AND (E.refAlumno = '''+ idAlumno +''')';


  if (idResponsable <> GUIDNULO) then
  begin
    case RespTipo of
     EST_INGRESO: elWHERE:= elWHERE + ' AND (E.refRespIngreso = '''+ idResponsable +''')';
     EST_EGRESO: elWHERE:= elWHERE + ' AND (E.refRespEgreso = '''+ idResponsable +''')';
     EST_TODO: elWHERE:= elWHERE + ' AND ((E.refRespIngreso = '''+ idResponsable +''')'
                                 + ' OR (E.refRespEgreso = '''+ idResponsable +'''))';
    end;
  end;

  case Estado of
    EST_ESTADO_RECIBIDO: elWHERE:= elWHERE + ' AND (E.PesoEgreso = 0)';
    EST_ESTADO_ENTREGADO: elWHERE:= elWHERE + ' AND (E.PesoEgreso <> 0)';
  end;

  with qListadoEsterilizacion do
  begin
    if Active then close;
    SQL.Clear;
    SQL.Add(elSELECT);
    SQL.Add(elFROM);
    SQL.Add(elWHERE);
    Open;

    tbListadoEsterilizacion.LoadFromDataSet(qListadoEsterilizacion, 0, lmAppend);

    Close;
  end;

end;

procedure TDM_Esterilizacion.ImprimirHistorico;
begin
  RepEtiqueta.Dataset:= frHistorico;
  DM_General.LevantarReporteEsp('historicoesterilizacion.lrf', tbListadoEsterilizacion, RepEtiqueta);
  RepEtiqueta.ShowReport;
end;


function TDM_Esterilizacion.BuscarProductoCodigo(elCodigo: string;
  refAlumno: GUID_ID): boolean;
var
  primerDia: TDateTime;
begin
  primerDia:= EncodeDate(YearOf(Now),1,1);

  DM_General.ReiniciarTabla(tbEsterilizacion);

  if (Length(TRIM(elcodigo)) <= 6 ) then
  begin
    with qBUSPorNroOrdenEgreso do
    begin
      if active then close;
      ParamByName('nroOrden').asInteger:= StrToIntDef(elCodigo, 0);
      ParamByName('PrimerDia').AsDateTime:= primerDia;
      ParamByName('refAlumno').asString:= refAlumno;
      open;
      tbEsterilizacion.LoadFromDataSet(qBUSPorNroOrdenEgreso, 0, lmAppend);
      Result:= (tbEsterilizacion.RecordCount > 0);
      Close;
    end;
  end
  else
  begin
    with qBUSPorCB do
    begin
      if active then close;
      ParamByName('codBarra').asString:= TRIM(elCodigo);
      ParamByName('PrimerDia').AsDateTime:= primerDia;
      ParamByName('refAlumno').asString:= refAlumno;
      open;
      tbEsterilizacion.LoadFromDataSet(qBUSPorCB, 0, lmAppend);
      Result:= (tbEsterilizacion.RecordCount > 0);
      Close;
    end;
  end;

end;

procedure TDM_Esterilizacion.AsentarReimpresion(responsable: GUID_ID);
begin
  with tbEsterilizacion do
  begin
    Edit;
    tbEsterilizacionrefUltReimpresion.asString:= responsable;
    Post;
  end;
  Grabar;
end;


end.





