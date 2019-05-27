unit uGame;

interface

uses
  uLd, System.SysUtils;

type
  TGame = class
  end;

  TGameManger = class
  public
    procedure StartAll; //运行所有
    procedure StartAllExist; //运行已经打开的窗口
    procedure StopAll; //停止所有
    procedure SortWnd; //排序
  end;

implementation

{ TGameManger }

procedure TGameManger.SortWnd;
begin
  TLd.SortWnd;
end;

procedure TGameManger.StartAll;
begin

end;

procedure TGameManger.StartAllExist;
begin

end;

procedure TGameManger.StopAll;
begin

end;

end.

