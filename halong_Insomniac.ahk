#Requires AutoHotkey v2.0
#SingleInstance Force

; ----------------- Anti-Idle --------------------
SetTimer(AntiIdle, 60000)
AntiIdle(*) {
    if (A_TimeIdlePhysical > 120000) { ; 2 minutes
        MouseGetPos(&x, &y)
        MouseMove(x+1, y, 0)
        MouseMove(x,   y, 0)
    }
}

; ---------- config ----------
imagePath       := A_ScriptDir "\bk.png"   ; image to show
baseWidth       := 600                     ; starting width in px
monitor_scale   := 125
scaling_factor  := 100/monitor_scale
; ---------- state ----------
isOpen := false
guis   := []       ; list of per-monitor Gui objects

; (>!) Win-Lock Substitute
!l::ToggleOverlay()   ; Alt+L

ToggleOverlay() {
    global isOpen, guis, imagePath, baseWidth
    if !isOpen {
        ; one overlay per monitor
        monCount := MonitorGetCount()                                   ; total displays
        Loop monCount {
            idx := A_Index
            MonitorGet(idx, &L, &T, &R, &B)                              ; monitor bounds
            monW := R - L, monH := B - T

            ; create a borderless, always-on-top black panel
            g := Gui("+AlwaysOnTop -Caption +ToolWindow", "")
            g.BackColor := "Black"
            g.MarginX := 0, g.MarginY := 0

            ; start with a target width and let Picture auto-compute height via h-1
            dispW := (baseWidth > monW) ? monW : baseWidth
            pic := g.Add("Picture", Format("x0 y0 w{} h-1", dispW), imagePath)

            ; show hidden first so the control can compute its auto height
            g.Show(Format("x{} y{} w{} h{} Hide", L, T, monW, monH))

            ; read the computed size, then center in the monitor
            pic.GetPos(&px, &py, &pw, &ph)                                ; GuiCtrl.GetPos
            px := Floor((monW - pw) / 2), py := Floor((monH - ph) / 2)
            pic.Move(px*scaling_factor, py*scaling_factor, pw*scaling_factor, ph*scaling_factor)

            ; now display the overlay
            g.Show()
            guis.Push(g)
        }
        ; optional: Esc closes the overlay while it's visible
        Hotkey("~Esc", CloseOverlay, "On")
        isOpen := true
    } else {
        CloseOverlay()
    }
}

CloseOverlay(*) {
    global isOpen, guis
    for g in guis
        try g.Destroy()
    guis := []
    Hotkey("~Esc", CloseOverlay, "Off")
    isOpen := false
}