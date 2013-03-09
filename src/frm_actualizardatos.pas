unit frm_actualizardatos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  Buttons, StdCtrls;

type

  { TfrmActualizarDatos }

  TfrmActualizarDatos = class(TForm)
    btnGrabar: TBitBtn;
    ds_alumno: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnGrabarClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmActualizarDatos: TfrmActualizarDatos;

implementation
{$R *.lfm}
uses
  dmalumnos
  ;

{ TfrmActualizarDatos }

procedure TfrmActualizarDatos.btnGrabarClick(Sender: TObject);
begin
  if dm_alumnos.camposObligatoriosCompletos then
  begin
    dm_alumnos.Grabar;
    ModalResult:= mrOK;
  end
  else
    ShowMessage('Falta completar los campos');
end;

end.

