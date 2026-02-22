#Requires AutoHotkey v2.0+
#SingleInstance Force

; --- Includes ---
#Include "dependencies.ahk"
#Include "halong_OS.ahk"
#Include "halong_EditorLauncher.ahk"
#Include "halong_CopyKo.ahk"
#Include "halong_quicksearches.ahk"
#Include "halong_7Zip.ahk"
#Include "halong_Powershell7.ahk"
#Include "laos_Main.ahk"
#Include "laos_Footpedals.ahk"
#Include "laos_FSeries.ahk"
#Include "laos_NumPad.ahk"
#Include "laos_CapsMaster.ahk"
#Include "laos_PrtSc.ahk"
#Include "laos_Copilot.ahk"
#Include "halong_Huion.ahk"
; Run "halong_Insomniac.ahk"

; --- Logistics ----------------------------------------------------------------
CoordMode("Mouse", "Screen")

; --- RESET --------------------------------------------------------------------
#i::
{
    g := Gui("+AlwaysOnTop -Caption -SysMenu +ToolWindow", "Reloading LAOS")
    g.BackColor := "000000"
    g.SetFont("s9 cFFFFFF", "Segoe UI")
    g.AddText("x12 y10 w120 Center", "Reloading LAOS")
    g.Show("AutoSize Center")
    SetTimer(() => (g.Destroy(), Reload()), -500)
}