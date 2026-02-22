#Requires AutoHotkey v2.0

;laos_CapsMaster.y
quicksearches_yt()
{
    HotIfWinActive("YTSrch")

    bind := (hk, seq) => Hotkey(hk, (*) => Send(seq), "On")
    bind("^Left",      "^{Left}")
    bind("^Right",     "^{Right}")
    bind("^Backspace", "+^{Left}{Backspace}") 
    bind("^Delete",    "^{Delete}")
    bind("^A",     "^a")          ; select all
    ib := InputBox("Search", "YTSrch", "w300 h100")
    for k in ["^Left","^Right","^Backspace","^Delete"]
        Hotkey(k, "Off")
    HotIf()

    ; Handle result
    if (ib.Result != "OK")
        MsgBox("NIET, KARTOSHKA")
    else {
        yt := "https://www.youtube.com/results?search_query=" StrReplace(ib.Value, A_Space, "+")
        Run('"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" ' yt)
    }
}