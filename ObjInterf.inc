type
  IObj = interface(IDispatch)
    ['{F3F54BC2-D6D1-4A85-B943-16287ECEA64C}']
    function Ver: WideString; safecall;
    function SetPath(const path: WideString): Integer; safecall;
    function Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double): WideString; safecall;
    function FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double;
      out x: OleVariant; out y: OleVariant): Integer; safecall;
    function GetResultCount(const str: WideString): Integer; safecall;
    function GetResultPos(const str: WideString; index: Integer;
      out x: OleVariant; out y: OleVariant): Integer; safecall;
    function StrStr(const s: WideString; const str: WideString)
      : Integer; safecall;
    function SendCommand(const cmd: WideString): Integer; safecall;
    function UseDict(index: Integer): Integer; safecall;
    function GetBasePath: WideString; safecall;
    function SetDictPwd(const pwd: WideString): Integer; safecall;
    function OcrInFile(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_name: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const file_: WideString): Integer; safecall;
    function KeyPress(vk: Integer): Integer; safecall;
    function KeyDown(vk: Integer): Integer; safecall;
    function KeyUp(vk: Integer): Integer; safecall;
    function LeftClick: Integer; safecall;
    function RightClick: Integer; safecall;
    function MiddleClick: Integer; safecall;
    function LeftDoubleClick: Integer; safecall;
    function LeftDown: Integer; safecall;
    function LeftUp: Integer; safecall;
    function RightDown: Integer; safecall;
    function RightUp: Integer; safecall;
    function MoveTo(x: Integer; y: Integer): Integer; safecall;
    function MoveR(rx: Integer; ry: Integer): Integer; safecall;
    function GetColor(x: Integer; y: Integer): WideString; safecall;
    function GetColorBGR(x: Integer; y: Integer): WideString; safecall;
    function RGB2BGR(const rgb_color: WideString): WideString; safecall;
    function BGR2RGB(const bgr_color: WideString): WideString; safecall;
    function UnBindWindow: Integer; safecall;
    function CmpColor(x: Integer; y: Integer; const color: WideString;
      sim: Double): Integer; safecall;
    function ClientToScreen(hwnd: Integer; var x: OleVariant; var y: OleVariant)
      : Integer; safecall;
    function ScreenToClient(hwnd: Integer; var x: OleVariant; var y: OleVariant)
      : Integer; safecall;
    function ShowScrMsg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const msg: WideString; const color: WideString): Integer; safecall;
    function SetMinRowGap(row_gap: Integer): Integer; safecall;
    function SetMinColGap(col_gap: Integer): Integer; safecall;
    function FindColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer; safecall;
    function FindColorEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double; dir: Integer): WideString; safecall;
    function SetWordLineHeight(line_height: Integer): Integer; safecall;
    function SetWordGap(word_gap: Integer): Integer; safecall;
    function SetRowGapNoDict(row_gap: Integer): Integer; safecall;
    function SetColGapNoDict(col_gap: Integer): Integer; safecall;
    function SetWordLineHeightNoDict(line_height: Integer): Integer; safecall;
    function SetWordGapNoDict(word_gap: Integer): Integer; safecall;
    function GetWordResultCount(const str: WideString): Integer; safecall;
    function GetWordResultPos(const str: WideString; index: Integer;
      out x: OleVariant; out y: OleVariant): Integer; safecall;
    function GetWordResultStr(const str: WideString; index: Integer)
      : WideString; safecall;
    function GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double): WideString; safecall;
    function GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString): WideString; safecall;
    function SetShowErrorMsg(show: Integer): Integer; safecall;
    function GetClientSize(hwnd: Integer; out width: OleVariant;
      out height: OleVariant): Integer; safecall;
    function MoveWindow(hwnd: Integer; x: Integer; y: Integer)
      : Integer; safecall;
    function GetColorHSV(x: Integer; y: Integer): WideString; safecall;
    function GetAveRGB(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString; safecall;
    function GetAveHSV(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString; safecall;
    function GetForegroundWindow: Integer; safecall;
    function GetForegroundFocus: Integer; safecall;
    function GetMousePointWindow: Integer; safecall;
    function GetPointWindow(x: Integer; y: Integer): Integer; safecall;
    function EnumWindow(parent: Integer; const title: WideString;
      const class_name: WideString; filter: Integer): WideString; safecall;
    function GetWindowState(hwnd: Integer; flag: Integer): Integer; safecall;
    function GetWindow(hwnd: Integer; flag: Integer): Integer; safecall;
    function GetSpecialWindow(flag: Integer): Integer; safecall;
    function SetWindowText(hwnd: Integer; const text: WideString)
      : Integer; safecall;
    function SetWindowSize(hwnd: Integer; width: Integer; height: Integer)
      : Integer; safecall;
    function GetWindowRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant)
      : Integer; safecall;
    function GetWindowTitle(hwnd: Integer): WideString; safecall;
    function GetWindowClass(hwnd: Integer): WideString; safecall;
    function SetWindowState(hwnd: Integer; flag: Integer): Integer; safecall;
    function CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer; safecall;
    function CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer; rw: Integer; rh: Integer): Integer; safecall;
    function CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer): Integer; safecall;
    function CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
      const pic: WideString; const trans_color: WideString; sim: Double)
      : Integer; safecall;
    function FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; const color: WideString): Integer; safecall;
    function FoobarDrawText(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer; const text: WideString; const color: WideString;
      align: Integer): Integer; safecall;
    function FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
      const pic: WideString; const trans_color: WideString): Integer; safecall;
    function FoobarUpdate(hwnd: Integer): Integer; safecall;
    function FoobarLock(hwnd: Integer): Integer; safecall;
    function FoobarUnlock(hwnd: Integer): Integer; safecall;
    function FoobarSetFont(hwnd: Integer; const font_name: WideString;
      size: Integer; flag: Integer): Integer; safecall;
    function FoobarTextRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer; safecall;
    function FoobarPrintText(hwnd: Integer; const text: WideString;
      const color: WideString): Integer; safecall;
    function FoobarClearText(hwnd: Integer): Integer; safecall;
    function FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer; safecall;
    function Play(const file_: WideString): Integer; safecall;
    function FaqCapture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      quality: Integer; delay: Integer; time: Integer): Integer; safecall;
    function FaqRelease(handle: Integer): Integer; safecall;
    function FaqSend(const server: WideString; handle: Integer;
      request_type: Integer; time_out: Integer): WideString; safecall;
    function Beep(fre: Integer; delay: Integer): Integer; safecall;
    function FoobarClose(hwnd: Integer): Integer; safecall;
    function MoveDD(dx: Integer; dy: Integer): Integer; safecall;
    function FaqGetSize(handle: Integer): Integer; safecall;
    function LoadPic(const pic_name: WideString): Integer; safecall;
    function FreePic(const pic_name: WideString): Integer; safecall;
    function GetScreenData(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : Integer; safecall;
    function FreeScreenData(handle: Integer): Integer; safecall;
    function WheelUp: Integer; safecall;
    function WheelDown: Integer; safecall;
    function SetMouseDelay(const type_: WideString; delay: Integer)
      : Integer; safecall;
    function SetKeypadDelay(const type_: WideString; delay: Integer)
      : Integer; safecall;
    function GetEnv(index: Integer; const name: WideString)
      : WideString; safecall;
    function SetEnv(index: Integer; const name: WideString;
      const value: WideString): Integer; safecall;
    function SendString(hwnd: Integer; const str: WideString): Integer;
      safecall;
    function DelEnv(index: Integer; const name: WideString): Integer; safecall;
    function GetPath: WideString; safecall;
    function SetDict(index: Integer; const dict_name: WideString)
      : Integer; safecall;
    function FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_name: WideString; const delta_color: WideString; sim: Double;
      dir: Integer; out x: OleVariant; out y: OleVariant): Integer; safecall;
    function FindPicEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_name: WideString; const delta_color: WideString; sim: Double;
      dir: Integer): WideString; safecall;
    function SetClientSize(hwnd: Integer; width: Integer; height: Integer)
      : Integer; safecall;
    function ReadInt(hwnd: Integer; const addr: WideString; type_: Integer)
      : Int64; safecall;
    function ReadFloat(hwnd: Integer; const addr: WideString): Single; safecall;
    function ReadDouble(hwnd: Integer; const addr: WideString): Double;
      safecall;
    function FindInt(hwnd: Integer; const addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; type_: Integer)
      : WideString; safecall;
    function FindFloat(hwnd: Integer; const addr_range: WideString;
      float_value_min: Single; float_value_max: Single): WideString; safecall;
    function FindDouble(hwnd: Integer; const addr_range: WideString;
      double_value_min: Double; double_value_max: Double): WideString; safecall;
    function FindString(hwnd: Integer; const addr_range: WideString;
      const string_value: WideString; type_: Integer): WideString; safecall;
    function GetModuleBaseAddr(hwnd: Integer; const module_name: WideString)
      : Int64; safecall;
    function MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
      : WideString; safecall;
    function MatchPicName(const pic_name: WideString): WideString; safecall;
    function AddDict(index: Integer; const dict_info: WideString)
      : Integer; safecall;
    function EnterCri: Integer; safecall;
    function LeaveCri: Integer; safecall;
    function WriteInt(hwnd: Integer; const addr: WideString; type_: Integer;
      v: Int64): Integer; safecall;
    function WriteFloat(hwnd: Integer; const addr: WideString; v: Single)
      : Integer; safecall;
    function WriteDouble(hwnd: Integer; const addr: WideString; v: Double)
      : Integer; safecall;
    function WriteString(hwnd: Integer; const addr: WideString; type_: Integer;
      const v: WideString): Integer; safecall;
    function AsmAdd(const asm_ins: WideString): Integer; safecall;
    function AsmClear: Integer; safecall;
    function AsmCall(hwnd: Integer; mode: Integer): Int64; safecall;
    function FindMultiColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const first_color: WideString; const offset_color: WideString;
      sim: Double; dir: Integer; out x: OleVariant; out y: OleVariant)
      : Integer; safecall;
    function FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; const first_color: WideString;
      const offset_color: WideString; sim: Double; dir: Integer)
      : WideString; safecall;
    function Assemble(base_addr: Int64; is_64bit: Integer): WideString;
      safecall;
    function DisAssemble(const asm_code: WideString; base_addr: Int64;
      is_64bit: Integer): WideString; safecall;
    function SetWindowTransparent(hwnd: Integer; v: Integer): Integer; safecall;
    function ReadData(hwnd: Integer; const addr: WideString; len: Integer)
      : WideString; safecall;
    function WriteData(hwnd: Integer; const addr: WideString;
      const data: WideString): Integer; safecall;
    function FindData(hwnd: Integer; const addr_range: WideString;
      const data: WideString): WideString; safecall;
    function SetPicPwd(const pwd: WideString): Integer; safecall;
    function Log(const info: WideString): Integer; safecall;
    function FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function FindColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double; dir: Integer): WideString; safecall;
    function FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_name: WideString; const delta_color: WideString; sim: Double;
      dir: Integer): WideString; safecall;
    function FindMultiColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const first_color: WideString; const offset_color: WideString;
      sim: Double; dir: Integer): WideString; safecall;
    function SetExactOcr(exact_ocr: Integer): Integer; safecall;
    function ReadString(hwnd: Integer; const addr: WideString; type_: Integer;
      len: Integer): WideString; safecall;
    function FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer; safecall;
    function OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double): WideString; safecall;
    function SetDisplayInput(const mode: WideString): Integer; safecall;
    function GetTime: Integer; safecall;
    function GetScreenWidth: Integer; safecall;
    function GetScreenHeight: Integer; safecall;
    function BindWindowEx(hwnd: Integer; const display: WideString;
      const mouse: WideString; const keypad: WideString;
      const public_desc: WideString; mode: Integer): Integer; safecall;
    function GetDiskSerial: WideString; safecall;
    function Md5(const str: WideString): WideString; safecall;
    function GetMac: WideString; safecall;
    function ActiveInputMethod(hwnd: Integer; const id: WideString)
      : Integer; safecall;
    function CheckInputMethod(hwnd: Integer; const id: WideString)
      : Integer; safecall;
    function FindInputMethod(const id: WideString): Integer; safecall;
    function GetCursorPos(out x: OleVariant; out y: OleVariant)
      : Integer; safecall;
    function BindWindow(hwnd: Integer; const display: WideString;
      const mouse: WideString; const keypad: WideString; mode: Integer)
      : Integer; safecall;
    function FindWindow(const class_name: WideString;
      const title_name: WideString): Integer; safecall;
    function GetScreenDepth: Integer; safecall;
    function SetScreen(width: Integer; height: Integer; depth: Integer)
      : Integer; safecall;
    function ExitOs(type_: Integer): Integer; safecall;
    function GetDir(type_: Integer): WideString; safecall;
    function GetOsType: Integer; safecall;
    function FindWindowEx(parent: Integer; const class_name: WideString;
      const title_name: WideString): Integer; safecall;
    function SetExportDict(index: Integer; const dict_name: WideString)
      : Integer; safecall;
    function GetCursorShape: WideString; safecall;
    function DownCpu(rate: Integer): Integer; safecall;
    function GetCursorSpot: WideString; safecall;
    function SendString2(hwnd: Integer; const str: WideString)
      : Integer; safecall;
    function FaqPost(const server: WideString; handle: Integer;
      request_type: Integer; time_out: Integer): Integer; safecall;
    function FaqFetch: WideString; safecall;
    function FetchWord(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; const word: WideString): WideString; safecall;
    function CaptureJpg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const file_: WideString; quality: Integer): Integer; safecall;
    function FindStrWithFont(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double;
      const font_name: WideString; font_size: Integer; flag: Integer;
      out x: OleVariant; out y: OleVariant): Integer; safecall;
    function FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; const str: WideString; const color: WideString; sim: Double;
      const font_name: WideString; font_size: Integer; flag: Integer)
      : WideString; safecall;
    function FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; const str: WideString; const color: WideString; sim: Double;
      const font_name: WideString; font_size: Integer; flag: Integer)
      : WideString; safecall;
    function GetDictInfo(const str: WideString; const font_name: WideString;
      font_size: Integer; flag: Integer): WideString; safecall;
    function SaveDict(index: Integer; const file_: WideString)
      : Integer; safecall;
    function GetWindowProcessId(hwnd: Integer): Integer; safecall;
    function GetWindowProcessPath(hwnd: Integer): WideString; safecall;
    function LockInput(lock: Integer): Integer; safecall;
    function GetPicSize(const pic_name: WideString): WideString; safecall;
    function GetID: Integer; safecall;
    function CapturePng(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const file_: WideString): Integer; safecall;
    function CaptureGif(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const file_: WideString; delay: Integer; time: Integer): Integer;
      safecall;
    function ImageToBmp(const pic_name: WideString; const bmp_name: WideString)
      : Integer; safecall;
    function FindStrFast(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double;
      out x: OleVariant; out y: OleVariant): Integer; safecall;
    function FindStrFastEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function FindStrFastE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function EnableDisplayDebug(enable_debug: Integer): Integer; safecall;
    function CapturePre(const file_: WideString): Integer; safecall;
    function RegEx(const code: WideString; const Ver: WideString;
      const ip: WideString): Integer; safecall;
    function GetMachineCode: WideString; safecall;
    function SetClipboard(const data: WideString): Integer; safecall;
    function GetClipboard: WideString; safecall;
    function GetNowDict: Integer; safecall;
    function Is64Bit: Integer; safecall;
    function GetColorNum(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double): Integer; safecall;
    function EnumWindowByProcess(const process_name: WideString;
      const title: WideString; const class_name: WideString; filter: Integer)
      : WideString; safecall;
    function GetDictCount(index: Integer): Integer; safecall;
    function GetLastError: Integer; safecall;
    function GetNetTime: WideString; safecall;
    function EnableGetColorByCapture(en: Integer): Integer; safecall;
    function CheckUAC: Integer; safecall;
    function SetUAC(uac: Integer): Integer; safecall;
    function DisableFontSmooth: Integer; safecall;
    function CheckFontSmooth: Integer; safecall;
    function SetDisplayAcceler(level: Integer): Integer; safecall;
    function FindWindowByProcess(const process_name: WideString;
      const class_name: WideString; const title_name: WideString)
      : Integer; safecall;
    function FindWindowByProcessId(process_id: Integer;
      const class_name: WideString; const title_name: WideString)
      : Integer; safecall;
    function ReadIni(const section: WideString; const key: WideString;
      const file_: WideString): WideString; safecall;
    function WriteIni(const section: WideString; const key: WideString;
      const v: WideString; const file_: WideString): Integer; safecall;
    function RunApp(const path: WideString; mode: Integer): Integer; safecall;
    function delay(mis: Integer): Integer; safecall;
    function FindWindowSuper(const spec1: WideString; flag1: Integer;
      type1: Integer; const spec2: WideString; flag2: Integer; type2: Integer)
      : Integer; safecall;
    function ExcludePos(const all_pos: WideString; type_: Integer; x1: Integer;
      y1: Integer; x2: Integer; y2: Integer): WideString; safecall;
    function FindNearestPos(const all_pos: WideString; type_: Integer;
      x: Integer; y: Integer): WideString; safecall;
    function SortPosDistance(const all_pos: WideString; type_: Integer;
      x: Integer; y: Integer): WideString; safecall;
    function FindPicMem(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_info: WideString; const delta_color: WideString; sim: Double;
      dir: Integer; out x: OleVariant; out y: OleVariant): Integer; safecall;
    function FindPicMemEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_info: WideString; const delta_color: WideString; sim: Double;
      dir: Integer): WideString; safecall;
    function FindPicMemE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_info: WideString; const delta_color: WideString; sim: Double;
      dir: Integer): WideString; safecall;
    function AppendPicAddr(const pic_info: WideString; addr: Integer;
      size: Integer): WideString; safecall;
    function WriteFile(const file_: WideString; const content: WideString)
      : Integer; safecall;
    function Stop(id: Integer): Integer; safecall;
    function SetDictMem(index: Integer; addr: Integer; size: Integer)
      : Integer; safecall;
    function GetNetTimeSafe: WideString; safecall;
    function ForceUnBindWindow(hwnd: Integer): Integer; safecall;
    function ReadIniPwd(const section: WideString; const key: WideString;
      const file_: WideString; const pwd: WideString): WideString; safecall;
    function WriteIniPwd(const section: WideString; const key: WideString;
      const v: WideString; const file_: WideString; const pwd: WideString)
      : Integer; safecall;
    function DecodeFile(const file_: WideString; const pwd: WideString)
      : Integer; safecall;
    function KeyDownChar(const key_str: WideString): Integer; safecall;
    function KeyUpChar(const key_str: WideString): Integer; safecall;
    function KeyPressChar(const key_str: WideString): Integer; safecall;
    function KeyPressStr(const key_str: WideString; delay: Integer)
      : Integer; safecall;
    function EnableKeypadPatch(en: Integer): Integer; safecall;
    function EnableKeypadSync(en: Integer; time_out: Integer): Integer;
      safecall;
    function EnableMouseSync(en: Integer; time_out: Integer): Integer; safecall;
    function DmGuard(en: Integer; const type_: WideString): Integer; safecall;
    function FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; const file_: WideString; quality: Integer): Integer;
      safecall;
    function FindIntEx(hwnd: Integer; const addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; type_: Integer; step: Integer;
      multi_thread: Integer; mode: Integer): WideString; safecall;
    function FindFloatEx(hwnd: Integer; const addr_range: WideString;
      float_value_min: Single; float_value_max: Single; step: Integer;
      multi_thread: Integer; mode: Integer): WideString; safecall;
    function FindDoubleEx(hwnd: Integer; const addr_range: WideString;
      double_value_min: Double; double_value_max: Double; step: Integer;
      multi_thread: Integer; mode: Integer): WideString; safecall;
    function FindStringEx(hwnd: Integer; const addr_range: WideString;
      const string_value: WideString; type_: Integer; step: Integer;
      multi_thread: Integer; mode: Integer): WideString; safecall;
    function FindDataEx(hwnd: Integer; const addr_range: WideString;
      const data: WideString; step: Integer; multi_thread: Integer;
      mode: Integer): WideString; safecall;
    function EnableRealMouse(en: Integer; mousedelay: Integer;
      mousestep: Integer): Integer; safecall;
    function EnableRealKeypad(en: Integer): Integer; safecall;
    function SendStringIme(const str: WideString): Integer; safecall;
    function FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; const color: WideString; style: Integer;
      width: Integer): Integer; safecall;
    function FindStrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function IsBind(hwnd: Integer): Integer; safecall;
    function SetDisplayDelay(t: Integer): Integer; safecall;
    function GetDmCount: Integer; safecall;
    function DisableScreenSave: Integer; safecall;
    function DisablePowerSave: Integer; safecall;
    function SetMemoryHwndAsProcessId(en: Integer): Integer; safecall;
    function FindShape(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const offset_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer; safecall;
    function FindShapeE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const offset_color: WideString; sim: Double; dir: Integer)
      : WideString; safecall;
    function FindShapeEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const offset_color: WideString; sim: Double; dir: Integer)
      : WideString; safecall;
    function FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double;
      out x: OleVariant; out y: OleVariant): WideString; safecall;
    function FindStrExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function FindStrFastS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double;
      out x: OleVariant; out y: OleVariant): WideString; safecall;
    function FindStrFastExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const str: WideString; const color: WideString; sim: Double)
      : WideString; safecall;
    function FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_name: WideString; const delta_color: WideString; sim: Double;
      dir: Integer; out x: OleVariant; out y: OleVariant): WideString; safecall;
    function FindPicExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const pic_name: WideString; const delta_color: WideString; sim: Double;
      dir: Integer): WideString; safecall;
    function ClearDict(index: Integer): Integer; safecall;
    function GetMachineCodeNoMac: WideString; safecall;
    function GetClientRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant)
      : Integer; safecall;
    function EnableFakeActive(en: Integer): Integer; safecall;
    function GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; out data: OleVariant; out size: OleVariant)
      : Integer; safecall;
    function EncodeFile(const file_: WideString; const pwd: WideString)
      : Integer; safecall;
    function GetCursorShapeEx(type_: Integer): WideString; safecall;
    function FaqCancel: Integer; safecall;
    function IntToData(int_value: Int64; type_: Integer): WideString; safecall;
    function FloatToData(float_value: Single): WideString; safecall;
    function DoubleToData(double_value: Double): WideString; safecall;
    function StringToData(const string_value: WideString; type_: Integer)
      : WideString; safecall;
    function SetMemoryFindResultToFile(const file_: WideString)
      : Integer; safecall;
    function EnableBind(en: Integer): Integer; safecall;
    function SetSimMode(mode: Integer): Integer; safecall;
    function LockMouseRect(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : Integer; safecall;
    function SendPaste(hwnd: Integer): Integer; safecall;
    function IsDisplayDead(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      t: Integer): Integer; safecall;
    function GetKeyState(vk: Integer): Integer; safecall;
    function CopyFile(const src_file: WideString; const dst_file: WideString;
      over: Integer): Integer; safecall;
    function IsFileExist(const file_: WideString): Integer; safecall;
    function DeleteFile(const file_: WideString): Integer; safecall;
    function MoveFile(const src_file: WideString; const dst_file: WideString)
      : Integer; safecall;
    function CreateFolder(const folder_name: WideString): Integer; safecall;
    function DeleteFolder(const folder_name: WideString): Integer; safecall;
    function GetFileLength(const file_: WideString): Integer; safecall;
    function ReadFile(const file_: WideString): WideString; safecall;
    function WaitKey(key_code: Integer; time_out: Integer): Integer; safecall;
    function DeleteIni(const section: WideString; const key: WideString;
      const file_: WideString): Integer; safecall;
    function DeleteIniPwd(const section: WideString; const key: WideString;
      const file_: WideString; const pwd: WideString): Integer; safecall;
    function EnableSpeedDx(en: Integer): Integer; safecall;
    function EnableIme(en: Integer): Integer; safecall;
    function Reg(const code: WideString; const Ver: WideString)
      : Integer; safecall;
    function SelectFile: WideString; safecall;
    function SelectDirectory: WideString; safecall;
    function LockDisplay(lock: Integer): Integer; safecall;
    function FoobarSetSave(hwnd: Integer; const file_: WideString; en: Integer;
      const header: WideString): Integer; safecall;
    function EnumWindowSuper(const spec1: WideString; flag1: Integer;
      type1: Integer; const spec2: WideString; flag2: Integer; type2: Integer;
      sort: Integer): WideString; safecall;
    function DownloadFile(const url: WideString; const save_file: WideString;
      timeout: Integer): Integer; safecall;
    function EnableKeypadMsg(en: Integer): Integer; safecall;
    function EnableMouseMsg(en: Integer): Integer; safecall;
    function RegNoMac(const code: WideString; const Ver: WideString)
      : Integer; safecall;
    function RegExNoMac(const code: WideString; const Ver: WideString;
      const ip: WideString): Integer; safecall;
    function SetEnumWindowDelay(delay: Integer): Integer; safecall;
    function FindMulColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double): Integer; safecall;
    function GetDict(index: Integer; font_index: Integer): WideString; safecall;
    function GetBindWindow: Integer; safecall;
    function FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
      const pic_name: WideString; repeat_limit: Integer; delay: Integer)
      : Integer; safecall;
    function FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
      const pic_name: WideString): Integer; safecall;
    function FreeProcessMemory(hwnd: Integer): Integer; safecall;
    function ReadFileData(const file_: WideString; start_pos: Integer;
      end_pos: Integer): WideString; safecall;
    function VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
      type_: Integer): Int64; safecall;
    function VirtualFreeEx(hwnd: Integer; addr: Int64): Integer; safecall;
    function GetCommandLine(hwnd: Integer): WideString; safecall;
    function TerminateProcess(pid: Integer): Integer; safecall;
    function GetNetTimeByIp(const ip: WideString): WideString; safecall;
    function EnumProcess(const name: WideString): WideString; safecall;
    function GetProcessInfo(pid: Integer): WideString; safecall;
    function ReadIntAddr(hwnd: Integer; addr: Int64; type_: Integer)
      : Int64; safecall;
    function ReadDataAddr(hwnd: Integer; addr: Int64; len: Integer)
      : WideString; safecall;
    function ReadDoubleAddr(hwnd: Integer; addr: Int64): Double; safecall;
    function ReadFloatAddr(hwnd: Integer; addr: Int64): Single; safecall;
    function ReadStringAddr(hwnd: Integer; addr: Int64; type_: Integer;
      len: Integer): WideString; safecall;
    function WriteDataAddr(hwnd: Integer; addr: Int64; const data: WideString)
      : Integer; safecall;
    function WriteDoubleAddr(hwnd: Integer; addr: Int64; v: Double)
      : Integer; safecall;
    function WriteFloatAddr(hwnd: Integer; addr: Int64; v: Single)
      : Integer; safecall;
    function WriteIntAddr(hwnd: Integer; addr: Int64; type_: Integer; v: Int64)
      : Integer; safecall;
    function WriteStringAddr(hwnd: Integer; addr: Int64; type_: Integer;
      const v: WideString): Integer; safecall;
    function Delays(min_s: Integer; max_s: Integer): Integer; safecall;
    function FindColorBlock(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double; count: Integer; width: Integer;
      height: Integer; out x: OleVariant; out y: OleVariant): Integer; safecall;
    function FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; const color: WideString; sim: Double; count: Integer;
      width: Integer; height: Integer): WideString; safecall;
    function OpenProcess(pid: Integer): Integer; safecall;
    function EnumIniSection(const file_: WideString): WideString; safecall;
    function EnumIniSectionPwd(const file_: WideString; const pwd: WideString)
      : WideString; safecall;
    function EnumIniKey(const section: WideString; const file_: WideString)
      : WideString; safecall;
    function EnumIniKeyPwd(const section: WideString; const file_: WideString;
      const pwd: WideString): WideString; safecall;
    function SwitchBindWindow(hwnd: Integer): Integer; safecall;
    function InitCri: Integer; safecall;
    function SendStringIme2(hwnd: Integer; const str: WideString; mode: Integer)
      : Integer; safecall;
    function EnumWindowByProcessId(pid: Integer; const title: WideString;
      const class_name: WideString; filter: Integer): WideString; safecall;
    function GetDisplayInfo: WideString; safecall;
    function EnableFontSmooth: Integer; safecall;
    function OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      const color: WideString; sim: Double): WideString; safecall;
    function SetAero(en: Integer): Integer; safecall;
    function FoobarSetTrans(hwnd: Integer; trans: Integer;
      const color: WideString; sim: Double): Integer; safecall;
    function EnablePicCache(en: Integer): Integer; safecall;
    function FaqIsPosted: Integer; safecall;
    function LoadPicByte(addr: Integer; size: Integer; const name: WideString)
      : Integer; safecall;
    function MiddleDown: Integer; safecall;
    function MiddleUp: Integer; safecall;
    function FaqCaptureString(const str: WideString): Integer; safecall;
    function VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
      type_: Integer; old_protect: Integer): Integer; safecall;
    function SetMouseSpeed(speed: Integer): Integer; safecall;
    function GetMouseSpeed: Integer; safecall;
    function EnableMouseAccuracy(en: Integer): Integer; safecall;
    function SetExcludeRegion(type_: Integer; const info: WideString)
      : Integer; safecall;
    function EnableShareDict(en: Integer): Integer; safecall;
    function DisableCloseDisplayAndSleep: Integer; safecall;
    function Int64ToInt32(v: Int64): Integer; safecall;
    function GetLocale: Integer; safecall;
    function SetLocale: Integer; safecall;
    function ReadDataToBin(hwnd: Integer; const addr: WideString; len: Integer)
      : Integer; safecall;
    function WriteDataFromBin(hwnd: Integer; const addr: WideString;
      data: Integer; len: Integer): Integer; safecall;
    function ReadDataAddrToBin(hwnd: Integer; addr: Int64; len: Integer)
      : Integer; safecall;
    function WriteDataAddrFromBin(hwnd: Integer; addr: Int64; data: Integer;
      len: Integer): Integer; safecall;
    function SetParam64ToPointer: Integer; safecall;
    function GetDPI: Integer; safecall;
    function SetDisplayRefreshDelay(t: Integer): Integer; safecall;
    function IsFolderExist(const folder: WideString): Integer; safecall;
    function GetCpuType: Integer; safecall;
    function ReleaseRef: Integer; safecall;
    function SetExitThread(en: Integer): Integer; safecall;
    function GetFps: Integer; safecall;
    function VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
      : WideString; safecall;
    function AsmCallEx(hwnd: Integer; mode: Integer;
      const base_addr: WideString): Int64; safecall;
    function GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
      const fun_name: WideString): Int64; safecall;
    function ExecuteCmd(const cmd: WideString; const current_dir: WideString;
      time_out: Integer): WideString; safecall;
    function SpeedNormalGraphic(en: Integer): Integer; safecall;
    function UnLoadDriver: Integer; safecall;
    function GetOsBuildNumber: Integer; safecall;
    function HackSpeed(rate: Double): Integer; safecall;
    function GetRealPath(const path: WideString): WideString; safecall;
    function ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer;
      safecall;
    function AsmSetTimeout(time_out: Integer; param: Integer): Integer;
      safecall;
    function DmGuardParams(const cmd: WideString; const sub_cmd: WideString;
      const param: WideString): WideString; safecall;
  end;

  Isuxin = interface(IDispatch)
    ['{C3D33AE4-526D-C537-C515-BD04F4597627}']
    function UDrIjEBgcDCew(BwiiKDJ_aycl_99: Integer): Integer; safecall;
    function gLMEKWA(gtskPLu_IOTEJmc_MPmqGB: Integer; IPgjJ_BIEJ_ojLjK: Integer;
      cMnOAx_DeGI_DMWIZF: Integer; const kjGH_DusnQ_smLH: WideString;
      ISTE38: Integer; fZbxufw_mpWxYyv_ebTNx: Integer): Integer; safecall;
    function vIwITzUsh(RQSvjkm12: Integer; oYAvK_qcoqm_13: Integer)
      : Integer; safecall;
    function hvMEAEeyiDERvM(const cEsBVzU_rfQZgDt_oBNwfWI: WideString)
      : WideString; safecall;
    function xZeeArtlhtFhVrC(MnOapI_tFVIyy_63: Integer): Integer; safecall;
    function AUMkCWtNByIG(osILSuC_KhNK_14: Integer; ICfem_rzTj: Integer;
      TQFu_aPCYg_dHcr: Integer): Integer; safecall;
    function HxDptMJWKYRrwaP: Integer; safecall;
    function fpLXcWtoGo(SDFS_NqgzBrn_xbGIM: Integer;
      const KLMl_AvgCR_MVWE: WideString; wwSZu_SAFSDp: Integer;
      obBsjht_nQWbMs_LuaJU: Integer): WideString; safecall;
    function UvxaRvdWIntkh(hMIiQR04: Integer; const XfzDqI_EMIJP_97: WideString;
      ragQFP96: Single; AWUGV_fTyOIgv_dzBq: Single; dfOLiQj_ggdrbKv_81: Integer;
      BTMKjC_kxQG: Integer; XIvnDC_xYqognQ_87: Integer): WideString; safecall;
    function QKMS(VUfYdHB61: Integer; bFPYrOL38: Integer): Integer; safecall;
    function NJkRd(MKlMG_bLdc: Integer; BmqqNOK52: Integer;
      Ywwnq_twftL: Integer; pAhL20: Integer;
      const urjNL_vlCY_ylmSuM: WideString;
      const uoeFWIN_BamLhb_tmFE: WideString; aKguUM_nBGgIO: Double;
      zsVAc_XLJuHS_67: Integer): WideString; safecall;
    function iFacCwAIk(zErN_fCub: Integer; VdbE54: Integer;
      coNmrP_kbVu_34: Integer): Integer; safecall;
    function CLsZISPR(LDVd45: Integer; WfXjVn_yjpGB_94: Int64;
      cOQIOxF_aiCAp_JtRdH: Integer): WideString; safecall;
    function fygwKKTQsAsQ(const KCsrmHy_JYwcNF_HRqks: WideString)
      : WideString; safecall;
    function PbbmlT(Hzvrg51: Single): WideString; safecall;
    function fsuuF(const SBgC_GKvm_UCzvK: WideString;
      const bbzllh_jqlJCH: WideString; rnmB_kiqBB_dwBoDfU: Integer)
      : WideString; safecall;
    function HfWVubrjaP(dvFYptX_WWTBIh: Integer; PlZZrSR05: Integer;
      DQcqje_kddrpFL_20: Integer; uFaz87: Integer;
      const eIGB_XJaFTxJ_40: WideString; const UJjmrZG_cCgDg: WideString;
      mfoOsp_wdPKHI: Double): WideString; safecall;
    function HBFNNw(ihHimaM_BAeVy: Integer): Integer; safecall;
    function SZsrfKgpv(Jyisf_qujBV_64: Integer): Integer; safecall;
    function kurGPNymZtUjNnM: WideString; safecall;
    function QEMSsTFHbEZKaj(mYvsQ_aqdMa_76: Integer; noCb_rkOsc_18: Integer;
      umVFT_QTqqxCo_dBrWkSZ: Integer; kNkdU_DTxAwYz_sWmvhj: Integer)
      : WideString; safecall;
    function APDZPcR(WIrw_wWCq_pthTLl: Integer): Integer; safecall;
    function LnjbD(mbPibh_aJlTSMO_83: Int64; aRkQgm_rlBGJ_Srcz: Integer)
      : WideString; safecall;
    function iAKB(uHGnSO_wCXX_81: Integer; zmfyFYO_gGxLcS: Integer)
      : WideString; safecall;
    function AGgkFPCU(ErKTKtj_yyGHTB: Integer): Integer; safecall;
    function nEPmKjs(const YVvsd_sMaEh_35: WideString; const ioAw54: WideString;
      JhysQ_PyAuQ_JHFN: Integer): Integer; safecall;
    function wfLKJnEwo(NUDt39: Integer; RAQyWc_piJkQ: Integer;
      jbQy_sNPvsT_TaGFnS: Integer): Integer; safecall;
    function NhaMl(iuQnj04: Integer; const GjpEkJ_VDKB: WideString;
      rasqd77: Integer): Integer; safecall;
    function kGtoHbuTM(const OgjZ58: WideString; const hvex_hEOxk: WideString;
      const oWlk_tfcby_54: WideString): Integer; safecall;
    function BNQbwwnVV(jXDe_cWzX: Integer): Integer; safecall;
    function NtLrJiRlddM(hweq_fxIx: Integer; PkWAHUt_FXnBzNa: Int64)
      : Single; safecall;
    function zRKhZUgZceLu(wjtG_JSFs_54: Integer; eWGYFg_bKvjw_14: Integer;
      luJmRG_pKELk: Integer; OlUyE_Pomxcd_49: Integer;
      const AvYTii_RmjXl_55: WideString; const RuhIG_qGfjd_55: WideString;
      sAmlbjc_wVYZIKX_UBSIVPm: Double): WideString; safecall;
    function CuBWMdp(sdgnZBm_zXpnR_nzLlIep: Integer; lqgv_HKLhbk_MUdB: Integer)
      : Integer; safecall;
    function zMYruEiAEwY(RiOgsTX_PUYD: Integer;
      const QzhPRG_LlqU_OplW: WideString): Integer; safecall;
    function lyCoBRENZgC(ZNCrMA_XPEW_PNJrTE: Integer): Integer; safecall;
    function ZKgrVNarl(AhuAuzz_oUKhA_qwjYrd: Integer;
      xjzZBzZ_LtgeRWG_21: Integer): Integer; safecall;
    function GJIoicxslmxdQvQ(cjoox_erzEa_uGCKY: Integer;
      const CAXO_YAKrG_37: WideString; yxjexnf_BbNEx_ykNhWFG: Integer;
      const YWHuFXr_McLb_06: WideString): Integer; safecall;
    function ILUWrxoIxv(mlLPD_AmHj_vqhvG: Integer): Integer; safecall;
    function npMQqsycbYx(zVYtS_DlGvuED_06: Integer; sadm_psunO: Integer;
      NuwNhAa26: Integer; ZeZttF52: Integer; const boYIpme_EGqfryL: WideString;
      const MjoWXo_EPfxt_96: WideString; QvriBk03: Double; slAYjFM73: Integer)
      : WideString; safecall;
    function WXrLStnefG(const LLHu_crWrtgS_08: WideString): Integer; safecall;
    function RdCLLteJI(koIa_UkIJAq_94: Integer): Integer; safecall;
    function zUFrjTtmIAnRcL(bdMhbFS77: Integer): WideString; safecall;
    function QzMmMsXhNNtSxGk(bnbNM_giJt_Ptqb: Integer;
      jcVXGW_BhcDkO_58: Integer; mdQQitQ_BiNMci_TUvddW: Integer;
      GCqQki74: Integer; const OUsbxI_XRhQ_76: WideString;
      const lGkJpH26: WideString; ulEPGva_Qvgo_sFVkW: Double;
      const GNGoZJu_TrCmMX_33: WideString; bUfzr00: Integer;
      ZjCv_tfCT_wWhIjXs: Integer): WideString; safecall;
    function PysIjccvayTk: Integer; safecall;
    function aFWQVQvu(Bgxik_rXySvX_34: Integer): WideString; safecall;
    function SaVvNr(VaXQVK_QGit_28: Integer; const mycj_bbVgi_63: WideString;
      PbMl_coEmFOl_jqAF: Double): Integer; safecall;
    function PnqzLgGKf(jkMU_ixxP: Integer; PvGk_eXwORT_ZRbWsXg: Integer;
      ojDBx63: Integer; VGqRskD29: Integer; const OGEAq_zCajpYv_31: WideString;
      const YFsNNIO_nQRV: WideString; daatKdC_BsEgc: Double;
      jenHC_XOVj_rQpVjE: Integer): WideString; safecall;
    function nQZCZGfGUNa(wGDB_NihXYOK_11: Integer): Integer; safecall;
    function xtWpBdqMMxyp(rRdX_WxIP_59: Integer;
      const gEIlT_JRfyQfD_DGnVrqG: WideString; ZplA_GeZvXqJ_75: Single;
      jfKjiyd_WMnWzg: Single): WideString; safecall;
    function lKov(ZxWw_MjsA_BFuZZ: Integer): Integer; safecall;
    function upJGlDbfQXzAi(kjqtVjA_QHhPyMg_63: Integer;
      const hmLJ_MMtqSZf_taGj: WideString): Integer; safecall;
    function Qgkln(const BlOoq_CaUifO_47: WideString;
      const mtphMj_revmiAE_98: WideString): Integer; safecall;
    function jcXnt(mbRjwbE_KZFSpSE: Integer;
      const psZrlBM_AmuGUK_71: WideString;
      const jAPd_wixdRS_LfxTZya: WideString; wUmrUgT_wlybok_99: Integer;
      tKyIF_Sokn: Integer; RlkSYSV_zPZki_oOSkV: Integer; kQxkM73: Integer)
      : WideString; safecall;
    function rrNwvYIAeqhwfgE(const UcQWjva_nVHL_30: WideString)
      : Integer; safecall;
    function sXjUaFekoEKX: Integer; safecall;
    function CmfCzPIkckrJik(const mCYt_ySpBgCl: WideString;
      const qyKXYy_WLvRfM_oEEn: WideString): Integer; safecall;
    function drlzQZfrWCdocC(yrZI_MwuzhXx_eKpJuH: Integer;
      var TlPmGD_wylpV_56: OleVariant; var RlEYGtu_yJJzOh: OleVariant)
      : Integer; safecall;
    function iRFfULVlKj(YHxrX_olOxt: Integer): Integer; safecall;
    function WvAIHjpJknPFR: WideString; safecall;
    function QPRbG(bdXP_XAEt_nkpgHCE: Integer; VoAkNTl_BpfGD: Int64;
      MnJlUnY_AYuiKj: Integer; const ENCvI90: WideString): Integer; safecall;
    function nmcGkSdggTVtg(dpzELeH_rCZtv: Integer; const WhReKl52: WideString;
      const xQTmffK_mNXKGO_30: WideString; tnczbhH_wOGZke: Integer)
      : WideString; safecall;
    function ittPYzBERKuhh(BZpd_BMZiZ_86: Integer): Integer; safecall;
    function dUSlsVEKouIJJWb(const QmAbsOX_MuzZmTB: WideString;
      const jganEC55: WideString): Integer; safecall;
    function FxhPYwh(RLSfZZy_RcZB_XMoPNcN: Integer; vgId_TlDR: Int64;
      Ibxg_QmwpR_scWQj: Integer; BvJbse_XQCM: Integer): Int64; safecall;
    function wuuwAMhWyjJ(const nvojth_ZVVC_42: WideString): Integer; safecall;
    function ncFhsK(Uogb_MVDkfC: Integer; OAqS_ISkcu_46: Integer;
      WTFOl02: Integer; zpES_KuzT_ASMUu: Integer; QLjf_iQaf_ATsFY: Integer;
      const TsZDe_Lnngw: WideString): Integer; safecall;
    function UHVxUguUxIC: Integer; safecall;
    function DNwZKDzoatLA: Integer; safecall;
    function rWynQZk(sTgLUY_NgHSd: Int64): Integer; safecall;
    function wsyJ(const bdruc_sTHG_47: WideString): WideString; safecall;
    function tFzLoEqrmvtW(KaoCae_OVmAczG_bcCdamf: Integer): Integer; safecall;
    function MHLSThNeHkC(const SliIEa_XxlXmG: WideString;
      const jkmDRM_hYfqzLl_TKftX: WideString): Integer; safecall;
    function TAvtmpJA: Integer; safecall;
    function XzbenJdmgJdhzZQ(const TwnyHmR_CMdlS_qFuw: WideString)
      : Integer; safecall;
    function ZRkau(FmFjRFk_EZPx_CQhEtr: Integer; nnGuOR_Oyql_16: Integer;
      ojgY_SpCLWDH: Integer; pYVxF50: Integer;
      const uXoHYk_OFCS_Zidaku: WideString; const bYuo50: WideString;
      RAIDLo41: Double; NyzoDb_TRYHLTk: Integer): WideString; safecall;
    function SmMUDbmvIHZW(VbEVwF_YwUz_49: Integer; SzVPpb_XRMU: Int64;
      NJlKn_VBjnBav: Integer; xlwzro_RGZa_PDWJvYd: Integer;
      Nkaply_VyzUdd: Integer): Integer; safecall;
    function WLqPNK(xSTRvp_cwarB: Integer): Integer; safecall;
    function NLKEIYsUuqMoApw(const kOdXE_sCFN_uZlY: WideString)
      : Integer; safecall;
    function nHqG(jtIm_YQRQ: Integer; diiD_hROX: Integer): Integer; safecall;
    function yZEeGDnoBJUG(cRqnNb_EPCl_VzlP: Integer; vsRRxjQ_JXqWFj_88: Integer;
      const nnANEVV21: WideString): Int64; safecall;
    function enmmArpgmLWUR(BuDygNz_vxYpT_92: Integer): Integer; safecall;
    function NwXjh(const zDGU_ujIgoGt_URYR: WideString; foMtyB_iFln_26: Integer)
      : Integer; safecall;
    function zIxDAda(tihZQBY_sctZ: Integer; wwHMYd_zavSR: Integer;
      voZFVk86: Integer; smgfiqC_VEDoBV: Integer;
      const ipmZNz_SWpVX: WideString; Dvmxa62: Double; bNMd_HgSFJ_99: Integer;
      out Dmxe46: OleVariant; out ERhFEA_ksOd_58: OleVariant): Integer;
      safecall;
    function AvTkgVtuc: Integer; safecall;
    function nJKSrFANNdrjA(rZwYaYG74: Integer): Integer; safecall;
    function KahwMccxXlZWJdX(UniVaPQ58: Integer; yKvEj65: Integer;
      mhDoIZl_FgXxL_oOWiQH: Integer; PYQGPvD19: Integer;
      const srPH_ivjv: WideString; ErzWV_jvhXE_RKuGcf: Double;
      DihY_XWpvR_11: Integer; QsWsIpH67: Integer; ZRaonrM24: Integer)
      : WideString; safecall;
    function BXGIKg(KmgLE_vhTckHp_18: Integer; JgsEWRb_QLJeHTU_41: Integer)
      : Integer; safecall;
    function wgkwlwgu(hpiK_qdrDtZg: Integer; const xVFWPq_kYKD: WideString;
      kyYE_lypZTu_15: Int64; YAvRoPS79: Int64; VZCO_KDAf_ysOb: Integer;
      rmHN_jggWw_FrtMT: Integer; XFgoFGk_kgnoNBZ: Integer;
      sGDKGzq_OOivdi_75: Integer): WideString; safecall;
    function jyEYiVMXiFjBUW: Integer; safecall;
    function KqdwNps(qYTpc_SjMKrZ_68: Integer): WideString; safecall;
    function CCgQMrvmUvrwQh(const XqgzZ_nSScR: WideString;
      const pPKa_TgGZy_xmdvsV: WideString; const OykUxr78: WideString;
      const SrtTh_DCohEx_75: WideString; const fzZytj48: WideString)
      : Integer; safecall;
    function NdQkPMPBgLo(VmBOY17: Integer; const UHdmol88: WideString;
      const zPQKK_aaRy_65: WideString): Integer; safecall;
    function dUbtEzxGlrAYR(HAjFT_LfwgmcP: Integer): Integer; safecall;
    function wWIXNhYqJI(jkmtJKS_OJJLLu: Integer; gpyMv_fgwbD_VAsfeJZ: Integer)
      : Integer; safecall;
    function aSvIJbik(qmtJya_LBEIns_99: Integer; twpKbpC_NZLnE: Integer;
      IeeOEh_GBnF_61: Integer; jlMw_AqGLV: Integer;
      const yuaWyO_LQMOQ_50: WideString; const XPfG_pWMh_10: WideString;
      MSnzdj_YszU_zogZf: Double; const fsOIF_HIIln_gemg: WideString;
      AOnrYh_lumWqd: Integer; Yhjsr_yOnMxJ_84: Integer;
      out USonNn_rtCqvUZ_00: OleVariant; out oIloAY48: OleVariant)
      : Integer; safecall;
    function FgZwqKQZ(GEHTS60: Integer; TcAle_cnqHFTZ_67: Int64)
      : Integer; safecall;
    function vDydcMN(dfSG_wWRdc_49: Integer; const caEz_IosbR_wdegh: WideString;
      KXvBZa04: Integer; jnJHc82: Integer): Integer; safecall;
    function lJkEJU: Integer; safecall;
    function KvRfGsKhDjt(Tovfpp20: Integer; REnXgW67: Integer;
      abrk_AxHLOay_36: Integer; EARBN_znREsyJ: Integer;
      oLeRyA_laQd_dAIyGVK: Integer): Integer; safecall;
    function biISsaTQgm(XfhDXZ_NtGym: Integer): Integer; safecall;
    function uxnLC(const pchX_SFqJA_xDle: WideString): Integer; safecall;
    function RDTo(XnhPM_Nixe_hxwe: Integer; WLnNHo_EekKEW: Integer)
      : Integer; safecall;
    function VAPj(GQVu_cYuzX: Integer): Integer; safecall;
    function rGQhFSDUoLp(const zGTc81: WideString;
      const RdATop_EDjkI: WideString; const wKOVwt_uuVO_lAii: WideString)
      : WideString; safecall;
    function nFrbXhzNpmGB(vcHdzB_GCVpL_ZiaokHm: Integer): Integer; safecall;
    function BinBmj(cfVxF_TEvYLm_34: Integer; zDaeERa_caoWyoI_07: Integer;
      eNyaOu_VwYb_SLxATf: Integer; QSHS_ASGXoxo_dskPoRR: Integer;
      out NVHZw_LzYDdS_QFlyrT: OleVariant; out xKtNGd_JsACa_15: OleVariant)
      : Integer; safecall;
    function XHqrxE(const snrOh_wrdMN: WideString): Integer; safecall;
    function ZNAELdSZNbgqAw: Integer; safecall;
    function MMdquvGECxLLbqT(XnfyG_Hapwb: Integer; TdfiT_mfNbOCv: Integer)
      : WideString; safecall;
    function DPuTHAf(const qsTPZJ_fIEW_tECaSwa: WideString;
      KdZxnO_tDVl_22: Integer): Integer; safecall;
    function rIHaPE: Integer; safecall;
    function kTzQkbfrPJG: Integer; safecall;
    function YkNyHbgycUikytH(iCZsmj_HPmIL_OeHL: Integer;
      const TpdLE_POAsVD_AjmiQNY: WideString): Integer; safecall;
    function aMRwfhwsVkk: WideString; safecall;
    function rWJtaXQMDSh(const UvOEh_wRMxCm: WideString; GLqBRJ_euvcW: Integer;
      utAz32: Integer): WideString; safecall;
    function nXTKTNlojUla: Integer; safecall;
    function XqgAZZNz(const SIFoW66: WideString; MfnZo73: Integer;
      out NDIWbr_eLwrb_VhFHC: OleVariant; out nnqCxs25: OleVariant)
      : Integer; safecall;
    function mFmdfkqJK(XpBUD_nKQWBwf: Integer): WideString; safecall;
    function cQnqzGtc(TaKXA38: Integer): Integer; safecall;
    function uAZa(const IvWuEw_Rqmnz: WideString): Integer; safecall;
    function hMsbVbNqx(const RKhnpY_DbWWD_ZjxeKqY: WideString)
      : WideString; safecall;
    function FvpxRv(emJhH18: Integer; const mHTQRN_ruXY_79: WideString)
      : Integer; safecall;
    function webcNfzF(tYJl_rvvzvEv_DXPvfM: Integer; giNOoq_SHYeEN: Integer;
      htzrNig_SlfvX_RMKoGFj: Integer; const VkXwaFe_FDqNhw: WideString)
      : Integer; safecall;
    function ExSsaGI: Integer; safecall;
    function gLyfPMYcHlksCE(SZZyoB_ugSa_08: Integer; FYlw_jWoL_06: Integer;
      const PXeMXZI_ccMri_CzyXJcR: WideString): Integer; safecall;
    function mCfR(const palpGZ_uarWr: WideString): Integer; safecall;
    function NyJHEHQ(baTZaW_oEuXR: Integer;
      const KrTXFos_vNlFA_YYJHQqf: WideString; kDdGpf_RPpHl_WHEJR: Integer)
      : WideString; safecall;
    function rdgWuYgBDEzn(zISqd_PXIGlzB: Integer; bsTxIG_CxJegR_wnzA: Integer)
      : Integer; safecall;
    function owEYUcjQ(BuFxjr_VlFJJW: Integer): Integer; safecall;
    function hcLkq(IAAy_GPWz: Integer; const hBVlX07: WideString;
      const uRhfrc_DLjyz: WideString): WideString; safecall;
    function WmDUrdvzvx(const RRGH_YgrVMrG: WideString;
      const PYkEY_CBhaE_QZaYHYv: WideString; const gVHcCv_VwzIYga: WideString;
      XdccS_fHToS: Integer): WideString; safecall;
    function wikkNPr: WideString; safecall;
    function LwaUtJt: WideString; safecall;
    function KTSMK(TCkWanz_prcBwb: Double): WideString; safecall;
    function rEZzpBQB(BuTEz_EjUFn: Integer; RANf_GgtLzZt_SkuBhdw: Int64;
      lShpgS91: Integer; BUwPuY75: Int64): Integer; safecall;
    function KyYIywoLGscTIU: Integer; safecall;
    function uqqXGk(negDw13: Integer): Integer; safecall;
    function rBBnMBIpFPk(JZDw_rOodU: Integer; xUeV_eKspq: Integer;
      Zinkyu_qdBjHaA_33: Integer; const NePZj25: WideString;
      const nfzOFPG_TxNWyi_43: WideString): Integer; safecall;
    function ykKY(eqgSrjP_bNwS_KOTuzqT: Integer): Integer; safecall;
    function DDGiUcEHkwtZa: Integer; safecall;
    function TpHtMErvJCKK(aqRbQ_woNYUHx_Tvsmmx: Integer; HGcxny65: Integer;
      lFoYTlB_Zuzp: Integer; aOoxDfF71: Integer; const LLAqUQl81: WideString)
      : Integer; safecall;
    function zXGewcRjrlXKfo(kBBVVcp_hQXmm_68: Integer): Integer; safecall;
    function HtljPtfkT(const ySGD40: WideString): Integer; safecall;
    function AkCfQQnYzF(Ysli_CaXrK_LhaTrN: Integer; KZzPp_rGqTJQT_AwODc: Int64;
      const sJOz_OsIAv: WideString): Integer; safecall;
    function pYop(LMRHRO_nsbwr_bhnWj: Integer): Integer; safecall;
    function VHfJHteo(GUrH97: Integer; lqzd_PcRjEzT: Integer;
      QseD_gXZJpPT_67: Integer; XynS_pRZZkwO_94: Integer;
      const CcgQ37: WideString; const gvON96: WideString; oazjpY25: Double;
      wZXPqzi_IhndoeZ_UZrnjOg: Integer; out KUmj58: OleVariant;
      out oFZL_dqNiD_08: OleVariant): Integer; safecall;
    function tNUnrzkdeClBnl(YIcM_DakR: Integer; QSsmCYD55: Int64;
      QNNvPY_MeWlBx_cgteSe: Integer): Integer; safecall;
    function wwfBwhV: Integer; safecall;
    function WKDvQweebkvjHW: WideString; safecall;
    function bNRzdqa(ZowkBd85: Integer; out yIgLE_UbgBd_26: OleVariant;
      out EgkqAH_ZEhb: OleVariant; out lMeaQO97: OleVariant;
      out YJZsgMl_satZSCl_LLVz: OleVariant): Integer; safecall;
    function vhtjEbma(jDKXzn_cGiNxZ_yMMST: Integer): Integer; safecall;
    function Qwdmm(ibyGlYj_jojQM_87: Integer): Integer; safecall;
    function ELzgHnRb(foVn86: Double): Integer; safecall;
    function qNCUG(cILdKqI_JVzlqdI_38: Integer): Integer; safecall;
    function xwvgvjz(PwjIATJ11: Integer; gYFXxz_mGIVy: Int64;
      pXbWTEJ_dIjA_pixPzN: Integer; MpKa61: Integer): WideString; safecall;
    function NhJpGyhIpydJ(VJtN_byUAHX_UMuw: Integer;
      const fEDjnkT_whLrN_74: WideString): Integer; safecall;
    function grDs(AapEOzz_jMaToWT: Integer; const WbOcJ38: WideString;
      const lYWUZg16: WideString; aBpzY_rAFKD_TMpWzwb: Integer)
      : WideString; safecall;
    function FfRmNvRjL(const cCdISq_SwkMR_NZhe: WideString; JWZiGj00: Integer;
      awDV_CLtJ_60: Integer; const pQVRTu_yTXAW_AGsjTQ: WideString;
      WvCX_qostFA_00: Integer; NwCF_PJCgsTz: Integer): Integer; safecall;
    function nsrWFBZHwVfHg(Oduo_TsIfCP_26: Integer; uRVa_zSTpOP: Integer;
      yauizrS_RGhH_81: Integer; psEGgKv_dkNXu_QToOez: Integer;
      frMCzq_xWjl: Integer; const bMbw_umNDF: WideString;
      anitqi_tJxswn: Integer; oqhmK_xvguq: Integer): Integer; safecall;
    function YHPfrQAUSM(gdXGHiU_sWzCKvt_60: Integer; tzIZjS_hLLBiki_15: Integer;
      Nrqc51: Integer; mdyk26: Integer; const IiKkJr39: WideString;
      nHNHSl_ilCjaHa_30: Double): WideString; safecall;
    function ikLcLgpefCU: Integer; safecall;
    function adpUwvwRXq(const pAGGV_qChcz: WideString; kwfX_wiisvEn: Integer;
      tnlRl_dgBnzr: Integer; const nvEUC_biuRIaK_VSQbCTg: WideString;
      qBgep_XEjXDd: Integer; uqeUh_TCdQtK: Integer; bYzvNhU_itzJ_79: Integer)
      : WideString; safecall;
    function MjPIPkFwPoCm(AUZlv_dHWx_mkYe: Integer): Integer; safecall;
    function vhANnDlgMb(const IFRG94: WideString): Integer; safecall;
    function vkgIGiWLxMwPWM(const bDNl_RDUy_OUwm: WideString): Integer;
      safecall;
    function xhaEMSj(omRQe_cLnNog_wQTPg: Integer; uBncxt56: Integer;
      ymkFJA_OgcuX: Integer): Integer; safecall;
    function zxFfXNqGwPrEEyy(WCqcrR_eDCsfz: Integer; KHUSPv_TGku_49: Int64;
      eqepi83: Double): Integer; safecall;
    function YsHPznLkVndthxP: Integer; safecall;
    function CaHhXpE(JDymrBs_FVCa_42: Integer; jpsVCg_Grha_23: Integer)
      : WideString; safecall;
    function WsXrqN(const OyfxAV69: WideString; const UlEKVX61: WideString)
      : WideString; safecall;
    function arpieUV: WideString; safecall;
    function ZSLyETTBXofw(RLNMskc22: Integer; lMBV63: Integer;
      tzdzZox_yvYXNP_00: Integer; RUpc_Nawi_lKxD: Integer;
      const Mrlpa23: WideString; const haAjkZO_koGAGkL: WideString;
      EeEyyMl_lOvI_ZMcXYs: Double; aRwEY_yvMFZiO: Integer): WideString;
      safecall;
    function ZEfKWxJTFSA(nRuSoe_qswfzOu: Integer; ULbajMq42: Integer;
      vzprqy_rTVs_85: Integer; const yIIVUDx75: WideString;
      const foOU28: WideString; OEPO_pmMUog: Double): Integer; safecall;
    function vTSqTHXxWMrZ(tQmGs_ftEJlk: Integer; KQOmKp22: Integer;
      wxVBFOv_vzAVAS_wGcH: Integer; fGZnd_MurnoP_56: Integer;
      const gNdkPqb_qdGWRz_93: WideString; const yuTSHzT_lHFD_51: WideString;
      Hxkf_HCCSds_ANETur: Double; out zjoVQ46: OleVariant;
      out ZUjkhk_hiATMs_56: OleVariant): Integer; safecall;
    function JqYxlsaWAvoAyh(const ZAToOfT_bYVloEK: WideString;
      PLsacoX_RBNEV_aVwSb: Integer): WideString; safecall;
    function TDUhmEjuEjSKCSf(hxyBVB_JKUpx_78: Integer;
      const IFLaRP76: WideString; const LgBV_puLFhVA_04: WideString)
      : Integer; safecall;
    function XZPNYlLEboj(pFCEQY_RMnin_SSzys: Integer): Integer; safecall;
    function vbHCVzFpiEvgF: Integer; safecall;
    function pdEyCeYj(vLYlh_nKFuyt_wvraRNG: Integer; ndEBMs_ALESZ_Fwonw: Int64;
      const yajtRS_VaaxoM_nrXcuIP: WideString): Int64; safecall;
    function DwejdWvmfKpr(SZmIkKZ_nnXfEJa_MimV: Integer): Integer; safecall;
    function PIBUkDuJJd: Integer; safecall;
    function XQAhvBiRIcXl(const IZoUp_UtVGaE: WideString;
      RbYKP_pABZdsh_60: Integer): Integer; safecall;
    function DaKhHXq(const jRdZOav_nIRW_51: WideString;
      const OAvbrbO_JoGJfWA_48: WideString): Integer; safecall;
    function QqBASYp(const gAKh_VnLu: WideString; wfFm52: Integer;
      out fUgbr_xxQmTO_tBOWzY: OleVariant; out EWRp_MwxoM_FZQcCF: OleVariant)
      : Integer; safecall;
    function fPfWUWEkB(BjYr62: Integer): Integer; safecall;
    function wHTBbkFiABdaf: Integer; safecall;
    function gcyZAtb(const weYU_MbciQjg_85: WideString; uYXLc17: Integer;
      bynxGl_vRvM: Integer; teiD_SlJv_NJxJ: Integer; dmQgZ_QzOF_57: Integer;
      yAzPvP_IXemj: Integer): WideString; safecall;
    function YbIkPusA(sYBSpD_OclxK_EMSXrJg: Integer;
      const UqBNl_yCPv_VUOA: WideString; const SWlF_UNbR_49: WideString)
      : Integer; safecall;
    function AnIPWsAjdTI(iiSLa_wqCo_Muxfi: Integer;
      const DJEQNyr_IYEG: WideString; const xeKVNa_skwsQ_46: WideString)
      : Integer; safecall;
    function CKaxgbULZApBQu(FGjV37: Integer; rYQbG_SfIjP_aoYkmZ: Integer;
      FoviBZM_vnuAgCM_GLEho: Integer; LOiu_DEqiCeQ: Integer;
      const XdHF_EqYxaS_31: WideString; JZvN_JsVxN_72: Double)
      : WideString; safecall;
    function MZHPFi: Integer; safecall;
    function zDEItHqZj(YIbIMJp53: Integer; const vIIll43: WideString)
      : Integer; safecall;
    function ZZCwmxbkrzbp(const FgdRAsj_RfyA: WideString): Integer; safecall;
    function AEHy(const MQpPmdn_cPOVV: WideString): WideString; safecall;
    function pidiLPkPGN(brKc_mPjbK: Integer; neEWyEw00: Integer)
      : WideString; safecall;
    function iZyLlwMU(HIiDyw_esKukIQ: Integer; vIBspef_WTnDSY_TZdzbz: Integer;
      KCZgMW_Dtued: Integer; jgKH_tBiyLSR_36: Integer;
      const unmM_iARPOVm: WideString; const VkxGpxt_alTVN_94: WideString;
      evjlXUz_ADHay: Double; const JZEQfnM_gMsbGlP: WideString;
      VaRVv_ITTI_10: Integer; DDWmtH_fwGahxY: Integer): WideString; safecall;
    function ZVEgKSBPF: WideString; safecall;
    function NLWkeHsy(const Jifc40: WideString; const Uetyx84: WideString)
      : Integer; safecall;
    function jfzlaRPUtHZwzp: Integer; safecall;
    function TNgMhtRIS(const vZcbP_Xluy: WideString): WideString; safecall;
    function oLPcrnQnbxa(pfBEH_uNZZFn_FaBBj: Integer;
      out pNBCE_PpiIB_kaSdD: OleVariant; out NFvrHd12: OleVariant;
      out kFZlc_EDebwhN_62: OleVariant; out AtIg56: OleVariant)
      : Integer; safecall;
    function FkmWFNFzqp: Integer; safecall;
    function KQSzhh: WideString; safecall;
    function HsmUiHGTcqmBzyF: Integer; safecall;
    function wrzsy: Integer; safecall;
    function NhrxYkNlVHFaRvB(Pgwt29: Integer): Integer; safecall;
    function tUtpGelWrB(gTFlYPW_TIVNC: Integer): WideString; safecall;
    function LaJRYMUI(jyJeSDC_ICEGiF: Int64; UASJ21: Integer)
      : WideString; safecall;
    function SYJH(iJiOg_vNiNQ_JOni: Integer; ZAKM_KrClnkD_43: Integer;
      wJJsi42: Integer; MXAbxQO_klRX: Integer; const afXwSAf63: WideString;
      const mcmsp40: WideString; fRobKst_kplkeCE_ZjZg: Double;
      jEPOe_NGWXV: Integer; out hDuSY72: OleVariant; out UhOKGvm06: OleVariant)
      : Integer; safecall;
    function EHaUtDelrc(BbnOpu45: Integer; ubAJWMo_ObmG_68: Integer;
      zgCgDwj_DwbhNu_04: Integer; XxnfNsM_caQGfsm_JSos: Integer;
      ilIRI26: Integer): Integer; safecall;
    function VXEtISYeVGWuTfV(JhmMCn70: Integer; xjaWmm_LcXBk_38: Integer)
      : Integer; safecall;
    function lYWBts(mNiy_DGfQdeX_83: Integer; const cplxrSs_rjWnn: WideString;
      ZxpQFsP91: Single): Integer; safecall;
    function KdBmwAomBy(yuQSeS_yjiut: Integer): Integer; safecall;
    function MlgjJQEUA(tAGspmo_VgZDBR: Integer;
      const Vdmx_xjCxBWg_79: WideString): Single; safecall;
    function cuMrVoMFydnIU: Integer; safecall;
    function ZAZWf: Integer; safecall;
    function XrBZLMhRE: Integer; safecall;
    function MESAr(YNkpF41: Integer; const sPJQ_ZYIf: WideString)
      : Integer; safecall;
    function ImZpRrYwIJCs(const gCCb_akGuuU_78: WideString;
      const WGBve_fsnLKUl_76: WideString): Integer; safecall;
    function PhweWsX: Integer; safecall;
    function jlYhlkCHG(vjPStf_PeelZE_dwFwE: Integer): Integer; safecall;
    function BKTocmNnnHIN(RPkgd_ENgUC_YpmS: Integer; mxGB57: Integer;
      iCUf82: Integer; ZbNH_YKVP_ceefRQ: Integer;
      const dypyJp_cjmZMgL_49: WideString): Integer; safecall;
    function UPvltYYRDtekbG(RnHt_nHFiR_IskK: Integer): Integer; safecall;
    function qhyibeMUS(iZPm_kHEKnL: Integer; vhsFM_FueFmPd: Integer;
      lzMJ_sitbldb: Integer; ufaYIFK_rYRWxa: Integer; const VOUVG26: WideString;
      gORjmy51: Double): Integer; safecall;
    function RPltbImeRNe(const HDfIxK_fXoX_36: WideString): Integer; safecall;
    function vcWDYEmU(const QIPHowA_dMqEqOc_69: WideString; jZqZ65: Integer)
      : WideString; safecall;
    function uAbw(const VCyVSK98: WideString): Integer; safecall;
    function DUVZpuY(BxjAsAI06: Integer; UdUn_mJOUJJH: Integer;
      VaKtvhT_fsVkdLW_29: Integer; reYPbR73: Integer): WideString; safecall;
    function fKsz(IcckWY56: Integer): Integer; safecall;
    function GgXGkUIvJUCoA(lepuejO_wCPU: Integer): Integer; safecall;
    function XyTQBygoV(EznIuKQ24: Integer; xGcotFF_kwANWJN_24: Integer;
      tFPGn_xsLTb_urgEFL: Integer; qNwjdXp_nRbaV: Integer;
      const GDZRSao34: WideString; DBmcef31: Double; mUeB29: Integer;
      out SoUz71: OleVariant; out wUWDiTd50: OleVariant): Integer; safecall;
    function EPCH(const RwAQC_NHyKcTd_EUJgZE: WideString): Integer; safecall;
    function tMlB(const yzAbA50: WideString;
      const japg_Idmwxq_nyeZME: WideString; const TiBlqm51: WideString)
      : Integer; safecall;
    function fpvAmERN(aUnxZ61: Integer; quECXP_cgoBTCu_mCvr: Integer;
      afhdsCV94: Integer; IJCnnbO_tzAf_88: Integer;
      const Arhtq_fMUf: WideString; const bfduSAy_uhCNV_19: WideString;
      sQpeQmr_UcHclqh: Double; out JEXca_iXwRH_uqzhoK: OleVariant;
      out XAJmJec_OjMKmtc_48: OleVariant): WideString; safecall;
    function xgccZAblYh(const PwTMNTo89: WideString): WideString; safecall;
    function AvVnotMyMED(qqzwMPR_xQVoi_86: Integer; zTpSD_zmVtoob_98: Integer)
      : Integer; safecall;
    function twNbcTaVrX(lmxZ_OLpq: Integer; eLbjd64: Integer;
      qyKT_hEbyAB: Integer; CkUtEiB_idfNdOa_80: Integer; mbyTUB_sKvHz: Integer;
      const BYKga88: WideString; const pSsFsa_kumCirO_MYLNW: WideString;
      WxpRu_OImOC_VtMxB: Integer): Integer; safecall;
    function JxCue(lLskv26: Integer): Integer; safecall;
    function HGjZcPSfPUboAI(PMZZl_Oobv_14: Integer;
      bpTrSYC_KPXZZmn_fzBtM: Integer; JFqkcRY_Klqg_30: Integer; fuMN11: Integer)
      : Integer; safecall;
    function aQTT(const JycX49: WideString): Integer; safecall;
    function JeGWGvUXIwlZ(LpalZD_msUYb_yJgM: Integer;
      DgdjNo_pLYCbDz_IkudoE: Integer): Integer; safecall;
    function ZUwaUKua: Integer; safecall;
    function nPhyPsyFWRgo: Integer; safecall;
    function FcktPpuSzYc(dLpTncJ_ANuODqC_IzPKX: Integer): Integer; safecall;
    function HWGxsVwyD(mFoEyOJ_BXanD_ZqVIqM: Integer; PCpR05: Integer)
      : Integer; safecall;
    function shXNhRmUxEaVR(OsMlPRH_YryljcV: Integer;
      const rWajNz_CUhh_00: WideString; vYLkLD_dPmnmvd_eNIW: Int64;
      wyeSyGS_WoXQSd: Int64; dFhqdsu_ACgrhc_HGgXL: Integer)
      : WideString; safecall;
    function NiaeRHEdwAzgQtx(liORfZt_ipVbrn_pTekIaz: Integer; VHGfzbB73: Int64;
      ZRVHl_lhaDcKU_08: Integer): Int64; safecall;
    function YJfxPExQY(RTgvX_zrJP: Integer): Integer; safecall;
    function ZkLE(FuuFB_KYQHCy_CXokAHz: Integer; knyfFq_pZVHYd_10: Integer;
      gBSjeGf_owxU: Integer; uYRFcNR_ZYDh_PDyx: Integer;
      const CXZVA_eULYxu_GgpylaB: WideString;
      const jZlBvOp_NLRGaL_DkMlSDS: WideString; ruYNpPf_XRQN_64: Double;
      uIWH_MDYI_75: Integer): WideString; safecall;
    function xVRBxy(tAxl_srRoV_12: Integer): Integer; safecall;
    function TuKkNmRqjnonABG(TrqVvLq49: Integer; VYnt_nJCdS_53: Integer;
      ldxFcKV_oCGuuN_vbAjc: Integer; MSjM_BiisLz: Integer;
      const LsVUa_PlsooAX_04: WideString; const iUnaHf_ycmGO_hyVd: WideString;
      vTzHP_uLUxGkv: Double; wjpYFLd91: Integer; out ovPdV26: OleVariant;
      out hwwe_SCbfuxa_93: OleVariant): Integer; safecall;
    function iNxYpfefxm: WideString; safecall;
    function zogzHFehJQgQUMQ(meKN71: Integer; JxhxHc_OFJNZyR_nSXs: Integer;
      VEoQ_GYGOvTN_12: Integer; liiUek_Xcfdtzz: Integer): Integer; safecall;
    function SfPv(const xtvoO_tuYC_pHMVQoz: WideString;
      const EXdmg_ptIHgWZ: WideString; const brQK28: WideString)
      : Integer; safecall;
    function GXKLW(nQwG_yfRPqD: Integer; WIHY_CsUrY_YtPpHcx: Integer;
      MgRYA11: Integer; IAKFuBb25: Integer; const KxPMjN_pAPO: WideString;
      iWxV_RfcDIEA: Double): Integer; safecall;
    function LqxpMWux(uprbcL99: Integer): Integer; safecall;
    function XEzYS: WideString; safecall;
    function YFSN: Integer; safecall;
    function TQAfh(const qVeR_lhJHntZ_23: WideString): Integer; safecall;
    function xpUtzYdsvPxVRSU(KzoUfuQ_zFhXWyt_naxSz: Integer;
      uQqHGxi_kFfmzB: Integer; vJoy_PqHz_15: Integer; vmPW74: Integer;
      const pIRcfzI_MhzQnbI_iZwE: WideString; QlanL_RNDWnQ: Double;
      TQYY25: Integer; YstJF_ZvOVmN_HYiKY: Integer; CznMrY08: Integer;
      out gdvY_tdaj: OleVariant; out JiCj_bbykE_98: OleVariant)
      : Integer; safecall;
    function gHChKPAbDQ(XqZr_IIzMsEl_84: Integer; LLmqYh_bINOPI_77: Integer;
      neuMxPX_iMfDUx_CDFqZh: Integer; JkNnm_WNEcBb_zMyr: Integer;
      const cpdhCC_oOCfG_ZMaAN: WideString; SwfuZ_PlQprDt: Integer)
      : Integer; safecall;
    function ZBkBxlawS(ACJct_JyUW_12: Integer; gKzIS_UMipDL_SRVopU: Integer;
      CktWy_RxLXI_31: Integer; DkvSHC_cUpwTY_rCRHB: Integer;
      const ByglT_BMkDa: WideString; zhXH_jmGUjdq: Double;
      ynWcc_bJGeTF_vOuZQuP: Integer): WideString; safecall;
    function alXeQNkYgKNfKUK(const RjrhzvA_eIZU: WideString): Integer; safecall;
    function tFZPIwzfL(const SOJPA_hfJopuv: WideString;
      const ClveUQ_mkYmGDC: WideString): Integer; safecall;
    function MHAyaviaf(vhnwu_QvEaqz_PqMCm: Integer;
      const VxgQ_uYEHAe_97: WideString): Integer; safecall;
    function HWCKwbSzU(const uemNQz_AhhzO_Wgsomxl: WideString)
      : Integer; safecall;
    function IIZPyKJURbY(kaEdn_usGU_issOLvl: Integer; ZShs_QbYnTHD_79: Integer;
      eDbCWGB_Uipw_51: Integer; aMUniKh_rECIt: Integer;
      const HafVLfv03: WideString; const IFljcWF_wolxb_QcTvT: WideString)
      : WideString; safecall;
    function TXfbVafJi(KkoMnL_neKZL_42: Integer; const JWyykGJ48: WideString;
      const heaHao_DInvhc_33: WideString): Integer; safecall;
    function JgQXxXXzZ(FiKTeN_pIDPd: Integer; const qCisHM_EWQUA_51: WideString)
      : Double; safecall;
    function eQrjv(YRvgud_cqhW_DSbvQ: Integer; iHYKl_YLMwUF_sfBom: Integer;
      LRHR_AhThAfj_PlEBu: Integer): Integer; safecall;
    function BuqoRPhqAeNdQH(const jCnIUL77: WideString;
      BmLOMWU_phpAo_13: Integer; VEuL46: Integer; dCCm_SVIKo_37: Integer)
      : WideString; safecall;
    function kVyAekLKR(const sncMzd11: WideString; const AWYQ03: WideString;
      const Kujgs_iyfCd_30: WideString): WideString; safecall;
    function AfAZCe(IQKvy_xXUozjK: Integer; jvWam_eBUj: Integer;
      mHvK_AQzgz_80: Integer; jIOMh_zYEQW: Integer;
      FObHiZ_bGLFDud_FqJa: Integer; jQzo21: Integer; paJe_lPVYxeU_51: Integer)
      : Integer; safecall;
    function LKrehaGyEFkQHk: Integer; safecall;
    function xtiPiiPFPxiJ(DyIVfkO_ZPmoCNj: Integer;
      HRjLDlZ_svmIlM_RJALrQj: Integer; pjVliZ_QxqUjgZ_TLCyfxY: Integer;
      pInYxtS_RVeHe_WNod: Integer; const ipQqZ_OBlm_qygPX: WideString;
      QRTa_DDkOxY_99: Double; IUHjE_MTxtopD_99: Integer): WideString; safecall;
    function PyuYJGZvDhbFE(makcRrz_Bwvp_20: Integer;
      const LRYVsFZ_NbGoc_34: WideString; CNIZ_nLWvMp_81: Integer)
      : Integer; safecall;
    function zUowz(rgdK50: Integer; yaUBmb_GszicK_AbGz: Integer;
      hyWFnEb_EvEYhxJ_44: Integer; rsadWuj_BGvJRM: Integer;
      const AvTmCCn_MqgAH_52: WideString; const biuQ_YPaZrMB_qZFx: WideString;
      CDqUiFK58: Double): WideString; safecall;
    function fWKDSWBAzfBmV(hqjHqJT_GASzV_xJHyN: Integer;
      out iEXATW_VaGq_PluMz: OleVariant; out uNjkMGK_hARrwO_KcIuF: OleVariant)
      : Integer; safecall;
    function xQYGmv(const snlKP33: WideString): Integer; safecall;
    function DpsFjfKYdgTzg(BaVeE_RCNHQH_QUjm: Integer;
      const TAEaVl04: WideString): Integer; safecall;
    function rjgIwCwQXrRY(hGCQW_Worthmu_52: Integer;
      const wYnh_jPEvuT_70: WideString; FCkcbzf_MMbKAUi_SyeTqI: Integer;
      UItnh_gRgY_gvRHs: Integer): Integer; safecall;
    function rqTHCRFp(NCUwB_eHOghN_slfIHzO: Integer;
      const xFGUF_ImgG_GYQr: WideString; GJPD_TcwGuy_37: Integer;
      const XHfAqa_nrbehL_66: WideString): Integer; safecall;
    function LJWzG(MGzcgxW28: Integer): Integer; safecall;
    function BehGgVCltWPqonB(TJSe_oiUUBqi_58: Integer;
      qcohrcW_ZYnrs_00: Integer; OXkspl80: Integer; JDcLsXP71: Integer;
      const NPyEWT_MlEpls_27: WideString; const JlhY_kKfSiO: WideString;
      ruYO_bWHL_NIzNBeW: Double; out tkhd_yqpul: OleVariant;
      out alvA_iEaFET: OleVariant): WideString; safecall;
    function ZFopiVw: Integer; safecall;
    function ZBTNIHBGeIemDSj(ykXOtWj_msqlq: Integer;
      const fHCTBKr_TMfW: WideString; const zFNqpt_rAuXC_41: WideString;
      const JHJb68: WideString; const EbXkr_rwBQj: WideString;
      MveMcTM_fpTAC_JHfW: Integer): Integer; safecall;
    function ZldLoKNEHN(YyLVdr_UIQAICw: Integer): Integer; safecall;
    function KnWR(Cfgf92: Integer): WideString; safecall;
    function IHgvWYxsyZmy(JmZX_vxGnHEX: Integer; eOCg_kAJL_UfPFitm: Integer;
      ooeQW_MUBHhZm_92: Integer; FcAc_cGtR: Integer;
      const gQcDqJk_nVzkqS_ZMLWQO: WideString; xgFvT12: Integer;
      Hlsq_dxwfD: Integer): Integer; safecall;
    function nDvRmmptvUnTJyg: Integer; safecall;
    function tHhQYJ(mPFfBH_nCNVXMh: Integer): Integer; safecall;
    function CeBIcDUuXg(zHzYj_nEDrkw: Integer): Integer; safecall;
    function naGjLkfsFMVeBX(const PkuxX99: WideString; ERLtFh39: Int64;
      YesLj35: Integer): WideString; safecall;
    function TLweTiXtv(const Bmwm70: WideString; const cDitN98: WideString;
      const TjmTog_hutHkyk_44: WideString): Integer; safecall;
    function mbxjJBvNghKT(BZTBwOQ_pjmEqFO: Integer; FFmc62: Integer;
      Mwlm_wkjNECP_80: Integer; IDyZWJg_QCRD_MKdHxqe: Integer;
      const NINY_XYjx_97: WideString; hyyTxof83: Double;
      EelHnWK_hfVas_TUdCGdV: Integer): WideString; safecall;
    function PSIvqvu(const riCxn54: WideString): Integer; safecall;
    function WgUFVH(HanfQHr_CkqxcXT_39: Integer): Integer; safecall;
    function iZkIuX(ESLLBR91: Integer; const obReS_xSxOgvT_24: WideString;
      EMKZCJ_KvPma_64: Integer): Int64; safecall;
    function RUWqTmAl(uNCQg_zhmtXv_66: Integer): Integer; safecall;
    function KuRJx(bAZgd_loreNtA_03: Integer; Ipfsh_iqieid_SFdl: Integer;
      mIBJqcD_PDyRE_04: Integer; DngB_NsoS_65: Integer): WideString; safecall;
    function yKFC(const RYvG_yLzcqfv: WideString): Integer; safecall;
    function bmbeNiyLCSE(const HuouGy41: WideString; aDUAkh_sstPdD: Integer;
      GBxFHIC_NsBV_KjvF: Integer; aCrgk_ebruZgb_wVfnT: Integer)
      : WideString; safecall;
    function RhqwdYBJQ(HNtYr62: Integer; Npgx48: Integer; ZmwGCq_QqwCw: Integer;
      ZxbILgL_rfeHDBC_FNKnHz: Integer; const nZbVu26: WideString;
      WxTL_ubRlKyU_aiMcBWf: Integer): Integer; safecall;
    function inoDBJyLDenvQA(iKaA_dzzGlt: Integer; rxVOuF_pIVt: Integer;
      hCdkd_qfPF: Integer): Integer; safecall;
    function IxxHM(rqUTL_oHPfPqM_55: Integer): Integer; safecall;
    function dkluvedfIqrgAIX(const FCPJZBw_qXhcIHm_14: WideString)
      : Integer; safecall;
    function cAZC(CocuJa49: Integer; CLcKCY_VddsUtJ_74: Integer)
      : Int64; safecall;
    function NTiDlpAa: WideString; safecall;
    function jmzn(HxbTzoW_krpsb_rOun: Integer; dHkYjzz_coIS_Ppvp: Int64;
      lZtCGP00: Integer; AFcmNpM_hWfYoLq_59: Integer): Integer; safecall;
    function ihzRBFlpmnfqbA(WmxQQi_jETRkL_00: Integer;
      sGTAS_zqVTnM_XRgHT: Integer; lgmCXld82: Integer;
      iBWMV_YBpSNJV_lKPFJU: Integer; const dhEk_UiDu_kVEwKPN: WideString;
      const FgfPkAR_yDBLfR_MEHOR: WideString; KspVt47: Double;
      QjXx_wEWMf_CpAukF: Integer; out NDmd_NHHno_XRrurL: OleVariant;
      out BwfBZjC_GbKLo_99: OleVariant): WideString; safecall;
    function uYtIsG(xLjz_haJmYD: Integer): WideString; safecall;
    function ovUBkZRoiDJ(GkMlrW_ZUBeAO_11: Integer): Integer; safecall;
    function IHmrtuuVklZ(bAfvi_InWp_XAEd: Integer; const ZFQLQw58: WideString;
      const astfSey_htLRmTM_meuG: WideString; AEzj_WvrzYY_bjpo: Integer)
      : WideString; safecall;
    function XMSdon: Integer; safecall;
    function tpVPr(Xxiig96: Integer; ybysi37: Integer;
      const ChyWRM33: WideString; lgwXv88: Double): Integer; safecall;
    function VqonxwiSNBKtG(gYPIDG89: Integer; BZzb_YkPR_83: Integer)
      : Integer; safecall;
    function LaCQF(aeTYVSD_leuOcWb: Integer; sXDTOm_MvqXfW_99: Integer;
      fhpM_gCvcE_epsb: Integer; fkpETk_fQdDC_95: Integer;
      const QzHhZ_kmCmmC: WideString; fkBsqHy91: Double;
      nYKh_afWDN_owxh: Integer): WideString; safecall;
    function ZBHw(UIMWlT_dMJLPKq: Integer; VNBUH44: Integer;
      nzXD_wpgw_75: Integer; fGFyrY_oHRj: Integer; const FiLVZhq55: WideString;
      const EQOekWH_yKGWVJ_71: WideString; ydvfg24: Double)
      : WideString; safecall;
    function PJPoNtGyhtSpbJF(yIUNPfN00: Integer;
      const tFCvo_enqmFe_WKqs: WideString; const BesOv_SXgJYY: WideString;
      const DFeS79: WideString; jIXxqwJ_pvzw: Integer): Integer; safecall;
    function ysvpGHTCjSxkM(FNjw74: Integer; npSmc_umvqL_71: Integer)
      : Integer; safecall;
    function jbghBFl: Integer; safecall;
    function GbexqmPTpmQrD: Integer; safecall;
    function vWfaEFNUnesbjX(cJiQTD_tYvT_DnIhAvE: Integer;
      Fbux_MlqZVc_REAioKh: Integer; mJdCZR_FxEExMn: Integer;
      rFVxQl_AUUvZL: Integer; hymnhbq_FevK_11: Integer): Integer; safecall;
    function ftZKpZDs: WideString; safecall;
    function FPapVSwcBJeBgzg(ajNQK_MXluLP: Integer; kFLTu81: Integer;
      ZlAMWr28: Integer; RGxpV_kkoo_jPKz: Integer;
      const JFoJ_oSerlV: WideString; const bnAHD25: WideString;
      pOLUtx21: Double): WideString; safecall;
    function kTkpWA(JQmOu37: Integer; const BrGf30: WideString)
      : Integer; safecall;
    function LXhe(kWbVx_EErgD_24: Integer; MeqJ_zcxQNq_TpEQu: Integer;
      cAQPk_YzZE_SqWmSM: Integer; lYDycsm_oSYEyU_60: Integer;
      cbgO_QBfex_27: Integer; Epqzw_sBOwJk: Integer; LVZSyQ_mXyperR: Integer)
      : Integer; safecall;
    function LvDwyVbkLKBNpX(VUcR_ueYgp_54: Integer): Integer; safecall;
    function vyVatBkbDhxbqL(const Pxqjj_LNEGVy: WideString)
      : WideString; safecall;
    function YXpqDwCjLHLgIow(const AiEZOBk04: WideString): WideString; safecall;
    function wDqqTc(loQfzzJ_lcBBbx: Integer; const EHAhv46: WideString;
      AWfP15: Integer; nnDA_JJzTk_LaWPp: Int64): Integer; safecall;
    function PrrUgxsnj(TrjFCkC86: Integer; kJlHOU_qDcyFQ_89: Integer;
      htrLs_AbwHoC_02: Integer; ySNLBZQ_lgBge: Integer;
      const SNiFaVp_jAUrz: WideString; const YgZA_aOfw: WideString;
      OjAPn84: Double): WideString; safecall;
    function SpGP(VTvQFy47: Integer; FuAjYpe_dcwLd_LNAK: Integer)
      : Integer; safecall;
    function uPyFzWCv: Integer; safecall;
    function giZGxidJLSie(out BaPPW_jhrOYJd_hQpP: OleVariant;
      out pkUy_vSSeo: OleVariant): Integer; safecall;
    function mjxEXqCAdBbz(const ejMaN20: WideString;
      const uBXS_enOrDp_ZZDN: WideString; const arxIQkJ_BHZQRUA_70: WideString)
      : WideString; safecall;
    function NxqlGsq(hPVt_guvthuJ_TJGb: Integer; MTfH17: Integer)
      : Integer; safecall;
    function YRDfm(gXkF_ZhdY_xczvLat: Integer): Integer; safecall;
    function AQPViHeWClMJnF(eMCmFI82: Integer): Integer; safecall;
    function EghZYsZ(cvXUjVZ14: Integer; const UuwQRV_roaV_kHql: WideString;
      const qREvUT_WLMHaP_SQdZ: WideString; ioWOiqv_aiuR: Integer;
      AzyD_ldyHgP_IAJHP: Integer; QCuGF_NPuCRdI: Integer): WideString; safecall;
    function zrfVEZGxWJVLwY: Integer; safecall;
    function sYGTvvuNIYjR: WideString; safecall;
    function uXltuWXRlKNLkk(const QSpT12: WideString;
      const IOUQmz_FCvxzWE_11: WideString): Integer; safecall;
    function BABEaUsPsu(qSytSiz_ZwaJaG_86: Integer): Integer; safecall;
    function WYNES: Integer; safecall;
    function EghqtuwlBhJn(const wLKmENe_cdvrEfc_16: WideString;
      const TmxFbLY_uJWqX: WideString; const aYrlp94: WideString;
      const rYLOg22: WideString): WideString; safecall;
    function EDLZ(Kjszrd93: Integer): Integer; safecall;
    function gCmoz(const xpoPWZC_jERhit_34: WideString; gRqWw_FByn_12: Integer)
      : Integer; safecall;
    function NeZFks(const cCojgK_IPHld: WideString): Integer; safecall;
    function qeIrvJkhZEBtq(OCATLJ_WhtY_ClZwDNp: Integer; sXGAPFG93: Int64;
      rACvDUb80: Single): Integer; safecall;
    function IXZrpl(const aDqj_DSxtUl_67: WideString;
      const PKFbdkf_QeSlVN_21: WideString; IzzHP_OQqpYz_kolfpB: Integer)
      : Integer; safecall;
    function GqzUhiEwfqAXX(const DzxCT_tqmLx_86: WideString): Integer; safecall;
    function VaBmodo(FrjTRas71: Integer; DxCJXnB08: Int64): Double; safecall;
    function qiMM(KFJvRkn_bQVLe: Integer; const cJUX_ZlEplwo_15: WideString;
      xYiOQs_fSav_49: Double; qagD_DdfMNyM_50: Double): WideString; safecall;
    function iuPTc(YclthY_ssZI: Integer; const ISnZ44: WideString)
      : Int64; safecall;
    function vXgV(const lfQaOr85: WideString;
      const AMWX_woWwuc_Ydgc: WideString; const kZzQ_hjZzcg_toTxq: WideString;
      const ExVZtp_ACAz: WideString): Integer; safecall;
    function VHLuftJPYsfzfiu(frxyxN46: Integer): Integer; safecall;
    function TVTdIwJoXuI(wwpKw72: Integer; fwodAYC_dOHEiCP: Int64;
      WKpUsO_psGgzZd_01: Integer): WideString; safecall;
    function mtikjWeiIwYAp(const KdtNc_KwYxj_JLkUS: WideString)
      : Integer; safecall;
    function DznPUjrSl(const XaXj_DUMsJ_71: WideString;
      EtaoCf_EpkvFm_44: Integer; vmoAb_nyTlZ_TJLmUg: Integer)
      : WideString; safecall;
    function IVTwWxKcvFI: Integer; safecall;
    function PeBHegBdZB(wlfpk70: Integer): Integer; safecall;
    function GmSb(const VwPnh38: WideString): WideString; safecall;
    function JvMwXPB(NBhUijE54: Integer; var bHKH38: OleVariant;
      var eapEM_ZSlLnIU: OleVariant): Integer; safecall;
    function nJckyIzi: Integer; safecall;
    function uwyrqkkbWTYcgg(RpHXfwa_EbBcjr_gOgdnP: Integer): Integer; safecall;
    function bScRBCilaHlUnFy(const uqdd_iiOxQj_93: WideString;
      const qypNfPY_qGtOwdI_ElqCq: WideString; HgFOFa_mzzAiX: Integer;
      nzqNzdN_RLoDT_69: Integer): WideString; safecall;
    function pxyHwQjEa(ZQokPM00: Integer; const IgVVeq_jtRDlG_32: WideString)
      : Integer; safecall;
    function oKwHpGksXDne: Integer; safecall;
    function HfAmeBdpg: Integer; safecall;
    function zyvyIy: WideString; safecall;
    function BUVNIQ(jsvuWOM_VenPfWQ_49: Integer; GSZhLfz33: Integer;
      wQVB50: Integer; oaXiwM_VTTM_03: Integer;
      const KkEt_SLauEpD_09: WideString; aEjrej_XtRhw: Double)
      : WideString; safecall;
    function argLDhCuvLbx(const WFUEdLL_PdRxWel_08: WideString;
      zmzsAh_sLGsH: Integer; lXQlqDj71: Integer; plpNy_GjhE_KkaSoO: Integer)
      : WideString; safecall;
    function xmBaheHXvwxBSee: Integer; safecall;
    function xRwBzSKr(yAKeXNh_jEFH_CcauqU: Integer; kclVNK23: Integer;
      MJnsw_aJliafj_26: Integer; qTlWPeG54: Integer;
      const gHNR_WVUm_19: WideString; const WpLfXVz36: WideString)
      : Integer; safecall;
    function yBFnBCu(GmJxfzY40: Integer; tOoH_sxbXxs_92: Integer;
      BxHt_Blsg_eVyytR: Integer; jAkZSMn_ZCKggdL: Integer;
      JjbXA_LikRC_MSQRM: Integer): Integer; safecall;
    function puXoGUk(const RkOCg_ARxZQl_PvOq: WideString;
      RoqbJml_YCDkKP: Integer; AYfz_Tfjge_43: Integer; AyGCud86: Integer)
      : Integer; safecall;
    function YguAyNMy: WideString; safecall;
    function nAxMvRZGveUZUG(PuAtjX09: Integer; gpMK55: Integer; TtQy99: Integer;
      HsSxXc_IATwX: Integer; const gPxj66: WideString;
      qgLh_Znjuy_qUhiSNO: Double): WideString; safecall;
    function AUtAalGEZsVCfR(hrwZGhA_owyz_60: Integer; zuEvc_BbpJx: Integer;
      hqoOgi47: Integer; QLjga_TKVm_LchwHdW: Integer;
      const nCydJ_dwcK_61: WideString; const ZzgfmfT_zjpLwS_11: WideString;
      HylVmz_RZvqX: Double; NBWW_HZSfMP: Integer): WideString; safecall;
    function RzwForeecY(OfmMKp_EdTj_25: Integer; UwJP_wsWm: Integer;
      uUNRuM_VxJjNM_68: Integer; dajOEC_IKTQSWF_fRBrpD: Integer;
      const rSQhJ_DNfUOA_93: WideString; const dXUOmSO_JydysG_VlER: WideString;
      xSHQ86: Double): WideString; safecall;
    function PGWiiKqESVvv(jKyQNZ_gvAOZ_nnazRVd: Integer;
      QDoyjU_AdvL_09: Integer; const JDciZ_AlQTK_45: WideString; LjBQ60: Double)
      : Integer; safecall;
    function bNSxXNHWbDmQ(jlLd_lLNmqjv_ktBCe: Integer): Integer; safecall;
    function gVGVKSIYqSiz(EJMTJo30: Integer; ImnCqj94: Integer;
      prXJ_dJVCP_SVearA: Integer; EeWDjl58: Integer;
      const oXbk_UGvFbXK_37: WideString): WideString; safecall;
    function JlKez: Integer; safecall;
    function ZUKcpVTKReub(VLGPS_xvqrzY_eqtQN: Integer;
      hmmklBG_tlbOCD_bvMDI: Integer; djfd_DvIBUu_31: Integer;
      VACxq_wAJj_xCcFrs: Integer; const rKLVimS_TPYCoS_UmmLd: WideString;
      const mnNgdxZ_anzrDx_38: WideString; dMfZ_qbmFEjf_84: Double;
      out PcDuE_nKUO_74: OleVariant; out MrVgsE_DaVJkx: OleVariant)
      : Integer; safecall;
    function QGClYnMa(aijqMY_fKnGXbt_12: Integer;
      const TryCQDH_mRbixNY_ZVgKewm: WideString; jIYNas_hlFLEv_02: Double;
      slkDgc_KbqX: Double; YHFk47: Integer; kWZKaVz_gAWl_53: Integer;
      WgSz_PAWW: Integer): WideString; safecall;
    function KxxB(bcQQxyK76: Integer): Integer; safecall;
    function feVoHL(const SyODNd_dpHy: WideString; const uAjxQdG40: WideString)
      : WideString; safecall;
    function BKXYEdXP(UYWaBpc_WHgix: Integer;
      const ugOZJyS_aoTaZK_41: WideString): WideString; safecall;
    function dzXyhoQCwxX: Integer; safecall;
    function uTecZFRmP(ihIyu73: Integer; const kwWy_vTsjeu_51: WideString)
      : Integer; safecall;
    function Zirbij(const jeTza94: WideString; const fpsuoY96: WideString;
      const mddS_LBrUHJT: WideString; const wnXjodd52: WideString)
      : Integer; safecall;
  end;

  IPighead = interface
    ['{EAE834B9-9800-4BDF-930F-36E9554EA70F}']
    Function GetDir(tpe: Integer): WideString;
    Function GetWindowTitle(hwnd: Integer): WideString;
    Function FaqGetSize(handle: Integer): Integer;
    Function RightUp(): Integer;
    Function GetDPI(): Integer;
    Function FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer;
    Function CaptureJpg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString; quality: Integer): Integer;
    Function IntToData(int_value: Int64; tpe: Integer): WideString;
    Function VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
      : WideString;
    Function FoobarSetFont(hwnd: Integer; font_name: WideString; size: Integer;
      flag: Integer): Integer;
    Function ReadDoubleAddr(hwnd: Integer; addr: Int64): Double;
    Function FoobarPrintText(hwnd: Integer; text: WideString;
      color: WideString): Integer;
    Function GetID(): Integer;
    Function ReadFileData(file_name: WideString; start_pos: Integer;
      end_pos: Integer): WideString;
    Function GetDmCount(): Integer;
    Function FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
      pic_name: WideString): Integer;
    Function OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString;
    Function GetWordResultCount(str: WideString): Integer;
    Function WriteFile(file_name: WideString; content: WideString): Integer;
    Function WriteFloat(hwnd: Integer; addr: WideString; v: Single): Integer;
    Function GetRealPath(path: WideString): WideString;
    Function SetRowGapNoDict(row_gap: Integer): Integer;
    Function GetCpuType(): Integer;
    Function AsmAdd(asm_ins: WideString): Integer;
    Function EnableKeypadMsg(en: Integer): Integer;
    Function DeleteIni(section: WideString; key: WideString;
      file_name: WideString): Integer;
    Function SetMinRowGap(row_gap: Integer): Integer;
    Function RegNoMac(code: WideString; Ver: WideString): Integer;
    Function FindFloatEx(hwnd: Integer; addr_range: WideString;
      float_value_min: Single; float_value_max: Single; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString;
    Function IsFolderExist(folder: WideString): Integer;
    Function Beep(fre: Integer; delay: Integer): Integer;
    Function ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
      length: Integer): WideString;
    Function Stop(id: Integer): Integer;
    Function GetColorHSV(x: Integer; y: Integer): WideString;
    Function FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; color: WideString; sim: Double; count: Integer;
      width: Integer; height: Integer): WideString;
    Function MoveDD(dx: Integer; dy: Integer): Integer;
    Function FindDouble(hwnd: Integer; addr_range: WideString;
      double_value_min: Double; double_value_max: Double): WideString;
    Function SetDisplayRefreshDelay(t: Integer): Integer;
    Function EnumIniKey(section: WideString; file_name: WideString): WideString;
    Function ShowScrMsg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      msg: WideString; color: WideString): Integer;
    Function FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer;
    Function GetCursorSpot(): WideString;
    Function VirtualFreeEx(hwnd: Integer; addr: Int64): Integer;
    Function SetPicPwd(pwd: WideString): Integer;
    Function FindPicEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString;
    Function GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString;
    Function ReadIntAddr(hwnd: Integer; addr: Int64; tpe: Integer): Int64;
    Function GetResultPos(str: WideString; index: Integer; out x: OleVariant;
      out y: OleVariant): Integer;
    Function WriteFloatAddr(hwnd: Integer; addr: Int64; v: Single): Integer;
    Function OcrInFile(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; color: WideString; sim: Double): WideString;
    Function WriteData(hwnd: Integer; addr: WideString;
      data: WideString): Integer;
    Function GetBasePath(): WideString;
    Function SetClipboard(data: WideString): Integer;
    Function FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
      pic: WideString; trans_color: WideString): Integer;
    Function WriteDouble(hwnd: Integer; addr: WideString; v: Double): Integer;
    Function GetDisplayInfo(): WideString;
    Function ReadIniPwd(section: WideString; key: WideString;
      file_name: WideString; pwd: WideString): WideString;
    Function GetTime(): Integer;
    Function ImageToBmp(pic_name: WideString; bmp_name: WideString): Integer;
    Function DoubleToData(double_value: Double): WideString;
    Function FindDoubleEx(hwnd: Integer; addr_range: WideString;
      double_value_min: Double; double_value_max: Double; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString;
    Function WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      v: WideString): Integer;
    Function FaqRelease(handle: Integer): Integer;
    Function DeleteFile(file_name: WideString): Integer;
    Function OpenProcess(pid: Integer): Integer;
    Function SetMouseSpeed(speed: Integer): Integer;
    Function EnableMouseMsg(en: Integer): Integer;
    Function EnumIniSectionPwd(file_name: WideString; pwd: WideString)
      : WideString;
    Function GetColor(x: Integer; y: Integer): WideString;
    Function SetMemoryFindResultToFile(file_name: WideString): Integer;
    Function FoobarSetTrans(hwnd: Integer; trans: Integer; color: WideString;
      sim: Double): Integer;
    Function ReadFile(file_name: WideString): WideString;
    Function GetDict(index: Integer; font_index: Integer): WideString;
    Function RGB2BGR(rgb_color: WideString): WideString;
    Function SetExcludeRegion(tpe: Integer; info: WideString): Integer;
    Function FaqCaptureString(str: WideString): Integer;
    Function EnableMouseAccuracy(en: Integer): Integer;
    Function CheckUAC(): Integer;
    Function GetWordResultStr(str: WideString; index: Integer): WideString;
    Function EnumProcess(name: WideString): WideString;
    Function GetResultCount(str: WideString): Integer;
    Function RunApp(path: WideString; mode: Integer): Integer;
    Function FindWindowEx(parent: Integer; class_name: WideString;
      title_name: WideString): Integer;
    Function ReadDataAddrToBin(hwnd: Integer; addr: Int64;
      length: Integer): Integer;
    Function FindColorEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer): WideString;
    Function SendPaste(hwnd: Integer): Integer;
    Function GetNetTimeByIp(ip: WideString): WideString;
    Function FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; str: WideString; color: WideString; sim: Double;
      font_name: WideString; font_size: Integer; flag: Integer): WideString;
    Function FetchWord(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; word: WideString): WideString;
    Function DisableFontSmooth(): Integer;
    Function AppendPicAddr(pic_info: WideString; addr: Integer; size: Integer)
      : WideString;
    Function FoobarClose(hwnd: Integer): Integer;
    Function FindColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer): WideString;
    Function SetExactOcr(exact_ocr: Integer): Integer;
    Function EnableFontSmooth(): Integer;
    Function SpeedNormalGraphic(en: Integer): Integer;
    Function GetWindowState(hwnd: Integer; flag: Integer): Integer;
    Function ExecuteCmd(cmd: WideString; current_dir: WideString;
      time_out: Integer): WideString;
    Function BindWindowEx(hwnd: Integer; display: WideString; mouse: WideString;
      keypad: WideString; public_desc: WideString; mode: Integer): Integer;
    Function delay(mis: Integer): Integer;
    Function MoveFile(src_file: WideString; dst_file: WideString): Integer;
    Function Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString): Integer;
    Function MiddleDown(): Integer;
    Function DmGuardParams(cmd: WideString; sub_cmd: WideString;
      param: WideString): WideString;
    Function DownCpu(rate: Integer): Integer;
    Function UnBindWindow(): Integer;
    Function FindStrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString;
    Function FindWindowByProcess(process_name: WideString;
      class_name: WideString; title_name: WideString): Integer;
    Function DisablePowerSave(): Integer;
    Function RightClick(): Integer;
    Function DisAssemble(asm_code: WideString; base_addr: Int64;
      is_64bit: Integer): WideString;
    Function EnableGetColorByCapture(en: Integer): Integer;
    Function FindStrFastEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString;
    Function FindFloat(hwnd: Integer; addr_range: WideString;
      float_value_min: Single; float_value_max: Single): WideString;
    Function ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
      y1: Integer; x2: Integer; y2: Integer): WideString;
    Function FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; first_color: WideString; offset_color: WideString;
      sim: Double; dir: Integer): WideString;
    Function FindColorBlock(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; count: Integer; width: Integer;
      height: Integer; out x: OleVariant; out y: OleVariant): Integer;
    Function Play(file_name: WideString): Integer;
    Function GetWindow(hwnd: Integer; flag: Integer): Integer;
    Function WheelDown(): Integer;
    Function SetLocale(): Integer;
    Function ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer;
    Function GetProcessInfo(pid: Integer): WideString;
    Function GetPointWindow(x: Integer; y: Integer): Integer;
    Function UseDict(index: Integer): Integer;
    Function FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; color: WideString; style: Integer;
      width: Integer): Integer;
    Function RegEx(code: WideString; Ver: WideString; ip: WideString): Integer;
    Function GetLastError(): Integer;
    Function SetKeypadDelay(tpe: WideString; delay: Integer): Integer;
    Function GetColorNum(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): Integer;
    Function SendString2(hwnd: Integer; str: WideString): Integer;
    Function GetClientRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
    Function GetModuleBaseAddr(hwnd: Integer; module_name: WideString): Int64;
    Function AddDict(index: Integer; dict_info: WideString): Integer;
    Function LoadPic(pic_name: WideString): Integer;
    Function GetMachineCodeNoMac(): WideString;
    Function FoobarUnlock(hwnd: Integer): Integer;
    Function GetOsType(): Integer;
    Function SetWordGapNoDict(word_gap: Integer): Integer;
    Function LeftDown(): Integer;
    Function SetEnumWindowDelay(delay: Integer): Integer;
    Function FindShapeEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer): WideString;
    Function FreeProcessMemory(hwnd: Integer): Integer;
    Function Ver(): WideString;
    Function GetForegroundWindow(): Integer;
    Function ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
      : WideString;
    Function KeyUp(vk: Integer): Integer;
    Function FindShapeE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer): WideString;
    Function WriteInt(hwnd: Integer; addr: WideString; tpe: Integer;
      v: Int64): Integer;
    Function EnableRealKeypad(en: Integer): Integer;
    Function EnumWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
      spec2: WideString; flag2: Integer; type2: Integer; sort: Integer)
      : WideString;
    Function IsBind(hwnd: Integer): Integer;
    Function SetSimMode(mode: Integer): Integer;
    Function GetWindowProcessPath(hwnd: Integer): WideString;
    Function KeyDownChar(key_str: WideString): Integer;
    Function MiddleClick(): Integer;
    Function WriteDataAddrFromBin(hwnd: Integer; addr: Int64; data: Integer;
      length: Integer): Integer;
    Function IsFileExist(file_name: WideString): Integer;
    Function FindStrFastExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString;
    Function FindStrExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString;
    Function EnableIme(en: Integer): Integer;
    Function ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      length: Integer): WideString;
    Function SetUAC(uac: Integer): Integer;
    Function DmGuard(en: Integer; tpe: WideString): Integer;
    Function FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString;
    Function GetMac(): WideString;
    Function FindMulColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): Integer;
    Function ReleaseRef(): Integer;
    Function EnumIniSection(file_name: WideString): WideString;
    Function GetClientSize(hwnd: Integer; out width: OleVariant;
      out height: OleVariant): Integer;
    Function SendCommand(cmd: WideString): Integer;
    Function SendStringIme(str: WideString): Integer;
    Function FindWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
      spec2: WideString; flag2: Integer; type2: Integer): Integer;
    Function FindPicMemE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString;
    Function SetDisplayAcceler(level: Integer): Integer;
    Function KeyPressChar(key_str: WideString): Integer;
    Function FloatToData(float_value: Single): WideString;
    Function GetDictCount(index: Integer): Integer;
    Function OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString;
    Function GetScreenHeight(): Integer;
    Function SetWordLineHeightNoDict(line_height: Integer): Integer;
    Function EnumWindowByProcess(process_name: WideString; title: WideString;
      class_name: WideString; filter: Integer): WideString;
    Function FindStrWithFont(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; font_name: WideString;
      font_size: Integer; flag: Integer; out x: OleVariant;
      out y: OleVariant): Integer;
    Function SetMemoryHwndAsProcessId(en: Integer): Integer;
    Function HackSpeed(rate: Double): Integer;
    Function ReadData(hwnd: Integer; addr: WideString; length: Integer)
      : WideString;
    Function GetPath(): WideString;
    Function GetMachineCode(): WideString;
    Function FindStrFast(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): Integer;
    Function LeaveCri(): Integer;
    Function SetPath(path: WideString): Integer;
    Function GetFps(): Integer;
    Function FindPicMem(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer;
    Function FindPicExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString;
    Function GetNetTimeSafe(): WideString;
    Function MoveR(rx: Integer; ry: Integer): Integer;
    Function GetOsBuildNumber(): Integer;
    Function FindNearestPos(all_pos: WideString; tpe: Integer; x: Integer;
      y: Integer): WideString;
    Function GetEnv(index: Integer; name: WideString): WideString;
    Function EnableFakeActive(en: Integer): Integer;
    Function ExitOs(tpe: Integer): Integer;
    Function SortPosDistance(all_pos: WideString; tpe: Integer; x: Integer;
      y: Integer): WideString;
    Function EnumWindow(parent: Integer; title: WideString;
      class_name: WideString; filter: Integer): WideString;
    Function BGR2RGB(bgr_color: WideString): WideString;
    Function WriteIni(section: WideString; key: WideString; v: WideString;
      file_name: WideString): Integer;
    Function RightDown(): Integer;
    Function GetCursorShape(): WideString;
    Function Reg(code: WideString; Ver: WideString): Integer;
    Function EnterCri(): Integer;
    Function SendStringIme2(hwnd: Integer; str: WideString;
      mode: Integer): Integer;
    Function FreeScreenData(handle: Integer): Integer;
    Function FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; str: WideString; color: WideString; sim: Double;
      font_name: WideString; font_size: Integer; flag: Integer): WideString;
    Function KeyPressStr(key_str: WideString; delay: Integer): Integer;
    Function LeftDoubleClick(): Integer;
    Function KeyUpChar(key_str: WideString): Integer;
    Function GetCursorShapeEx(tpe: Integer): WideString;
    Function EnableRealMouse(en: Integer; mousedelay: Integer;
      mousestep: Integer): Integer;
    Function FindString(hwnd: Integer; addr_range: WideString;
      string_value: WideString; tpe: Integer): WideString;
    Function ReadIni(section: WideString; key: WideString;
      file_name: WideString): WideString;
    Function SetWordGap(word_gap: Integer): Integer;
    Function DisableScreenSave(): Integer;
    Function FindIntEx(hwnd: Integer; addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString;
    Function GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
      fun_name: WideString): Int64;
    Function CopyFile(src_file: WideString; dst_file: WideString;
      over: Integer): Integer;
    Function SetWindowState(hwnd: Integer; flag: Integer): Integer;
    Function SetMinColGap(col_gap: Integer): Integer;
    Function FoobarDrawText(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer; text: WideString; color: WideString; align: Integer): Integer;
    Function Delays(min_s: Integer; max_s: Integer): Integer;
    Function RegExNoMac(code: WideString; Ver: WideString;
      ip: WideString): Integer;
    Function GetBindWindow(): Integer;
    Function EnumWindowByProcessId(pid: Integer; title: WideString;
      class_name: WideString; filter: Integer): WideString;
    Function SetShowErrorMsg(show: Integer): Integer;
    Function ReadDouble(hwnd: Integer; addr: WideString): Double;
    Function LeftClick(): Integer;
    Function GetScreenDepth(): Integer;
    Function SelectDirectory(): WideString;
    Function GetLocale(): Integer;
    Function CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
      pic: WideString; trans_color: WideString; sim: Double): Integer;
    Function SetWindowTransparent(hwnd: Integer; v: Integer): Integer;
    Function FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer;
    Function SetExportDict(index: Integer; dict_name: WideString): Integer;
    Function CheckInputMethod(hwnd: Integer; id: WideString): Integer;
    Function SetDisplayInput(mode: WideString): Integer;
    Function TerminateProcess(pid: Integer): Integer;
    Function LockInput(locks: Integer): Integer;
    Function SetDict(index: Integer; dict_name: WideString): Integer;
    Function FaqCancel(): Integer;
    Function FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; file_name: WideString; quality: Integer): Integer;
    Function DecodeFile(file_name: WideString; pwd: WideString): Integer;
    Function GetNetTime(): WideString;
    Function CheckFontSmooth(): Integer;
    Function AsmClear(): Integer;
    Function StrStr(s: WideString; str: WideString): Integer;
    Function FindWindowByProcessId(process_id: Integer; class_name: WideString;
      title_name: WideString): Integer;
    Function WriteIniPwd(section: WideString; key: WideString; v: WideString;
      file_name: WideString; pwd: WideString): Integer;
    Function KeyPress(vk: Integer): Integer;
    Function FaqIsPosted(): Integer;
    Function ActiveInputMethod(hwnd: Integer; id: WideString): Integer;
    Function BindWindow(hwnd: Integer; display: WideString; mouse: WideString;
      keypad: WideString; mode: Integer): Integer;
    Function VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
      tpe: Integer; old_protect: Integer): Integer;
    Function CreateFolder(folder_name: WideString): Integer;
    Function GetPicSize(pic_name: WideString): WideString;
    Function FindPicMemEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString;
    Function SetMouseDelay(tpe: WideString; delay: Integer): Integer;
    Function GetNowDict(): Integer;
    Function GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString): WideString;
    Function GetFileLength(file_name: WideString): Integer;
    Function FindStrFastE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString;
    Function FindInputMethod(id: WideString): Integer;
    Function FaqPost(server: WideString; handle: Integer; request_type: Integer;
      time_out: Integer): Integer;
    Function EnableSpeedDx(en: Integer): Integer;
    Function MoveWindow(hwnd: Integer; x: Integer; y: Integer): Integer;
    Function Assemble(base_addr: Int64; is_64bit: Integer): WideString;
    Function SwitchBindWindow(hwnd: Integer): Integer;
    Function LockMouseRect(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer): Integer;
    Function SetDictMem(index: Integer; addr: Integer; size: Integer): Integer;
    Function InitCri(): Integer;
    Function FindInt(hwnd: Integer; addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; tpe: Integer): WideString;
    Function SetDisplayDelay(t: Integer): Integer;
    Function GetMouseSpeed(): Integer;
    Function FoobarLock(hwnd: Integer): Integer;
    Function VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
      tpe: Integer): Int64;
    Function EnableShareDict(en: Integer): Integer;
    Function FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): Integer;
    Function FaqSend(server: WideString; handle: Integer; request_type: Integer;
      time_out: Integer): WideString;
    Function ReadFloatAddr(hwnd: Integer; addr: Int64): Single;
    Function SetWordLineHeight(line_height: Integer): Integer;
    Function EnableBind(en: Integer): Integer;
    Function Is64Bit(): Integer;
    Function FindDataEx(hwnd: Integer; addr_range: WideString; data: WideString;
      steps: Integer; multi_thread: Integer; mode: Integer): WideString;
    Function KeyDown(vk: Integer): Integer;
    Function SetWindowText(hwnd: Integer; text: WideString): Integer;
    Function WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      v: Int64): Integer;
    Function EncodeFile(file_name: WideString; pwd: WideString): Integer;
    Function LoadPicByte(addr: Integer; size: Integer;
      name: WideString): Integer;
    Function GetScreenData(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer): Integer;
    Function GetClipboard(): WideString;
    Function GetColorBGR(x: Integer; y: Integer): WideString;
    Function FindStrFastS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): WideString;
    Function CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer): Integer;
    Function MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
      : WideString;
    Function GetWindowRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant): Integer;
    Function SetWindowSize(hwnd: Integer; width: Integer;
      height: Integer): Integer;
    Function AsmCall(hwnd: Integer; mode: Integer): Int64;
    Function SetScreen(width: Integer; height: Integer; depth: Integer)
      : Integer;
    Function ClientToScreen(hwnd: Integer; var x: OleVariant;
      var y: OleVariant): Integer;
    Function FindWindow(class_name: WideString; title_name: WideString)
      : Integer;
    Function WriteDataAddr(hwnd: Integer; addr: Int64;
      data: WideString): Integer;
    Function GetScreenWidth(): Integer;
    Function FindColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer;
    Function FindMultiColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      first_color: WideString; offset_color: WideString; sim: Double;
      dir: Integer): WideString;
    Function GetWindowClass(hwnd: Integer): WideString;
    Function CapturePre(file_name: WideString): Integer;
    Function GetForegroundFocus(): Integer;
    Function SetAero(en: Integer): Integer;
    Function FoobarTextRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer;
    Function FindMultiColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      first_color: WideString; offset_color: WideString; sim: Double;
      dir: Integer; out x: OleVariant; out y: OleVariant): Integer;
    Function DownloadFile(url: WideString; save_file: WideString;
      timeout: Integer): Integer;
    Function MatchPicName(pic_name: WideString): WideString;
    Function Log(info: WideString): Integer;
    Function GetCursorPos(out x: OleVariant; out y: OleVariant): Integer;
    Function GetMousePointWindow(): Integer;
    Function GetDiskSerial(): WideString;
    Function Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString;
    Function ReadInt(hwnd: Integer; addr: WideString; tpe: Integer): Int64;
    Function GetWindowProcessId(hwnd: Integer): Integer;
    Function AsmCallEx(hwnd: Integer; mode: Integer;
      base_addr: WideString): Int64;
    Function ClearDict(index: Integer): Integer;
    Function Int64ToInt32(v: Int64): Integer;
    Function SetDictPwd(pwd: WideString): Integer;
    Function FaqFetch(): WideString;
    Function GetSpecialWindow(flag: Integer): Integer;
    Function EnablePicCache(en: Integer): Integer;
    Function EnumIniKeyPwd(section: WideString; file_name: WideString;
      pwd: WideString): WideString;
    Function SetClientSize(hwnd: Integer; width: Integer;
      height: Integer): Integer;
    Function SendString(hwnd: Integer; str: WideString): Integer;
    Function WriteDoubleAddr(hwnd: Integer; addr: Int64; v: Double): Integer;
    Function ScreenToClient(hwnd: Integer; var x: OleVariant;
      var y: OleVariant): Integer;
    Function AsmSetTimeout(time_out: Integer; param: Integer): Integer;
    Function WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
      v: WideString): Integer;
    Function GetWordResultPos(str: WideString; index: Integer;
      out x: OleVariant; out y: OleVariant): Integer;
    Function FoobarClearText(hwnd: Integer): Integer;
    Function IsDisplayDead(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      t: Integer): Integer;
    Function ReadDataToBin(hwnd: Integer; addr: WideString;
      length: Integer): Integer;
    Function WaitKey(key_code: Integer; time_out: Integer): Integer;
    Function EnableKeypadPatch(en: Integer): Integer;
    Function CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer;
    Function CapturePng(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString): Integer;
    Function MiddleUp(): Integer;
    Function CmpColor(x: Integer; y: Integer; color: WideString;
      sim: Double): Integer;
    Function FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): WideString;
    Function GetKeyState(vk: Integer): Integer;
    Function FoobarSetSave(hwnd: Integer; file_name: WideString; en: Integer;
      header: WideString): Integer;
    Function ReadFloat(hwnd: Integer; addr: WideString): Single;
    Function LeftUp(): Integer;
    Function ForceUnBindWindow(hwnd: Integer): Integer;
    Function DeleteIniPwd(section: WideString; key: WideString;
      file_name: WideString; pwd: WideString): Integer;
    Function FaqCapture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      quality: Integer; delay: Integer; time: Integer): Integer;
    Function SetExitThread(en: Integer): Integer;
    Function EnableDisplayDebug(enable_debug: Integer): Integer;
    Function CaptureGif(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString; delay: Integer; time: Integer): Integer;
    Function EnableMouseSync(en: Integer; time_out: Integer): Integer;
    Function SetParam64ToPointer(): Integer;
    Function FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString;
    Function DelEnv(index: Integer; name: WideString): Integer;
    Function GetCommandLine(hwnd: Integer): WideString;
    Function FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): WideString;
    Function FoobarUpdate(hwnd: Integer): Integer;
    Function SelectFile(): WideString;
    Function FindData(hwnd: Integer; addr_range: WideString; data: WideString)
      : WideString;
    Function FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; color: WideString): Integer;
    Function LockDisplay(locks: Integer): Integer;
    Function WheelUp(): Integer;
    Function Md5(str: WideString): WideString;
    Function FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
      pic_name: WideString; repeat_limit: Integer; delay: Integer): Integer;
    Function MoveTo(x: Integer; y: Integer): Integer;
    Function WriteDataFromBin(hwnd: Integer; addr: WideString; data: Integer;
      length: Integer): Integer;
    Function SetEnv(index: Integer; name: WideString;
      value: WideString): Integer;
    Function StringToData(string_value: WideString; tpe: Integer): WideString;
    Function FreePic(pic_name: WideString): Integer;
    Function EnableKeypadSync(en: Integer; time_out: Integer): Integer;
    Function DeleteFolder(folder_name: WideString): Integer;
    Function FindShape(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer;
    Function FindStringEx(hwnd: Integer; addr_range: WideString;
      string_value: WideString; tpe: Integer; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString;
    Function SaveDict(index: Integer; file_name: WideString): Integer;
    Function GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; out data: OleVariant; out size: OleVariant): Integer;
    Function GetAveHSV(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString;
    Function CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer; rw: Integer; rh: Integer): Integer;
    Function GetDictInfo(str: WideString; font_name: WideString;
      font_size: Integer; flag: Integer): WideString;
    Function GetAveRGB(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString;
    Function UnLoadDriver(): Integer;
    Function DisableCloseDisplayAndSleep(): Integer;
    Function SetColGapNoDict(col_gap: Integer): Integer;

  end;

  TCustomObj = Class(TInterfacedObject, IPighead)
  Private
    obj: Isuxin;
  Public
    Constructor Create();
    Destructor Destroy(); Override;

    Function GetDir(tpe: Integer): WideString; Virtual;
    Function GetWindowTitle(hwnd: Integer): WideString; Virtual;
    Function FaqGetSize(handle: Integer): Integer; Virtual;
    Function RightUp(): Integer; Virtual;
    Function GetDPI(): Integer; Virtual;
    Function FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function CaptureJpg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString; quality: Integer): Integer; Virtual;
    Function IntToData(int_value: Int64; tpe: Integer): WideString; Virtual;
    Function VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
      : WideString; Virtual;
    Function FoobarSetFont(hwnd: Integer; font_name: WideString; size: Integer;
      flag: Integer): Integer; Virtual;
    Function ReadDoubleAddr(hwnd: Integer; addr: Int64): Double; Virtual;
    Function FoobarPrintText(hwnd: Integer; text: WideString; color: WideString)
      : Integer; Virtual;
    Function GetID(): Integer; Virtual;
    Function ReadFileData(file_name: WideString; start_pos: Integer;
      end_pos: Integer): WideString; Virtual;
    Function GetDmCount(): Integer; Virtual;
    Function FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
      pic_name: WideString): Integer; Virtual;
    Function OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function GetWordResultCount(str: WideString): Integer; Virtual;
    Function WriteFile(file_name: WideString; content: WideString)
      : Integer; Virtual;
    Function WriteFloat(hwnd: Integer; addr: WideString; v: Single)
      : Integer; Virtual;
    Function GetRealPath(path: WideString): WideString; Virtual;
    Function SetRowGapNoDict(row_gap: Integer): Integer; Virtual;
    Function GetCpuType(): Integer; Virtual;
    Function AsmAdd(asm_ins: WideString): Integer; Virtual;
    Function EnableKeypadMsg(en: Integer): Integer; Virtual;
    Function DeleteIni(section: WideString; key: WideString;
      file_name: WideString): Integer; Virtual;
    Function SetMinRowGap(row_gap: Integer): Integer; Virtual;
    Function RegNoMac(code: WideString; Ver: WideString): Integer; Virtual;
    Function FindFloatEx(hwnd: Integer; addr_range: WideString;
      float_value_min: Single; float_value_max: Single; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function IsFolderExist(folder: WideString): Integer; Virtual;
    Function Beep(fre: Integer; delay: Integer): Integer; Virtual;
    Function ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
      length: Integer): WideString; Virtual;
    Function Stop(id: Integer): Integer; Virtual;
    Function GetColorHSV(x: Integer; y: Integer): WideString; Virtual;
    Function FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; color: WideString; sim: Double; count: Integer;
      width: Integer; height: Integer): WideString; Virtual;
    Function MoveDD(dx: Integer; dy: Integer): Integer; Virtual;
    Function FindDouble(hwnd: Integer; addr_range: WideString;
      double_value_min: Double; double_value_max: Double): WideString; Virtual;
    Function SetDisplayRefreshDelay(t: Integer): Integer; Virtual;
    Function EnumIniKey(section: WideString; file_name: WideString)
      : WideString; Virtual;
    Function ShowScrMsg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      msg: WideString; color: WideString): Integer; Virtual;
    Function FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer; Virtual;
    Function GetCursorSpot(): WideString; Virtual;
    Function VirtualFreeEx(hwnd: Integer; addr: Int64): Integer; Virtual;
    Function SetPicPwd(pwd: WideString): Integer; Virtual;
    Function FindPicEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function ReadIntAddr(hwnd: Integer; addr: Int64; tpe: Integer)
      : Int64; Virtual;
    Function GetResultPos(str: WideString; index: Integer; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function WriteFloatAddr(hwnd: Integer; addr: Int64; v: Single)
      : Integer; Virtual;
    Function OcrInFile(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; color: WideString; sim: Double)
      : WideString; Virtual;
    Function WriteData(hwnd: Integer; addr: WideString; data: WideString)
      : Integer; Virtual;
    Function GetBasePath(): WideString; Virtual;
    Function SetClipboard(data: WideString): Integer; Virtual;
    Function FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
      pic: WideString; trans_color: WideString): Integer; Virtual;
    Function WriteDouble(hwnd: Integer; addr: WideString; v: Double)
      : Integer; Virtual;
    Function GetDisplayInfo(): WideString; Virtual;
    Function ReadIniPwd(section: WideString; key: WideString;
      file_name: WideString; pwd: WideString): WideString; Virtual;
    Function GetTime(): Integer; Virtual;
    Function ImageToBmp(pic_name: WideString; bmp_name: WideString)
      : Integer; Virtual;
    Function DoubleToData(double_value: Double): WideString; Virtual;
    Function FindDoubleEx(hwnd: Integer; addr_range: WideString;
      double_value_min: Double; double_value_max: Double; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      v: WideString): Integer; Virtual;
    Function FaqRelease(handle: Integer): Integer; Virtual;
    Function DeleteFile(file_name: WideString): Integer; Virtual;
    Function OpenProcess(pid: Integer): Integer; Virtual;
    Function SetMouseSpeed(speed: Integer): Integer; Virtual;
    Function EnableMouseMsg(en: Integer): Integer; Virtual;
    Function EnumIniSectionPwd(file_name: WideString; pwd: WideString)
      : WideString; Virtual;
    Function GetColor(x: Integer; y: Integer): WideString; Virtual;
    Function SetMemoryFindResultToFile(file_name: WideString): Integer; Virtual;
    Function FoobarSetTrans(hwnd: Integer; trans: Integer; color: WideString;
      sim: Double): Integer; Virtual;
    Function ReadFile(file_name: WideString): WideString; Virtual;
    Function GetDict(index: Integer; font_index: Integer): WideString; Virtual;
    Function RGB2BGR(rgb_color: WideString): WideString; Virtual;
    Function SetExcludeRegion(tpe: Integer; info: WideString): Integer; Virtual;
    Function FaqCaptureString(str: WideString): Integer; Virtual;
    Function EnableMouseAccuracy(en: Integer): Integer; Virtual;
    Function CheckUAC(): Integer; Virtual;
    Function GetWordResultStr(str: WideString; index: Integer)
      : WideString; Virtual;
    Function EnumProcess(name: WideString): WideString; Virtual;
    Function GetResultCount(str: WideString): Integer; Virtual;
    Function RunApp(path: WideString; mode: Integer): Integer; Virtual;
    Function FindWindowEx(parent: Integer; class_name: WideString;
      title_name: WideString): Integer; Virtual;
    Function ReadDataAddrToBin(hwnd: Integer; addr: Int64; length: Integer)
      : Integer; Virtual;
    Function FindColorEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function SendPaste(hwnd: Integer): Integer; Virtual;
    Function GetNetTimeByIp(ip: WideString): WideString; Virtual;
    Function FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; str: WideString; color: WideString; sim: Double;
      font_name: WideString; font_size: Integer; flag: Integer)
      : WideString; Virtual;
    Function FetchWord(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; word: WideString): WideString; Virtual;
    Function DisableFontSmooth(): Integer; Virtual;
    Function AppendPicAddr(pic_info: WideString; addr: Integer; size: Integer)
      : WideString; Virtual;
    Function FoobarClose(hwnd: Integer): Integer; Virtual;
    Function FindColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function SetExactOcr(exact_ocr: Integer): Integer; Virtual;
    Function EnableFontSmooth(): Integer; Virtual;
    Function SpeedNormalGraphic(en: Integer): Integer; Virtual;
    Function GetWindowState(hwnd: Integer; flag: Integer): Integer; Virtual;
    Function ExecuteCmd(cmd: WideString; current_dir: WideString;
      time_out: Integer): WideString; Virtual;
    Function BindWindowEx(hwnd: Integer; display: WideString; mouse: WideString;
      keypad: WideString; public_desc: WideString; mode: Integer)
      : Integer; Virtual;
    Function delay(mis: Integer): Integer; Virtual;
    Function MoveFile(src_file: WideString; dst_file: WideString)
      : Integer; Virtual;
    Function Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString): Integer; Virtual;
    Function MiddleDown(): Integer; Virtual;
    Function DmGuardParams(cmd: WideString; sub_cmd: WideString;
      param: WideString): WideString; Virtual;
    Function DownCpu(rate: Integer): Integer; Virtual;
    Function UnBindWindow(): Integer; Virtual;
    Function FindStrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function FindWindowByProcess(process_name: WideString;
      class_name: WideString; title_name: WideString): Integer; Virtual;
    Function DisablePowerSave(): Integer; Virtual;
    Function RightClick(): Integer; Virtual;
    Function DisAssemble(asm_code: WideString; base_addr: Int64;
      is_64bit: Integer): WideString; Virtual;
    Function EnableGetColorByCapture(en: Integer): Integer; Virtual;
    Function FindStrFastEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function FindFloat(hwnd: Integer; addr_range: WideString;
      float_value_min: Single; float_value_max: Single): WideString; Virtual;
    Function ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
      y1: Integer; x2: Integer; y2: Integer): WideString; Virtual;
    Function FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; first_color: WideString; offset_color: WideString;
      sim: Double; dir: Integer): WideString; Virtual;
    Function FindColorBlock(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; count: Integer; width: Integer;
      height: Integer; out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function Play(file_name: WideString): Integer; Virtual;
    Function GetWindow(hwnd: Integer; flag: Integer): Integer; Virtual;
    Function WheelDown(): Integer; Virtual;
    Function SetLocale(): Integer; Virtual;
    Function ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer; Virtual;
    Function GetProcessInfo(pid: Integer): WideString; Virtual;
    Function GetPointWindow(x: Integer; y: Integer): Integer; Virtual;
    Function UseDict(index: Integer): Integer; Virtual;
    Function FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; color: WideString; style: Integer;
      width: Integer): Integer; Virtual;
    Function RegEx(code: WideString; Ver: WideString; ip: WideString)
      : Integer; Virtual;
    Function GetLastError(): Integer; Virtual;
    Function SetKeypadDelay(tpe: WideString; delay: Integer): Integer; Virtual;
    Function GetColorNum(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): Integer; Virtual;
    Function SendString2(hwnd: Integer; str: WideString): Integer; Virtual;
    Function GetClientRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant)
      : Integer; Virtual;
    Function GetModuleBaseAddr(hwnd: Integer; module_name: WideString)
      : Int64; Virtual;
    Function AddDict(index: Integer; dict_info: WideString): Integer; Virtual;
    Function LoadPic(pic_name: WideString): Integer; Virtual;
    Function GetMachineCodeNoMac(): WideString; Virtual;
    Function FoobarUnlock(hwnd: Integer): Integer; Virtual;
    Function GetOsType(): Integer; Virtual;
    Function SetWordGapNoDict(word_gap: Integer): Integer; Virtual;
    Function LeftDown(): Integer; Virtual;
    Function SetEnumWindowDelay(delay: Integer): Integer; Virtual;
    Function FindShapeEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function FreeProcessMemory(hwnd: Integer): Integer; Virtual;
    Function Ver(): WideString; Virtual;
    Function GetForegroundWindow(): Integer; Virtual;
    Function ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
      : WideString; Virtual;
    Function KeyUp(vk: Integer): Integer; Virtual;
    Function FindShapeE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function WriteInt(hwnd: Integer; addr: WideString; tpe: Integer; v: Int64)
      : Integer; Virtual;
    Function EnableRealKeypad(en: Integer): Integer; Virtual;
    Function EnumWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
      spec2: WideString; flag2: Integer; type2: Integer; sort: Integer)
      : WideString; Virtual;
    Function IsBind(hwnd: Integer): Integer; Virtual;
    Function SetSimMode(mode: Integer): Integer; Virtual;
    Function GetWindowProcessPath(hwnd: Integer): WideString; Virtual;
    Function KeyDownChar(key_str: WideString): Integer; Virtual;
    Function MiddleClick(): Integer; Virtual;
    Function WriteDataAddrFromBin(hwnd: Integer; addr: Int64; data: Integer;
      length: Integer): Integer; Virtual;
    Function IsFileExist(file_name: WideString): Integer; Virtual;
    Function FindStrFastExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function FindStrExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function EnableIme(en: Integer): Integer; Virtual;
    Function ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      length: Integer): WideString; Virtual;
    Function SetUAC(uac: Integer): Integer; Virtual;
    Function DmGuard(en: Integer; tpe: WideString): Integer; Virtual;
    Function FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function GetMac(): WideString; Virtual;
    Function FindMulColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): Integer; Virtual;
    Function ReleaseRef(): Integer; Virtual;
    Function EnumIniSection(file_name: WideString): WideString; Virtual;
    Function GetClientSize(hwnd: Integer; out width: OleVariant;
      out height: OleVariant): Integer; Virtual;
    Function SendCommand(cmd: WideString): Integer; Virtual;
    Function SendStringIme(str: WideString): Integer; Virtual;
    Function FindWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
      spec2: WideString; flag2: Integer; type2: Integer): Integer; Virtual;
    Function FindPicMemE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function SetDisplayAcceler(level: Integer): Integer; Virtual;
    Function KeyPressChar(key_str: WideString): Integer; Virtual;
    Function FloatToData(float_value: Single): WideString; Virtual;
    Function GetDictCount(index: Integer): Integer; Virtual;
    Function OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function GetScreenHeight(): Integer; Virtual;
    Function SetWordLineHeightNoDict(line_height: Integer): Integer; Virtual;
    Function EnumWindowByProcess(process_name: WideString; title: WideString;
      class_name: WideString; filter: Integer): WideString; Virtual;
    Function FindStrWithFont(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; font_name: WideString;
      font_size: Integer; flag: Integer; out x: OleVariant; out y: OleVariant)
      : Integer; Virtual;
    Function SetMemoryHwndAsProcessId(en: Integer): Integer; Virtual;
    Function HackSpeed(rate: Double): Integer; Virtual;
    Function ReadData(hwnd: Integer; addr: WideString; length: Integer)
      : WideString; Virtual;
    Function GetPath(): WideString; Virtual;
    Function GetMachineCode(): WideString; Virtual;
    Function FindStrFast(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function LeaveCri(): Integer; Virtual;
    Function SetPath(path: WideString): Integer; Virtual;
    Function GetFps(): Integer; Virtual;
    Function FindPicMem(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function FindPicExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function GetNetTimeSafe(): WideString; Virtual;
    Function MoveR(rx: Integer; ry: Integer): Integer; Virtual;
    Function GetOsBuildNumber(): Integer; Virtual;
    Function FindNearestPos(all_pos: WideString; tpe: Integer; x: Integer;
      y: Integer): WideString; Virtual;
    Function GetEnv(index: Integer; name: WideString): WideString; Virtual;
    Function EnableFakeActive(en: Integer): Integer; Virtual;
    Function ExitOs(tpe: Integer): Integer; Virtual;
    Function SortPosDistance(all_pos: WideString; tpe: Integer; x: Integer;
      y: Integer): WideString; Virtual;
    Function EnumWindow(parent: Integer; title: WideString;
      class_name: WideString; filter: Integer): WideString; Virtual;
    Function BGR2RGB(bgr_color: WideString): WideString; Virtual;
    Function WriteIni(section: WideString; key: WideString; v: WideString;
      file_name: WideString): Integer; Virtual;
    Function RightDown(): Integer; Virtual;
    Function GetCursorShape(): WideString; Virtual;
    Function Reg(code: WideString; Ver: WideString): Integer; Virtual;
    Function EnterCri(): Integer; Virtual;
    Function SendStringIme2(hwnd: Integer; str: WideString; mode: Integer)
      : Integer; Virtual;
    Function FreeScreenData(handle: Integer): Integer; Virtual;
    Function FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; str: WideString; color: WideString; sim: Double;
      font_name: WideString; font_size: Integer; flag: Integer)
      : WideString; Virtual;
    Function KeyPressStr(key_str: WideString; delay: Integer): Integer; Virtual;
    Function LeftDoubleClick(): Integer; Virtual;
    Function KeyUpChar(key_str: WideString): Integer; Virtual;
    Function GetCursorShapeEx(tpe: Integer): WideString; Virtual;
    Function EnableRealMouse(en: Integer; mousedelay: Integer;
      mousestep: Integer): Integer; Virtual;
    Function FindString(hwnd: Integer; addr_range: WideString;
      string_value: WideString; tpe: Integer): WideString; Virtual;
    Function ReadIni(section: WideString; key: WideString;
      file_name: WideString): WideString; Virtual;
    Function SetWordGap(word_gap: Integer): Integer; Virtual;
    Function DisableScreenSave(): Integer; Virtual;
    Function FindIntEx(hwnd: Integer; addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
      fun_name: WideString): Int64; Virtual;
    Function CopyFile(src_file: WideString; dst_file: WideString; over: Integer)
      : Integer; Virtual;
    Function SetWindowState(hwnd: Integer; flag: Integer): Integer; Virtual;
    Function SetMinColGap(col_gap: Integer): Integer; Virtual;
    Function FoobarDrawText(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer; text: WideString; color: WideString; align: Integer)
      : Integer; Virtual;
    Function Delays(min_s: Integer; max_s: Integer): Integer; Virtual;
    Function RegExNoMac(code: WideString; Ver: WideString; ip: WideString)
      : Integer; Virtual;
    Function GetBindWindow(): Integer; Virtual;
    Function EnumWindowByProcessId(pid: Integer; title: WideString;
      class_name: WideString; filter: Integer): WideString; Virtual;
    Function SetShowErrorMsg(show: Integer): Integer; Virtual;
    Function ReadDouble(hwnd: Integer; addr: WideString): Double; Virtual;
    Function LeftClick(): Integer; Virtual;
    Function GetScreenDepth(): Integer; Virtual;
    Function SelectDirectory(): WideString; Virtual;
    Function GetLocale(): Integer; Virtual;
    Function CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
      pic: WideString; trans_color: WideString; sim: Double): Integer; Virtual;
    Function SetWindowTransparent(hwnd: Integer; v: Integer): Integer; Virtual;
    Function FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer; Virtual;
    Function SetExportDict(index: Integer; dict_name: WideString)
      : Integer; Virtual;
    Function CheckInputMethod(hwnd: Integer; id: WideString): Integer; Virtual;
    Function SetDisplayInput(mode: WideString): Integer; Virtual;
    Function TerminateProcess(pid: Integer): Integer; Virtual;
    Function LockInput(locks: Integer): Integer; Virtual;
    Function SetDict(index: Integer; dict_name: WideString): Integer; Virtual;
    Function FaqCancel(): Integer; Virtual;
    Function FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; file_name: WideString; quality: Integer): Integer; Virtual;
    Function DecodeFile(file_name: WideString; pwd: WideString)
      : Integer; Virtual;
    Function GetNetTime(): WideString; Virtual;
    Function CheckFontSmooth(): Integer; Virtual;
    Function AsmClear(): Integer; Virtual;
    Function StrStr(s: WideString; str: WideString): Integer; Virtual;
    Function FindWindowByProcessId(process_id: Integer; class_name: WideString;
      title_name: WideString): Integer; Virtual;
    Function WriteIniPwd(section: WideString; key: WideString; v: WideString;
      file_name: WideString; pwd: WideString): Integer; Virtual;
    Function KeyPress(vk: Integer): Integer; Virtual;
    Function FaqIsPosted(): Integer; Virtual;
    Function ActiveInputMethod(hwnd: Integer; id: WideString): Integer; Virtual;
    Function BindWindow(hwnd: Integer; display: WideString; mouse: WideString;
      keypad: WideString; mode: Integer): Integer; Virtual;
    Function VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
      tpe: Integer; old_protect: Integer): Integer; Virtual;
    Function CreateFolder(folder_name: WideString): Integer; Virtual;
    Function GetPicSize(pic_name: WideString): WideString; Virtual;
    Function FindPicMemEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function SetMouseDelay(tpe: WideString; delay: Integer): Integer; Virtual;
    Function GetNowDict(): Integer; Virtual;
    Function GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString): WideString; Virtual;
    Function GetFileLength(file_name: WideString): Integer; Virtual;
    Function FindStrFastE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function FindInputMethod(id: WideString): Integer; Virtual;
    Function FaqPost(server: WideString; handle: Integer; request_type: Integer;
      time_out: Integer): Integer; Virtual;
    Function EnableSpeedDx(en: Integer): Integer; Virtual;
    Function MoveWindow(hwnd: Integer; x: Integer; y: Integer)
      : Integer; Virtual;
    Function Assemble(base_addr: Int64; is_64bit: Integer): WideString; Virtual;
    Function SwitchBindWindow(hwnd: Integer): Integer; Virtual;
    Function LockMouseRect(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : Integer; Virtual;
    Function SetDictMem(index: Integer; addr: Integer; size: Integer)
      : Integer; Virtual;
    Function InitCri(): Integer; Virtual;
    Function FindInt(hwnd: Integer; addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; tpe: Integer)
      : WideString; Virtual;
    Function SetDisplayDelay(t: Integer): Integer; Virtual;
    Function GetMouseSpeed(): Integer; Virtual;
    Function FoobarLock(hwnd: Integer): Integer; Virtual;
    Function VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
      tpe: Integer): Int64; Virtual;
    Function EnableShareDict(en: Integer): Integer; Virtual;
    Function FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function FaqSend(server: WideString; handle: Integer; request_type: Integer;
      time_out: Integer): WideString; Virtual;
    Function ReadFloatAddr(hwnd: Integer; addr: Int64): Single; Virtual;
    Function SetWordLineHeight(line_height: Integer): Integer; Virtual;
    Function EnableBind(en: Integer): Integer; Virtual;
    Function Is64Bit(): Integer; Virtual;
    Function FindDataEx(hwnd: Integer; addr_range: WideString; data: WideString;
      steps: Integer; multi_thread: Integer; mode: Integer)
      : WideString; Virtual;
    Function KeyDown(vk: Integer): Integer; Virtual;
    Function SetWindowText(hwnd: Integer; text: WideString): Integer; Virtual;
    Function WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer; v: Int64)
      : Integer; Virtual;
    Function EncodeFile(file_name: WideString; pwd: WideString)
      : Integer; Virtual;
    Function LoadPicByte(addr: Integer; size: Integer; name: WideString)
      : Integer; Virtual;
    Function GetScreenData(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : Integer; Virtual;
    Function GetClipboard(): WideString; Virtual;
    Function GetColorBGR(x: Integer; y: Integer): WideString; Virtual;
    Function FindStrFastS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): WideString; Virtual;
    Function CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer): Integer; Virtual;
    Function MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
      : WideString; Virtual;
    Function GetWindowRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant)
      : Integer; Virtual;
    Function SetWindowSize(hwnd: Integer; width: Integer; height: Integer)
      : Integer; Virtual;
    Function AsmCall(hwnd: Integer; mode: Integer): Int64; Virtual;
    Function SetScreen(width: Integer; height: Integer; depth: Integer)
      : Integer; Virtual;
    Function ClientToScreen(hwnd: Integer; var x: OleVariant; var y: OleVariant)
      : Integer; Virtual;
    Function FindWindow(class_name: WideString; title_name: WideString)
      : Integer; Virtual;
    Function WriteDataAddr(hwnd: Integer; addr: Int64; data: WideString)
      : Integer; Virtual;
    Function GetScreenWidth(): Integer; Virtual;
    Function FindColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function FindMultiColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      first_color: WideString; offset_color: WideString; sim: Double;
      dir: Integer): WideString; Virtual;
    Function GetWindowClass(hwnd: Integer): WideString; Virtual;
    Function CapturePre(file_name: WideString): Integer; Virtual;
    Function GetForegroundFocus(): Integer; Virtual;
    Function SetAero(en: Integer): Integer; Virtual;
    Function FoobarTextRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer; Virtual;
    Function FindMultiColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      first_color: WideString; offset_color: WideString; sim: Double;
      dir: Integer; out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function DownloadFile(url: WideString; save_file: WideString;
      timeout: Integer): Integer; Virtual;
    Function MatchPicName(pic_name: WideString): WideString; Virtual;
    Function Log(info: WideString): Integer; Virtual;
    Function GetCursorPos(out x: OleVariant; out y: OleVariant)
      : Integer; Virtual;
    Function GetMousePointWindow(): Integer; Virtual;
    Function GetDiskSerial(): WideString; Virtual;
    Function Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function ReadInt(hwnd: Integer; addr: WideString; tpe: Integer)
      : Int64; Virtual;
    Function GetWindowProcessId(hwnd: Integer): Integer; Virtual;
    Function AsmCallEx(hwnd: Integer; mode: Integer; base_addr: WideString)
      : Int64; Virtual;
    Function ClearDict(index: Integer): Integer; Virtual;
    Function Int64ToInt32(v: Int64): Integer; Virtual;
    Function SetDictPwd(pwd: WideString): Integer; Virtual;
    Function FaqFetch(): WideString; Virtual;
    Function GetSpecialWindow(flag: Integer): Integer; Virtual;
    Function EnablePicCache(en: Integer): Integer; Virtual;
    Function EnumIniKeyPwd(section: WideString; file_name: WideString;
      pwd: WideString): WideString; Virtual;
    Function SetClientSize(hwnd: Integer; width: Integer; height: Integer)
      : Integer; Virtual;
    Function SendString(hwnd: Integer; str: WideString): Integer; Virtual;
    Function WriteDoubleAddr(hwnd: Integer; addr: Int64; v: Double)
      : Integer; Virtual;
    Function ScreenToClient(hwnd: Integer; var x: OleVariant; var y: OleVariant)
      : Integer; Virtual;
    Function AsmSetTimeout(time_out: Integer; param: Integer): Integer; Virtual;
    Function WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
      v: WideString): Integer; Virtual;
    Function GetWordResultPos(str: WideString; index: Integer;
      out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function FoobarClearText(hwnd: Integer): Integer; Virtual;
    Function IsDisplayDead(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      t: Integer): Integer; Virtual;
    Function ReadDataToBin(hwnd: Integer; addr: WideString; length: Integer)
      : Integer; Virtual;
    Function WaitKey(key_code: Integer; time_out: Integer): Integer; Virtual;
    Function EnableKeypadPatch(en: Integer): Integer; Virtual;
    Function CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer; Virtual;
    Function CapturePng(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString): Integer; Virtual;
    Function MiddleUp(): Integer; Virtual;
    Function CmpColor(x: Integer; y: Integer; color: WideString; sim: Double)
      : Integer; Virtual;
    Function FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): WideString; Virtual;
    Function GetKeyState(vk: Integer): Integer; Virtual;
    Function FoobarSetSave(hwnd: Integer; file_name: WideString; en: Integer;
      header: WideString): Integer; Virtual;
    Function ReadFloat(hwnd: Integer; addr: WideString): Single; Virtual;
    Function LeftUp(): Integer; Virtual;
    Function ForceUnBindWindow(hwnd: Integer): Integer; Virtual;
    Function DeleteIniPwd(section: WideString; key: WideString;
      file_name: WideString; pwd: WideString): Integer; Virtual;
    Function FaqCapture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      quality: Integer; delay: Integer; time: Integer): Integer; Virtual;
    Function SetExitThread(en: Integer): Integer; Virtual;
    Function EnableDisplayDebug(enable_debug: Integer): Integer; Virtual;
    Function CaptureGif(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString; delay: Integer; time: Integer): Integer; Virtual;
    Function EnableMouseSync(en: Integer; time_out: Integer): Integer; Virtual;
    Function SetParam64ToPointer(): Integer; Virtual;
    Function FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function DelEnv(index: Integer; name: WideString): Integer; Virtual;
    Function GetCommandLine(hwnd: Integer): WideString; Virtual;
    Function FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): WideString; Virtual;
    Function FoobarUpdate(hwnd: Integer): Integer; Virtual;
    Function SelectFile(): WideString; Virtual;
    Function FindData(hwnd: Integer; addr_range: WideString; data: WideString)
      : WideString; Virtual;
    Function FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; color: WideString): Integer; Virtual;
    Function LockDisplay(locks: Integer): Integer; Virtual;
    Function WheelUp(): Integer; Virtual;
    Function Md5(str: WideString): WideString; Virtual;
    Function FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
      pic_name: WideString; repeat_limit: Integer; delay: Integer)
      : Integer; Virtual;
    Function MoveTo(x: Integer; y: Integer): Integer; Virtual;
    Function WriteDataFromBin(hwnd: Integer; addr: WideString; data: Integer;
      length: Integer): Integer; Virtual;
    Function SetEnv(index: Integer; name: WideString; value: WideString)
      : Integer; Virtual;
    Function StringToData(string_value: WideString; tpe: Integer)
      : WideString; Virtual;
    Function FreePic(pic_name: WideString): Integer; Virtual;
    Function EnableKeypadSync(en: Integer; time_out: Integer): Integer; Virtual;
    Function DeleteFolder(folder_name: WideString): Integer; Virtual;
    Function FindShape(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function FindStringEx(hwnd: Integer; addr_range: WideString;
      string_value: WideString; tpe: Integer; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function SaveDict(index: Integer; file_name: WideString): Integer; Virtual;
    Function GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; out data: OleVariant; out size: OleVariant)
      : Integer; Virtual;
    Function GetAveHSV(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString; Virtual;
    Function CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer; rw: Integer; rh: Integer): Integer; Virtual;
    Function GetDictInfo(str: WideString; font_name: WideString;
      font_size: Integer; flag: Integer): WideString; Virtual;
    Function GetAveRGB(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString; Virtual;
    Function UnLoadDriver(): Integer; Virtual;
    Function DisableCloseDisplayAndSleep(): Integer; Virtual;
    Function SetColGapNoDict(col_gap: Integer): Integer; Virtual;
  End;

  TNormalObj = Class(TInterfacedObject, IPighead)
  Private
    obj: IObj;
  Public
    Constructor Create();
    Destructor Destroy(); Override;

    Function SetRowGapNoDict(row_gap: Integer): Integer; Virtual;
    Function SetWordGapNoDict(word_gap: Integer): Integer; Virtual;
    Function FoobarSetFont(hwnd: Integer; font_name: WideString; size: Integer;
      flag: Integer): Integer; Virtual;
    Function SetParam64ToPointer(): Integer; Virtual;
    Function ReadFloat(hwnd: Integer; addr: WideString): Single; Virtual;
    Function SetUAC(uac: Integer): Integer; Virtual;
    Function FindShapeE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function RightDown(): Integer; Virtual;
    Function Capture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString): Integer; Virtual;
    Function SetMemoryFindResultToFile(file_name: WideString): Integer; Virtual;
    Function FoobarSetTrans(hwnd: Integer; trans: Integer; color: WideString;
      sim: Double): Integer; Virtual;
    Function FindPicExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function SetWordLineHeightNoDict(line_height: Integer): Integer; Virtual;
    Function FindFloat(hwnd: Integer; addr_range: WideString;
      float_value_min: Single; float_value_max: Single): WideString; Virtual;
    Function FindDouble(hwnd: Integer; addr_range: WideString;
      double_value_min: Double; double_value_max: Double): WideString; Virtual;
    Function LeaveCri(): Integer; Virtual;
    Function ReadDataAddrToBin(hwnd: Integer; addr: Int64; length: Integer)
      : Integer; Virtual;
    Function Reg(code: WideString; Ver: WideString): Integer; Virtual;
    Function EnumIniKey(section: WideString; file_name: WideString)
      : WideString; Virtual;
    Function SetDisplayAcceler(level: Integer): Integer; Virtual;
    Function ReadFloatAddr(hwnd: Integer; addr: Int64): Single; Virtual;
    Function SetEnv(index: Integer; name: WideString; value: WideString)
      : Integer; Virtual;
    Function GetDictCount(index: Integer): Integer; Virtual;
    Function ExitOs(tpe: Integer): Integer; Virtual;
    Function SetEnumWindowDelay(delay: Integer): Integer; Virtual;
    Function IsBind(hwnd: Integer): Integer; Virtual;
    Function LockInput(locks: Integer): Integer; Virtual;
    Function GetAveHSV(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString; Virtual;
    Function UseDict(index: Integer): Integer; Virtual;
    Function SetMemoryHwndAsProcessId(en: Integer): Integer; Virtual;
    Function Ocr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function SendCommand(cmd: WideString): Integer; Virtual;
    Function GetMouseSpeed(): Integer; Virtual;
    Function RightUp(): Integer; Virtual;
    Function Play(file_name: WideString): Integer; Virtual;
    Function FindFloatEx(hwnd: Integer; addr_range: WideString;
      float_value_min: Single; float_value_max: Single; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function EnablePicCache(en: Integer): Integer; Virtual;
    Function EnumIniKeyPwd(section: WideString; file_name: WideString;
      pwd: WideString): WideString; Virtual;
    Function HackSpeed(rate: Double): Integer; Virtual;
    Function GetDPI(): Integer; Virtual;
    Function AsmAdd(asm_ins: WideString): Integer; Virtual;
    Function FoobarDrawLine(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; color: WideString; style: Integer;
      width: Integer): Integer; Virtual;
    Function GetScreenData(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : Integer; Virtual;
    Function FindStrS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): WideString; Virtual;
    Function EnableRealMouse(en: Integer; mousedelay: Integer;
      mousestep: Integer): Integer; Virtual;
    Function GetCursorPos(out x: OleVariant; out y: OleVariant)
      : Integer; Virtual;
    Function FindStringEx(hwnd: Integer; addr_range: WideString;
      string_value: WideString; tpe: Integer; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function FindString(hwnd: Integer; addr_range: WideString;
      string_value: WideString; tpe: Integer): WideString; Virtual;
    Function EnableFontSmooth(): Integer; Virtual;
    Function GetFps(): Integer; Virtual;
    Function CaptureGif(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString; delay: Integer; time: Integer): Integer; Virtual;
    Function GetNetTimeByIp(ip: WideString): WideString; Virtual;
    Function EnumWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
      spec2: WideString; flag2: Integer; type2: Integer; sort: Integer)
      : WideString; Virtual;
    Function FindData(hwnd: Integer; addr_range: WideString; data: WideString)
      : WideString; Virtual;
    Function GetWordResultCount(str: WideString): Integer; Virtual;
    Function LeftDoubleClick(): Integer; Virtual;
    Function InitCri(): Integer; Virtual;
    Function ShowTaskBarIcon(hwnd: Integer; is_show: Integer): Integer; Virtual;
    Function CreateFoobarRoundRect(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer; rw: Integer; rh: Integer): Integer; Virtual;
    Function DisAssemble(asm_code: WideString; base_addr: Int64;
      is_64bit: Integer): WideString; Virtual;
    Function UnLoadDriver(): Integer; Virtual;
    Function GetPointWindow(x: Integer; y: Integer): Integer; Virtual;
    Function RightClick(): Integer; Virtual;
    Function WriteFile(file_name: WideString; content: WideString)
      : Integer; Virtual;
    Function FindColorBlockEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; color: WideString; sim: Double; count: Integer;
      width: Integer; height: Integer): WideString; Virtual;
    Function FoobarSetSave(hwnd: Integer; file_name: WideString; en: Integer;
      header: WideString): Integer; Virtual;
    Function EnableRealKeypad(en: Integer): Integer; Virtual;
    Function GetCursorShape(): WideString; Virtual;
    Function FindPicEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function SetAero(en: Integer): Integer; Virtual;
    Function VirtualQueryEx(hwnd: Integer; addr: Int64; pmbi: Integer)
      : WideString; Virtual;
    Function EnableMouseAccuracy(en: Integer): Integer; Virtual;
    Function CapturePre(file_name: WideString): Integer; Virtual;
    Function KeyPress(vk: Integer): Integer; Virtual;
    Function GetMac(): WideString; Virtual;
    Function SetDict(index: Integer; dict_name: WideString): Integer; Virtual;
    Function WriteData(hwnd: Integer; addr: WideString; data: WideString)
      : Integer; Virtual;
    Function FindWindowEx(parent: Integer; class_name: WideString;
      title_name: WideString): Integer; Virtual;
    Function FaqFetch(): WideString; Virtual;
    Function AddDict(index: Integer; dict_info: WideString): Integer; Virtual;
    Function DoubleToData(double_value: Double): WideString; Virtual;
    Function SaveDict(index: Integer; file_name: WideString): Integer; Virtual;
    Function FetchWord(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; word: WideString): WideString; Virtual;
    Function FoobarTextPrintDir(hwnd: Integer; dir: Integer): Integer; Virtual;
    Function GetCursorShapeEx(tpe: Integer): WideString; Virtual;
    Function CaptureJpg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString; quality: Integer): Integer; Virtual;
    Function SetWindowState(hwnd: Integer; flag: Integer): Integer; Virtual;
    Function SetColGapNoDict(col_gap: Integer): Integer; Virtual;
    Function FindPicS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): WideString; Virtual;
    Function ReadIni(section: WideString; key: WideString;
      file_name: WideString): WideString; Virtual;
    Function VirtualProtectEx(hwnd: Integer; addr: Int64; size: Integer;
      tpe: Integer; old_protect: Integer): Integer; Virtual;
    Function GetScreenDepth(): Integer; Virtual;
    Function FoobarStopGif(hwnd: Integer; x: Integer; y: Integer;
      pic_name: WideString): Integer; Virtual;
    Function MoveFile(src_file: WideString; dst_file: WideString)
      : Integer; Virtual;
    Function GetLastError(): Integer; Virtual;
    Function DelEnv(index: Integer; name: WideString): Integer; Virtual;
    Function GetEnv(index: Integer; name: WideString): WideString; Virtual;
    Function KeyUp(vk: Integer): Integer; Virtual;
    Function IsDisplayDead(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      t: Integer): Integer; Virtual;
    Function SetMouseDelay(tpe: WideString; delay: Integer): Integer; Virtual;
    Function SetClipboard(data: WideString): Integer; Virtual;
    Function SortPosDistance(all_pos: WideString; tpe: Integer; x: Integer;
      y: Integer): WideString; Virtual;
    Function SetLocale(): Integer; Virtual;
    Function SendString(hwnd: Integer; str: WideString): Integer; Virtual;
    Function FindPicMem(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function FindStrFast(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function IntToData(int_value: Int64; tpe: Integer): WideString; Virtual;
    Function RGB2BGR(rgb_color: WideString): WideString; Virtual;
    Function GetAveRGB(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : WideString; Virtual;
    Function GetCommandLine(hwnd: Integer): WideString; Virtual;
    Function DeleteFolder(folder_name: WideString): Integer; Virtual;
    Function DisableCloseDisplayAndSleep(): Integer; Virtual;
    Function FreeProcessMemory(hwnd: Integer): Integer; Virtual;
    Function GetWords(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function GetID(): Integer; Virtual;
    Function SetExitThread(en: Integer): Integer; Virtual;
    Function FindShape(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function SetScreen(width: Integer; height: Integer; depth: Integer)
      : Integer; Virtual;
    Function CheckFontSmooth(): Integer; Virtual;
    Function WheelUp(): Integer; Virtual;
    Function WriteFloatAddr(hwnd: Integer; addr: Int64; v: Single)
      : Integer; Virtual;
    Function WriteDoubleAddr(hwnd: Integer; addr: Int64; v: Double)
      : Integer; Virtual;
    Function RegExNoMac(code: WideString; Ver: WideString; ip: WideString)
      : Integer; Virtual;
    Function GetBasePath(): WideString; Virtual;
    Function SetWordGap(word_gap: Integer): Integer; Virtual;
    Function FindInputMethod(id: WideString): Integer; Virtual;
    Function WriteIniPwd(section: WideString; key: WideString; v: WideString;
      file_name: WideString; pwd: WideString): Integer; Virtual;
    Function RunApp(path: WideString; mode: Integer): Integer; Virtual;
    Function FoobarTextRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer; Virtual;
    Function SetDisplayDelay(t: Integer): Integer; Virtual;
    Function AsmSetTimeout(time_out: Integer; param: Integer): Integer; Virtual;
    Function GetTime(): Integer; Virtual;
    Function FaqIsPosted(): Integer; Virtual;
    Function delay(mis: Integer): Integer; Virtual;
    Function FaqCaptureString(str: WideString): Integer; Virtual;
    Function FindInt(hwnd: Integer; addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; tpe: Integer)
      : WideString; Virtual;
    Function MiddleClick(): Integer; Virtual;
    Function EnableShareDict(en: Integer): Integer; Virtual;
    Function KeyPressStr(key_str: WideString; delay: Integer): Integer; Virtual;
    Function FaqCaptureFromFile(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; file_name: WideString; quality: Integer): Integer; Virtual;
    Function FindColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function ReadFile(file_name: WideString): WideString; Virtual;
    Function FindNearestPos(all_pos: WideString; tpe: Integer; x: Integer;
      y: Integer): WideString; Virtual;
    Function EnumWindowByProcess(process_name: WideString; title: WideString;
      class_name: WideString; filter: Integer): WideString; Virtual;
    Function StrStr(s: WideString; str: WideString): Integer; Virtual;
    Function MiddleUp(): Integer; Virtual;
    Function GetScreenHeight(): Integer; Virtual;
    Function FindShapeEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      offset_color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function ReadStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      length: Integer): WideString; Virtual;
    Function CreateFoobarRect(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer): Integer; Virtual;
    Function FindWindow(class_name: WideString; title_name: WideString)
      : Integer; Virtual;
    Function ShowScrMsg(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      msg: WideString; color: WideString): Integer; Virtual;
    Function GetForegroundFocus(): Integer; Virtual;
    Function GetModuleBaseAddr(hwnd: Integer; module_name: WideString)
      : Int64; Virtual;
    Function FindStrFastExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function WriteIni(section: WideString; key: WideString; v: WideString;
      file_name: WideString): Integer; Virtual;
    Function EnableMouseMsg(en: Integer): Integer; Virtual;
    Function SetWordLineHeight(line_height: Integer): Integer; Virtual;
    Function EnumProcess(name: WideString): WideString; Virtual;
    Function CmpColor(x: Integer; y: Integer; color: WideString; sim: Double)
      : Integer; Virtual;
    Function SetSimMode(mode: Integer): Integer; Virtual;
    Function Md5(str: WideString): WideString; Virtual;
    Function SetDictMem(index: Integer; addr: Integer; size: Integer)
      : Integer; Virtual;
    Function ReadDouble(hwnd: Integer; addr: WideString): Double; Virtual;
    Function GetWordResultPos(str: WideString; index: Integer;
      out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function DownCpu(rate: Integer): Integer; Virtual;
    Function FindPicMemEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function EnumIniSection(file_name: WideString): WideString; Virtual;
    Function FindStr(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function FloatToData(float_value: Single): WideString; Virtual;
    Function SetWindowText(hwnd: Integer; text: WideString): Integer; Virtual;
    Function GetDisplayInfo(): WideString; Virtual;
    Function CheckInputMethod(hwnd: Integer; id: WideString): Integer; Virtual;
    Function FindColorEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function GetOsBuildNumber(): Integer; Virtual;
    Function FoobarUpdate(hwnd: Integer): Integer; Virtual;
    Function KeyDown(vk: Integer): Integer; Virtual;
    Function GetDiskSerial(): WideString; Virtual;
    Function ImageToBmp(pic_name: WideString; bmp_name: WideString)
      : Integer; Virtual;
    Function BindWindow(hwnd: Integer; display: WideString; mouse: WideString;
      keypad: WideString; mode: Integer): Integer; Virtual;
    Function FindColorBlock(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; count: Integer; width: Integer;
      height: Integer; out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function FindMultiColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      first_color: WideString; offset_color: WideString; sim: Double;
      dir: Integer; out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function FreePic(pic_name: WideString): Integer; Virtual;
    Function GetNetTime(): WideString; Virtual;
    Function BindWindowEx(hwnd: Integer; display: WideString; mouse: WideString;
      keypad: WideString; public_desc: WideString; mode: Integer)
      : Integer; Virtual;
    Function WriteString(hwnd: Integer; addr: WideString; tpe: Integer;
      v: WideString): Integer; Virtual;
    Function Assemble(base_addr: Int64; is_64bit: Integer): WideString; Virtual;
    Function SetDisplayInput(mode: WideString): Integer; Virtual;
    Function FaqPost(server: WideString; handle: Integer; request_type: Integer;
      time_out: Integer): Integer; Virtual;
    Function ReadInt(hwnd: Integer; addr: WideString; tpe: Integer)
      : Int64; Virtual;
    Function FindPicE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function DeleteFile(file_name: WideString): Integer; Virtual;
    Function SendStringIme(str: WideString): Integer; Virtual;
    Function GetCursorSpot(): WideString; Virtual;
    Function GetMachineCode(): WideString; Virtual;
    Function FaqCapture(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      quality: Integer; delay: Integer; time: Integer): Integer; Virtual;
    Function DisablePowerSave(): Integer; Virtual;
    Function SelectFile(): WideString; Virtual;
    Function GetRealPath(path: WideString): WideString; Virtual;
    Function LeftUp(): Integer; Virtual;
    Function GetWindowState(hwnd: Integer; flag: Integer): Integer; Virtual;
    Function GetClientRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant)
      : Integer; Virtual;
    Function EnumWindow(parent: Integer; title: WideString;
      class_name: WideString; filter: Integer): WideString; Virtual;
    Function ReadDoubleAddr(hwnd: Integer; addr: Int64): Double; Virtual;
    Function DmGuardParams(cmd: WideString; sub_cmd: WideString;
      param: WideString): WideString; Virtual;
    Function SetMouseSpeed(speed: Integer): Integer; Virtual;
    Function FindMultiColorEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; first_color: WideString; offset_color: WideString;
      sim: Double; dir: Integer): WideString; Virtual;
    Function FindStrExS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function FaqSend(server: WideString; handle: Integer; request_type: Integer;
      time_out: Integer): WideString; Virtual;
    Function FaqCancel(): Integer; Virtual;
    Function GetResultCount(str: WideString): Integer; Virtual;
    Function RegEx(code: WideString; Ver: WideString; ip: WideString)
      : Integer; Virtual;
    Function SetClientSize(hwnd: Integer; width: Integer; height: Integer)
      : Integer; Virtual;
    Function GetWindowTitle(hwnd: Integer): WideString; Virtual;
    Function WaitKey(key_code: Integer; time_out: Integer): Integer; Virtual;
    Function CopyFile(src_file: WideString; dst_file: WideString; over: Integer)
      : Integer; Virtual;
    Function GetColor(x: Integer; y: Integer): WideString; Virtual;
    Function ActiveInputMethod(hwnd: Integer; id: WideString): Integer; Virtual;
    Function EnableFakeActive(en: Integer): Integer; Virtual;
    Function FindStrWithFontEx(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; str: WideString; color: WideString; sim: Double;
      font_name: WideString; font_size: Integer; flag: Integer)
      : WideString; Virtual;
    Function GetDictInfo(str: WideString; font_name: WideString;
      font_size: Integer; flag: Integer): WideString; Virtual;
    Function FaqRelease(handle: Integer): Integer; Virtual;
    Function FindStrWithFontE(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; str: WideString; color: WideString; sim: Double;
      font_name: WideString; font_size: Integer; flag: Integer)
      : WideString; Virtual;
    Function OcrExOne(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function ClientToScreen(hwnd: Integer; var x: OleVariant; var y: OleVariant)
      : Integer; Virtual;
    Function Ver(): WideString; Virtual;
    Function KeyPressChar(key_str: WideString): Integer; Virtual;
    Function Delays(min_s: Integer; max_s: Integer): Integer; Virtual;
    Function GetFileLength(file_name: WideString): Integer; Virtual;
    Function SendPaste(hwnd: Integer): Integer; Virtual;
    Function FindMulColor(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): Integer; Virtual;
    Function AsmClear(): Integer; Virtual;
    Function ClearDict(index: Integer): Integer; Virtual;
    Function ExecuteCmd(cmd: WideString; current_dir: WideString;
      time_out: Integer): WideString; Virtual;
    Function GetWindowRect(hwnd: Integer; out x1: OleVariant;
      out y1: OleVariant; out x2: OleVariant; out y2: OleVariant)
      : Integer; Virtual;
    Function EnumIniSectionPwd(file_name: WideString; pwd: WideString)
      : WideString; Virtual;
    Function OcrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): WideString; Virtual;
    Function SendString2(hwnd: Integer; str: WideString): Integer; Virtual;
    Function KeyUpChar(key_str: WideString): Integer; Virtual;
    Function VirtualAllocEx(hwnd: Integer; addr: Int64; size: Integer;
      tpe: Integer): Int64; Virtual;
    Function FindStrFastEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function ScreenToClient(hwnd: Integer; var x: OleVariant; var y: OleVariant)
      : Integer; Virtual;
    Function FindStrFastE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function GetKeyState(vk: Integer): Integer; Virtual;
    Function GetScreenWidth(): Integer; Virtual;
    Function GetProcessInfo(pid: Integer): WideString; Virtual;
    Function GetDict(index: Integer; font_index: Integer): WideString; Virtual;
    Function SelectDirectory(): WideString; Virtual;
    Function GetClientSize(hwnd: Integer; out width: OleVariant;
      out height: OleVariant): Integer; Virtual;
    Function WriteDataFromBin(hwnd: Integer; addr: WideString; data: Integer;
      length: Integer): Integer; Virtual;
    Function FindPic(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; delta_color: WideString; sim: Double; dir: Integer;
      out x: OleVariant; out y: OleVariant): Integer; Virtual;
    Function ExcludePos(all_pos: WideString; tpe: Integer; x1: Integer;
      y1: Integer; x2: Integer; y2: Integer): WideString; Virtual;
    Function GetWindow(hwnd: Integer; flag: Integer): Integer; Virtual;
    Function MoveDD(dx: Integer; dy: Integer): Integer; Virtual;
    Function FoobarClose(hwnd: Integer): Integer; Virtual;
    Function GetWordsNoDict(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString): WideString; Virtual;
    Function FindStrWithFont(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; font_name: WideString;
      font_size: Integer; flag: Integer; out x: OleVariant; out y: OleVariant)
      : Integer; Virtual;
    Function GetLocale(): Integer; Virtual;
    Function ReadFileData(file_name: WideString; start_pos: Integer;
      end_pos: Integer): WideString; Virtual;
    Function FoobarDrawText(hwnd: Integer; x: Integer; y: Integer; w: Integer;
      h: Integer; text: WideString; color: WideString; align: Integer)
      : Integer; Virtual;
    Function ReadIniPwd(section: WideString; key: WideString;
      file_name: WideString; pwd: WideString): WideString; Virtual;
    Function KeyDownChar(key_str: WideString): Integer; Virtual;
    Function SetDictPwd(pwd: WideString): Integer; Virtual;
    Function EnumWindowByProcessId(pid: Integer; title: WideString;
      class_name: WideString; filter: Integer): WideString; Virtual;
    Function DmGuard(en: Integer; tpe: WideString): Integer; Virtual;
    Function GetRemoteApiAddress(hwnd: Integer; base_addr: Int64;
      fun_name: WideString): Int64; Virtual;
    Function SetKeypadDelay(tpe: WideString; delay: Integer): Integer; Virtual;
    Function LeftClick(): Integer; Virtual;
    Function CreateFoobarCustom(hwnd: Integer; x: Integer; y: Integer;
      pic: WideString; trans_color: WideString; sim: Double): Integer; Virtual;
    Function IsFolderExist(folder: WideString): Integer; Virtual;
    Function MiddleDown(): Integer; Virtual;
    Function GetDir(tpe: Integer): WideString; Virtual;
    Function CheckUAC(): Integer; Virtual;
    Function FaqGetSize(handle: Integer): Integer; Virtual;
    Function FindStrEx(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function LockDisplay(locks: Integer): Integer; Virtual;
    Function FoobarClearText(hwnd: Integer): Integer; Virtual;
    Function FindDoubleEx(hwnd: Integer; addr_range: WideString;
      double_value_min: Double; double_value_max: Double; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function FindIntEx(hwnd: Integer; addr_range: WideString;
      int_value_min: Int64; int_value_max: Int64; tpe: Integer; steps: Integer;
      multi_thread: Integer; mode: Integer): WideString; Virtual;
    Function EncodeFile(file_name: WideString; pwd: WideString)
      : Integer; Virtual;
    Function BGR2RGB(bgr_color: WideString): WideString; Virtual;
    Function GetSpecialWindow(flag: Integer): Integer; Virtual;
    Function CreateFolder(folder_name: WideString): Integer; Virtual;
    Function SpeedNormalGraphic(en: Integer): Integer; Virtual;
    Function WriteDataAddrFromBin(hwnd: Integer; addr: Int64; data: Integer;
      length: Integer): Integer; Virtual;
    Function UnBindWindow(): Integer; Virtual;
    Function DeleteIni(section: WideString; key: WideString;
      file_name: WideString): Integer; Virtual;
    Function ReadDataAddr(hwnd: Integer; addr: Int64; length: Integer)
      : WideString; Virtual;
    Function WriteInt(hwnd: Integer; addr: WideString; tpe: Integer; v: Int64)
      : Integer; Virtual;
    Function OpenProcess(pid: Integer): Integer; Virtual;
    Function AsmCallEx(hwnd: Integer; mode: Integer; base_addr: WideString)
      : Int64; Virtual;
    Function SetShowErrorMsg(show: Integer): Integer; Virtual;
    Function SetWindowTransparent(hwnd: Integer; v: Integer): Integer; Virtual;
    Function FindWindowSuper(spec1: WideString; flag1: Integer; type1: Integer;
      spec2: WideString; flag2: Integer; type2: Integer): Integer; Virtual;
    Function WriteFloat(hwnd: Integer; addr: WideString; v: Single)
      : Integer; Virtual;
    Function EnableKeypadPatch(en: Integer): Integer; Virtual;
    Function GetCpuType(): Integer; Virtual;
    Function SetExportDict(index: Integer; dict_name: WideString)
      : Integer; Virtual;
    Function LockMouseRect(x1: Integer; y1: Integer; x2: Integer; y2: Integer)
      : Integer; Virtual;
    Function TerminateProcess(pid: Integer): Integer; Virtual;
    Function EnableIme(en: Integer): Integer; Virtual;
    Function Is64Bit(): Integer; Virtual;
    Function OcrInFile(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_name: WideString; color: WideString; sim: Double)
      : WideString; Virtual;
    Function DownloadFile(url: WideString; save_file: WideString;
      timeout: Integer): Integer; Virtual;
    Function GetMachineCodeNoMac(): WideString; Virtual;
    Function SetExcludeRegion(tpe: Integer; info: WideString): Integer; Virtual;
    Function GetWindowProcessId(hwnd: Integer): Integer; Virtual;
    Function FindMultiColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      first_color: WideString; offset_color: WideString; sim: Double;
      dir: Integer): WideString; Virtual;
    Function GetColorNum(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double): Integer; Virtual;
    Function FoobarPrintText(hwnd: Integer; text: WideString; color: WideString)
      : Integer; Virtual;
    Function FoobarFillRect(hwnd: Integer; x1: Integer; y1: Integer;
      x2: Integer; y2: Integer; color: WideString): Integer; Virtual;
    Function Beep(fre: Integer; delay: Integer): Integer; Virtual;
    Function GetColorHSV(x: Integer; y: Integer): WideString; Virtual;
    Function SwitchBindWindow(hwnd: Integer): Integer; Virtual;
    Function MoveToEx(x: Integer; y: Integer; w: Integer; h: Integer)
      : WideString; Virtual;
    Function WheelDown(): Integer; Virtual;
    Function ReadString(hwnd: Integer; addr: WideString; tpe: Integer;
      length: Integer): WideString; Virtual;
    Function MoveR(rx: Integer; ry: Integer): Integer; Virtual;
    Function GetNowDict(): Integer; Virtual;
    Function WriteDouble(hwnd: Integer; addr: WideString; v: Double)
      : Integer; Virtual;
    Function WriteIntAddr(hwnd: Integer; addr: Int64; tpe: Integer; v: Int64)
      : Integer; Virtual;
    Function CreateFoobarEllipse(hwnd: Integer; x: Integer; y: Integer;
      w: Integer; h: Integer): Integer; Virtual;
    Function EnableKeypadMsg(en: Integer): Integer; Virtual;
    Function ReleaseRef(): Integer; Virtual;
    Function DeleteIniPwd(section: WideString; key: WideString;
      file_name: WideString; pwd: WideString): Integer; Virtual;
    Function GetWordResultStr(str: WideString; index: Integer)
      : WideString; Virtual;
    Function FoobarUnlock(hwnd: Integer): Integer; Virtual;
    Function SetPicPwd(pwd: WideString): Integer; Virtual;
    Function GetWindowClass(hwnd: Integer): WideString; Virtual;
    Function EnableKeypadSync(en: Integer; time_out: Integer): Integer; Virtual;
    Function DisableScreenSave(): Integer; Virtual;
    Function GetNetTimeSafe(): WideString; Virtual;
    Function FoobarDrawPic(hwnd: Integer; x: Integer; y: Integer;
      pic: WideString; trans_color: WideString): Integer; Virtual;
    Function WriteStringAddr(hwnd: Integer; addr: Int64; tpe: Integer;
      v: WideString): Integer; Virtual;
    Function GetResultPos(str: WideString; index: Integer; out x: OleVariant;
      out y: OleVariant): Integer; Virtual;
    Function StringToData(string_value: WideString; tpe: Integer)
      : WideString; Virtual;
    Function GetOsType(): Integer; Virtual;
    Function GetForegroundWindow(): Integer; Virtual;
    Function LoadPic(pic_name: WideString): Integer; Virtual;
    Function SetMinColGap(col_gap: Integer): Integer; Virtual;
    Function GetWindowProcessPath(hwnd: Integer): WideString; Virtual;
    Function SetExactOcr(exact_ocr: Integer): Integer; Virtual;
    Function DisableFontSmooth(): Integer; Virtual;
    Function GetColorBGR(x: Integer; y: Integer): WideString; Virtual;
    Function EnableMouseSync(en: Integer; time_out: Integer): Integer; Virtual;
    Function FoobarTextLineGap(hwnd: Integer; gap: Integer): Integer; Virtual;
    Function SetDisplayRefreshDelay(t: Integer): Integer; Virtual;
    Function FindStrE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double): WideString; Virtual;
    Function VirtualFreeEx(hwnd: Integer; addr: Int64): Integer; Virtual;
    Function GetBindWindow(): Integer; Virtual;
    Function DecodeFile(file_name: WideString; pwd: WideString)
      : Integer; Virtual;
    Function GetDmCount(): Integer; Virtual;
    Function EnableBind(en: Integer): Integer; Virtual;
    Function FindWindowByProcessId(process_id: Integer; class_name: WideString;
      title_name: WideString): Integer; Virtual;
    Function ReadData(hwnd: Integer; addr: WideString; length: Integer)
      : WideString; Virtual;
    Function MoveTo(x: Integer; y: Integer): Integer; Virtual;
    Function LoadPicByte(addr: Integer; size: Integer; name: WideString)
      : Integer; Virtual;
    Function GetScreenDataBmp(x1: Integer; y1: Integer; x2: Integer;
      y2: Integer; out data: OleVariant; out size: OleVariant)
      : Integer; Virtual;
    Function FindDataEx(hwnd: Integer; addr_range: WideString; data: WideString;
      steps: Integer; multi_thread: Integer; mode: Integer)
      : WideString; Virtual;
    Function FindWindowByProcess(process_name: WideString;
      class_name: WideString; title_name: WideString): Integer; Virtual;
    Function IsFileExist(file_name: WideString): Integer; Virtual;
    Function SetMinRowGap(row_gap: Integer): Integer; Virtual;
    Function GetPicSize(pic_name: WideString): WideString; Virtual;
    Function WriteDataAddr(hwnd: Integer; addr: Int64; data: WideString)
      : Integer; Virtual;
    Function EnterCri(): Integer; Virtual;
    Function EnableGetColorByCapture(en: Integer): Integer; Virtual;
    Function RegNoMac(code: WideString; Ver: WideString): Integer; Virtual;
    Function SendStringIme2(hwnd: Integer; str: WideString; mode: Integer)
      : Integer; Virtual;
    Function GetMousePointWindow(): Integer; Virtual;
    Function AsmCall(hwnd: Integer; mode: Integer): Int64; Virtual;
    Function SetWindowSize(hwnd: Integer; width: Integer; height: Integer)
      : Integer; Virtual;
    Function FindColorE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      color: WideString; sim: Double; dir: Integer): WideString; Virtual;
    Function ReadDataToBin(hwnd: Integer; addr: WideString; length: Integer)
      : Integer; Virtual;
    Function EnableDisplayDebug(enable_debug: Integer): Integer; Virtual;
    Function SetPath(path: WideString): Integer; Virtual;
    Function FoobarStartGif(hwnd: Integer; x: Integer; y: Integer;
      pic_name: WideString; repeat_limit: Integer; delay: Integer)
      : Integer; Virtual;
    Function FreeScreenData(handle: Integer): Integer; Virtual;
    Function CapturePng(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      file_name: WideString): Integer; Virtual;
    Function AppendPicAddr(pic_info: WideString; addr: Integer; size: Integer)
      : WideString; Virtual;
    Function MatchPicName(pic_name: WideString): WideString; Virtual;
    Function FoobarLock(hwnd: Integer): Integer; Virtual;
    Function FindPicMemE(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      pic_info: WideString; delta_color: WideString; sim: Double; dir: Integer)
      : WideString; Virtual;
    Function ForceUnBindWindow(hwnd: Integer): Integer; Virtual;
    Function MoveWindow(hwnd: Integer; x: Integer; y: Integer)
      : Integer; Virtual;
    Function FindStrFastS(x1: Integer; y1: Integer; x2: Integer; y2: Integer;
      str: WideString; color: WideString; sim: Double; out x: OleVariant;
      out y: OleVariant): WideString; Virtual;
    Function GetPath(): WideString; Virtual;
    Function Stop(id: Integer): Integer; Virtual;
    Function ReadIntAddr(hwnd: Integer; addr: Int64; tpe: Integer)
      : Int64; Virtual;
    Function Int64ToInt32(v: Int64): Integer; Virtual;
    Function LeftDown(): Integer; Virtual;
    Function Log(info: WideString): Integer; Virtual;
    Function GetClipboard(): WideString; Virtual;
    Function EnableSpeedDx(en: Integer): Integer; Virtual;
  End;
