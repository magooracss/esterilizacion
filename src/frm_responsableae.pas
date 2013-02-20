unit frm_responsableae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, Forms, Controls, Graphics,
  Dialogs, DbCtrls, ExtCtrls, StdCtrls, Buttons, ExtDlgs, ComCtrls, dmGeneral
  ;

type

  { TfrmResponsableae }

  TfrmResponsableae = class(TForm)
    btnGrabarySalir: TBitBtn;
    btnCancelar: TBitBtn;
    btnFotoAgregar: TBitBtn;
    btnFotoQuitar: TBitBtn;
    cbTipoDoc: TComboBox;
    cbDiaFranco: TComboBox;
    cbGrupo: TComboBox;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DS_fotos: TDatasource;
    DBImage1: TDBImage;
    DS_Responsable: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBMemo1: TDBMemo;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
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
    procedure FormShow(Sender: TObject);
  private
    _idResponsable: GUID_ID;
    procedure Inicializar;
  public
   property idResponsable: GUID_ID read _idResponsable write _idResponsable;
  end;

var
  frmResponsableae: TfrmResponsableae;

implementation
{$R *.lfm}
uses
  dmresponsables
  ,dmfotos
  ;
{ TfrmResponsableae }

procedure TfrmResponsableae.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idResponsable = GUIDNULO then
    _idResponsable:= DM_Responsables.crearResponsable
  else
  begin
    DM_Responsables.levantarResponsable (_idResponsable);
    cbTipoDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoDoc, DM_Responsables.tbResponsablerefTipoDoc.AsInteger);
  end;
  cbGrupo.ItemIndex:= DM_General.obtenerIdxCombo(cbGrupo, DM_Responsables.tbResponsablerefGrupo.AsInteger);
  cbDiaFranco.ItemIndex:= DM_Responsables.tbResponsableFrancoDia.AsInteger;
end;

procedure TfrmResponsableae.btnFotoAgregarClick(Sender: TObject);
begin
//  if opt.Execute then
//    DM_Fotos.cargarArchivo(_idAlumno, opt.FileName);
end;

procedure TfrmResponsableae.btnGrabarySalirClick(Sender: TObject);
var
  idx: integer;
begin
  idx:= DM_General.obtenerIDIntComboBox(cbTipoDoc);
  DM_Responsables.ActualizarCombos (idx, DM_General.obtenerIDIntComboBox(cbGrupo), cbDiaFranco.ItemIndex);
  DM_Responsables.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmResponsableae.DBEdit3Exit(Sender: TObject);
begin
  if DS_Responsable.DataSet.State in dsEditModes then
    DS_Responsable.DataSet.FieldByName('TarjetaLegajo').asInteger:= DS_Responsable.DataSet.FieldByName('legajo').asInteger;

end;

procedure TfrmResponsableae.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmResponsableae.Inicializar;
begin
//  DM_Fotos:= TDM_Fotos.Create(self);
//  dm_alumnos:= Tdm_alumnos.Create(self);
  DM_General.CargarComboBox(cbTipoDoc,'TipoDocumento', 'idTipoDocumento', DM_Responsables.qTiposDocumento);
  DM_General.CargarComboBox(cbGrupo,'GrupoResponsable', 'idGrupoResponsable', DM_Responsables.qGruposResponsables);

  cbTipoDoc.ItemIndex:= 1;
end;

end.

