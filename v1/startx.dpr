uses kol, windows, messages;

var Befar, Be, Far: PControl;
    Winamp, Next, Prev, Main: PControl;
    ShootDawn, Reset: PControl;
    Timer1: PTimer;
    WAHandle: THandle;
    ScWidth, ScHeight: Longint;

Function RegisterServiceProcess(dwProcessID, dwType: Integer): Integer; stdcall; external 'KERNEL32.DLL';

procedure TryToClose( Dummy: Pointer; Sender: PControl; var Accept: Boolean );
begin
 Accept := False;
end;

procedure BeClick( Dummy: Pointer; Sender: TControl );
begin
  If BeFar.Left >= 0 Then
  Begin
    BeFar.Left := 11 - BeFar.Width;
    Be.Caption := '4';
    Be.Left := BeFar.Width - 14;
    Far.Left := 0;
    Winamp.Top := Winamp.Top + 20;
    ShootDawn.Left := ShootDawn.Left + 20;
  End
  Else
  Begin
    BeFar.Left := 0;
    Be.Caption := '3';
    Be.Left := - 2;
    Far.Left := 20;
    Winamp.Top := Winamp.Top - 20;
    ShootDawn.Left := ShootDawn.Left - 20;
  End;
end;

procedure FarClick( Dummy: Pointer; Sender: TControl );
begin
 WinExec( 'far.pif', SW_SHOWNORMAL );
end;

procedure NextClick( Dummy: Pointer; Sender: TControl );
begin
  If WAHandle <> 0 Then SendMessage( WAHandle, WM_COMMAND, 40048, 0 );  // Next
end;

procedure PrevClick( Dummy: Pointer; Sender: TControl );
begin
  If WAHandle <> 0 Then SendMessage( WAHandle, WM_COMMAND, 40044, 0 );  // Prev
end;

procedure MainClick( Dummy: Pointer; Sender: TControl );
begin
  If WAHandle <> 0 Then Begin
  If SendMessage( WAHandle, WM_USER, 0, 104 ) <> 0 Then
   SendMessage( WAHandle, WM_COMMAND, 40046, 0 )   // Pause
  Else SendMessage( WAHandle, WM_USER, 0, 102 ) End
  Else WinExec( 'C:\Program Files\Winamp\Winamp.exe', SW_NORMAL );
end;

procedure ShutClick( Dummy: Pointer; Sender: TControl );
begin
  If WAHandle <> 0 Then
    SendMessage( WAHandle,WM_COMMAND, 40001, 0 ) // Exit Winamp
  ExitWindowsEx(EWX_FORCE + EWX_REBOOT, 0);
end;

procedure MainDown( Dummy: Pointer; Sender: PControl; var Mouse: TMouseEventData );
begin
  If Mouse.Button = mbRight Then
     ShowWindow( WAHandle, SW_RESTORE );
end;

procedure Timer1Tick( Dummy: Pointer; Sender: TControl );
var S: String;
    R: TRect;
