unit uLd;

interface

uses uInterfaces;

type

  // 索引，标题，顶层窗口句柄，绑定窗口句柄，是否进入android，进程PID，VBox进程PID

  TLd = class
  strict private
    class function GetRunConsoleResult(FileName: string;
      const Visibility: Integer; var mOutputs: string): Integer;
  public
    class var FilePath: string;
    class var Visibility: Integer;
    class constructor Create();
    class procedure Launch(const index: Integer); // 启动模拟器
    class procedure LaunchEx(const index: Integer; PackageName: string);
    // 启动模拟器并打开应用
    class procedure Quit(const index: Integer); // 退出模拟器
    class procedure QuitAll(); // 退出所有模拟器
    class procedure Reboot(const index: Integer); // 重启模拟器系统
    class procedure RunApp(const index: Integer; PackageName: string); // 启动程序
    class procedure KillApp(const index: Integer; PackageName: string);
    class procedure SetProp(const index: Integer; key, value: string); // 设置属性
    class function GetProp(const index: Integer; key: string = '';
      value: string = ''): string; // 获得属性
    class function Adb(const index: Integer; command: string): string;
    class function ListPackages(const index: Integer): string;

    // 不设置为''
    class procedure Modify(const index, w, h, dpi, { <w,h,dpi>] // 自定义分辨率 }
      cpu, { <1 | 2 | 3 | 4>] // cpu设置 }
      memory: Integer; { 512 | 1024 | 2048 | 4096 | 8192>  //内存设置 }
      manufacturer { 手机厂商 } , model, { 手机型号 }
      pnumber, { 手机号13812345678 }
      imei, { <auto | 865166023949731>] // imei设置，auto就自动随机生成 }
      imsi, { <auto | 460000000000000>] }
      simserial, { <auto | 89860000000000000000>] }
      androidid, { <auto | 0123456789abcdef>] }
      mac, { <auto | 000000000000>] //12位m16进制mac地址 }
      autorotate, { <1 | 0>] }
      lockwindow { <1 | 0>] }
      : string);
    // list2一次性返回了多个信息，依次是：索引，标题，顶层窗口句柄，绑定窗口句柄，是否进入android，进程PID，VBox进程PID
    class function List2(): string;
    class function List2Ex(): TArray<TEmulatorInfo>; // 解析出最后结果
    class function FindEmulator(const index: Integer): TEmulatorInfo;
    class procedure DownCpu(const index: Integer;
      const rate: Integer { 0~10 } ); // 降低cpu
    class procedure InstallApp(const index: Integer; apkFileName: string);
    // 安装应用
    class procedure uninstallapp(const index: Integer; PackageName: string);
    // 卸载应用
    class procedure Backup(const index: Integer; FileName: string); // 备份
    class procedure Restore(const index: Integer; FileName: string); // 还原
    class procedure SortWnd(); // 排序窗口
    class procedure GlobalSetting(const fps: Integer; { 模拟器帧率0~60 } // 全局设置
      const audio: Integer; { 音频 1~10 }
      const fastply: Integer; { 快速显示模式 1:0 }
      const cleanmode: Integer { 干净模式，去除广告 1:0 }
      );
    class procedure Locate(const index: Integer; const Lng, Lat: Integer);
    // 修改定位重启生效
    class procedure Action(const index: Integer; key, value: string); // 执行一些操作
    // 修改定位即时生效
    class procedure LocateByAction(const index: Integer;
      const Lng, Lat: Integer);
    // 重命名
    class procedure Rename(const index: Integer; title: string);
    // 重启模拟器，启动后并打开 packagename 应用, null 表示不打开任何应用
    class procedure RebootByAction(const index: Integer;
      PackageName: string = 'null');
    // 摇一摇
    class procedure ShakeByAction(const index: Integer);
    // 文字输入
    class procedure InputByAction(const index: Integer; value: string);
    // 断开和连接网络命令   offline    connect
    class procedure NetworkByAction(const index: Integer;
      const IsConnect: Boolean);
    class procedure Scan(const index: Integer; FileName: string);
    // 备份应用
    class procedure BackupApp(const index: Integer; PackageName: string;
      FileName: string);
    // 还原应用
    class procedure RestoreApp(const index: Integer; PackageName: string;
      FileName: string);
    // 模拟器是否运行
    class function IsRuning(const index: Integer): Boolean;
    // 新增模拟器
    class procedure Add(name: string);
    // 复制模拟器
    class procedure Copy(name: string; const FromIndex: Integer);
    // 移除模拟器
    class procedure Remove(const index: Integer);

    //
    // class procedure SetPropByFile(const index: Integer; key, value: Variant);
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, {qjson,} System.Types;

