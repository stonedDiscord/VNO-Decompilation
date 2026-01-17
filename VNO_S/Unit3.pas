unit Unit3;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.ScktComp,
   IdBaseComponent, IdGlobal, IdHash, IdHashMessageDigest, IdSASL, IdSASLUserPass, IdSASLDigest, Vcl.ComCtrls, IniFiles;

type
  TPlayer = record
    ID: Integer;
    Name: string;
    IP: string;
    Character: string;
    Status: string;
  end;

  TClientData = class
    Name: string;
    Status: string;
    ID: Integer;
    Room: Integer;
    Character: string;
    IP: string;
    Connected: Boolean;
    Socket: TCustomWinSocket;
    MemoryStream: TMemoryStream;
    constructor Create;
  end;

  TForm3 = class(TForm)
    edit_ooc: TEdit;
    Memo2: TMemo;
    button_reload: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    ListBox_user: TListBox;
    Button6: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button12: TButton;
    Button18: TButton;
    Memo3: TMemo;
    Memo1: TMemo;
    Memo_ooc: TMemo;
    memo_ms: TMemo;
    Button20: TButton;
    Button22: TButton;
    Button23: TButton;
    groupbox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Button19: TButton;
    CheckBox1: TCheckBox;
    Button21: TButton;
    Memo4: TMemo;
    StatusBar1: TStatusBar;
    listbox_event: TListBox;
    ClientSocket1: TClientSocket;
    ServerSocket1: TServerSocket;
    IdSASLDigest1: TIdSASLDigest;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure TimerPerRoomTimer(Sender: TObject);
    procedure TRefresh();
    function MD5(S: String): string;
    function CheckForFreeSlot: Integer;
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Panel2Click(Sender: TObject);
    procedure Loader();
    procedure CheckInternetCode2(s: string; Socket: TCustomWinSocket);
    procedure CheckInternetCode(s: string; Socket: TCustomWinSocket);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure button_reloadClick(Sender: TObject);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edit_oocKeyPress(Sender: TObject; var Key: Char);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  private
    { Private-Deklarationen }
    function FindClientBySocket(Socket: TCustomWinSocket): TClientData;
  public
    { Public-Deklarationen }
  end;

var
  Form3: TForm3;
  PlayerList: TList;
  ConnectionStatus: string;
  BanList: TList;
  ClientList: TList;
  HPOffSent: Boolean;
  NumAreas: Integer;
  NumItems: Integer;
  NumMusic: Integer;
  NumChars: Integer;

implementation

{$R *.dfm}

constructor TClientData.Create;
begin
  inherited;
  Name := '$UNOWN';
  Status := '$NONE';
  Room := -1;
  Character := '$UNOWN';
  Connected := True;
  MemoryStream := TMemoryStream.Create;
end;


function TForm3.CheckForFreeSlot: Integer;
var
  i, j: Integer;
  used: Boolean;
begin
  for i := 1 to 100 do
  begin
    used := False;
    for j := 0 to ClientList.Count - 1 do
      if TClientData(ClientList[j]).ID = i then
      begin
        used := True;
        Break;
      end;
    if not used then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function TForm3.FindClientBySocket(Socket: TCustomWinSocket): TClientData;
var
  i: Integer;
begin
  for i := 0 to ClientList.Count - 1 do
    if TClientData(ClientList[i]).Socket = Socket then
    begin
      Result := TClientData(ClientList[i]);
      Exit;
    end;
  Result := nil;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  ClientSocket1.Active := False;
  ClientSocket1.Active := True;
end;

procedure TForm3.TimerPerRoomTimer(Sender: TObject);
var
  i: Integer;
  client: TClientData;
begin
  // Check for inactive clients in each room
  for i := 0 to ClientList.Count - 1 do
  begin
    client := TClientData(ClientList[i]);
    if client.Connected and (client.Room <> -1) then
    begin
      // Check if client is inactive for too long
      // For now, just log the room activity
      Memo2.Lines.Add('Room ' + IntToStr(client.Room) + ' activity check for client ' + IntToStr(client.ID));
    end;
  end;
end;

