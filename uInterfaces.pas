unit uInterfaces;

interface

uses Winapi.Messages, OtlCommon, OtlTaskControl, uObj, OtlTask,
  Spring.Container;

const
  WM_LOG = WM_USER + 1;
  WM_STOP = WM_USER + 2;
  // 参数
  PARAM_EMULATOR_INFO = 'EmulatorInfo'; // 模拟器信息
  PARAM_ACCOUNT = 'account'; // 账号
  PARAM_PASSWORD = 'password'; // 密码
  PARAM_OBJ = 'obj'; // 插件对象
  PARAM_ALL = 'ParamAll';
  GAME_PACKAGE_NAME = 'com.tencent.ssss'; // 三生三世

type
  TEmulatorInfo = packed record
    index: Integer;
    title: string;
    ParentHwnd: Integer;
    BindHwnd: Integer;
    IsInAndroid: Boolean;
    Pid: Integer;
    VBpxPid: Integer;
  end;

  TGameData = packed record
    EmulatorInfo: TEmulatorInfo;
    Obj: IPighead;
    LogHwnd: Integer;
  end;

  PGameData = ^TGameData;
  IPighead = uObj.IPighead;

  IGameConfig = interface(IInvokable)
    ['{CE39F86D-9054-4397-B21B-3B2DEB1ABD0C}']
  end;

  IGameManger = interface(IInvokable { 使继承类有RTTI } )
    ['{51856D60-057E-452F-ACBA-0C157EB8D8A5}']
    function StartAll(monitor: IOmniTaskControlMonitor): Boolean; //
    function StartExistWnds(monitor: IOmniTaskControlMonitor): Boolean;
    procedure StopAll;
    procedure SortWnd;
  end;

  ITaskExcute = interface(IInvokable)
    ['{DEE75FB8-C3F8-4171-8D0C-00C278E6CAF6}']
    procedure Excute(task: IOmniTask; aGameData: PGameData); // 里面保存了所有相关的全局信息
  end;

  IGame = interface(ITaskExcute)
    ['{FFC22E96-D678-4BE3-936D-99ACA5C2D151}']
  end;

  TBase = class(TInterfacedObject, ITaskExcute)
  private
    FLogCount: Integer;
    FLastMsg: string;
  protected
    FIndex: Integer;
    FObj: IPighead;
    FGameData: PGameData;
    FTask: IOmniTask;
    FValueContainer: TOmniValueContainer;
    procedure Delay(const adelayTime: Integer; const interval: Integer = 100);
    procedure Log(Msg: string);
    procedure SendLogMessage(Msg: string);
  public
    procedure Excute(task: IOmniTask; aGameData: PGameData); virtual;
  end;

var
  gContainer: TContainer;

implementation

uses System.Diagnostics, Winapi.Windows;
{ TBase }

procedure TBase.Delay(const adelayTime, interval: Integer);
var
  astopwatch: TStopwatch;
  ms: Integer;
begin
  astopwatch := TStopwatch.StartNew;
  // if interval > 1000 then
  // ms := 1000
  // else
  // ms := interval;
  repeat
    if astopwatch.ElapsedMilliseconds >= adelayTime then
      Break;
    Sleep(interval);
  until (FTask.Terminated);
end;

procedure TBase.Excute(task: IOmniTask; aGameData: PGameData);
begin
  FTask := task;
  FGameData := aGameData;
  FObj := FGameData.Obj;
  FIndex := FGameData.EmulatorInfo.index;
  // FValueContainer := task.Param[PARAM_ALL].AsArray;
  // FEmulatorInfo := task.Param[PARAM_EMULATOR_INFO].ToRecord<TEmulatorInfo>;
  // FObj := FValueContainer[PARAM_OBJ].AsInterface as IPighead;
end;

procedure TBase.Log(Msg: string);
var
  s: string;
  i: Integer;
begin
  SendLogMessage(Msg);
  if FGameData.LogHwnd > 0 then
  begin
    if Msg = FLastMsg then
    begin
      if FLogCount >= 10 then
        FLogCount := 0;
      for i := 0 to FLogCount - 1 do
        s := s + '.';
    end
    else
    begin
      FLastMsg := Msg;
    end;

    FObj.FoobarPrintText(FGameData.LogHwnd, Msg + s, 'ff0000');
    FObj.FoobarUpdate(FGameData.LogHwnd);
    Inc(FLogCount);
  end;

end;

procedure TBase.SendLogMessage(Msg: string);
begin
  FTask.Comm.Send(WM_LOG, Msg);
end;

{ TEmulatorInfo }

initialization

finalization

end.
