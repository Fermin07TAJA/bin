#Requires AutoHotkey v2.0+
; PM Handler            ----------------------------------------------------------------
global CFP := A_ScriptDir "\..\pm\pm.ini"
LoadConfigIni(filePath) {
    cfg := Map()
    read := (section, key, default:="") => IniRead(filePath, section, key, default)

    cfg["ITINERARIO_URL"] := read("Urls",  "ITINERARIO_URL")
    cfg["contra_URL"]     := read("Urls",  "contra_URL")
    cfg["anime_URL"]      := read("Urls",  "anime_URL")
    cfg["EMAIL_1"]        := read("Emails","EMAIL_1")
    cfg["EMAIL_2"]        := read("Emails","EMAIL_2")
    cfg["EMAIL_3"]        := read("Emails","EMAIL_3")
    cfg["EMAIL_4"]        := read("Emails","EMAIL_4")
    cfg["EMAIL_5"]        := read("Emails","EMAIL_5")
    cfg["EMAIL_6"]        := read("Emails","EMAIL_6")
    cfg["PHONE_1"]        := read("Profile","PHONE_1")
    cfg["EMAIL_COMPANY"]  := read("Profile","EMAIL_COMPANY")
    cfg["PWD_COMPANY"]    := read("Profile","PWD_COMPANY")
    cfg["THROWPASS"]      := read("Snippets","THROWPASS")
    cfg["THROWEMAIL"]     := read("Snippets","THROWEMAIL")
    cfg["NAME"]           := read("Profile","NAME")
    cfg["NAMECAPS"]       := read("Profile","NAMECAPS")
    cfg["ID_NUM"]         := read("Profile","ID_NUM")
    cfg["LINKEDIN"]       := read("Profiles","LINKEDIN")
    cfg["GITHUB"]         := read("Profiles","GITHUB")
    cfg["PORTFOLIO"]      := read("Profiles","PORTFOLIO")
    cfg["DIREC"]          := read("System","DIREC")
    cfg["ZED"]            := read("System","ZED")    ; editor/command

    return cfg
}

global config := LoadConfigIni(CFP)
Cfg(key, default:="") => (config.Has(key) ? config[key] : default)

; Aliases
global itinerario := Cfg("ITINERARIO_URL")
global contra     := Cfg("contra_URL")
global anime      := Cfg("anime_URL")
global email1     := Cfg("EMAIL_1")
global email2     := Cfg("EMAIL_2")
global email3     := Cfg("EMAIL_3")
global email4     := Cfg("EMAIL_4")
global email5     := Cfg("EMAIL_5")
global email6     := Cfg("EMAIL_6")
global phone      := Cfg("PHONE_1")
global emailC     := Cfg("EMAIL_COMPANY")
global pwdC       := Cfg("PWD_COMPANY")
global THROWPASS  := Cfg("THROWPASS")
global THROWEMAIL := Cfg("THROWEMAIL")
global NAME       := Cfg("NAME")
global NAMECAPS   := Cfg("NAMECAPS")
global ID_NUM     := Cfg("ID_NUM")
global LINKEDIN   := Cfg("LINKEDIN")
global GITHUB     := Cfg("GITHUB")
global PORTFOLIO  := Cfg("PORTFOLIO")
global direc      := Cfg("DIREC")
global zed        := Cfg("ZED")


; --- Utilities         ----------------------------------------------------------------
; Used in 
; halong_EditorLauncher.(Folder File Editor Launcher).~RButton
; laos_Capsmaster.(Path copy folder).LButton
; laos_Capsmaster.(Path open folder).^LButton
; laos_Main.Extract with 7-Zip.>!p
clipMaster() {
    A_Clipboard := ""
    Send("^c")
    ClipWait(2)
    return A_Clipboard
}

; Relative Path Finder  ----------------------------------------------------------------
reldir_handler(relPath) {
    full := A_ScriptDir . "\" . relPath
    buf := Buffer(520 * 2)
    DllCall("Kernel32\GetFullPathNameW"
        , "str", full
        , "uint", 520
        , "ptr", buf
        , "ptr", 0)
    return StrGet(buf)
}

; Window Handler        ----------------------------------------------------------------
win_handler(appPath, windowTitle) {
    winList := WinGetList()
    windowsFound := false
    minimizedWindows := false

    for hwnd in winList {
        this_id := "ahk_id " hwnd
        ; title := WinGetTitle(this_id)
        if !WinExist(this_id)
            continue
        title := WinGetTitle(this_id)
        if InStr(title, windowTitle) {
            windowsFound := true
            state := WinGetMinMax(this_id) ; -1=minimized, 0=normal, 1=maximized
            if (state = -1) {
                minimizedWindows := true
                WinRestore(this_id)
                WinActivate(this_id)
            } else {
                if !WinActive(this_id) {
                    WinActivate(this_id)
                    return
                }
                WinMinimize(this_id)
            }
        }
    }

    if (!windowsFound && appPath && appPath != "")
        Run(appPath)

    if (minimizedWindows)
        return
}

; Typehold Handler      ----------------------------------------------------------------
; Run‑loop breaker, dev for numlock title headers originally
; RAlt returns 1, Esc returns 0
; Used in:
; laos_NumPad
interrupt() {
    while true {
        Sleep 10
        if GetKeyState("RAlt", "P")
            return 1
        if GetKeyState("Esc", "P")
            return 0
    }
}