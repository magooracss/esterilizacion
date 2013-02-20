unit dmfotos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmGeneral
  ;

type

  { TDM_Fotos }

  TDM_Fotos = class(TDataModule)
    qFotoRelacionFOTO: TBlobField;
    qFotoRelacionIDFOTO: TStringField;
    qFotoRelacionRELACION: TStringField;
    tbFoto: TRxMemoryData;
    tbFotoFoto: TBlobField;
    tbFotoidFoto: TStringField;
    tbFotorelacion: TStringField;
    qFotoRelacion: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbFotoAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure LevantarFoto (relacion: GUID_ID);
    procedure cargarArchivo (relacion: GUID_ID; archivo: string);
  end;

var
  DM_Fotos: TDM_Fotos;

implementation
{$R *.lfm}


{ TDM_Fotos }

procedure TDM_Fotos.tbFotoAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idFoto').asString:= DM_General.CrearGUID;
    FieldByName('relacion').asString:= GUIDNULO;
  end;


end;

procedure TDM_Fotos.DataModuleCreate(Sender: TObject);
begin
  tbFoto.Open;
end;

procedure TDM_Fotos.LevantarFoto(relacion: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbFoto);
  with qFotoRelacion do
  begin
    if active then close;
    ParamByName('relacion').asString:= relacion;
    Open;
    tbFoto.LoadFromDataSet(qFotoRelacion, 0, lmAppend);
  end;
end;

procedure TDM_Fotos.cargarArchivo(relacion: GUID_ID; archivo: string);
begin
  DM_General.ReiniciarTabla(tbFoto);
  tbFoto.Insert;
  tbFotorelacion.asString:= relacion;

//  tbFotoFoto.LoadFromFile(archivo);
  tbFoto.Post;
end;

end.

