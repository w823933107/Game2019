unit uLd;

interface

uses uInterfaces;

type

  // ���������⣬���㴰�ھ�����󶨴��ھ�����Ƿ����android������PID��VBox����PID

  TLd = class
  strict private
    class function GetRunConsoleResult(FileName: string;
      const Visibility: Integer; var mOutputs: string): Integer;
  public
    class var FilePath: string;
    class var Visibility: Integer;
    class constructor Create();
    class procedure Launch(const index: Integer); // ����ģ����
    class procedure LaunchEx(const index: Integer; PackageName: string);
    // ����ģ��������Ӧ��
    class procedure Quit(const index: Integer); // �˳�ģ����
    class procedure QuitAll(); // �˳�����ģ����
    class procedure Reboot(const index: Integer); // ����ģ����ϵͳ
    class procedure RunApp(const index: Integer; PackageName: string); // ��������
    class procedure KillApp(const index: Integer; PackageName: string);
    class procedure SetProp(const index: Integer; key, value: string); // ��������
    class function GetProp(const index: Integer; key: string = '';
      value: string = ''): string; // �������
    class function Adb(const index: Integer; command: string): string;
    class function ListPackages(const index: Integer): string;

    // ������Ϊ''
    class procedure Modify(const index, w, h, dpi, { <w,h,dpi>] // �Զ���ֱ��� }
      cpu, { <1 | 2 | 3 | 4>] // cpu���� }
      memory: Integer; { 512 | 1024 | 2048 | 4096 | 8192>  //�ڴ����� }
      manufacturer { �ֻ����� } , model, { �ֻ��ͺ� }
      pnumber, { �ֻ���13812345678 }
      imei, { <auto | 865166023949731>] // imei���ã�auto���Զ�������� }
      imsi, { <auto | 460000000000000>] }
      simserial, { <auto | 89860000000000000000>] }
      androidid, { <auto | 0123456789abcdef>] }
      mac, { <auto | 000000000000>] //12λm16����mac��ַ }
      autorotate, { <1 | 0>] }
      lockwindow { <1 | 0>] }
      : string);
    // list2һ���Է����˶����Ϣ�������ǣ����������⣬���㴰�ھ�����󶨴��ھ�����Ƿ����android������PID��VBox����PID
    class function List2(): string;
    class function List2Ex(): TArray<TEmulatorInfo>; // �����������
    class function FindEmulator(const index: Integer): TEmulatorInfo;
    class procedure DownCpu(const index: Integer;
      const rate: Integer { 0~10 } ); // ����cpu
    class procedure InstallApp(const index: Integer; apkFileName: string);
    // ��װӦ��
    class procedure uninstallapp(const index: Integer; PackageName: string);
    // ж��Ӧ��
    class procedure Backup(const index: Integer; FileName: string); // ����
    class procedure Restore(const index: Integer; FileName: string); // ��ԭ
    class procedure SortWnd(); // ���򴰿�
    class procedure GlobalSetting(const fps: Integer; { ģ����֡��0~60 } // ȫ������
      const audio: Integer; { ��Ƶ 1~10 }
      const fastply: Integer; { ������ʾģʽ 1:0 }
      const cleanmode: Integer { �ɾ�ģʽ��ȥ����� 1:0 }
      );
    class procedure Locate(const index: Integer; const Lng, Lat: Integer);
    // �޸Ķ�λ������Ч
    class procedure Action(const index: Integer; key, value: string); // ִ��һЩ����
    // �޸Ķ�λ��ʱ��Ч
    class procedure LocateByAction(const index: Integer;
      const Lng, Lat: Integer);
    // ������
    class procedure Rename(const index: Integer; title: string);
    // ����ģ�����������󲢴� packagename Ӧ��, null ��ʾ�����κ�Ӧ��
    class procedure RebootByAction(const index: Integer;
      PackageName: string = 'null');
    // ҡһҡ
    class procedure ShakeByAction(const index: Integer);
    // ��������
    class procedure InputByAction(const index: Integer; value: string);
    // �Ͽ���������������   offline    connect
    class procedure NetworkByAction(const index: Integer;
      const IsConnect: Boolean);
    class procedure Scan(const index: Integer; FileName: string);
    // ����Ӧ��
    class procedure BackupApp(const index: Integer; PackageName: string;
      FileName: string);
    // ��ԭӦ��
    class procedure RestoreApp(const index: Integer; PackageName: string;
      FileName: string);
    // ģ�����Ƿ�����
    class function IsRuning(const index: Integer): Boolean;
    // ����ģ����
    class procedure Add(name: string);
    // ����ģ����
    class procedure Copy(name: string; const FromIndex: Integer);
    // �Ƴ�ģ����
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
  FillChar(Result, SizeOf(TEmulatorInfo), 0); // 0���
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
    Result := -2; // ͨ������ʧ��
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
    Result := INFINITE { -1 ���̴���ʧ�� }
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
    // �ȴ�console����
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
