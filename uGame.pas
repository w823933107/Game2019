unit uGame;

interface

// dm_ret = dm.ZBTNIHBGeIemDSj(hwnd,"dx.graphic.opengl","windows3","windows","",0)
// dnconsole.exe  runapp --index 0 --packagename com.tencent.ssss

type

  TLd = class
  strict private
    class function GetRunConsoleResult(FileName: String; Visibility: Integer;
      var mOutputs: string): Integer;
  public
    class var FilePath: string;
    class var Visibility: Integer;
    class constructor Create();

    class procedure Launch(index: Integer); // 启动模拟器
    class procedure LaunchEx(index: Integer; PackageName: string); // 启动模拟器并打开应用
    class procedure Quit(index: Integer); // 退出模拟器
    class procedure QuitAll(); // 退出所有模拟器
    class procedure Reboot(index: Integer); // 重启模拟器系统
    class procedure RunApp(index: Integer; PackageName: string); // 启动程序
    class procedure KillApp(index: Integer; PackageName: string);
    class procedure Modify(index, w, h, dpi, { <w,h,dpi>] // 自定义分辨率 }
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
    class procedure DownCpu(index: Integer; rate: Integer { 0~10 } ); // 降低cpu
    class procedure InstallApp(index: Integer; apkFileName: string); // 安装应用
    class procedure uninstallapp(index: Integer; PackageName: string); // 卸载应用
    class procedure Backup(index: Integer; FileName: string); // 备份
    class procedure Restore(index: Integer; FileName: string); // 还原
    class procedure SortWnd(); // 排序窗口
    class procedure GlobalSetting(fps: Integer; { 模拟器帧率0~60 } // 全局设置
      audio: Integer; { 音频 1~10 }
      fastply: Integer; { 快速显示模式 1:0 }
      cleanmode: Integer { 干净模式，去除广告 1:0 }
      );
    class procedure Locate(index: Integer; Lng, Lat: Integer); // 修改定位重启生效
    class procedure Action(index: Integer; key, value: string); // 执行一些操作
    // 修改定位即时生效
    class procedure LocateByAction(index: Integer; Lng, Lat: Integer);
    // 重命名
    class procedure Rename(index: Integer; title: string);
    // 重启模拟器，启动后并打开 packagename 应用, null 表示不打开任何应用
    class procedure RebootByAction(index: Integer;
      PackageName: string = 'null');
    // 摇一摇
    class procedure ShakeByAction(index: Integer);
    // 文字输入
    class procedure InputByAction(index: Integer; value: string);
    // 断开和连接网络命令   offline    connect
    class procedure NetworkByAction(index: Integer; IsConnect: Boolean);
    class procedure Scan(index: Integer; FileName: string);
    // 备份应用
    class procedure BackupApp(index: Integer; PackageName: string;
      FileName: string);
    // 还原应用
    class procedure RestoreApp(index: Integer; PackageName: string;
      FileName: string);
    // 模拟器是否运行
    class function IsRuning(index: Integer): Boolean;
    // 新增模拟器
    class procedure Add(name: string);
    // 复制模拟器
    class procedure Copy(name: string; FromIndex: Integer);
    // 移除模拟器
    class procedure Remove(index: Integer);
  end;

implementation

uses Winapi.Windows, System.SysUtils, Vcl.Forms;

{ TLd }

class procedure TLd.Action(index: Integer; key, value: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s action --index %d --key %s --value %s', [FilePath, Index, key,
    value]))), Visibility);
end;

class procedure TLd.Add(name: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s add --name %s ', [FilePath, name]))),
    Visibility);
end;

class procedure TLd.Backup(index: Integer; FileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s backup --index %d --file %s',
    [FilePath, Index, FileName]))), Visibility);
end;

class procedure TLd.BackupApp(index: Integer; PackageName, FileName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s backup --index %d --packagename %s --file %s', [FilePath, Index,
    PackageName, FileName]))), Visibility);
end;

class procedure TLd.Copy(name: string; FromIndex: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s add --name %s --from %d ',
    [FilePath, name, FromIndex]))), Visibility);
end;

class constructor TLd.Create;
begin
  FilePath := 'D:\Changzhi\dnplayer2\dnconsole.exe';
  TLd.Visibility := 1;
end;

class procedure TLd.DownCpu(index, rate: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s downcpu --index %d --rate %d',
    [FilePath, Index, rate]))), Visibility);
end;

class function TLd.GetRunConsoleResult(FileName: String; Visibility: Integer;
  var mOutputs: string): Integer;
var
  sa: TSecurityAttributes;
  hReadPipe, hWritePipe: THandle;
  ret: BOOL;
  strBuff: array [0 .. 255] of Ansichar;
  lngBytesread: DWORD;
  WorkDir: String;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(sa, Sizeof(sa), #0);
  sa.nLength := Sizeof(sa);
  sa.bInheritHandle := True;
  sa.lpSecurityDescriptor := nil;
  if not(CreatePipe(hReadPipe, hWritePipe, @sa, 0)) then
  begin
    Result := -2; // 通道创建失败
  end;
  WorkDir := ExtractFileDir(Application.ExeName);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
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
      FillChar(strBuff, Sizeof(strBuff), #0);
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

class procedure TLd.GlobalSetting(fps, audio, fastply, cleanmode: Integer);
var
  comm: string;
begin
  comm := Format('%s --fps %d --audio %d  --fastplay %d --cleanmpde %d',
    [FilePath, fps, audio, fastply, cleanmode]);
  WinExec(PAnsiChar(Ansistring(comm)), Visibility);
end;

class procedure TLd.InputByAction(index: Integer; value: string);
begin
  Action(index, 'call.input', value);
end;

class procedure TLd.InstallApp(index: Integer; apkFileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s installapp --index %d --filename %s',
    [FilePath, Index, apkFileName]))), Visibility);
