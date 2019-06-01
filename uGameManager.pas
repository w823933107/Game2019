unit uGameManager;

interface

uses
  uLd, System.SysUtils, OtlTask, OtlTaskControl, uInterfaces, OtlParallel,
  OtlSync, OtlCommon;

type
  TGameManger = class(TInterfacedObject, IGameManger)
  private
    FLoop: IOmniParallelLoop<integer>;
    FCancellationToken: IOmniCancellationToken;
    //
    FTaskGroup: IOmniTaskGroup;
    FLock: IOmniCriticalSection;
    procedure Excute(const task: IOmniTask);
  public
    constructor Create();
    destructor Destroy; override;
    function StartAll(monitor: IOmniTaskControlMonitor): Boolean; // 运行所有
    function StartExistWnds(monitor: IOmniTaskControlMonitor): Boolean;
    procedure StopAll; // 停止所有
    // 运行已经打开的窗口
    function StartExistWndsEx(eventDispatcher: TObject): Boolean; // 运行已经打开的窗口
    procedure StopAllEx; // 停止所有
    procedure SortWnd; // 排序
  end;

implementation

uses
  CodeSiteLogging, Winapi.Windows, Winapi.ActiveX, System.Win.ComObj;
{ TGameManger }

constructor TGameManger.Create;
begin
  FTaskGroup := CreateTaskGroup;
  FLock := CreateOmniCriticalSection;
end;

destructor TGameManger.Destroy;
begin
  StopAll;
  inherited;
end;

procedure TGameManger.Excute(const task: IOmniTask);
var
  emulatorInfo: TEmulatorInfo;
  game: IGame;
  obj: IPighead;
  ValueContainer: TOmniValueContainer;
  gameData: TGameData;
begin
  OleCheck(CoInitializeEx(nil, COINIT_MULTITHREADED));
  obj := gContainer.Resolve<IPighead>; // 创建插件对象
  task.Comm.Send(WM_LOG, 'Create obj'); // 发送插件版本信息
  gameData.obj := obj;
  emulatorInfo := task.Param[PARAM_EMULATOR_INFO].ToRecord<TEmulatorInfo>;
  gameData.emulatorInfo := emulatorInfo;
  task.Comm.Send(WM_LOG, obj.Ver); // 发送插件版本信息
  // ValueContainer := task.Param[PARAM_ALL].AsArray; // 取得参数容器
  // ValueContainer[PARAM_OBJ] := obj; // 保存插件对象
  game := gContainer.Resolve<IGame>; // 创建game
  try
    task.Comm.Send(WM_LOG, 'start');
    task.Comm.Send(WM_LOG, emulatorInfo.title);
    game.Excute(task, @gameData);
  finally
    CoUninitialize;
  end;
end;

procedure TGameManger.SortWnd;
begin
  TLd.SortWnd;
end;

function TGameManger.StartAll(monitor: IOmniTaskControlMonitor): Boolean;
var
  I: integer;
  arr: TArray<TEmulatorInfo>;
  count: integer;
  aContorl: IOmniTaskControl;
begin
  Result := False;
  if FTaskGroup.Tasks.count > 0 then
    Exit;
  Result := True;
  arr := TLd.List2Ex();
  count := Length(arr);
  for I := 0 to count - 1 do
  begin
    // if arr[I].Pid > 0 then // 如果进程存在则创建
    // begin
    // 创建任务
    aContorl := CreateTask(Excute, I.ToString).MonitorWith(monitor)
      .Join(FTaskGroup).WithLock(FLock);
    // 设置模拟器参数
    aContorl.SetParameter(PARAM_EMULATOR_INFO, TOmniValue.FromRecord(arr[I]));
    aContorl.SetParameter(PARAM_ALL, TOmniValue.CreateNamed([])); // 预留一个供参数传递
    // end;
  end;
  FTaskGroup.RunAll;

end;

function TGameManger.StartExistWnds(monitor: IOmniTaskControlMonitor): Boolean;
var
  I: integer;
  arr: TArray<TEmulatorInfo>;
  count: integer;
  aContorl: IOmniTaskControl;
begin
  Result := False;
  if FTaskGroup.Tasks.count > 0 then
    Exit;
  Result := True;
  arr := TLd.List2Ex();
  count := Length(arr);
  for I := 0 to count - 1 do
  begin
    if arr[I].Pid > 0 then // 如果进程存在则创建
    begin
      // 创建任务
      aContorl := CreateTask(Excute, I.ToString).MonitorWith(monitor)
        .Join(FTaskGroup).WithLock(FLock);
      // 设置模拟器参数
      aContorl.SetParameter(PARAM_EMULATOR_INFO, TOmniValue.FromRecord(arr[I]));
      aContorl.SetParameter(PARAM_ALL, TOmniValue.CreateNamed([])); // 预留一个供参数传递
    end;
  end;
  FTaskGroup.RunAll;

end;

function TGameManger.StartExistWndsEx(eventDispatcher: TObject): Boolean;
var
  arr: TArray<TEmulatorInfo>;
  count: integer;
begin
  Result := False;
  if Assigned(FLoop) then
    Exit;
  Result := True;
  arr := TLd.List2Ex();
  count := Length(arr);
  FCancellationToken := CreateOmniCancellationToken;
  FLoop := Parallel.ForEach(0, count - 1);
  FLoop.TaskConfig(Parallel.TaskConfig.OnMessage(eventDispatcher));
  FLoop.NoWait.NumTasks(count);
  FLoop.CancelWith(FCancellationToken); // 设置取消令牌
  FLoop.OnStop(
    procedure(const task: IOmniTask)
    begin
      // task.Comm.Send(WM_STOP);
      FCancellationToken := nil;
      FLoop := nil;
    end);
  FLoop.Execute(
    procedure(const task: IOmniTask; const value: integer)
    begin
      // task.Param.Add('aa', 'mmmm');
      // task.Comm.Send(task.Param.ByName('aa'));
      if arr[value].Pid <> -1 then // 检测进程是否存在
      begin
        task.Comm.Send(WM_LOG, value);
        repeat
          task.Comm.Send(WM_LOG, '线程运行中');
          Sleep(1000);
        until (FCancellationToken.IsSignalled);
      end;

    end);

end;

procedure TGameManger.StopAll;
begin
  if FTaskGroup.Tasks.count = 0 then
    Exit;
  FTaskGroup.TerminateAll();
  FTaskGroup.Tasks.Clear;
end;

procedure TGameManger.StopAllEx;
begin
  if Assigned(FLoop) then
  begin
    FCancellationToken.Signal;
  end;
end;

end.
