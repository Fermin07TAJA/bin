global susk := false

; Suspends All Hotkeys
^Escape::toggleSuspend()

; Display Fire Mode
*NumLock::ShowModeTooltip("NumLock")
*CapsLock::ShowModeTooltip("CapsLock")

; Pills
;*0::consume(5.5)

; Frag
;*4::frag()

; Bandage
;*7::consume(3)

; NRG Drink
;*9::consume(3)

; Mosin Switch
*e::sniper(3)

; Burstfire Selection
LButton::burst()        ; Caps for Burstfire

burst(burst:=200) {
    if GetKeyState("CapsLock", "T") {
        if GetKeyState("NumLock", "T") {
            while GetKeyState("LButton", "P") {
                Click
                Sleep, 1000
            }
        } else {
            while GetKeyState("LButton", "P") {
                Click down
                Sleep, burst
                Click up
                Sleep, 200
            }
        }
    } else {
        Send, {LButton down}
        KeyWait, LButton
        Send, {LButton up}
    }
}

frag(time := 0, main := "1"){
    do := SubStr(A_ThisHotkey, 2)
    Hotkey, *%do%, Off
    kp(do,400)
    Sleep, 10
    Click down
    Sleep, 1000
    Click up
    kp(main)
    Hotkey, *%do%, On
}

consume(time := 0, main := "1"){
    do := SubStr(A_ThisHotkey, 1)
    Hotkey, %do%, Off
    kp(do,400)
    Sleep, time*1000+1000
    kp(main)
    Hotkey, %do%, On
}


kp(key, holdTime := 1) {
    Send, {%key% down}
    Sleep, holdTime
    Send, {%key% up}
}

sniper(time := 0, main := "1"){
    kp(main)
    do := "2"
    ;Hotkey, %do%, Off
    Click
    Sleep, 10
    kp(do)
    Sleep, 510
    Click
    Sleep, 10
    kp(main)
    ;Hotkey, %do%, On
}

toggleSuspend() {
    ;static susk := false
    susk := !susk

    stte("*0", susk)
    stte("*4", susk)
    stte("*7", susk)
    stte("*9", susk)
    stte("*e", susk)
    stte("LButton", susk)

    ToolTip % "Hotkeys are " . (susk ? "suspended" : "active")
    Sleep, 1000
    ToolTip
}

stte(hotkey, suspended) {
    Hotkey, %hotkey%, % suspended ? "Off" : "On"
}

ShowModeTooltip(key) {
    if (key = "NumLock") {
        SetNumLockState, % !GetKeyState("NumLock", "T")
        if !susk {
            ToolTip % "Single Fire  " . (!GetKeyState("NumLock", "T") ? "Off" : "On")
        }
    } else if (key = "CapsLock") {
        SetCapsLockState, % !GetKeyState("CapsLock", "T")
        if !susk {
            ToolTip % "Burst Fire  " . (!GetKeyState("CapsLock", "T") ? "Off" : "On")
        }
    }

    if !susk1 {
        Sleep, 1000
        ToolTip
    }
}
