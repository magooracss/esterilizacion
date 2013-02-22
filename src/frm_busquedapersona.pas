unit frm_busquedapersona;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids
  ,dmGeneral, db
  ;

const
  PER_DOCENTE = 'D';
  PER_ALUMNO = 'A';
  PER_MATERIAL = 'T'; //Puede ser alumno, docente o cualquiera que ingrese material
  PER_RESPONSABLE = 'R';
  CRIT_APELLIDO = 0;
  CRIT_LEGAJO = 1;

type

  { TfrmBuscarPersonas }

  TfrmBuscarPersonas = class(TForm)
    btnAceptar: TBitBtn;
    btnBuscar: TBitBtn;
    DS_Resultados: TDatasource;
    GrillaResultados: TDBGrid;
    edDato: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgCriterio: TRadioGroup;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure edDatoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    _tipoPersona: Char;
    function getApyNomPersona: string;
    function getIdPersona: GUID_ID;
    procedure Inicializar;
    procedure Buscar;
  public
    property TipoPersona: Char read _tipoPersona write _tipoPersona;
    property idPersona: GUID_ID read getIdPersona;
    property ApyNomPersona: string read getApyNomPersona;
  end;

var
  frmBuscarPersonas: TfrmBuscarPersonas;

implementation
{$R *.lfm}
uses
  dmalumnos
  ,dmresponsables
  ;

{ TfrmBuscarPersonas }

procedure TfrmBuscarPersonas.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBuscarPersonas.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBuscarPersonas.edDatoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   Buscar;
end;

procedure TfrmBuscarPersonas.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmBuscarPersonas.getIdPersona: GUID_ID;
begin
  case _tipoPersona of
        PER_RESPONSABLE: Result:=  DM_Responsables.idResponsableActual;
        PER_ALUMNO: Result:=  dm_alumnos.idAlumnoActual;
        PER_DOCENTE: Result:=  dm_alumnos.idAlumnoActual;
        PER_MATERIAL: Result:=  dm_alumnos.idAlumnoActual;
  end;
end;

function TfrmBuscarPersonas.getApyNomPersona: string;
begin
  case _tipoPersona of
        PER_RESPONSABLE: Result:= DM_Responsables.ApyNomResponsableActual;
        PER_ALUMNO: Result:= dm_alumnos.ApyNomAlumnoActual;
        PER_DOCENTE: Result:= dm_alumnos.ApyNomAlumnoActual;
        PER_MATERIAL: Result:= dm_alumnos.ApyNomAlumnoActual;
  end;
end;

procedure TfrmBuscarPersonas.Inicializar;
begin
  rgCriterio.ItemIndex:= 0;
  edDato.Clear;
  case _tipoPersona of
       PER_RESPONSABLE:
       begin
         DS_Resultados.DataSet:= DM_Responsables.tbResponsable ;
         GrillaResultados.Columns.Items[0].FieldName:= 'Legajo';
         DM_Responsables.Inicializar;
       end;
       PER_ALUMNO:
       begin
         DS_Resultados.DataSet:= dm_alumnos.tbAlumnos;
         GrillaResultados.Columns.Items[0].FieldName:= 'NroAlumno';
         dm_alumnos.inicializar;
       end;
       PER_DOCENTE:
       begin
         DS_Resultados.DataSet:= dm_alumnos.tbAlumnos;
         GrillaResultados.Columns.Items[0].FieldName:= 'NroAlumno';
         dm_alumnos.inicializar;
       end;
       PER_MATERIAL:
       begin
         DS_Resultados.DataSet:= dm_alumnos.tbAlumnos;
         GrillaResultados.Columns.Items[0].FieldName:= 'NroAlumno';
         dm_alumnos.inicializar;
       end;

  end;
  edDato.SetFocus;
end;

procedure TfrmBuscarPersonas.Buscar;
begin
  Case rgCriterio.ItemIndex of
       CRIT_APELLIDO:
                     Case _tipoPersona of
                          PER_ALUMNO: dm_alumnos.BuscarAlumnoApellido (Trim(edDato.Text));
                          PER_DOCENTE: dm_alumnos.BuscarDocenteApellido (Trim(edDato.Text));
                          PER_MATERIAL: dm_alumnos.BuscarPersonaApellido (Trim(edDato.Text));
                          PER_RESPONSABLE: DM_Responsables.BuscarResponsableApellido (Trim(edDato.Text));
                     end;
       CRIT_LEGAJO:
                     Case _tipoPersona of
                          PER_ALUMNO: dm_alumnos.BuscarAlumnoLegajo (StrToIntDef(edDato.Text,0));
                          PER_DOCENTE: dm_alumnos.BuscarDocenteLegajo (StrToIntDef(edDato.Text,0));
                          PER_MATERIAL: dm_alumnos.BuscarPersonaLegajo (StrToIntDef(edDato.Text,0));
                          PER_RESPONSABLE: DM_Responsables.BuscarResponsableLegajo (StrToIntDef(edDato.Text,0));
                     end;
  end;
end;

end.

