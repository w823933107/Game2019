object ServerForm: TServerForm
  Left = 372
  Top = 277
  BorderStyle = bsDialog
  Caption = 'RemObjects Server'
  ClientHeight = 64
  ClientWidth = 228
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ROPoweredByRemObjectsButton1: TROPoweredByRemObjectsButton
    Left = 8
    Top = 8
    Width = 212
    Height = 48
    Cursor = crHandPoint
  end
  object ROMessage: TROBinMessage
    Envelopes = <>
    Left = 36
    Top = 8
  end
  object ROServer: TROIndyHTTPServer
    Dispatchers = <
      item
        Name = 'ROMessage'
        Message = ROMessage
        Enabled = True
        PathInfo = 'Bin'
      end>
    SendClientAccessPolicyXml = captAllowAll
    IndyServer.Bindings = <>
    IndyServer.DefaultPort = 8099
    Port = 8099
    Left = 8
    Top = 8
  end
end
