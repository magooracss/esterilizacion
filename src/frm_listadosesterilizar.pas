unit frm_listadosesterilizar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons, EditBtn, MaskEdit
  ,dmGeneral, db;

type

  { TfrmListadoEsterilizar }

  TfrmListadoEsterilizar = class(TForm)
    btnAlumnoBuscar: TBitBtn;
    btnObtenerDatos: TBitBtn;
    btnRespBuscar: TBitBtn;
    btnSalir: TBitBtn;
    btnImprimir: TBitBtn;
    ds_historico: TDatasource;
    DBGrid1: TDBGrid;
    edFechaFin: TDateEdit;
    edFechaIni: TDateEdit;
    edHoraFin: TMaskEdit;
    edHoraIni: TMaskEdit;
    edRegistros: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbAlumno: TLabel;
    lbResponsable: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    rbAlumnIndividual: TRadioButton;
    rbAlumnTodos: TRadioButton;
    rbFechaTipo: TRadioGroup;
    Panel1: TPanel;
    Panel2: TPanel;
    rbRespIndividual: TRadioButton;
    rbRespTipo: TRadioGroup;
    rbRespTodos: TRadioButton;
    rgEstado: TRadioGroup;
    procedure btnImprimirClick(Sender: TObject);
    procedure btnObtenerDatosClick(Sender: TObject);
    procedure btnAlumnoBuscarClick(Sender: TObject);
    procedure btnRespBuscarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox3Click(Sender: TObject);
    procedure rbAlumnTodosClick(Sender: TObject);
    procedure rbRespTodosClick(Sender: TObject);
  private
    idAlumno: GUID_ID;
    idResponsable: GUID_ID;
    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmListadoEsterilizar: TfrmListadoEsterilizar;

implementation
{$R *.lfm}

uses
  dateutils
  ,frm_listadoalumnos
  ,frm_ListadoResponsables
  ,dmesterilizacion
  ;

{ TfrmListadoEsterilizar }


(*******************************************************************************
**** PANTALLA
*******************************************************************************)

procedure TfrmListadoEsterilizar.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmListadoEsterilizar.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
end;

procedure TfrmListadoEsterilizar.FormCreate(Sender: TObject);
begin

end;

procedure TfrmListadoEsterilizar.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmListadoEsterilizar.GroupBox3Click(Sender: TObject);
begin

end;


procedure TfrmListadoEsterilizar.rbAlumnTodosClick(Sender: TObject);
begin
  idAlumno:= GUIDNULO;
  lbAlumno.Caption:= '-----------------';
end;

procedure TfrmListadoEsterilizar.rbRespTodosClick(Sender: TObject);
begin
  idResponsable:= GUIDNULO;
  lbResponsable.Caption:= '-----------------';
end;

procedure TfrmListadoEsterilizar.Inicializar;
var
  d,m,y: word;
begin
  DM_General.ReiniciarTabla(DM_Esterilizacion.tbListadoEsterilizacion);
  DecodeDate(Now, y,m,d);
  edFechaIni.Date:= EncodeDate(y,m,1);
  edFechaFin.Date:= EncodeDate(y,m,DaysInAMonth(y,m));
  rbFechaTipo.ItemIndex:= 0;
  rbAlumnTodos.Checked:= True;
  rbRespTodos.Checked:= True;
  rbRespTipo.ItemIndex:= 0;
  rgEstado.ItemIndex:= 0 ;
  idAlumno:= GUIDNULO;
  lbAlumno.Caption:= '-----------------';
  idResponsable:= GUIDNULO;
  lbResponsable.Caption:= '-----------------';
  edHoraIni.Text:= '00:00';
  edHoraFin.Text:= '23:59';
end;

(*******************************************************************************
**** Búsqueda de alumnos
*******************************************************************************)

procedure TfrmListadoEsterilizar.btnAlumnoBuscarClick(Sender: TObject);
var
  pant: TfrmListadoAlumnos;
begin
  lbAlumno.Caption:= EmptyStr;
  pant:= TfrmListadoAlumnos.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      idAlumno:= pant.idAlumnoSeleccionado;
      lbAlumno.Caption:= pant.ApyNomAlumnoSeleccionado;
    end
    else
    begin
     idAlumno:= GUIDNULO;
     lbAlumno.Caption:= EmptyStr;
    end;
  finally
    pant.free;
  end;
end;


(*******************************************************************************
**** Búsqueda de responsables
*******************************************************************************)
procedure TfrmListadoEsterilizar.btnRespBuscarClick(Sender: TObject);
var
  pant: TfrmListadoResponsables;
begin
  pant:= TfrmListadoResponsables.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      idResponsable:= pant.idResponsableSeleccionado;
      lbResponsable.Caption:= pant.ApyNomResponsableSelecciondo;
    end
    else
    begin
      idResponsable:= GUIDNULO;
      lbResponsable.Caption:= EmptyStr;
    end;
  finally
  end;
end;


(*******************************************************************************
**** Obtener Parámetros
*******************************************************************************)

procedure TfrmListadoEsterilizar.btnObtenerDatosClick(Sender: TObject);
var
 hIni, hFin: TTime;
begin
  hIni:= StrToTime(edHoraIni.Text);
  hFin:= StrToTime(edHoraFin.Text);
  DM_General.IntervaloHorasConsulta(hIni, hFin);

  DM_Esterilizacion.ObtenerHistorico (  edFechaIni.Date
                                       ,edFechaFin.Date
                                       ,hIni
                                       ,hFin
                                       ,rbFechaTipo.ItemIndex
                                       ,idAlumno
                                       ,idResponsable
                                       ,rbRespTipo.ItemIndex
                                       ,rgEstado.ItemIndex
                                       );


  edRegistros.Text:= IntToStr(DM_Esterilizacion.CantRegHistorico);
end;

procedure TfrmListadoEsterilizar.btnImprimirClick(Sender: TObject);
begin
  DM_Esterilizacion.ImprimirHistorico;
end;

end.

