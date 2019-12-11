$code = @'
    [DllImport("user32.dll")]
     public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetWindowRect(IntPtr hWnd, out System.Drawing.Rectangle lpRect);

    [DllImport("User32.dll")]
    public extern static bool MoveWindow(IntPtr handle, int x, int y, int width, int height, bool redraw);
'@
Add-Type $code -Name Utils -Namespace Win32 -ReferencedAssemblies System.Drawing

Sleep 3
While($True)
{
    $Weight = 15
    If($Weight % 2){$Weight++}

    $ChangeX = (Get-Random -Min ($Weight * -1) -Max $Weight)
    $ChangeY = (Get-Random -Min ($Weight * -1) -Max $Weight)
    $Handle = [Win32.Utils]::GetForegroundWindow()

    $PHRect = New-Object System.Drawing.Rectangle
    [Void]([Win32.Utils]::GetWindowRect($Handle,[Ref]$PHRect))

    [Win32.Utils]::MoveWindow($Handle,($PHRect.X + $ChangeX),($PHRect.Y + $ChangeY),($PHRect.Width - $PHRect.X + $ChangeX/2),($PHRect.Height - $PHRect.Y + $ChangeY/2),$True)
    Sleep -Milliseconds 10
}
