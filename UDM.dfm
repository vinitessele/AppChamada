object DM: TDM
  OldCreateOrder = False
  Height = 393
  Width = 535
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\vinic\Documents\Embarcadero\Studio\Projects\Ap' +
        'pChamada\Bd\bd.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 56
    Top = 16
  end
  object FDQParametro: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from parametro')
    Left = 48
    Top = 80
    object FDQParametroparametro_nome: TStringField
      FieldName = 'parametro_nome'
      Origin = 'parametro_nome'
      Size = 60
    end
    object FDQParametroparametro_logo: TBlobField
      FieldName = 'parametro_logo'
      Origin = 'parametro_logo'
    end
    object FDQParametroparametro_login: TStringField
      FieldName = 'parametro_login'
      Origin = 'parametro_login'
      Size = 100
    end
    object FDQParametroparametro_totalpontos: TIntegerField
      FieldName = 'parametro_totalpontos'
      Origin = 'parametro_totalpontos'
    end
    object FDQParametroparametro_premio: TStringField
      FieldName = 'parametro_premio'
      Origin = 'parametro_premio'
      Size = 100
    end
    object FDQParametroparametro_senha: TStringField
      FieldName = 'parametro_senha'
      Origin = 'parametro_senha'
      Size = 10
    end
  end
  object FDQClienteAll: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from cliente'
      'order by cliente_nome asc')
    Left = 151
    Top = 16
    object FDQClienteAllcliente_id: TFDAutoIncField
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQClienteAllcliente_cpf: TStringField
      FieldName = 'cliente_cpf'
      Origin = 'cliente_cpf'
      Size = 11
    end
    object FDQClienteAllcliente_nome: TStringField
      FieldName = 'cliente_nome'
      Origin = 'cliente_nome'
      Size = 60
    end
    object FDQClienteAllcliente_celular: TStringField
      FieldName = 'cliente_celular'
      Origin = 'cliente_celular'
      Size = 12
    end
    object FDQClienteAllcliente_email: TStringField
      FieldName = 'cliente_email'
      Origin = 'cliente_email'
      Size = 100
    end
    object FDQClienteAllcliente_img: TBlobField
      FieldName = 'cliente_img'
      Origin = 'cliente_img'
    end
  end
  object FDQCliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from cliente'
      'where cliente_nome like :nome')
    Left = 232
    Top = 16
    ParamData = <
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
        Value = 'n'
      end>
    object FDQClientecliente_id: TFDAutoIncField
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQClientecliente_cpf: TStringField
      FieldName = 'cliente_cpf'
      Origin = 'cliente_cpf'
      Size = 11
    end
    object FDQClientecliente_nome: TStringField
      FieldName = 'cliente_nome'
      Origin = 'cliente_nome'
      Size = 60
    end
    object FDQClientecliente_celular: TStringField
      FieldName = 'cliente_celular'
      Origin = 'cliente_celular'
      Size = 12
    end
    object FDQClientecliente_email: TStringField
      FieldName = 'cliente_email'
      Origin = 'cliente_email'
      Size = 100
    end
    object FDQClientecliente_img: TBlobField
      FieldName = 'cliente_img'
      Origin = 'cliente_img'
    end
  end
  object FDQPontuacao: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pontuacao')
    Left = 135
    Top = 88
    object FDQPontuacaopontuacao_id: TFDAutoIncField
      FieldName = 'pontuacao_id'
      Origin = 'pontuacao_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQPontuacaopontuacao_id_cliente: TIntegerField
      FieldName = 'pontuacao_id_cliente'
      Origin = 'pontuacao_id_cliente'
    end
    object FDQPontuacaopontuacao_pontos: TIntegerField
      FieldName = 'pontuacao_pontos'
      Origin = 'pontuacao_pontos'
    end
    object FDQPontuacaopontuacao_data: TDateField
      FieldName = 'pontuacao_data'
      Origin = 'pontuacao_data'
    end
  end
  object FDQSomaPontos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select coalesce(sum(pontuacao_pontos),0) as pontuacao from pontu' +
        'acao'
      'where pontuacao_id_cliente = :idCliente')
    Left = 39
    Top = 168
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    object FDQSomaPontospontuacao: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'pontuacao'
      Origin = 'pontuacao'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQPontuacaoZera: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pontuacao where pontuacao_id_cliente =:idcliente')
    Left = 239
    Top = 88
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
    object FDQPontuacaoZerapontuacao_id: TFDAutoIncField
      FieldName = 'pontuacao_id'
      Origin = 'pontuacao_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQPontuacaoZerapontuacao_id_cliente: TIntegerField
      FieldName = 'pontuacao_id_cliente'
      Origin = 'pontuacao_id_cliente'
    end
    object FDQPontuacaoZerapontuacao_pontos: TIntegerField
      FieldName = 'pontuacao_pontos'
      Origin = 'pontuacao_pontos'
    end
    object FDQPontuacaoZerapontuacao_data: TDateField
      FieldName = 'pontuacao_data'
      Origin = 'pontuacao_data'
    end
  end
  object FDQPontuacaoOrderbyDesc: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'select cliente_id, cliente_nome, coalesce(sum(pontuacao_pontos),' +
        '0) as pontuacao from cliente c'
      'inner join pontuacao p on c.cliente_id = p.pontuacao_id_cliente'
      'group by cliente_id')
    Left = 359
    Top = 88
    object FDQPontuacaoOrderbyDesccliente_id: TFDAutoIncField
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQPontuacaoOrderbyDesccliente_nome: TStringField
      FieldName = 'cliente_nome'
      Origin = 'cliente_nome'
      Size = 60
    end
    object FDQPontuacaoOrderbyDescpontuacao: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'pontuacao'
      Origin = 'pontuacao'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
