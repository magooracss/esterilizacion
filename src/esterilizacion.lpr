program esterilizacion;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, memdslaz, rxnew, RackCtlsPkg, frm_Principal, dmGeneral,
  frm_listadoalumnos, dmalumnos, dmconexion, zcomponent, frm_alumnoae, dmfotos,
  frm_listadoresponsables, dmresponsables, frm_responsableae,
  frm_ingresoesterilizar, balanza, dmesterilizacion, frm_validar, dmvalidar,
  frm_egresoesterilizar, frm_listadosesterilizar
  { you can add units after this }
  ,controls, frm_permisosAE, frm_busquedapersona, frm_listadoinventario, 
dminventario, frm_inventarioae, frm_listadoprestamos, frm_prestasmossd, 
frm_aviso, frm_actualizardatos
;
{$R *.res}


begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(Tdm_conexion, dm_conexion);
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(Tdm_alumnos, dm_alumnos);
  Application.CreateForm(TDM_Responsables, DM_Responsables);
  Application.CreateForm(TDM_Esterilizacion, DM_Esterilizacion);
  Application.CreateForm(TDM_Validar, DM_Validar);
  Application.CreateForm(TDM_Inventario, DM_Inventario);

  frmValidacion := TfrmValidacion.Create(nil);
  if frmValidacion.ShowModal <> mrOK then
      Application.Terminate;

  frmValidacion.Free;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmListadoPrestamos, frmListadoPrestamos);
  frmListadoPrestamos.Show;
  Application.Run;
end.

