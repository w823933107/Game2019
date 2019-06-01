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
    class function CreateNormalObj: IPighead; static; // 创建普通对象
    class function CreateCustomObj: IPighead; static; // 创建定制对象
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
  Result := TNormalObj.Create;
end;

class function TObjFactory.CreateCustomObj: IPighead;
var
  iRet: Integer;
begin
  Result := TCustomObj.Create;
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

Constructor TCustomObj.Create();
Begin
  // Obj := CreateOleObject('wy.suxin');
  Obj := TObjFactory.CreateObj<Isuxin>(CLASS_suxin, gCustomPath);

End;

Destructor TCustomObj.Destroy();
Begin
  // obj := Unassigned;
  Obj := nil;
End;

Function TCustomObj.GetDir(tpe: Integer): WideString;
Begin
  Result := Obj.zUFrjTtmIAnRcL(tpe);
End;

Function TCustomObj.GetWindowTitle(hwnd: Integer): WideString;
Begin
  Result := Obj.aFWQVQvu(hwnd);
End;

Function TCustomObj.FaqGetSize(handle: Integer): Integer;
Begin
  Result := Obj.enmmArpgmLWUR(handle);
End;

Function TCustomObj.RightUp(): Integer;
Begin
  Result := Obj.xmBaheHXvwxBSee;
End;

Function TCustomObj.GetDPI(): Integer;
Begin
  Result := Obj.kTzQkbfrPJG;
End;

Function TCustomObj.FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.SYJH(x1, y1, x2, y2, pic_name, delta_color, sim, dir, x, y);
End;

