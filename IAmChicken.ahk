
^+F9::Run, % "C:\RootApps\bin\IAmChicken.lnk"

global hwnd := 0

+F9::iamchickenhide()
^!F9::RestoreWindow()

iamchickenhide() {
    global hwnd
    WinGet, hwnd, ID, ahk_class CASCADIA_HOSTING_WINDOW_CLASS ahk_exe WindowsTerminal.exe
    if (hwnd) {
        WinHide, ahk_id %hwnd%
        TrayTip, Python Script, IAmChicken Terminal Hidden
    } else {
        TrayTip, Could not find the terminal window.
    }
}

RestoreWindow() {
    global hwnd
    if (hwnd) {
        WinShow, ahk_id %hwnd%
        WinActivate, ahk_id %hwnd%
        TrayTip, Python Script, IAmChicken Terminal Open
    } else {
        TrayTip, No stored window handle found. Please reopen the window.
    }
}
