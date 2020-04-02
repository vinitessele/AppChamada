unit UDM;

interface

uses
  System.SysUtils, IOUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQParametro: TFDQuery;
    FDQParametroparametro_nome: TStringField;
    FDQParametroparametro_logo: TBlobField;
    FDQParametroparametro_login: TStringField;
    FDQParametroparametro_totalpontos: TIntegerField;
    FDQParametroparametro_premio: TStringField;
    FDQParametroparametro_senha: TStringField;
    FDQClienteAll: TFDQuery;
    FDQClienteAllcliente_id: TFDAutoIncField;
    FDQClienteAllcliente_cpf: TStringField;
    FDQClienteAllcliente_nome: TStringField;
    FDQClienteAllcliente_celular: TStringField;
    FDQClienteAllcliente_email: TStringField;
    FDQClienteAllcliente_img: TBlobField;
    FDQCliente: TFDQuery;
    FDQPontuacao: TFDQuery;
    FDQSomaPontos: TFDQuery;
    FDQSomaPontospontuacao: TLargeintField;
    FDQClientecliente_id: TFDAutoIncField;
    FDQClientecliente_cpf: TStringField;
    FDQClientecliente_nome: TStringField;
    FDQClientecliente_celular: TStringField;
    FDQClientecliente_email: TStringField;
    FDQClientecliente_img: TBlobField;
    FDQPontuacaopontuacao_id: TFDAutoIncField;
    FDQPontuacaopontuacao_id_cliente: TIntegerField;
    FDQPontuacaopontuacao_pontos: TIntegerField;
    FDQPontuacaopontuacao_data: TDateField;
    FDQPontuacaoZera: TFDQuery;
    FDQPontuacaoZerapontuacao_id: TFDAutoIncField;
    FDQPontuacaoZerapontuacao_id_cliente: TIntegerField;
    FDQPontuacaoZerapontuacao_pontos: TIntegerField;
    FDQPontuacaoZerapontuacao_data: TDateField;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL := //
    ' CREATE TABLE IF NOT EXISTS parametro( ' + //
    ' parametro_nome varchar(60),   ' + //
    ' parametro_logo blob,          ' + //
    ' parametro_login varchar(100), ' + //
    ' parametro_totalpontos integer,' + //
    ' parametro_premio varchar(100),' + //
    ' parametro_senha varchar(10))  ';
  FDConnection1.ExecSQL(strSQL);
  strSQL := EmptyStr;

  strSQL := //
    ' CREATE TABLE IF NOT EXISTS cliente(   ' + //
    ' cliente_id integer not null primary key AUTOINCREMENT, ' + //
    ' cliente_cpf varchar(11),   ' + //
    ' cliente_nome varchar(60),   ' + //
    ' cliente_celular varchar(12), ' + //
    ' cliente_img blob , ' + //
    ' cliente_email varchar(100)) ';
  FDConnection1.ExecSQL(strSQL);

    strSQL := EmptyStr;
  strSQL := //
    ' CREATE TABLE IF NOT EXISTS pontuacao(   ' + //
    ' pontuacao_id integer not null primary key AUTOINCREMENT,      ' + //
    ' pontuacao_id_cliente integer,    ' + //
    ' pontuacao_pontos integer,    ' + //
     ' pontuacao_data date,  ' + //
    ' foreign key (pontuacao_id_cliente)references cliente(cliente_id)) ' ;
   FDConnection1.ExecSQL(strSQL);
end;

procedure TDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('C:\Users\vinic\Documents\Embarcadero\Studio\Projects\AppChamada\Bd\',
    'Bd.db');
{$ENDIF}
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine
    (System.IOUtils.TPath.GetDocumentsPath, 'Bd.db');
{$ENDIF}
  FDConnection1.Params.Values['DATABASE'] := strPath;
end;

end.
