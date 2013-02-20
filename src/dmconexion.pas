unit dmconexion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection;

type

  { Tdm_conexion }

  Tdm_conexion = class(TDataModule)
    cnxGeneral: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure AbrirConexion;
  public
    { public declarations }
  end;

var
  dm_conexion: Tdm_conexion;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ;


{ Tdm_conexion }

procedure Tdm_conexion.DataModuleCreate(Sender: TObject);
begin
  AbrirConexion;
end;

procedure Tdm_conexion.AbrirConexion;
var
 base: string;
 host: string;
begin
  if cnxGeneral.Connected then
   cnxGeneral.Disconnect;

  base:= LeerDato (SECCION_APP ,SERVIDOR_FB) ;
  if ((base <>  ERROR_APERTURA_CFG)
      and (base <> ERROR_CFG)) then
  begin
    base := base;
    host:= LeerDato (SECCION_APP, BASE_HOST);
    try
      with cnxGeneral do
      begin
        Database:=  base;
        HostName:= host;
        Connect;
      end;
    except
      Exception.Create('Error abriendo la base de datos');
    end;
  end
  else
    Exception.Create('Error abriendo la base de datos desde CFG');
end;

end.

