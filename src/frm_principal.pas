unit frm_Principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus, ExtCtrls
  , dminventario
  ;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    MenuItem23: TMenuItem;
    prestListadoPrestado: TAction;
    Image1: TImage;
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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure prestDevolucionExecute(Sender: TObject);
    procedure prestIniciarExecute(Sender: TObject);
    procedure prestInventarioExecute(Sender: TObject);
    procedure prestListadoPrestadoExecute(Sender: TObject);
    procedure prgEditarLRFExecute(Sender: TObject);
    procedure prgSalirExecute(Sender: TObject);
    procedure prgUsuariosExecute(Sender: TObject);
    procedure tugAlumnosExecute(Sender: TObject);
    procedure tugDocentesExecute(Sender: TObject);
    procedure tugResponsablesExecute(Sender: TObject);
  private
    procedure Inicializar;
    procedure AjustarSeguridad;

    procedure pantPrestamos (Estado: TEstado);
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
  ,frm_listadoinventario
  ,SD_Configuracion
  ,frm_listadoprestamos
  ,frm_prestasmossd
  ;

{ TfrmPrincipal }

(*******************************************************************************
*** Manejo del programa
*******************************************************************************)

procedure TfrmPrincipal.prgSalirExecute(Sender: TObject);
begin
  EscribirDato(SECCION_APP, FRM_Y, IntToStr(self.Top));
  EscribirDato(SECCION_APP, FRM_X, IntToStr(self.Left));
  if (MessageDlg ('ATENCION'
                ,'Realmente desea salir del programa?'
                , mtConfirmation
                , [mbYes, mbNo]
                ,0 ) = mrYes) then
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
  self.top:= strToIntDef(LeerDato(SECCION_APP, FRM_Y),0);
  self.Left:= strToIntDef(LeerDato(SECCION_APP, FRM_X),0);
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
  prestIniciar.Enabled:= (DM_Validar.pPrestArticulos = SEG_TODO);
  prestDevolucion.Enabled:= (DM_Validar.pPrestArticulos = SEG_TODO);
  prestInventario.Enabled:= (DM_Validar.pPrestArticulos = SEG_TODO);
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
  pant:= TfrmListadoAlumnos.Create (self);
  pant.refCategoria:= CAT_ALUMNO;
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.tugDocentesExecute(Sender: TObject);
var
  pant: TfrmListadoAlumnos;
begin
  pant:= TfrmListadoAlumnos.Create (self);
  pant.refCategoria:= CAT_DOCENTE;
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;

end;

procedure TfrmPrincipal.tugResponsablesExecute(Sender: TObject);
var
  pant: TfrmListadoResponsables;
begin
  pant:= TfrmListadoResponsables.Create (self);
  try
   pant.ShowModal;
  finally
    pant.Free;
  end;
end;

(*******************************************************************************
*** Manejo de material para Esterilización
*******************************************************************************)

procedure TfrmPrincipal.estIngresoExecute(Sender: TObject);
var
  pant: TfrmIngresoEsterilizar;
begin
  pant:= TfrmIngresoEsterilizar.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.estReimpIngresoExecute(Sender: TObject);
var
  elValor: string;
begin
  begin
    if InputQuery('Reimpresión','Nro de Orden a reimprimir', elValor) then
      DM_Esterilizacion.reimprimirPorNroOrden(StrToIntDef(elValor,0));
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin

end;

procedure TfrmPrincipal.estEgresoExecute(Sender: TObject);
var
  pant: TfrmEgresoEsterilizacion;
begin
  pant:= TfrmEgresoEsterilizacion.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPrincipal.estHistoricoExecute(Sender: TObject);
var
  pant: TfrmListadoEsterilizar;
begin
  pant:= TfrmListadoEsterilizar.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

(*******************************************************************************
*** Manejo de material para Inventario
*******************************************************************************)
procedure TfrmPrincipal.prestInventarioExecute(Sender: TObject);
var
  pant: TfrmListadoInventario;
begin
  pant:= TfrmListadoInventario.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;

end;

procedure TfrmPrincipal.prestListadoPrestadoExecute(Sender: TObject);
var
  pant: TfrmListadoPrestamos;
begin
  pant:= TfrmListadoPrestamos.Create (self);
  pant.Show;
end;


(*******************************************************************************
*** Prestamos
*******************************************************************************)

procedure TfrmPrincipal.pantPrestamos(Estado: TEstado);
var
  pant: TfrmPrestamosSD;
begin
  pant:= TfrmPrestamosSD.Create(self);
  try
    pant.estado:= Estado;
    pant.ShowModal;
  finally
    pant.Free;
    DM_Inventario.LevantarPrestamosOtorgados;
  end;
end;


procedure TfrmPrincipal.prestIniciarExecute(Sender: TObject);
begin
  pantPrestamos (Iniciado);
end;


procedure TfrmPrincipal.prestDevolucionExecute(Sender: TObject);
begin
  pantPrestamos (Finalizado);
end;


end.