{ TLd }

class procedure TLd.Action(const index: Integer; key, value: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s action --index %d --key %s --value %s', [FilePath, index, key,
    value]))), Visibility);
end;

class function TLd.Adb(const index: Integer; command: string): string;
begin
  GetRunConsoleResult
    (PAnsiChar(Ansistring(Format('%s adb --index %d --command "%s"',
    [FilePath, index, command]))), Visibility, Result);
end;

class procedure TLd.Add(name: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s add --name %s ', [FilePath, name]))),
    Visibility);
end;

class procedure TLd.Backup(const index: Integer; FileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s backup --index %d --file %s',
    [FilePath, index, FileName]))), Visibility);
end;

class procedure TLd.BackupApp(const index: Integer;
  PackageName, FileName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s backup --index %d --packagename %s --file %s', [FilePath, index,
    PackageName, FileName]))), Visibility);
end;

class procedure TLd.Copy(name: string; const FromIndex: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s add --name %s --from %d ',
    [FilePath, name, FromIndex]))), Visibility);
end;

class constructor TLd.Create;
begin
  FilePath := 'D:\Changzhi\dnplayer2\dnconsole.exe';
  TLd.Visibility := 1;
end;

class procedure TLd.DownCpu(const index, rate: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s downcpu --index %d --rate %d',
    [FilePath, index, rate]))), Visibility);
end;

class function TLd.FindEmulator(const index: Integer): TEmulatorInfo;
var
  emulatorInfoArr: TArray<TEmulatorInfo>;
  emulatorInfo: TEmulatorInfo;

begin
  FillChar(Result, SizeOf(TEmulatorInfo), 0); // 0填充
  emulatorInfoArr := TLd.List2Ex;
  for emulatorInfo in emulatorInfoArr do
  begin
    if emulatorInfo.index = index then
      Result := emulatorInfo;
  end;
end;

class function TLd.GetProp(const index: Integer; key, value: string): string;
var
  commandLine: string;
begin
  if key.IsEmpty or value.IsEmpty then
  begin
    commandLine := Format('%s getprop  --index 0', [FilePath])
  end
  else
  begin
    commandLine := Format('%s getprop  --index 0 --key "%s" --value "%s"',
      [FilePath, key, value])
  end;
  GetRunConsoleResult(commandLine, TLd.Visibility, Result);
end;

class function TLd.GetRunConsoleResult(FileName: string;
  const Visibility: Integer; var mOutputs: string): Integer;
var
  sa: TSecurityAttributes;
  hReadPipe, hWritePipe: THandle;
  ret: BOOL;
  strBuff: array [0 .. 255] of Ansichar;
  lngBytesread: DWORD;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(sa, SizeOf(sa), 0);
  sa.nLength := SizeOf(sa);
  sa.bInheritHandle := True;
  sa.lpSecurityDescriptor := nil;
  if not(CreatePipe(hReadPipe, hWritePipe, @sa, 0)) then
  begin
    Result := -2; // 通道创建失败
  end;
  WorkDir := ExtractFileDir(Application.ExeName);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
  StartupInfo.wShowWindow := Visibility;

  StartupInfo.hStdOutput := hWritePipe;
  StartupInfo.hStdError := hWritePipe;

  if not CreateProcess(nil, PChar(FileName), { pointer to command line string }
    @sa, { pointer to process security attributes }
    @sa, { pointer to thread security attributes }
    True, { handle inheritance flag }
    NORMAL_PRIORITY_CLASS, nil, { pointer to new environment block }
    PChar(WorkDir), { pointer to current directory name, PChar }
    StartupInfo, { pointer to STARTUPINFO }
    ProcessInfo) { pointer to PROCESS_INF }
  then
    Result := INFINITE { -1 进程创建失败 }
  else
  begin
    CloseHandle(hWritePipe);
    mOutputs := '';
    while ret do
    begin
      FillChar(strBuff, SizeOf(strBuff), #0);
      ret := ReadFile(hReadPipe, strBuff, 256, lngBytesread, nil);
      mOutputs := mOutputs + strBuff;
    end;
    Application.ProcessMessages;
    // 等待console结束
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Cardinal(Result));
    CloseHandle(ProcessInfo.hProcess); { to prevent memory leaks }
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(hReadPipe);
  end;

