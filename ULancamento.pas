unit ULancamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Data.db,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFLancamento = class(TFModelo)
    VertScrollBox2: TVertScrollBox;
    LayoutTopo: TLayout;
    CircleFotoCliente2: TCircle;
    LabelCliente2: TLabel;
    Labelcelular2: TLabel;
    LayoutEntrada: TLayout;
    Label6: TLabel;
    RoundRect2: TRoundRect;
    BtnCartao: TButton;
    Layout3D1: TLayout3D;
    LayoutCartao: TLayout;
    RectangleCartao: TRectangle;
    LayoutCartaoDentro: TLayout;
    imgEstrela1: TImage;
    imgEstrela2: TImage;
    imgEstrela3: TImage;
    imgEstrela4: TImage;
    imgEstrela5: TImage;
    imgEstrela6: TImage;
    imgEstrela7: TImage;
    imgEstrela8: TImage;
    imgEstrela9: TImage;
    imgEstrela10: TImage;
    imgtrofeu1: TImage;
    StyleBook1: TStyleBook;
    LayoutNome: TLayout;
    EditNome: TEdit;
    btnBusca: TSpeedButton;
    Layout2: TLayout;
    ListViewNome: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure BtnCartaoClick(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure ListViewNomeItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure bntMenuClick(Sender: TObject);
  private
    procedure VisibleEstrela;
    { Private declarations }
  public
    { Public declarations }
    procedure VarificaPontos;
  end;

var
  FLancamento: TFLancamento;

implementation

{$R *.fmx}

uses UDM, UCadClientes
{$IFDEF ANDROID}
    , Androidapi.Helpers,
  FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
{$ENDIF ANDROID}
    ;

procedure TFLancamento.bntMenuClick(Sender: TObject);
begin
  close;
  inherited;
end;

procedure TFLancamento.btnBuscaClick(Sender: TObject);
begin
  inherited;
  dm.FDQCliente.close;
  dm.FDQCliente.ParamByName('nome').AsString := '%' + EditNome.Text + '%';
  dm.FDQCliente.Open();
end;

procedure TFLancamento.BtnCartaoClick(Sender: TObject);
begin
  inherited;

  dm.FDQPontuacao.Active := true;
  dm.FDQPontuacao.Append;
  dm.FDQPontuacaopontuacao_id_cliente.AsString :=
    dm.FDQClientecliente_id.AsString;
  dm.FDQPontuacaopontuacao_pontos.AsString := '100';
  dm.FDQPontuacaopontuacao_data.AsDateTime := Date;
  dm.FDQPontuacao.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Parab�ns voc� acaba de receber +100');
  VarificaPontos;

end;

procedure TFLancamento.ListViewNomeItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  vFoto: TStream;
begin
  inherited;
  LabelCliente2.Text := dm.FDQClientecliente_nome.AsString;
  Labelcelular2.Text := dm.FDQClientecliente_celular.AsString;
  vFoto := dm.FDQCliente.CreateBlobStream
    (dm.FDQCliente.FieldByName('cliente_img'), bmRead);
  if not dm.FDQClientecliente_img.IsNull then
  begin
    CircleFotoCliente2.Fill.Bitmap.Bitmap.LoadFromStream(vFoto);
  end;
  imgEstrela1.Visible := false;
  imgEstrela2.Visible := false;
  imgEstrela3.Visible := false;
  imgEstrela4.Visible := false;
  imgEstrela5.Visible := false;
  imgEstrela6.Visible := false;
  imgEstrela7.Visible := false;
  imgEstrela8.Visible := false;
  imgEstrela9.Visible := false;
  imgEstrela10.Visible := false;
  imgtrofeu1.Visible := false;
  VarificaPontos
end;

procedure TFLancamento.VarificaPontos;
var
  sql: string;
begin

  if dm.FDQClientecliente_id.AsString <> EmptyStr then
  begin
    dm.FDQSomaPontos.close;
    dm.FDQSomaPontos.ParamByName('idCliente').AsString :=
      dm.FDQClientecliente_id.AsString;
    dm.FDQSomaPontos.Open;

    if dm.FDQSomaPontospontuacao.AsString <> EmptyStr then
    begin

      if dm.FDQParametroparametro_totalpontos.AsInteger <=
        dm.FDQSomaPontospontuacao.AsInteger then
      begin
        imgEstrela10.Visible := true;
        imgtrofeu1.Visible := true;
        ShowMessage('Parab�ns voc� acaba de ' +
          dm.FDQParametroparametro_premio.AsString);

        MessageDlg('Deseja excluir a pontua��o?',
          System.UITypes.TMsgDlgType.mtInformation,
          [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
          procedure(const BotaoPressionado: TModalResult)
          begin
            case BotaoPressionado of
              mrYes:
                begin
                  sql := 'update pontuacao set pontuacao_pontos =0 where pontuacao_id_cliente =  '
                    + dm.FDQClientecliente_id.AsString;
                  dm.FDConnection1.ExecSQL(sql);
                  dm.FDConnection1.CommitRetaining;
                  ShowMessage('Pontua��o excluida com sucesso!');
                end;
              mrNo:
                begin
                  ShowMessage('OK');
                end;
            end;
          end);
      end;
      VisibleEstrela;
    end;
  end;
end;

procedure TFLancamento.VisibleEstrela;
begin
  if dm.FDQSomaPontospontuacao.AsInteger >= 100 then
  begin
    imgEstrela1.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 200 then
  begin
    imgEstrela2.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 300 then
  begin
    imgEstrela3.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 400 then
  begin
    imgEstrela4.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 500 then
  begin
    imgEstrela5.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 600 then
  begin
    imgEstrela6.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 700 then
  begin
    imgEstrela7.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 800 then
  begin
    imgEstrela8.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 900 then
  begin
    imgEstrela9.Visible := true;
  end;
  if dm.FDQSomaPontospontuacao.AsInteger >= 1000 then
  begin
    imgEstrela10.Visible := true;
    imgtrofeu1.Visible := true;
  end;
end;

end.
