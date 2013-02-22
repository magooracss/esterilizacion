unit dminventario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil;

type
  TDM_Inventario = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_Inventario: TDM_Inventario;

implementation

{$R *.lfm}

end.

