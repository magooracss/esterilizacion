unit dmalumnos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmGeneral
  ;

const
  CAT_ALUMNO = 'A';
  CAT_DOCENTE = 'D';

type

  { Tdm_alumnos }

  Tdm_alumnos = class(TDataModule)
    qBuscarAlumnoCBBVISIBLE: TSmallintField;
    qBuscarAlumnoCBCAPELLIDOS: TStringField;
    qBuscarAlumnoCBCNOMBRES: TStringField;
    qBuscarAlumnoCBCODBARRA: TStringField;
    qBuscarAlumnoCBDIRECCION: TStringField;
    qBuscarAlumnoCBDOCUMENTO: TStringField;
    qBuscarAlumnoCBIDALUMNO: TStringField;
    qBuscarAlumnoCBLOCALIDAD: TStringField;
    qBuscarAlumnoCBNROALUMNO: TLongintField;
    qBuscarAlumnoCBREFFOTO: TStringField;
    qBuscarAlumnoCBREFTIPODOC: TLongintField;
    qBuscarAlumnoCBSUSPENDIDOFIN: TDateField;
    qBuscarAlumnoCBSUSPENDIDOINI: TDateField;
    qBuscarAlumnoCBTARJETADIGITO: TLongintField;
    qBuscarAlumnoCBTARJETALEGAJO: TLongintField;
    qBuscarAlumnoCBTELEFONO: TStringField;
    qBuscarAlumnoCBTXNOTAS: TMemoField;
    qTiposDocumentoBVISIBLE: TSmallintField;
    qTiposDocumentoIDTIPODOCUMENTO: TLongintField;
    qTiposDocumentoTIPODOCUMENTO: TStringField;
    qTodosLosAlumnos: TZQuery;
    qTiposDocumento: TZQuery;
    qBuscarAlumnoCB: TZQuery;
    qTodosLosAlumnosBVISIBLE: TSmallintField;
    qTodosLosAlumnosBVISIBLE2: TSmallintField;
    qTodosLosAlumnosBVISIBLE3: TSmallintField;
    qTodosLosAlumnosBVISIBLE4: TSmallintField;
    qTodosLosAlumnosCAPELLIDOS: TStringField;
    qTodosLosAlumnosCAPELLIDOS2: TStringField;
    qTodosLosAlumnosCAPELLIDOS3: TStringField;
    qTodosLosAlumnosCAPELLIDOS4: TStringField;
    qTodosLosAlumnosCATEGORIA: TStringField;
    qTodosLosAlumnosCNOMBRES: TStringField;
    qTodosLosAlumnosCNOMBRES2: TStringField;
    qTodosLosAlumnosCNOMBRES3: TStringField;
    qTodosLosAlumnosCNOMBRES4: TStringField;
    qTodosLosAlumnosCODBARRA2: TStringField;
    qTodosLosAlumnosCODBARRA3: TStringField;
    qTodosLosAlumnosCODBARRA4: TStringField;
    qTodosLosAlumnosDIRECCION: TStringField;
    qTodosLosAlumnosDOCUMENTO: TStringField;
    qTodosLosAlumnosDOCUMENTO2: TStringField;
    qTodosLosAlumnosDOCUMENTO3: TStringField;
    qTodosLosAlumnosDOCUMENTO4: TStringField;
    qTodosLosAlumnosIDALUMNO: TStringField;
    qTodosLosAlumnosIDALUMNO2: TStringField;
    qTodosLosAlumnosIDALUMNO3: TStringField;
    qTodosLosAlumnosIDALUMNO4: TStringField;
    qTodosLosAlumnosLOCALIDAD: TStringField;
    qTodosLosAlumnosNROALUMNO: TLongintField;
    qTodosLosAlumnosNROALUMNO2: TStringField;
    qTodosLosAlumnosNROALUMNO3: TStringField;
    qTodosLosAlumnosNROALUMNO4: TStringField;
    qTodosLosAlumnosREFFOTO: TStringField;
    qTodosLosAlumnosREFFOTO2: TStringField;
    qTodosLosAlumnosREFFOTO3: TStringField;
    qTodosLosAlumnosREFFOTO4: TStringField;
    qTodosLosAlumnosREFTIPODOC: TLongintField;
    qTodosLosAlumnosREFTIPODOC2: TLongintField;
    qTodosLosAlumnosREFTIPODOC3: TLongintField;
    qTodosLosAlumnosREFTIPODOC4: TLongintField;
    qTodosLosAlumnosSUSPENDIDOFIN: TDateField;
    qTodosLosAlumnosSUSPENDIDOINI: TDateField;
    qTodosLosAlumnosTARJETADIGITO: TLongintField;
    qTodosLosAlumnosTARJETALEGAJO: TLongintField;
    qTodosLosAlumnosTELEFONO: TStringField;
    qTodosLosAlumnosTXNOTAS: TMemoField;
    qTodosLosAlumnosTXNOTAS2: TMemoField;
    qTodosLosAlumnosTXNOTAS3: TMemoField;
    qTodosLosAlumnosTXNOTAS4: TMemoField;
    tbAlumnosbVisible: TLongintField;
    tbAlumnoscApellidos: TStringField;
    tbAlumnoscategoria: TStringField;
    tbAlumnoscNombres: TStringField;
    tbAlumnosDireccion: TStringField;
    tbAlumnosDocumento: TStringField;
    tbAlumnoSEL: TZQuery;
    tbAlumnos: TRxMemoryData;
    tbAlumnoINS: TZQuery;
    tbAlumnoSELBVISIBLE: TSmallintField;
    tbAlumnoSELCAPELLIDOS: TStringField;
    tbAlumnoSELCATEGORIA: TStringField;
    tbAlumnoSELCNOMBRES: TStringField;
    tbAlumnoSELCODBARRA: TStringField;
    tbAlumnoSELDIRECCION: TStringField;
    tbAlumnoSELDOCUMENTO: TStringField;
    tbAlumnoSELIDALUMNO: TStringField;
    tbAlumnoSELLOCALIDAD: TStringField;
    tbAlumnoSELNROALUMNO: TLongintField;
    tbAlumnoSELREFFOTO: TStringField;
    tbAlumnoSELREFTIPODOC: TLongintField;
    tbAlumnoSELSUSPENDIDOFIN: TDateField;
    tbAlumnoSELSUSPENDIDOINI: TDateField;
    tbAlumnoSELTARJETADIGITO: TLongintField;
    tbAlumnoSELTARJETALEGAJO: TLongintField;
    tbAlumnoSELTELEFONO: TStringField;
    tbAlumnoSELTXNOTAS: TMemoField;
    tbAlumnosidAlumno: TStringField;
    tbAlumnosLocalidad: TStringField;
    tbAlumnosnroAlumno: TLongintField;
    tbAlumnosrefFoto: TStringField;
    tbAlumnosrefTipoDoc: TLongintField;
    tbAlumnosSuspendidoFin: TDateField;
    tbAlumnosSuspendidoIni: TDateField;
    tbAlumnostarjetaDigito: TLongintField;
    tbAlumnostarjetaLegajo: TLongintField;
    tbAlumnosTelefono: TStringField;
    tbAlumnostxNotas: TStringField;
    tbAlumnoUPD: TZQuery;
    tbAlumnoDEL: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbAlumnosAfterInsert(DataSet: TDataSet);
  private
    _refCategoria: string;
    function getIdAlumnoActual: GUID_ID;
    { private declarations }
  public
    property idAlumnoActual: GUID_ID read getIdAlumnoActual;
    property refCategoria: string read _refCategoria write _refCategoria;
    procedure ObtenerTodosLosAlumnos;
    function SeleccionTodosLosAlumnos: GUID_ID;

    function CrearAlumno: GUID_ID;
    procedure LevantarAlumno (idAlumno: GUID_ID);

    procedure ActualizarCombos (tipoDocumento: integer);
    procedure Borrar (idAlumno: GUID_ID);
    procedure Grabar;

    function BuscarAlumnoCB(elCodigo: string): boolean;
    procedure inicializar;
  end;

