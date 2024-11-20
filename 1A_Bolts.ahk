#Persistent
CoordMode, Mouse, Screen

global mkd_dir, SourceFolder
SourceFolder := "D:\Chickenfish\Pictures\Screenshots\"

; Language Cycler
global messages, arrayLength, langIndex
messages := Object(1, "English (United States)", 2, "Spanish (Mexico)", 3, "Vietnamese", 4, "French (Switzerland)", 5, "Chinese (Simplified, China)", 6, "Japanese IME", 7, "Japanese Pinyin")
arrayLength := messages.MaxIndex()
langIndex := 2

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
direc := config.DIREC

; Chosen Editor
zed := config.ZED

;Logistics		----------------------------------------------------------------------------------------------------
#SingleInstance, Force

; RESET
^F12::
    Gui, New, +Owner -SysMenu +AlwaysOnTop
    Gui, Color, 000000
    Gui, Add, Button, x4 y4 w60 h20 gOK vBtnOK, OK
    Gui, Show, w68 h28, Main: Reset!
    Send {Down}
    Return

OK:
    Gui, Destroy
    Reload
Return

; RESET Tester Script
F24::
    Run, taskkill /F /IM AutoHotkey.exe /FI "WINDOWTITLE eq test.ahk"
    Run, "C:\Users\Chickenfish\Desktop\test.ahk"
Return

; PrtSc Master  ----------------------------------------------------------------------------------------------------
^NumpadAdd::Run * %A_ScriptDir%\..\pm\feedsend.ps1

*PrintScreen::Return ; Block default PrtSc functionality
#If (GetKeyState("PrintScreen", "P") && !GetKeyState("Shift", "P"))
    NumpadEnter::Run %zed% "C:\RootApps\bin\Numlock.ahk"
    ;NumpadAdd::Run * "C:\RootApps\pm\wbhk.ps1"
    NumpadAdd::Run * %A_ScriptDir%\..\pm\cadsend.ps1
    ^NumpadAdd::Run * %A_ScriptDir%\..\pm\quotessend.ps1

    .::
        Send, ^x
        Sleep, 500
        Clipboard := Clipboard
        formattedText := "$\overset{exists}{" Clipboard "}$"
        Send, {RAW}%formattedText%
    Return

    0::win_handler("C:\Users\Chickenfish\AppData\Local\Discord\app-1.0.9170\Discord.exe", " - Discord")

    w::Send, {F22}
    e::Send, {F23}
    r::Send, {F21}
    y::Send, {F20}
    u::Send, {F19}
    n::
        Click
        Loop, 6
            {
            sleep, 500
            Send, n
            }
        Send, {Enter}
    Return

    ; FSAE MASTER, Weekly
    f::Run % "https://docs.google.com/spreadsheets/d/1FmOXR6D-jeyJmyBriq8Hzz1BQ5pjE82IgwO-I1mIsw8/edit?gid=2058464649#gid=2058464649"
    ^f::Run % "https://canvas.cornell.edu/courses/66952/modules"

    ; TODO
    g::Run % "https://drive.google.com/drive/folders/1gGONr5472x-Q0M8pyKTg3RSKLh50_QK1"

    s::win_handler("C:\Users\Chickenfish\AppData\Local\slack\slack.exe", " - Slack")

    ; Run PowerShell as Administrator
    T::
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

    v::Run % "D:\SFX\SFX_DCSB\SadViolin.mp3"

    z::
        FormatTime, datestring,, yyyy-MM-dd ;  hh-mm-ss
        Send % "PAZ_JOAQUIN_Resume_" datestring "_(){Left}"
    return

#If

;Caps Master		----------------------------------------------------------------------------------------------------
SetCapsLockState, AlwaysOff
+CapsLock::SetCapsLockState, % (GetKeyState("CapsLock", "T") ? "Off" : "On")

