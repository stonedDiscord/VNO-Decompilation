unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.ScktComp,
  IdBaseComponent, IdGlobal, IdHash, IdHashMessageDigest, IdSASL, IdSASLUserPass, IdSASLDigest, Vcl.ComCtrls;

type
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
  public
    { Public-Deklarationen }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Timer1Timer(Sender: TObject);
begin
;
end;

procedure TForm3.TimerPerRoomTimer(Sender: TObject);
begin
;
end;

procedure TForm3.TRefresh();
begin
;
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
begin
    ;
end;

procedure TForm3.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
;
end;

procedure TForm3.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
;
end;

procedure TForm3.Panel2Click(Sender: TObject);
begin
;
end;

procedure TForm3.Loader();
begin
;
end;

procedure TForm3.CheckInternetCode2(s: string; Socket: TCustomWinSocket);
begin
;
end;

procedure TForm3.CheckInternetCode(s: string; Socket: TCustomWinSocket);
begin
;
end;

procedure TForm3.Button10Click(Sender: TObject);
begin
  TRefresh();
  Memo4.Lines.LoadFromFile('musiclist.txt');
  Memo4.BringToFront;
  Button10.Caption := 'OTHER';
end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  Memo3.BringToFront;
  Button11.Caption := 'AREAS';
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
  Memo1.BringToFront;
  Button12.Caption := 'HOST';
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
  Memo3.BringToFront;
  Button13.Caption := 'ITEMS';
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
  var username := InputBox('Banning a Player', 'Enter the username to ban:', '');
  if username <> '' then
    ClientSocket1.Socket.SendText('BU#' + username + '#%');
end;

procedure TForm3.Button15Click(Sender: TObject);
begin
  var ip := InputBox('Banning a Player', 'Enter the IP to ban:', '');
  if ip <> '' then
    ClientSocket1.Socket.SendText('BI#' + ip + '#%');
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
  Memo1.Lines.SaveToFile('host.txt');
  Memo3.Lines.SaveToFile('areas.txt');
  Memo4.Lines.SaveToFile('musiclist.txt');
end;

procedure TForm3.Button19Click(Sender: TObject);
begin
     Form3.ClientSocket1.Socket.SendText('CO#' + Form3.Edit1.Text + '#' + MD5(Form3.Edit2.Text) + '#%')
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  var ip := InputBox('Banning a Player', 'Enter the IP to ban:', '');
  if ip <> '' then
    ClientSocket1.Socket.SendText('BI#' + ip + '#%');
end;

procedure TForm3.Button20Click(Sender: TObject);
begin
  TRefresh();
end;

procedure TForm3.Button21Click(Sender: TObject);
begin
  if not ClientSocket1.Active then
    Button19Click(Self);
end;

procedure TForm3.Button22Click(Sender: TObject);
begin
  listbox_event.BringToFront;
  Button22.Caption := 'MODS';
end;

procedure TForm3.Button23Click(Sender: TObject);
begin
  Memo1.BringToFront;
  Button23.Caption := 'ANIMATORS';
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  var username := InputBox('Banning a Player', 'Enter the username to ban:', '');
  if username <> '' then
    ClientSocket1.Socket.SendText('BU#' + username + '#%');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  var character := InputBox('Muting a Player', 'Enter the character to mute:', '');
  if character <> '' then
    ClientSocket1.Socket.SendText('MU#' + character + '#%');
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  var character := InputBox('Unmuting a Player', 'Enter the character to unmute:', '');
  if character <> '' then
    ClientSocket1.Socket.SendText('UM#' + character + '#%');
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  var id := InputBox('Disconnecting a Player', 'Enter the ID to disconnect:', '');
  if id <> '' then
    ClientSocket1.Socket.SendText('DI#' + id + '#%');
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
     Button5.Caption := 'SERVER';
     ListBox_user.BringToFront;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  var character := InputBox('Kicking a Player', 'Enter the character to kick:', '');
  if character <> '' then
    ClientSocket1.Socket.SendText('KI#' + character + '#%');
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  groupbox1.BringToFront;
  Button8.Caption := 'SETTINGS';
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  Loader();
  Button9.Caption := 'INIT';
end;

procedure TForm3.button_reloadClick(Sender: TObject);
begin
;
end;

procedure TForm3.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    Form3.StatusBar1.Panels[0].Text := 'AS Connection: ONLINE';
end;

procedure TForm3.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    Form3.StatusBar1.Panels[0].Text := 'AS Connection: ERROR. WRONG VERSION';
    Form3.StatusBar1.Panels[0].Text := 'AS Connection: ERROR. TRYING TO RECONNECT';
end;

procedure TForm3.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
            ;
end;

procedure TForm3.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
       ;
end;

procedure TForm3.edit_oocKeyPress(Sender: TObject; var Key: Char);
begin
;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
;
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
      MessageDlg('Are you sure ?', mtConfirmation, [mbYes, mbNo], 0);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
      ;
end;

end.