Function TCustomObj.CaptureJpg(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.gHChKPAbDQ(x1, y1, x2, y2, file_name, quality);
End;

Function TCustomObj.IntToData(int_value: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.LnjbD(int_value, tpe);
End;

Function TCustomObj.VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
  : WideString;
Begin
  Result := Obj.CLsZISPR(hwnd, addr, pmbi);
End;

Function TCustomObj.FoobarSetFont(hwnd: Integer; font_name: WideString;
  size: Integer; flag: Integer): Integer;
Begin
  Result := Obj.rjgIwCwQXrRY(hwnd, font_name, size, flag);
End;

Function TCustomObj.ReadDoubleAddr(hwnd: Integer; addr: Int64): Double;
Begin
  Result := Obj.VaBmodo(hwnd, addr);
End;

Function TCustomObj.FoobarPrintText(hwnd: Integer; text: WideString;
  color: WideString): Integer;
Begin
  Result := Obj.TXfbVafJi(hwnd, text, color);
End;

Function TCustomObj.GetID(): Integer;
Begin
  Result := Obj.PysIjccvayTk;
End;

Function TCustomObj.ReadFileData(file_name: WideString; start_pos: Integer;
  end_pos: Integer): WideString;
Begin
  Result := Obj.rWJtaXQMDSh(file_name, start_pos, end_pos);
End;

Function TCustomObj.GetDmCount(): Integer;
Begin
  Result := Obj.nXTKTNlojUla;
End;

Function TCustomObj.FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString): Integer;
Begin
  Result := Obj.webcNfzF(hwnd, x, y, pic_name);
End;

Function TCustomObj.OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.BUVNIQ(x1, y1, x2, y2, color, sim);
End;

Function TCustomObj.GetWordResultCount(str: WideString): Integer;
Begin
  Result := Obj.yKFC(str);
End;

Function TCustomObj.WriteFile(file_name: WideString;
  content: WideString): Integer;
Begin
  Result := Obj.uXltuWXRlKNLkk(file_name, content);
End;

Function TCustomObj.WriteFloat(hwnd: Integer; addr: WideString;
  v: Single): Integer;
Begin
  Result := Obj.lYWBts(hwnd, addr, v);
End;

Function TCustomObj.GetRealPath(path: WideString): WideString;
Begin
  Result := Obj.YXpqDwCjLHLgIow(path);
End;

Function TCustomObj.SetRowGapNoDict(row_gap: Integer): Integer;
Begin
  Result := Obj.VAPj(row_gap);
End;

Function TCustomObj.GetCpuType(): Integer;
Begin
  Result := Obj.HsmUiHGTcqmBzyF;
End;

Function TCustomObj.AsmAdd(asm_ins: WideString): Integer;
Begin
  Result := Obj.vkgIGiWLxMwPWM(asm_ins);
End;

Function TCustomObj.EnableKeypadMsg(en: Integer): Integer;
Begin
  Result := Obj.ovUBkZRoiDJ(en);
End;

Function TCustomObj.DeleteIni(section: WideString; key: WideString;
  file_name: WideString): Integer;
Begin
  Result := Obj.SfPv(section, key, file_name);
End;

Function TCustomObj.SetMinRowGap(row_gap: Integer): Integer;
Begin
  Result := Obj.fPfWUWEkB(row_gap);
End;

Function TCustomObj.RegNoMac(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.CmfCzPIkckrJik(code, ver);
End;

Function TCustomObj.FindFloatEx(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.UvxaRvdWIntkh(hwnd, addr_range, float_value_min,
    float_value_max, steps, multi_thread, mode);
End;

Function TCustomObj.IsFolderExist(folder: WideString): Integer;
Begin
  Result := Obj.TQAfh(folder);
End;

Function TCustomObj.Beep(fre: Integer; delay: Integer): Integer;
Begin
  Result := Obj.vIwITzUsh(fre, delay);
End;

Function TCustomObj.ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.fpLXcWtoGo(hwnd, addr, tpe, length);
End;

Function TCustomObj.Stop(id: Integer): Integer;
Begin
  Result := Obj.PeBHegBdZB(id);
End;

Function TCustomObj.GetColorHSV(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.iAKB(x, y);
End;

Function TCustomObj.FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer): WideString;
Begin
  Result := Obj.KahwMccxXlZWJdX(x1, y1, x2, y2, color, sim, count,
    width, height);
End;

Function TCustomObj.MoveDD(dx: Integer; dy: Integer): Integer;
Begin
  Result := Obj.HWGxsVwyD(dx, dy);
End;

Function TCustomObj.FindDouble(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double): WideString;
Begin
  Result := Obj.qiMM(hwnd, addr_range, double_value_min, double_value_max);
End;

Function TCustomObj.SetDisplayRefreshDelay(T: Integer): Integer;
Begin
  Result := Obj.BABEaUsPsu(T);
End;

Function TCustomObj.EnumIniKey(section: WideString; file_name: WideString)
  : WideString;
Begin
  Result := Obj.feVoHL(section, file_name);
End;

Function TCustomObj.ShowScrMsg(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; msg: WideString; color: WideString): Integer;
Begin
  Result := Obj.xRwBzSKr(x1, y1, x2, y2, msg, color);
End;

Function TCustomObj.FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer;
Begin
  Result := Obj.rdgWuYgBDEzn(hwnd, gap);
End;

Function TCustomObj.GetCursorSpot(): WideString;
Begin
  Result := Obj.iNxYpfefxm;
End;

Function TCustomObj.VirtualFreeEx(hwnd: Integer; addr: Int64): Integer;
Begin
  Result := Obj.FgZwqKQZ(hwnd, addr);
End;

Function TCustomObj.SetPicPwd(pwd: WideString): Integer;
Begin
  Result := Obj.alXeQNkYgKNfKUK(pwd);
End;

Function TCustomObj.FindPicEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_name: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.ZkLE(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TCustomObj.GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.YHPfrQAUSM(x1, y1, x2, y2, color, sim);
End;

Function TCustomObj.ReadIntAddr(hwnd: Integer; addr: Int64;
  tpe: Integer): Int64;
Begin
  Result := Obj.NiaeRHEdwAzgQtx(hwnd, addr, tpe);
End;

Function TCustomObj.GetResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.XqgAZZNz(str, index, x, y);
End;

Function TCustomObj.WriteFloatAddr(hwnd: Integer; addr: Int64;
  v: Single): Integer;
Begin
  Result := Obj.qeIrvJkhZEBtq(hwnd, addr, v);
End;

Function TCustomObj.OcrInFile(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_name: WideString; color: WideString; sim: Double)
  : WideString;
Begin
  Result := Obj.RzwForeecY(x1, y1, x2, y2, pic_name, color, sim);
End;

Function TCustomObj.WriteData(hwnd: Integer; addr: WideString;
  data: WideString): Integer;
Begin
  Result := Obj.AnIPWsAjdTI(hwnd, addr, data);
End;

Function TCustomObj.GetBasePath(): WideString;
Begin
  Result := Obj.ftZKpZDs;
End;

Function TCustomObj.SetClipboard(data: WideString): Integer;
Begin
  Result := Obj.dkluvedfIqrgAIX(data);
End;

Function TCustomObj.FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString): Integer;
Begin
  Result := Obj.rBBnMBIpFPk(hwnd, x, y, pic, trans_color);
End;

Function TCustomObj.WriteDouble(hwnd: Integer; addr: WideString;
  v: Double): Integer;
Begin
  Result := Obj.SaVvNr(hwnd, addr, v);
End;

Function TCustomObj.GetDisplayInfo(): WideString;
Begin
  Result := Obj.kurGPNymZtUjNnM;
End;

Function TCustomObj.ReadIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): WideString;
Begin
  Result := Obj.EghqtuwlBhJn(section, key, file_name, pwd);
End;

Function TCustomObj.GetTime(): Integer;
Begin
  Result := Obj.dzXyhoQCwxX;
End;

Function TCustomObj.ImageToBmp(pic_name: WideString;
  bmp_name: WideString): Integer;
Begin
  Result := Obj.MHLSThNeHkC(pic_name, bmp_name);
End;

Function TCustomObj.DoubleToData(double_value: Double): WideString;
Begin
  Result := Obj.KTSMK(double_value);
End;

Function TCustomObj.FindDoubleEx(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.QGClYnMa(hwnd, addr_range, double_value_min, double_value_max,
    steps, multi_thread, mode);
End;

Function TCustomObj.WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.QPRbG(hwnd, addr, tpe, v);
End;

Function TCustomObj.FaqRelease(handle: Integer): Integer;
Begin
  Result := Obj.HBFNNw(handle);
End;

Function TCustomObj.DeleteFile(file_name: WideString): Integer;
Begin
  Result := Obj.uAbw(file_name);
End;

Function TCustomObj.OpenProcess(pid: Integer): Integer;
Begin
  Result := Obj.AQPViHeWClMJnF(pid);
End;

Function TCustomObj.SetMouseSpeed(speed: Integer): Integer;
Begin
  Result := Obj.IxxHM(speed);
End;

Function TCustomObj.EnableMouseMsg(en: Integer): Integer;
Begin
  Result := Obj.xVRBxy(en);
End;

Function TCustomObj.EnumIniSectionPwd(file_name: WideString; pwd: WideString)
  : WideString;
Begin
  Result := Obj.WsXrqN(file_name, pwd);
End;

Function TCustomObj.GetColor(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.MMdquvGECxLLbqT(x, y);
End;

Function TCustomObj.SetMemoryFindResultToFile(file_name: WideString): Integer;
Begin
  Result := Obj.GqzUhiEwfqAXX(file_name);
End;

Function TCustomObj.FoobarSetTrans(hwnd: Integer; trans: Integer;
  color: WideString; sim: Double): Integer;
Begin
  Result := Obj.PGWiiKqESVvv(hwnd, trans, color, sim);
End;

Function TCustomObj.ReadFile(file_name: WideString): WideString;
Begin
  Result := Obj.GmSb(file_name);
End;

Function TCustomObj.GetDict(index: Integer; font_index: Integer): WideString;
Begin
  Result := Obj.pidiLPkPGN(index, font_index);
End;

Function TCustomObj.RGB2BGR(rgb_color: WideString): WideString;
Begin
  Result := Obj.fygwKKTQsAsQ(rgb_color);
End;

Function TCustomObj.SetExcludeRegion(tpe: Integer; info: WideString): Integer;
Begin
  Result := Obj.NhJpGyhIpydJ(tpe, info);
End;

Function TCustomObj.FaqCaptureString(str: WideString): Integer;
Begin
  Result := Obj.XHqrxE(str);
End;

Function TCustomObj.EnableMouseAccuracy(en: Integer): Integer;
Begin
  Result := Obj.uqqXGk(en);
End;

Function TCustomObj.CheckUAC(): Integer;
Begin
  Result := Obj.YsHPznLkVndthxP;
End;

Function TCustomObj.GetWordResultStr(str: WideString; index: Integer)
  : WideString;
Begin
  Result := Obj.JqYxlsaWAvoAyh(str, index);
End;

Function TCustomObj.EnumProcess(name: WideString): WideString;
Begin
  Result := Obj.hMsbVbNqx(name);
End;

Function TCustomObj.GetResultCount(str: WideString): Integer;
Begin
  Result := Obj.xQYGmv(str);
End;

Function TCustomObj.RunApp(path: WideString; mode: Integer): Integer;
Begin
  Result := Obj.XQAhvBiRIcXl(path, mode);
End;

Function TCustomObj.FindWindowEx(parent: Integer; class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.TDUhmEjuEjSKCSf(parent, class_name, title_name);
End;

Function TCustomObj.ReadDataAddrToBin(hwnd: Integer; addr: Int64;
  length: Integer): Integer;
Begin
  Result := Obj.tNUnrzkdeClBnl(hwnd, addr, length);
End;

Function TCustomObj.FindColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.xtiPiiPFPxiJ(x1, y1, x2, y2, color, sim, dir);
End;

Function TCustomObj.SendPaste(hwnd: Integer): Integer;
Begin
  Result := Obj.XZPNYlLEboj(hwnd);
End;

Function TCustomObj.GetNetTimeByIp(ip: WideString): WideString;
Begin
  Result := Obj.wsyJ(ip);
End;

Function TCustomObj.FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.QzMmMsXhNNtSxGk(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function TCustomObj.FetchWord(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; word: WideString): WideString;
Begin
  Result := Obj.IIZPyKJURbY(x1, y1, x2, y2, color, word);
End;

Function TCustomObj.DisableFontSmooth(): Integer;
Begin
  Result := Obj.cuMrVoMFydnIU;
End;

Function TCustomObj.AppendPicAddr(pic_info: WideString; addr: Integer;
  size: Integer): WideString;
Begin
  Result := Obj.DznPUjrSl(pic_info, addr, size);
End;

Function TCustomObj.FoobarClose(hwnd: Integer): Integer;
Begin
  Result := Obj.MjPIPkFwPoCm(hwnd);
End;

Function TCustomObj.FindColorE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.LaCQF(x1, y1, x2, y2, color, sim, dir);
End;

Function TCustomObj.SetExactOcr(exact_ocr: Integer): Integer;
Begin
  Result := Obj.tHhQYJ(exact_ocr);
End;

Function TCustomObj.EnableFontSmooth(): Integer;
Begin
  Result := Obj.wrzsy;
End;

Function TCustomObj.SpeedNormalGraphic(en: Integer): Integer;
Begin
  Result := Obj.nFrbXhzNpmGB(en);
End;

Function TCustomObj.GetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.RDTo(hwnd, flag);
End;

Function TCustomObj.ExecuteCmd(cmd: WideString; current_dir: WideString;
  time_out: Integer): WideString;
Begin
  Result := Obj.fsuuF(cmd, current_dir, time_out);
End;

Function TCustomObj.BindWindowEx(hwnd: Integer; display: WideString;
  mouse: WideString; keypad: WideString; public_desc: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.ZBTNIHBGeIemDSj(hwnd, display, mouse, keypad,
    public_desc, mode);
End;

Function TCustomObj.delay(mis: Integer): Integer;
Begin
  Result := Obj.biISsaTQgm(mis);
End;

Function TCustomObj.MoveFile(src_file: WideString;
  dst_file: WideString): Integer;
Begin
  Result := Obj.NLWkeHsy(src_file, dst_file);
End;

Function TCustomObj.Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString): Integer;
Begin
  Result := Obj.BKTocmNnnHIN(x1, y1, x2, y2, file_name);
End;

Function TCustomObj.MiddleDown(): Integer;
Begin
  Result := Obj.oKwHpGksXDne;
End;

Function TCustomObj.DmGuardParams(cmd: WideString; sub_cmd: WideString;
  param: WideString): WideString;
Begin
  Result := Obj.rGQhFSDUoLp(cmd, sub_cmd, param);
End;

Function TCustomObj.DownCpu(rate: Integer): Integer;
Begin
  Result := Obj.UPvltYYRDtekbG(rate);
End;

Function TCustomObj.UnBindWindow(): Integer;
Begin
  Result := Obj.MZHPFi;
End;

Function TCustomObj.FindStrEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.zUowz(x1, y1, x2, y2, str, color, sim);
End;

Function TCustomObj.FindWindowByProcess(process_name: WideString;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.kGtoHbuTM(process_name, class_name, title_name);
End;

Function TCustomObj.DisablePowerSave(): Integer;
Begin
  Result := Obj.sXjUaFekoEKX;
End;

Function TCustomObj.RightClick(): Integer;
Begin
  Result := Obj.GbexqmPTpmQrD;
End;

Function TCustomObj.DisAssemble(asm_code: WideString; base_addr: Int64;
  is_64bit: Integer): WideString;
Begin
  Result := Obj.naGjLkfsFMVeBX(asm_code, base_addr, is_64bit);
End;

Function TCustomObj.EnableGetColorByCapture(en: Integer): Integer;
Begin
  Result := Obj.uwyrqkkbWTYcgg(en);
End;

Function TCustomObj.FindStrFastEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.ZBHw(x1, y1, x2, y2, str, color, sim);
End;

Function TCustomObj.FindFloat(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single): WideString;
Begin
  Result := Obj.xtWpBdqMMxyp(hwnd, addr_range, float_value_min,
    float_value_max);
End;

Function TCustomObj.ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
  y1: Integer; x2: Integer; y2: Integer): WideString;
Begin
  Result := Obj.gcyZAtb(all_pos, tpe, x1, y1, x2, y2);
End;

Function TCustomObj.FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.AUtAalGEZsVCfR(x1, y1, x2, y2, first_color, offset_color,
    sim, dir);
End;

Function TCustomObj.FindColorBlock(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.xpUtzYdsvPxVRSU(x1, y1, x2, y2, color, sim, count, width,
    height, x, y);
End;

Function TCustomObj.Play(file_name: WideString): Integer;
Begin
  Result := Obj.vhANnDlgMb(file_name);
End;

Function TCustomObj.GetWindow(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.VXEtISYeVGWuTfV(hwnd, flag);
End;

Function TCustomObj.WheelDown(): Integer;
Begin
  Result := Obj.lJkEJU;
End;

Function TCustomObj.SetLocale(): Integer;
Begin
  Result := Obj.uPyFzWCv;
End;

Function TCustomObj.ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer;
Begin
  Result := Obj.SpGP(hwnd, is_show);
End;

Function TCustomObj.GetProcessInfo(pid: Integer): WideString;
Begin
  Result := Obj.uYtIsG(pid);
End;

Function TCustomObj.GetPointWindow(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.QKMS(x, y);
End;

Function TCustomObj.UseDict(index: Integer): Integer;
Begin
  Result := Obj.RdCLLteJI(index);
End;

Function TCustomObj.FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString; style: Integer;
  width: Integer): Integer;
Begin
  Result := Obj.nsrWFBZHwVfHg(hwnd, x1, y1, x2, y2, color, style, width);
End;

Function TCustomObj.RegEx(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.tMlB(code, ver, ip);
End;

Function TCustomObj.GetLastError(): Integer;
Begin
  Result := Obj.XrBZLMhRE;
End;

Function TCustomObj.SetKeypadDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.NwXjh(tpe, delay);
End;

Function TCustomObj.GetColorNum(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double): Integer;
Begin
  Result := Obj.GXKLW(x1, y1, x2, y2, color, sim);
End;

Function TCustomObj.SendString2(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.uTecZFRmP(hwnd, str);
End;

Function TCustomObj.GetClientRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.bNRzdqa(hwnd, x1, y1, x2, y2);
End;

Function TCustomObj.GetModuleBaseAddr(hwnd: Integer;
  module_name: WideString): Int64;
Begin
  Result := Obj.iuPTc(hwnd, module_name);
End;

Function TCustomObj.AddDict(index: Integer; dict_info: WideString): Integer;
Begin
  Result := Obj.MESAr(index, dict_info);
End;

Function TCustomObj.LoadPic(pic_name: WideString): Integer;
Begin
  Result := Obj.mtikjWeiIwYAp(pic_name);
End;

Function TCustomObj.GetMachineCodeNoMac(): WideString;
Begin
  Result := Obj.aMRwfhwsVkk;
End;

Function TCustomObj.FoobarUnlock(hwnd: Integer): Integer;
Begin
  Result := Obj.SZsrfKgpv(hwnd);
End;

Function TCustomObj.GetOsType(): Integer;
Begin
  Result := Obj.nJckyIzi;
End;

Function TCustomObj.SetWordGapNoDict(word_gap: Integer): Integer;
Begin
  Result := Obj.JxCue(word_gap);
End;

Function TCustomObj.LeftDown(): Integer;
Begin
  Result := Obj.nPhyPsyFWRgo;
End;

Function TCustomObj.SetEnumWindowDelay(delay: Integer): Integer;
Begin
  Result := Obj.ILUWrxoIxv(delay);
End;

Function TCustomObj.FindShapeEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.mbxjJBvNghKT(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function TCustomObj.FreeProcessMemory(hwnd: Integer): Integer;
Begin
  Result := Obj.jlYhlkCHG(hwnd);
End;

Function TCustomObj.ver(): WideString;
Begin
  Result := Obj.KQSzhh;
End;

Function TCustomObj.GetForegroundWindow(): Integer;
Begin
  Result := Obj.HxDptMJWKYRrwaP;
End;

Function TCustomObj.ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
  : WideString;
Begin
  Result := Obj.TVTdIwJoXuI(hwnd, addr, length);
End;

Function TCustomObj.KeyUp(vk: Integer): Integer;
Begin
  Result := Obj.Qwdmm(vk);
End;

Function TCustomObj.FindShapeE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.ZBkBxlawS(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function TCustomObj.WriteInt(hwnd: Integer; addr: WideString; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.wDqqTc(hwnd, addr, tpe, v);
End;

Function TCustomObj.EnableRealKeypad(en: Integer): Integer;
Begin
  Result := Obj.tFzLoEqrmvtW(en);
End;

Function TCustomObj.EnumWindowSuper(spec1: WideString; flag1: Integer;
  type1: Integer; spec2: WideString; flag2: Integer; type2: Integer;
  sort: Integer): WideString;
Begin
  Result := Obj.adpUwvwRXq(spec1, flag1, type1, spec2, flag2, type2, sort);
End;

Function TCustomObj.IsBind(hwnd: Integer): Integer;
Begin
  Result := Obj.lyCoBRENZgC(hwnd);
End;

Function TCustomObj.SetSimMode(mode: Integer): Integer;
Begin
  Result := Obj.iRFfULVlKj(mode);
End;

Function TCustomObj.GetWindowProcessPath(hwnd: Integer): WideString;
Begin
  Result := Obj.mFmdfkqJK(hwnd);
End;

Function TCustomObj.KeyDownChar(key_str: WideString): Integer;
Begin
  Result := Obj.HWCKwbSzU(key_str);
End;

Function TCustomObj.MiddleClick(): Integer;
Begin
  Result := Obj.ZAZWf;
End;

Function TCustomObj.WriteDataAddrFromBin(hwnd: Integer; addr: Int64;
  data: Integer; length: Integer): Integer;
Begin
  Result := Obj.jmzn(hwnd, addr, data, length);
End;

Function TCustomObj.IsFileExist(file_name: WideString): Integer;
Begin
  Result := Obj.WXrLStnefG(file_name);
End;

Function TCustomObj.FindStrFastExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FPapVSwcBJeBgzg(x1, y1, x2, y2, str, color, sim);
End;

Function TCustomObj.FindStrExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.zRKhZUgZceLu(x1, y1, x2, y2, str, color, sim);
End;

Function TCustomObj.EnableIme(en: Integer): Integer;
Begin
  Result := Obj.LJWzG(en);
End;

Function TCustomObj.ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.xwvgvjz(hwnd, addr, tpe, length);
End;

Function TCustomObj.SetUAC(uac: Integer): Integer;
Begin
  Result := Obj.fKsz(uac);
End;

Function TCustomObj.DmGuard(en: Integer; tpe: WideString): Integer;
Begin
  Result := Obj.YkNyHbgycUikytH(en, tpe);
End;

Function TCustomObj.FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.PnqzLgGKf(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TCustomObj.GetMac(): WideString;
Begin
  Result := Obj.arpieUV;
End;

Function TCustomObj.FindMulColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double): Integer;
Begin
  Result := Obj.qhyibeMUS(x1, y1, x2, y2, color, sim);
End;

Function TCustomObj.ReleaseRef(): Integer;
Begin
  Result := Obj.zrfVEZGxWJVLwY;
End;

Function TCustomObj.EnumIniSection(file_name: WideString): WideString;
Begin
  Result := Obj.hvMEAEeyiDERvM(file_name);
End;

Function TCustomObj.GetClientSize(hwnd: Integer; out width: OleVariant;
  out height: OleVariant): Integer;
Begin
  Result := Obj.fWKDSWBAzfBmV(hwnd, width, height);
End;

Function TCustomObj.SendCommand(cmd: WideString): Integer;
Begin
  Result := Obj.wuuwAMhWyjJ(cmd);
End;

Function TCustomObj.SendStringIme(str: WideString): Integer;
Begin
  Result := Obj.NeZFks(str);
End;

Function TCustomObj.FindWindowSuper(spec1: WideString; flag1: Integer;
  type1: Integer; spec2: WideString; flag2: Integer; type2: Integer): Integer;
Begin
  Result := Obj.FfRmNvRjL(spec1, flag1, type1, spec2, flag2, type2);
End;

Function TCustomObj.FindPicMemE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.npMQqsycbYx(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function TCustomObj.SetDisplayAcceler(level: Integer): Integer;
Begin
  Result := Obj.KxxB(level);
End;

Function TCustomObj.KeyPressChar(key_str: WideString): Integer;
Begin
  Result := Obj.NLKEIYsUuqMoApw(key_str);
End;

Function TCustomObj.FloatToData(float_value: Single): WideString;
Begin
  Result := Obj.PbbmlT(float_value);
End;

Function TCustomObj.GetDictCount(index: Integer): Integer;
Begin
  Result := Obj.qNCUG(index);
End;

Function TCustomObj.OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.CKaxgbULZApBQu(x1, y1, x2, y2, color, sim);
End;

Function TCustomObj.GetScreenHeight(): Integer;
Begin
  Result := Obj.ikLcLgpefCU;
End;

Function TCustomObj.SetWordLineHeightNoDict(line_height: Integer): Integer;
Begin
  Result := Obj.YRDfm(line_height);
End;

Function TCustomObj.EnumWindowByProcess(process_name: WideString;
  title: WideString; class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.WmDUrdvzvx(process_name, title, class_name, filter);
End;

Function TCustomObj.FindStrWithFont(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.aSvIJbik(x1, y1, x2, y2, str, color, sim, font_name, font_size,
    flag, x, y);
End;

Function TCustomObj.SetMemoryHwndAsProcessId(en: Integer): Integer;
Begin
  Result := Obj.NhrxYkNlVHFaRvB(en);
End;

Function TCustomObj.HackSpeed(rate: Double): Integer;
Begin
  Result := Obj.ELzgHnRb(rate);
End;

Function TCustomObj.ReadData(hwnd: Integer; addr: WideString; length: Integer)
  : WideString;
Begin
  Result := Obj.NyJHEHQ(hwnd, addr, length);
End;

Function TCustomObj.GetPath(): WideString;
Begin
  Result := Obj.LwaUtJt;
End;

Function TCustomObj.GetMachineCode(): WideString;
Begin
  Result := Obj.WKDvQweebkvjHW;
End;

Function TCustomObj.FindStrFast(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.vTSqTHXxWMrZ(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TCustomObj.LeaveCri(): Integer;
Begin
  Result := Obj.rIHaPE;
End;

Function TCustomObj.SetPath(path: WideString): Integer;
Begin
  Result := Obj.HtljPtfkT(path);
End;

Function TCustomObj.GetFps(): Integer;
Begin
  Result := Obj.nDvRmmptvUnTJyg;
End;

Function TCustomObj.FindPicMem(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.TuKkNmRqjnonABG(x1, y1, x2, y2, pic_info, delta_color, sim,
    dir, x, y);
End;

Function TCustomObj.FindPicExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_name: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.ZSLyETTBXofw(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TCustomObj.GetNetTimeSafe(): WideString;
Begin
  Result := Obj.ZVEgKSBPF;
End;

Function TCustomObj.MoveR(rx: Integer; ry: Integer): Integer;
Begin
  Result := Obj.BXGIKg(rx, ry);
End;

Function TCustomObj.GetOsBuildNumber(): Integer;
Begin
  Result := Obj.YFSN;
End;

Function TCustomObj.FindNearestPos(all_pos: WideString; tpe: Integer;
  x: Integer; y: Integer): WideString;
Begin
  Result := Obj.bmbeNiyLCSE(all_pos, tpe, x, y);
End;

Function TCustomObj.GetEnv(index: Integer; name: WideString): WideString;
Begin
  Result := Obj.BKXYEdXP(index, name);
End;

Function TCustomObj.EnableFakeActive(en: Integer): Integer;
Begin
  Result := Obj.APDZPcR(en);
End;

Function TCustomObj.ExitOs(tpe: Integer): Integer;
Begin
  Result := Obj.ittPYzBERKuhh(tpe);
End;

Function TCustomObj.SortPosDistance(all_pos: WideString; tpe: Integer;
  x: Integer; y: Integer): WideString;
Begin
  Result := Obj.BuqoRPhqAeNdQH(all_pos, tpe, x, y);
End;

Function TCustomObj.EnumWindow(parent: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.nmcGkSdggTVtg(parent, title, class_name, filter);
End;

Function TCustomObj.BGR2RGB(bgr_color: WideString): WideString;
Begin
  Result := Obj.vyVatBkbDhxbqL(bgr_color);
End;

Function TCustomObj.WriteIni(section: WideString; key: WideString;
  v: WideString; file_name: WideString): Integer;
Begin
  Result := Obj.Zirbij(section, key, v, file_name);
End;

Function TCustomObj.RightDown(): Integer;
Begin
  Result := Obj.IVTwWxKcvFI;
End;

Function TCustomObj.GetCursorShape(): WideString;
Begin
  Result := Obj.wikkNPr;
End;

Function TCustomObj.Reg(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.tFZPIwzfL(code, ver);
End;

Function TCustomObj.EnterCri(): Integer;
Begin
  Result := Obj.jyEYiVMXiFjBUW;
End;

Function TCustomObj.SendStringIme2(hwnd: Integer; str: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.PyuYJGZvDhbFE(hwnd, str, mode);
End;

Function TCustomObj.FreeScreenData(handle: Integer): Integer;
Begin
  Result := Obj.xZeeArtlhtFhVrC(handle);
End;

Function TCustomObj.FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.iZyLlwMU(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function TCustomObj.KeyPressStr(key_str: WideString; delay: Integer): Integer;
Begin
  Result := Obj.DPuTHAf(key_str, delay);
End;

Function TCustomObj.LeftDoubleClick(): Integer;
Begin
  Result := Obj.DNwZKDzoatLA;
End;

Function TCustomObj.KeyUpChar(key_str: WideString): Integer;
Begin
  Result := Obj.PSIvqvu(key_str);
End;

Function TCustomObj.GetCursorShapeEx(tpe: Integer): WideString;
Begin
  Result := Obj.KnWR(tpe);
End;

Function TCustomObj.EnableRealMouse(en: Integer; mousedelay: Integer;
  mousestep: Integer): Integer;
Begin
  Result := Obj.wfLKJnEwo(en, mousedelay, mousestep);
End;

Function TCustomObj.FindString(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer): WideString;
Begin
  Result := Obj.grDs(hwnd, addr_range, string_value, tpe);
End;

Function TCustomObj.ReadIni(section: WideString; key: WideString;
  file_name: WideString): WideString;
Begin
  Result := Obj.kVyAekLKR(section, key, file_name);
End;

Function TCustomObj.SetWordGap(word_gap: Integer): Integer;
Begin
  Result := Obj.DwejdWvmfKpr(word_gap);
End;

Function TCustomObj.DisableScreenSave(): Integer;
Begin
  Result := Obj.PIBUkDuJJd;
End;

Function TCustomObj.FindIntEx(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.wgkwlwgu(hwnd, addr_range, int_value_min, int_value_max, tpe,
    steps, multi_thread, mode);
End;

Function TCustomObj.GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
  fun_name: WideString): Int64;
Begin
  Result := Obj.pdEyCeYj(hwnd, base_addr, fun_name);
End;

Function TCustomObj.CopyFile(src_file: WideString; dst_file: WideString;
  over: Integer): Integer;
Begin
  Result := Obj.IXZrpl(src_file, dst_file, over);
End;

Function TCustomObj.SetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.CuBWMdp(hwnd, flag);
End;

Function TCustomObj.SetMinColGap(col_gap: Integer): Integer;
Begin
  Result := Obj.UDrIjEBgcDCew(col_gap);
End;

Function TCustomObj.FoobarDrawText(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; text: WideString; color: WideString;
  align: Integer): Integer;
Begin
  Result := Obj.twNbcTaVrX(hwnd, x, y, w, h, text, color, align);
End;

Function TCustomObj.Delays(min_s: Integer; max_s: Integer): Integer;
Begin
  Result := Obj.NxqlGsq(min_s, max_s);
End;

Function TCustomObj.RegExNoMac(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.TLweTiXtv(code, ver, ip);
End;

Function TCustomObj.GetBindWindow(): Integer;
Begin
  Result := Obj.ZFopiVw;
End;

Function TCustomObj.EnumWindowByProcessId(pid: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.IHmrtuuVklZ(pid, title, class_name, filter);
End;

Function TCustomObj.SetShowErrorMsg(show: Integer): Integer;
Begin
  Result := Obj.owEYUcjQ(show);
End;

Function TCustomObj.ReadDouble(hwnd: Integer; addr: WideString): Double;
Begin
  Result := Obj.JgQXxXXzZ(hwnd, addr);
End;

Function TCustomObj.LeftClick(): Integer;
Begin
  Result := Obj.JlKez;
End;

Function TCustomObj.GetScreenDepth(): Integer;
Begin
  Result := Obj.UHVxUguUxIC;
End;

Function TCustomObj.SelectDirectory(): WideString;
Begin
  Result := Obj.sYGTvvuNIYjR;
End;

Function TCustomObj.GetLocale(): Integer;
Begin
  Result := Obj.wwfBwhV;
End;

Function TCustomObj.CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString; sim: Double): Integer;
Begin
  Result := Obj.ZEfKWxJTFSA(hwnd, x, y, pic, trans_color, sim);
End;

Function TCustomObj.SetWindowTransparent(hwnd: Integer; v: Integer): Integer;
Begin
  Result := Obj.AvVnotMyMED(hwnd, v);
End;

Function TCustomObj.FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer;
Begin
  Result := Obj.ysvpGHTCjSxkM(hwnd, dir);
End;

Function TCustomObj.SetExportDict(index: Integer;
  dict_name: WideString): Integer;
Begin
  Result := Obj.zDEItHqZj(index, dict_name);
End;

Function TCustomObj.CheckInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.zMYruEiAEwY(hwnd, id);
End;

Function TCustomObj.SetDisplayInput(mode: WideString): Integer;
Begin
  Result := Obj.ZZCwmxbkrzbp(mode);
End;

Function TCustomObj.TerminateProcess(pid: Integer): Integer;
Begin
  Result := Obj.ZldLoKNEHN(pid);
End;

Function TCustomObj.LockInput(locks: Integer): Integer;
Begin
  Result := Obj.vhtjEbma(locks);
End;

Function TCustomObj.SetDict(index: Integer; dict_name: WideString): Integer;
Begin
  Result := Obj.kTkpWA(index, dict_name);
End;

Function TCustomObj.FaqCancel(): Integer;
Begin
  Result := Obj.XMSdon;
End;

Function TCustomObj.FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.RhqwdYBJQ(x1, y1, x2, y2, file_name, quality);
End;

Function TCustomObj.DecodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.Qgkln(file_name, pwd);
End;

Function TCustomObj.GetNetTime(): WideString;
Begin
  Result := Obj.zyvyIy;
End;

Function TCustomObj.CheckFontSmooth(): Integer;
Begin
  Result := Obj.ZNAELdSZNbgqAw;
End;

Function TCustomObj.AsmClear(): Integer;
Begin
  Result := Obj.PhweWsX;
End;

Function TCustomObj.StrStr(s: WideString; str: WideString): Integer;
Begin
  Result := Obj.dUSlsVEKouIJJWb(s, str);
End;

Function TCustomObj.FindWindowByProcessId(process_id: Integer;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.NdQkPMPBgLo(process_id, class_name, title_name);
End;

Function TCustomObj.WriteIniPwd(section: WideString; key: WideString;
  v: WideString; file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.CCgQMrvmUvrwQh(section, key, v, file_name, pwd);
End;

Function TCustomObj.KeyPress(vk: Integer): Integer;
Begin
  Result := Obj.lKov(vk);
End;

Function TCustomObj.FaqIsPosted(): Integer;
Begin
  Result := Obj.vbHCVzFpiEvgF;
End;

Function TCustomObj.ActiveInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.pxyHwQjEa(hwnd, id);
End;

Function TCustomObj.BindWindow(hwnd: Integer; display: WideString;
  mouse: WideString; keypad: WideString; mode: Integer): Integer;
Begin
  Result := Obj.PJPoNtGyhtSpbJF(hwnd, display, mouse, keypad, mode);
End;

Function TCustomObj.VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer; old_protect: Integer): Integer;
Begin
  Result := Obj.SmMUDbmvIHZW(hwnd, addr, size, tpe, old_protect);
End;

Function TCustomObj.CreateFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.EPCH(folder_name);
End;

Function TCustomObj.GetPicSize(pic_name: WideString): WideString;
Begin
  Result := Obj.xgccZAblYh(pic_name);
End;

Function TCustomObj.FindPicMemEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.NJkRd(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function TCustomObj.SetMouseDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.gCmoz(tpe, delay);
End;

Function TCustomObj.GetNowDict(): Integer;
Begin
  Result := Obj.ZUwaUKua;
End;

Function TCustomObj.GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString): WideString;
Begin
  Result := Obj.gVGVKSIYqSiz(x1, y1, x2, y2, color);
End;

Function TCustomObj.GetFileLength(file_name: WideString): Integer;
Begin
  Result := Obj.uxnLC(file_name);
End;

Function TCustomObj.FindStrFastE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.HfWVubrjaP(x1, y1, x2, y2, str, color, sim);
End;

Function TCustomObj.FindInputMethod(id: WideString): Integer;
Begin
  Result := Obj.XzbenJdmgJdhzZQ(id);
End;

Function TCustomObj.FaqPost(server: WideString; handle: Integer;
  request_type: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.puXoGUk(server, handle, request_type, time_out);
End;

Function TCustomObj.EnableSpeedDx(en: Integer): Integer;
Begin
  Result := Obj.VHLuftJPYsfzfiu(en);
End;

Function TCustomObj.MoveWindow(hwnd: Integer; x: Integer; y: Integer): Integer;
Begin
  Result := Obj.xhaEMSj(hwnd, x, y);
End;

Function TCustomObj.Assemble(base_addr: Int64; is_64bit: Integer): WideString;
Begin
  Result := Obj.LaJRYMUI(base_addr, is_64bit);
End;

Function TCustomObj.SwitchBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.dUbtEzxGlrAYR(hwnd);
End;

Function TCustomObj.LockMouseRect(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.zogzHFehJQgQUMQ(x1, y1, x2, y2);
End;

Function TCustomObj.SetDictMem(index: Integer; addr: Integer;
  size: Integer): Integer;
Begin
  Result := Obj.inoDBJyLDenvQA(index, addr, size);
End;

Function TCustomObj.InitCri(): Integer;
Begin
  Result := Obj.AvTkgVtuc;
End;

Function TCustomObj.FindInt(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.shXNhRmUxEaVR(hwnd, addr_range, int_value_min,
    int_value_max, tpe);
End;

Function TCustomObj.SetDisplayDelay(T: Integer): Integer;
Begin
  Result := Obj.FcktPpuSzYc(T);
End;

Function TCustomObj.GetMouseSpeed(): Integer;
Begin
  Result := Obj.LKrehaGyEFkQHk;
End;

Function TCustomObj.FoobarLock(hwnd: Integer): Integer;
Begin
  Result := Obj.BNQbwwnVV(hwnd);
End;

Function TCustomObj.VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer): Int64;
Begin
  Result := Obj.FxhPYwh(hwnd, addr, size, tpe);
End;

Function TCustomObj.EnableShareDict(en: Integer): Integer;
Begin
  Result := Obj.CeBIcDUuXg(en);
End;

Function TCustomObj.FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.ZUKcpVTKReub(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TCustomObj.FaqSend(server: WideString; handle: Integer;
  request_type: Integer; time_out: Integer): WideString;
Begin
  Result := Obj.argLDhCuvLbx(server, handle, request_type, time_out);
End;

Function TCustomObj.ReadFloatAddr(hwnd: Integer; addr: Int64): Single;
Begin
  Result := Obj.NtLrJiRlddM(hwnd, addr);
End;

Function TCustomObj.SetWordLineHeight(line_height: Integer): Integer;
Begin
  Result := Obj.WgUFVH(line_height);
End;

Function TCustomObj.EnableBind(en: Integer): Integer;
Begin
  Result := Obj.LvDwyVbkLKBNpX(en);
End;

Function TCustomObj.Is64Bit(): Integer;
Begin
  Result := Obj.ExSsaGI;
End;

Function TCustomObj.FindDataEx(hwnd: Integer; addr_range: WideString;
  data: WideString; steps: Integer; multi_thread: Integer; mode: Integer)
  : WideString;
Begin
  Result := Obj.EghZYsZ(hwnd, addr_range, data, steps, multi_thread, mode);
End;

Function TCustomObj.KeyDown(vk: Integer): Integer;
Begin
  Result := Obj.bNSxXNHWbDmQ(vk);
End;

Function TCustomObj.SetWindowText(hwnd: Integer; text: WideString): Integer;
Begin
  Result := Obj.upJGlDbfQXzAi(hwnd, text);
End;

Function TCustomObj.WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.rEZzpBQB(hwnd, addr, tpe, v);
End;

Function TCustomObj.EncodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.ImZpRrYwIJCs(file_name, pwd);
End;

Function TCustomObj.LoadPicByte(addr: Integer; size: Integer;
  name: WideString): Integer;
Begin
  Result := Obj.gLyfPMYcHlksCE(addr, size, name);
End;

Function TCustomObj.GetScreenData(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.HGjZcPSfPUboAI(x1, y1, x2, y2);
End;

Function TCustomObj.GetClipboard(): WideString;
Begin
  Result := Obj.YguAyNMy;
End;

Function TCustomObj.GetColorBGR(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.CaHhXpE(x, y);
End;

Function TCustomObj.FindStrFastS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.BehGgVCltWPqonB(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TCustomObj.CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.vWfaEFNUnesbjX(hwnd, x, y, w, h);
End;

Function TCustomObj.MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
  : WideString;
Begin
  Result := Obj.KuRJx(x, y, w, h);
End;

Function TCustomObj.GetWindowRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.oLPcrnQnbxa(hwnd, x1, y1, x2, y2);
End;

Function TCustomObj.SetWindowSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.iFacCwAIk(hwnd, width, height);
End;

Function TCustomObj.AsmCall(hwnd: Integer; mode: Integer): Int64;
Begin
  Result := Obj.cAZC(hwnd, mode);
End;

Function TCustomObj.SetScreen(width: Integer; height: Integer;
  depth: Integer): Integer;
Begin
  Result := Obj.eQrjv(width, height, depth);
End;

Function TCustomObj.ClientToScreen(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.JvMwXPB(hwnd, x, y);
End;

Function TCustomObj.FindWindow(class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.DaKhHXq(class_name, title_name);
End;

Function TCustomObj.WriteDataAddr(hwnd: Integer; addr: Int64;
  data: WideString): Integer;
Begin
  Result := Obj.AkCfQQnYzF(hwnd, addr, data);
End;

Function TCustomObj.GetScreenWidth(): Integer;
Begin
  Result := Obj.FkmWFNFzqp;
End;

Function TCustomObj.FindColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.zIxDAda(x1, y1, x2, y2, color, sim, dir, x, y);
End;

Function TCustomObj.FindMultiColorE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.ZRkau(x1, y1, x2, y2, first_color, offset_color, sim, dir);
End;

Function TCustomObj.GetWindowClass(hwnd: Integer): WideString;
Begin
  Result := Obj.KqdwNps(hwnd);
End;

Function TCustomObj.CapturePre(file_name: WideString): Integer;
Begin
  Result := Obj.rrNwvYIAeqhwfgE(file_name);
End;

Function TCustomObj.GetForegroundFocus(): Integer;
Begin
  Result := Obj.WYNES;
End;

Function TCustomObj.SetAero(en: Integer): Integer;
Begin
  Result := Obj.cQnqzGtc(en);
End;

Function TCustomObj.FoobarTextRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.KvRfGsKhDjt(hwnd, x, y, w, h);
End;

Function TCustomObj.FindMultiColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.VHfJHteo(x1, y1, x2, y2, first_color, offset_color, sim,
    dir, x, y);
End;

Function TCustomObj.DownloadFile(url: WideString; save_file: WideString;
  timeout: Integer): Integer;
Begin
  Result := Obj.nEPmKjs(url, save_file, timeout);
End;

Function TCustomObj.MatchPicName(pic_name: WideString): WideString;
Begin
  Result := Obj.TNgMhtRIS(pic_name);
End;

Function TCustomObj.Log(info: WideString): Integer;
Begin
  Result := Obj.mCfR(info);
End;

Function TCustomObj.GetCursorPos(out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.giZGxidJLSie(x, y);
End;

Function TCustomObj.GetMousePointWindow(): Integer;
Begin
  Result := Obj.TAvtmpJA;
End;

Function TCustomObj.GetDiskSerial(): WideString;
Begin
  Result := Obj.NTiDlpAa;
End;

Function TCustomObj.Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.nAxMvRZGveUZUG(x1, y1, x2, y2, color, sim);
End;

Function TCustomObj.ReadInt(hwnd: Integer; addr: WideString;
  tpe: Integer): Int64;
Begin
  Result := Obj.iZkIuX(hwnd, addr, tpe);
End;

Function TCustomObj.GetWindowProcessId(hwnd: Integer): Integer;
Begin
  Result := Obj.nQZCZGfGUNa(hwnd);
End;

Function TCustomObj.AsmCallEx(hwnd: Integer; mode: Integer;
  base_addr: WideString): Int64;
Begin
  Result := Obj.yZEeGDnoBJUG(hwnd, mode, base_addr);
End;

Function TCustomObj.ClearDict(index: Integer): Integer;
Begin
  Result := Obj.ykKY(index);
End;

Function TCustomObj.Int64ToInt32(v: Int64): Integer;
Begin
  Result := Obj.rWynQZk(v);
End;

Function TCustomObj.SetDictPwd(pwd: WideString): Integer;
Begin
  Result := Obj.aQTT(pwd);
End;

Function TCustomObj.FaqFetch(): WideString;
Begin
  Result := Obj.XEzYS;
End;

Function TCustomObj.GetSpecialWindow(flag: Integer): Integer;
Begin
  Result := Obj.GgXGkUIvJUCoA(flag);
End;

Function TCustomObj.EnablePicCache(en: Integer): Integer;
Begin
  Result := Obj.WLqPNK(en);
End;

Function TCustomObj.EnumIniKeyPwd(section: WideString; file_name: WideString;
  pwd: WideString): WideString;
Begin
  Result := Obj.mjxEXqCAdBbz(section, file_name, pwd);
End;

Function TCustomObj.SetClientSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.AUMkCWtNByIG(hwnd, width, height);
End;

Function TCustomObj.SendString(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.DpsFjfKYdgTzg(hwnd, str);
End;

Function TCustomObj.WriteDoubleAddr(hwnd: Integer; addr: Int64;
  v: Double): Integer;
Begin
  Result := Obj.zxFfXNqGwPrEEyy(hwnd, addr, v);
End;

Function TCustomObj.ScreenToClient(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.drlzQZfrWCdocC(hwnd, x, y);
End;

Function TCustomObj.AsmSetTimeout(time_out: Integer; param: Integer): Integer;
Begin
  Result := Obj.wWIXNhYqJI(time_out, param);
End;

Function TCustomObj.WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.GJIoicxslmxdQvQ(hwnd, addr, tpe, v);
End;

Function TCustomObj.GetWordResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.QqBASYp(str, index, x, y);
End;

Function TCustomObj.FoobarClearText(hwnd: Integer): Integer;
Begin
  Result := Obj.pYop(hwnd);
End;

Function TCustomObj.IsDisplayDead(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; T: Integer): Integer;
Begin
  Result := Obj.EHaUtDelrc(x1, y1, x2, y2, T);
End;

Function TCustomObj.ReadDataToBin(hwnd: Integer; addr: WideString;
  length: Integer): Integer;
Begin
  Result := Obj.NhaMl(hwnd, addr, length);
End;

Function TCustomObj.WaitKey(key_code: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.JeGWGvUXIwlZ(key_code, time_out);
End;

Function TCustomObj.EnableKeypadPatch(en: Integer): Integer;
Begin
  Result := Obj.nJKSrFANNdrjA(en);
End;

Function TCustomObj.CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.yBFnBCu(hwnd, x, y, w, h);
End;

Function TCustomObj.CapturePng(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString): Integer;
Begin
  Result := Obj.TpHtMErvJCKK(x1, y1, x2, y2, file_name);
End;

Function TCustomObj.MiddleUp(): Integer;
Begin
  Result := Obj.jbghBFl;
End;

Function TCustomObj.CmpColor(x: Integer; y: Integer; color: WideString;
  sim: Double): Integer;
Begin
  Result := Obj.tpVPr(x, y, color, sim);
End;

Function TCustomObj.FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): WideString;
Begin
  Result := Obj.fpvAmERN(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TCustomObj.GetKeyState(vk: Integer): Integer;
Begin
  Result := Obj.LqxpMWux(vk);
End;

Function TCustomObj.FoobarSetSave(hwnd: Integer; file_name: WideString;
  en: Integer; header: WideString): Integer;
Begin
  Result := Obj.rqTHCRFp(hwnd, file_name, en, header);
End;

Function TCustomObj.ReadFloat(hwnd: Integer; addr: WideString): Single;
Begin
  Result := Obj.MlgjJQEUA(hwnd, addr);
End;

Function TCustomObj.LeftUp(): Integer;
Begin
  Result := Obj.KyYIywoLGscTIU;
End;

Function TCustomObj.ForceUnBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.AGgkFPCU(hwnd);
End;

Function TCustomObj.DeleteIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.vXgV(section, key, file_name, pwd);
End;

Function TCustomObj.FaqCapture(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; quality: Integer; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.AfAZCe(x1, y1, x2, y2, quality, delay, time);
End;

Function TCustomObj.SetExitThread(en: Integer): Integer;
Begin
  Result := Obj.YJfxPExQY(en);
End;

Function TCustomObj.EnableDisplayDebug(enable_debug: Integer): Integer;
Begin
  Result := Obj.KdBmwAomBy(enable_debug);
End;

Function TCustomObj.CaptureGif(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.IHgvWYxsyZmy(x1, y1, x2, y2, file_name, delay, time);
End;

Function TCustomObj.EnableMouseSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.ZKgrVNarl(en, time_out);
End;

Function TCustomObj.SetParam64ToPointer(): Integer;
Begin
  Result := Obj.wHTBbkFiABdaf;
End;

Function TCustomObj.FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.PrrUgxsnj(x1, y1, x2, y2, str, color, sim);
End;

Function TCustomObj.DelEnv(index: Integer; name: WideString): Integer;
Begin
  Result := Obj.FvpxRv(index, name);
End;

Function TCustomObj.GetCommandLine(hwnd: Integer): WideString;
Begin
  Result := Obj.tUtpGelWrB(hwnd);
End;

Function TCustomObj.FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.ihzRBFlpmnfqbA(x1, y1, x2, y2, pic_name, delta_color, sim,
    dir, x, y);
End;

Function TCustomObj.FoobarUpdate(hwnd: Integer): Integer;
Begin
  Result := Obj.EDLZ(hwnd);
End;

Function TCustomObj.SelectFile(): WideString;
Begin
  Result := Obj.WvAIHjpJknPFR;
End;

Function TCustomObj.FindData(hwnd: Integer; addr_range: WideString;
  data: WideString): WideString;
Begin
  Result := Obj.hcLkq(hwnd, addr_range, data);
End;

Function TCustomObj.FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString): Integer;
Begin
  Result := Obj.ncFhsK(hwnd, x1, y1, x2, y2, color);
End;

Function TCustomObj.LockDisplay(locks: Integer): Integer;
Begin
  Result := Obj.zXGewcRjrlXKfo(locks);
End;

Function TCustomObj.WheelUp(): Integer;
Begin
  Result := Obj.HfAmeBdpg;
End;

Function TCustomObj.Md5(str: WideString): WideString;
Begin
  Result := Obj.AEHy(str);
End;

Function TCustomObj.FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString; repeat_limit: Integer; delay: Integer): Integer;
Begin
  Result := Obj.gLMEKWA(hwnd, x, y, pic_name, repeat_limit, delay);
End;

Function TCustomObj.MoveTo(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.VqonxwiSNBKtG(x, y);
End;

Function TCustomObj.WriteDataFromBin(hwnd: Integer; addr: WideString;
  data: Integer; length: Integer): Integer;
Begin
  Result := Obj.vDydcMN(hwnd, addr, data, length);
End;

Function TCustomObj.SetEnv(index: Integer; name: WideString;
  value: WideString): Integer;
Begin
  Result := Obj.YbIkPusA(index, name, value);
End;

Function TCustomObj.StringToData(string_value: WideString; tpe: Integer)
  : WideString;
Begin
  Result := Obj.vcWDYEmU(string_value, tpe);
End;

Function TCustomObj.FreePic(pic_name: WideString): Integer;
Begin
  Result := Obj.uAZa(pic_name);
End;

Function TCustomObj.EnableKeypadSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.nHqG(en, time_out);
End;

Function TCustomObj.DeleteFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.RPltbImeRNe(folder_name);
End;

Function TCustomObj.FindShape(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.XyTQBygoV(x1, y1, x2, y2, offset_color, sim, dir, x, y);
End;

Function TCustomObj.FindStringEx(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer; steps: Integer; multi_thread: Integer;
  mode: Integer): WideString;
Begin
  Result := Obj.jcXnt(hwnd, addr_range, string_value, tpe, steps,
    multi_thread, mode);
End;

Function TCustomObj.SaveDict(index: Integer; file_name: WideString): Integer;
Begin
  Result := Obj.MHAyaviaf(index, file_name);
End;

Function TCustomObj.GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; out data: OleVariant; out size: OleVariant): Integer;
Begin
  Result := Obj.BinBmj(x1, y1, x2, y2, data, size);
End;

Function TCustomObj.GetAveHSV(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): WideString;
Begin
  Result := Obj.DUVZpuY(x1, y1, x2, y2);
End;

Function TCustomObj.CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; rw: Integer; rh: Integer): Integer;
Begin
  Result := Obj.LXhe(hwnd, x, y, w, h, rw, rh);
End;

Function TCustomObj.GetDictInfo(str: WideString; font_name: WideString;
  font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.bScRBCilaHlUnFy(str, font_name, font_size, flag);
End;

Function TCustomObj.GetAveRGB(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): WideString;
Begin
  Result := Obj.QEMSsTFHbEZKaj(x1, y1, x2, y2);
End;

Function TCustomObj.UnLoadDriver(): Integer;
Begin
  Result := Obj.DDGiUcEHkwtZa;
End;

Function TCustomObj.DisableCloseDisplayAndSleep(): Integer;
Begin
  Result := Obj.jfzlaRPUtHZwzp;
End;

Function TCustomObj.SetColGapNoDict(col_gap: Integer): Integer;
Begin
  Result := Obj.RUWqTmAl(col_gap);
End;

Constructor TNormalObj.Create();
Begin
  // obj := CreateOleObject('dm.dmsoft');
  Obj := TObjFactory.CreateObj();
End;

Destructor TNormalObj.Destroy();
Begin
  // obj := Unassigned;
  Obj := nil;
End;

Function TNormalObj.SetRowGapNoDict(row_gap: Integer): Integer;
Begin
  Result := Obj.SetRowGapNoDict(row_gap);
End;

Function TNormalObj.SetWordGapNoDict(word_gap: Integer): Integer;
Begin
  Result := Obj.SetWordGapNoDict(word_gap);
End;

Function TNormalObj.FoobarSetFont(hwnd: Integer; font_name: WideString;
  size: Integer; flag: Integer): Integer;
Begin
  Result := Obj.FoobarSetFont(hwnd, font_name, size, flag);
End;

Function TNormalObj.SetParam64ToPointer(): Integer;
Begin
  Result := Obj.SetParam64ToPointer;
End;

Function TNormalObj.ReadFloat(hwnd: Integer; addr: WideString): Single;
Begin
  Result := Obj.ReadFloat(hwnd, addr);
End;

Function TNormalObj.SetUAC(uac: Integer): Integer;
Begin
  Result := Obj.SetUAC(uac);
End;

Function TNormalObj.FindShapeE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindShapeE(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function TNormalObj.RightDown(): Integer;
Begin
  Result := Obj.RightDown;
End;

Function TNormalObj.Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  file_name: WideString): Integer;
Begin
  Result := Obj.Capture(x1, y1, x2, y2, file_name);
End;

Function TNormalObj.SetMemoryFindResultToFile(file_name: WideString): Integer;
Begin
  Result := Obj.SetMemoryFindResultToFile(file_name);
End;

Function TNormalObj.FoobarSetTrans(hwnd: Integer; trans: Integer;
  color: WideString; sim: Double): Integer;
Begin
  Result := Obj.FoobarSetTrans(hwnd, trans, color, sim);
End;

Function TNormalObj.FindPicExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_name: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindPicExS(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TNormalObj.SetWordLineHeightNoDict(line_height: Integer): Integer;
Begin
  Result := Obj.SetWordLineHeightNoDict(line_height);
End;

Function TNormalObj.FindFloat(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single): WideString;
Begin
  Result := Obj.FindFloat(hwnd, addr_range, float_value_min, float_value_max);
End;

Function TNormalObj.FindDouble(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double): WideString;
Begin
  Result := Obj.FindDouble(hwnd, addr_range, double_value_min,
    double_value_max);
End;

Function TNormalObj.LeaveCri(): Integer;
Begin
  Result := Obj.LeaveCri;
End;

Function TNormalObj.ReadDataAddrToBin(hwnd: Integer; addr: Int64;
  length: Integer): Integer;
Begin
  Result := Obj.ReadDataAddrToBin(hwnd, addr, length);
End;

Function TNormalObj.Reg(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.Reg(code, ver);
End;

Function TNormalObj.EnumIniKey(section: WideString; file_name: WideString)
  : WideString;
Begin
  Result := Obj.EnumIniKey(section, file_name);
End;

Function TNormalObj.SetDisplayAcceler(level: Integer): Integer;
Begin
  Result := Obj.SetDisplayAcceler(level);
End;

Function TNormalObj.ReadFloatAddr(hwnd: Integer; addr: Int64): Single;
Begin
  Result := Obj.ReadFloatAddr(hwnd, addr);
End;

Function TNormalObj.SetEnv(index: Integer; name: WideString;
  value: WideString): Integer;
Begin
  Result := Obj.SetEnv(index, name, value);
End;

Function TNormalObj.GetDictCount(index: Integer): Integer;
Begin
  Result := Obj.GetDictCount(index);
End;

Function TNormalObj.ExitOs(tpe: Integer): Integer;
Begin
  Result := Obj.ExitOs(tpe);
End;

Function TNormalObj.SetEnumWindowDelay(delay: Integer): Integer;
Begin
  Result := Obj.SetEnumWindowDelay(delay);
End;

Function TNormalObj.IsBind(hwnd: Integer): Integer;
Begin
  Result := Obj.IsBind(hwnd);
End;

Function TNormalObj.LockInput(locks: Integer): Integer;
Begin
  Result := Obj.LockInput(locks);
End;

Function TNormalObj.GetAveHSV(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): WideString;
Begin
  Result := Obj.GetAveHSV(x1, y1, x2, y2);
End;

Function TNormalObj.UseDict(index: Integer): Integer;
Begin
  Result := Obj.UseDict(index);
End;

Function TNormalObj.SetMemoryHwndAsProcessId(en: Integer): Integer;
Begin
  Result := Obj.SetMemoryHwndAsProcessId(en);
End;

Function TNormalObj.Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.Ocr(x1, y1, x2, y2, color, sim);
End;

Function TNormalObj.SendCommand(cmd: WideString): Integer;
Begin
  Result := Obj.SendCommand(cmd);
End;

Function TNormalObj.GetMouseSpeed(): Integer;
Begin
  Result := Obj.GetMouseSpeed;
End;

Function TNormalObj.RightUp(): Integer;
Begin
  Result := Obj.RightUp;
End;

Function TNormalObj.Play(file_name: WideString): Integer;
Begin
  Result := Obj.Play(file_name);
End;

Function TNormalObj.FindFloatEx(hwnd: Integer; addr_range: WideString;
  float_value_min: Single; float_value_max: Single; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindFloatEx(hwnd, addr_range, float_value_min, float_value_max,
    steps, multi_thread, mode);
End;

Function TNormalObj.EnablePicCache(en: Integer): Integer;
Begin
  Result := Obj.EnablePicCache(en);
End;

Function TNormalObj.EnumIniKeyPwd(section: WideString; file_name: WideString;
  pwd: WideString): WideString;
Begin
  Result := Obj.EnumIniKeyPwd(section, file_name, pwd);
End;

Function TNormalObj.HackSpeed(rate: Double): Integer;
Begin
  Result := Obj.HackSpeed(rate);
End;

Function TNormalObj.GetDPI(): Integer;
Begin
  Result := Obj.GetDPI;
End;

Function TNormalObj.AsmAdd(asm_ins: WideString): Integer;
Begin
  Result := Obj.AsmAdd(asm_ins);
End;

Function TNormalObj.FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString; style: Integer;
  width: Integer): Integer;
Begin
  Result := Obj.FoobarDrawLine(hwnd, x1, y1, x2, y2, color, style, width);
End;

Function TNormalObj.GetScreenData(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.GetScreenData(x1, y1, x2, y2);
End;

Function TNormalObj.FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): WideString;
Begin
  Result := Obj.FindStrS(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TNormalObj.EnableRealMouse(en: Integer; mousedelay: Integer;
  mousestep: Integer): Integer;
Begin
  Result := Obj.EnableRealMouse(en, mousedelay, mousestep);
End;

Function TNormalObj.GetCursorPos(out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.GetCursorPos(x, y);
End;

Function TNormalObj.FindStringEx(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer; steps: Integer; multi_thread: Integer;
  mode: Integer): WideString;
Begin
  Result := Obj.FindStringEx(hwnd, addr_range, string_value, tpe, steps,
    multi_thread, mode);
End;

Function TNormalObj.FindString(hwnd: Integer; addr_range: WideString;
  string_value: WideString; tpe: Integer): WideString;
Begin
  Result := Obj.FindString(hwnd, addr_range, string_value, tpe);
End;

Function TNormalObj.EnableFontSmooth(): Integer;
Begin
  Result := Obj.EnableFontSmooth;
End;

Function TNormalObj.GetFps(): Integer;
Begin
  Result := Obj.GetFps;
End;

Function TNormalObj.CaptureGif(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.CaptureGif(x1, y1, x2, y2, file_name, delay, time);
End;

Function TNormalObj.GetNetTimeByIp(ip: WideString): WideString;
Begin
  Result := Obj.GetNetTimeByIp(ip);
End;

Function TNormalObj.EnumWindowSuper(spec1: WideString; flag1: Integer;
  type1: Integer; spec2: WideString; flag2: Integer; type2: Integer;
  sort: Integer): WideString;
Begin
  Result := Obj.EnumWindowSuper(spec1, flag1, type1, spec2, flag2, type2, sort);
End;

Function TNormalObj.FindData(hwnd: Integer; addr_range: WideString;
  data: WideString): WideString;
Begin
  Result := Obj.FindData(hwnd, addr_range, data);
End;

Function TNormalObj.GetWordResultCount(str: WideString): Integer;
Begin
  Result := Obj.GetWordResultCount(str);
End;

Function TNormalObj.LeftDoubleClick(): Integer;
Begin
  Result := Obj.LeftDoubleClick;
End;

Function TNormalObj.InitCri(): Integer;
Begin
  Result := Obj.InitCri;
End;

Function TNormalObj.ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer;
Begin
  Result := Obj.ShowTaskBarIcon(hwnd, is_show);
End;

Function TNormalObj.CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; rw: Integer; rh: Integer): Integer;
Begin
  Result := Obj.CreateFoobarRoundRect(hwnd, x, y, w, h, rw, rh);
End;

Function TNormalObj.DisAssemble(asm_code: WideString; base_addr: Int64;
  is_64bit: Integer): WideString;
Begin
  Result := Obj.DisAssemble(asm_code, base_addr, is_64bit);
End;

Function TNormalObj.UnLoadDriver(): Integer;
Begin
  Result := Obj.UnLoadDriver;
End;

Function TNormalObj.GetPointWindow(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.GetPointWindow(x, y);
End;

Function TNormalObj.RightClick(): Integer;
Begin
  Result := Obj.RightClick;
End;

Function TNormalObj.WriteFile(file_name: WideString;
  content: WideString): Integer;
Begin
  Result := Obj.WriteFile(file_name, content);
End;

Function TNormalObj.FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer): WideString;
Begin
  Result := Obj.FindColorBlockEx(x1, y1, x2, y2, color, sim, count,
    width, height);
End;

Function TNormalObj.FoobarSetSave(hwnd: Integer; file_name: WideString;
  en: Integer; header: WideString): Integer;
Begin
  Result := Obj.FoobarSetSave(hwnd, file_name, en, header);
End;

Function TNormalObj.EnableRealKeypad(en: Integer): Integer;
Begin
  Result := Obj.EnableRealKeypad(en);
End;

Function TNormalObj.GetCursorShape(): WideString;
Begin
  Result := Obj.GetCursorShape;
End;

Function TNormalObj.FindPicEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_name: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindPicEx(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TNormalObj.SetAero(en: Integer): Integer;
Begin
  Result := Obj.SetAero(en);
End;

Function TNormalObj.VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
  : WideString;
Begin
  Result := Obj.VirtualQueryEx(hwnd, addr, pmbi);
End;

Function TNormalObj.EnableMouseAccuracy(en: Integer): Integer;
Begin
  Result := Obj.EnableMouseAccuracy(en);
End;

Function TNormalObj.CapturePre(file_name: WideString): Integer;
Begin
  Result := Obj.CapturePre(file_name);
End;

Function TNormalObj.KeyPress(vk: Integer): Integer;
Begin
  Result := Obj.KeyPress(vk);
End;

Function TNormalObj.GetMac(): WideString;
Begin
  Result := Obj.GetMac;
End;

Function TNormalObj.SetDict(index: Integer; dict_name: WideString): Integer;
Begin
  Result := Obj.SetDict(index, dict_name);
End;

Function TNormalObj.WriteData(hwnd: Integer; addr: WideString;
  data: WideString): Integer;
Begin
  Result := Obj.WriteData(hwnd, addr, data);
End;

Function TNormalObj.FindWindowEx(parent: Integer; class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.FindWindowEx(parent, class_name, title_name);
End;

Function TNormalObj.FaqFetch(): WideString;
Begin
  Result := Obj.FaqFetch;
End;

Function TNormalObj.AddDict(index: Integer; dict_info: WideString): Integer;
Begin
  Result := Obj.AddDict(index, dict_info);
End;

Function TNormalObj.DoubleToData(double_value: Double): WideString;
Begin
  Result := Obj.DoubleToData(double_value);
End;

Function TNormalObj.SaveDict(index: Integer; file_name: WideString): Integer;
Begin
  Result := Obj.SaveDict(index, file_name);
End;

Function TNormalObj.FetchWord(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; word: WideString): WideString;
Begin
  Result := Obj.FetchWord(x1, y1, x2, y2, color, word);
End;

Function TNormalObj.FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer;
Begin
  Result := Obj.FoobarTextPrintDir(hwnd, dir);
End;

Function TNormalObj.GetCursorShapeEx(tpe: Integer): WideString;
Begin
  Result := Obj.GetCursorShapeEx(tpe);
End;

Function TNormalObj.CaptureJpg(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.CaptureJpg(x1, y1, x2, y2, file_name, quality);
End;

Function TNormalObj.SetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.SetWindowState(hwnd, flag);
End;

Function TNormalObj.SetColGapNoDict(col_gap: Integer): Integer;
Begin
  Result := Obj.SetColGapNoDict(col_gap);
End;

Function TNormalObj.FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.FindPicS(x1, y1, x2, y2, pic_name, delta_color, sim, dir, x, y);
End;

Function TNormalObj.ReadIni(section: WideString; key: WideString;
  file_name: WideString): WideString;
Begin
  Result := Obj.ReadIni(section, key, file_name);
End;

Function TNormalObj.VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer; old_protect: Integer): Integer;
Begin
  Result := Obj.VirtualProtectEx(hwnd, addr, size, tpe, old_protect);
End;

Function TNormalObj.GetScreenDepth(): Integer;
Begin
  Result := Obj.GetScreenDepth;
End;

Function TNormalObj.FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString): Integer;
Begin
  Result := Obj.FoobarStopGif(hwnd, x, y, pic_name);
End;

Function TNormalObj.MoveFile(src_file: WideString;
  dst_file: WideString): Integer;
Begin
  Result := Obj.MoveFile(src_file, dst_file);
End;

Function TNormalObj.GetLastError(): Integer;
Begin
  Result := Obj.GetLastError;
End;

Function TNormalObj.DelEnv(index: Integer; name: WideString): Integer;
Begin
  Result := Obj.DelEnv(index, name);
End;

Function TNormalObj.GetEnv(index: Integer; name: WideString): WideString;
Begin
  Result := Obj.GetEnv(index, name);
End;

Function TNormalObj.KeyUp(vk: Integer): Integer;
Begin
  Result := Obj.KeyUp(vk);
End;

Function TNormalObj.IsDisplayDead(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; T: Integer): Integer;
Begin
  Result := Obj.IsDisplayDead(x1, y1, x2, y2, T);
End;

Function TNormalObj.SetMouseDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.SetMouseDelay(tpe, delay);
End;

Function TNormalObj.SetClipboard(data: WideString): Integer;
Begin
  Result := Obj.SetClipboard(data);
End;

Function TNormalObj.SortPosDistance(all_pos: WideString; tpe: Integer;
  x: Integer; y: Integer): WideString;
Begin
  Result := Obj.SortPosDistance(all_pos, tpe, x, y);
End;

Function TNormalObj.SetLocale(): Integer;
Begin
  Result := Obj.SetLocale;
End;

Function TNormalObj.SendString(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.SendString(hwnd, str);
End;

Function TNormalObj.FindPicMem(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindPicMem(x1, y1, x2, y2, pic_info, delta_color, sim,
    dir, x, y);
End;

Function TNormalObj.FindStrFast(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindStrFast(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TNormalObj.IntToData(int_value: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.IntToData(int_value, tpe);
End;

Function TNormalObj.RGB2BGR(rgb_color: WideString): WideString;
Begin
  Result := Obj.RGB2BGR(rgb_color);
End;

Function TNormalObj.GetAveRGB(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): WideString;
Begin
  Result := Obj.GetAveRGB(x1, y1, x2, y2);
End;

Function TNormalObj.GetCommandLine(hwnd: Integer): WideString;
Begin
  Result := Obj.GetCommandLine(hwnd);
End;

Function TNormalObj.DeleteFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.DeleteFolder(folder_name);
End;

Function TNormalObj.DisableCloseDisplayAndSleep(): Integer;
Begin
  Result := Obj.DisableCloseDisplayAndSleep;
End;

Function TNormalObj.FreeProcessMemory(hwnd: Integer): Integer;
Begin
  Result := Obj.FreeProcessMemory(hwnd);
End;

Function TNormalObj.GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.GetWords(x1, y1, x2, y2, color, sim);
End;

Function TNormalObj.GetID(): Integer;
Begin
  Result := Obj.GetID;
End;

Function TNormalObj.SetExitThread(en: Integer): Integer;
Begin
  Result := Obj.SetExitThread(en);
End;

Function TNormalObj.FindShape(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindShape(x1, y1, x2, y2, offset_color, sim, dir, x, y);
End;

Function TNormalObj.SetScreen(width: Integer; height: Integer;
  depth: Integer): Integer;
Begin
  Result := Obj.SetScreen(width, height, depth);
End;

Function TNormalObj.CheckFontSmooth(): Integer;
Begin
  Result := Obj.CheckFontSmooth;
End;

Function TNormalObj.WheelUp(): Integer;
Begin
  Result := Obj.WheelUp;
End;

Function TNormalObj.WriteFloatAddr(hwnd: Integer; addr: Int64;
  v: Single): Integer;
Begin
  Result := Obj.WriteFloatAddr(hwnd, addr, v);
End;

Function TNormalObj.WriteDoubleAddr(hwnd: Integer; addr: Int64;
  v: Double): Integer;
Begin
  Result := Obj.WriteDoubleAddr(hwnd, addr, v);
End;

Function TNormalObj.RegExNoMac(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.RegExNoMac(code, ver, ip);
End;

Function TNormalObj.GetBasePath(): WideString;
Begin
  Result := Obj.GetBasePath;
End;

Function TNormalObj.SetWordGap(word_gap: Integer): Integer;
Begin
  Result := Obj.SetWordGap(word_gap);
End;

Function TNormalObj.FindInputMethod(id: WideString): Integer;
Begin
  Result := Obj.FindInputMethod(id);
End;

Function TNormalObj.WriteIniPwd(section: WideString; key: WideString;
  v: WideString; file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.WriteIniPwd(section, key, v, file_name, pwd);
End;

Function TNormalObj.RunApp(path: WideString; mode: Integer): Integer;
Begin
  Result := Obj.RunApp(path, mode);
End;

Function TNormalObj.FoobarTextRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.FoobarTextRect(hwnd, x, y, w, h);
End;

Function TNormalObj.SetDisplayDelay(T: Integer): Integer;
Begin
  Result := Obj.SetDisplayDelay(T);
End;

Function TNormalObj.AsmSetTimeout(time_out: Integer; param: Integer): Integer;
Begin
  Result := Obj.AsmSetTimeout(time_out, param);
End;

Function TNormalObj.GetTime(): Integer;
Begin
  Result := Obj.GetTime;
End;

Function TNormalObj.FaqIsPosted(): Integer;
Begin
  Result := Obj.FaqIsPosted;
End;

Function TNormalObj.delay(mis: Integer): Integer;
Begin
  Result := Obj.delay(mis);
End;

Function TNormalObj.FaqCaptureString(str: WideString): Integer;
Begin
  Result := Obj.FaqCaptureString(str);
End;

Function TNormalObj.FindInt(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer): WideString;
Begin
  Result := Obj.FindInt(hwnd, addr_range, int_value_min, int_value_max, tpe);
End;

Function TNormalObj.MiddleClick(): Integer;
Begin
  Result := Obj.MiddleClick;
End;

Function TNormalObj.EnableShareDict(en: Integer): Integer;
Begin
  Result := Obj.EnableShareDict(en);
End;

Function TNormalObj.KeyPressStr(key_str: WideString; delay: Integer): Integer;
Begin
  Result := Obj.KeyPressStr(key_str, delay);
End;

Function TNormalObj.FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString; quality: Integer): Integer;
Begin
  Result := Obj.FaqCaptureFromFile(x1, y1, x2, y2, file_name, quality);
End;

Function TNormalObj.FindColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindColor(x1, y1, x2, y2, color, sim, dir, x, y);
End;

Function TNormalObj.ReadFile(file_name: WideString): WideString;
Begin
  Result := Obj.ReadFile(file_name);
End;

Function TNormalObj.FindNearestPos(all_pos: WideString; tpe: Integer;
  x: Integer; y: Integer): WideString;
Begin
  Result := Obj.FindNearestPos(all_pos, tpe, x, y);
End;

Function TNormalObj.EnumWindowByProcess(process_name: WideString;
  title: WideString; class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.EnumWindowByProcess(process_name, title, class_name, filter);
End;

Function TNormalObj.StrStr(s: WideString; str: WideString): Integer;
Begin
  Result := Obj.StrStr(s, str);
End;

Function TNormalObj.MiddleUp(): Integer;
Begin
  Result := Obj.MiddleUp;
End;

Function TNormalObj.GetScreenHeight(): Integer;
Begin
  Result := Obj.GetScreenHeight;
End;

Function TNormalObj.FindShapeEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; offset_color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindShapeEx(x1, y1, x2, y2, offset_color, sim, dir);
End;

Function TNormalObj.ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.ReadStringAddr(hwnd, addr, tpe, length);
End;

Function TNormalObj.CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.CreateFoobarRect(hwnd, x, y, w, h);
End;

Function TNormalObj.FindWindow(class_name: WideString;
  title_name: WideString): Integer;
Begin
  Result := Obj.FindWindow(class_name, title_name);
End;

Function TNormalObj.ShowScrMsg(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; msg: WideString; color: WideString): Integer;
Begin
  Result := Obj.ShowScrMsg(x1, y1, x2, y2, msg, color);
End;

Function TNormalObj.GetForegroundFocus(): Integer;
Begin
  Result := Obj.GetForegroundFocus;
End;

Function TNormalObj.GetModuleBaseAddr(hwnd: Integer;
  module_name: WideString): Int64;
Begin
  Result := Obj.GetModuleBaseAddr(hwnd, module_name);
End;

Function TNormalObj.FindStrFastExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrFastExS(x1, y1, x2, y2, str, color, sim);
End;

Function TNormalObj.WriteIni(section: WideString; key: WideString;
  v: WideString; file_name: WideString): Integer;
Begin
  Result := Obj.WriteIni(section, key, v, file_name);
End;

Function TNormalObj.EnableMouseMsg(en: Integer): Integer;
Begin
  Result := Obj.EnableMouseMsg(en);
End;

Function TNormalObj.SetWordLineHeight(line_height: Integer): Integer;
Begin
  Result := Obj.SetWordLineHeight(line_height);
End;

Function TNormalObj.EnumProcess(name: WideString): WideString;
Begin
  Result := Obj.EnumProcess(name);
End;

Function TNormalObj.CmpColor(x: Integer; y: Integer; color: WideString;
  sim: Double): Integer;
Begin
  Result := Obj.CmpColor(x, y, color, sim);
End;

Function TNormalObj.SetSimMode(mode: Integer): Integer;
Begin
  Result := Obj.SetSimMode(mode);
End;

Function TNormalObj.Md5(str: WideString): WideString;
Begin
  Result := Obj.Md5(str);
End;

Function TNormalObj.SetDictMem(index: Integer; addr: Integer;
  size: Integer): Integer;
Begin
  Result := Obj.SetDictMem(index, addr, size);
End;

Function TNormalObj.ReadDouble(hwnd: Integer; addr: WideString): Double;
Begin
  Result := Obj.ReadDouble(hwnd, addr);
End;

Function TNormalObj.GetWordResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.GetWordResultPos(str, index, x, y);
End;

Function TNormalObj.DownCpu(rate: Integer): Integer;
Begin
  Result := Obj.DownCpu(rate);
End;

Function TNormalObj.FindPicMemEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindPicMemEx(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function TNormalObj.EnumIniSection(file_name: WideString): WideString;
Begin
  Result := Obj.EnumIniSection(file_name);
End;

Function TNormalObj.FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindStr(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TNormalObj.FloatToData(float_value: Single): WideString;
Begin
  Result := Obj.FloatToData(float_value);
End;

Function TNormalObj.SetWindowText(hwnd: Integer; text: WideString): Integer;
Begin
  Result := Obj.SetWindowText(hwnd, text);
End;

Function TNormalObj.GetDisplayInfo(): WideString;
Begin
  Result := Obj.GetDisplayInfo;
End;

Function TNormalObj.CheckInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.CheckInputMethod(hwnd, id);
End;

Function TNormalObj.FindColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindColorEx(x1, y1, x2, y2, color, sim, dir);
End;

Function TNormalObj.GetOsBuildNumber(): Integer;
Begin
  Result := Obj.GetOsBuildNumber;
End;

Function TNormalObj.FoobarUpdate(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarUpdate(hwnd);
End;

Function TNormalObj.KeyDown(vk: Integer): Integer;
Begin
  Result := Obj.KeyDown(vk);
End;

Function TNormalObj.GetDiskSerial(): WideString;
Begin
  Result := Obj.GetDiskSerial;
End;

Function TNormalObj.ImageToBmp(pic_name: WideString;
  bmp_name: WideString): Integer;
Begin
  Result := Obj.ImageToBmp(pic_name, bmp_name);
End;

Function TNormalObj.BindWindow(hwnd: Integer; display: WideString;
  mouse: WideString; keypad: WideString; mode: Integer): Integer;
Begin
  Result := Obj.BindWindow(hwnd, display, mouse, keypad, mode);
End;

Function TNormalObj.FindColorBlock(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; count: Integer; width: Integer;
  height: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindColorBlock(x1, y1, x2, y2, color, sim, count, width,
    height, x, y);
End;

Function TNormalObj.FindMultiColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer; out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindMultiColor(x1, y1, x2, y2, first_color, offset_color, sim,
    dir, x, y);
End;

Function TNormalObj.FreePic(pic_name: WideString): Integer;
Begin
  Result := Obj.FreePic(pic_name);
End;

Function TNormalObj.GetNetTime(): WideString;
Begin
  Result := Obj.GetNetTime;
End;

Function TNormalObj.BindWindowEx(hwnd: Integer; display: WideString;
  mouse: WideString; keypad: WideString; public_desc: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.BindWindowEx(hwnd, display, mouse, keypad, public_desc, mode);
End;

Function TNormalObj.WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.WriteString(hwnd, addr, tpe, v);
End;

Function TNormalObj.Assemble(base_addr: Int64; is_64bit: Integer): WideString;
Begin
  Result := Obj.Assemble(base_addr, is_64bit);
End;

Function TNormalObj.SetDisplayInput(mode: WideString): Integer;
Begin
  Result := Obj.SetDisplayInput(mode);
End;

Function TNormalObj.FaqPost(server: WideString; handle: Integer;
  request_type: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.FaqPost(server, handle, request_type, time_out);
End;

Function TNormalObj.ReadInt(hwnd: Integer; addr: WideString;
  tpe: Integer): Int64;
Begin
  Result := Obj.ReadInt(hwnd, addr, tpe);
End;

Function TNormalObj.FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
  : WideString;
Begin
  Result := Obj.FindPicE(x1, y1, x2, y2, pic_name, delta_color, sim, dir);
End;

Function TNormalObj.DeleteFile(file_name: WideString): Integer;
Begin
  Result := Obj.DeleteFile(file_name);
End;

Function TNormalObj.SendStringIme(str: WideString): Integer;
Begin
  Result := Obj.SendStringIme(str);
End;

Function TNormalObj.GetCursorSpot(): WideString;
Begin
  Result := Obj.GetCursorSpot;
End;

Function TNormalObj.GetMachineCode(): WideString;
Begin
  Result := Obj.GetMachineCode;
End;

Function TNormalObj.FaqCapture(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; quality: Integer; delay: Integer; time: Integer): Integer;
Begin
  Result := Obj.FaqCapture(x1, y1, x2, y2, quality, delay, time);
End;

Function TNormalObj.DisablePowerSave(): Integer;
Begin
  Result := Obj.DisablePowerSave;
End;

Function TNormalObj.SelectFile(): WideString;
Begin
  Result := Obj.SelectFile;
End;

Function TNormalObj.GetRealPath(path: WideString): WideString;
Begin
  Result := Obj.GetRealPath(path);
End;

Function TNormalObj.LeftUp(): Integer;
Begin
  Result := Obj.LeftUp;
End;

Function TNormalObj.GetWindowState(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.GetWindowState(hwnd, flag);
End;

Function TNormalObj.GetClientRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.GetClientRect(hwnd, x1, y1, x2, y2);
End;

Function TNormalObj.EnumWindow(parent: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.EnumWindow(parent, title, class_name, filter);
End;

Function TNormalObj.ReadDoubleAddr(hwnd: Integer; addr: Int64): Double;
Begin
  Result := Obj.ReadDoubleAddr(hwnd, addr);
End;

Function TNormalObj.DmGuardParams(cmd: WideString; sub_cmd: WideString;
  param: WideString): WideString;
Begin
  Result := Obj.DmGuardParams(cmd, sub_cmd, param);
End;

Function TNormalObj.SetMouseSpeed(speed: Integer): Integer;
Begin
  Result := Obj.SetMouseSpeed(speed);
End;

Function TNormalObj.FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindMultiColorEx(x1, y1, x2, y2, first_color, offset_color,
    sim, dir);
End;

Function TNormalObj.FindStrExS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrExS(x1, y1, x2, y2, str, color, sim);
End;

Function TNormalObj.FaqSend(server: WideString; handle: Integer;
  request_type: Integer; time_out: Integer): WideString;
Begin
  Result := Obj.FaqSend(server, handle, request_type, time_out);
End;

Function TNormalObj.FaqCancel(): Integer;
Begin
  Result := Obj.FaqCancel;
End;

Function TNormalObj.GetResultCount(str: WideString): Integer;
Begin
  Result := Obj.GetResultCount(str);
End;

Function TNormalObj.RegEx(code: WideString; ver: WideString;
  ip: WideString): Integer;
Begin
  Result := Obj.RegEx(code, ver, ip);
End;

Function TNormalObj.SetClientSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.SetClientSize(hwnd, width, height);
End;

Function TNormalObj.GetWindowTitle(hwnd: Integer): WideString;
Begin
  Result := Obj.GetWindowTitle(hwnd);
End;

Function TNormalObj.WaitKey(key_code: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.WaitKey(key_code, time_out);
End;

Function TNormalObj.CopyFile(src_file: WideString; dst_file: WideString;
  over: Integer): Integer;
Begin
  Result := Obj.CopyFile(src_file, dst_file, over);
End;

Function TNormalObj.GetColor(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.GetColor(x, y);
End;

Function TNormalObj.ActiveInputMethod(hwnd: Integer; id: WideString): Integer;
Begin
  Result := Obj.ActiveInputMethod(hwnd, id);
End;

Function TNormalObj.EnableFakeActive(en: Integer): Integer;
Begin
  Result := Obj.EnableFakeActive(en);
End;

Function TNormalObj.FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.FindStrWithFontEx(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function TNormalObj.GetDictInfo(str: WideString; font_name: WideString;
  font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.GetDictInfo(str, font_name, font_size, flag);
End;

Function TNormalObj.FaqRelease(handle: Integer): Integer;
Begin
  Result := Obj.FaqRelease(handle);
End;

Function TNormalObj.FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer): WideString;
Begin
  Result := Obj.FindStrWithFontE(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag);
End;

Function TNormalObj.OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.OcrExOne(x1, y1, x2, y2, color, sim);
End;

Function TNormalObj.ClientToScreen(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.ClientToScreen(hwnd, x, y);
End;

Function TNormalObj.ver(): WideString;
Begin
  Result := Obj.ver;
End;

Function TNormalObj.KeyPressChar(key_str: WideString): Integer;
Begin
  Result := Obj.KeyPressChar(key_str);
End;

Function TNormalObj.Delays(min_s: Integer; max_s: Integer): Integer;
Begin
  Result := Obj.Delays(min_s, max_s);
End;

Function TNormalObj.GetFileLength(file_name: WideString): Integer;
Begin
  Result := Obj.GetFileLength(file_name);
End;

Function TNormalObj.SendPaste(hwnd: Integer): Integer;
Begin
  Result := Obj.SendPaste(hwnd);
End;

Function TNormalObj.FindMulColor(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double): Integer;
Begin
  Result := Obj.FindMulColor(x1, y1, x2, y2, color, sim);
End;

Function TNormalObj.AsmClear(): Integer;
Begin
  Result := Obj.AsmClear;
End;

Function TNormalObj.ClearDict(index: Integer): Integer;
Begin
  Result := Obj.ClearDict(index);
End;

Function TNormalObj.ExecuteCmd(cmd: WideString; current_dir: WideString;
  time_out: Integer): WideString;
Begin
  Result := Obj.ExecuteCmd(cmd, current_dir, time_out);
End;

Function TNormalObj.GetWindowRect(hwnd: Integer; out x1: OleVariant;
  out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
Begin
  Result := Obj.GetWindowRect(hwnd, x1, y1, x2, y2);
End;

Function TNormalObj.EnumIniSectionPwd(file_name: WideString; pwd: WideString)
  : WideString;
Begin
  Result := Obj.EnumIniSectionPwd(file_name, pwd);
End;

Function TNormalObj.OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  color: WideString; sim: Double): WideString;
Begin
  Result := Obj.OcrEx(x1, y1, x2, y2, color, sim);
End;

Function TNormalObj.SendString2(hwnd: Integer; str: WideString): Integer;
Begin
  Result := Obj.SendString2(hwnd, str);
End;

Function TNormalObj.KeyUpChar(key_str: WideString): Integer;
Begin
  Result := Obj.KeyUpChar(key_str);
End;

Function TNormalObj.VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
  tpe: Integer): Int64;
Begin
  Result := Obj.VirtualAllocEx(hwnd, addr, size, tpe);
End;

Function TNormalObj.FindStrFastEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrFastEx(x1, y1, x2, y2, str, color, sim);
End;

Function TNormalObj.ScreenToClient(hwnd: Integer; var x: OleVariant;
  var y: OleVariant): Integer;
Begin
  Result := Obj.ScreenToClient(hwnd, x, y);
End;

Function TNormalObj.FindStrFastE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrFastE(x1, y1, x2, y2, str, color, sim);
End;

Function TNormalObj.GetKeyState(vk: Integer): Integer;
Begin
  Result := Obj.GetKeyState(vk);
End;

Function TNormalObj.GetScreenWidth(): Integer;
Begin
  Result := Obj.GetScreenWidth;
End;

Function TNormalObj.GetProcessInfo(pid: Integer): WideString;
Begin
  Result := Obj.GetProcessInfo(pid);
End;

Function TNormalObj.GetDict(index: Integer; font_index: Integer): WideString;
Begin
  Result := Obj.GetDict(index, font_index);
End;

Function TNormalObj.SelectDirectory(): WideString;
Begin
  Result := Obj.SelectDirectory;
End;

Function TNormalObj.GetClientSize(hwnd: Integer; out width: OleVariant;
  out height: OleVariant): Integer;
Begin
  Result := Obj.GetClientSize(hwnd, width, height);
End;

Function TNormalObj.WriteDataFromBin(hwnd: Integer; addr: WideString;
  data: Integer; length: Integer): Integer;
Begin
  Result := Obj.WriteDataFromBin(hwnd, addr, data, length);
End;

Function TNormalObj.FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.FindPic(x1, y1, x2, y2, pic_name, delta_color, sim, dir, x, y);
End;

Function TNormalObj.ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
  y1: Integer; x2: Integer; y2: Integer): WideString;
Begin
  Result := Obj.ExcludePos(all_pos, tpe, x1, y1, x2, y2);
End;

Function TNormalObj.GetWindow(hwnd: Integer; flag: Integer): Integer;
Begin
  Result := Obj.GetWindow(hwnd, flag);
End;

Function TNormalObj.MoveDD(dx: Integer; dy: Integer): Integer;
Begin
  Result := Obj.MoveDD(dx, dy);
End;

Function TNormalObj.FoobarClose(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarClose(hwnd);
End;

Function TNormalObj.GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString): WideString;
Begin
  Result := Obj.GetWordsNoDict(x1, y1, x2, y2, color);
End;

Function TNormalObj.FindStrWithFont(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  font_name: WideString; font_size: Integer; flag: Integer; out x: OleVariant;
  out y: OleVariant): Integer;
Begin
  Result := Obj.FindStrWithFont(x1, y1, x2, y2, str, color, sim, font_name,
    font_size, flag, x, y);
End;

Function TNormalObj.GetLocale(): Integer;
Begin
  Result := Obj.GetLocale;
End;

Function TNormalObj.ReadFileData(file_name: WideString; start_pos: Integer;
  end_pos: Integer): WideString;
Begin
  Result := Obj.ReadFileData(file_name, start_pos, end_pos);
End;

Function TNormalObj.FoobarDrawText(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer; text: WideString; color: WideString;
  align: Integer): Integer;
Begin
  Result := Obj.FoobarDrawText(hwnd, x, y, w, h, text, color, align);
End;

Function TNormalObj.ReadIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): WideString;
Begin
  Result := Obj.ReadIniPwd(section, key, file_name, pwd);
End;

Function TNormalObj.KeyDownChar(key_str: WideString): Integer;
Begin
  Result := Obj.KeyDownChar(key_str);
End;

Function TNormalObj.SetDictPwd(pwd: WideString): Integer;
Begin
  Result := Obj.SetDictPwd(pwd);
End;

Function TNormalObj.EnumWindowByProcessId(pid: Integer; title: WideString;
  class_name: WideString; filter: Integer): WideString;
Begin
  Result := Obj.EnumWindowByProcessId(pid, title, class_name, filter);
End;

Function TNormalObj.DmGuard(en: Integer; tpe: WideString): Integer;
Begin
  Result := Obj.DmGuard(en, tpe);
End;

Function TNormalObj.GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
  fun_name: WideString): Int64;
Begin
  Result := Obj.GetRemoteApiAddress(hwnd, base_addr, fun_name);
End;

Function TNormalObj.SetKeypadDelay(tpe: WideString; delay: Integer): Integer;
Begin
  Result := Obj.SetKeypadDelay(tpe, delay);
End;

Function TNormalObj.LeftClick(): Integer;
Begin
  Result := Obj.LeftClick;
End;

Function TNormalObj.CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString; sim: Double): Integer;
Begin
  Result := Obj.CreateFoobarCustom(hwnd, x, y, pic, trans_color, sim);
End;

Function TNormalObj.IsFolderExist(folder: WideString): Integer;
Begin
  Result := Obj.IsFolderExist(folder);
End;

Function TNormalObj.MiddleDown(): Integer;
Begin
  Result := Obj.MiddleDown;
End;

Function TNormalObj.GetDir(tpe: Integer): WideString;
Begin
  Result := Obj.GetDir(tpe);
End;

Function TNormalObj.CheckUAC(): Integer;
Begin
  Result := Obj.CheckUAC;
End;

Function TNormalObj.FaqGetSize(handle: Integer): Integer;
Begin
  Result := Obj.FaqGetSize(handle);
End;

Function TNormalObj.FindStrEx(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrEx(x1, y1, x2, y2, str, color, sim);
End;

Function TNormalObj.LockDisplay(locks: Integer): Integer;
Begin
  Result := Obj.LockDisplay(locks);
End;

Function TNormalObj.FoobarClearText(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarClearText(hwnd);
End;

Function TNormalObj.FindDoubleEx(hwnd: Integer; addr_range: WideString;
  double_value_min: Double; double_value_max: Double; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindDoubleEx(hwnd, addr_range, double_value_min,
    double_value_max, steps, multi_thread, mode);
End;

Function TNormalObj.FindIntEx(hwnd: Integer; addr_range: WideString;
  int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
  multi_thread: Integer; mode: Integer): WideString;
Begin
  Result := Obj.FindIntEx(hwnd, addr_range, int_value_min, int_value_max, tpe,
    steps, multi_thread, mode);
End;

Function TNormalObj.EncodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.EncodeFile(file_name, pwd);
End;

Function TNormalObj.BGR2RGB(bgr_color: WideString): WideString;
Begin
  Result := Obj.BGR2RGB(bgr_color);
End;

Function TNormalObj.GetSpecialWindow(flag: Integer): Integer;
Begin
  Result := Obj.GetSpecialWindow(flag);
End;

Function TNormalObj.CreateFolder(folder_name: WideString): Integer;
Begin
  Result := Obj.CreateFolder(folder_name);
End;

Function TNormalObj.SpeedNormalGraphic(en: Integer): Integer;
Begin
  Result := Obj.SpeedNormalGraphic(en);
End;

Function TNormalObj.WriteDataAddrFromBin(hwnd: Integer; addr: Int64;
  data: Integer; length: Integer): Integer;
Begin
  Result := Obj.WriteDataAddrFromBin(hwnd, addr, data, length);
End;

Function TNormalObj.UnBindWindow(): Integer;
Begin
  Result := Obj.UnBindWindow;
End;

Function TNormalObj.DeleteIni(section: WideString; key: WideString;
  file_name: WideString): Integer;
Begin
  Result := Obj.DeleteIni(section, key, file_name);
End;

Function TNormalObj.ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
  : WideString;
Begin
  Result := Obj.ReadDataAddr(hwnd, addr, length);
End;

Function TNormalObj.WriteInt(hwnd: Integer; addr: WideString; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.WriteInt(hwnd, addr, tpe, v);
End;

Function TNormalObj.OpenProcess(pid: Integer): Integer;
Begin
  Result := Obj.OpenProcess(pid);
End;

Function TNormalObj.AsmCallEx(hwnd: Integer; mode: Integer;
  base_addr: WideString): Int64;
Begin
  Result := Obj.AsmCallEx(hwnd, mode, base_addr);
End;

Function TNormalObj.SetShowErrorMsg(show: Integer): Integer;
Begin
  Result := Obj.SetShowErrorMsg(show);
End;

Function TNormalObj.SetWindowTransparent(hwnd: Integer; v: Integer): Integer;
Begin
  Result := Obj.SetWindowTransparent(hwnd, v);
End;

Function TNormalObj.FindWindowSuper(spec1: WideString; flag1: Integer;
  type1: Integer; spec2: WideString; flag2: Integer; type2: Integer): Integer;
Begin
  Result := Obj.FindWindowSuper(spec1, flag1, type1, spec2, flag2, type2);
End;

Function TNormalObj.WriteFloat(hwnd: Integer; addr: WideString;
  v: Single): Integer;
Begin
  Result := Obj.WriteFloat(hwnd, addr, v);
End;

Function TNormalObj.EnableKeypadPatch(en: Integer): Integer;
Begin
  Result := Obj.EnableKeypadPatch(en);
End;

Function TNormalObj.GetCpuType(): Integer;
Begin
  Result := Obj.GetCpuType;
End;

Function TNormalObj.SetExportDict(index: Integer;
  dict_name: WideString): Integer;
Begin
  Result := Obj.SetExportDict(index, dict_name);
End;

Function TNormalObj.LockMouseRect(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer): Integer;
Begin
  Result := Obj.LockMouseRect(x1, y1, x2, y2);
End;

Function TNormalObj.TerminateProcess(pid: Integer): Integer;
Begin
  Result := Obj.TerminateProcess(pid);
End;

Function TNormalObj.EnableIme(en: Integer): Integer;
Begin
  Result := Obj.EnableIme(en);
End;

Function TNormalObj.Is64Bit(): Integer;
Begin
  Result := Obj.Is64Bit;
End;

Function TNormalObj.OcrInFile(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_name: WideString; color: WideString; sim: Double)
  : WideString;
Begin
  Result := Obj.OcrInFile(x1, y1, x2, y2, pic_name, color, sim);
End;

Function TNormalObj.DownloadFile(url: WideString; save_file: WideString;
  timeout: Integer): Integer;
Begin
  Result := Obj.DownloadFile(url, save_file, timeout);
End;

Function TNormalObj.GetMachineCodeNoMac(): WideString;
Begin
  Result := Obj.GetMachineCodeNoMac;
End;

Function TNormalObj.SetExcludeRegion(tpe: Integer; info: WideString): Integer;
Begin
  Result := Obj.SetExcludeRegion(tpe, info);
End;

Function TNormalObj.GetWindowProcessId(hwnd: Integer): Integer;
Begin
  Result := Obj.GetWindowProcessId(hwnd);
End;

Function TNormalObj.FindMultiColorE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; first_color: WideString; offset_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindMultiColorE(x1, y1, x2, y2, first_color, offset_color,
    sim, dir);
End;

Function TNormalObj.GetColorNum(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double): Integer;
Begin
  Result := Obj.GetColorNum(x1, y1, x2, y2, color, sim);
End;

Function TNormalObj.FoobarPrintText(hwnd: Integer; text: WideString;
  color: WideString): Integer;
Begin
  Result := Obj.FoobarPrintText(hwnd, text, color);
End;

Function TNormalObj.FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
  x2: Integer; y2: Integer; color: WideString): Integer;
Begin
  Result := Obj.FoobarFillRect(hwnd, x1, y1, x2, y2, color);
End;

Function TNormalObj.Beep(fre: Integer; delay: Integer): Integer;
Begin
  Result := Obj.Beep(fre, delay);
End;

Function TNormalObj.GetColorHSV(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.GetColorHSV(x, y);
End;

Function TNormalObj.SwitchBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.SwitchBindWindow(hwnd);
End;

Function TNormalObj.MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
  : WideString;
Begin
  Result := Obj.MoveToEx(x, y, w, h);
End;

Function TNormalObj.WheelDown(): Integer;
Begin
  Result := Obj.WheelDown;
End;

Function TNormalObj.ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
  length: Integer): WideString;
Begin
  Result := Obj.ReadString(hwnd, addr, tpe, length);
End;

Function TNormalObj.MoveR(rx: Integer; ry: Integer): Integer;
Begin
  Result := Obj.MoveR(rx, ry);
End;

Function TNormalObj.GetNowDict(): Integer;
Begin
  Result := Obj.GetNowDict;
End;

Function TNormalObj.WriteDouble(hwnd: Integer; addr: WideString;
  v: Double): Integer;
Begin
  Result := Obj.WriteDouble(hwnd, addr, v);
End;

Function TNormalObj.WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: Int64): Integer;
Begin
  Result := Obj.WriteIntAddr(hwnd, addr, tpe, v);
End;

Function TNormalObj.CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
  w: Integer; h: Integer): Integer;
Begin
  Result := Obj.CreateFoobarEllipse(hwnd, x, y, w, h);
End;

Function TNormalObj.EnableKeypadMsg(en: Integer): Integer;
Begin
  Result := Obj.EnableKeypadMsg(en);
End;

Function TNormalObj.ReleaseRef(): Integer;
Begin
  Result := Obj.ReleaseRef;
End;

Function TNormalObj.DeleteIniPwd(section: WideString; key: WideString;
  file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.DeleteIniPwd(section, key, file_name, pwd);
End;

Function TNormalObj.GetWordResultStr(str: WideString; index: Integer)
  : WideString;
Begin
  Result := Obj.GetWordResultStr(str, index);
End;

Function TNormalObj.FoobarUnlock(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarUnlock(hwnd);
End;

Function TNormalObj.SetPicPwd(pwd: WideString): Integer;
Begin
  Result := Obj.SetPicPwd(pwd);
End;

Function TNormalObj.GetWindowClass(hwnd: Integer): WideString;
Begin
  Result := Obj.GetWindowClass(hwnd);
End;

Function TNormalObj.EnableKeypadSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.EnableKeypadSync(en, time_out);
End;

Function TNormalObj.DisableScreenSave(): Integer;
Begin
  Result := Obj.DisableScreenSave;
End;

Function TNormalObj.GetNetTimeSafe(): WideString;
Begin
  Result := Obj.GetNetTimeSafe;
End;

Function TNormalObj.FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
  pic: WideString; trans_color: WideString): Integer;
Begin
  Result := Obj.FoobarDrawPic(hwnd, x, y, pic, trans_color);
End;

Function TNormalObj.WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
  v: WideString): Integer;
Begin
  Result := Obj.WriteStringAddr(hwnd, addr, tpe, v);
End;

Function TNormalObj.GetResultPos(str: WideString; index: Integer;
  out x: OleVariant; out y: OleVariant): Integer;
Begin
  Result := Obj.GetResultPos(str, index, x, y);
End;

Function TNormalObj.StringToData(string_value: WideString; tpe: Integer)
  : WideString;
Begin
  Result := Obj.StringToData(string_value, tpe);
End;

Function TNormalObj.GetOsType(): Integer;
Begin
  Result := Obj.GetOsType;
End;

Function TNormalObj.GetForegroundWindow(): Integer;
Begin
  Result := Obj.GetForegroundWindow;
End;

Function TNormalObj.LoadPic(pic_name: WideString): Integer;
Begin
  Result := Obj.LoadPic(pic_name);
End;

Function TNormalObj.SetMinColGap(col_gap: Integer): Integer;
Begin
  Result := Obj.SetMinColGap(col_gap);
End;

Function TNormalObj.GetWindowProcessPath(hwnd: Integer): WideString;
Begin
  Result := Obj.GetWindowProcessPath(hwnd);
End;

Function TNormalObj.SetExactOcr(exact_ocr: Integer): Integer;
Begin
  Result := Obj.SetExactOcr(exact_ocr);
End;

Function TNormalObj.DisableFontSmooth(): Integer;
Begin
  Result := Obj.DisableFontSmooth;
End;

Function TNormalObj.GetColorBGR(x: Integer; y: Integer): WideString;
Begin
  Result := Obj.GetColorBGR(x, y);
End;

Function TNormalObj.EnableMouseSync(en: Integer; time_out: Integer): Integer;
Begin
  Result := Obj.EnableMouseSync(en, time_out);
End;

Function TNormalObj.FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer;
Begin
  Result := Obj.FoobarTextLineGap(hwnd, gap);
End;

Function TNormalObj.SetDisplayRefreshDelay(T: Integer): Integer;
Begin
  Result := Obj.SetDisplayRefreshDelay(T);
End;

Function TNormalObj.FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
  str: WideString; color: WideString; sim: Double): WideString;
Begin
  Result := Obj.FindStrE(x1, y1, x2, y2, str, color, sim);
End;

Function TNormalObj.VirtualFreeEx(hwnd: Integer; addr: Int64): Integer;
Begin
  Result := Obj.VirtualFreeEx(hwnd, addr);
End;

Function TNormalObj.GetBindWindow(): Integer;
Begin
  Result := Obj.GetBindWindow;
End;

Function TNormalObj.DecodeFile(file_name: WideString; pwd: WideString): Integer;
Begin
  Result := Obj.DecodeFile(file_name, pwd);
End;

Function TNormalObj.GetDmCount(): Integer;
Begin
  Result := Obj.GetDmCount;
End;

Function TNormalObj.EnableBind(en: Integer): Integer;
Begin
  Result := Obj.EnableBind(en);
End;

Function TNormalObj.FindWindowByProcessId(process_id: Integer;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.FindWindowByProcessId(process_id, class_name, title_name);
End;

Function TNormalObj.ReadData(hwnd: Integer; addr: WideString; length: Integer)
  : WideString;
Begin
  Result := Obj.ReadData(hwnd, addr, length);
End;

Function TNormalObj.MoveTo(x: Integer; y: Integer): Integer;
Begin
  Result := Obj.MoveTo(x, y);
End;

Function TNormalObj.LoadPicByte(addr: Integer; size: Integer;
  name: WideString): Integer;
Begin
  Result := Obj.LoadPicByte(addr, size, name);
End;

Function TNormalObj.GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; out data: OleVariant; out size: OleVariant): Integer;
Begin
  Result := Obj.GetScreenDataBmp(x1, y1, x2, y2, data, size);
End;

Function TNormalObj.FindDataEx(hwnd: Integer; addr_range: WideString;
  data: WideString; steps: Integer; multi_thread: Integer; mode: Integer)
  : WideString;
Begin
  Result := Obj.FindDataEx(hwnd, addr_range, data, steps, multi_thread, mode);
End;

Function TNormalObj.FindWindowByProcess(process_name: WideString;
  class_name: WideString; title_name: WideString): Integer;
Begin
  Result := Obj.FindWindowByProcess(process_name, class_name, title_name);
End;

Function TNormalObj.IsFileExist(file_name: WideString): Integer;
Begin
  Result := Obj.IsFileExist(file_name);
End;

Function TNormalObj.SetMinRowGap(row_gap: Integer): Integer;
Begin
  Result := Obj.SetMinRowGap(row_gap);
End;

Function TNormalObj.GetPicSize(pic_name: WideString): WideString;
Begin
  Result := Obj.GetPicSize(pic_name);
End;

Function TNormalObj.WriteDataAddr(hwnd: Integer; addr: Int64;
  data: WideString): Integer;
Begin
  Result := Obj.WriteDataAddr(hwnd, addr, data);
End;

Function TNormalObj.EnterCri(): Integer;
Begin
  Result := Obj.EnterCri;
End;

Function TNormalObj.EnableGetColorByCapture(en: Integer): Integer;
Begin
  Result := Obj.EnableGetColorByCapture(en);
End;

Function TNormalObj.RegNoMac(code: WideString; ver: WideString): Integer;
Begin
  Result := Obj.RegNoMac(code, ver);
End;

Function TNormalObj.SendStringIme2(hwnd: Integer; str: WideString;
  mode: Integer): Integer;
Begin
  Result := Obj.SendStringIme2(hwnd, str, mode);
End;

Function TNormalObj.GetMousePointWindow(): Integer;
Begin
  Result := Obj.GetMousePointWindow;
End;

Function TNormalObj.AsmCall(hwnd: Integer; mode: Integer): Int64;
Begin
  Result := Obj.AsmCall(hwnd, mode);
End;

Function TNormalObj.SetWindowSize(hwnd: Integer; width: Integer;
  height: Integer): Integer;
Begin
  Result := Obj.SetWindowSize(hwnd, width, height);
End;

Function TNormalObj.FindColorE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; color: WideString; sim: Double; dir: Integer): WideString;
Begin
  Result := Obj.FindColorE(x1, y1, x2, y2, color, sim, dir);
End;

Function TNormalObj.ReadDataToBin(hwnd: Integer; addr: WideString;
  length: Integer): Integer;
Begin
  Result := Obj.ReadDataToBin(hwnd, addr, length);
End;

Function TNormalObj.EnableDisplayDebug(enable_debug: Integer): Integer;
Begin
  Result := Obj.EnableDisplayDebug(enable_debug);
End;

Function TNormalObj.SetPath(path: WideString): Integer;
Begin
  Result := Obj.SetPath(path);
End;

Function TNormalObj.FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
  pic_name: WideString; repeat_limit: Integer; delay: Integer): Integer;
Begin
  Result := Obj.FoobarStartGif(hwnd, x, y, pic_name, repeat_limit, delay);
End;

Function TNormalObj.FreeScreenData(handle: Integer): Integer;
Begin
  Result := Obj.FreeScreenData(handle);
End;

Function TNormalObj.CapturePng(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; file_name: WideString): Integer;
Begin
  Result := Obj.CapturePng(x1, y1, x2, y2, file_name);
End;

Function TNormalObj.AppendPicAddr(pic_info: WideString; addr: Integer;
  size: Integer): WideString;
Begin
  Result := Obj.AppendPicAddr(pic_info, addr, size);
End;

Function TNormalObj.MatchPicName(pic_name: WideString): WideString;
Begin
  Result := Obj.MatchPicName(pic_name);
End;

Function TNormalObj.FoobarLock(hwnd: Integer): Integer;
Begin
  Result := Obj.FoobarLock(hwnd);
End;

Function TNormalObj.FindPicMemE(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; pic_info: WideString; delta_color: WideString; sim: Double;
  dir: Integer): WideString;
Begin
  Result := Obj.FindPicMemE(x1, y1, x2, y2, pic_info, delta_color, sim, dir);
End;

Function TNormalObj.ForceUnBindWindow(hwnd: Integer): Integer;
Begin
  Result := Obj.ForceUnBindWindow(hwnd);
End;

Function TNormalObj.MoveWindow(hwnd: Integer; x: Integer; y: Integer): Integer;
Begin
  Result := Obj.MoveWindow(hwnd, x, y);
End;

Function TNormalObj.FindStrFastS(x1: Integer; y1: Integer; x2: Integer;
  y2: Integer; str: WideString; color: WideString; sim: Double;
  out x: OleVariant; out y: OleVariant): WideString;
Begin
  Result := Obj.FindStrFastS(x1, y1, x2, y2, str, color, sim, x, y);
End;

Function TNormalObj.GetPath(): WideString;
Begin
  Result := Obj.GetPath;
End;

Function TNormalObj.Stop(id: Integer): Integer;
Begin
  Result := Obj.Stop(id);
End;

Function TNormalObj.ReadIntAddr(hwnd: Integer; addr: Int64;
  tpe: Integer): Int64;
Begin
  Result := Obj.ReadIntAddr(hwnd, addr, tpe);
End;

Function TNormalObj.Int64ToInt32(v: Int64): Integer;
Begin
  Result := Obj.Int64ToInt32(v);
End;

Function TNormalObj.LeftDown(): Integer;
Begin
  Result := Obj.LeftDown;
End;

Function TNormalObj.Log(info: WideString): Integer;
Begin
  Result := Obj.Log(info);
End;

Function TNormalObj.GetClipboard(): WideString;
Begin
  Result := Obj.GetClipboard;
End;

Function TNormalObj.EnableSpeedDx(en: Integer): Integer;
Begin
  Result := Obj.EnableSpeedDx(en);
End;

initialization

finalization

end.
