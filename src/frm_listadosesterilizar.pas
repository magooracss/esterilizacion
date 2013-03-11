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
    btnObtenerDatos: TBitBtn;
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
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox3Click(Sender: TObject);
    procedure rbAlumnIndividualChange(Sender: TObject);
    procedure rbAlumnTodosClick(Sender: TObject);
    procedure rbRespIndividualChange(Sender: TObject);
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
  ,frm_busquedapersona
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
  //CloseAction:= caFree;
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

procedure TfrmListadoEsterilizar.rbAlumnIndividualChange(Sender: TObject);
var
 pant: TfrmBuscarPersonas;
begin
  if rbAlumnIndividual.Checked then
  begin
    lbAlumno.Caption:= EmptyStr;
    pant:= TfrmBuscarPersonas.Create (self);
    pant.TipoPersona:= PER_MATERIAL;
    try
      if pant.ShowModal = mrOK then
      begin
        idAlumno:= pant.idPersona;
        lbAlumno.Caption:= pant.ApyNomPersona;
      end
      else
      begin
       idAlumno:= GUIDNULO;
       lbAlumno.Caption:= EmptyStr;
      end;

      if idAlumno = GUIDNULO then
        rbAlumnTodos.Checked:= True;
    finally
      pant.free;
    end;
  end;
end;


(*******************************************************************************
**** Búsqueda de responsables
*******************************************************************************)

procedure TfrmListadoEsterilizar.rbRespIndividualChange(Sender: TObject);
var
  pant: TfrmBuscarPersonas;
begin
  if rbRespIndividual.Checked then
  begin
    lbResponsable.Caption:= EmptyStr;
    pant:= TfrmBuscarPersonas.Create (self);
    pant.TipoPersona:= PER_RESPONSABLE;
    try
      if pant.ShowModal = mrOK then
      begin
        idResponsable:= pant.idPersona;
        lbResponsable.Caption:= pant.ApyNomPersona;
      end
      else
      begin
        idResponsable:= GUIDNULO;
        lbResponsable.Caption:= EmptyStr;
      end;

      if idResponsable = GUIDNULO then
       rbRespTodos.Checked:= true;
    finally
    end;

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

