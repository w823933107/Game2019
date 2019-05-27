object ServerAccess_GameLibrary: TServerAccess_GameLibrary
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Message: TROBinMessage
    Envelopes = <>
    DefaultNamespaces = 'GameLibrary'
    Left = 40
    Top = 24
  end
  object Channel: TROIndyHTTPChannel
    UserAgent = 'Remoting SDK'
    DispatchOptions = []
    ServerLocators = <>
    TargetUrl = 'http://localhost:8099/bin'
    IndyClient.AllowCookies = True
    IndyClient.ProxyParams.BasicAuthentication = False
    IndyClient.ProxyParams.ProxyPort = 0
    IndyClient.Request.ContentLength = -1
    IndyClient.Request.ContentRangeEnd = -1
    IndyClient.Request.ContentRangeStart = -1
    IndyClient.Request.ContentRangeInstanceLength = -1
    IndyClient.Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    IndyClient.Request.BasicAuthentication = False
    IndyClient.Request.Host = 'localhost:8099'
    IndyClient.Request.UserAgent = 'Remoting SDK'
    IndyClient.Request.Ranges.Units = 'bytes'
    IndyClient.Request.Ranges = <>
    IndyClient.HTTPOptions = [hoKeepOrigProtocol, hoForceEncodeParams]
    Left = 40
    Top = 80
  end
end
