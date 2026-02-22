#Requires AutoHotkey v2.0

pwsh7_C()
{
    exe := "C:\Program Files\PowerShell\7\pwsh.exe"
    if !FileExist(exe)
        exe := "pwsh.exe"
    Run('"' exe '" -NoExit', "C:\")
}

pwsh7_atfolder() {
    Sleep 120
    SendEvent("{Alt down}s")
    Sleep 120
    SendEvent("{Alt up}")
    SendEvent("{Ctrl down}c")
    Sleep 120
    SendEvent("{Ctrl up}")
    ClipWait(0.4)
    dir := Trim(A_Clipboard)
    Sleep 120
    SendEvent("{Esc}")

    exe := "C:\Program Files\PowerShell\7\pwsh.exe"
    if !FileExist(exe)
        exe := "pwsh.exe"

    clipSave := ClipboardAll()
    A_Clipboard := ""
    if (dir = "") {
        A_Clipboard := ""
        Send("^c")
        if ClipWait(0.4) {
            sel := Trim(A_Clipboard)
            if sel != "" {
                SplitPath(sel, , &parent)
                dir := parent
            }
        }
    }
    A_Clipboard := clipSave

    Run('"' exe '" -NoExit', dir)
}