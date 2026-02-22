#Requires AutoHotkey v2.0

*PrintScreen:: return

; START PrtSc       -----------------------------------------------------------------------------------
#HotIf ( GetKeyState("PrintScreen", "P") && !GetKeyState("Shift", "P") )
;                   -----------------------------------------------------------------------------------

; WinHandler --------------------------------------
0:: win_handler("", " | Microsoft Teams")
s:: win_handler("C:\Users\Chickenfish\AppData\Local\slack\slack.exe", " - Slack")
;            --------------------------------------

; NumpadEnter:: Run(zed " " "C:\RootApps\bin\Numlock.ahk")
NumpadAdd::   Run('* "' A_ScriptDir '\..\pm\cadsend.ps1"')
^NumpadAdd::  Run('* "' A_ScriptDir '\..\pm\quotessend.ps1"')

; PDF extension stripper
.::
{
    clipSaved := ClipboardAll()
    A_Clipboard := ""
    Send("^a")
    Send("^c")
    if ClipWait(2) {                                 ; v2 ClipWait() [3](https://www.reddit.com/r/AutoHotkey/comments/e5hjjf/pros_and_cons_of_include_vs_run_ahk/)
        selected := A_Clipboard
        newText  := RegExReplace(selected, "\.[^.]+$")
        SendText(newText)                            ; safer for literal text  [1](https://www.redditmedia.com/r/AutoHotkey/comments/1gnxq4x/is_it_necessary_to_switch_to_v2/)
    }
    A_Clipboard := clipSaved
}

; Latex Line Combiner
l::
{
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(1)
        return

    original := A_Clipboard
    original := StrReplace(original, "`r`n", "`n")
    original := StrReplace(original, "`r", "`n")
    original := StrReplace(original, "**", "")

    lines  := StrSplit(original, "`n")
    result := ""
    i := 1

    while (i <= lines.Length()) {
        if (Trim(lines[i]) = "$") {
            if ((i + 2 <= lines.Length()) && (Trim(lines[i+2]) = "$")) {
                combined := Trim(lines[i+1])
                result .= "$" combined "$`n"
                i += 2
            } else {
                result .= lines[i] "`n"
            }
        } else {
            result .= lines[i] "`n"
        }
        i++
    }
    result := StrReplace(result, "`n", "`r`n")
    A_Clipboard := result
    Send("^v")
}

v:: Run("D:\SFX\SFX_DCSB\SadViolin.mp3")

; END   CapsMaster  -----------------------------------------------------------------------------------
#HotIf
;                   -----------------------------------------------------------------------------------