end;

class function TLd.IsRuning(index: Integer): Boolean;
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

class procedure TLd.KillApp(index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s killapp --index %d --packagename %s',
    [FilePath, Index, PackageName]))), Visibility);

end;

class procedure TLd.Launch(index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s launch --index %d', [FilePath, Index])
    )), Visibility);
end;

class procedure TLd.LaunchEx(index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s launchex --index %d --packagename %s',
    [FilePath, Index, PackageName]))), Visibility);
end;

class function TLd.List2: string;
begin
  GetRunConsoleResult(Format('%s list2', [FilePath]), TLd.Visibility, Result);
end;

class procedure TLd.Locate(index, Lng, Lat: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s locate --index %d --LLI %d,%d',
    [FilePath, Index, Lng, Lat]))), Visibility);
end;

class procedure TLd.LocateByAction(index, Lng, Lat: Integer);
begin
  Action(index, 'call.locate', Format('%d,%d', [Lng, Lat]));
end;

class procedure TLd.Modify(index, w, h, dpi, cpu, memory: Integer;
  manufacturer, model, pnumber, imei, imsi, simserial, androidid, mac,
  autorotate, lockwindow: string);
var
  commandline: string;
begin
  commandline := Format('%s modify --index %d', [TLd.FilePath, index]);
  if (w > 0) and (h > 0) and (dpi > 0) then
    commandline := Format('%s --resolution %d,%d,%d', [commandline, w, h, dpi]);
  if cpu > 0 then
    commandline := Format('%s --cpu %d', [commandline, cpu]);
  if memory > 0 then
    commandline := Format('%s --memory  %d', [commandline, memory]);
  if manufacturer <> '' then
    commandline := Format('%s --manufacturer %s', [commandline, manufacturer]);
  if model <> '' then
    commandline := Format('%s --model %s', [commandline, model]);
  if pnumber <> '' then
    commandline := Format('%s --pnumber %s', [commandline, pnumber]);
  if imei <> '' then
    commandline := Format('%s --imei %s', [commandline, imei]);
  if imsi <> '' then
    commandline := Format('%s --imsi %s', [commandline, imsi]);
  if simserial <> '' then
    commandline := Format('%s --simserial %s', [commandline, simserial]);
  if androidid <> '' then
    commandline := Format('%s --androidid %s', [commandline, androidid]);
  if mac <> '' then
    commandline := Format('%s --mac %s', [commandline, mac]);
  if autorotate <> '' then
    commandline := Format('%s --autorotate  %s', [commandline, autorotate]);
  if lockwindow <> '' then
    commandline := Format('%s --lockwindow  %s', [commandline, lockwindow]);
  WinExec(PAnsiChar(Ansistring(commandline)), Visibility);
end;

class procedure TLd.NetworkByAction(index: Integer; IsConnect: Boolean);
var
  value: string;
begin
  if IsConnect then
    value := 'connect'
  else
    value := 'offline';
  Action(index, 'call.network', value);
end;

class procedure TLd.Quit(index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s quit --index %d', [FilePath, Index]))
    ), Visibility);
end;

class procedure TLd.QuitAll;
begin
  WinExec(PAnsiChar(Ansistring(Format('%s quitall ', [FilePath]))), Visibility);
end;

class procedure TLd.Reboot(index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s reboot --index %d', [FilePath, Index])
    )), Visibility);
end;

class procedure TLd.RebootByAction(index: Integer; PackageName: string);
begin
  Action(index, 'call.reboot', Format('packagename/', ['%s']));
end;

class procedure TLd.Remove(index: Integer);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s remove --index %d', [FilePath, index])
    )), Visibility);
end;

class procedure TLd.Rename(index: Integer; title: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s rename --index %d --title %s',
    [FilePath, Index, title]))), Visibility);
end;

class procedure TLd.Restore(index: Integer; FileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s restore --index %d --file %s',
    [FilePath, Index, FileName]))), Visibility);
end;

class procedure TLd.RestoreApp(index: Integer; PackageName, FileName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s restoreapp --index %d --packagename %s --file %s',
    [FilePath, Index, PackageName, FileName]))), Visibility);
end;

class procedure TLd.RunApp(index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s runapp --index %d --packagename %s',
    [FilePath, Index, PackageName]))), Visibility);
end;

class procedure TLd.Scan(index: Integer; FileName: string);
begin
  WinExec(PAnsiChar(Ansistring(Format('%s scan --index %d --file %s',
    [FilePath, Index, FileName]))), Visibility);
end;

class procedure TLd.ShakeByAction(index: Integer);
begin
  Action(index, 'call.shake', 'null');
end;

class procedure TLd.SortWnd;
begin
  WinExec(PAnsiChar(Ansistring(Format('%s sortWnd', [FilePath]))), Visibility);
end;

class procedure TLd.uninstallapp(index: Integer; PackageName: string);
begin
  WinExec(PAnsiChar(Ansistring
    (Format('%s uninstallapp --index %d --packagename %s', [FilePath, Index,
    PackageName]))), Visibility);
end;

end.
