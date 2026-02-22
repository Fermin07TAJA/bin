#Requires AutoHotkey v2.0+

; Foot Pedals

;Ctrl M
F13:: Send("^m")
;Win Tab
F14:: Send("#{Tab}")

;Ctrl q
F17:: Send("^q")
;Ctrl a
F18:: Send("^a")

;Ctrl d
F16:: Send("+^d")

; Q-Dir toggle
F15:: win_handler("C:\Q-Dir\Q-Dir_x64.exe", "Q-Dir 11")

;Ctrl Shift O (Letter)
F19:: Send("^+o")

; Katamani: Outlook toggle by Inbox title fragment
F22:: win_handler("C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE", "Inbox")

; Teams (Store path) toggle
F20:: win_handler("C:\Program Files\WindowsApps\MSTeams_25122.1415.3698.6812_x64__8wekyb3d8bbwe\ms-teams.exe", " | Microsoft Teams")
