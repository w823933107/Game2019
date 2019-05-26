program Pigheader;

uses
  uROComInit,
  Forms,
  fServerForm in 'fServerForm.pas' {ServerForm},
  GameService_Impl in 'GameService_Impl.pas' {GameService: TRORemoteDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TServerForm, ServerForm);
  Application.Run;
end.
