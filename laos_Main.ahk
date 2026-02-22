#Requires AutoHotkey v2.0+

; WinHandler ----------------------------------------------------------------------------------
; Discord
; #Space::win_handler("\..\pm\discord.vbs", " - Discord")
#Space::win_handler("C:\Users\Chickenfish\AppData\Local\Discord\Update.exe --processStart discord.exe", " - Discord")
; MSTeams
; #Space:: win_handler("", " | Microsoft Teams")
; VS Code
<!Space:: win_handler(":\Program Files\Microsoft VS Code\Code.exe", "Visual Studio Code")
; Gee Pee Tee
>!g::win_handler("https://chatgpt.com", "ChatGPT")
; >!g:: win_handler("https://m365.cloud.microsoft/chat/?fromcode=cmmiadtp424&refOrigin=Other&origindomain=Office&auth=2&client-request-id=a9c9c7ff-4ca3-418d-afe1-7e2283513163", "M365 Copilot")
; Notepad
RAlt & n::  win_handler("C:\Windows\System32\notepad.exe", "Notepad")
; Thunderbird
#m::win_handler("C:\Program Files\Mozilla Thunderbird\thunderbird.exe", "Mozilla Thunderbird")
; #q::win_handler("C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE", " - Outlook")
; WhatsApp
#q::win_handler(reldir_handler("..\pm\whats.ps1"), "WhatsApp")
;Q-Dir
#W:: win_handler("C:\Q-Dir\Q-Dir_x64.exe", "Q-Dir 12")

; win_handler("https://mesa-88.cat.com/mesa-web/#/app", "MES - ")
; win_handler("C:\RootApps\pm\outlook.lnk", "Mail - ")
; win_handler("C:\RootApps\pm\outlook.vbs", "Mail - ")
;            ----------------------------------------------------------------------------------

;Bulleted list PPT
>^>+8:: 
{
    Sleep 300
    Send("{Alt}hu4{Right}{Enter}")
}

; Degree Delta
!8::
{
    txt := Trim(A_Clipboard)
    txt := StrReplace(txt, "−", "-") ;to ascii
    if !ClipWait(0.5) or !RegExMatch(txt, "^\s*[+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?\s*$") {
        MsgBox("Clipboard does not contain a number.")
        return
    }
    deg := Number(txt)*180/3.141592653589793238462643383279502884
    A_Clipboard := Format("{:.3f}", deg)
    MsgBox("Radians to degrees: " A_Clipboard " degrees.")
}

; Break <br>
LAlt & b:: SendText("<br>")

; Tap Chart
RAlt & b:: Run("https://armstrongmetalcrafts.com/Reference/MetricTapChart.aspx")

; Password / email quick inserts
LAlt & d:: SendText(THROWEMAIL)
RAlt & d:: SendText(THROWPASS)
; joaquin.paz@cat.com
LAlt & y:: SendText(emailC)
; PWD Corporate
RAlt & y:: Send("{Raw}" . pwdC)

; ShowSave
^>!i::  Run(anime)

; ID
>!j:: SendText(ID_NUM)
; Name
!j::   SendText(NAME)
; +NAME
+!j::  SendText(NAMECAPS)

; Main Cluster (EMail)
#j::  SendText(email1)
; Main Cluster (EMail)
#^j:: SendText(email2)
; Main Cluster (EMail)
#!j::  SendText(email3)

; Phun Nombur
RAlt & k:: SendText(phone)

; Musica Discord
>!m:: Run('* "' A_ScriptDir '\..\pm\musisend.ps1"')

; Alt Cluster (EMail)
#o::  SendText(email4)
; Alt Cluster (EMail)
#^o:: SendText(email5)
; Alt Cluster (EMail)
#!o::  SendText(email6)

; Extract from zip file
RAlt & p::extract_7Zip()

; Portfolio link
>!w::  SendText(PORTFOLIO)

; GitHub link
^>!w:: SendText(GITHUB)