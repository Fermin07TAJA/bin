#Requires AutoHotkey v2.0

; Huion / Wacom Tablet for Xournal++
^`;:: tog()
tog() {
    static togstate := 0
    if (togstate = 1) {
        Send("^+P")
        togstate := 0
    } else {
        Send("^+E")
        togstate := 1
    }
}