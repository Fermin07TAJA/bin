#Persistent
CoordMode, Mouse, Screen

;Password Manager	----------------------------------------------------------------------------------------------------
cfp := A_ScriptDir "\..\pm\pm.ini"
ReadConfig(filePath) {
    local config := {}
    Loop, Read, %filePath%
    {
        if (InStr(A_LoopReadLine, "=")) {
            arr := StrSplit(A_LoopReadLine, "=")
            config[arr[1]] := arr[2]
        }
    }
    return config
}
config := ReadConfig(cfp)
itinerario := config.ITINERARIO_URL
contra := config.contra_URL
anime := config.anime_URL
email1 := config.EMAIL_1
email2 := config.EMAIL_2
email3 := config.EMAIL_3
email4 := config.EMAIL_4
email5 := config.EMAIL_5
email6 := config.EMAIL_6
phone := config.PHONE_1
THROWPASS := config.THROWPASS
THROWEMAIL := config.THROWEMAIL
NAME := config.NAME
NAMECAPS := config.NAMECAPS
LINKEDIN := config.LINKEDIN
GITHUB := config.GITHUB
PORTFOLIO := config.PORTFOLIO

;Logistics		----------------------------------------------------------------------------------------------------
#SingleInstance, Force

; RESET
^F12::
	MsgBox,"Main Reset"
	Reload
return

;Caps Master		----------------------------------------------------------------------------------------------------
SetCapsLockState, AlwaysOff
+CapsLock::SetCapsLockState, % (GetKeyState("CapsLock", "T") ? "Off" : "On")

#If (GetKeyState("CapsLock", "P") && !GetKeyState("Shift", "P"))
    ;-------------------------------------------------------------------------------------------
	Tab::Send {F15}
	`::Send {F16}
	a::Send {Alt}hfp ;Formtato
	;f
	;g
	i::img_ipynb()
	>!i::Run % contra
	q::Send {F17}
	r::Send {U+03A9} ;Ω
	;u
	;w

	;ASCII ---------------------------

	Right::Send {U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F872} ; 🢜🢜🢜🢜🢜🡲
	Left::Send {U+1F870}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C} ; 🡰🢜🢜🢜🢜
	Down::Send {U+1F873} ;🡳
	Up::Send {U+1F871} ;🡱

	;Path ---------------------------

	LButton::
		Clipboard := ""  ; Clear the clipboard
		Send ^c  ; Copy selected text (file path) to the clipboard
		ClipWait, 2  ; Wait up to 2 seconds for the clipboard to contain data
		Filepath := Clipboard
		;MsgBox, % Filepath
		Clipboard = %Filepath%
	return

	^LButton::
		Clipboard := ""  ; Clear the clipboard
		Send ^c  ; Copy selected text (file path) to the clipboard
		ClipWait, 2  ; Wait up to 2 seconds for the clipboard to contain data
		Filepath := Clipboard
		;MsgBox, % Filepath
		Clipboard = %Filepath%
		SplitPath, Filepath, OutFileName, OutDir  ; Split the file path into components
		Run, %OutDir%  ; Open the folder containing the file
	return

	;WinManager ---------------------------

	F1::
		winmove()
		sleep, 500
		WinMaximize, A
	return

	;365Manager ---------------------------
	1::Send {Alt}jpaac ;Center Image

	f::Send {Alt}jpsow{Down}{Down}{Down}{Down}{Down}{Down}{Enter} ;Frame
	g::Send {Alt}jpagg ;Group
	u::Send {Alt}jpagu ;Ungroup
	w::Send {Alt}jptwo ;Wrap Image
    ;-------------------------------------------------------------------------------------------

#If
CapsLock::return ; Prevent Caps Lock from toggling when pressed alone

;Image Embed
img_ipynb()
{
	InputBox, ImageName, Fysh AHK UI, Enter Image Name,, 300, 100
	if ErrorLevel {
	    MsgBox, Operation cancelled.
	} else {
	    Send, {Raw}<center><img src="img/%ImageName%.png" alt="" height="400"/></center>
	}
}

;Alpha		----------------------------------------------------------------------------------------------------
^+8::
sleep, 300
Send {Alt}hu4{Right}{Enter}
return

RAlt & b::Run % "https://armstrongmetalcrafts.com/Reference/MetricTapChart.aspx"
RAlt & c::Run % "D:\Chickenfish\Code\ScratchPad\1A_Calc.ipynb"

RAlt & d::Send %THROWPASS%
LAlt & d::Send %THROWEMAIL%

#e::Run, C:\Windows\explorer.exe shell:ControlPanelFolder

>!g::Send Convert each plot to use fgmk2 instead of plt. Fgmk2 is in the Customize ChatGPT section.
+>!g::Send Convert to markdown. Use '$' format for equation delimiters

>!i::Run % itinerario
^>!i::Run % anime

>!j::Send jp928
!j::Send %NAME%
+!j::Send %NAMECAPS%

#j::Send %email1%
#^j::Send %email2%
#!j::Send %email3%

RAlt & k::Send %phone%

RAlt & l::Send %LINKEDIN%

RAlt & m::Send \begin{{}bmatrix{}} \end{{}bmatrix{}}

>!n::Run Notepad
^>!n::Run notepad++.exe

!`::Send {U+00F1}

