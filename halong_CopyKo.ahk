#Requires AutoHotkey v2.0

; Globals           ---------------------------------------------
global miniExcelData := [] 
global miniExcelFile := A_ScriptDir "\mini_excel.txt"
global listening     := false
global gMini         := unset

; Conditional Sniff ---------------------------------------------
#HotIf listening
    ^c:: CopyKo_Intercept()
#HotIf

; #c opens clipboard miniexcel
#c::
{
    global listening
    listening := !listening
    if listening {
        LoadMiniExcelData()
        CopyKo_ShowGui()
    } else {
        if (IsSet(gMini) && gMini)
            gMini.Hide()
    }
}

; Prog Structures   ---------------------------------------------
CopyKo_Intercept() {
    global miniExcelData, miniExcelFile
    clipSaved := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if !ClipWait(1)
        return A_Clipboard := clipSaved

    val := A_Clipboard
    ib  := InputBox(Format("Tag for:`n{1}", val), "CopyKo", "w420 h140")
    if (ib.Result != "OK" || ib.Value = "") {
        A_Clipboard := clipSaved
        return
    }
    tag := ib.Value

    ; Slide into DMs
    miniExcelData.Push([tag, val])
    FileAppend(tag "`t" val "`n", miniExcelFile)
    CopyKo_ShowGui()
    A_Clipboard := clipSaved
}

CopyKo_ShowGui() {
    global miniExcelData, gMini

    if (IsSet(gMini) && gMini) {
        gMini.Destroy()
    }

    gMini := Gui("+AlwaysOnTop -Caption +ToolWindow", "Mini Excel")
    gMini.SetFont("s9", "Segoe UI")
    gMini.AddText("w370 Center", "CopyKo")

    ypos := 30
    for idx, row in miniExcelData {
        tag := row[1], val := row[2]

        gMini.AddText(Format("x10  y{1} w110", ypos), tag)
        gMini.AddText(Format("x125 y{1} w180", ypos), val)

        btnTag := gMini.AddButton(Format("x315 y{1} w52", ypos), "Tag")
        btnVal := gMini.AddButton(Format("x370 y{1} w52", ypos), "Val")

        ; capture idx in closure for each button
        btnTag.OnEvent("Click", (*) => CopyKo_Copy(idx, true))
        btnVal.OnEvent("Click", (*) => CopyKo_Copy(idx, false))

        ypos += 28
    }

    row := gMini.AddText(Format("x10 y{1}", ypos + 6), "")  ; spacer baseline

    btnClose  := gMini.AddButton(Format("x130 y{1} w70", ypos + 2), "Close")
    btnClear  := gMini.AddButton(Format("x210 y{1} w70", ypos + 2), "Clear")
    btnReload := gMini.AddButton(Format("x290 y{1} w70", ypos + 2), "Reload")

    btnClose.OnEvent("Click", (*) => CopyKo_CloseGui())
    btnClear.OnEvent("Click", (*) => CopyKo_Clear())
    btnReload.OnEvent("Click", (*) => CopyKo_Reload())

    ; Screen Sizes
    x := A_ScreenWidth - 550
    y := 10
    gMini.Show(Format("x{1} y{2} w430 h{3} NoActivate", x, y, ypos + 40))
}

CopyKo_Copy(idx, isTag) {
    global miniExcelData
    if (idx < 1 || idx > miniExcelData.Length)
        return
    A_Clipboard := isTag ? miniExcelData[idx][1] : miniExcelData[idx][2]
    ToolTip((isTag ? "Tag" : "Val") " copied: " A_Clipboard)
    SetTimer(() => ToolTip(), -800)
}

CopyKo_Clear() {
    global miniExcelData, miniExcelFile
    miniExcelData := []
    if FileExist(miniExcelFile)
        FileDelete(miniExcelFile)
    CopyKo_ShowGui()
    TrayTip("Mini Excel", "Data cleared.", 2)
}

CopyKo_CloseGui() {
    global gMini, listening
    if (IsSet(gMini) && gMini)
        gMini.Hide()
    listening := false
}

CopyKo_Reload() {
    global miniExcelData
    miniExcelData := []
    LoadMiniExcelData()
    CopyKo_ShowGui()
    TrayTip("Mini Excel", "Data reloaded from file.", 2)
}

LoadMiniExcelData() {
    global miniExcelData, miniExcelFile
    miniExcelData := []
    if !FileExist(miniExcelFile)
        return

    for line in StrSplit(FileRead(miniExcelFile), "`n", "`r") {
        if !line
            continue
        fields := StrSplit(line, A_Tab)
        if (fields.Length >= 2) && (fields[1] != "") && (fields[2] != "")
            miniExcelData.Push([fields[1], fields[2]])
    }
}
