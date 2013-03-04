unit dminventario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmGeneral, db
  ,dmconexion
  ;

type

  { TDM_Inventario }

  TDM_Inventario = class(TDataModule)
    qInventarioCompleto: TZQuery;
    qInventarioCompletoBVISIBLE: TSmallintField;
    qInventarioCompletoCODIGO: TStringField;
    qInventarioCompletoCODIGODEBARRAS: TStringField;
    qInventarioCompletoDESCRIPCION: TStringField;
    qInventarioCompletoESTADO: TStringField;
    qInventarioCompletoIDINVENTARIO: TLongintField;
    qInventarioSELBVISIBLE: TSmallintField;
    qInventarioSELCODIGO: TStringField;
    qInventarioSELCODIGODEBARRAS: TStringField;
    qInventarioSELDESCRIPCION: TStringField;
    qInventarioSELESTADO: TStringField;
    qInventarioSELIDINVENTARIO: TLongintField;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure tbInventarioAfterInsert(DataSet: TDataSet);
  private
    _idInventario: integer;
    function GetidInventarioActual: integer;
  public
    property idInventario: integer read GetidInventarioActual write _idInventario ;
    property idInventarioActual: integer read GetidInventarioActual;
    procedure NuevoArticulo;
    procedure ModificarArticulo (refInventario: integer);

    procedure LevantarInventario;

    procedure GenerarCB (refInventario: integer);
    procedure Grabar;
  end;

var
  DM_Inventario: TDM_Inventario;

implementation

{$R *.lfm}

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

procedure TDM_Inventario.GenerarCB(refInventario: integer);
const
  longitud = 10;
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
    Edit;
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

end.