var
  dm_alumnos: Tdm_alumnos;

implementation
{$R *.lfm}

{ Tdm_alumnos }

procedure Tdm_alumnos.tbAlumnosAfterInsert(DataSet: TDataSet);
begin
  with dataset do
  begin
    FieldByName('idAlumno').asString:= DM_General.CrearGUID;
    FieldByName('TarjetaDigito').asInteger:= 1;
    FieldByName('refFoto').asString:= GUIDNULO;
    FieldByName('categoria').asString:= _refCategoria;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

function Tdm_alumnos.getIdAlumnoActual: GUID_ID;
begin
  with tbAlumnos do
  begin
    if RecordCount > 0 then
      Result:= tbAlumnosidAlumno.asString
    else
      Result:= GUIDNULO;
  end;
end;

procedure Tdm_alumnos.DataModuleCreate(Sender: TObject);
begin
  tbAlumnos.Open;
  _refCategoria:= CAT_ALUMNO;
end;

procedure Tdm_alumnos.ObtenerTodosLosAlumnos;
begin
  with qTodosLosAlumnos  do
  begin
    if active then close;
    ParamByName('categoria').asString:= _refCategoria;
    open;
  end;
end;

function Tdm_alumnos.SeleccionTodosLosAlumnos: GUID_ID;
begin
  if qTodosLosAlumnos.EOF then
      Result:= GUIDNULO
  else
      Result:= qTodosLosAlumnosIDALUMNO.asString;