#o::Send %email4%
#^o::Send %email5%
#!o::Send %email6%

#q::
	Run, C:\RootApps\bin\whats.vbs,, Hide
	sleep, 2000
	Send y&
	sleep, 500
	Send {Down}{Enter}
return

RAlt & s::Run % "C:Bolts.pdf"
^#S::Run % "D:\SFX\SFX_DCSB\SadViolin.mp3"
#s::
    Send, {LWin down}{9 down}
    Sleep, 5
    Send, {LWin up}{9 up}
return

; Function to get highlighted text
GetHighlightedText()
{
    Clipboard := ""           ; Empty the clipboard
    Send, ^c                  ; Copy the highlighted text
    ClipWait, 1               ; Wait for the clipboard to contain data
    return Clipboard
}

; Run PowerShell as Administrator
#T::
{
    path := GetHighlightedText()
    if (path != "")
    {
        path := StrReplace(path, "\", "\\")
        Run, *RunAs pwsh.exe -NoExit -Command "Set-Location -LiteralPath '%path%'", , RunAs
    }
    else
    {
        Run, pwsh.exe, , RunAs
    }
}
return

; Run PowerShell
>!T::
{
    path := GetHighlightedText()
    if (path != "")
    {
        path := StrReplace(path, "\", "\\")
        Run, pwsh.exe -NoExit -Command "Set-Location -LiteralPath '%path%'", , Normal
    }
    else
    {
        Run, pwsh.exe
    }
}
return

#u::Send {Raw}`%`%render sci_not 3
>!u::Send {Raw}`%`%render short 3
^>!u::Send {Raw}`%`%render long 3
+>!u::Send {Raw}`%`%render params

>!w::Send %PORTFOLIO%
^>!w::Send %GITHUB%

#W::
    Send, {LWin down}{8 down}
    Sleep, 5
    Send, {LWin up}{8 up}
return

#z::
FormatTime, datestring,,yyyy-MM-dd
Send %datestring%
return

;Text Editing		----------------------------------------------------------------------------------------------------
LCtrl & RCtrl::
	ClipSave := ClipboardAll
	Clipboard :=
	Send ^c
	Clipwait 2
	Filepath := Clipboard
	Clipboard := ClipSave

	;MsgBox, % Filepath
	Run Notepad.exe %Filepath%
return

LAlt & RAlt::
	ClipSave := ClipboardAll
	Clipboard :=
	Send ^c
	Clipwait 2
	Filepath := Clipboard
	Clipboard := ClipSave

	;MsgBox, % Filepath
	Run "C:\Program Files\Zed\zed.exe" "%Filepath%"
return

;OS Management		----------------------------------------------------------------------------------------------------

; Window on Top
^!SPACE::Winset, Alwaysontop, , A

; Everything Search and 1A_Bolts Editor
$Tab::                ;Trigger ($=no self-firing)
  KeyWait Tab,T0.3    ;  Wait up to 300ms
  If !ErrorLevel         ;  If released before
    Send {Tab Down}   ;    Say so/do stuff
  Else{                  ;  Or 'Else'...
    Run "C:\Program Files\Everything\Everything.exe"
    KeyWait Tab,T1    ;    Wait T(insert num here)s
    If ErrorLevel        ;    If NOT released in 5s
      Run "C:\Program Files\Zed\zed.exe" "C:\RootApps\bin\1A_Bolts.ahk" ;      Say so/do stuff
  }                      ;  ...Close 'Else' block
  KeyWait Tab         ;  Wait until released
  Send {Tab Up}       ;  Revert the pressed key
return

; AltTab Replacement
<!Tab::
{
    list := ""
    Menu, windows, Add
    Menu, windows, deleteAll
    WinGet, id, list
    Loop, %id%
    {
        this_ID := id%A_Index%
        WinGetTitle, title, ahk_id %this_ID%
        If (title = "")
            continue
        If (!IsWindow(WinExist("ahk_id" . this_ID)))
            continue
        Menu, windows, Add, %title%, ActivateTitle
        WinGet, Path, ProcessPath, ahk_id %this_ID%
        Try
            Menu, windows, Icon, %title%, %Path%,, 0
        Catch
            Menu, windows, Icon, %title%, %A_WinDir%\System32\SHELL32.dll, 3, 0
    }
    CoordMode, Mouse, Screen
    ;MouseMove, (0.4*A_ScreenWidth), (0.35*A_ScreenHeight)
    CoordMode, Menu, Screen
    Xm := (0.25*A_ScreenWidth)
    Ym := (0.25*A_ScreenHeight)
    Menu, windows, Show, %Xm%, %Ym%
}

ActivateTitle:
    SetTitleMatchMode 3
    WinActivate, %A_ThisMenuItem%
return

IsWindow(hWnd){
    WinGet, dwStyle, Style, ahk_id %hWnd%
    if ((dwStyle&0x08000000) || !(dwStyle&0x10000000)) {
        return false
    }
    WinGet, dwExStyle, ExStyle, ahk_id %hWnd%
    if (dwExStyle & 0x00000080) {
        return false
    }
    WinGetClass, szClass, ahk_id %hWnd%
    if (szClass = "TApplication") {
        return false
    }
    return true
}

;Media Management	----------------------------------------------------------------------------------------------------

; Music
Home::Media_Play_Pause

End::Media_Prev

Ins::Media_Next

; Huion / Wacom Tablet for Xournal++
^`;::tog()

tog()
{
    static togstate = 0
    if (togstate = 1)
    {
        ;msgbox ON
	Send ^+P
        togstate = 0
    }
    else
    {
        ;msgbox OFF
	Send ^+E
        togstate = 1
    }
}

;F Series		----------------------------------------------------------------------------------------------------

; DisplayFusion Replacement
; NOTE: Next two lines at the start of the file belong to F9!
; #Persistent
; CoordMode, Mouse, Screen

!F1::winmove()

winmove()
{
    MouseGetPos, xpos, ypos
    xpos -= 500
    ypos -= 10
    WinGet, active_id, ID, A
    WinMove, ahk_id %active_id%,, xpos, ypos
}

; GPT Delimiter - Reformat to Markdown
F14::
    ClipWait, 1
    StringReplace, Clipboard, Clipboard, \[, $, All
    StringReplace, Clipboard, Clipboard, \], $, All
    StringReplace, Clipboard, Clipboard, \(, $, All
    StringReplace, Clipboard, Clipboard, \), $, All
return

; Degree Delta
!F2::
    ClipWait, 1    ; Wait for the clipboard to have data
    if (ErrorLevel)  ; If there is a timeout error, inform the user
    {
        MsgBox, Clipboard does not contain data.
        return
    }

    radians := Trim(Clipboard) ;rm whitespace
    degrees := (radians * 180) / 3.14159265358979323846
    Clipboard := degrees
    MsgBox, % "Radians to degrees: " degrees
return