procedure TForm3.TRefresh();
var
  i: Integer;
  player: ^TPlayer;
begin
  Memo1.Lines.Clear;
  for i := 0 to PlayerList.Count - 1 do
  begin
    player := PlayerList[i];
    Memo1.Lines.Add(IntToStr(player^.ID) + ' ' + player^.Name + ' ' + player^.IP + ' ' + player^.Character + ' ' + player^.Status);
  end;
  if ConnectionStatus <> 'ac ' then
    StatusBar1.Panels[0].Text := 'ac<';
end;

function TForm3.MD5(S: String): string;
var
    hashMessageDigest5 : TIdHashMessageDigest5;
begin
    hashMessageDigest5 := nil;
    try
        hashMessageDigest5 := TIdHashMessageDigest5.Create;
        Result := IdGlobal.IndyLowerCase ( hashMessageDigest5.HashStringAsHex ( S ) );
    finally
        hashMessageDigest5.Free;
    end;
end;

procedure TForm3.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ip: string;
  client: TClientData;
  countsMsg: string;
begin
  ip := Socket.RemoteAddress;

//  if IsBanned(ip) then
//  begin
//    Socket.Close;
//    Exit;
//  end;

  // Send HPOFF if needed
  if not HPOffSent then
  begin
    Socket.SendText('HPOFF#%');
    Sleep(10);
    HPOffSent := True;
  end;

  // Send counts message
  countsMsg := IntToStr(ClientList.Capacity) + '#' +
               IntToStr(NumAreas) + '#' +
               IntToStr(NumItems) + '#' +
               IntToStr(NumMusic) + '#' +
               IntToStr(NumChars) + '#%';
  Socket.SendText(countsMsg);

  // Create client
  client := TClientData.Create;
  client.IP := ip;
  client.ID := CheckForFreeSlot;
  client.Socket := Socket;
  ClientList.Add(client);

  // Log
  Memo1.Lines.Add('[CONNEC.] ' + IntToStr(client.ID) + ' ' + ip);

  // Send to master server
  ClientSocket1.Socket.SendText(IntToStr(client.ID) + '#' + ip + '#%');

  // Refresh
  TRefresh();
end;

procedure TForm3.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: Integer;
  client: TClientData;
  room: Integer;
  count: Integer;
begin
  for i := 0 to ClientList.Count - 1 do
  begin
    client := TClientData(ClientList[i]);
    if client.Socket = Socket then
    begin
      // Free memory stream if any
      if client.MemoryStream <> nil then
        client.MemoryStream.Free;
      // Set char taken to 0 if not $UNOWN
      if client.Name <> '$UNOWN' then
      begin
        // CharData[client.Character].taken := 0;
      end;
      // Decrement room count if in room
      if client.Room <> -1 then
      begin
        // RoomData[client.Room].count := RoomData[client.Room].count - 1;
      end;
      // Log disconnect
      Memo1.Lines.Add('[DISCONN.] ' + IntToStr(client.ID) + ' ' + client.IP);
      // Clear slot
      // ClientSlots[client.ID] := nil;
      // Remove from list
      ClientList.Delete(i);
      client.Free;
      Break;
    end;
  end;
  TRefresh();
  // Send room counts to clients
  for i := 0 to ClientList.Count - 1 do
  begin
    client := TClientData(ClientList[i]);
    if client.Connected then
    begin
      room := client.Room;
      if room <> -1 then
      begin
        // count := RoomData[room].count;
        count := 0; // placeholder
        client.Socket.SendText(IntToStr(room) + '#' + IntToStr(count) + '#%');
      end;
    end;
  end;
end;

procedure TForm3.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  data: string;
begin
  data := Socket.ReceiveText;
  CheckInternetCode(data, Socket);
end;

procedure TForm3.Panel2Click(Sender: TObject);
begin
  ;
end;

procedure TForm3.Loader();
var
  ini: TIniFile;
  i, count: Integer;
  section: string;
