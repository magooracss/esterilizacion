unit frm_prestasmossd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RackCtls, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DbCtrls, Buttons, ExtCtrls
  ,dminventario;

type

  { TfrmPrestamosSD }

  TfrmPrestamosSD = class(TForm)
    btnSalir: TBitBtn;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    ds_alumnos: TDatasource;
    ds_responsable: TDatasource;
    ds_articulo: TDatasource;
    edArticulo: TEdit;
    edTarjetaAlumno: TEdit;
    edTarjetaResponsable: TEdit;
    gbAlumno: TGroupBox;
    gbResponsable: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ledAnos: TLEDDisplay;
    ledDias: TLEDDisplay;
    ledHoras: TLEDDisplay;
    ledMeses: TLEDDisplay;
    ledMinutos: TLEDDisplay;
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    procedure btnSalirClick(Sender: TObject);
    procedure edArticuloKeyPress(Sender: TObject; var Key: char);
    procedure edTarjetaAlumnoKeyPress(Sender: TObject; var Key: char);
    procedure edTarjetaResponsableKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    _Estado: TEstado;
    horaIngreso: TTime;
    fechaIngreso: TDate;
    procedure EstablecerHora;
  public
    property Estado: TEstado read _Estado write _Estado;
  end;

var
  frmPrestamosSD: TfrmPrestamosSD;

implementation
uses
   dmalumnos
  ,dmresponsables
  ,frm_aviso
  ;


{$R *.lfm}
{ TfrmPrestamosSD }



procedure TfrmPrestamosSD.btnSalirClick(Sender: TObject);
var
  pantAviso: TfrmAviso;
begin
  pantAviso:= nil;
  if (Estado = Finalizado) and
     (NOT DM_Inventario.AlumnoArticuloPrestado( ds_alumnos.DataSet.FieldByName('idAlumno').asString
                                               ,ds_articulo.DataSet.FieldByName('idInventario').asInteger
                                               )
     ) then
  begin
     pantAviso:= TfrmAviso.Create (self);
     pantAviso.mensaje:= 'No corresponde el alumno';
//     pantAviso.color:= clRed;
     pantAviso.ShowModal;
     edArticulo.SetFocus;
     pantAviso.Free;
  end
  else
  begin

    DM_Inventario.grabarPrestamo (ds_alumnos.DataSet.FieldByName('idAlumno').asString
                                ,ds_responsable.DataSet.FieldByName('idResponsable').asString
                                ,ds_articulo.DataSet.FieldByName('idInventario').asInteger
                                ,horaIngreso
                                ,fechaIngreso
                                ,_Estado
                                );
    DM_Inventario.ImprimirTicketPrestamo(DM_Inventario.prestamoID, Estado);
    ModalResult:= mrOK;
  end;
end;

procedure TfrmPrestamosSD.edArticuloKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    if DM_Inventario.BuscarArticuloCB(edArticulo.Text) then
    begin
     btnSalir.SetFocus;
    end
    else
      ShowMessage('No se encuentra el artículo seleccionado');
  end;
end;

procedure TfrmPrestamosSD.edTarjetaAlumnoKeyPress(Sender: TObject; var Key: char
  );
begin
  if key = #13 then
  begin
    if dm_alumnos.BuscarAlumnoCB (TRIM(edTarjetaAlumno.Text)) then
      edTarjetaResponsable.SetFocus
    else
    begin
      ShowMessage('Problemas al buscar el alumno en la Base de Datos');
      edTarjetaAlumno.SetFocus;
    end;
  end;
end;

procedure TfrmPrestamosSD.edTarjetaResponsableKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    if DM_Responsables.BuscarResponsableCB (TRIM(edTarjetaResponsable.Text)) then
     edArticulo.SetFocus
    else
    begin
     ShowMessage('Problemas al buscar el responsable en la Base de Datos');
     edTarjetaResponsable.SetFocus;
    end;
  end;

end;

procedure TfrmPrestamosSD.FormCreate(Sender: TObject);
begin
  DM_Inventario.Inicializar;
  DM_Responsables.Inicializar;
  dm_alumnos.inicializar;
end;

procedure TfrmPrestamosSD.Panel1Click(Sender: TObject);
begin

end;

procedure TfrmPrestamosSD.Timer1Timer(Sender: TObject);
begin
  EstablecerHora;
end;

procedure TfrmPrestamosSD.EstablecerHora;
var
    h,min,s,ms,d,m,y: word;
    momento: TDateTime;
begin

    momento:= Now;

    DecodeDate(momento,y,m,d);
    DecodeTime(momento,h,min,s,ms);

    horaIngreso:= momento;
    FechaIngreso:= momento;

    ledHoras.Value:= h;
    ledMinutos.Value:= min;

    ledDias.Value:= d;
    ledMeses.Value:= m;
    ledAnos.Value:= y;
end;

end.