end;

class procedure TLd.GlobalSetting(const fps, audio, fastply,
  cleanmode: Integer);
var
  comm: string;
begin
  comm := Format('%s --fps %d --audio %d  --fastplay %d --cleanmpde %d',
    [FilePath, fps, audio, fastply, cleanmode]);
  WinExec(PAnsiChar(Ansistring(comm)), Visibility);
end;

class procedure TLd.InputByAction(const index: Integer; value: string);
begin
  Action(index, 'call.input', value);
end;

class procedure TLd.InstallApp(const index: Integer; apkFileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s installapp --index %d --filename %s',
    [FilePath, index, apkFileName]))), Visibility);
end;

class function TLd.IsRuning(const index: Integer): Boolean;
var
  r: string;
begin
  Result := False;
  GetRunConsoleResult(Format('%s isrunning --index %d', [FilePath, index]),
    TLd.Visibility, r);
  if r = 'runing' then
    Result := True
  else if r = 'stop' then
    Result := False;
end;

class procedure TLd.KillApp(const index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s killapp --index %d --packagename %s',
    [FilePath, index, PackageName]))), Visibility);

end;

class procedure TLd.Launch(const index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s launch --index %d', [FilePath, index])
    )), Visibility);
end;

class procedure TLd.LaunchEx(const index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s launchex --index %d --packagename "%s"', [FilePath, index,
    PackageName]))), Visibility);
end;

class function TLd.List2: string;
begin
  GetRunConsoleResult(Format('%s list2', [FilePath]), TLd.Visibility, Result);
end;

class function TLd.ListPackages(const index: Integer): string;
begin
  Result := Adb(index, 'shell pm list packages');
end;

class procedure TLd.Locate(const index, Lng, Lat: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s locate --index %d --LLI %d,%d',
    [FilePath, index, Lng, Lat]))), Visibility);
end;

class procedure TLd.LocateByAction(const index, Lng, Lat: Integer);
begin
  Action(index, 'call.locate', Format('%d,%d', [Lng, Lat]));
end;

class function TLd.List2Ex: TArray<TEmulatorInfo>;
var
  sr: string;
  sarrAll, sCurrArr: TArray<string>;
  I: Integer;
  s: string;
  emulatorInfo: TEmulatorInfo;
