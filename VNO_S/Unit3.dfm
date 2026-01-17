object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Visual Novel Online IRC Server'
  ClientHeight = 383
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object edit_ooc: TEdit
    Left = 8
    Top = 302
    Width = 505
    Height = 21
    TabOrder = 27
    OnKeyPress = edit_oocKeyPress
  end
  object Memo2: TMemo
    Left = 8
    Top = 39
    Width = 505
    Height = 284
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 19
  end
  object button_reload: TButton
    Left = 519
    Top = 279
    Width = 58
    Height = 25
    Caption = 'Reload'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Visible = False
    OnClick = button_reloadClick
  end
  object Button1: TButton
    Left = 519
    Top = 186
    Width = 59
    Height = 25
    Caption = 'IPBan'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 519
    Top = 217
    Width = 58
    Height = 25
    Caption = 'UserBan'
    TabOrder = 2
  end
  object Button3: TButton
    Left = 519
    Top = 124
    Width = 58
    Height = 25
    Caption = 'Mute'
    TabOrder = 3
  end
  object Button4: TButton
    Left = 519
    Top = 155
    Width = 58
    Height = 25
    Caption = 'Unmute'
    TabOrder = 4
  end
  object Button5: TButton
    Left = 519
    Top = 248
    Width = 58
    Height = 25
    Caption = 'Discon.'
    TabOrder = 5
  end
  object Button7: TButton
    Left = 519
    Top = 93
    Width = 58
    Height = 25
    Caption = 'Kick'
    TabOrder = 6
  end
  object ListBox_user: TListBox
    Left = 8
    Top = 39
    Width = 505
    Height = 284
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 7
  end
  object Button6: TButton
    Left = 8
    Top = 329
    Width = 57
    Height = 25
    Caption = 'Server'
    TabOrder = 8
  end
  object Button8: TButton
    Left = 8
    Top = 8
    Width = 57
    Height = 25
    Caption = 'settings'
    TabOrder = 9
  end
  object Button9: TButton
    Left = 64
    Top = 8
    Width = 57
    Height = 25
    Caption = 'init'
    TabOrder = 10
  end
  object Button10: TButton
    Left = 120
    Top = 8
    Width = 57
    Height = 25
    Caption = 'music'
    TabOrder = 11
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 176
    Top = 8
    Width = 57
    Height = 25
    Caption = 'areas'
    TabOrder = 12
    OnClick = Button11Click
  end
  object Button13: TButton
    Left = 232
    Top = 8
    Width = 57
    Height = 25
    Caption = 'items'
    TabOrder = 13
  end
  object Button14: TButton
    Left = 288
    Top = 8
    Width = 57
    Height = 25
    Caption = 'ban'
    TabOrder = 14
  end
  object Button15: TButton
    Left = 344
    Top = 8
    Width = 57
    Height = 25
    Caption = 'ipban'
    TabOrder = 15
  end
  object Button16: TButton
    Left = 71
    Top = 329
    Width = 58
    Height = 25
    Caption = 'Main'
    TabOrder = 16
  end
  object Button17: TButton
    Left = 135
    Top = 329
    Width = 58
    Height = 25
    Caption = 'OOC'
    TabOrder = 17
  end
  object Button12: TButton
    Left = 519
    Top = 62
    Width = 59
    Height = 25
    Caption = 'Host'
    TabOrder = 18
    OnClick = Button12Click
  end
  object Button18: TButton
    Left = 472
    Top = 329
    Width = 41
    Height = 25
    Caption = 'Save'
    TabOrder = 20
  end
  object Memo3: TMemo
    Left = 1006
    Top = 545
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo3')
    TabOrder = 23
    Visible = False
  end
  object Memo1: TMemo
    Left = 1006
    Top = 377
    Width = 185
    Height = 162
    Lines.Strings = (
      'Memo1')
    TabOrder = 24
  end
  object Memo_ooc: TMemo
    Left = 8
    Top = 39
    Width = 505
    Height = 265
    Lines.Strings = (
      'Memo_ooc')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 25
  end
  object memo_ms: TMemo
    Left = 8
    Top = 39
    Width = 505
    Height = 284
    Lines.Strings = (
      'Memo_ooc')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 26
  end
  object Button20: TButton
    Left = 425
    Top = 329
    Width = 41
    Height = 25
    Caption = 'Upd.'
    TabOrder = 28
  end
  object Button22: TButton
    Left = 456
    Top = 8
    Width = 57
    Height = 25
    Caption = 'mods'
    TabOrder = 29
  end
  object Button23: TButton
    Left = 400
    Top = 8
    Width = 57
    Height = 25
    Caption = 'animators'
    TabOrder = 31
    OnClick = Button23Click
  end
  object groupbox1: TGroupBox
    Left = -32
    Top = -9
    Width = 926
    Height = 408
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    object Edit1: TEdit
      Left = 192
      Top = 139
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Username'
    end
    object Edit2: TEdit
      Left = 192
      Top = 166
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      Text = 'Password'
    end
    object Button19: TButton
      Left = 214
      Top = 193
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 2
      OnClick = Button19Click
    end
    object CheckBox1: TCheckBox
      Left = 192
      Top = 224
      Width = 97
      Height = 17
      Caption = 'Remember Me'
      TabOrder = 3
    end
    object Button21: TButton
      Left = 295
      Top = 193
      Width = 114
      Height = 25
      Caption = 'Only if the AS is down'
      TabOrder = 4
    end
    object Memo4: TMemo
      Left = 128
      Top = 288
      Width = 185
      Height = 89
      Lines.Strings = (
        'Memo4')
      TabOrder = 5
      Visible = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 364
    Width = 818
    Height = 19
    Panels = <
      item
        Text = 'AS Connection: ERROR'
        Width = 300
      end
      item
        Text = 'Server Status: OFFLINE'
        Width = 150
      end
      item
        Text = 'Public: FALSE'
        Width = 50
      end>
  end
  object listbox_event: TListBox
    Left = 584
    Top = 8
    Width = 225
    Height = 346
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 22
  end
  object ClientSocket1: TClientSocket
    Active = True
    Address = '161.35.248.101'
    ClientType = ctNonBlocking
    Port = 6543
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    OnError = ClientSocket1Error
    Left = 584
    Top = 8
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 6541
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 576
    Top = 64
  end
  object IdSASLDigest1: TIdSASLDigest
    Left = 672
    Top = 128
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 592
    Top = 280
  end
end
