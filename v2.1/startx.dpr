uses kol, windows, messages;

var Befar, Be, Far: PControl;
    Winamp, Next, Prev, Main, Lock: PControl;
    ShootDawn, Reset, Login, PassEdit: PControl;
    Timer1: PTimer;
    WAHandle: THandle;
    ScWidth, ScHeight: Longint;
    eS: string;
    ts: tSize;
    locked: boolean;

{$I events.inc}

procedure Timer1Tick( Dummy: Pointer; Sender: TControl );
var S: String;
    R: TRect;
begin
  eS := Main.Caption;
  WAHandle := FindWindow('Winamp v1.x', nil);
  If WAHandle <> 0 Then
  Begin
    SetLength( S, 255 );
    GetWindowText( WAHandle, PChar( S ), 255 );
    Main.Caption := S;
  End
  Else Main.Caption := 'Winamp is not running';

  systemkeys( locked );
  Login.Visible := locked;

  if eS <> Main.Caption then
  begin

//    GetTextExtentPoint32( getdc( main.Handle ), pchar( s ), length( s ), ts );
//    Main.Width := ts.cx + 60;
    Main.Width := length( main.caption ) * 10;
    Winamp.Width := 2 * 17 + Main.Width;
    Winamp.Left := ( ScWidth - Winamp.Width ) div 2;
    Next.Left := Main.Left + Main.Width + 2;

    SetWindowPos( BeFar.Handle, HWND_TOPMOST, BeFar.Left, BeFar.Top, BeFar.Width, BeFar.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    SetWindowPos( Winamp.Handle, HWND_TOPMOST, Winamp.Left, Winamp.Top, Winamp.Width, Winamp.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    SetWindowPos( ShootDawn.Handle, HWND_TOPMOST, ShootDawn.Left, ShootDawn.Top, ShootDawn.Width, ShootDawn.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    SetWindowPos( Login.Handle, HWND_TOPMOST, Login.Left, Login.Top, Login.Width, Login.Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    R.Left := 0;
    R.Top := 0;
    R.Right := ScWidth;
    R.Bottom := ScHeight;

    SystemParametersInfo( SPI_SETWORKAREA, 0, @R, 0);
  end;

end;

{$I cc.inc}

begin

  applet := newapplet( 'StartX' );
  applet.exstyle := WS_EX_TOOLWINDOW;

  cc;

  loginwindow( nil, applet^ );
  run( applet );

end. // applet ����