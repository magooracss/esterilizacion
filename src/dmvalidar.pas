unit dmvalidar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmGeneral, db
  ;

const
  SEG_TODO = 'T';
  SEG_CONSULTAR = 'C';
  SEG_NO_ACCESO = 'N';



type

  { TDM_Validar }

  TDM_Validar = class(TDataModule)
    qBuscarUsuario: TZQuery;
    qBuscarUsuarioBVISIBLE: TSmallintField;
    qBuscarUsuarioCLAVE: TStringField;
    qBuscarUsuarioIDUSUARIO: TStringField;
    qBuscarUsuarioPALUMNOS: TStringField;
    qBuscarUsuarioPAPLICACION: TStringField;
    qBuscarUsuarioPARTICULOS: TStringField;
    qBuscarUsuarioPDOCENTES: TStringField;
    qBuscarUsuarioPESTHISTORICO: TStringField;
    qBuscarUsuarioPESTMATERIAL: TStringField;
    qBuscarUsuarioPPERSONAL: TStringField;
    qBuscarUsuarioPPRESTARTICULOS: TStringField;
    qBuscarUsuarioPSUSPENCIONES: TStringField;
    qBuscarUsuarioPTARJETAALUMNO: TStringField;
    qBuscarUsuarioPTARJETAARTICULO: TStringField;
    qBuscarUsuarioPTARJETAPERSONAL: TStringField;
    qBuscarUsuarioREFULTACCESO: TStringField;
    qBuscarUsuarioULTACCESO: TDateTimeField;
    qBuscarUsuarioUSUARIO: TStringField;
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
    qUsuariosActivos: TZQuery;
    qUsuariosActivosBVISIBLE: TSmallintField;
    qUsuariosActivosCLAVE: TStringField;
    qUsuariosActivosIDUSUARIO: TStringField;
    qUsuariosActivosPALUMNOS: TStringField;
    qUsuariosActivosPAPLICACION: TStringField;
    qUsuariosActivosPARTICULOS: TStringField;
    qUsuariosActivosPDOCENTES: TStringField;
    qUsuariosActivosPESTHISTORICO: TStringField;
    qUsuariosActivosPESTMATERIAL: TStringField;
    qUsuariosActivosPPERSONAL: TStringField;
    qUsuariosActivosPPRESTARTICULOS: TStringField;
    qUsuariosActivosPSUSPENCIONES: TStringField;
    qUsuariosActivosPTARJETAALUMNO: TStringField;
    qUsuariosActivosPTARJETAARTICULO: TStringField;
    qUsuariosActivosPTARJETAPERSONAL: TStringField;
    qUsuariosActivosREFULTACCESO: TStringField;
    qUsuariosActivosULTACCESO: TDateTimeField;
    qUsuariosActivosUSUARIO: TStringField;
    tbUsuarios: TRxMemoryData;
    tbUsuariosDEL: TZQuery;
    tbUsuariosINS: TZQuery;
    tbUsuariosSEL: TZQuery;
    tbUsuariosUPD: TZQuery;
    tbUsuariosbVisible: TLongintField;
    tbUsuariosClave: TStringField;
    tbUsuariosidUsuario: TStringField;
    tbUsuariospAlumnos: TStringField;
    tbUsuariospAplicacion: TStringField;
    tbUsuariospArticulos: TStringField;
    tbUsuariospDocentes: TStringField;
    tbUsuariospEstHistorico: TStringField;
    tbUsuariospEstMaterial: TStringField;
    tbUsuariospPersonal: TStringField;
    tbUsuariospPrestArticulos: TStringField;
    tbUsuariospSuspenciones: TStringField;
    tbUsuariospTarjetaAlumno: TStringField;
    tbUsuariospTarjetaArticulo: TStringField;
    tbUsuariospTarjetaPersonal: TStringField;
    tbUsuariosrefUltAcceso: TStringField;
    tbUsuariosSELBVISIBLE: TSmallintField;
    tbUsuariosSELCLAVE: TStringField;
    tbUsuariosSELIDUSUARIO: TStringField;
    tbUsuariosSELPALUMNOS: TStringField;
    tbUsuariosSELPAPLICACION: TStringField;
    tbUsuariosSELPARTICULOS: TStringField;
    tbUsuariosSELPDOCENTES: TStringField;
    tbUsuariosSELPESTHISTORICO: TStringField;
    tbUsuariosSELPESTMATERIAL: TStringField;
    tbUsuariosSELPPERSONAL: TStringField;
    tbUsuariosSELPPRESTARTICULOS: TStringField;
    tbUsuariosSELPSUSPENCIONES: TStringField;
    tbUsuariosSELPTARJETAALUMNO: TStringField;
    tbUsuariosSELPTARJETAARTICULO: TStringField;
    tbUsuariosSELPTARJETAPERSONAL: TStringField;
    tbUsuariosSELREFULTACCESO: TStringField;
    tbUsuariosSELULTACCESO: TDateTimeField;
    tbUsuariosSELUSUARIO: TStringField;
    tbUsuariosUltAcceso: TDateTimeField;
    tbUsuariosUsuario: TStringField;
    procedure tbUsuariosAfterInsert(DataSet: TDataSet);
  private
    _idUsuario: GUID_ID;
    function getpAlumnos: char;
    function getpAplicacion: char;
    function getpArticulos: char;
    function getpDocentes: char;
    function getpEstHistorico: char;
    function getpEstMaterial: char;
    function getpPersonal: char;
    function getpPrestArticulos: char;
    function getpSuspenciones: char;
    function getpTarjetaAlumno: char;
    function getpTarjetaArticulo: char;
    function getpTarjetaPersonal: char;
    function getUsuario: string;


  public
    property idUsuario: GUID_ID read _idUsuario;
    property Usuario: string read getUsuario;
    property pAplicacion: char read getpAplicacion;
    property pEstMaterial: char read getpEstMaterial;
    property pEstHistorico: char read getpEstHistorico;
    property pPrestArticulos: char read getpPrestArticulos;
    property pSuspenciones: char read getpSuspenciones;
    property pAlumnos: char read getpAlumnos;
    property pDocentes: char read getpDocentes;
    property pArticulos: char read getpArticulos;
    property pPersonal: char read getpPersonal;
    property pTarjetaAlumno: char read getpTarjetaAlumno;
    property pTarjetaArticulo: char read getpTarjetaArticulo;
    property pTarjetaPersonal: char read getpTarjetaPersonal;

    function usuarioValido (elUsuario, laClave: string): boolean;

    procedure Inicializar;
    procedure Grabar;

    procedure LevantarUsuarios;
    procedure UsuarioNuevo;
    procedure EliminarUsuarioSeleccionado;
  end;

