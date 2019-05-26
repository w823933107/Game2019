program PigheaderClient;

uses
  uROComInit,
  Forms,
  fClientForm in 'fClientForm.pas' {ClientForm},
  GameLibrary_Intf in 'GameLibrary_Intf.pas',
  uGame in 'uGame.pas',
  uObj in 'uObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClientForm, ClientForm);
  Application.Run;
end.
