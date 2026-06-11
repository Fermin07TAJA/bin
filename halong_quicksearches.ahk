#Requires AutoHotkey v2.0

; Callout, Box (F) or Clipboard (T), path_base_URL, SpaceDeleter, 
qsr(stype, textfield, launchApp:="", path_base_URL := "https://duck.com/?q=", encodethis:=True)
{
    if(launchApp=="Browser")
        launchApp := DEFAULT_BROWSER

    if(textfield) {
        HotIfWinActive("Search Type: " stype)

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
        clp := ib.Value
    }
    else {
        A_Clipboard := ""
        Sleep(30)
        Send("^c")
        if !ClipWait(2)
            return
        clp := A_Clipboard
    }
    
    switch{
        case(stype=="yt"):
            path_base_URL:="https://www.youtube.com/results?search_query="
        case(stype=="ddg"):
            path_base_URL:="https://duck.com/?q="
        case(stype=="gp"):
            path_base_URL:="https://patents.google.com/patent/"
        default: return
    }

    if(encodethis)
        clp := StrReplace(clp, A_Space, "+")

    ; Run(launchApp path_base_URL clp)

    full := path_base_URL clp   
    if (launchApp != "")
        Run('"' launchApp '" "' full '"')
    else
        Run('"' full '"')
}