begin
  WAHandle := FindWindow('Winamp v1.x', nil);
  If WAHandle <> 0 Then
  Begin
    SetLength( S, 255 );
    GetWindowText( WAHandle, PChar( S ), 255 );
    Main.Caption := S;
  End
  Else Main.Caption := 'Winamp is not running';

  Main.Width := Length( Main.Caption ) * 10;
  Winamp.Width := 2 * 17 + Main.Width;
  Winamp.Left := ( ScWidth - Winamp.Width ) div 2;
  Next.Left := Main.Left + Main.Width + 2;

  SetWindowPos( BeFar.Handle, HWND_TOPMOST, BeFar.Left, BeFar.Top, BeFar.Width, BeFar.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  SetWindowPos( Winamp.Handle, HWND_TOPMOST, Winamp.Left, Winamp.Top, Winamp.Width, Winamp.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  SetWindowPos( ShootDawn.Handle, HWND_TOPMOST, ShootDawn.Left, ShootDawn.Top, ShootDawn.Width, ShootDawn.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

  R.Left := 0;
  R.Top := 0;
  R.Right := ScWidth;
  R.Bottom := ScHeight;

  SystemParametersInfo( SPI_SETWORKAREA, 0, @R, 0);
end;

procedure cc;
begin

RegisterServiceProcess(GetCurrentProcessID, 1); // 1 - ki, 0 - be
WAHandle := FindWindow('Winamp v1.x', nil);
ScWidth := GetSystemMetrics( SM_CXFULLSCREEN );
ScHeight := GetSystemMetrics( SM_CYFULLSCREEN );

WinExec( 'C:\Windows\System\4dmain.exe -startup', SW_SHOWNORMAL );
WinExec( 'far.pif', SW_SHOWNORMAL );
WinExec( 'start "c:\program files\winamp\winamp.m3u"', SW_HIDE );

BeFar := NewForm( Applet, '' );
With BeFar^ Do
Begin
  Top := ScHeight + 4;
  Left := 0;
  Caption := 'MainForm';
  ClientHeight := 15;
  ClientWidth := 50;
  Style := Style XOR WS_BORDER XOR WS_THICKFRAME XOR WS_EX_LAYOUTRTL;
  ClientHeight := 15;
  ClientWidth := 54;
  Color := clBackground;
  Font.FontCharset := 2;
  Font.Color := clWindowText;
  Font.FontHeight := -11;
  Font.FontName := 'MS Sans Serif';
  Font.FontStyle := [];
  OnClose := TOnEventAccept( MakeMethod( nil, @TryToClose ) );

Be := NewLabel( BeFar, '' );
With Be^ Do
Begin
  Left := -2;
  Top := 0;
  Width := 11;
  Height := 16;
  Caption := '3';
  Font.FontCharset := 2;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Marlett';
  Font.FontStyle := [];
  OnClick := TOnEvent( MakeMethod( nil, @BeClick ) );
end; // label: Be

Far := NewLabel( BeFar, '' );
With Far^ Do
Begin
  Left := 20;
  Top := -1;
  Width := 30;
  Height := 18;
  Caption := 'Far';
  Font.FontCharset := 0;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Courier New';
  Font.FontStyle := [fsBold];
  OnClick := TOnEvent( MakeMethod( nil, @FarClick ) );
end; // label: Far
end; // form : BeFar

Winamp := NewForm( Applet, 'Winamp Control' );
With Winamp^ Do
Begin
  Top := ScHeight + 4;
  Left := ( ScWidth - 150 ) div 2;
  ClientHeight := 15;
  ClientWidth := 150;
  Style := Style XOR WS_BORDER XOR WS_THICKFRAME XOR WS_EX_LAYOUTRTL;
  ClientHeight := 15;
  ClientWidth := 150;
  Color := clBackground;
  Font.FontCharset := 2;
  Font.Color := clWindowText;
  Font.FontHeight := -11;
  Font.FontName := 'MS Sans Serif';
  Font.FontStyle := [];
  OnClose := TOnEventAccept( MakeMethod( nil, @TryToClose ) );
End;

Next := NewLabel( Winamp, 'и' );
With Next^ Do
Begin
  Left := Winamp.Width - 11;
  Top := 0;
  Width := 11;
  Height := 16;
  Font.FontCharset := 2;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Wingdings';
  Font.FontStyle := [];
  OnClick := TOnEvent( MakeMethod( nil, @NextClick ) );
End;

Prev := NewLabel( Winamp, 'з' );
With Prev^ Do
Begin
  Left := 0;
  Top := 0;
  Width := 11;
  Height := 16;
  Font.FontCharset := 2;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Wingdings';
  Font.FontStyle := [];
  OnClick := TOnEvent( MakeMethod( nil, @PrevClick ) );
End;

Main := NewLabel( Winamp, '' );
With Main^ Do
Begin
  Left := 20;
  Top := -1;
  Caption := 'Winamp stopped';
  Width := Length( Caption ) * 10;
  Height := 18;
  Font.FontCharset := 0;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Courier New';
  Font.FontStyle := [fsBold];
  OnClick := TOnEvent( MakeMethod( nil, @MainClick ) );
  OnMouseDown := TOnMouse( MakeMethod( nil, @MainDown ) );
End;

Timer1 := NewTimer( 100 );
With Timer1^ Do
Begin
  Enabled := True;
  OnTimer := TOnEvent( MakeMethod( nil, @Timer1Tick ) );
End;

ShootDawn := NewForm( Applet, 'ShootDawn' );
With ShootDawn^ Do
Begin
  Top := ScHeight + 4;
  Left := ScWidth - 15;
  ClientHeight := 15;
  ClientWidth := 150;
  Style := Style XOR WS_BORDER XOR WS_THICKFRAME XOR WS_EX_LAYOUTRTL;
  ClientHeight := 15;
  ClientWidth := 150;
  Color := clBackground;
  Font.FontCharset := 0;
  Font.Color := clWindowText;
  Font.FontHeight := -11;
  Font.FontName := 'MS Sans Serif';
  Font.FontStyle := [];
  OnClose := TOnEventAccept( MakeMethod( nil, @TryToClose ) );
End;

Reset := NewLabel( ShootDawn, 'R' );
With Reset^ Do
Begin
  Left := 3;
  Top := -1;
  Width := 12;
  Height := 15;
  Font.FontCharset := 0;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Courier New';
  Font.FontStyle := [fsBold];
  OnClick := TOnEvent( MakeMethod( nil, @ShutClick ) );
End;

end; // proc : Cc

begin

  applet := newapplet( 'Start-X' );

  cc;

  run( applet );

end. // applet зичш
