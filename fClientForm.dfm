object ClientForm: TClientForm
  Left = 372
  Top = 277
  Caption = 'RemObjects Client'
  ClientHeight = 499
  ClientWidth = 652
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 652
    Height = 345
    ActivePage = tsBase
    Align = alTop
    TabOrder = 0
    object tsEmulator: TTabSheet
      Caption = 'Emulator'
      object lblEmulatorIndex: TLabel
        Left = 3
        Top = 3
        Width = 70
        Height = 13
        Caption = 'EmulatorIndex'
      end
      object lblPackageName: TLabel
        Left = 134
        Top = 6
        Width = 67
        Height = 13
        Caption = 'PackageName'
      end
      object btnLaunch: TButton
        Left = 3
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Launch'
        TabOrder = 0
        OnClick = btnLaunchClick
      end
      object btnQuit: TButton
        Left = 94
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Quit'
        TabOrder = 1
        OnClick = btnQuitClick
      end
      object btnQuitAll: TButton
        Left = 185
        Top = 40
        Width = 75
        Height = 25
        Caption = 'QuitAll'
        TabOrder = 2
        OnClick = btnQuitAllClick
      end
      object edtEmulatorIndex: TEdit
        Left = 79
        Top = 3
        Width = 49
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        Text = '0'
      end
      object edtPackageName: TEdit
        Left = 207
        Top = 3
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'com.tencent.ssss'
      end
      object btnRunApp: TButton
        Left = 277
        Top = 40
        Width = 75
        Height = 25
        Caption = 'RunApp'
        TabOrder = 5
        OnClick = btnRunAppClick
      end
      object btnKillApp: TButton
        Left = 368
        Top = 40
        Width = 75
        Height = 25
        Caption = 'KillApp'
        TabOrder = 6
        OnClick = btnKillAppClick
      end
      object btnList2: TButton
        Left = 464
        Top = 40
        Width = 75
        Height = 25
        Caption = 'List2'
        TabOrder = 7
        OnClick = btnList2Click
      end
    end
    object tsBase: TTabSheet
      Caption = 'Base'
      ImageIndex = 1
      object btnStart: TButton
        Left = 0
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Start'
        TabOrder = 0
        OnClick = btnStartClick
      end
      object btnStop: TButton
        Left = 3
        Top = 78
        Width = 75
        Height = 25
        Caption = 'Stop'
        TabOrder = 1
        OnClick = btnStopClick
      end
      object btnStartExistWnds: TButton
        Left = 3
        Top = 47
        Width = 75
        Height = 25
        Caption = 'StartExistWnds'
        TabOrder = 2
        OnClick = btnStartExistWndsClick
      end
      object btnSortWnd: TButton
        Left = 3
        Top = 109
        Width = 75
        Height = 25
        Caption = 'SortWnd'
        TabOrder = 3
        OnClick = btnSortWndClick
      end
      object btnTest: TButton
        Left = 216
        Top = 96
        Width = 75
        Height = 25
        Caption = 'btnTest'
        TabOrder = 4
        OnClick = btnTestClick
      end
    end
  end
  object mmoLog: TMemo
    Left = 0
    Top = 345
    Width = 652
    Height = 154
    Align = alClient
    Lines.Strings = (
      'mmoLog')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ROMessage: TROBinMessage
    Envelopes = <>
    Left = 608
    Top = 359
  end
  object ROChannel: TROWinInetHTTPChannel
    UserAgent = 'Remoting SDK'
    DispatchOptions = []
    ServerLocators = <>
    TargetUrl = 'http://127.0.0.1:8099/bin'
    TrustInvalidCA = False
    Left = 608
    Top = 455
  end
  object RORemoteService: TRORemoteService
    ServiceName = 'GameService'
    Channel = ROChannel
    Message = ROMessage
    Left = 608
    Top = 407
  end
  object OEM: TOmniEventMonitor
    OnTaskMessage = OEMTaskMessage
    OnTaskTerminated = OEMTaskTerminated
    Left = 608
    Top = 311
  end
end