#If (GetKeyState("CapsLock", "P") && !GetKeyState("Shift", "P"))
    ;-------------------------------------------------------------------------------------------
    ;v Language Cycler ------------------
    Space::
        langcycle()
    return
    langcycle() {
        global langIndex, messages, arrayLength
        currentMessage := messages[langIndex]
        Tooltip, % currentMessage ", " langIndex " of " arrayLength
        langIndex++
        if (langIndex > arrayLength) {
            langIndex := 1
        }
        Send, {RWin Down}{Space}{RWin Up}
        SetTimer, RemoveTooltip, -1000
    }
    RemoveTooltip:
        Tooltip
    return
    ;^                 ------------------

	Tab::Send {F15}
	`::Send {F16}
	a::Send {Alt}hfp ;Formtato
	d::
	Send, ^d
	sleep, 150
    Send, ^c
    ClipWait, 1
    selectedText := Clipboard
    if (RegExMatch(selectedText, "Watch\s+(.*?)\s+English", match))
    {
        Clipboard := match1
        Send, ^v
    }
    Return

	;f
	;g
	i::img_ipynb()
	>!i::Run % contra
	j::Send %direc%
	q::Send {F17}
	r::Send {U+03A9} ;Ω
	s::Send {F24}
	t::Send &emsp;{Space}
	;u

    ; VSCode Image Pasting
    v::
        ; Logistics
        if !mkd_dir
        {
            InputBox, mkd_dir, Set Destination Folder, Please enter the destination folder path:
            if ErrorLevel  ; If user cancels the prompt
            {
                MsgBox, Controlled Pasting Canceled.
                return
            }
            if (SubStr(mkd_dir, 0) != "\")
                mkd_dir .= "\"
            img_dir := mkd_dir . "img\"
            if !FileExist(img_dir)
                FileCreateDir, %img_dir%
        }

        ; Process
        Loop, Files, %SourceFolder%*.*
        {
            if (A_LoopFileTimeModified > NewestTime) {
                NewestTime := A_LoopFileTimeModified
                NewestFile := A_LoopFileLongPath
                NewestFileName := A_LoopFileName
            }
        }

        ; Paste
        FileCopy, %NewestFile%, %img_dir%%NewestFileName%, 1
        MarkdownPath := "<center><img src=""./img/" NewestFileName """ width=""600""/></center>"
        Clipboard := MarkdownPath
        ClipWait
        Send, ^v
    return


	;w

    y::
    InputBox, yt_search, YTSrch, Search,, 300, 100
    if ErrorLevel {
        MsgBox, Nope.
    } else {
        yt_search := "https://www.youtube.com/results?search_query=" . yt_search
        StringReplace, yt_search, yt_search, %A_Space%, +, All
        Run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" %yt_search%
    }
    return

	;ASCII ---------------------------

	Right::Send {U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F872} ; 🢜🢜🢜🢜🢜🡲
	Left::Send {U+1F870}{U+1F89C}{U+1F89C}{U+1F89C}{U+1F89C} ; 🡰🢜🢜🢜🢜
	Down::Send {U+1F873} ;🡳
	Up::Send {U+1F871} ;🡱

	;Path ---------------------------

	LButton::
        Filepath := clipMaster()
        Clipboard = %Filepath%
	return

	^LButton::
        Filepath := clipMaster()
        Clipboard = %Filepath%
		SplitPath, Filepath, OutFileName, OutDir  ; Split path into components
		Run, %OutDir%  ; Open file location
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
>^>+8::
sleep, 300
Send {Alt}hu4{Right}{Enter}
return

#Space::win_handler("C:\Users\Chickenfish\AppData\Local\Discord\app-1.0.9170\Discord.exe", " - Discord")
<!Space::win_handler("C:\Users\Chickenfish\AppData\Local\Programs\Microsoft VS Code\Code.exe", "Visual Studio Code")

RAlt & b::Run % "https://armstrongmetalcrafts.com/Reference/MetricTapChart.aspx"
>!c::Run % "D:\Chickenfish\Code\ScratchPad\1A_Calc.ipynb"
<!c::Run % "D:\Chickenfish\Code\ScratchPad\1A_Workflow.md"
#c::win_handler("C:\Program Files\Altium\AD24\X2.EXE","- Altium Designer Professional")

RAlt & d::Send %THROWPASS%
LAlt & d::Send %THROWEMAIL%

#e::Run, C:\Windows\explorer.exe shell:ControlPanelFolder

>!f::Send POWERTRAIN PERIPHERALS
<!f::Send PT25_A07
#<!f::Run % "https://drive.google.com/drive/folders/1Z6k7yDcmoCvjKCkCC_pLMdgMCAzDXraC?usp=drive_link"
#f::
    InputBox, u_inp, IProperties, SUB_SUBASSY_(DESC):
    u_inp := Trim(u_inp)

    ; First pattern for format: SUB_SUBASSY_(DESC)
    If RegExMatch(u_inp, "(\w+)_(\w+)_(\w+)_\(([\w\s]+)\)", fpn)
        {
            desc := fpn4 ; e.g., New Cart
            pn := fpn1 "_" fpn2 "_" fpn3 ; e.g., PT25_A0701_P02
            subassy := fpn2 ; e.g., A0701

            SendInput, %desc%{Tab} ; e.g., New Cart
            SendInput, %NAMECAPS%{Tab} ; JOAQUIN PAZ
            SendInput, %pn%{Tab} ; e.g., PT25_A0701_P02
            SendInput, %NAMECAPS%{Tab} ; JOAQUIN PAZ
            SendInput, %subassy%{Tab} ; e.g., A0701
            SendInput, POWERTRAIN PERIPHERALS{Tab} ; POWERTRAIN PERIPHERALS
            SendInput, %NAMECAPS% ; JOAQUIN PAZ
        }
    ; Second pattern for format: SUB_SUBASSY_SUB_(DESC)
    Else If RegExMatch(u_inp, "(\w+)_(\w+)_\(([\w\s]+)\)", fpn)
    {
        desc := fpn3 ; e.g., Crested
        pn := fpn1 "_" fpn2 ; e.g., PT25_A0703

        SendInput, %desc%{Tab} ; e.g., Crested
        SendInput, %NAMECAPS%{Tab} ; JOAQUIN PAZ
        SendInput, %pn%{Tab} ; e.g., PT25_A0703
        SendInput, %NAMECAPS%{Tab} ; JOAQUIN PAZ
        SendInput, %fpn2%{Tab} ; e.g., A0703
        SendInput, POWERTRAIN PERIPHERALS{Tab} ; POWERTRAIN PERIPHERALS
        SendInput, %NAMECAPS% ; JOAQUIN PAZ
    }
    Else
    {
        Msgbox, SUB_SUBASSY_(DESC) or SUB_SUBASSY_PN_(DESC) format!
    }
return




>!g::Run % "https://chatgpt.com"

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

>!m::Run * %A_ScriptDir%\..\pm\musisend.ps1

>!n::win_handler("C:\Windows\System32\notepad.exe", "Notepad")
^>!n::Run "C:\Windows\System32\notepad.exe"

!`::Send {U+00F1}

