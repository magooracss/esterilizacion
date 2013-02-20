unit balanza;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TBalanza }
  TBalanza = class(TObject)
  public
    function leerPeso: double;
  end;

implementation

uses
  synaser
  , SD_Configuracion;

{ TBalanza }
function TBalanza.leerPeso: double;
var
  ser: TBlockSerial;
  x: integer;
  cad, procStr: string;
begin
{$IFNDEF DESARROLLO}
  ser := TBlockSerial.Create;
  try
    ser.Connect(LeerDato(SECCION_BALANZA, BCOM));

    for x := 1 to 3000 do
    begin
    end;

    ser.config(9600, 8, 'N', SB2, False, False);
    procStr := ser.RecvBufferStr(8, 5000);
    cad := EmptyStr;
    for x := 0 to Length(procStr) do
    begin
      if procStr[x] in ['0'..'9'] then
        cad := cad + procStr[x];
      if procStr[x] in [',', '.'] then
        cad := cad + ',';
    end;
    Result := StrToFloatDef(cad, 0.0);
  finally
    ser.Free;
  end;
{$ELSE}
  Result:= StrToFloatDef('21,125', 0.0);;
{$ENDIF}
end;

end.
