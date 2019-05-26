unit fServerForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  uROClient, uROPoweredByRemObjectsButton, uROClientIntf, uROServer,
  uROBaseConnection, uROCustomHTTPServer, uROBaseHTTPServer, uROComponent, uROMessage,
  uROBinMessage, uROIndyHTTPServer, System.TypInfo, uROServerIntf,
  uROCustomRODLReader;

type
  TServerForm = class(TForm)
    ROPoweredByRemObjectsButton1: TROPoweredByRemObjectsButton;
    ROMessage: TROBinMessage;
    ROServer: TROIndyHTTPServer;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServerForm: TServerForm;

implementation
uses
 uRORTTIServerSupport;

{$R *.dfm}

procedure TServerForm.FormCreate(Sender: TObject);
begin
  ROServer.Active := true;
end;

initialization
  uRORTTIServerSupport.RODLLibraryName := 'GameLibrary';
end.
