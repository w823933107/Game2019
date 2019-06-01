program PigheaderClient;

uses
  uROComInit,
  Forms,
  fClientForm in 'fClientForm.pas' {ClientForm},
  GameLibrary_Intf in 'GameLibrary_Intf.pas',
  uGameManager in 'uGameManager.pas',
  uObj in 'uObj.pas',
  uInterfaces in 'uInterfaces.pas',
  uRegistrations in 'uRegistrations.pas',
  uLd in 'uLd.pas',
  uGame in 'uGame.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClientForm, ClientForm);
  Application.Run;
end.
