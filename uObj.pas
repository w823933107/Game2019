{
  var obj:IPighead;
  begin
  obj := TObjFactory.CreateNormalObj;
  //obj := TObjFactory.CreateCustomObj;
  ShowMessage(ap.Ver);
  end
}

unit uObj;

interface

uses Winapi.ActiveX, Winapi.Windows, System.Generics.Collections,
  System.SysUtils;

{$I ObjInterf.inc}

// 创建对象
var
  gPath: string = '.\Bin\wy.dll';
  gRegCode: string = '823933107a7db5990846801fa577014f2806c4b93';
  gCustomPath: string = '.\Bin\pighead.dll';
  gCustomRegCod: string = '823933107cae91c25b97bcf082b485c85aa1e731a';

var
  CLASS_PluginInterface: TGUID = '{26037A0E-7CBD-4FFF-9C63-56F2D0770214}';
  CLASS_suxin: TGUID = '{972C28D1-3E9F-102A-5B64-B947F88AE8BD}';

type
  TObjFactory = class
  private
    class var FDllDictionary: TDictionary<string, THandle>;
    class constructor Create();
    class destructor Destroy;
    class function CreateComObjFromDll(CLASS_ID: TGUID; ADllHandle: HMODULE)
      : IDispatch; static;
    class function NoRegCreateComObj(const CLASS_ID: TGUID;
      const aDllPath: string): IDispatch;
  public
    class function CreateObj<T>(const CLASS_ID: TGUID; const aDllPath: string)
      : T; overload; static;
    class function CreateObj(): IObj; overload; static;
    class function CreateNormalObj: IPighead; static;
    class function CreateCustomObj: IPighead; static;
    class procedure FreeObj(aDllPath: string);
    class procedure FreeAllObjs();

  end;

implementation

uses
  System.TypInfo;

{ TObjFactory<T> }

class constructor TObjFactory.Create;
begin
  FDllDictionary := TDictionary<string, THandle>.Create();
end;

class function TObjFactory.CreateComObjFromDll(CLASS_ID: TGUID;
  ADllHandle: HMODULE): IDispatch;
var
  lFactory: IClassFactory;
  lHRESULT: HRESULT;
  lDllGetClassObject: function(const CLSID, IID: TGUID; var Obj)
    : HRESULT; stdcall;
begin
  Result := nil;
  lDllGetClassObject := GetProcAddress(ADllHandle, 'DllGetClassObject');
  if Assigned(lDllGetClassObject) then
  begin
    lHRESULT := lDllGetClassObject(CLASS_ID, IClassFactory, lFactory);
    if lHRESULT = S_OK then
    begin
      lFactory.CreateInstance(nil, IDispatch, Result);
    end;
  end;

end;

class function TObjFactory.CreateObj: IObj;
var
  iRet: Integer;
  aobj: IObj;
begin
  aobj := NoRegCreateComObj(CLASS_PluginInterface, gPath) as IObj;
  if not Assigned(aobj) then
    raise Exception.Create('创建收费对象失败！');
  iRet := aobj.Reg(gRegCode, '');
  if iRet <> 1 then
    raise Exception.CreateFmt('插件收费功能注册失败，错误码：%d', [iRet]);
  Result := aobj;
  // aobj.QueryInterface(GetTypeData(TypeInfo(T)).Guid, Result);
end;

class function TObjFactory.CreateNormalObj: IPighead;
begin
  Result := Twy.Create;
end;

class function TObjFactory.CreateCustomObj: IPighead;
var
  iRet: Integer;
begin
  Result := TPighead.Create;
  iRet := Result.Reg(gCustomRegCod, '');
  if iRet <> 1 then
    raise Exception.CreateFmt('插件收费功能注册失败，错误码：%d', [iRet]);

end;

class destructor TObjFactory.Destroy;
begin
  inherited;
  FreeAndNil(FDllDictionary);
end;

class procedure TObjFactory.FreeAllObjs;
var
  lDllHandle: THandle;
begin
  for lDllHandle in FDllDictionary.Values do
  begin
    FreeLibrary(lDllHandle);
  end;
end;

class procedure TObjFactory.FreeObj(aDllPath: string);
var
  lDllHandle: THandle;
begin
  if FDllDictionary.TryGetValue(aDllPath, lDllHandle) then
  begin
    FreeLibrary(FDllDictionary[aDllPath]);
  end;
end;

class function TObjFactory.NoRegCreateComObj(const CLASS_ID: TGUID;
  const aDllPath: string): IDispatch;
var
  lDllHandle: THandle;
begin
  Result := nil;
  if not FileExists(aDllPath) then
    raise Exception.CreateFmt('%s插件路径不存在', [aDllPath]);
  // 判断是否已经加载
  // 未加载进行加载
  if not FDllDictionary.ContainsKey(aDllPath) then
  begin
    lDllHandle := SafeLoadLibrary(aDllPath);
    if lDllHandle = 0 then
      raise Exception.CreateFmt('加载%失败', [aDllPath]);
  end
  else
    // 已经加载从词典中获取句柄
    lDllHandle := FDllDictionary[aDllPath];
  // 创建对象
  Result := CreateComObjFromDll(CLASS_ID, lDllHandle);
  // 对象创建成功加入到词典
  if Assigned(Result) then
  begin
    if not FDllDictionary.ContainsKey(aDllPath) then
      FDllDictionary.Add(aDllPath, lDllHandle);
    { 如果存在更新,不存在则添加 }
  end;
  // Assert(result<>nil,'免注册对象创建失败');
  if Result = nil then
    raise Exception.Create('免注册对象创建失败');

end;

class function TObjFactory.CreateObj<T>(const CLASS_ID: TGUID;
  const aDllPath: string): T;
var
  aobj: IDispatch;
begin
  aobj := NoRegCreateComObj(CLASS_ID, aDllPath);
  if not Assigned(aobj) then
    raise Exception.Create('创建对象失败！');
  aobj.QueryInterface(GetTypeData(TypeInfo(T)).Guid, Result);
end;

Constructor TPighead.Create();
Begin
  // Obj := CreateOleObject('wy.suxin');
  Obj := TObjFactory.CreateObj<Isuxin>(CLASS_suxin, gCustomPath);

End;

Destructor TPighead.Destroy();
Begin
  // obj := Unassigned;
  Obj := nil;
End;

Function TPighead.GetDir(tpe: Integer): WideString;
Begin
  Result := Obj.zUFrjTtmIAnRcL(tpe);
End;

Function TPighead.GetWindowTitle(hwnd: Integer): WideString;
Begin
  Result := Obj.aFWQVQvu(hwnd);
End;

Function TPighead.FaqGetSize(handle: Integer): Integer;
Begin
  Result := Obj.enmmArpgmLWUR(handle);
End;

Function TPighead.RightUp(): Integer;
Begin
  Result := Obj.xmBaheHXvwxBSee;
End;

Function TPighead.GetDPI(): Integer;
Begin
  Result := Obj.kTzQkbfrPJG;
End;

Function TPighead.FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.SYJH(x1, y1, x2, y2, pic_name, delta_color, sim, dir, x, y);
End;

Function TPighead.CaptureJpg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.gHChKPAbDQ(x1, y1, x2, y2, file_name, quality);
End;

Function TPighead.IntToData(int_value: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.LnjbD(int_value, tpe);
End;

Function TPighead.VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
  : WideString;
Begin
  Result := Obj.CLsZISPR(hwnd, addr, pmbi);
End;

Function TPighead.FoobarSetFont(hwnd: Integer; font_name: WideString;
  size: Integer; flag: Integer): Integer;
Begin
  Result := Obj.rjgIwCwQXrRY(hwnd, font_name, size, flag);
End;

Function TPighead.ReadDoubleAddr(hwnd: Integer; addr: Int64): Double;
Begin
  Result := Obj.VaBmodo(hwnd, addr);
End;

Function TPighead.FoobarPrintText(hwnd: Integer; text: WideString;
  color: WideString): Integer;
Begin
  Result := Obj.TXfbVafJi(hwnd, text, color);
End;

Function TPighead.GetID(): Integer;
Begin
  Result := Obj.PysIjccvayTk;
End;

Function TPighead.ReadFileData(file_name: WideString; start_pos: Integer;
  end_pos: Integer): WideString;
Begin
  Result := Obj.rWJtaXQMDSh(file_name, start_pos, end_pos);
End;

Function TPighead.GetDmCount(): Integer;
Begin
  Result := Obj.nXTKTNlojUla;
End;

Function TPighead.FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString): Integer;
Begin
  Result := Obj.webcNfzF(hwnd, x, y, pic_name);
End;

Function TPighead.OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.BUVNIQ(x1, y1, x2, y2, color, sim);
End;

Function TPighead.GetWordResultCount(str: WideString): Integer;
Begin
  Result := Obj.yKFC(str);
End;

Function TPighead.WriteFile(file_name: WideString; content: WideString)
  : Integer;
Begin
  Result := Obj.uXltuWXRlKNLkk(file_name, content);
End;

Function TPighead.WriteFloat(hwnd: Integer; addr: WideString;
  v: Single): Integer;
Begin
  Result := Obj.lYWBts(hwnd, addr, v);
End;

Function TPighead.GetRealPath(path: WideString): WideString;
Begin
  Result := Obj.YXpqDwCjLHLgIow(path);
End;

Function TPighead.SetRowGapNoDict(row_gap: Integer): Integer;
Begin
  Result := Obj.VAPj(row_gap);
End;

Function TPighead.GetCpuType(): Integer;
Begin
  Result := Obj.HsmUiHGTcqmBzyF;
End;

Function TPighead.AsmAdd(asm_ins: WideString): Integer;
Begin
  Result := Obj.vkgIGiWLxMwPWM(asm_ins);
End;

Function TPighead.EnableKeypadMsg(en: Integer): Integer;
Begin
  Result := Obj.ovUBkZRoiDJ(en);
End;

Function TPighead.DeleteIni(section: WideString; key: WideString;
  file_name: WideString): Integer;
Begin
  Result := Obj.SfPv(section, key, file_name);
End;

Function TPighead.SetMinRowGap(row_gap: Integer): Integer;
Begin
  Result := Obj.fPfWUWEkB(row_gap);
End;

