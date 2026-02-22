#Requires AutoHotkey v2.0

; Permanent
; AOT
^!Space:: WinSetAlwaysOnTop(-1, "A")
; Control Panel
#e::Run("C:\Windows\explorer.exe shell:ControlPanelFolder")
; Itinerario
RAlt & i::Run(itinerario)
; Notepad
^>!n:: Run("C:\Windows\System32\notepad.exe")
; ñ
!`:: Send("{U+00F1}") ; ñ Character

; Bolts PDF
RAlt & s:: Run("C:Bolts.pdf")

; Terminal @C Drive
RAlt & t::pwsh7_C() ; halong_Powershell7.pwsh7_C

; Cut Line
#x::
{
    Send("{Home}+{End}")
    Sleep 100
    Send("^x")
}

; Date @(yyyy-MM-dd)
#z::SendText(FormatTime(, "yyyy-MM-dd"))

; Feed
^NumpadAdd:: Run('* "' A_ScriptDir '\..\pm\feedsend.ps1"')


; Voidtools and Edit Self
$Tab::
{
    releasedQuick := KeyWait("Tab", "T0.3") ; 300ms
    if (releasedQuick) {
        Send("{Tab Down}")
    } else {
        win_handler("C:\Program Files\Everything\Everything.exe", " - Everything")
        releasedIn5 := KeyWait("Tab", "T5")
        if (!releasedIn5) {
            Run(zed " " "C:\RootApps\bin\1AOS.ahk")
        }
    }
    KeyWait("Tab")
    Send("{Tab Up}")
}

; Media Remaps

; Play / Pause
Home:: Send("{Media_Play_Pause}")
; Prev Track
End::  Send("{Media_Prev}")
; Next Track
Ins::  Send("{Media_Next}")

