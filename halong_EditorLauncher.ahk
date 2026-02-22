#Requires AutoHotkey v2.0

; Folder File Editor Launcher
~RButton::
{
    if !KeyWait("LButton", "D T1")
        return
    Sleep 500
    filepath := clipMaster()
    filepath := StrReplace(filepath, '"', "")
    filepath := RTrim(filepath, "\")

    SplitPath(A_ScriptFullPath, , &scriptDir)
    iniFile := scriptDir "\fl.ini"

    if FileExist(iniFile)
    {
        for line in StrSplit(FileRead(iniFile), "`n", "`r")
        {
            line := Trim(line)
            if (line = "")
                continue

            parts   := StrSplit(line, ",", , 2)
            path    := RTrim(Trim(parts[1], '" '), "\")
            runfile := Trim(parts.Length >= 2 ? parts[2] : "", '" ')

            if (filepath = path)
            {
                ; Absolute path? (drive or UNC)
                if RegExMatch(runfile, "^(?:[A-Za-z]:\\|\\\\)")
                {
                    SplitPath(runfile, , &runDir)
                    Run(runfile, runDir)
                    return
                }

                fullrun := filepath "\" runfile
                if FileExist(fullrun)
                {
                    Run(fullrun, filepath)
                    return
                }
                else
                {
                    MsgBox("Fallback: " runfile)
                    if (runfile != "")
                    {
                        SplitPath(runfile, , &runDir)
                        Run(runfile, runDir)
                    }
                    else
                        MsgBox("No runfile specified for " filepath)
                    return
                }
            }
        }
    }
    else
    {
        MsgBox("File Editor Launcher Paths (fl.ini) missing")
    }
}

; --- LCtrl & RCtrl ---
LCtrl & RCtrl::
{
    clipSave := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(2) {
        A_Clipboard := clipSave
        return
    }
    filepath := A_Clipboard
    A_Clipboard := clipSave
    Run("Notepad.exe " filepath)
}

; --- LAlt & RAlt ---
LAlt & RAlt::
{
    clipSave := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(2) {
        A_Clipboard := clipSave
        return
    }
    filepath := A_Clipboard
    A_Clipboard := clipSave
    Run(zed " " '"' filepath '"')
}