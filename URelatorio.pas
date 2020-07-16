unit URelatorio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IOUtils,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation;

type
  TFRelatorio = class(TFModelo)
    procedure FormShow(Sender: TObject);
  private
    procedure AddItem(codigo, qtepontos: integer; nome: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelatorio: TFRelatorio;

implementation

{$R *.fmx}

uses UDM;

procedure TFRelatorio.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQPontuacaoOrderbyDesc.Active := True;
  dm.FDQPontuacaoOrderbyDesc.Close;
  dm.FDQPontuacaoOrderbyDesc.Open();
  while not dm.FDQPontuacaoOrderbyDesc.Eof do
  begin
    AddItem(dm.FDQPontuacaoOrderbyDesccliente_id.AsInteger,
      dm.FDQPontuacaoOrderbyDescpontuacao.AsInteger,
      dm.FDQPontuacaoOrderbyDesccliente_nome.AsString);
    dm.FDQPontuacaoOrderbyDesc.Next;
  end;
end;

procedure TFRelatorio.AddItem(codigo, qtepontos: integer; nome: string);
var
  rect, rect_barra, rect_icone: TRectangle;
  lbl: TLabel;
  img: TImage;
  I: integer;
  pontos: integer;
begin
  pontos := trunc(qtepontos / 100);
  // fundo
  rect := TRectangle.Create(VertScrollBox1);
  with rect do
  begin
    Align := TAlignLayout.Top;
    Height := 110;
    Fill.Color := $FFFFFFFF;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    XRadius := 8;
    YRadius := 8;
    TagString := IntToStr(codigo);
  end;
  // Barra inferior...
  rect_barra := TRectangle.Create(rect);
  with rect_barra do
  begin
    Align := TAlignLayout.Bottom;
    Height := 55;
    Fill.Color := $FFF4F4F4;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Sides := [TSide.Left, TSide.Bottom, TSide.Right];
    XRadius := 8;
    YRadius := 8;
    Corners := [TCorner.BottomLeft, TCorner.BottomRight];
    HitTest := false;
    rect.AddObject(rect_barra);
  end;
  // Descricao...
  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FF333333;
    Text := nome;
    Width := 300;
    font.Size := 12;
    font.Style := [TFontStyle.fsBold];
    Position.X := 50;
    Position.Y := 20;
    rect.AddObject(lbl);
  end;
  // Pontuação
  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    Anchors := [TAnchorKind.akTop, TAnchorKind.akRight];
    TextSettings.FontColor := $FFCCCCCC;
    TextSettings.HorzAlign := TTextAlign.Trailing;
    Text := 'Quantidade de Estrelas';
    font.Size := 10;
    Width := 150;
    Position.X := -160;
    Position.Y := 7;
    rect.AddObject(lbl);
  end;
  // Valor resultado estimado...
  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    Anchors := [TAnchorKind.akTop, TAnchorKind.akRight];
    TextSettings.FontColor := $FF685FEE;
    TextSettings.HorzAlign := TTextAlign.Trailing;
    Text := IntToStr(pontos);
    font.Size := 13;
    Width := 150;
    Position.X := -160; // VertScrollBox1.Width - 180;
    Position.Y := 23;
    font.Style := [TFontStyle.fsBold];
    rect.AddObject(lbl);
  end;
  // Caixa de Icone...
  rect_icone := TRectangle.Create(rect);
  with rect_icone do
  begin
    Height := 30;
    Width := 30;
    Fill.Color := $FF08DABD;
    Stroke.Kind := TBrushKind.None;
    XRadius := 4;
    YRadius := 4;
    Position.X := 10;
    Position.Y := 12;
    HitTest := false;
    rect.AddObject(rect_icone);
  end;
  // Label do icone...
  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    Align := TAlignLayout.Client;
    Height := 20;
    TextSettings.FontColor := $FFFFFFFF;
    TextSettings.VertAlign := TTextAlign.Center;
    TextSettings.HorzAlign := TTextAlign.Center;
    Text := Copy(nome, 1, 1);
    font.Size := 12;
    font.Style := [TFontStyle.fsBold];
    rect_icone.AddObject(lbl);
  end;

  for I := 1 to pontos do
  begin
    img := TImage.Create(rect);
    with img do
    begin
{$IFDEF MSWINDOWS}
      bitmap.LoadFromFile
        (IOUtils.TPath.Combine
        ('C:\Users\vinic\Documents\Embarcadero\Studio\Projects\AppChamada\img\',
        'estrela36.png'));
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
      bitmap.LoadFromFile
        (IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
        'estrela36.png'));
{$ENDIF}
      Height := 30;
      Width := 30;
      Position.X := I*15;
      rect_barra.AddObject(img);
    end;
  end;

  VertScrollBox1.AddObject(rect);
end;

end.
