unit GameService_Impl;

{$I RemObjects.inc}

interface

uses
  System.SysUtils, System.Classes, System.TypInfo,
  uROXMLIntf, uROClientIntf, uROClasses, uROTypes, uROServer, uROServerIntf,
  uROSessions,
  uRORemoteDataModule, uRORTTIAttributes, uRORTTIServerSupport, uROArray;

{$REGION 'brief info for Code-First Services'}
(*
  set library name, uid, namespace, documentation:
  uRORTTIServerSupport.RODLLibraryName := 'LibraryName';
  uRORTTIServerSupport.RODLLibraryID := '{2533A58A-49D9-47CC-B77A-FFD791F425BE}';
  uRORTTIServerSupport.RODLLibraryNamespace := 'namespace';
  uRORTTIServerSupport.RODLLibraryDocumentation := 'documentation';

  mandatory identificators for services/methods/event sinks:
  [ROService('name')] - name parameter is optional
  [ROServiceMethod('name')] - name parameter is optional
  [ROEventSink('name')] - name parameter is optional

  (optional) class factory - service attribute, only one should be used
  [ROStandardClassFactory] - used by default
  [ROSingletonClassFactory]
  [ROSynchronizedSingletonClassFactory]
  [ROPooledClassFactory(PoolSize,PoolBehavior,PreInitializePool)] - only 1st param is mandatore
  [ROPerClientClassFactory(TimeoutSeconds)]

  other (optional) attributes:
  [ROAbstract] - Marks the service as abstract. it cannot be called directly (service only)
  [ROServiceRequiresLogin] - Sets the 'RequiresSession' property to true at runtime. (service only)
  [RORole('role')]  - allow role (service&service methods only)
  [RORole('!role')] - deny role, (service&service methods only)
  [ROSkip] - for excluding type at generting RODL for clientside
  [ROCustom('myname','myvalue')] - custom attributes
  [RODocumentation('documentation')] - documentation
  [ROObsolete] - add "obsolete" message into documentation
  [ROObsolete('custom message')] - add specified message into documentation
  [ROEnumSoapName(EntityName,SoapEntityName)] - soap mapping. multiple (enums only)

  serialization mode for properties, method parameters, arrays and service's functions results
  [ROStreamAs(Ansi)]
  [ROStreamAs(UTF8)]

  backward compatibility attributes:
  [ROSerializeAsAnsiString] - alias for [ROStreamAs(Ansi)]
  [ROSerializeAsUTF8String] - alias for [ROStreamAs(UTF8)]
  [ROSerializeResultAsAnsiString] - alias for [ROStreamAs(Ansi)]
  [ROSerializeResultAsUTF8String] - alias for [ROStreamAs(UTF8)]
*)
{$ENDREGION}
{$REGION 'examples'}
(*
  [ROEnumSoapName('sxFemale','soap_sxFemale')]
  [ROEnumSoapName('sxMale','soap_sxMale')]
  TSex = (
  sxMale,
  sxFemale
  );
  TMyStruct = class(TROComplexType)
  private
  fA: Integer;
  published
  property A :Integer read fA write fA;
  [ROStreamAs(UTF8)]
  property AsUtf8: String read fAsUtf8 write fAsUtf8;
  end;

  TMyStructArray = class(TROArray<TMyStruct>);

  [ROStreamAs(UTF8)]
  TMyUTF8Array = class(TROArray<String>);

  [ROEventSink]
  IMyEvents = interface(IROEventSink)
  ['{75F9A466-518A-4B09-9DC4-9272B1EEFD95}']
  procedure OnMyEvent([ROStreamAs(Ansi)] const aStr: String);
  end;

  [ROService('MyService')]
  TMyService = class(TRORemoteDataModule)
  private
  public
  [ROServiceMethod]
  [ROStreamAs(Ansi)]
  function Echo([ROStreamAs(Ansi)] const aValue: string):string;
  end;

  simple usage of event sinks:
  //ev: IROEventWriter<IMyEvents>;
  ..
  ev := EventRepository.GetWriter<IMyEvents>(Session.SessionID);
  ev.Event.OnMyEvent('Message');

  for using custom class factories, use these attributes:
  [ROSingletonClassFactory]
  [ROSynchronizedSingletonClassFactory]
  [ROPooledClassFactory(PoolSize,PoolBehavior,PreInitializePool)]
  [ROPerClientClassFactory(TimeoutSeconds)]

  or replace
  -----------
  initialization
  RegisterCodeFirstService(TNewService1);
  end.
  -----------
  with
  -----------
  procedure Create_NewService1(out anInstance : IUnknown);
  begin
  anInstance := TNewService1.Create(nil);
  end;

  var
  fClassFactory: IROClassFactory;
  initialization
  fClassFactory := TROClassFactory.Create(__ServiceName, Create_NewService1, TRORTTIInvoker);
  //RegisterForZeroConf(fClassFactory, Format('_TRORemoteDataModule_rosdk._tcp.',[__ServiceName]));
  finalization
  UnRegisterClassFactory(fClassFactory);
  fClassFactory := nil;
  end.
  -----------
*)
{$ENDREGION}

const
  __ServiceName = 'GameService';

type

  [ROService(__ServiceName)]
  TGameService = class(TRORemoteDataModule)
  private
  public
    // [ROServiceMethod]
    // procedure NewMethod;
    [ROServiceMethod]
    function Helloworld: string;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
{ TGameService }

function TGameService.Helloworld: string;
begin

  Result := 'hellworld'
end;

initialization

RegisterCodeFirstService(TGameService);

end.
