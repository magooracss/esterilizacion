unit frm_alumnoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, Forms, Controls, Graphics,
  Dialogs, DbCtrls, ExtCtrls, StdCtrls, Buttons, ExtDlgs, dmGeneral
  ;

type

  { TfrmAlumnoae }

  TfrmAlumnoae = class(TForm)
    btnGrabarySalir: TBitBtn;
    btnCancelar: TBitBtn;
    btnFotoAgregar: TBitBtn;
    btnFotoQuitar: TBitBtn;
    cbTipoDoc: TComboBox;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DS_fotos: TDatasource;
    DBImage1: TDBImage;
    DS_Alumnos: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBMemo1: TDBMemo;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    opt: TOpenPictureDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFotoAgregarClick(Sender: TObject);
    procedure btnGrabarySalirClick(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idAlumno: GUID_ID;
    _categoria: String;
    procedure Inicializar;
    procedure setCategoria(AValue: string);
  public
   property idAlumno: GUID_ID read _idAlumno write _idAlumno;
   property categoria: string read _categoria write setCategoria;
  end;

var
  frmAlumnoae: TfrmAlumnoae;

implementation
{$R *.lfm}
uses
  dmalumnos
  ,dmfotos
  ;
{ TfrmAlumnoae }

procedure TfrmAlumnoae.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idAlumno = GUIDNULO then
    _idAlumno:= dm_alumnos.crearAlumno
  else
  begin
    dm_alumnos.levantarAlumno (_idAlumno);
    cbTipoDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoDoc, dm_alumnos.tbAlumnosrefTipoDoc.AsInteger);
//    DM_Fotos.levantarFoto(_idAlumno);
  end;
end;

procedure TfrmAlumnoae.btnFotoAgregarClick(Sender: TObject);
begin
//  if opt.Execute then
//    DM_Fotos.cargarArchivo(_idAlumno, opt.FileName);
end;

procedure TfrmAlumnoae.btnGrabarySalirClick(Sender: TObject);
var
  idx: integer;
begin
  idx:= DM_General.obtenerIDIntComboBox(cbTipoDoc);
  dm_alumnos.ActualizarCombos (idx);
  dm_alumnos.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmAlumnoae.DBEdit3Exit(Sender: TObject);
begin
 if DS_Alumnos.DataSet.State in dsEditModes then
   DS_Alumnos.DataSet.FieldByName('TarjetaLegajo').asInteger:= DS_Alumnos.DataSet.FieldByName('nroAlumno').asInteger;
end;

procedure TfrmAlumnoae.FormCreate(Sender: TObject);
begin
 if _categoria = CAT_ALUMNO then
   (Sender as TfrmAlumnoae).Caption:= 'Alumno'
 else
   (Sender as TfrmAlumnoae).Caption:= 'Docente';
end;

procedure TfrmAlumnoae.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmAlumnoae.Inicializar;
begin
//  DM_Fotos:= TDM_Fotos.Create(self);
//  dm_alumnos:= Tdm_alumnos.Create(self);
  DM_General.CargarComboBox(cbTipoDoc,'TipoDocumento', 'idTipoDocumento', dm_alumnos.qTiposDocumento);
  cbTipoDoc.ItemIndex:= 1;
end;

procedure TfrmAlumnoae.setCategoria(AValue: string);
begin
  if _categoria=AValue then Exit;
  _categoria:=AValue;
  dm_alumnos.refCategoria := categoria;
end;


end.