#o::Send %email4%
#^o::Send %email5%
#!o::Send %email6%

>!p::
    Filepath := clipMaster()
    Clipboard := Filepath
    SplitPath, Filepath, FileName, OutDir, EXT, BaseName
    NewOutDir := OutDir . "\" . BaseName
    LogFile := OutDir . "\extraction_log.txt"

    showdirs := "File:`n   " . Filepath . "`nParent Directory:`n   " . OutDir . "`nExtracted To:`n   " . NewOutDir
    Gui, New, +Owner +Resize -SysMenu
    Gui, Color, 000000k
    Gui, Font, s8, Segoe UI
    Gui, Add, Button, x4 y4 w100 h20 gCANCEL vBtnCancel, Cancel
    Gui, Add, Button, x109 y4 w50 h20 gEXTRACT vBtnExtract, Extract

    Gui, Add, Text, x4 y35 cFFFFFF, %showdirs%

    Gui, Show, w163 h28, Fysh 7z
    Gui, +LastFound
    WinGetPos,,, Width, Height
    WinMove, A,, (A_ScreenWidth - Width) / 2, (A_ScreenHeight - Height) / 2

    Send, {Tab}

    Return

    EXTRACT:
    FileCreateDir, %NewOutDir%
    RunWait, "C:\Program Files\7-Zip\7z.exe" x "%Filepath%" -o"%NewOutDir%"
    FileDelete, %Filepath%
    Gui, Destroy
    Return

    CANCEL:
    Gui, Destroy
    MsgBox, Canceled: %BaseName%.%EXT%
    Return