var
  DM_Validar: TDM_Validar;

implementation

{$R *.lfm}

{ TDM_Validar }

procedure TDM_Validar.tbUsuariosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idUsuario').asString:= DM_General.CrearGUID;
    tbUsuariospAlumnos.asString:= 'N';
    tbUsuariospAplicacion.asString:= 'N';
    tbUsuariospArticulos.asString:= 'N';
    tbUsuariospDocentes.asString:= 'N';
    tbUsuariospEstHistorico.asString:= 'N';
    tbUsuariospEstMaterial.asString:= 'N';
    tbUsuariospPersonal.asString:= 'N';
    tbUsuariospPrestArticulos.asString:= 'N';
    tbUsuariospSuspenciones.asString:= 'N';
    tbUsuariospTarjetaAlumno.asString:= 'N';
    tbUsuariospTarjetaPersonal.asString:= 'N';
    tbUsuariospTarjetaArticulo.asString:= 'N';
    FieldByName('bVisible').asInteger:= 1;
    tbUsuariosrefUltAcceso.asString:= GUIDNULO;
  end;
end;

function TDM_Validar.getpAlumnos: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPALUMNOS.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpAplicacion: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPAPLICACION.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpArticulos: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPARTICULOS.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpDocentes: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPDOCENTES.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpEstHistorico: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPESTHISTORICO.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpEstMaterial: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPESTMATERIAL.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpPersonal: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPPERSONAL.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpPrestArticulos: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPPRESTARTICULOS.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpSuspenciones: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPSUSPENCIONES.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpTarjetaAlumno: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPTARJETAALUMNO.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpTarjetaArticulo: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPTARJETAARTICULO.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getpTarjetaPersonal: char;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioPTARJETAPERSONAL.AsString[1]
  else
    Result:= SEG_NO_ACCESO;
end;

function TDM_Validar.getUsuario: string;
begin
  if ((qBuscarUsuario.Active) and (qBuscarUsuario.RecordCount > 0)) then
    Result:= qBuscarUsuarioUSUARIO.AsString
  else
    Result:= EmptyStr;
end;

function TDM_Validar.usuarioValido(elUsuario, laClave: string): boolean;
begin
  with qBuscarUsuario do
  begin
    if active then close;
    ParamByName('usuario').asString:= elUsuario;
    open;

    if (RecordCount > 0) then
      Result:= (TRIM(laClave) = TRIM(qBuscarUsuarioCLAVE.asString))
    else
      Result:= false;
  end;
end;

procedure TDM_Validar.Grabar;
begin
  DM_General.GrabarDatos(tbUsuariosSEL, tbUsuariosINS, tbUsuariosUPD, tbUsuarios, 'idUsuario');
end;

procedure TDM_Validar.Inicializar;
begin
  with qBuscarUsuario do
  begin
    if active then close;
  end;
end;

procedure TDM_Validar.LevantarUsuarios;
begin
  DM_General.ReiniciarTabla(tbUsuarios);
  with qUsuariosActivos do
  begin
    if active then close;
    Open;
    tbUsuarios.LoadFromDataSet(qUsuariosActivos, 0, lmAppend);
  end;
end;

procedure TDM_Validar.UsuarioNuevo;
begin
  tbUsuarios.Insert;
end;

procedure TDM_Validar.EliminarUsuarioSeleccionado;
begin
  with tbUsuariosDEL do
  begin
    ParamByName('idUsuario').asString:= tbUsuariosidUsuario.asString;
    ExecSQL;
    tbUsuarios.Delete;
  end;
end;

end.