begin
  sr := List2();
  sr := Trim(sr);
  sarrAll := sr.Split([#10, #13]);
  Result := [];
  for s in sarrAll do
  begin
    sCurrArr := s.Split([',']);
    if Length(sCurrArr) = 7 then
    begin
      emulatorInfo.index := sCurrArr[0].ToInteger;
      emulatorInfo.title := sCurrArr[1];
      emulatorInfo.ParentHwnd := sCurrArr[2].ToInteger;
      emulatorInfo.BindHwnd := sCurrArr[3].ToInteger;
      emulatorInfo.IsInAndroid := sCurrArr[4].ToBoolean();
      emulatorInfo.Pid := sCurrArr[5].ToInteger();
      emulatorInfo.VBpxPid := sCurrArr[6].ToInteger();
      Result := Result + [emulatorInfo];
    end;

  end;

end;

class procedure TLd.Modify(const index, w, h, dpi, cpu, memory: Integer;
  manufacturer, model, pnumber, imei, imsi, simserial, androidid, mac,
  autorotate, lockwindow: string);
var
  commandLine: string;
begin
  commandLine := Format('%s modify --index %d', [TLd.FilePath, index]);
  if (w > 0) and (h > 0) and (dpi > 0) then
    commandLine := Format('%s --resolution %d,%d,%d', [commandLine, w, h, dpi]);
  if cpu > 0 then
    commandLine := Format('%s --cpu %d', [commandLine, cpu]);
  if memory > 0 then
    commandLine := Format('%s --memory  %d', [commandLine, memory]);
  if manufacturer <> '' then
    commandLine := Format('%s --manufacturer %s', [commandLine, manufacturer]);
  if model <> '' then
    commandLine := Format('%s --model %s', [commandLine, model]);
  if pnumber <> '' then
    commandLine := Format('%s --pnumber %s', [commandLine, pnumber]);
  if imei <> '' then
    commandLine := Format('%s --imei %s', [commandLine, imei]);
  if imsi <> '' then
    commandLine := Format('%s --imsi %s', [commandLine, imsi]);
  if simserial <> '' then
    commandLine := Format('%s --simserial %s', [commandLine, simserial]);
  if androidid <> '' then
    commandLine := Format('%s --androidid %s', [commandLine, androidid]);
  if mac <> '' then
    commandLine := Format('%s --mac %s', [commandLine, mac]);
  if autorotate <> '' then
    commandLine := Format('%s --autorotate  %s', [commandLine, autorotate]);
  if lockwindow <> '' then
    commandLine := Format('%s --lockwindow  %s', [commandLine, lockwindow]);
  WinExec(PAnsiChar(Ansistring(commandLine)), Visibility);
end;

class procedure TLd.NetworkByAction(const index: Integer;
  const IsConnect: Boolean);
var
  value: string;
begin
  if IsConnect then
    value := 'connect'
  else
    value := 'offline';
  Action(index, 'call.network', value);
end;

class procedure TLd.Quit(const index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s quit --index %d', [FilePath, index]))
    ), Visibility);
end;

class procedure TLd.QuitAll;
begin
  WinExec(PAnsiChar(Ansistring(Format('%s quitall ', [FilePath]))), Visibility);
end;

class procedure TLd.Reboot(const index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s reboot --index %d', [FilePath, index])
    )), Visibility);
end;

class procedure TLd.RebootByAction(const index: Integer; PackageName: string);
begin
  Action(index, 'call.reboot', Format('packagename/', ['%s']));
end;

class procedure TLd.Remove(const index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s remove --index %d', [FilePath, index])
    )), Visibility);
end;

class procedure TLd.Rename(const index: Integer; title: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s rename --index %d --title %s',
    [FilePath, index, title]))), Visibility);
end;

class procedure TLd.Restore(const index: Integer; FileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s restore --index %d --file %s',
    [FilePath, index, FileName]))), Visibility);
end;

class procedure TLd.RestoreApp(const index: Integer;
  PackageName, FileName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s restoreapp --index %d --packagename %s --file %s',
    [FilePath, index, PackageName, FileName]))), Visibility);
end;

class procedure TLd.RunApp(const index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s runapp --index %d --packagename %s',
    [FilePath, index, PackageName]))), Visibility);
end;

class procedure TLd.Scan(const index: Integer; FileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s scan --index %d --file %s',
    [FilePath, index, FileName]))), Visibility);
end;

class procedure TLd.SetProp(const index: Integer; key, value: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s setprop  --index %d --key "%s" --value "%s"', [FilePath, index,
    key, value]))), Visibility);
end;

// class procedure TLd.SetPropByFile(const index: Integer; key, value: Variant);
// var
// js: TQJson;
// cfgFile: string;
// note: TQJson;
// begin
// js := TQJson.Create;
// try
// cfgFile := Format('%s\vms\config\leidian%d.config',
// [ExtractFileDir(FilePath), index]);
// if not FileExists(cfgFile) then
// Exit;
// js.LoadFromFile(cfgFile);
// note := js.ForceName(key);
//
// note.AsVariant := value;
//
// js.SaveToFile(cfgFile);
// finally
// js.Free;
// end;
//
// end;

class procedure TLd.ShakeByAction(const index: Integer);
begin
  Action(index, 'call.shake', 'null');
end;

class procedure TLd.SortWnd;
begin
  WinExec(PAnsiChar(Ansistring(Format('%s sortWnd', [FilePath]))), Visibility);
end;

class procedure TLd.uninstallapp(const index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s uninstallapp --index %d --packagename %s', [FilePath, index,
    PackageName]))), Visibility);
end;

end.
