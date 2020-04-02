program AppChamada;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  UModelo in 'UModelo.pas' {FModelo},
  uOpenViewUrl in 'uOpenViewUrl.pas',
  USobre in 'USobre.pas' {FSobre},
  UConfiguracao in 'UConfiguracao.pas' {FConfiguracao},
  UCadClientes in 'UCadClientes.pas' {FCadCliente},
  ULancamento in 'ULancamento.pas' {FLancamento};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFLancamento, FLancamento);
  Application.Run;
end.
