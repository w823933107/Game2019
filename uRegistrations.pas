unit uRegistrations;

interface

uses Spring.Container;

procedure RegisterTypes(const Container: TContainer);

implementation

uses uGameManager, uObj, uGame;

procedure RegisterTypes(const Container: TContainer);
begin
  Container.RegisterType<TNormalObj>; // ������ͨ����
  Container.RegisterType<TGame>;
  Container.RegisterType<TGameManger>;
  Container.Build;
end;

end.
