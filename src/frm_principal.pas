unit frm_Principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    MenuItem22: TMenuItem;
    prgUsuarios: TAction;
    MenuItem21: TMenuItem;
    tugDocentes: TAction;
    MenuItem20: TMenuItem;
    PrestListados: TAction;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    prestInventario: TAction;
    prestDevolucion: TAction;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    prestIniciar: TAction;
    estHistorico: TAction;
    estEgreso: TAction;
    estReimpIngreso: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    prgEditarLRF: TAction;
    estIngreso: TAction;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tugResponsables: TAction;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    tugAlumnos: TAction;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    prgSalir: TAction;
    listaAcciones: TActionList;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure estEgresoExecute(Sender: TObject);
    procedure estHistoricoExecute(Sender: TObject);
    procedure estIngresoExecute(Sender: TObject);
    procedure estReimpIngresoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure prgEditarLRFExecute(Sender: TObject);
    procedure prgSalirExecute(Sender: TObject);
    procedure prgUsuariosExecute(Sender: TObject);
    procedure tugAlumnosExecute(Sender: TObject);
    procedure tugDocentesExecute(Sender: TObject);
    procedure tugResponsablesExecute(Sender: TObject);
  private
    procedure Inicializar;
    procedure AjustarSeguridad;
  public
    { public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation
{$R *.lfm}
uses
  versioninfo
  ,frm_listadoalumnos
  ,frm_ListadoResponsables
  ,frm_ingresoesterilizar
  ,frm_egresoesterilizar
  ,frm_listadosesterilizar
  ,dmGeneral
  ,dmesterilizacion
  ,frm_validar
  ,dmvalidar
  ,frm_permisosAE
  ,dmalumnos
  ;

{ TfrmPrincipal }

(*******************************************************************************
*** Manejo del programa
*******************************************************************************)

procedure TfrmPrincipal.prgSalirExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.prgUsuariosExecute(Sender: TObject);
var
  pant: TfrmPermisosAE;
begin
  pant:= TfrmPermisosAE.Create (self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Inicializar;
  AjustarSeguridad;
end;



procedure TfrmPrincipal.prgEditarLRFExecute(Sender: TObject);
begin
  DM_General.LevantarReporte(_REP_TICKET, DM_Esterilizacion.tbEsterilizacion);
  DM_General.EditarReporte;
end;

procedure TfrmPrincipal.Inicializar;
var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  st.Panels[0].Text:= ' v:' + NroVersion;
{$IFDEF DESARROLLO}
  st.Panels[0].Text:= ' v:' + NroVersion + ' MODO DESARROLLO';
{$ENDIF}
  st.Panels[2].Text:= FormatDateTime('dd/mm/yyyy', now)+ '        ';
  st.Panels[1].Text:=  DM_Validar.Usuario;
end;

(*******************************************************************************
*** Manejo de seguridad
*******************************************************************************)

procedure TfrmPrincipal.AjustarSeguridad;
begin
  tugAlumnos.Enabled:= ((DM_Validar.pAlumnos = SEG_CONSULTAR) OR (DM_Validar.pAlumnos = SEG_TODO));
  tugResponsables.Enabled:= ((DM_Validar.pPersonal = SEG_CONSULTAR) OR (DM_Validar.pPersonal = SEG_TODO));
  estIngreso.Enabled:= (DM_Validar.pEstMaterial = SEG_TODO);
  estEgreso.Enabled:= (DM_Validar.pEstMaterial = SEG_TODO);
  prgEditarLRF.Enabled:= (DM_Validar.pAplicacion = SEG_TODO);
  estReimpIngreso.Enabled:= (DM_Validar.pEstMaterial = SEG_TODO);
  estHistorico.Enabled:= ((DM_Validar.pEstHistorico = SEG_CONSULTAR) OR (DM_Validar.pEstHistorico = SEG_TODO));
  prestIniciar.Enabled:= (DM_Validar.pArticulos = SEG_TODO);
  prestDevolucion.Enabled:= (DM_Validar.pArticulos = SEG_TODO);
  prestInventario.Enabled:= (DM_Validar.pArticulos = SEG_TODO);
  PrestListados.Enabled:= (DM_Validar.pArticulos = SEG_TODO);
  prgUsuarios.Enabled:= (DM_Validar.pAplicacion = SEG_TODO);
end;


(*******************************************************************************
*** Manejo de tablas generales
*******************************************************************************)

procedure TfrmPrincipal.tugAlumnosExecute(Sender: TObject);
var
  pant: TfrmListadoAlumnos;
begin
//  if ValidarAcceso(SEG_ADMINISTRADOR) then
  begin
    pant:= TfrmListadoAlumnos.Create (self);
    pant.refCategoria:= CAT_ALUMNO;
    pant.Show;
  end;
end;

procedure TfrmPrincipal.tugDocentesExecute(Sender: TObject);
var
  pant: TfrmListadoAlumnos;
begin
  begin
    pant:= TfrmListadoAlumnos.Create (self);
    pant.refCategoria:= CAT_DOCENTE;
    pant.Show;
  end;
end;

procedure TfrmPrincipal.tugResponsablesExecute(Sender: TObject);
var
  pant: TfrmListadoResponsables;
begin
//  if ValidarAcceso(SEG_ADMINISTRADOR) then
  begin
    pant:= TfrmListadoResponsables.Create (self);
    pant.Show;
  end;
end;

(*******************************************************************************
*** Manejo de material para Esterilización
*******************************************************************************)

procedure TfrmPrincipal.estIngresoExecute(Sender: TObject);
var
  pant: TfrmIngresoEsterilizar;
begin
//  if ValidarAcceso(SEG_OPERADOR) then
  begin
    pant:= TfrmIngresoEsterilizar.Create(self);
    pant.Show;
  end;
end;

procedure TfrmPrincipal.estReimpIngresoExecute(Sender: TObject);
var
  elValor: string;
begin
//  if ValidarAcceso(SEG_ADMINISTRADOR) then
  begin
    if InputQuery('Reimpresión','Nro de Orden a reimprimir', elValor) then
      DM_Esterilizacion.reimprimirPorNroOrden(StrToIntDef(elValor,0));
  end;
end;

procedure TfrmPrincipal.estEgresoExecute(Sender: TObject);
var
  pant: TfrmEgresoEsterilizacion;
begin
  pant:= TfrmEgresoEsterilizacion.Create(self);
  pant.Show;
end;

procedure TfrmPrincipal.estHistoricoExecute(Sender: TObject);
var
  pant: TfrmListadoEsterilizar;
begin
  pant:= TfrmListadoEsterilizar.Create(self);
  pant.Show;
end;


end.

