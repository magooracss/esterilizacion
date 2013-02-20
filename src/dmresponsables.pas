unit dmresponsables;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmGeneral, dmconexion;

type

  { TDM_Responsables }

  TDM_Responsables = class(TDataModule)
    qBuscarResponsableCB: TZQuery;
    qBuscarResponsableCBBVISIBLE: TSmallintField;
    qBuscarResponsableCBCAPELLIDOS: TStringField;
    qBuscarResponsableCBCLAVE: TStringField;
    qBuscarResponsableCBCNOMBRES: TStringField;
    qBuscarResponsableCBCODBARRA: TStringField;
    qBuscarResponsableCBDOCUMENTO: TStringField;
    qBuscarResponsableCBIDRESPONSABLE: TStringField;
    qBuscarResponsableCBLEGAJO: TStringField;
    qBuscarResponsableCBNIVELACCESO: TLongintField;
    qBuscarResponsableCBREFFOTO: TStringField;
    qBuscarResponsableCBREFTIPODOC: TLongintField;
    qBuscarResponsableCBTXNOTAS: TMemoField;
    qGruposResponsablesBVISIBLE: TSmallintField;
    qGruposResponsablesGRUPORESPONSABLE: TStringField;
    qGruposResponsablesIDGRUPORESPONSABLE: TLongintField;
    qTiposDocumento: TZQuery;
    qGruposResponsables: TZQuery;
    qTiposDocumentoBVISIBLE: TSmallintField;
    qTiposDocumentoIDTIPODOCUMENTO: TLongintField;
    qTiposDocumentoTIPODOCUMENTO: TStringField;
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
    qTodosLosResponsablesBVISIBLE: TSmallintField;
    qTodosLosResponsablesCAPELLIDOS: TStringField;
    qTodosLosResponsablesCNOMBRES: TStringField;
    qTodosLosResponsablesDOCUMENTO: TStringField;
    qTodosLosResponsablesFRANCODIA: TLongintField;
    qTodosLosResponsablesFRANCOFIN: TTimeField;
    qTodosLosResponsablesFRANCOINI: TTimeField;
    qTodosLosResponsablesHORARIO1FIN: TTimeField;
    qTodosLosResponsablesHORARIO1INI: TTimeField;
    qTodosLosResponsablesHORARIO2FIN: TTimeField;
    qTodosLosResponsablesHORARIO2INI: TTimeField;
    qTodosLosResponsablesIDRESPONSABLE: TStringField;
    qTodosLosResponsablesLEGAJO: TLongintField;
    qTodosLosResponsablesREFFOTO: TStringField;
    qTodosLosResponsablesREFGRUPO: TLongintField;
    qTodosLosResponsablesREFTIPODOC: TLongintField;
    qTodosLosResponsablesTARJETADIGITO: TLongintField;
    qTodosLosResponsablesTARJETALEGAJO: TLongintField;
    qTodosLosResponsablesTXNOTAS: TMemoField;
    tbResponsablebVisible: TLongintField;
    tbResponsablecApellidos: TStringField;
    tbResponsablecNombres: TStringField;
    tbResponsableDEL: TZQuery;
    tbResponsableDocumento: TStringField;
    tbResponsableFrancoDia: TLongintField;
    tbResponsableFrancoFin: TDateTimeField;
    tbResponsableFrancoIni: TDateTimeField;
    tbResponsableHorario1Fin: TDateTimeField;
    tbResponsableHorario1Ini: TDateTimeField;
    tbResponsableHorario2Fin: TDateTimeField;
    tbResponsableHorario2Ini: TDateTimeField;
    tbResponsableidResponsable: TStringField;
    tbResponsableINS: TZQuery;
    tbResponsablelegajo: TLongintField;
    tbResponsablerefFoto: TStringField;
    tbResponsablerefGrupo: TLongintField;
    tbResponsablerefTipoDoc: TLongintField;
    tbResponsableSEL: TZQuery;
    tbResponsableSELBVISIBLE: TSmallintField;
    tbResponsableSELCAPELLIDOS: TStringField;
    tbResponsableSELCNOMBRES: TStringField;
    tbResponsableSELDOCUMENTO: TStringField;
    tbResponsableSELFRANCODIA: TLongintField;
    tbResponsableSELFRANCOFIN: TTimeField;
    tbResponsableSELFRANCOINI: TTimeField;
    tbResponsableSELHORARIO1FIN: TTimeField;
    tbResponsableSELHORARIO1INI: TTimeField;
    tbResponsableSELHORARIO2FIN: TTimeField;
    tbResponsableSELHORARIO2INI: TTimeField;
    tbResponsableSELIDRESPONSABLE: TStringField;
    tbResponsableSELLEGAJO: TLongintField;
    tbResponsableSELREFFOTO: TStringField;
    tbResponsableSELREFGRUPO: TLongintField;
    tbResponsableSELREFTIPODOC: TLongintField;
    tbResponsableSELTARJETADIGITO: TLongintField;
    tbResponsableSELTARJETALEGAJO: TLongintField;
    tbResponsableSELTXNOTAS: TMemoField;
    tbResponsabletarjetaDigito: TLongintField;
    tbResponsabletarjetaLegajo: TLongintField;
    tbResponsabletxNotas: TStringField;
    tbResponsableUPD: TZQuery;
    tbResponsable: TRxMemoryData;
    qTodosLosResponsables: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbResponsableAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure ObtenerTodosLosResponsables;
    function SeleccionTodosLosResponsables: GUID_ID;

    function CrearResponsable: GUID_ID;
    procedure LevantarResponsable (idResponsable: GUID_ID);

    procedure ActualizarCombos (tipoDocumento, tipogrupo, diaFranco: integer);
    procedure Borrar (idResponsable: GUID_ID);
    procedure Grabar;

    function BuscarResponsableCB(elCodigo: string): boolean;

    procedure Inicializar;
  end;