Function TPighead.RegNoMac(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.CmfCzPIkckrJik(code, ver);
End;

Function TPighead.FindFloatEx(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.UvxaRvdWIntkh(hwnd, addr_range, float_value_min,
    float_value_max, steps, multi_thread, mode);
End;

Function TPighead.IsFolderExist(folder: WideString): Integer;
Begin
  Result := Obj.TQAfh(folder);
End;

Function TPighead.Beep(fre: Integer; delay: Integer): Integer;
Begin
  Result := Obj.vIwITzUsh(fre, delay);
End;

Function TPighead.ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.fpLXcWtoGo(hwnd, addr, tpe, length);
End;

Function TPighead.Stop(id: Integer): Integer;
Begin
  Result := Obj.PeBHegBdZB(id);
End;

Function TPighead.GetColorHSV(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.iAKB(x, y);
End;

Function TPighead.FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer): WideString;
Begin
  Result := Obj.KahwMccxXlZWJdX(x1, y1, x2, y2, color, sim, count,
    width, height);
End;

Function TPighead.MoveDD(dx: Integer; dy: Integer): Integer;
Begin
  Result := Obj.HWGxsVwyD(dx, dy);
End;

Function TPighead.FindDouble(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double): WideString;
Begin
  Result := Obj.qiMM(hwnd, addr_range, double_value_min, double_value_max);
End;

Function TPighead.SetDisplayRefreshDelay(T: Integer): Integer;
Begin
  Result := Obj.BABEaUsPsu(T);
End;

Function TPighead.EnumIniKey(section: WideString; file_name: WideString)
  : WideString;
Begin
  Result := Obj.feVoHL(section, file_name);
End;

Function TPighead.ShowScrMsg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  msg: WideString; color: WideString): Integer;
Begin
  Result := Obj.xRwBzSKr(x1, y1, x2, y2, msg, color);
End;

Function TPighead.FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer;
Begin
  Result := Obj.rdgWuYgBDEzn(hwnd, gap);
End;

Function TPighead.GetCursorSpot(): WideString;
Begin
  Result := Obj.iNxYpfefxm;
End;

Function TPighead.VirtualFreeEx(hwnd: Integer; addr: Int64): Integer;
Begin
  Result := Obj.FgZwqKQZ(hwnd, addr);
End;

Function TPighead.SetPicPwd(pwd: WideString): Integer;
Begin
  Result := Obj.alXeQNkYgKNfKUK(pwd);
End;

Function TPighead.FindPicEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.ZkLE(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TPighead.GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.YHPfrQAUSM(x1, y1, x2, y2, color, sim);
End;

Function TPighead.ReadIntAddr(hwnd: Integer; addr: Int64; tpe: Integer): Int64;
Begin
  Result := Obj.NiaeRHEdwAzgQtx(hwnd, addr, tpe);
End;

Function TPighead.GetResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.XqgAZZNz(str, index, x, y);
End;

Function TPighead.WriteFloatAddr(hwnd: Integer; addr: Int64; v: Single)
  : Integer;
Begin
  Result := Obj.qeIrvJkhZEBtq(hwnd, addr, v);
End;

Function TPighead.OcrInFile(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.RzwForeecY(x1, y1, x2, y2, pic_name, color, sim);
End;

Function TPighead.WriteData(hwnd: Integer; addr: WideString;
  data: WideString): Integer;
Begin
  Result := Obj.AnIPWsAjdTI(hwnd, addr, data);
End;

Function TPighead.GetBasePath(): WideString;
Begin
  Result := Obj.ftZKpZDs;
End;

Function TPighead.SetClipboard(data: WideString): Integer;
Begin
  Result := Obj.dkluvedfIqrgAIX(data);
End;

Function TPighead.FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString): Integer;
Begin
  Result := Obj.rBBnMBIpFPk(hwnd, x, y, pic, trans_color);
End;

Function TPighead.WriteDouble(hwnd: Integer; addr: WideString;
  v: Double): Integer;
Begin
  Result := Obj.SaVvNr(hwnd, addr, v);
End;

Function TPighead.GetDisplayInfo(): WideString;
Begin
  Result := Obj.kurGPNymZtUjNnM;
End;

Function TPighead.ReadIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): WideString;
Begin
  Result := Obj.EghqtuwlBhJn(section, key, file_name, pwd);
End;

Function TPighead.GetTime(): Integer;
Begin
  Result := Obj.dzXyhoQCwxX;
End;

Function TPighead.ImageToBmp(pic_name: WideString;
  bmp_name: WideString): Integer;
Begin
  Result := Obj.MHLSThNeHkC(pic_name, bmp_name);
End;

Function TPighead.DoubleToData(double_value: Double): WideString;
Begin
  Result := Obj.KTSMK(double_value);
End;

Function TPighead.FindDoubleEx(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.QGClYnMa(hwnd, addr_range, double_value_min, double_value_max,
    steps, multi_thread, mode);
End;

Function TPighead.WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.QPRbG(hwnd, addr, tpe, v);
End;

Function TPighead.FaqRelease(handle: Integer): Integer;
Begin
  Result := Obj.HBFNNw(handle);
End;

Function TPighead.DeleteFile(file_name: WideString): Integer;
Begin
  Result := Obj.uAbw(file_name);
End;

Function TPighead.OpenProcess(pid: Integer): Integer;
Begin
  Result := Obj.AQPViHeWClMJnF(pid);
End;

Function TPighead.SetMouseSpeed(speed: Integer): Integer;
Begin
  Result := Obj.IxxHM(speed);
End;

Function TPighead.EnableMouseMsg(en: Integer): Integer;
Begin
  Result := Obj.xVRBxy(en);
End;

Function TPighead.EnumIniSectionPwd(file_name: WideString; pwd: WideString)
  : WideString;
Begin
  Result := Obj.WsXrqN(file_name, pwd);
End;

Function TPighead.GetColor(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.MMdquvGECxLLbqT(x, y);
End;

Function TPighead.SetMemoryFindResultToFile(file_name: WideString): Integer;
Begin
  Result := Obj.GqzUhiEwfqAXX(file_name);
End;

Function TPighead.FoobarSetTrans(hwnd: Integer; trans: Integer;
  color: WideString; sim: Double): Integer;
Begin
  Result := Obj.PGWiiKqESVvv(hwnd, trans, color, sim);
End;

Function TPighead.ReadFile(file_name: WideString): WideString;
Begin
  Result := Obj.GmSb(file_name);
End;

Function TPighead.GetDict(index: Integer; font_index: Integer): WideString;
Begin
  Result := Obj.pidiLPkPGN(index, font_index);
End;

Function TPighead.RGB2BGR(rgb_color: WideString): WideString;
Begin
  Result := Obj.fygwKKTQsAsQ(rgb_color);
End;

Function TPighead.SetExcludeRegion(tpe: Integer; info: WideString): Integer;
Begin
  Result := Obj.NhJpGyhIpydJ(tpe, info);
End;

Function TPighead.FaqCaptureString(str: WideString): Integer;
Begin
  Result := Obj.XHqrxE(str);
End;

Function TPighead.EnableMouseAccuracy(en: Integer): Integer;
Begin
  Result := Obj.uqqXGk(en);
End;

Function TPighead.CheckUAC(): Integer;
Begin
  Result := Obj.YsHPznLkVndthxP;
End;

Function TPighead.GetWordResultStr(str: WideString; index: Integer): WideString;
Begin
  Result := Obj.JqYxlsaWAvoAyh(str, index);
End;

Function TPighead.EnumProcess(name: WideString): WideString;
Begin
  Result := Obj.hMsbVbNqx(name);
End;

Function TPighead.GetResultCount(str: WideString): Integer;
Begin
  Result := Obj.xQYGmv(str);
End;

Function TPighead.RunApp(path: WideString; mode: Integer): Integer;
Begin
  Result := Obj.XQAhvBiRIcXl(path, mode);
End;

Function TPighead.FindWindowEx(parent: Integer; class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.TDUhmEjuEjSKCSf(parent, class_name, title_name);
End;

Function TPighead.ReadDataAddrToBin(hwnd: Integer; addr: Int64;
  length: Integer): Integer;
Begin
  Result := Obj.tNUnrzkdeClBnl(hwnd, addr, length);
End;

Function TPighead.FindColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.xtiPiiPFPxiJ(x1, y1, x2, y2, color, sim, dir);
End;

Function TPighead.SendPaste(hwnd: Integer): Integer;
Begin
  Result := Obj.XZPNYlLEboj(hwnd);
End;

Function TPighead.GetNetTimeByIp(ip: WideString): WideString;
Begin
  Result := Obj.wsyJ(ip);
End;

Function TPighead.FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.QzMmMsXhNNtSxGk(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function TPighead.FetchWord(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; word: WideString): WideString;
Begin
  Result := Obj.IIZPyKJURbY(x1, y1, x2, y2, color, word);
End;

Function TPighead.DisableFontSmooth(): Integer;
Begin
  Result := Obj.cuMrVoMFydnIU;
End;

Function TPighead.AppendPicAddr(pic_info: WideString; addr: Integer;
  size: Integer): WideString;
Begin
  Result := Obj.DznPUjrSl(pic_info, addr, size);
End;

Function TPighead.FoobarClose(hwnd: Integer): Integer;
Begin
  Result := Obj.MjPIPkFwPoCm(hwnd);
End;

Function TPighead.FindColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.LaCQF(x1, y1, x2, y2, color, sim, dir);
End;

Function TPighead.SetExactOcr(exact_ocr: Integer): Integer;
Begin
  Result := Obj.tHhQYJ(exact_ocr);
End;

Function TPighead.EnableFontSmooth(): Integer;
Begin
  Result := Obj.wrzsy;
End;

Function TPighead.SpeedNormalGraphic(en: Integer): Integer;
Begin
  Result := Obj.nFrbXhzNpmGB(en);
End;

Function TPighead.GetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.RDTo(hwnd, flag);
End;

Function TPighead.ExecuteCmd(cmd: WideString; current_dir: WideString;
  time_out: Integer): WideString;
Begin
  Result := Obj.fsuuF(cmd, current_dir, time_out);
End;

Function TPighead.BindWindowEx(hwnd: Integer; display: WideString;
  mouse: WideString; keypad: WideString; public_desc: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.ZBTNIHBGeIemDSj(hwnd, display, mouse, keypad,
    public_desc, mode);
End;

Function TPighead.delay(mis: Integer): Integer;
Begin
  Result := Obj.biISsaTQgm(mis);
End;

Function TPighead.MoveFile(src_file: WideString; dst_file: WideString): Integer;
Begin
  Result := Obj.NLWkeHsy(src_file, dst_file);
End;

Function TPighead.Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString): Integer;
Begin
  Result := Obj.BKTocmNnnHIN(x1, y1, x2, y2, file_name);
End;

Function TPighead.MiddleDown(): Integer;
Begin
  Result := Obj.oKwHpGksXDne;
End;

Function TPighead.DmGuardParams(cmd: WideString; sub_cmd: WideString;
  param: WideString): WideString;
Begin
  Result := Obj.rGQhFSDUoLp(cmd, sub_cmd, param);
End;

Function TPighead.DownCpu(rate: Integer): Integer;
Begin
  Result := Obj.UPvltYYRDtekbG(rate);
End;

Function TPighead.UnBindWindow(): Integer;
Begin
  Result := Obj.MZHPFi;
End;

Function TPighead.FindStrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.zUowz(x1, y1, x2, y2, str, color, sim);
End;

Function TPighead.FindWindowByProcess(process_name: WideString;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.kGtoHbuTM(process_name, class_name, title_name);
End;

Function TPighead.DisablePowerSave(): Integer;
Begin
  Result := Obj.sXjUaFekoEKX;
End;

Function TPighead.RightClick(): Integer;
Begin
  Result := Obj.GbexqmPTpmQrD;
End;

Function TPighead.DisAssemble(asm_code: WideString; base_addr: Int64;
  is_64bit: Integer): WideString;
Begin
  Result := Obj.naGjLkfsFMVeBX(asm_code, base_addr, is_64bit);
End;

Function TPighead.EnableGetColorByCapture(en: Integer): Integer;
Begin
  Result := Obj.uwyrqkkbWTYcgg(en);
End;

Function TPighead.FindStrFastEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.ZBHw(x1, y1, x2, y2, str, color, sim);
End;

Function TPighead.FindFloat(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single): WideString;
Begin
  Result := Obj.xtWpBdqMMxyp(hwnd, addr_range, float_value_min,
    float_value_max);
End;

Function TPighead.ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
  y1: Integer; x2: Integer; y2: Integer): WideString;
Begin
  Result := Obj.gcyZAtb(all_pos, tpe, x1, y1, x2, y2);
End;

Function TPighead.FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.AUtAalGEZsVCfR(x1, y1, x2, y2, first_color, offset_color,
    sim, dir);
End;

Function TPighead.FindColorBlock(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.xpUtzYdsvPxVRSU(x1, y1, x2, y2, color, sim, count, width,
    height, x, y);
End;

Function TPighead.Play(file_name: WideString): Integer;
Begin
  Result := Obj.vhANnDlgMb(file_name);
End;

Function TPighead.GetWindow(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.VXEtISYeVGWuTfV(hwnd, flag);
End;

Function TPighead.WheelDown(): Integer;
Begin
  Result := Obj.lJkEJU;
End;

Function TPighead.SetLocale(): Integer;
Begin
  Result := Obj.uPyFzWCv;
End;

Function TPighead.ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer;
Begin
  Result := Obj.SpGP(hwnd, is_show);
End;

Function TPighead.GetProcessInfo(pid: Integer): WideString;
Begin
  Result := Obj.uYtIsG(pid);
End;

Function TPighead.GetPointWindow(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.QKMS(x, y);
End;

Function TPighead.UseDict(index: Integer): Integer;
Begin
  Result := Obj.RdCLLteJI(index);
End;

Function TPighead.FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString; style: Integer;
  width: Integer): Integer;
Begin
  Result := Obj.nsrWFBZHwVfHg(hwnd, x1, y1, x2, y2, color, style, width);
End;

Function TPighead.RegEx(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.tMlB(code, ver, ip);
End;

Function TPighead.GetLastError(): Integer;
Begin
  Result := Obj.XrBZLMhRE;
End;

Function TPighead.SetKeypadDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.NwXjh(tpe, delay);
End;

Function TPighead.GetColorNum(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double): Integer;
Begin
  Result := Obj.GXKLW(x1, y1, x2, y2, color, sim);
End;

Function TPighead.SendString2(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.uTecZFRmP(hwnd, str);
End;

Function TPighead.GetClientRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.bNRzdqa(hwnd, x1, y1, x2, y2);
End;

Function TPighead.GetModuleBaseAddr(hwnd: Integer;
  module_name: WideString): Int64;
Begin
  Result := Obj.iuPTc(hwnd, module_name);
End;

Function TPighead.AddDict(index: Integer; dict_info: WideString): Integer;
Begin
  Result := Obj.MESAr(index, dict_info);
End;

Function TPighead.LoadPic(pic_name: WideString): Integer;
Begin
  Result := Obj.mtikjWeiIwYAp(pic_name);
End;

Function TPighead.GetMachineCodeNoMac(): WideString;
Begin
  Result := Obj.aMRwfhwsVkk;
End;

Function TPighead.FoobarUnlock(hwnd: Integer): Integer;
Begin
  Result := Obj.SZsrfKgpv(hwnd);
End;

Function TPighead.GetOsType(): Integer;
Begin
  Result := Obj.nJckyIzi;
End;

Function TPighead.SetWordGapNoDict(word_gap: Integer): Integer;
Begin
  Result := Obj.JxCue(word_gap);
End;

Function TPighead.LeftDown(): Integer;
Begin
  Result := Obj.nPhyPsyFWRgo;
End;

Function TPighead.SetEnumWindowDelay(delay: Integer): Integer;
Begin
  Result := Obj.ILUWrxoIxv(delay);
End;

Function TPighead.FindShapeEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.mbxjJBvNghKT(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function TPighead.FreeProcessMemory(hwnd: Integer): Integer;
Begin
  Result := Obj.jlYhlkCHG(hwnd);
End;

Function TPighead.ver(): WideString;
Begin
  Result := Obj.KQSzhh;
End;

Function TPighead.GetForegroundWindow(): Integer;
Begin
  Result := Obj.HxDptMJWKYRrwaP;
End;

Function TPighead.ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
  : WideString;
Begin
  Result := Obj.TVTdIwJoXuI(hwnd, addr, length);
End;

Function TPighead.KeyUp(vk: Integer): Integer;
Begin
  Result := Obj.Qwdmm(vk);
End;

Function TPighead.FindShapeE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.ZBkBxlawS(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function TPighead.WriteInt(hwnd: Integer; addr: WideString; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.wDqqTc(hwnd, addr, tpe, v);
End;

Function TPighead.EnableRealKeypad(en: Integer): Integer;
Begin
  Result := Obj.tFzLoEqrmvtW(en);
End;

Function TPighead.EnumWindowSuper(spec1: WideString; flag1: Integer;
  type1: Integer; spec2: WideString; flag2: Integer; type2: Integer;
  sort: Integer): WideString;
Begin
  Result := Obj.adpUwvwRXq(spec1, flag1, type1, spec2, flag2, type2, sort);
End;

Function TPighead.IsBind(hwnd: Integer): Integer;
Begin
  Result := Obj.lyCoBRENZgC(hwnd);
End;

Function TPighead.SetSimMode(mode: Integer): Integer;
Begin
  Result := Obj.iRFfULVlKj(mode);
End;

Function TPighead.GetWindowProcessPath(hwnd: Integer): WideString;
Begin
  Result := Obj.mFmdfkqJK(hwnd);
End;

Function TPighead.KeyDownChar(key_str: WideString): Integer;
Begin
  Result := Obj.HWCKwbSzU(key_str);
End;

Function TPighead.MiddleClick(): Integer;
Begin
  Result := Obj.ZAZWf;
End;

Function TPighead.WriteDataAddrFromBin(hwnd: Integer; addr: Int64;
  data: Integer; length: Integer): Integer;
Begin
  Result := Obj.jmzn(hwnd, addr, data, length);
End;

Function TPighead.IsFileExist(file_name: WideString): Integer;
Begin
  Result := Obj.WXrLStnefG(file_name);
End;

Function TPighead.FindStrFastExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FPapVSwcBJeBgzg(x1, y1, x2, y2, str, color, sim);
End;

Function TPighead.FindStrExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.zRKhZUgZceLu(x1, y1, x2, y2, str, color, sim);
End;

Function TPighead.EnableIme(en: Integer): Integer;
Begin
  Result := Obj.LJWzG(en);
End;

Function TPighead.ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.xwvgvjz(hwnd, addr, tpe, length);
End;

Function TPighead.SetUAC(uac: Integer): Integer;
Begin
  Result := Obj.fKsz(uac);
End;

Function TPighead.DmGuard(en: Integer; tpe: WideString): Integer;
Begin
  Result := Obj.YkNyHbgycUikytH(en, tpe);
End;

Function TPighead.FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.PnqzLgGKf(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TPighead.GetMac(): WideString;
Begin
  Result := Obj.arpieUV;
End;

Function TPighead.FindMulColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double): Integer;
Begin
  Result := Obj.qhyibeMUS(x1, y1, x2, y2, color, sim);
End;

Function TPighead.ReleaseRef(): Integer;
Begin
  Result := Obj.zrfVEZGxWJVLwY;
End;

Function TPighead.EnumIniSection(file_name: WideString): WideString;
Begin
  Result := Obj.hvMEAEeyiDERvM(file_name);
End;

Function TPighead.GetClientSize(hwnd: Integer; out width: OleVariant;
  out height: OleVariant): Integer;
Begin
  Result := Obj.fWKDSWBAzfBmV(hwnd, width, height);
End;

Function TPighead.SendCommand(cmd: WideString): Integer;
Begin
  Result := Obj.wuuwAMhWyjJ(cmd);
End;

Function TPighead.SendStringIme(str: WideString): Integer;
Begin
  Result := Obj.NeZFks(str);
End;

Function TPighead.FindWindowSuper(spec1: WideString; flag1: Integer;
  type1: Integer; spec2: WideString; flag2: Integer; type2: Integer): Integer;
Begin
  Result := Obj.FfRmNvRjL(spec1, flag1, type1, spec2, flag2, type2);
End;

Function TPighead.FindPicMemE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.npMQqsycbYx(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function TPighead.SetDisplayAcceler(level: Integer): Integer;
Begin
  Result := Obj.KxxB(level);
End;

Function TPighead.KeyPressChar(key_str: WideString): Integer;
Begin
  Result := Obj.NLKEIYsUuqMoApw(key_str);
End;

Function TPighead.FloatToData(float_value: Single): WideString;
Begin
  Result := Obj.PbbmlT(float_value);
End;

Function TPighead.GetDictCount(index: Integer): Integer;
Begin
  Result := Obj.qNCUG(index);
End;

Function TPighead.OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.CKaxgbULZApBQu(x1, y1, x2, y2, color, sim);
End;

Function TPighead.GetScreenHeight(): Integer;
Begin
  Result := Obj.ikLcLgpefCU;
End;

Function TPighead.SetWordLineHeightNoDict(line_height: Integer): Integer;
Begin
  Result := Obj.YRDfm(line_height);
End;

Function TPighead.EnumWindowByProcess(process_name: WideString;
  title: WideString; class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.WmDUrdvzvx(process_name, title, class_name, filter);
End;

Function TPighead.FindStrWithFont(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.aSvIJbik(x1, y1, x2, y2, str, color, sim, font_name, font_size,
    flag, x, y);
End;

Function TPighead.SetMemoryHwndAsProcessId(en: Integer): Integer;
Begin
  Result := Obj.NhrxYkNlVHFaRvB(en);
End;

Function TPighead.HackSpeed(rate: Double): Integer;
Begin
  Result := Obj.ELzgHnRb(rate);
End;

Function TPighead.ReadData(hwnd: Integer; addr: WideString; length: Integer)
  : WideString;
Begin
  Result := Obj.NyJHEHQ(hwnd, addr, length);
End;

Function TPighead.GetPath(): WideString;
Begin
  Result := Obj.LwaUtJt;
End;

Function TPighead.GetMachineCode(): WideString;
Begin
  Result := Obj.WKDvQweebkvjHW;
End;

Function TPighead.FindStrFast(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.vTSqTHXxWMrZ(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TPighead.LeaveCri(): Integer;
Begin
  Result := Obj.rIHaPE;
End;

Function TPighead.SetPath(path: WideString): Integer;
Begin
  Result := Obj.HtljPtfkT(path);
End;

Function TPighead.GetFps(): Integer;
Begin
  Result := Obj.nDvRmmptvUnTJyg;
End;

Function TPighead.FindPicMem(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.TuKkNmRqjnonABG(x1, y1, x2, y2, pic_info, delta_color, sim,
    dir, x, y);
End;

Function TPighead.FindPicExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.ZSLyETTBXofw(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TPighead.GetNetTimeSafe(): WideString;
Begin
  Result := Obj.ZVEgKSBPF;
End;

Function TPighead.MoveR(rx: Integer; ry: Integer): Integer;
Begin
  Result := Obj.BXGIKg(rx, ry);
End;

Function TPighead.GetOsBuildNumber(): Integer;
Begin
  Result := Obj.YFSN;
End;

Function TPighead.FindNearestPos(all_pos: WideString; tpe: Integer; x: Integer;
  y: Integer): WideString;
Begin
  Result := Obj.bmbeNiyLCSE(all_pos, tpe, x, y);
End;

Function TPighead.GetEnv(index: Integer; name: WideString): WideString;
Begin
  Result := Obj.BKXYEdXP(index, name);
End;

Function TPighead.EnableFakeActive(en: Integer): Integer;
Begin
  Result := Obj.APDZPcR(en);
End;

Function TPighead.ExitOs(tpe: Integer): Integer;
Begin
  Result := Obj.ittPYzBERKuhh(tpe);
End;

Function TPighead.SortPosDistance(all_pos: WideString; tpe: Integer; x: Integer;
  y: Integer): WideString;
Begin
  Result := Obj.BuqoRPhqAeNdQH(all_pos, tpe, x, y);
End;

Function TPighead.EnumWindow(parent: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.nmcGkSdggTVtg(parent, title, class_name, filter);
End;

Function TPighead.BGR2RGB(bgr_color: WideString): WideString;
Begin
  Result := Obj.vyVatBkbDhxbqL(bgr_color);
End;

Function TPighead.WriteIni(section: WideString; key: WideString; v: WideString;
  file_name: WideString): Integer;
Begin
  Result := Obj.Zirbij(section, key, v, file_name);
End;

Function TPighead.RightDown(): Integer;
Begin
  Result := Obj.IVTwWxKcvFI;
End;

Function TPighead.GetCursorShape(): WideString;
Begin
  Result := Obj.wikkNPr;
End;

Function TPighead.Reg(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.tFZPIwzfL(code, ver);
End;

Function TPighead.EnterCri(): Integer;
Begin
  Result := Obj.jyEYiVMXiFjBUW;
End;

Function TPighead.SendStringIme2(hwnd: Integer; str: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.PyuYJGZvDhbFE(hwnd, str, mode);
End;

Function TPighead.FreeScreenData(handle: Integer): Integer;
Begin
  Result := Obj.xZeeArtlhtFhVrC(handle);
End;

Function TPighead.FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.iZyLlwMU(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function TPighead.KeyPressStr(key_str: WideString; delay: Integer): Integer;
Begin
  Result := Obj.DPuTHAf(key_str, delay);
End;

Function TPighead.LeftDoubleClick(): Integer;
Begin
  Result := Obj.DNwZKDzoatLA;
End;

Function TPighead.KeyUpChar(key_str: WideString): Integer;
Begin
  Result := Obj.PSIvqvu(key_str);
End;

Function TPighead.GetCursorShapeEx(tpe: Integer): WideString;
Begin
  Result := Obj.KnWR(tpe);
End;

Function TPighead.EnableRealMouse(en: Integer; mousedelay: Integer;
  mousestep: Integer): Integer;
Begin
  Result := Obj.wfLKJnEwo(en, mousedelay, mousestep);
End;

Function TPighead.FindString(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer): WideString;
Begin
  Result := Obj.grDs(hwnd, addr_range, string_value, tpe);
End;

Function TPighead.ReadIni(section: WideString; key: WideString;
  file_name: WideString): WideString;
Begin
  Result := Obj.kVyAekLKR(section, key, file_name);
End;

Function TPighead.SetWordGap(word_gap: Integer): Integer;
Begin
  Result := Obj.DwejdWvmfKpr(word_gap);
End;

Function TPighead.DisableScreenSave(): Integer;
Begin
  Result := Obj.PIBUkDuJJd;
End;

Function TPighead.FindIntEx(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.wgkwlwgu(hwnd, addr_range, int_value_min, int_value_max, tpe,
    steps, multi_thread, mode);
End;

Function TPighead.GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
  fun_name: WideString): Int64;
Begin
  Result := Obj.pdEyCeYj(hwnd, base_addr, fun_name);
End;

Function TPighead.CopyFile(src_file: WideString; dst_file: WideString;
  over: Integer): Integer;
Begin
  Result := Obj.IXZrpl(src_file, dst_file, over);
End;

Function TPighead.SetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.CuBWMdp(hwnd, flag);
End;

Function TPighead.SetMinColGap(col_gap: Integer): Integer;
Begin
  Result := Obj.UDrIjEBgcDCew(col_gap);
End;

Function TPighead.FoobarDrawText(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; text: WideString; color: WideString;
  align: Integer): Integer;
Begin
  Result := Obj.twNbcTaVrX(hwnd, x, y, w, h, text, color, align);
End;

Function TPighead.Delays(min_s: Integer; max_s: Integer): Integer;
Begin
  Result := Obj.NxqlGsq(min_s, max_s);
End;

Function TPighead.RegExNoMac(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.TLweTiXtv(code, ver, ip);
End;

Function TPighead.GetBindWindow(): Integer;
Begin
  Result := Obj.ZFopiVw;
End;

Function TPighead.EnumWindowByProcessId(pid: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.IHmrtuuVklZ(pid, title, class_name, filter);
End;

Function TPighead.SetShowErrorMsg(show: Integer): Integer;
Begin
  Result := Obj.owEYUcjQ(show);
End;

Function TPighead.ReadDouble(hwnd: Integer; addr: WideString): Double;
Begin
  Result := Obj.JgQXxXXzZ(hwnd, addr);
End;

Function TPighead.LeftClick(): Integer;
Begin
  Result := Obj.JlKez;
End;

Function TPighead.GetScreenDepth(): Integer;
Begin
  Result := Obj.UHVxUguUxIC;
End;

Function TPighead.SelectDirectory(): WideString;
Begin
  Result := Obj.sYGTvvuNIYjR;
End;

Function TPighead.GetLocale(): Integer;
Begin
  Result := Obj.wwfBwhV;
End;

Function TPighead.CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString; sim: Double): Integer;
Begin
  Result := Obj.ZEfKWxJTFSA(hwnd, x, y, pic, trans_color, sim);
End;

Function TPighead.SetWindowTransparent(hwnd: Integer; v: Integer): Integer;
Begin
  Result := Obj.AvVnotMyMED(hwnd, v);
End;

Function TPighead.FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer;
Begin
  Result := Obj.ysvpGHTCjSxkM(hwnd, dir);
End;

Function TPighead.SetExportDict(index: Integer; dict_name: WideString): Integer;
Begin
  Result := Obj.zDEItHqZj(index, dict_name);
End;

Function TPighead.CheckInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.zMYruEiAEwY(hwnd, id);
End;

Function TPighead.SetDisplayInput(mode: WideString): Integer;
Begin
  Result := Obj.ZZCwmxbkrzbp(mode);
End;

Function TPighead.TerminateProcess(pid: Integer): Integer;
Begin
  Result := Obj.ZldLoKNEHN(pid);
End;

Function TPighead.LockInput(locks: Integer): Integer;
Begin
  Result := Obj.vhtjEbma(locks);
End;

Function TPighead.SetDict(index: Integer; dict_name: WideString): Integer;
Begin
  Result := Obj.kTkpWA(index, dict_name);
End;

Function TPighead.FaqCancel(): Integer;
Begin
  Result := Obj.XMSdon;
End;

Function TPighead.FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.RhqwdYBJQ(x1, y1, x2, y2, file_name, quality);
End;

Function TPighead.DecodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.Qgkln(file_name, pwd);
End;

Function TPighead.GetNetTime(): WideString;
Begin
  Result := Obj.zyvyIy;
End;

Function TPighead.CheckFontSmooth(): Integer;
Begin
  Result := Obj.ZNAELdSZNbgqAw;
End;

Function TPighead.AsmClear(): Integer;
Begin
  Result := Obj.PhweWsX;
End;

Function TPighead.StrStr(s: WideString; str: WideString): Integer;
Begin
  Result := Obj.dUSlsVEKouIJJWb(s, str);
End;

Function TPighead.FindWindowByProcessId(process_id: Integer;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.NdQkPMPBgLo(process_id, class_name, title_name);
End;

Function TPighead.WriteIniPwd(section: WideString; key: WideString;
  v: WideString; file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.CCgQMrvmUvrwQh(section, key, v, file_name, pwd);
End;

Function TPighead.KeyPress(vk: Integer): Integer;
Begin
  Result := Obj.lKov(vk);
End;

Function TPighead.FaqIsPosted(): Integer;
Begin
  Result := Obj.vbHCVzFpiEvgF;
End;

Function TPighead.ActiveInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.pxyHwQjEa(hwnd, id);
End;

Function TPighead.BindWindow(hwnd: Integer; display: WideString;
  mouse: WideString; keypad: WideString; mode: Integer): Integer;
Begin
  Result := Obj.PJPoNtGyhtSpbJF(hwnd, display, mouse, keypad, mode);
End;

Function TPighead.VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer; old_protect: Integer): Integer;
Begin
  Result := Obj.SmMUDbmvIHZW(hwnd, addr, size, tpe, old_protect);
End;

Function TPighead.CreateFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.EPCH(folder_name);
End;

Function TPighead.GetPicSize(pic_name: WideString): WideString;
Begin
  Result := Obj.xgccZAblYh(pic_name);
End;

Function TPighead.FindPicMemEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.NJkRd(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function TPighead.SetMouseDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.gCmoz(tpe, delay);
End;

Function TPighead.GetNowDict(): Integer;
Begin
  Result := Obj.ZUwaUKua;
End;

Function TPighead.GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString): WideString;
Begin
  Result := Obj.gVGVKSIYqSiz(x1, y1, x2, y2, color);
End;

Function TPighead.GetFileLength(file_name: WideString): Integer;
Begin
  Result := Obj.uxnLC(file_name);
End;

Function TPighead.FindStrFastE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.HfWVubrjaP(x1, y1, x2, y2, str, color, sim);
End;

Function TPighead.FindInputMethod(id: WideString): Integer;
Begin
  Result := Obj.XzbenJdmgJdhzZQ(id);
End;

Function TPighead.FaqPost(server: WideString; handle: Integer;
  request_type: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.puXoGUk(server, handle, request_type, time_out);
End;

Function TPighead.EnableSpeedDx(en: Integer): Integer;
Begin
  Result := Obj.VHLuftJPYsfzfiu(en);
End;

Function TPighead.MoveWindow(hwnd: Integer; x: Integer; y: Integer): Integer;
Begin
  Result := Obj.xhaEMSj(hwnd, x, y);
End;

Function TPighead.Assemble(base_addr: Int64; is_64bit: Integer): WideString;
Begin
  Result := Obj.LaJRYMUI(base_addr, is_64bit);
End;

Function TPighead.SwitchBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.dUbtEzxGlrAYR(hwnd);
End;

Function TPighead.LockMouseRect(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.zogzHFehJQgQUMQ(x1, y1, x2, y2);
End;

Function TPighead.SetDictMem(index: Integer; addr: Integer;
  size: Integer): Integer;
Begin
  Result := Obj.inoDBJyLDenvQA(index, addr, size);
End;

Function TPighead.InitCri(): Integer;
Begin
  Result := Obj.AvTkgVtuc;
End;

Function TPighead.FindInt(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.shXNhRmUxEaVR(hwnd, addr_range, int_value_min,
    int_value_max, tpe);
End;

Function TPighead.SetDisplayDelay(T: Integer): Integer;
Begin
  Result := Obj.FcktPpuSzYc(T);
End;

Function TPighead.GetMouseSpeed(): Integer;
Begin
  Result := Obj.LKrehaGyEFkQHk;
End;

Function TPighead.FoobarLock(hwnd: Integer): Integer;
Begin
  Result := Obj.BNQbwwnVV(hwnd);
End;

Function TPighead.VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer): Int64;
Begin
  Result := Obj.FxhPYwh(hwnd, addr, size, tpe);
End;

Function TPighead.EnableShareDict(en: Integer): Integer;
Begin
  Result := Obj.CeBIcDUuXg(en);
End;

Function TPighead.FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.ZUKcpVTKReub(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TPighead.FaqSend(server: WideString; handle: Integer;
  request_type: Integer; time_out: Integer): WideString;
Begin
  Result := Obj.argLDhCuvLbx(server, handle, request_type, time_out);
End;

Function TPighead.ReadFloatAddr(hwnd: Integer; addr: Int64): Single;
Begin
  Result := Obj.NtLrJiRlddM(hwnd, addr);
End;

Function TPighead.SetWordLineHeight(line_height: Integer): Integer;
Begin
  Result := Obj.WgUFVH(line_height);
End;

Function TPighead.EnableBind(en: Integer): Integer;
Begin
  Result := Obj.LvDwyVbkLKBNpX(en);
End;

Function TPighead.Is64Bit(): Integer;
Begin
  Result := Obj.ExSsaGI;
End;

Function TPighead.FindDataEx(hwnd: Integer; addr_range: WideString;
  data: WideString; steps: Integer; multi_thread: Integer; mode: Integer)
  : WideString;
Begin
  Result := Obj.EghZYsZ(hwnd, addr_range, data, steps, multi_thread, mode);
End;

Function TPighead.KeyDown(vk: Integer): Integer;
Begin
  Result := Obj.bNSxXNHWbDmQ(vk);
End;

Function TPighead.SetWindowText(hwnd: Integer; text: WideString): Integer;
Begin
  Result := Obj.upJGlDbfQXzAi(hwnd, text);
End;

Function TPighead.WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.rEZzpBQB(hwnd, addr, tpe, v);
End;

Function TPighead.EncodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.ImZpRrYwIJCs(file_name, pwd);
End;

Function TPighead.LoadPicByte(addr: Integer; size: Integer;
  name: WideString): Integer;
Begin
  Result := Obj.gLyfPMYcHlksCE(addr, size, name);
End;

Function TPighead.GetScreenData(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.HGjZcPSfPUboAI(x1, y1, x2, y2);
End;

Function TPighead.GetClipboard(): WideString;
Begin
  Result := Obj.YguAyNMy;
End;

Function TPighead.GetColorBGR(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.CaHhXpE(x, y);
End;

Function TPighead.FindStrFastS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.BehGgVCltWPqonB(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TPighead.CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.vWfaEFNUnesbjX(hwnd, x, y, w, h);
End;

Function TPighead.MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
  : WideString;
Begin
  Result := Obj.KuRJx(x, y, w, h);
End;

Function TPighead.GetWindowRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.oLPcrnQnbxa(hwnd, x1, y1, x2, y2);
End;

Function TPighead.SetWindowSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.iFacCwAIk(hwnd, width, height);
End;

Function TPighead.AsmCall(hwnd: Integer; mode: Integer): Int64;
Begin
  Result := Obj.cAZC(hwnd, mode);
End;

Function TPighead.SetScreen(width: Integer; height: Integer;
  depth: Integer): Integer;
Begin
  Result := Obj.eQrjv(width, height, depth);
End;

Function TPighead.ClientToScreen(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.JvMwXPB(hwnd, x, y);
End;

Function TPighead.FindWindow(class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.DaKhHXq(class_name, title_name);
End;

Function TPighead.WriteDataAddr(hwnd: Integer; addr: Int64;
  data: WideString): Integer;
Begin
  Result := Obj.AkCfQQnYzF(hwnd, addr, data);
End;

Function TPighead.GetScreenWidth(): Integer;
Begin
  Result := Obj.FkmWFNFzqp;
End;

Function TPighead.FindColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double; dir: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.zIxDAda(x1, y1, x2, y2, color, sim, dir, x, y);
End;

Function TPighead.FindMultiColorE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.ZRkau(x1, y1, x2, y2, first_color, offset_color, sim, dir);
End;

Function TPighead.GetWindowClass(hwnd: Integer): WideString;
Begin
  Result := Obj.KqdwNps(hwnd);
End;

Function TPighead.CapturePre(file_name: WideString): Integer;
Begin
  Result := Obj.rrNwvYIAeqhwfgE(file_name);
End;

Function TPighead.GetForegroundFocus(): Integer;
Begin
  Result := Obj.WYNES;
End;

Function TPighead.SetAero(en: Integer): Integer;
Begin
  Result := Obj.cQnqzGtc(en);
End;

Function TPighead.FoobarTextRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.KvRfGsKhDjt(hwnd, x, y, w, h);
End;

Function TPighead.FindMultiColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.VHfJHteo(x1, y1, x2, y2, first_color, offset_color, sim,
    dir, x, y);
End;

Function TPighead.DownloadFile(url: WideString; save_file: WideString;
  timeout: Integer): Integer;
Begin
  Result := Obj.nEPmKjs(url, save_file, timeout);
End;

Function TPighead.MatchPicName(pic_name: WideString): WideString;
Begin
  Result := Obj.TNgMhtRIS(pic_name);
End;

Function TPighead.Log(info: WideString): Integer;
Begin
  Result := Obj.mCfR(info);
End;

Function TPighead.GetCursorPos(out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.giZGxidJLSie(x, y);
End;

Function TPighead.GetMousePointWindow(): Integer;
Begin
  Result := Obj.TAvtmpJA;
End;

Function TPighead.GetDiskSerial(): WideString;
Begin
  Result := Obj.NTiDlpAa;
End;

Function TPighead.Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.nAxMvRZGveUZUG(x1, y1, x2, y2, color, sim);
End;

Function TPighead.ReadInt(hwnd: Integer; addr: WideString; tpe: Integer): Int64;
Begin
  Result := Obj.iZkIuX(hwnd, addr, tpe);
End;

Function TPighead.GetWindowProcessId(hwnd: Integer): Integer;
Begin
  Result := Obj.nQZCZGfGUNa(hwnd);
End;

Function TPighead.AsmCallEx(hwnd: Integer; mode: Integer;
  base_addr: WideString): Int64;
Begin
  Result := Obj.yZEeGDnoBJUG(hwnd, mode, base_addr);
End;

Function TPighead.ClearDict(index: Integer): Integer;
Begin
  Result := Obj.ykKY(index);
End;

Function TPighead.Int64ToInt32(v: Int64): Integer;
Begin
  Result := Obj.rWynQZk(v);
End;

Function TPighead.SetDictPwd(pwd: WideString): Integer;
Begin
  Result := Obj.aQTT(pwd);
End;

Function TPighead.FaqFetch(): WideString;
Begin
  Result := Obj.XEzYS;
End;

Function TPighead.GetSpecialWindow(flag: Integer): Integer;
Begin
  Result := Obj.GgXGkUIvJUCoA(flag);
End;

Function TPighead.EnablePicCache(en: Integer): Integer;
Begin
  Result := Obj.WLqPNK(en);
End;

Function TPighead.EnumIniKeyPwd(section: WideString; file_name: WideString;
  pwd: WideString): WideString;
Begin
  Result := Obj.mjxEXqCAdBbz(section, file_name, pwd);
End;

Function TPighead.SetClientSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.AUMkCWtNByIG(hwnd, width, height);
End;

Function TPighead.SendString(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.DpsFjfKYdgTzg(hwnd, str);
End;

Function TPighead.WriteDoubleAddr(hwnd: Integer; addr: Int64;
  v: Double): Integer;
Begin
  Result := Obj.zxFfXNqGwPrEEyy(hwnd, addr, v);
End;

Function TPighead.ScreenToClient(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.drlzQZfrWCdocC(hwnd, x, y);
End;

Function TPighead.AsmSetTimeout(time_out: Integer; param: Integer): Integer;
Begin
  Result := Obj.wWIXNhYqJI(time_out, param);
End;

Function TPighead.WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.GJIoicxslmxdQvQ(hwnd, addr, tpe, v);
End;

Function TPighead.GetWordResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.QqBASYp(str, index, x, y);
End;

Function TPighead.FoobarClearText(hwnd: Integer): Integer;
Begin
  Result := Obj.pYop(hwnd);
End;

Function TPighead.IsDisplayDead(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; T: Integer): Integer;
Begin
  Result := Obj.EHaUtDelrc(x1, y1, x2, y2, T);
End;

Function TPighead.ReadDataToBin(hwnd: Integer; addr: WideString;
  length: Integer): Integer;
Begin
  Result := Obj.NhaMl(hwnd, addr, length);
End;

Function TPighead.WaitKey(key_code: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.JeGWGvUXIwlZ(key_code, time_out);
End;

Function TPighead.EnableKeypadPatch(en: Integer): Integer;
Begin
  Result := Obj.nJKSrFANNdrjA(en);
End;

Function TPighead.CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.yBFnBCu(hwnd, x, y, w, h);
End;

Function TPighead.CapturePng(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString): Integer;
Begin
  Result := Obj.TpHtMErvJCKK(x1, y1, x2, y2, file_name);
End;

Function TPighead.MiddleUp(): Integer;
Begin
  Result := Obj.jbghBFl;
End;

Function TPighead.CmpColor(x: Integer; y: Integer; color: WideString;
  sim: Double): Integer;
Begin
  Result := Obj.tpVPr(x, y, color, sim);
End;

Function TPighead.FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): WideString;
Begin
  Result := Obj.fpvAmERN(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TPighead.GetKeyState(vk: Integer): Integer;
Begin
  Result := Obj.LqxpMWux(vk);
End;

Function TPighead.FoobarSetSave(hwnd: Integer; file_name: WideString;
  en: Integer; header: WideString): Integer;
Begin
  Result := Obj.rqTHCRFp(hwnd, file_name, en, header);
End;

Function TPighead.ReadFloat(hwnd: Integer; addr: WideString): Single;
Begin
  Result := Obj.MlgjJQEUA(hwnd, addr);
End;

Function TPighead.LeftUp(): Integer;
Begin
  Result := Obj.KyYIywoLGscTIU;
End;

Function TPighead.ForceUnBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.AGgkFPCU(hwnd);
End;

Function TPighead.DeleteIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.vXgV(section, key, file_name, pwd);
End;

Function TPighead.FaqCapture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  quality: Integer; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.AfAZCe(x1, y1, x2, y2, quality, delay, time);
End;

Function TPighead.SetExitThread(en: Integer): Integer;
Begin
  Result := Obj.YJfxPExQY(en);
End;

Function TPighead.EnableDisplayDebug(enable_debug: Integer): Integer;
Begin
  Result := Obj.KdBmwAomBy(enable_debug);
End;

Function TPighead.CaptureGif(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.IHgvWYxsyZmy(x1, y1, x2, y2, file_name, delay, time);
End;

Function TPighead.EnableMouseSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.ZKgrVNarl(en, time_out);
End;

Function TPighead.SetParam64ToPointer(): Integer;
Begin
  Result := Obj.wHTBbkFiABdaf;
End;

Function TPighead.FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.PrrUgxsnj(x1, y1, x2, y2, str, color, sim);
End;

Function TPighead.DelEnv(index: Integer; name: WideString): Integer;
Begin
  Result := Obj.FvpxRv(index, name);
End;

Function TPighead.GetCommandLine(hwnd: Integer): WideString;
Begin
  Result := Obj.tUtpGelWrB(hwnd);
End;

Function TPighead.FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.ihzRBFlpmnfqbA(x1, y1, x2, y2, pic_name, delta_color, sim,
    dir, x, y);
End;

Function TPighead.FoobarUpdate(hwnd: Integer): Integer;
Begin
  Result := Obj.EDLZ(hwnd);
End;

Function TPighead.SelectFile(): WideString;
Begin
  Result := Obj.WvAIHjpJknPFR;
End;

Function TPighead.FindData(hwnd: Integer; addr_range: WideString;
  data: WideString): WideString;
Begin
  Result := Obj.hcLkq(hwnd, addr_range, data);
End;

Function TPighead.FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString): Integer;
Begin
  Result := Obj.ncFhsK(hwnd, x1, y1, x2, y2, color);
End;

Function TPighead.LockDisplay(locks: Integer): Integer;
Begin
  Result := Obj.zXGewcRjrlXKfo(locks);
End;

Function TPighead.WheelUp(): Integer;
Begin
  Result := Obj.HfAmeBdpg;
End;

Function TPighead.Md5(str: WideString): WideString;
Begin
  Result := Obj.AEHy(str);
End;

Function TPighead.FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString; repeat_limit: Integer; delay: Integer): Integer;
Begin
  Result := Obj.gLMEKWA(hwnd, x, y, pic_name, repeat_limit, delay);
End;

Function TPighead.MoveTo(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.VqonxwiSNBKtG(x, y);
End;

Function TPighead.WriteDataFromBin(hwnd: Integer; addr: WideString;
  data: Integer; length: Integer): Integer;
Begin
  Result := Obj.vDydcMN(hwnd, addr, data, length);
End;

Function TPighead.SetEnv(index: Integer; name: WideString;
  value: WideString): Integer;
Begin
  Result := Obj.YbIkPusA(index, name, value);
End;

Function TPighead.StringToData(string_value: WideString; tpe: Integer)
  : WideString;
Begin
  Result := Obj.vcWDYEmU(string_value, tpe);
End;

Function TPighead.FreePic(pic_name: WideString): Integer;
Begin
  Result := Obj.uAZa(pic_name);
End;

Function TPighead.EnableKeypadSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.nHqG(en, time_out);
End;

Function TPighead.DeleteFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.RPltbImeRNe(folder_name);
End;

Function TPighead.FindShape(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  offset_color: WideString; sim: Double; dir: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.XyTQBygoV(x1, y1, x2, y2, offset_color, sim, dir, x, y);
End;

Function TPighead.FindStringEx(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer; steps: Integer; multi_thread: Integer;
  mode: Integer): WideString;
Begin
  Result := Obj.jcXnt(hwnd, addr_range, string_value, tpe, steps,
    multi_thread, mode);
End;

Function TPighead.SaveDict(index: Integer; file_name: WideString): Integer;
Begin
  Result := Obj.MHAyaviaf(index, file_name);
End;

Function TPighead.GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; out data: OleVariant; out size: OleVariant): Integer;
Begin
  Result := Obj.BinBmj(x1, y1, x2, y2, data, size);
End;

Function TPighead.GetAveHSV(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
  : WideString;
Begin
  Result := Obj.DUVZpuY(x1, y1, x2, y2);
End;

Function TPighead.CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; rw: Integer; rh: Integer): Integer;
Begin
  Result := Obj.LXhe(hwnd, x, y, w, h, rw, rh);
End;

Function TPighead.GetDictInfo(str: WideString; font_name: WideString;
  font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.bScRBCilaHlUnFy(str, font_name, font_size, flag);
End;

Function TPighead.GetAveRGB(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
  : WideString;
Begin
  Result := Obj.QEMSsTFHbEZKaj(x1, y1, x2, y2);
End;

Function TPighead.UnLoadDriver(): Integer;
Begin
  Result := Obj.DDGiUcEHkwtZa;
End;

Function TPighead.DisableCloseDisplayAndSleep(): Integer;
Begin
  Result := Obj.jfzlaRPUtHZwzp;
End;

Function TPighead.SetColGapNoDict(col_gap: Integer): Integer;
Begin
  Result := Obj.RUWqTmAl(col_gap);
End;

Constructor Twy.Create();
Begin
  // obj := CreateOleObject('dm.dmsoft');
  Obj := TObjFactory.CreateObj();
End;

Destructor Twy.Destroy();
Begin
  // obj := Unassigned;
  Obj := nil;
End;

Function Twy.SetRowGapNoDict(row_gap: Integer): Integer;
Begin
  Result := Obj.SetRowGapNoDict(row_gap);
End;

Function Twy.SetWordGapNoDict(word_gap: Integer): Integer;
Begin
  Result := Obj.SetWordGapNoDict(word_gap);
End;

Function Twy.FoobarSetFont(hwnd: Integer; font_name: WideString; size: Integer;
  flag: Integer): Integer;
Begin
  Result := Obj.FoobarSetFont(hwnd, font_name, size, flag);
End;

Function Twy.SetParam64ToPointer(): Integer;
Begin
  Result := Obj.SetParam64ToPointer;
End;

Function Twy.ReadFloat(hwnd: Integer; addr: WideString): Single;
Begin
  Result := Obj.ReadFloat(hwnd, addr);
End;

Function Twy.SetUAC(uac: Integer): Integer;
Begin
  Result := Obj.SetUAC(uac);
End;

Function Twy.FindShapeE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindShapeE(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function Twy.RightDown(): Integer;
Begin
  Result := Obj.RightDown;
End;

Function Twy.Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString): Integer;
Begin
  Result := Obj.Capture(x1, y1, x2, y2, file_name);
End;

Function Twy.SetMemoryFindResultToFile(file_name: WideString): Integer;
Begin
  Result := Obj.SetMemoryFindResultToFile(file_name);
End;

Function Twy.FoobarSetTrans(hwnd: Integer; trans: Integer; color: WideString;
  sim: Double): Integer;
Begin
  Result := Obj.FoobarSetTrans(hwnd, trans, color, sim);
End;

Function Twy.FindPicExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindPicExS(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function Twy.SetWordLineHeightNoDict(line_height: Integer): Integer;
Begin
  Result := Obj.SetWordLineHeightNoDict(line_height);
End;

Function Twy.FindFloat(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single): WideString;
Begin
  Result := Obj.FindFloat(hwnd, addr_range, float_value_min, float_value_max);
End;

Function Twy.FindDouble(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double): WideString;
Begin
  Result := Obj.FindDouble(hwnd, addr_range, double_value_min,
    double_value_max);
End;

Function Twy.LeaveCri(): Integer;
Begin
  Result := Obj.LeaveCri;
End;

Function Twy.ReadDataAddrToBin(hwnd: Integer; addr: Int64;
  length: Integer): Integer;
Begin
  Result := Obj.ReadDataAddrToBin(hwnd, addr, length);
End;

Function Twy.Reg(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.Reg(code, ver);
End;

Function Twy.EnumIniKey(section: WideString; file_name: WideString): WideString;
Begin
  Result := Obj.EnumIniKey(section, file_name);
End;

Function Twy.SetDisplayAcceler(level: Integer): Integer;
Begin
  Result := Obj.SetDisplayAcceler(level);
End;

Function Twy.ReadFloatAddr(hwnd: Integer; addr: Int64): Single;
Begin
  Result := Obj.ReadFloatAddr(hwnd, addr);
End;

Function Twy.SetEnv(index: Integer; name: WideString;
  value: WideString): Integer;
Begin
  Result := Obj.SetEnv(index, name, value);
End;

Function Twy.GetDictCount(index: Integer): Integer;
Begin
  Result := Obj.GetDictCount(index);
End;

Function Twy.ExitOs(tpe: Integer): Integer;
Begin
  Result := Obj.ExitOs(tpe);
End;

Function Twy.SetEnumWindowDelay(delay: Integer): Integer;
Begin
  Result := Obj.SetEnumWindowDelay(delay);
End;

Function Twy.IsBind(hwnd: Integer): Integer;
Begin
  Result := Obj.IsBind(hwnd);
End;

Function Twy.LockInput(locks: Integer): Integer;
Begin
  Result := Obj.LockInput(locks);
End;

Function Twy.GetAveHSV(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
  : WideString;
Begin
  Result := Obj.GetAveHSV(x1, y1, x2, y2);
End;

Function Twy.UseDict(index: Integer): Integer;
Begin
  Result := Obj.UseDict(index);
End;

Function Twy.SetMemoryHwndAsProcessId(en: Integer): Integer;
Begin
  Result := Obj.SetMemoryHwndAsProcessId(en);
End;

Function Twy.Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.Ocr(x1, y1, x2, y2, color, sim);
End;

Function Twy.SendCommand(cmd: WideString): Integer;
Begin
  Result := Obj.SendCommand(cmd);
End;

Function Twy.GetMouseSpeed(): Integer;
Begin
  Result := Obj.GetMouseSpeed;
End;

Function Twy.RightUp(): Integer;
Begin
  Result := Obj.RightUp;
End;

Function Twy.Play(file_name: WideString): Integer;
Begin
  Result := Obj.Play(file_name);
End;

Function Twy.FindFloatEx(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindFloatEx(hwnd, addr_range, float_value_min, float_value_max,
    steps, multi_thread, mode);
End;

Function Twy.EnablePicCache(en: Integer): Integer;
Begin
  Result := Obj.EnablePicCache(en);
End;

Function Twy.EnumIniKeyPwd(section: WideString; file_name: WideString;
  pwd: WideString): WideString;
Begin
  Result := Obj.EnumIniKeyPwd(section, file_name, pwd);
End;

Function Twy.HackSpeed(rate: Double): Integer;
Begin
  Result := Obj.HackSpeed(rate);
End;

Function Twy.GetDPI(): Integer;
Begin
  Result := Obj.GetDPI;
End;

Function Twy.AsmAdd(asm_ins: WideString): Integer;
Begin
  Result := Obj.AsmAdd(asm_ins);
End;

Function Twy.FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString; style: Integer;
  width: Integer): Integer;
Begin
  Result := Obj.FoobarDrawLine(hwnd, x1, y1, x2, y2, color, style, width);
End;

Function Twy.GetScreenData(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.GetScreenData(x1, y1, x2, y2);
End;

Function Twy.FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): WideString;
Begin
  Result := Obj.FindStrS(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function Twy.EnableRealMouse(en: Integer; mousedelay: Integer;
  mousestep: Integer): Integer;
Begin
  Result := Obj.EnableRealMouse(en, mousedelay, mousestep);
End;

Function Twy.GetCursorPos(out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.GetCursorPos(x, y);
End;

Function Twy.FindStringEx(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer; steps: Integer; multi_thread: Integer;
  mode: Integer): WideString;
Begin
  Result := Obj.FindStringEx(hwnd, addr_range, string_value, tpe, steps,
    multi_thread, mode);
End;

Function Twy.FindString(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer): WideString;
Begin
  Result := Obj.FindString(hwnd, addr_range, string_value, tpe);
End;

Function Twy.EnableFontSmooth(): Integer;
Begin
  Result := Obj.EnableFontSmooth;
End;

Function Twy.GetFps(): Integer;
Begin
  Result := Obj.GetFps;
End;

Function Twy.CaptureGif(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.CaptureGif(x1, y1, x2, y2, file_name, delay, time);
End;

Function Twy.GetNetTimeByIp(ip: WideString): WideString;
Begin
  Result := Obj.GetNetTimeByIp(ip);
End;

Function Twy.EnumWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
  spec2: WideString; flag2: Integer; type2: Integer; sort: Integer): WideString;
Begin
  Result := Obj.EnumWindowSuper(spec1, flag1, type1, spec2, flag2, type2, sort);
End;

Function Twy.FindData(hwnd: Integer; addr_range: WideString; data: WideString)
  : WideString;
Begin
  Result := Obj.FindData(hwnd, addr_range, data);
End;

Function Twy.GetWordResultCount(str: WideString): Integer;
Begin
  Result := Obj.GetWordResultCount(str);
End;

Function Twy.LeftDoubleClick(): Integer;
Begin
  Result := Obj.LeftDoubleClick;
End;

Function Twy.InitCri(): Integer;
Begin
  Result := Obj.InitCri;
End;

Function Twy.ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer;
Begin
  Result := Obj.ShowTaskBarIcon(hwnd, is_show);
End;

Function Twy.CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; rw: Integer; rh: Integer): Integer;
Begin
  Result := Obj.CreateFoobarRoundRect(hwnd, x, y, w, h, rw, rh);
End;

Function Twy.DisAssemble(asm_code: WideString; base_addr: Int64;
  is_64bit: Integer): WideString;
Begin
  Result := Obj.DisAssemble(asm_code, base_addr, is_64bit);
End;

Function Twy.UnLoadDriver(): Integer;
Begin
  Result := Obj.UnLoadDriver;
End;

Function Twy.GetPointWindow(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.GetPointWindow(x, y);
End;

Function Twy.RightClick(): Integer;
Begin
  Result := Obj.RightClick;
End;

Function Twy.WriteFile(file_name: WideString; content: WideString): Integer;
Begin
  Result := Obj.WriteFile(file_name, content);
End;

Function Twy.FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer): WideString;
Begin
  Result := Obj.FindColorBlockEx(x1, y1, x2, y2, color, sim, count,
    width, height);
End;

Function Twy.FoobarSetSave(hwnd: Integer; file_name: WideString; en: Integer;
  header: WideString): Integer;
Begin
  Result := Obj.FoobarSetSave(hwnd, file_name, en, header);
End;

Function Twy.EnableRealKeypad(en: Integer): Integer;
Begin
  Result := Obj.EnableRealKeypad(en);
End;

Function Twy.GetCursorShape(): WideString;
Begin
  Result := Obj.GetCursorShape;
End;

Function Twy.FindPicEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindPicEx(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function Twy.SetAero(en: Integer): Integer;
Begin
  Result := Obj.SetAero(en);
End;

Function Twy.VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
  : WideString;
Begin
  Result := Obj.VirtualQueryEx(hwnd, addr, pmbi);
End;

Function Twy.EnableMouseAccuracy(en: Integer): Integer;
Begin
  Result := Obj.EnableMouseAccuracy(en);
End;

Function Twy.CapturePre(file_name: WideString): Integer;
Begin
  Result := Obj.CapturePre(file_name);
End;

Function Twy.KeyPress(vk: Integer): Integer;
Begin
  Result := Obj.KeyPress(vk);
End;

Function Twy.GetMac(): WideString;
Begin
  Result := Obj.GetMac;
End;

Function Twy.SetDict(index: Integer; dict_name: WideString): Integer;
Begin
  Result := Obj.SetDict(index, dict_name);
End;

Function Twy.WriteData(hwnd: Integer; addr: WideString;
  data: WideString): Integer;
Begin
  Result := Obj.WriteData(hwnd, addr, data);
End;

Function Twy.FindWindowEx(parent: Integer; class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.FindWindowEx(parent, class_name, title_name);
End;

Function Twy.FaqFetch(): WideString;
Begin
  Result := Obj.FaqFetch;
End;

Function Twy.AddDict(index: Integer; dict_info: WideString): Integer;
Begin
  Result := Obj.AddDict(index, dict_info);
End;

Function Twy.DoubleToData(double_value: Double): WideString;
Begin
  Result := Obj.DoubleToData(double_value);
End;

Function Twy.SaveDict(index: Integer; file_name: WideString): Integer;
Begin
  Result := Obj.SaveDict(index, file_name);
End;

Function Twy.FetchWord(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; word: WideString): WideString;
Begin
  Result := Obj.FetchWord(x1, y1, x2, y2, color, word);
End;

Function Twy.FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer;
Begin
  Result := Obj.FoobarTextPrintDir(hwnd, dir);
End;

Function Twy.GetCursorShapeEx(tpe: Integer): WideString;
Begin
  Result := Obj.GetCursorShapeEx(tpe);
End;

Function Twy.CaptureJpg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.CaptureJpg(x1, y1, x2, y2, file_name, quality);
End;

Function Twy.SetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.SetWindowState(hwnd, flag);
End;

Function Twy.SetColGapNoDict(col_gap: Integer): Integer;
Begin
  Result := Obj.SetColGapNoDict(col_gap);
End;

Function Twy.FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.FindPicS(x1, y1, x2, y2, pic_name, delta_color, sim, dir, x, y);
End;

Function Twy.ReadIni(section: WideString; key: WideString;
  file_name: WideString): WideString;
Begin
  Result := Obj.ReadIni(section, key, file_name);
End;

Function Twy.VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer; old_protect: Integer): Integer;
Begin
  Result := Obj.VirtualProtectEx(hwnd, addr, size, tpe, old_protect);
End;

Function Twy.GetScreenDepth(): Integer;
Begin
  Result := Obj.GetScreenDepth;
End;

Function Twy.FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString): Integer;
Begin
  Result := Obj.FoobarStopGif(hwnd, x, y, pic_name);
End;

Function Twy.MoveFile(src_file: WideString; dst_file: WideString): Integer;
Begin
  Result := Obj.MoveFile(src_file, dst_file);
End;

Function Twy.GetLastError(): Integer;
Begin
  Result := Obj.GetLastError;
End;

Function Twy.DelEnv(index: Integer; name: WideString): Integer;
Begin
  Result := Obj.DelEnv(index, name);
End;

Function Twy.GetEnv(index: Integer; name: WideString): WideString;
Begin
  Result := Obj.GetEnv(index, name);
End;

Function Twy.KeyUp(vk: Integer): Integer;
Begin
  Result := Obj.KeyUp(vk);
End;

Function Twy.IsDisplayDead(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  T: Integer): Integer;
Begin
  Result := Obj.IsDisplayDead(x1, y1, x2, y2, T);
End;

Function Twy.SetMouseDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.SetMouseDelay(tpe, delay);
End;

Function Twy.SetClipboard(data: WideString): Integer;
Begin
  Result := Obj.SetClipboard(data);
End;

Function Twy.SortPosDistance(all_pos: WideString; tpe: Integer; x: Integer;
  y: Integer): WideString;
Begin
  Result := Obj.SortPosDistance(all_pos, tpe, x, y);
End;

Function Twy.SetLocale(): Integer;
Begin
  Result := Obj.SetLocale;
End;

Function Twy.SendString(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.SendString(hwnd, str);
End;

Function Twy.FindPicMem(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindPicMem(x1, y1, x2, y2, pic_info, delta_color, sim,
    dir, x, y);
End;

Function Twy.FindStrFast(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindStrFast(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function Twy.IntToData(int_value: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.IntToData(int_value, tpe);
End;

Function Twy.RGB2BGR(rgb_color: WideString): WideString;
Begin
  Result := Obj.RGB2BGR(rgb_color);
End;

Function Twy.GetAveRGB(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
  : WideString;
Begin
  Result := Obj.GetAveRGB(x1, y1, x2, y2);
End;

Function Twy.GetCommandLine(hwnd: Integer): WideString;
Begin
  Result := Obj.GetCommandLine(hwnd);
End;

Function Twy.DeleteFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.DeleteFolder(folder_name);
End;

Function Twy.DisableCloseDisplayAndSleep(): Integer;
Begin
  Result := Obj.DisableCloseDisplayAndSleep;
End;

Function Twy.FreeProcessMemory(hwnd: Integer): Integer;
Begin
  Result := Obj.FreeProcessMemory(hwnd);
End;

Function Twy.GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.GetWords(x1, y1, x2, y2, color, sim);
End;

Function Twy.GetID(): Integer;
Begin
  Result := Obj.GetID;
End;

Function Twy.SetExitThread(en: Integer): Integer;
Begin
  Result := Obj.SetExitThread(en);
End;

Function Twy.FindShape(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  offset_color: WideString; sim: Double; dir: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindShape(x1, y1, x2, y2, offset_color, sim, dir, x, y);
End;

Function Twy.SetScreen(width: Integer; height: Integer; depth: Integer)
  : Integer;
Begin
  Result := Obj.SetScreen(width, height, depth);
End;

Function Twy.CheckFontSmooth(): Integer;
Begin
  Result := Obj.CheckFontSmooth;
End;

Function Twy.WheelUp(): Integer;
Begin
  Result := Obj.WheelUp;
End;

Function Twy.WriteFloatAddr(hwnd: Integer; addr: Int64; v: Single): Integer;
Begin
  Result := Obj.WriteFloatAddr(hwnd, addr, v);
End;

Function Twy.WriteDoubleAddr(hwnd: Integer; addr: Int64; v: Double): Integer;
Begin
  Result := Obj.WriteDoubleAddr(hwnd, addr, v);
End;

Function Twy.RegExNoMac(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.RegExNoMac(code, ver, ip);
End;

Function Twy.GetBasePath(): WideString;
Begin
  Result := Obj.GetBasePath;
End;

Function Twy.SetWordGap(word_gap: Integer): Integer;
Begin
  Result := Obj.SetWordGap(word_gap);
End;

Function Twy.FindInputMethod(id: WideString): Integer;
Begin
  Result := Obj.FindInputMethod(id);
End;

Function Twy.WriteIniPwd(section: WideString; key: WideString; v: WideString;
  file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.WriteIniPwd(section, key, v, file_name, pwd);
End;

Function Twy.RunApp(path: WideString; mode: Integer): Integer;
Begin
  Result := Obj.RunApp(path, mode);
End;

Function Twy.FoobarTextRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
  h: Integer): Integer;
Begin
  Result := Obj.FoobarTextRect(hwnd, x, y, w, h);
End;

Function Twy.SetDisplayDelay(T: Integer): Integer;
Begin
  Result := Obj.SetDisplayDelay(T);
End;

Function Twy.AsmSetTimeout(time_out: Integer; param: Integer): Integer;
Begin
  Result := Obj.AsmSetTimeout(time_out, param);
End;

Function Twy.GetTime(): Integer;
Begin
  Result := Obj.GetTime;
End;

Function Twy.FaqIsPosted(): Integer;
Begin
  Result := Obj.FaqIsPosted;
End;

Function Twy.delay(mis: Integer): Integer;
Begin
  Result := Obj.delay(mis);
End;

Function Twy.FaqCaptureString(str: WideString): Integer;
Begin
  Result := Obj.FaqCaptureString(str);
End;

Function Twy.FindInt(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.FindInt(hwnd, addr_range, int_value_min, int_value_max, tpe);
End;

Function Twy.MiddleClick(): Integer;
Begin
  Result := Obj.MiddleClick;
End;

Function Twy.EnableShareDict(en: Integer): Integer;
Begin
  Result := Obj.EnableShareDict(en);
End;

Function Twy.KeyPressStr(key_str: WideString; delay: Integer): Integer;
Begin
  Result := Obj.KeyPressStr(key_str, delay);
End;

Function Twy.FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.FaqCaptureFromFile(x1, y1, x2, y2, file_name, quality);
End;

Function Twy.FindColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double; dir: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindColor(x1, y1, x2, y2, color, sim, dir, x, y);
End;

Function Twy.ReadFile(file_name: WideString): WideString;
Begin
  Result := Obj.ReadFile(file_name);
End;

Function Twy.FindNearestPos(all_pos: WideString; tpe: Integer; x: Integer;
  y: Integer): WideString;
Begin
  Result := Obj.FindNearestPos(all_pos, tpe, x, y);
End;

Function Twy.EnumWindowByProcess(process_name: WideString; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.EnumWindowByProcess(process_name, title, class_name, filter);
End;

Function Twy.StrStr(s: WideString; str: WideString): Integer;
Begin
  Result := Obj.StrStr(s, str);
End;

Function Twy.MiddleUp(): Integer;
Begin
  Result := Obj.MiddleUp;
End;

Function Twy.GetScreenHeight(): Integer;
Begin
  Result := Obj.GetScreenHeight;
End;

Function Twy.FindShapeEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindShapeEx(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function Twy.ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.ReadStringAddr(hwnd, addr, tpe, length);
End;

Function Twy.CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
  h: Integer): Integer;
Begin
  Result := Obj.CreateFoobarRect(hwnd, x, y, w, h);
End;

Function Twy.FindWindow(class_name: WideString; title_name: WideString)
  : Integer;
Begin
  Result := Obj.FindWindow(class_name, title_name);
End;

Function Twy.ShowScrMsg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  msg: WideString; color: WideString): Integer;
Begin
  Result := Obj.ShowScrMsg(x1, y1, x2, y2, msg, color);
End;

Function Twy.GetForegroundFocus(): Integer;
Begin
  Result := Obj.GetForegroundFocus;
End;

Function Twy.GetModuleBaseAddr(hwnd: Integer; module_name: WideString): Int64;
Begin
  Result := Obj.GetModuleBaseAddr(hwnd, module_name);
End;

Function Twy.FindStrFastExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrFastExS(x1, y1, x2, y2, str, color, sim);
End;

Function Twy.WriteIni(section: WideString; key: WideString; v: WideString;
  file_name: WideString): Integer;
Begin
  Result := Obj.WriteIni(section, key, v, file_name);
End;

Function Twy.EnableMouseMsg(en: Integer): Integer;
Begin
  Result := Obj.EnableMouseMsg(en);
End;

Function Twy.SetWordLineHeight(line_height: Integer): Integer;
Begin
  Result := Obj.SetWordLineHeight(line_height);
End;

Function Twy.EnumProcess(name: WideString): WideString;
Begin
  Result := Obj.EnumProcess(name);
End;

Function Twy.CmpColor(x: Integer; y: Integer; color: WideString;
  sim: Double): Integer;
Begin
  Result := Obj.CmpColor(x, y, color, sim);
End;

Function Twy.SetSimMode(mode: Integer): Integer;
Begin
  Result := Obj.SetSimMode(mode);
End;

Function Twy.Md5(str: WideString): WideString;
Begin
  Result := Obj.Md5(str);
End;

Function Twy.SetDictMem(index: Integer; addr: Integer; size: Integer): Integer;
Begin
  Result := Obj.SetDictMem(index, addr, size);
End;

Function Twy.ReadDouble(hwnd: Integer; addr: WideString): Double;
Begin
  Result := Obj.ReadDouble(hwnd, addr);
End;

Function Twy.GetWordResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.GetWordResultPos(str, index, x, y);
End;

Function Twy.DownCpu(rate: Integer): Integer;
Begin
  Result := Obj.DownCpu(rate);
End;

Function Twy.FindPicMemEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindPicMemEx(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function Twy.EnumIniSection(file_name: WideString): WideString;
Begin
  Result := Obj.EnumIniSection(file_name);
End;

Function Twy.FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindStr(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function Twy.FloatToData(float_value: Single): WideString;
Begin
  Result := Obj.FloatToData(float_value);
End;

Function Twy.SetWindowText(hwnd: Integer; text: WideString): Integer;
Begin
  Result := Obj.SetWindowText(hwnd, text);
End;

Function Twy.GetDisplayInfo(): WideString;
Begin
  Result := Obj.GetDisplayInfo;
End;

Function Twy.CheckInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.CheckInputMethod(hwnd, id);
End;

Function Twy.FindColorEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindColorEx(x1, y1, x2, y2, color, sim, dir);
End;

Function Twy.GetOsBuildNumber(): Integer;
Begin
  Result := Obj.GetOsBuildNumber;
End;

Function Twy.FoobarUpdate(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarUpdate(hwnd);
End;

Function Twy.KeyDown(vk: Integer): Integer;
Begin
  Result := Obj.KeyDown(vk);
End;

Function Twy.GetDiskSerial(): WideString;
Begin
  Result := Obj.GetDiskSerial;
End;

Function Twy.ImageToBmp(pic_name: WideString; bmp_name: WideString): Integer;
Begin
  Result := Obj.ImageToBmp(pic_name, bmp_name);
End;

Function Twy.BindWindow(hwnd: Integer; display: WideString; mouse: WideString;
  keypad: WideString; mode: Integer): Integer;
Begin
  Result := Obj.BindWindow(hwnd, display, mouse, keypad, mode);
End;

Function Twy.FindColorBlock(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindColorBlock(x1, y1, x2, y2, color, sim, count, width,
    height, x, y);
End;

Function Twy.FindMultiColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  first_color: WideString; offset_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindMultiColor(x1, y1, x2, y2, first_color, offset_color, sim,
    dir, x, y);
End;

Function Twy.FreePic(pic_name: WideString): Integer;
Begin
  Result := Obj.FreePic(pic_name);
End;

Function Twy.GetNetTime(): WideString;
Begin
  Result := Obj.GetNetTime;
End;

Function Twy.BindWindowEx(hwnd: Integer; display: WideString; mouse: WideString;
  keypad: WideString; public_desc: WideString; mode: Integer): Integer;
Begin
  Result := Obj.BindWindowEx(hwnd, display, mouse, keypad, public_desc, mode);
End;

Function Twy.WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.WriteString(hwnd, addr, tpe, v);
End;

Function Twy.Assemble(base_addr: Int64; is_64bit: Integer): WideString;
Begin
  Result := Obj.Assemble(base_addr, is_64bit);
End;

Function Twy.SetDisplayInput(mode: WideString): Integer;
Begin
  Result := Obj.SetDisplayInput(mode);
End;

Function Twy.FaqPost(server: WideString; handle: Integer; request_type: Integer;
  time_out: Integer): Integer;
Begin
  Result := Obj.FaqPost(server, handle, request_type, time_out);
End;

Function Twy.ReadInt(hwnd: Integer; addr: WideString; tpe: Integer): Int64;
Begin
  Result := Obj.ReadInt(hwnd, addr, tpe);
End;

Function Twy.FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindPicE(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function Twy.DeleteFile(file_name: WideString): Integer;
Begin
  Result := Obj.DeleteFile(file_name);
End;

Function Twy.SendStringIme(str: WideString): Integer;
Begin
  Result := Obj.SendStringIme(str);
End;

Function Twy.GetCursorSpot(): WideString;
Begin
  Result := Obj.GetCursorSpot;
End;

Function Twy.GetMachineCode(): WideString;
Begin
  Result := Obj.GetMachineCode;
End;

Function Twy.FaqCapture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  quality: Integer; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.FaqCapture(x1, y1, x2, y2, quality, delay, time);
End;

Function Twy.DisablePowerSave(): Integer;
Begin
  Result := Obj.DisablePowerSave;
End;

Function Twy.SelectFile(): WideString;
Begin
  Result := Obj.SelectFile;
End;

Function Twy.GetRealPath(path: WideString): WideString;
Begin
  Result := Obj.GetRealPath(path);
End;

Function Twy.LeftUp(): Integer;
Begin
  Result := Obj.LeftUp;
End;

Function Twy.GetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.GetWindowState(hwnd, flag);
End;

Function Twy.GetClientRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.GetClientRect(hwnd, x1, y1, x2, y2);
End;

Function Twy.EnumWindow(parent: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.EnumWindow(parent, title, class_name, filter);
End;

Function Twy.ReadDoubleAddr(hwnd: Integer; addr: Int64): Double;
Begin
  Result := Obj.ReadDoubleAddr(hwnd, addr);
End;

Function Twy.DmGuardParams(cmd: WideString; sub_cmd: WideString;
  param: WideString): WideString;
Begin
  Result := Obj.DmGuardParams(cmd, sub_cmd, param);
End;

Function Twy.SetMouseSpeed(speed: Integer): Integer;
Begin
  Result := Obj.SetMouseSpeed(speed);
End;

Function Twy.FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindMultiColorEx(x1, y1, x2, y2, first_color, offset_color,
    sim, dir);
End;

Function Twy.FindStrExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrExS(x1, y1, x2, y2, str, color, sim);
End;

Function Twy.FaqSend(server: WideString; handle: Integer; request_type: Integer;
  time_out: Integer): WideString;
Begin
  Result := Obj.FaqSend(server, handle, request_type, time_out);
End;

Function Twy.FaqCancel(): Integer;
Begin
  Result := Obj.FaqCancel;
End;

Function Twy.GetResultCount(str: WideString): Integer;
Begin
  Result := Obj.GetResultCount(str);
End;

Function Twy.RegEx(code: WideString; ver: WideString; ip: WideString): Integer;
Begin
  Result := Obj.RegEx(code, ver, ip);
End;

Function Twy.SetClientSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.SetClientSize(hwnd, width, height);
End;

Function Twy.GetWindowTitle(hwnd: Integer): WideString;
Begin
  Result := Obj.GetWindowTitle(hwnd);
End;

Function Twy.WaitKey(key_code: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.WaitKey(key_code, time_out);
End;

Function Twy.CopyFile(src_file: WideString; dst_file: WideString;
  over: Integer): Integer;
Begin
  Result := Obj.CopyFile(src_file, dst_file, over);
End;

Function Twy.GetColor(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.GetColor(x, y);
End;

Function Twy.ActiveInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.ActiveInputMethod(hwnd, id);
End;

Function Twy.EnableFakeActive(en: Integer): Integer;
Begin
  Result := Obj.EnableFakeActive(en);
End;

Function Twy.FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.FindStrWithFontEx(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function Twy.GetDictInfo(str: WideString; font_name: WideString;
  font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.GetDictInfo(str, font_name, font_size, flag);
End;

Function Twy.FaqRelease(handle: Integer): Integer;
Begin
  Result := Obj.FaqRelease(handle);
End;

Function Twy.FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.FindStrWithFontE(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function Twy.OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.OcrExOne(x1, y1, x2, y2, color, sim);
End;

Function Twy.ClientToScreen(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.ClientToScreen(hwnd, x, y);
End;

Function Twy.ver(): WideString;
Begin
  Result := Obj.ver;
End;

Function Twy.KeyPressChar(key_str: WideString): Integer;
Begin
  Result := Obj.KeyPressChar(key_str);
End;

Function Twy.Delays(min_s: Integer; max_s: Integer): Integer;
Begin
  Result := Obj.Delays(min_s, max_s);
End;

Function Twy.GetFileLength(file_name: WideString): Integer;
Begin
  Result := Obj.GetFileLength(file_name);
End;

Function Twy.SendPaste(hwnd: Integer): Integer;
Begin
  Result := Obj.SendPaste(hwnd);
End;

Function Twy.FindMulColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): Integer;
Begin
  Result := Obj.FindMulColor(x1, y1, x2, y2, color, sim);
End;

Function Twy.AsmClear(): Integer;
Begin
  Result := Obj.AsmClear;
End;

Function Twy.ClearDict(index: Integer): Integer;
Begin
  Result := Obj.ClearDict(index);
End;

Function Twy.ExecuteCmd(cmd: WideString; current_dir: WideString;
  time_out: Integer): WideString;
Begin
  Result := Obj.ExecuteCmd(cmd, current_dir, time_out);
End;

Function Twy.GetWindowRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.GetWindowRect(hwnd, x1, y1, x2, y2);
End;

Function Twy.EnumIniSectionPwd(file_name: WideString; pwd: WideString)
  : WideString;
Begin
  Result := Obj.EnumIniSectionPwd(file_name, pwd);
End;

Function Twy.OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.OcrEx(x1, y1, x2, y2, color, sim);
End;

Function Twy.SendString2(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.SendString2(hwnd, str);
End;

Function Twy.KeyUpChar(key_str: WideString): Integer;
Begin
  Result := Obj.KeyUpChar(key_str);
End;

Function Twy.VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer): Int64;
Begin
  Result := Obj.VirtualAllocEx(hwnd, addr, size, tpe);
End;

Function Twy.FindStrFastEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrFastEx(x1, y1, x2, y2, str, color, sim);
End;

Function Twy.ScreenToClient(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.ScreenToClient(hwnd, x, y);
End;

Function Twy.FindStrFastE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrFastE(x1, y1, x2, y2, str, color, sim);
End;

Function Twy.GetKeyState(vk: Integer): Integer;
Begin
  Result := Obj.GetKeyState(vk);
End;

Function Twy.GetScreenWidth(): Integer;
Begin
  Result := Obj.GetScreenWidth;
End;

Function Twy.GetProcessInfo(pid: Integer): WideString;
Begin
  Result := Obj.GetProcessInfo(pid);
End;

Function Twy.GetDict(index: Integer; font_index: Integer): WideString;
Begin
  Result := Obj.GetDict(index, font_index);
End;

Function Twy.SelectDirectory(): WideString;
Begin
  Result := Obj.SelectDirectory;
End;

Function Twy.GetClientSize(hwnd: Integer; out width: OleVariant;
  out height: OleVariant): Integer;
Begin
  Result := Obj.GetClientSize(hwnd, width, height);
End;

Function Twy.WriteDataFromBin(hwnd: Integer; addr: WideString; data: Integer;
  length: Integer): Integer;
Begin
  Result := Obj.WriteDataFromBin(hwnd, addr, data, length);
End;

Function Twy.FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindPic(x1, y1, x2, y2, pic_name, delta_color, sim, dir, x, y);
End;

Function Twy.ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
  y1: Integer; x2: Integer; y2: Integer): WideString;
Begin
  Result := Obj.ExcludePos(all_pos, tpe, x1, y1, x2, y2);
End;

Function Twy.GetWindow(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.GetWindow(hwnd, flag);
End;

Function Twy.MoveDD(dx: Integer; dy: Integer): Integer;
Begin
  Result := Obj.MoveDD(dx, dy);
End;

Function Twy.FoobarClose(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarClose(hwnd);
End;

Function Twy.GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString): WideString;
Begin
  Result := Obj.GetWordsNoDict(x1, y1, x2, y2, color);
End;

Function Twy.FindStrWithFont(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; font_name: WideString;
  font_size: Integer; flag: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindStrWithFont(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag, x, y);
End;

Function Twy.GetLocale(): Integer;
Begin
  Result := Obj.GetLocale;
End;

Function Twy.ReadFileData(file_name: WideString; start_pos: Integer;
  end_pos: Integer): WideString;
Begin
  Result := Obj.ReadFileData(file_name, start_pos, end_pos);
End;

Function Twy.FoobarDrawText(hwnd: Integer; x: Integer; y: Integer; w: Integer;
  h: Integer; text: WideString; color: WideString; align: Integer): Integer;
Begin
  Result := Obj.FoobarDrawText(hwnd, x, y, w, h, text, color, align);
End;

Function Twy.ReadIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): WideString;
Begin
  Result := Obj.ReadIniPwd(section, key, file_name, pwd);
End;

Function Twy.KeyDownChar(key_str: WideString): Integer;
Begin
  Result := Obj.KeyDownChar(key_str);
End;

Function Twy.SetDictPwd(pwd: WideString): Integer;
Begin
  Result := Obj.SetDictPwd(pwd);
End;

Function Twy.EnumWindowByProcessId(pid: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.EnumWindowByProcessId(pid, title, class_name, filter);
End;

Function Twy.DmGuard(en: Integer; tpe: WideString): Integer;
Begin
  Result := Obj.DmGuard(en, tpe);
End;

Function Twy.GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
  fun_name: WideString): Int64;
Begin
  Result := Obj.GetRemoteApiAddress(hwnd, base_addr, fun_name);
End;

Function Twy.SetKeypadDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.SetKeypadDelay(tpe, delay);
End;

Function Twy.LeftClick(): Integer;
Begin
  Result := Obj.LeftClick;
End;

Function Twy.CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString; sim: Double): Integer;
Begin
  Result := Obj.CreateFoobarCustom(hwnd, x, y, pic, trans_color, sim);
End;

Function Twy.IsFolderExist(folder: WideString): Integer;
Begin
  Result := Obj.IsFolderExist(folder);
End;

Function Twy.MiddleDown(): Integer;
Begin
  Result := Obj.MiddleDown;
End;

Function Twy.GetDir(tpe: Integer): WideString;
Begin
  Result := Obj.GetDir(tpe);
End;

Function Twy.CheckUAC(): Integer;
Begin
  Result := Obj.CheckUAC;
End;

Function Twy.FaqGetSize(handle: Integer): Integer;
Begin
  Result := Obj.FaqGetSize(handle);
End;

Function Twy.FindStrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrEx(x1, y1, x2, y2, str, color, sim);
End;

Function Twy.LockDisplay(locks: Integer): Integer;
Begin
  Result := Obj.LockDisplay(locks);
End;

Function Twy.FoobarClearText(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarClearText(hwnd);
End;

Function Twy.FindDoubleEx(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindDoubleEx(hwnd, addr_range, double_value_min,
    double_value_max, steps, multi_thread, mode);
End;

Function Twy.FindIntEx(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindIntEx(hwnd, addr_range, int_value_min, int_value_max, tpe,
    steps, multi_thread, mode);
End;

Function Twy.EncodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.EncodeFile(file_name, pwd);
End;

Function Twy.BGR2RGB(bgr_color: WideString): WideString;
Begin
  Result := Obj.BGR2RGB(bgr_color);
End;

Function Twy.GetSpecialWindow(flag: Integer): Integer;
Begin
  Result := Obj.GetSpecialWindow(flag);
End;

Function Twy.CreateFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.CreateFolder(folder_name);
End;

Function Twy.SpeedNormalGraphic(en: Integer): Integer;
Begin
  Result := Obj.SpeedNormalGraphic(en);
End;

Function Twy.WriteDataAddrFromBin(hwnd: Integer; addr: Int64; data: Integer;
  length: Integer): Integer;
Begin
  Result := Obj.WriteDataAddrFromBin(hwnd, addr, data, length);
End;

Function Twy.UnBindWindow(): Integer;
Begin
  Result := Obj.UnBindWindow;
End;

Function Twy.DeleteIni(section: WideString; key: WideString;
  file_name: WideString): Integer;
Begin
  Result := Obj.DeleteIni(section, key, file_name);
End;

Function Twy.ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
  : WideString;
Begin
  Result := Obj.ReadDataAddr(hwnd, addr, length);
End;

Function Twy.WriteInt(hwnd: Integer; addr: WideString; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.WriteInt(hwnd, addr, tpe, v);
End;

Function Twy.OpenProcess(pid: Integer): Integer;
Begin
  Result := Obj.OpenProcess(pid);
End;

Function Twy.AsmCallEx(hwnd: Integer; mode: Integer;
  base_addr: WideString): Int64;
Begin
  Result := Obj.AsmCallEx(hwnd, mode, base_addr);
End;

Function Twy.SetShowErrorMsg(show: Integer): Integer;
Begin
  Result := Obj.SetShowErrorMsg(show);
End;

Function Twy.SetWindowTransparent(hwnd: Integer; v: Integer): Integer;
Begin
  Result := Obj.SetWindowTransparent(hwnd, v);
End;

Function Twy.FindWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
  spec2: WideString; flag2: Integer; type2: Integer): Integer;
Begin
  Result := Obj.FindWindowSuper(spec1, flag1, type1, spec2, flag2, type2);
End;

Function Twy.WriteFloat(hwnd: Integer; addr: WideString; v: Single): Integer;
Begin
  Result := Obj.WriteFloat(hwnd, addr, v);
End;

Function Twy.EnableKeypadPatch(en: Integer): Integer;
Begin
  Result := Obj.EnableKeypadPatch(en);
End;

Function Twy.GetCpuType(): Integer;
Begin
  Result := Obj.GetCpuType;
End;

Function Twy.SetExportDict(index: Integer; dict_name: WideString): Integer;
Begin
  Result := Obj.SetExportDict(index, dict_name);
End;

Function Twy.LockMouseRect(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.LockMouseRect(x1, y1, x2, y2);
End;

Function Twy.TerminateProcess(pid: Integer): Integer;
Begin
  Result := Obj.TerminateProcess(pid);
End;

Function Twy.EnableIme(en: Integer): Integer;
Begin
  Result := Obj.EnableIme(en);
End;

Function Twy.Is64Bit(): Integer;
Begin
  Result := Obj.Is64Bit;
End;

Function Twy.OcrInFile(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.OcrInFile(x1, y1, x2, y2, pic_name, color, sim);
End;

Function Twy.DownloadFile(url: WideString; save_file: WideString;
  timeout: Integer): Integer;
Begin
  Result := Obj.DownloadFile(url, save_file, timeout);
End;

Function Twy.GetMachineCodeNoMac(): WideString;
Begin
  Result := Obj.GetMachineCodeNoMac;
End;

Function Twy.SetExcludeRegion(tpe: Integer; info: WideString): Integer;
Begin
  Result := Obj.SetExcludeRegion(tpe, info);
End;

Function Twy.GetWindowProcessId(hwnd: Integer): Integer;
Begin
  Result := Obj.GetWindowProcessId(hwnd);
End;

Function Twy.FindMultiColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  first_color: WideString; offset_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindMultiColorE(x1, y1, x2, y2, first_color, offset_color,
    sim, dir);
End;

Function Twy.GetColorNum(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): Integer;
Begin
  Result := Obj.GetColorNum(x1, y1, x2, y2, color, sim);
End;

Function Twy.FoobarPrintText(hwnd: Integer; text: WideString;
  color: WideString): Integer;
Begin
  Result := Obj.FoobarPrintText(hwnd, text, color);
End;

Function Twy.FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString): Integer;
Begin
  Result := Obj.FoobarFillRect(hwnd, x1, y1, x2, y2, color);
End;

Function Twy.Beep(fre: Integer; delay: Integer): Integer;
Begin
  Result := Obj.Beep(fre, delay);
End;

Function Twy.GetColorHSV(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.GetColorHSV(x, y);
End;

Function Twy.SwitchBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.SwitchBindWindow(hwnd);
End;

Function Twy.MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
  : WideString;
Begin
  Result := Obj.MoveToEx(x, y, w, h);
End;

Function Twy.WheelDown(): Integer;
Begin
  Result := Obj.WheelDown;
End;

Function Twy.ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.ReadString(hwnd, addr, tpe, length);
End;

Function Twy.MoveR(rx: Integer; ry: Integer): Integer;
Begin
  Result := Obj.MoveR(rx, ry);
End;

Function Twy.GetNowDict(): Integer;
Begin
  Result := Obj.GetNowDict;
End;

Function Twy.WriteDouble(hwnd: Integer; addr: WideString; v: Double): Integer;
Begin
  Result := Obj.WriteDouble(hwnd, addr, v);
End;

Function Twy.WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.WriteIntAddr(hwnd, addr, tpe, v);
End;

Function Twy.CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.CreateFoobarEllipse(hwnd, x, y, w, h);
End;

Function Twy.EnableKeypadMsg(en: Integer): Integer;
Begin
  Result := Obj.EnableKeypadMsg(en);
End;

Function Twy.ReleaseRef(): Integer;
Begin
  Result := Obj.ReleaseRef;
End;

Function Twy.DeleteIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.DeleteIniPwd(section, key, file_name, pwd);
End;

Function Twy.GetWordResultStr(str: WideString; index: Integer): WideString;
Begin
  Result := Obj.GetWordResultStr(str, index);
End;

Function Twy.FoobarUnlock(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarUnlock(hwnd);
End;

Function Twy.SetPicPwd(pwd: WideString): Integer;
Begin
  Result := Obj.SetPicPwd(pwd);
End;

Function Twy.GetWindowClass(hwnd: Integer): WideString;
Begin
  Result := Obj.GetWindowClass(hwnd);
End;

Function Twy.EnableKeypadSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.EnableKeypadSync(en, time_out);
End;

Function Twy.DisableScreenSave(): Integer;
Begin
  Result := Obj.DisableScreenSave;
End;

Function Twy.GetNetTimeSafe(): WideString;
Begin
  Result := Obj.GetNetTimeSafe;
End;

Function Twy.FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString): Integer;
Begin
  Result := Obj.FoobarDrawPic(hwnd, x, y, pic, trans_color);
End;

Function Twy.WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.WriteStringAddr(hwnd, addr, tpe, v);
End;

Function Twy.GetResultPos(str: WideString; index: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.GetResultPos(str, index, x, y);
End;

Function Twy.StringToData(string_value: WideString; tpe: Integer): WideString;
Begin
  Result := Obj.StringToData(string_value, tpe);
End;

Function Twy.GetOsType(): Integer;
Begin
  Result := Obj.GetOsType;
End;

Function Twy.GetForegroundWindow(): Integer;
Begin
  Result := Obj.GetForegroundWindow;
End;

Function Twy.LoadPic(pic_name: WideString): Integer;
Begin
  Result := Obj.LoadPic(pic_name);
End;

Function Twy.SetMinColGap(col_gap: Integer): Integer;
Begin
  Result := Obj.SetMinColGap(col_gap);
End;

Function Twy.GetWindowProcessPath(hwnd: Integer): WideString;
Begin
  Result := Obj.GetWindowProcessPath(hwnd);
End;

Function Twy.SetExactOcr(exact_ocr: Integer): Integer;
Begin
  Result := Obj.SetExactOcr(exact_ocr);
End;

Function Twy.DisableFontSmooth(): Integer;
Begin
  Result := Obj.DisableFontSmooth;
End;

Function Twy.GetColorBGR(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.GetColorBGR(x, y);
End;

Function Twy.EnableMouseSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.EnableMouseSync(en, time_out);
End;

Function Twy.FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer;
Begin
  Result := Obj.FoobarTextLineGap(hwnd, gap);
End;

Function Twy.SetDisplayRefreshDelay(T: Integer): Integer;
Begin
  Result := Obj.SetDisplayRefreshDelay(T);
End;

Function Twy.FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrE(x1, y1, x2, y2, str, color, sim);
End;

Function Twy.VirtualFreeEx(hwnd: Integer; addr: Int64): Integer;
Begin
  Result := Obj.VirtualFreeEx(hwnd, addr);
End;

Function Twy.GetBindWindow(): Integer;
Begin
  Result := Obj.GetBindWindow;
End;

Function Twy.DecodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.DecodeFile(file_name, pwd);
End;

Function Twy.GetDmCount(): Integer;
Begin
  Result := Obj.GetDmCount;
End;

Function Twy.EnableBind(en: Integer): Integer;
Begin
  Result := Obj.EnableBind(en);
End;

Function Twy.FindWindowByProcessId(process_id: Integer; class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.FindWindowByProcessId(process_id, class_name, title_name);
End;

Function Twy.ReadData(hwnd: Integer; addr: WideString; length: Integer)
  : WideString;
Begin
  Result := Obj.ReadData(hwnd, addr, length);
End;

Function Twy.MoveTo(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.MoveTo(x, y);
End;

Function Twy.LoadPicByte(addr: Integer; size: Integer;
  name: WideString): Integer;
Begin
  Result := Obj.LoadPicByte(addr, size, name);
End;

Function Twy.GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; out data: OleVariant; out size: OleVariant): Integer;
Begin
  Result := Obj.GetScreenDataBmp(x1, y1, x2, y2, data, size);
End;

Function Twy.FindDataEx(hwnd: Integer; addr_range: WideString; data: WideString;
  steps: Integer; multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindDataEx(hwnd, addr_range, data, steps, multi_thread, mode);
End;

Function Twy.FindWindowByProcess(process_name: WideString;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.FindWindowByProcess(process_name, class_name, title_name);
End;

Function Twy.IsFileExist(file_name: WideString): Integer;
Begin
  Result := Obj.IsFileExist(file_name);
End;

Function Twy.SetMinRowGap(row_gap: Integer): Integer;
Begin
  Result := Obj.SetMinRowGap(row_gap);
End;

Function Twy.GetPicSize(pic_name: WideString): WideString;
Begin
  Result := Obj.GetPicSize(pic_name);
End;

Function Twy.WriteDataAddr(hwnd: Integer; addr: Int64;
  data: WideString): Integer;
Begin
  Result := Obj.WriteDataAddr(hwnd, addr, data);
End;

Function Twy.EnterCri(): Integer;
Begin
  Result := Obj.EnterCri;
End;

Function Twy.EnableGetColorByCapture(en: Integer): Integer;
Begin
  Result := Obj.EnableGetColorByCapture(en);
End;

Function Twy.RegNoMac(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.RegNoMac(code, ver);
End;

Function Twy.SendStringIme2(hwnd: Integer; str: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.SendStringIme2(hwnd, str, mode);
End;

Function Twy.GetMousePointWindow(): Integer;
Begin
  Result := Obj.GetMousePointWindow;
End;

Function Twy.AsmCall(hwnd: Integer; mode: Integer): Int64;
Begin
  Result := Obj.AsmCall(hwnd, mode);
End;

Function Twy.SetWindowSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.SetWindowSize(hwnd, width, height);
End;

Function Twy.FindColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindColorE(x1, y1, x2, y2, color, sim, dir);
End;

Function Twy.ReadDataToBin(hwnd: Integer; addr: WideString;
  length: Integer): Integer;
Begin
  Result := Obj.ReadDataToBin(hwnd, addr, length);
End;

Function Twy.EnableDisplayDebug(enable_debug: Integer): Integer;
Begin
  Result := Obj.EnableDisplayDebug(enable_debug);
End;

Function Twy.SetPath(path: WideString): Integer;
Begin
  Result := Obj.SetPath(path);
End;

Function Twy.FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString; repeat_limit: Integer; delay: Integer): Integer;
Begin
  Result := Obj.FoobarStartGif(hwnd, x, y, pic_name, repeat_limit, delay);
End;

Function Twy.FreeScreenData(handle: Integer): Integer;
Begin
  Result := Obj.FreeScreenData(handle);
End;

Function Twy.CapturePng(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString): Integer;
Begin
  Result := Obj.CapturePng(x1, y1, x2, y2, file_name);
End;

Function Twy.AppendPicAddr(pic_info: WideString; addr: Integer; size: Integer)
  : WideString;
Begin
  Result := Obj.AppendPicAddr(pic_info, addr, size);
End;

Function Twy.MatchPicName(pic_name: WideString): WideString;
Begin
  Result := Obj.MatchPicName(pic_name);
End;

Function Twy.FoobarLock(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarLock(hwnd);
End;

Function Twy.FindPicMemE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindPicMemE(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function Twy.ForceUnBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.ForceUnBindWindow(hwnd);
End;

Function Twy.MoveWindow(hwnd: Integer; x: Integer; y: Integer): Integer;
Begin
  Result := Obj.MoveWindow(hwnd, x, y);
End;

Function Twy.FindStrFastS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): WideString;
Begin
  Result := Obj.FindStrFastS(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function Twy.GetPath(): WideString;
Begin
  Result := Obj.GetPath;
End;

Function Twy.Stop(id: Integer): Integer;
Begin
  Result := Obj.Stop(id);
End;

Function Twy.ReadIntAddr(hwnd: Integer; addr: Int64; tpe: Integer): Int64;
Begin
  Result := Obj.ReadIntAddr(hwnd, addr, tpe);
End;

Function Twy.Int64ToInt32(v: Int64): Integer;
Begin
  Result := Obj.Int64ToInt32(v);
End;

Function Twy.LeftDown(): Integer;
Begin
  Result := Obj.LeftDown;
End;

Function Twy.Log(info: WideString): Integer;
Begin
  Result := Obj.Log(info);
End;

Function Twy.GetClipboard(): WideString;
Begin
  Result := Obj.GetClipboard;
End;

Function Twy.EnableSpeedDx(en: Integer): Integer;
Begin
  Result := Obj.EnableSpeedDx(en);
End;

initialization

finalization

end.
