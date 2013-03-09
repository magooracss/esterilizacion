unit frm_aviso;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls;

type

  { TfrmAviso }

  TfrmAviso = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    stMensaje: TStaticText;
    procedure BitBtn1Click(Sender: TObject);
    procedure stMensajeClick(Sender: TObject);
  private
    procedure setColor(AValue: TColor);
    procedure setMensaje(AValue: string);
    { private declarations }
  public
    property mensaje: string write setMensaje;
    property color: TColor write setColor;

  end;

var
  frmAviso: TfrmAviso;

implementation

{$R *.lfm}

{ TfrmAviso }

procedure TfrmAviso.stMensajeClick(Sender: TObject);
begin
end;

procedure TfrmAviso.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmAviso.setColor(AValue: TColor);
begin
  frmAviso.color:= AValue;
end;

procedure TfrmAviso.setMensaje(AValue: string);
begin
  stMensaje.Caption:= AValue;
end;

end.

