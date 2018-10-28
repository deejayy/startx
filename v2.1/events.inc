Function RegisterServiceProcess(dwProcessID, dwType: Integer): Integer; stdcall; external 'KERNEL32.DLL';

procedure SystemKeys(Disable: Boolean) ;
var OldVal : LongInt;
begin
  SystemParametersInfo(SPI_SCREENSAVERRUNNING, Word(Disable), @OldVal, 0);
end;

procedure press( dummy: pointer; sender: pcontrol; var key: Longint; shift: dword );
begin
  if key = VK_RETURN then locked := passedit.text <> '';
end;


procedure LoginWindow( dummy: pointer; sender: tControl );
begin
  passedit.text := '';
  locked := true;
end;

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

procedure ShutDown( Dummy: Pointer; Sender: PControl; var Mouse: TMouseEventData );
begin
  If WAHandle <> 0 Then SendMessage( WAHandle,WM_COMMAND, 40001, 0 ); // Exit Winamp
  if mouse.Button = mbRight then
    ExitWindowsEx(EWX_FORCE + EWX_REBOOT, 0)
  else ExitWindowsEx(EWX_FORCE + EWX_SHUTDOWN, 0);
end;

procedure MainDown( Dummy: Pointer; Sender: PControl; var Mouse: TMouseEventData );
begin
  If Mouse.Button = mbRight Then begin
    if IsWindowVisible( WAhandle ) then
    ShowWindow( WAHandle, SW_MINIMIZE )
    else
    ShowWindow( WAHandle, SW_RESTORE );
  end;
end;

