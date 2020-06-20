unit UModelo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFModelo = class(TForm)
    ToolBar1: TToolBar;
    bntMenu: TSpeedButton;
    LabelMenu: TLabel;
    btnInf: TSpeedButton;
    RectRodape: TRectangle;
    Image1: TImage;
    LayoutCabecalho: TLayout;
    LabelMenuModelo: TLabel;
    VertScrollBox1: TVertScrollBox;
    procedure bntMenuClick(Sender: TObject);
    procedure btnInfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FModelo: TFModelo;

implementation

{$R *.fmx}

uses USobre;

procedure TFModelo.bntMenuClick(Sender: TObject);
begin
  close;
end;

procedure TFModelo.btnInfClick(Sender: TObject);
begin
  if not Assigned(FSobre) then
    FSobre := TFSobre.Create(nil);
  FSobre.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      sleep(500);
      FSobre := nil;
      FSobre.disposeof;
    end);
end;

end.
