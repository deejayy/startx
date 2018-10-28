procedure cc;
begin

RegisterServiceProcess(GetCurrentProcessID, 1); // 1 - ki, 0 - be
WAHandle := FindWindow('Winamp v1.x', nil);
ScWidth := GetSystemMetrics( SM_CXSCREEN );
ScHeight := GetSystemMetrics( SM_CYSCREEN ) - 18;

 WinExec( 'C:\windows\system\4dmain.exe -startup', SW_SHOWNORMAL );
 WinExec( 'far.pif', SW_SHOWNORMAL );
// if wahandle <> 0 then
 WinExec( 'start "c:\program files\winamp\winamp.m3u"', SW_HIDE );

BeFar := NewForm( Applet, '' );
With BeFar^ Do
Begin
  Top := ScHeight + 2;
  Left := 0;
  Caption := 'MainForm';
  ClientHeight := 17;
  ClientWidth := 50;
  Style := Style XOR WS_BORDER XOR WS_THICKFRAME XOR WS_EX_LAYOUTRTL;
  exstyle := WS_EX_TOOLWINDOW;
  ClientHeight := 17;
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
  Font.FontName := 'Arial';
  Font.FontStyle := [fsBold];
  OnClick := TOnEvent( MakeMethod( nil, @FarClick ) );
end; // label: Far
end; // form : BeFar

Winamp := NewForm( Applet, 'Winamp Control' );
With Winamp^ Do
Begin
  Top := ScHeight + 2;
  Left := ( ScWidth - 150 ) div 2;
  ClientHeight := 17;
  ClientWidth := 150;
  Style := Style XOR WS_BORDER XOR WS_THICKFRAME XOR WS_EX_LAYOUTRTL;
  exstyle := WS_EX_TOOLWINDOW;
  ClientHeight := 17;
  ClientWidth := 150;
  Color := clBackground;
  Font.FontCharset := 2;
  Font.Color := clWindowText;
  Font.FontHeight := -11;
  Font.FontName := 'MS Sans Serif';
  Font.FontStyle := [];
  OnClose := TOnEventAccept( MakeMethod( nil, @TryToClose ) );
End;

Next := NewLabel( Winamp, 'Ø' );
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

Prev := NewLabel( Winamp, '×' );
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
  Font.FontName := 'Arial';
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
  Top := ScHeight + 2;
  Left := ScWidth - 15;
  ClientHeight := 17;
  ClientWidth := 150;
  Style := Style XOR WS_BORDER XOR WS_THICKFRAME XOR WS_EX_LAYOUTRTL;
  exstyle := WS_EX_TOOLWINDOW;
  ClientHeight := 17;
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
  Width := 20;
  Height := 20;
  Font.FontCharset := 0;
  Font.Color := clWindow;
  Font.FontHeight := -16;
  Font.FontName := 'Arial';
  Font.FontStyle := [fsBold];
  OnMouseDown := TOnMouse( MakeMethod( nil, @ShutDown ) );
End;

end; // proc : Cc