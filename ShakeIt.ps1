$Code = @'
    [DllImport("User32.dll")]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("User32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetWindowRect(IntPtr hWnd, out System.Drawing.Rectangle lpRect);

    [DllImport("User32.dll")]
    public extern static bool MoveWindow(IntPtr handle, int x, int y, int width, int height, bool redraw);
'@
Add-Type $Code -Name Utils -Namespace Win32 -IgnoreWarnings -ReferencedAssemblies System.Drawing

Sleep 3
While($True)
{
    $Weight = 15

    $ChangeX = (Get-Random -Min ($Weight * -1) -Max $Weight)
    $ChangeY = (Get-Random -Min ($Weight * -1) -Max $Weight)

    $Handle = [Win32.Utils]::GetForegroundWindow()

    $PHRect = New-Object System.Drawing.Rectangle
    [Void]([Win32.Utils]::GetWindowRect($Handle,[Ref]$PHRect))

    $PHRect.Offset($ChangeX,$ChangeY)

    [Void][Win32.Utils]::MoveWindow($Handle,$PHRect.Location.X,$PHRect.Location.Y,[UInt32]::Parse($PHRect.Size.Width - $PHRect.Location.X + $ChangeX),[UInt32]::Parse($PHRect.Size.Height - $PHRect.Location.Y + $ChangeY),$True)

    Sleep -Milliseconds 10
}
