program GameConsole;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.StrUtils,
  GameLibrary_Intf in 'GameLibrary_Intf.pas',
  GameLibrary_ServerAccess in 'GameLibrary_ServerAccess.pas' {ServerAccess_GameLibrary: TDataModule},
  uObj in 'uObj.pas',
  uGameManager in 'uGameManager.pas',
  uLd in 'uLd.pas',
  uConfig in 'uConfig.pas',
  uComm in 'uComm.pas';

function ParseCmd(comm: string; var countParam: Integer; var op: string): TArray<string>;
var
  arr: TArray<string>;
  I: Integer;
  ls: string;
  hasGet: Boolean;
begin
  ls := LowerCase(comm);
  arr := ls.Split([' ']);
  hasGet := False;
  op := '';
  countParam := 0;
  Result := [];
  for I := Low(arr) to High(arr) do
  begin
    if arr[I] <> '' then
    begin
      if hasGet then
      begin
        Result := Result + [arr[I]]
      end
      else
      begin
        op := arr[I];
        hasGet := True;
      end;

    end;
  end;
  countParam := Length(Result);
end;

procedure KeyEnterContinue();
begin
  Write('key enter continue');
  Readln;
end;

procedure ShowHelper();
begin
  Writeln('-h --help');
  Writeln('-l --lanch [index]');
  Writeln('-le --LanchEx [index] [package name]');
  Writeln('-q --quit [index]');
  Writeln('-ls2 --list2');
  Writeln('-lp --ListPackages [index]');
  Writeln('-stg|1 --StartGame');
  Writeln('-spg|2 --StopGame');
  Writeln('-t --test');
end;

procedure TestLd();
var
  sCommandline: string;
  param: Integer;
  paramIntArr: array[0..50] of Integer;
  paramIntStr: array[0..50] of string;
  paramArr: TArray<string>;
  countParam: Integer;
  op: string;
begin
  ShowHelper();
  while True do
  begin
    try
      Write('>>');
      Readln(sCommandline);
      paramArr := ParseCmd(sCommandline, countParam, op);
      if op = '' then
      begin
        Writeln('input ', sCommandline, ' error');
        Continue;
      end;

      if (op = '-l') or (op = '--lanch') then
      begin
        if countParam = 1 then
        begin
          TLd.Launch(paramArr[0].ToInteger());
          Writeln('launch emulator:', paramArr[0]);
          Continue;
        end;

      end;
      if (op = '-le') or (op = '--LanchEx') then
      begin
        if countParam = 2 then
        begin
          TLd.LaunchEx(paramArr[0].ToInteger, paramArr[1]);
          Writeln('launch emulator ', paramArr[0], ' and runapp ', paramArr[1]);
          Continue;
        end;
      end;
      if (op = '-q') or (op = '--quit') then
      begin
        if countParam = 1 then
        begin
          TLd.Quit(paramArr[0].ToInteger());
          Writeln(' emulator ', paramArr[0], ' quit');
          Continue;
        end;
      end;
      if (op = '-ls2') or (op = '--list2') then
      begin
        Writeln(TLd.List2());
        Continue;
      end;
      if (op = '-lp') or (op = '--ListPackages') then
      begin
        if countParam = 1 then
        begin
          Writeln(TLd.ListPackages(paramArr[0].ToInteger()));

          Continue;
        end;

      end;

      if (op = '-spg') or (op = '--StartGame') or (op = '1') then
      begin
        Writeln('StartGame');
        Continue;
      end;
      if (op = '-stg') or (op = '--StopGame') or (op = '2') then
      begin
        Writeln('StopGame');
        Continue;

      end;
      if (op = '-t') or (op = '--test') then
      begin
        // TLd.Modify(0, 0, 0, 0, 0, 0, '', '', '15351808327', '', '', '', '',
        // '', '', '');
        // TLd.GlobalSetting(60, 1,1, 1);
        // Writeln(TLd.List2);
        // paramIntStr[0] := TLd.ListPackages(0);
        // Writeln(paramIntStr[0]);

        Continue;
        //
        // var arr: tarray<TEmulatorInfo> := TLd.List2Ex;
        // if Length(arr) > 0 then
        // Writeln(arr[0].BindHwnd);
      end;
      if (op = '-h') or (op = '--help') then
      begin
        ShowHelper;
      end;

      Writeln('input unknown');

    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;

  end;

end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    // 命令行参数索引从1到后面,空格自动分割

    // s := (ServerAccess.GameService as IGameService).Helloworld();
    // Writeln(s);
    TLd.FilePath := LD_PATCH;
    // TLd.QuitAll;
    TestLd;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.