return


#q::
    win_handler("C:\RootApps\bin\whats.vbs", "WhatsApp")
return

RAlt & s::Run % "C:Bolts.pdf"
#s::
    win_handler("thunderbird.exe", "Mozilla Thunderbird")
    ;win_handler("C:\RootApps\bin\outlook.lnk", "Mail - ")
    ;win_handler("C:\RootApps\bin\outlook.vbs", "Mail - ")
return

; Function to get highlighted text
GetHighlightedText()
{
    Clipboard := ""           ; Empty the clipboard
    Send, ^c                  ; Copy the highlighted text
    ClipWait, 1               ; Wait for the clipboard to contain data
    return Clipboard
}

#u::Send {Raw}`%`%render sci_not 3
>!u::Send {Raw}`%`%render short 3
^>!u::Send {Raw}`%`%render long 3
+>!u::Send {Raw}`%`%render params

>!w::Send %PORTFOLIO%
^>!w::Send %GITHUB%

#W::
    win_handler("C:\Users\Chickenfish\AppData\Roaming\Q-Dir\Q-Dir.exe", "Q-Dir 11")
return

#z::
FormatTime, datestring,, yyyy-MM-dd ;  hh-mm-ss
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
	Run %zed% "%Filepath%"
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
    ;Run "C:\Program Files\Everything\Everything.exe"
    win_handler("C:\Program Files\Everything\Everything.exe", " - Everything")
    KeyWait Tab,T1    ;    Wait T(insert num here)s
    If ErrorLevel        ;    If NOT released in 5s
      Run %zed% "C:\RootApps\bin\1A_Bolts.ahk" ;      Say so/do stuff
  }
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
    StringReplace, Clipboard, Clipboard, np.pi, pi, All
    Clipboard := RegExReplace(Clipboard, "\s\*\s", "*")
    Clipboard := RegExReplace(Clipboard, "\s/\s", "/")
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

clipMaster() {
    Clipboard := ""
    Send ^c
    ClipWait, 2
    return Clipboard
}

win_handler(appPath, windowTitle) {
    ; Window Open Check
    WinGet, winList, List
    windowsFound := false
    minimizedWindows := false
    Loop, %winList% {
        this_window := "ahk_id " winList%A_Index%
        WinGetTitle, this_title, %this_window%

        if InStr(this_title, windowTitle) {
            windowsFound := true
            ; Minimized or not
            WinGet, winState, MinMax, %this_window%

            if (winState = -1) { ; If the window is minimized, restore it
                minimizedWindows := true
                WinRestore, %this_window%
                WinActivate, %this_window%
            } else {
                if !WinActive(this_window) {
                    WinActivate, %this_window%
                    return
                }
                WinMinimize, %this_window%
            }
        }
    }

    ; Launch
    if (!windowsFound) {
        Run, %appPath%
    }
    ; Restore
    if (minimizedWindows) {
        return
    }
}

;F Series		----------------------------------------------------------------------------------------------------

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
