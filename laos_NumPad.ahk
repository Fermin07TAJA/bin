#Requires AutoHotkey v2.0

; Adds PG break
NumpadDiv::Send("mapkeys")
; NumpadDiv:: {
;     Send("{Raw}<div style=`"break-after:page`"></div>")
;     Send("{Enter}{Enter}")
; }

; Highlighted Item Search
NumpadMult::qsr("ddg", False, "Browser")
; NumpadMult::quicksearches_ddg()

; Creo Commit Saves
^!NumpadAdd::{
    OutputFile := A_ScriptDir "\creo_commits.txt"
    ClipSaved := ClipboardAll()

    try {
        A_Clipboard := ""
        Send "^c"
        if !ClipWait(1) {
            return
        }
        SelectedText := Trim(A_Clipboard, "`r`n`t ")
        if (SelectedText != "") {
            FileAppend(SelectedText "`r`n", OutputFile, "UTF-8")
            TrayTip("WE'RE DOIN' IT LIVE", "Laos")
            ToolTip("WE'RE DOIN' IT LIVE")
            SetTimer () => ToolTip(), -2000
        }
    }
    finally {
        A_Clipboard := ClipSaved
    }
}

; Powershell clear
NumpadSub::SendInput("clear{Enter}")

; ----------------------- 7 8 9 -----------------------

; W389
NumpadHome::{
    Send("W389")
    Sleep(1900)
    Click()
}

; Teamcenter - CAT
NumpadUp::{
    Send("1E5167A")
    Sleep(1900)
    Click()
}

; ^Teamcenter - SOURCE
^NumpadUp::{
    Send("1E5167D")
    Sleep(1900)
    Click()
}

; Teamcenter - PT
NumpadPgUp::{
    Send("PT")
    Sleep(500)
    Send("{Tab}")
}

; ^Teamcenter - AS
^NumpadPgUp::{
    Send("AS")
    Sleep(500)
    Send("{Tab}")
}

; ----------------------- 4 5 6 -----------------------

; Dash space
NumpadLeft::        Send("-` ")

; CREO - Edit Definition
NumpadClear::       Send("^+d")

; CREO - Open File, [^] Open File via no selection
NumpadRight::       Send("^o")      
^NumpadRight::       Send("^+o")      

; ----------------------- 1 2 3 -----------------------

; CREO - View Left +Top
NumpadEnd::Send("hvvv_LEFT")
+NumpadEnd::Send("hvvv_TOP")

; CREO - View Front +Back
NumpadDown::Send("hvvv_FRONT")
+NumpadDown::Send("hvvv_REAR")

; CREO - View Right +Bottom
NumpadPgDn::Send("hvvv_RIGHT")
+NumpadPgDn::Send("hvvv_BOTTOM")


; ----------------------- 0 . Del -----------------------
; CREO - Coords: [] PTOG, [!] Visible Off [+] On, [^] PAP, PTOALL UNBOUND
!NumpadIns::Send("^q")
+NumpadIns::Send("^a")
^NumpadIns::Send("PAP")
NumpadIns::Send("PTOG")

; CREO - Construction
NumpadDel::Send("const")        

^+c::Send("circle")

; end - erase not displayed
; eced - close window and "end"
; dep - remove dependencies. Be careful
; 
; 1p - save stp
; 3p - save stp with window
; 
; axis
; plane
; rect
;
; sect
; ex - open Project folder in explorer
; m##c is the hole tool. 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 24, 30, 36
; xz and xx Assembly
; zz and zx Mirror