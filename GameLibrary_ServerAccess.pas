unit GameLibrary_ServerAccess;

{$I RemObjects.inc}

interface

uses
  {$IFDEF DELPHIXE2UP}System.SysUtils{$ELSE}SysUtils{$ENDIF},
  {$IFDEF DELPHIXE2UP}System.Classes{$ELSE}Classes{$ENDIF},
  uROComponent,
  uROMessage,
  uROBaseConnection,
  uROTransportChannel,
  uROBinMessage,
  uROBaseHTTPClient,
  uROIndyHTTPChannel,
  GameLibrary_Intf, System.TypInfo, uROClientIntf, uROAsync, uROServerLocator;

type
  { Forward declarations }
  TServerAccess_GameLibrary = class;

  TServerAccess_GameLibrary = class(TDataModule)
  private
    fServerUrl: String;
    function get__ServerUrl: String;
    function get__GameService: IGameService;
    function get__GameService_Async: IGameService_Async;
    function get__GameService_AsyncEx: IGameService_AsyncEx;
  public
    property ServerUrl: String read get__ServerUrl;
    property GameService: IGameService read get__GameService;
    property GameService_Async: IGameService_Async read get__GameService_Async;
    property GameService_AsyncEx: IGameService_AsyncEx read get__GameService_AsyncEx;
  published
    Message: TROBinMessage;
    Channel: TROIndyHTTPChannel;
    procedure DataModuleCreate(Sender: TObject);
  end;

function ServerAccess: TServerAccess_GameLibrary;
implementation

{$IFDEF DELPHIXE2}
  {%CLASSGROUP 'System.Classes.TPersistent'}
{$ENDIF}
{$R *.dfm}

const SERVER_URL = 'http://localhost:8099/bin';
var fServerAccess: TServerAccess_GameLibrary;

function ServerAccess: TServerAccess_GameLibrary;
begin
  if not assigned(fServerAccess) then begin
    fServerAccess := TServerAccess_GameLibrary.Create(nil);
  end;
  result := fServerAccess;
  exit;
end;

procedure TServerAccess_GameLibrary.DataModuleCreate(Sender: TObject);
begin
  Self.fServerUrl := SERVER_URL;
  Self.Channel.TargetUrl := Self.fServerUrl;
end;

function TServerAccess_GameLibrary.get__ServerUrl: String;
begin
  result := Self.fServerUrl;
  exit;
end;

function TServerAccess_GameLibrary.get__GameService: IGameService;
begin
  result := CoGameService.Create(Self.Message, Self.Channel);
  exit;
end;

function TServerAccess_GameLibrary.get__GameService_Async: IGameService_Async;
begin
  result := CoGameService_Async.Create(Self.Message, Self.Channel);
  exit;
end;

function TServerAccess_GameLibrary.get__GameService_AsyncEx: IGameService_AsyncEx;
begin
  result := CoGameService_AsyncEx.Create(Self.Message, Self.Channel);
  exit;
end;

initialization
finalization
  fServerAccess.Free();
end.