begin
  // Load chars
  ini := TIniFile.Create('.\base\scene\' + '\init.ini');
  try
    count := ini.ReadInteger('chars', 'number', 0);
    NumChars := count;
    for i := 1 to count do
    begin
      ;
    end;
  finally
    ini.Free;
  end;

  // Load areas
  ini := TIniFile.Create('\areas.ini');
  try
    count := ini.ReadInteger('Areas', 'number', 0);
    NumAreas := count;
    for i := 1 to count do
    begin
      section := 'Area' + IntToStr(i);
      // Load area properties from ini
      Memo3.Lines.Add('Area ' + IntToStr(i) + ': ' + ini.ReadString(section, 'name', 'Unknown'));
    end;
  finally
    ini.Free;
  end;

  // Load items
  ini := TIniFile.Create('\items.ini');
  try
    count := ini.ReadInteger('items', 'number', 0);
    NumItems := count;
    for i := 1 to count do
    begin
      ;
    end;
  finally
    ini.Free;
  end;

  // Load music
  ini := TIniFile.Create('\musiclist.ini');
  try
    count := ini.ReadInteger('Name', 'number', 0);
    NumMusic := count;
    for i := 1 to count do
    begin
      ;
    end;
  finally
    ini.Free;
  end;
end;

procedure TForm3.CheckInternetCode2(s: string; Socket: TCustomWinSocket);
var
  parts: TArray<string>;
  command: string;
  i: Integer;
  client: TClientData;
  ipToBan: string;
begin
  parts := s.Split(['#']);
  if Length(parts) > 0 then
    command := parts[0]
  else
    Exit;

  if command = 'CT' then
  begin
    // Handle player update
    if Length(parts) > 1 then
    begin
      // Update player name in list
      for i := 0 to ClientList.Count - 1 do
      begin
        client := TClientData(ClientList[i]);
        if client.Name = parts[1] then
        begin
          client.Name := parts[2];
          Break;
        end;
      end;
    end;
    TRefresh();
  end
  else if command = 'VER' then
  begin
    // Send version
    ClientSocket1.Socket.SendText('VER#S#2.3#%');
  end
  else if command = 'CT2' then
  begin
    // Send login
    ClientSocket1.Socket.SendText('CO#' + Edit1.Text + '#' + MD5(Edit2.Text) + '#%');
  end
  else if command = 'CT3' then
  begin
    // Connection success
    StatusBar1.Panels[0].Text := 'AS Connection: ONLINE';
    ConnectionStatus := 'SERVER';
    Memo2.Lines.Add('Connected to master server');
    Memo2.Lines.Add('Running version 2.3');
  end
  else if command = 'CT4' then
  begin
    // Refused
    Memo2.Lines.Add('Refused access to masterserver.');
    StatusBar1.Panels[0].Text := 'AS Connection: REFUSED';
  end
  else if command = 'CT5' then
  begin
    // Wrong version
    Memo2.Lines.Add('Wrong VNO server version.');
    StatusBar1.Panels[0].Text := 'AS Connection: ERROR, WRONG VERSION';
  end
  else if command = 'CT6' then
  begin
    // Ban IP
    if Length(parts) > 1 then
    begin
      ipToBan := parts[1];
      //BanList.Add(ipToBan);
      // Close connections from this IP
      for i := 0 to ClientList.Count - 1 do
      begin
        client := TClientData(ClientList[i]);
        if client.IP = ipToBan then
        begin
          client.Socket.Close;
          Memo2.Lines.Add('Closed connection from banned IP: ' + ipToBan);
        end;
      end;
    end;
  end;
end;

procedure TForm3.CheckInternetCode(s: string; Socket: TCustomWinSocket);
var
  parts: TArray<string>;
  command: string;
  client: TClientData;
  i: Integer;
  otherClient: TClientData;
begin
  parts := s.Split(['#']);
  if Length(parts) > 0 then
    command := parts[0]
  else
    Exit;

  client := FindClientBySocket(Socket);
  if client = nil then Exit;

  if command = 'MS' then
  begin
    // In-character message
    Memo2.Lines.Add(client.Name + ': ' + parts[1]);
    // Broadcast to room
    for i := 0 to ClientList.Count - 1 do
    begin
      otherClient := TClientData(ClientList[i]);
      if (otherClient.Room = client.Room) and (otherClient.ID <> client.ID) then
      begin
        otherClient.Socket.SendText('MS#' + client.Name + '#' + parts[1] + '#%');
      end;
    end;
  end
  else if command = 'OOC' then
  begin
    // Out-of-character message
    Memo_ooc.Lines.Add(client.Name + ': ' + parts[1]);
    // Broadcast OOC to all clients
    for i := 0 to ClientList.Count - 1 do
    begin
      otherClient := TClientData(ClientList[i]);
      if otherClient.ID <> client.ID then
      begin
        otherClient.Socket.SendText('OOC#' + client.Name + '#' + parts[1] + '#%');
      end;
    end;
  end
  else if command = 'CH' then
  begin
    // Change character
    if Length(parts) > 1 then
    begin
      client.Character := parts[1];
      Memo2.Lines.Add(client.Name + ' changed character to ' + client.Character);
    end;
  end
  else if command = 'HI' then
  begin
    // Handshake
    Socket.SendText('HI#' + IntToStr(client.ID) + '#%');
    Memo2.Lines.Add('Handshake completed with client ' + IntToStr(client.ID));
  end
  else if command = 'RC' then
  begin
    // Room change
    if Length(parts) > 1 then
    begin
      client.Room := StrToInt(parts[1]);
      Memo2.Lines.Add(client.Name + ' changed to room ' + parts[1]);
    end;
  end
  else if command = 'RC2' then
  begin
    // Request room count
    // Send room count to client
    Socket.SendText('RC2#' + IntToStr(client.Room) + '#0#%'); // 0 is placeholder for count
  end;
end;

procedure TForm3.Button10Click(Sender: TObject);
begin
  TRefresh();
  if FileExists('.\base\scene\' + '\musiclist.txt') then
    Memo4.Lines.LoadFromFile('\musiclist.txt');
  Memo2.BringToFront;
  Button10.Caption := 'OTHER';
end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  // Reload areas info
    Memo2.Lines.LoadFromFile('.\base\scane\' + '\areas.ini');
    Button11.Caption := 'OTHER';
  Memo2.BringToFront;
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := 'Server Status: ONLINE';
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
  Memo3.BringToFront;
  // Clear and show items
  Memo3.Clear;
  if FileExists('.\base\scene\' + '\items.ini') then
    Memo3.Lines.LoadFromFile('.\base\scene\' + '\items.ini');
  Button13.Caption := 'OTHER';
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
  Memo2.Lines.LoadFromFile('.\banuser.txt');
  Memo2.BringToFront;
end;

procedure TForm3.Button15Click(Sender: TObject);
begin
  Memo2.Lines.LoadFromFile('.\banip.txt');
  Memo2.BringToFront;
end;

procedure TForm3.Button16Click(Sender: TObject);
begin
     Button16.Caption := 'MAIN';
     memo_ms.BringToFront;
end;

procedure TForm3.Button17Click(Sender: TObject);
begin
     Memo_ooc.BringToFront;
     edit_ooc.BringToFront;
     Button17.Caption := 'OOC';
end;

procedure TForm3.Button18Click(Sender: TObject);
begin
  Memo2.Lines.SaveToFile('');
end;

procedure TForm3.Button19Click(Sender: TObject);
begin
     Form3.ClientSocket1.Socket.SendText('CO#' + Form3.Edit1.Text + '#' + MD5(Form3.Edit2.Text) + '#%')
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  ip: string;
begin
  ip := InputBox('Banning a Player', 'Enter the IP to ban:', '');
  ClientSocket1.Socket.SendText('CT#$ADMIN#' + ip + ' was banned(ip).#%');
end;

procedure TForm3.Button20Click(Sender: TObject);
begin
  TRefresh();
end;

procedure TForm3.Button21Click(Sender: TObject);
begin
  groupbox1.Visible := False;
  Button12.Enabled := True;
  ListBox_user.BringToFront;
  Timer1.Enabled := False;
end;

procedure TForm3.Button22Click(Sender: TObject);
begin
  Memo2.Clear;
  Memo2.Lines.LoadFromFile('.\mods.txt');
  Memo2.BringToFront;
  Button22.Caption := 'mods';
end;

procedure TForm3.Button23Click(Sender: TObject);
begin
  Button23.Caption := '.\animators.txt';
  Memo2.BringToFront;
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  username: string;
begin
  username := InputBox('Banning a Player', 'Enter the username to ban:', '');
  ClientSocket1.Socket.SendText('CT#$ADMIN#' + character + ' was banned(user).#%');
end;

procedure TForm3.Button3Click(Sender: TObject);
var
  character: string;
begin
  character := InputBox('Muting a Player', 'Enter the character to mute:', '');
  if character <> '' then
    ClientSocket1.Socket.SendText('CT#$ADMIN#' + character + ' was muted.#%');
    ClientSocket1.Socket.SendText('MU#' + character + '#%');
end;

procedure TForm3.Button4Click(Sender: TObject);
var
  character: string;
begin
  character := InputBox('Unmuting a Player', 'Enter the character to unmute:', '');
  if character <> '' then
    ClientSocket1.Socket.SendText('CT#$ADMIN#' + character + ' was unmuted.#%');
    ClientSocket1.Socket.SendText('UM#' + character + '#%');
end;

procedure TForm3.Button5Click(Sender: TObject);
var
  id: string;
begin
  id := InputBox('Disconnecting a Player', 'Enter the ID to disconnect:', '');

end;

procedure TForm3.Button6Click(Sender: TObject);
begin
     Button6.Caption := 'Server';
     ListBox_user.BringToFront;
end;

procedure TForm3.Button7Click(Sender: TObject);
var
  character: string;
begin
  character := InputBox('Kicking a Player', 'Enter the character to kick:', '');
  if character <> '' then
    ClientSocket1.Socket.SendText('KC#' + character + '#%');
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  Memo2.BringToFront;
  Button8.Caption := 'OTHER';
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  //get_scene
  Button9.Caption := '.\base\scene\' + '\init.ini';
end;

procedure TForm3.button_reloadClick(Sender: TObject);
begin
  ;
end;

procedure TForm3.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    Form3.StatusBar1.Panels[0].Text := 'AS Connection: ONLINE';
    Timer1.Enabled := False;
end;

procedure TForm3.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    Form3.StatusBar1.Panels[0].Text := 'AS Connection: ERROR. WRONG VERSION';
    Form3.StatusBar1.Panels[0].Text := 'AS Connection: ERROR. TRYING TO RECONNECT';
    ClientSocket1.Active := False;
    Timer1.Enabled := False;
end;

procedure TForm3.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ClientSocket1.Active := False;
end;

procedure TForm3.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  data: string;
  pos: Integer;
begin
  data := Socket.ReceiveText;
  Memo1.Lines.Add(data);
  while Length(data) > 0 do
  begin
    if Length(data) < 3 then
      Break;
    pos := AnsiPos('%', data);
    if pos = 0 then
      Break;
    CheckInternetCode2(Copy(data, 1, pos - 1), Socket);
    data := Copy(data, pos + 1, Length(data));
  end;
end;

procedure TForm3.edit_oocKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  client: TClientData;
begin
  if Key = #13 then
  begin
    if edit_ooc.Text = '/clear' then
    begin
      Memo_ooc.Clear;
      edit_ooc.Clear;
    end;

    // Send OOC message
    if edit_ooc.Text <> '' then
    begin
      Memo_ooc.Lines.Add('$ADMIN: ' + edit_ooc.Text);
      // Broadcast to all clients
      for i := 0 to ClientList.Count - 1 do
      begin
        client := TClientData(ClientList[i]);
        if client.Connected then
        begin
          client.Socket.SendText('CT#$ADMIN#' + edit_ooc.Text + '#%');
        end;
      end;
      edit_ooc.Text := '';
    end;
    Key := #0;
  end;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Memo4.Lines.SaveToFile('./base/logs.txt');
  ClientSocket1.Socket.SendText('KSID#%');
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Are you sure ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  PlayerList := TList.Create;
  ClientList := TList.Create;
  BanList := TList.Create;
  HPOffSent := False;
  NumAreas := 0;
  NumItems := 0;
  NumMusic := 0;
  NumChars := 0;
  Loader();
end;

end.
