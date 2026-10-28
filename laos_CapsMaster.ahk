#Requires AutoHotkey v2.0

; Remapping Toggles
SetCapsLockState("AlwaysOff")
^CapsLock:: SetCapsLockState(GetKeyState("CapsLock","T") ? "Off" : "On")
CapsLock:: return

; START CapsMaster  -----------------------------------------------------------------------------------
#HotIf GetKeyState("CapsLock", "P")
;                   -----------------------------------------------------------------------------------

; WinHandler --------------------------------------
; Word
w:: win_handler("C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE", " - Word")
;            --------------------------------------

; #V Shortcut
a::Send("#v")


; Second Clipboard ----------------------
global Clipboard2 := ""

; Secondary Clipboard Copy
c::
{
    global Clipboard2

    ClipSaved := ClipboardAll()
    A_Clipboard := ""
    Send "^c"

    if ClipWait(1)
        Clipboard2 := A_Clipboard

    A_Clipboard := ClipSaved
}

; Secondary Clipboard Paste
v::
{
    global Clipboard2
    SendText(Clipboard2)
}
; ----------------------

;CAPS - Δ Special Character
d:: Send("{U+0394}")    ; Δ Special Character

;CAPS - Sends F12
q::Send("{F12}")

;CAPS - CNTRA
RAlt & i::    Run(contra)
;CAPS - Ω
r::      Send("{U+03A9}")      ; Ω Special Character
; t::      Send("&emsp;{Space}") ; IPYNB Tab
;CAPS - Terminal @Folder
T::pwsh7_atfolder() ; halong_Powershell7.pwsh7_atfolder

; YouTube (halong_quicksearches.quicksearches_yt)
; YT Search
y::qsr("yt",True, "Browser")
; y::quicksearches_yt()

; ASCII arrows
;🢜🢜🢜🢜🢜🡲
Right:: Send("{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F872}")
;🡰🢜🢜🢜🢜
Left::  Send("{U+1F870}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}")
;🡳
Down::  Send("{U+1F873}")
;🡱
Up::    Send("{U+1F871}")

; Path copy folder
LButton::
{
    filepath := clipMaster()
    A_Clipboard := filepath
}

; Path open folder
^LButton::
{
    filepath := clipMaster()
    A_Clipboard := filepath
    SplitPath(filepath, , &outDir)
    Run(outDir)
}

; 365 Manager shortcuts

; Word: Format
; a::  Send("{Alt}hfp") ; Formtato
; Word: Wrap Image
1:: Send("{Alt}jptwo")           ; Wrap Image
; Word: Frame
f:: Send("{Alt}jpsow{Down}{Down}{Down}{Down}{Down}{Down}{Enter}") ; Frame
; Word: Center?
g:: Send("{Alt}jpagg")
; Word: Center?
u:: Send("{Alt}jpagu")

; END   CapsMaster  -----------------------------------------------------------------------------------
#HotIf
;                   -----------------------------------------------------------------------------------