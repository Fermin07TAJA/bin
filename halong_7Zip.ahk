#Requires AutoHotkey v2.0+

extract_7Zip() {
    Filepath := clipMaster()
    A_Clipboard := Filepath

    SplitPath(Filepath, &FileName, &OutDir, &Ext, &BaseName)
    NewOutDir := OutDir "\" BaseName

    showdirs :=
        "File:`n   " Filepath "`n"
      . "Parent Directory:`n   " OutDir "`n"
      . "Extracted To:`n   " NewOutDir

    g := Gui("+Owner +Resize -SysMenu", "Fysh 7z")
    g.BackColor := "000000"
    g.SetFont("s8 cFFFFFF", "Segoe UI")

    btnCancel  := g.AddButton("x4   y4 w100 h20", "Cancel")
    btnExtract := g.AddButton("x109 y4 w50  h20 Default", "Extract")  ; Enter triggers this

    g.AddText("x4 y35", showdirs)

    cancelHandler := (*) => ( g.Destroy(), MsgBox("Canceled: " BaseName "." Ext) )
    btnCancel.OnEvent("Click", cancelHandler)
    g.OnEvent("Escape", cancelHandler)
    g.OnEvent("Close",  cancelHandler)

    btnExtract.OnEvent("Click", (*) => (
        DirCreate(NewOutDir),
        RunWait(Format('"{1}" x "{2}" -o"{3}"', "C:\Program Files\7-Zip\7z.exe", Filepath, NewOutDir)),
        FileDelete(Filepath),
        g.Destroy()
    ))

    g.Show("AutoSize Center")

    btnExtract.Focus() ; Highlight Export first of fast enter confirm
}