var
  DM_Responsables: TDM_Responsables;

implementation
{$R *.lfm}

{ TDM_Responsables }

procedure TDM_Responsables.tbResponsableAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    tbResponsableidResponsable.AsString:= DM_General.CrearGUID;
    tbResponsablerefTipoDoc.asInteger := 1;
    tbResponsablebVisible.asInteger:= 1;
    tbResponsablerefFoto.asString:= GUIDNULO;
    tbResponsablerefGrupo.asInteger:= 1;
    tbResponsabletarjetaDigito.asInteger:= 1;
  end;
end;

procedure TDM_Responsables.DataModuleCreate(Sender: TObject);
begin
  tbResponsable.Open;
end;

procedure TDM_Responsables.ObtenerTodosLosResponsables;
begin
  with qTodosLosResponsables  do
  begin
    if active then close;
    open;
  end;
end;

function TDM_Responsables.SeleccionTodosLosResponsables: GUID_ID;
begin
  if qTodosLosResponsables.EOF then
      Result:= GUIDNULO
  else
      Result:= qTodosLosResponsablesIDRESPONSABLE.asString;
end;

function TDM_Responsables.CrearResponsable: GUID_ID;
begin
  tbResponsable.Insert;
  Result:= tbResponsableidResponsable.AsString;
end;

procedure TDM_Responsables.LevantarResponsable(idResponsable: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbResponsable);
  with tbResponsableSEL do
  begin
    if active then close;
    ParamByName('idResponsable').asString:= idResponsable;
    Open;
    if RecordCount > 0 then
    begin
       tbResponsable.LoadFromDataSet(tbResponsableSEL,0, lmAppend);
    end;
  end;
end;

procedure TDM_Responsables.ActualizarCombos(tipoDocumento, tipogrupo,
  diaFranco: integer);
begin
  with tbResponsable do
  begin
    Edit;
    tbResponsablerefTipoDoc.AsInteger:= tipoDocumento;
    tbResponsablerefGrupo.asInteger:= tipoGrupo;
    tbResponsableFrancoDia.AsInteger:= diaFranco;
  end;
end;

procedure TDM_Responsables.Borrar(idResponsable: GUID_ID);
begin
  if idResponsable <> GUIDNULO then
  begin
    tbResponsableDEL.ParamByName('idResponsable').asString:= idResponsable;
    tbResponsableDEL.ExecSQL;
  end;
end;

procedure TDM_Responsables.Grabar;
begin
  DM_General.GrabarDatos(tbResponsableSEL, tbResponsableINS,tbResponsableUPD,tbResponsable, 'idResponsable');
end;

function TDM_Responsables.BuscarResponsableCB(elCodigo: string): boolean;
var
  elLegajo, elDigito: integer;
begin
  DM_General.ReiniciarTabla(tbResponsable);
  elLegajo:= StrToIntDef (Copy(elCodigo, 1, Length(elCodigo) - 1), 0);
  elDigito:= StrToIntDef (Copy(elCodigo, Length(elCodigo),1), 0);

  with qBuscarResponsableCB do
  begin
    if active then close;
    ParamByName('elLegajo').AsInteger:= elLegajo;
    ParamByName('elDigito').AsInteger:= elDigito;
    Open;
    if RecordCount > 0 then
    begin
      Result:= true;
      tbResponsable.LoadFromDataSet(qBuscarResponsableCB, 0, lmAppend);
    end
    else
      Result:= false;
  end;
end;

procedure TDM_Responsables.Inicializar;
begin
  DM_General.ReiniciarTabla(tbResponsable);
end;

end.