end;

function Tdm_alumnos.CrearAlumno: GUID_ID;
begin
  tbAlumnos.Insert;
  Result:= tbAlumnos.FieldByName('idAlumno').asString;
end;

procedure Tdm_alumnos.LevantarAlumno(idAlumno: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbAlumnos);
  with tbAlumnoSEL do
  begin
    if active then close;
    ParamByName('idAlumno').asString:= idAlumno;
    Open;
    if RecordCount > 0 then
    begin
       tbAlumnos.LoadFromDataSet(tbAlumnoSEL,0, lmAppend);
    end;
  end;
end;

procedure Tdm_alumnos.ActualizarCombos(tipoDocumento: integer);
begin
  with tbAlumnos do
  begin
    Edit;
    tbAlumnosrefTipoDoc.AsInteger:= tipoDocumento;
  end;
end;

procedure Tdm_alumnos.Borrar(idAlumno: GUID_ID);
begin
  if idAlumno <> GUIDNULO then
  begin
    tbAlumnoDEL.ParamByName('idAlumno').asString:= idAlumno;
    tbAlumnoDEL.ExecSQL;
  end;
end;

procedure Tdm_alumnos.Grabar;
begin
  DM_General.GrabarDatos(tbAlumnoSEL, tbAlumnoINS,tbAlumnoUPD,tbAlumnos, 'idAlumno');
end;

function Tdm_alumnos.BuscarAlumnoCB(elCodigo: string): boolean;
var
  elLegajo, elDigito: integer;
begin
  DM_General.ReiniciarTabla(tbAlumnos);
  elLegajo:= StrToIntDef (Copy(elCodigo, 1, Length(elCodigo) - 1), 0);
  elDigito:= StrToIntDef (Copy(elCodigo, Length(elCodigo),1), 0);

  with qBuscarAlumnoCB do
  begin
    if active then close;
    ParamByName('elLegajo').AsInteger:= elLegajo;
    ParamByName('elDigito').AsInteger:= elDigito;

    Open;
    if RecordCount > 0 then
    begin
      Result:= true;
      tbAlumnos.LoadFromDataSet(qBuscarAlumnoCB, 0, lmAppend);
    end
    else
      Result:= false;
  end;
end;

procedure Tdm_alumnos.inicializar;
begin
  DM_General.ReiniciarTabla(tbAlumnos);
end;

end.

