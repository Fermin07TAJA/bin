#Requires AutoHotkey v2.0
SetTimer ToolTip, -400
ToolTip("Numlock Script Active")

^!F12::
{
    ToolTip("Numlock Script Reset")
    Sleep 150
	Reload()
}


interrupt()
{
    while (1)
    {
        Sleep(10)
        if (GetKeyState("RALT", "P"))
        {
            return 1
        }
        if (GetKeyState("ESC", "P"))
        {
            return 0
        }
    }
}

;OPERATORS	----------------------------------------------------------------------------------------------------

NumpadDiv::
{
	Send "{Raw}<div style=`"break-after:page`"></div>"
	Send "{Enter}{Enter}"
}


NumpadMult::
{
    Send("^c")
    Sleep 250
    clp := A_Clipboard
    Clipwait
    clp := StrReplace(clp, A_Space, "+")
    Run("C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe https://duck.com/?q=" clp)
}
return



;^NumpadMult::^Backspace
; ^NumpadSub:: {
;     Send "{Raw}$$\colorbox{ffb6c1}{$\textcolor{black}{\begin{aligned}\end{aligned}}$}$$"
;     Send "{Left 18}"
;     Send "`r`n`r`n"
; }
; ^NumpadSub:: {
;     Send "{Raw}## <span style='font-size: large; font-weight: bold;'>"
;     Send "`n"
;     Send "{Raw}</span><hr style='position: relative; margin: 0; width: 94%; border-color: rgba(255, 182, 193, 0.5); border-style: solid; background-color: rgba(255, 182, 193, 0.5);border-width: 18px; top: 48px;'/>"
;     Send "`n"
; }
^NumpadSub:: {
    Send "{Raw}<div style='position: relative; width: 100%; min-height: 0px;'><div style='position: absolute;top: -10px; left: -5px; width: 100%; background-color: rgba(255, 182, 193, 0.2);  z-index: -1; border-style: solid; border-color: rgba(255, 182, 193, 1); height: 40px;'></div></div>"
    Send "`n"
}

<!NumpadSub:: {
    Send "{Raw}<div style='position: relative; width: 100%; min-height: 0px;'><div style='position: absolute;top: -10px; left: -5px; width: 100%; background-color: rgba(255, 182, 193, 0.2);  z-index: -1; border-style: solid; border-color: rgba(255, 182, 193, 1); height: 55px;'></div></div>"
    Send "`n"
}

>!NumpadSub:: {
    Send "{Raw}<div style='position: relative; width: 100%; min-height: 0px;'><div style='position: absolute;top: -10px; left: -5px; width: 100%; background-color: rgba(255, 182, 193, 0.2);  z-index: -1; border-style: solid; border-color: rgba(255, 182, 193, 1); height: 90px;'></div></div>"
    Send "`n"
}


;^NumpadSub::^Delete
;NumpadAdd SCREENSHOT - TAKEN

;789		----------------------------------------------------------------------------------------------------

NumpadHome::Send "{Raw}\therefore"
+NumpadHome::Send "{Raw}Delta"
^NumpadHome::Send "{Raw}\delta"

NumpadUp::Send "{Raw}\theta"

NumpadPgUp::
{
	IB := InputBox("Enter Symbolic Variable", "Fysh AHK UI", "w300 h100")
	if (IB.Value = "") {
    	if(interrupt()=1){
    		Send("{Raw}t = Symbol('t')")
        }
	} else {
        if(interrupt()=1){
    		Send("{Raw}" IB.Value " = Symbol('" IB.Value "')")
        }
	}
}

;Lambdify
^NumpadPgUp::
{
	IB := InputBox("Enter Symbolic Function Name", "Fysh AHK UI", "w300 h100")
	if (IB = "Cancel" || IB = "") {
    		MsgBox("Operation cancelled.")
	} else {
		IB2 := InputBox("Enter Initial Condition Desired", "Fysh AHK UI", "w300 h100")
        if(interrupt()=1){
            Send("{Raw}" IB.Value "_num = lambdify(t," IB.Value ",'numpy')")
    		Send("{Enter}")
    		Send("{Raw}" IB.Value "_num(" IB2.Value ")")
        }
	}
}

;456		----------------------------------------------------------------------------------------------------

NumpadLeft::Send "{Raw}\cdot"
+NumpadLeft::Send "*` "
NumpadClear::Send "{F14}"




^NumpadClear::
{
    originalClipboard := A_Clipboard
    result := InputBox("Solution Header Autoformat", "Problem Solution Title")
    title_sol := result.Value

    if (title_sol = "")
        Return

    title_pre := "Solution,"
    margin := (StrLen(title_sol) + StrLen(title_pre) + 1) * 10 - 10

    A_Clipboard := "## <span style='font-size: large; font-weight: bold;'>" title_pre " " title_sol "</span><hr style='position: relative; top: -29.5px; margin-left: " margin "px; border-width: 3px; color: #084000; border-color: #084000; border-style: solid;' />"
    ClipWait

    if(interrupt()=1){
        Send "^v"
    }

    Sleep(300)
    A_Clipboard := originalClipboard
    ClipWait
}


!NumpadClear::
{
    originalClipboard := A_Clipboard
    result := InputBox("Notes Header Autoformat", "Problem Solution Title")
    title_sol := result.Value

    if (title_sol = "")
        Return

    title_pre := "NOTE:    "
    margin := (StrLen(title_sol) + StrLen(title_pre) + 1) * 10 - 10

    A_Clipboard := "### <span style='font-size: large; font-weight: bold;'>" title_pre " " title_sol "</span><hr style='position: relative; top: -29.5px; margin-left: " margin "px; border-width: 3px; color: rgb(255, 106, 0); border-color: rgb(255, 106, 0); border-style: solid;' />`r`n`r`n`r`n`r`n### <span style='font-size: large; font-weight: bold;'>:)</span><hr style='position: relative; top: -29.5px; margin-left: 60px; border-width: 3px; color: rgb(255, 106, 0); border-color: rgb(255, 106, 0); border-style: solid;' />" 

    ClipWait

    if(interrupt()=1){
        Send "^v"
    }

    Sleep(300)
    A_Clipboard := originalClipboard
    ClipWait
}

NumpadRight::Send "{Raw}\Rightarrow"
^NumpadRight::Send "{Raw}\rightarrow"

;123		----------------------------------------------------------------------------------------------------

;Latex Fraction
NumpadEnd::Send "{Raw}\frac{"
;Latex Fraction Comment
+NumpadEnd::
{
	IB := InputBox("Enter Numerator", "Fysh AHK UI", "w300 h100")
	if (IB = "Cancel" || IB = "") {
    		MsgBox("Operation cancelled.")
	} else {
		IB2 := InputBox("Enter Denominator", "Fysh AHK UI", "w300 h100")
        if(interrupt()=1){
            Send("{Raw}\frac{" IB.Value "}{" IB2.Value "} ")
        }
	}
}
NumpadDown:: send "{Raw}\cos("
NumpadPgDn::Send "{Raw}\sin("
+NumpadDown:: send "{Raw}\sec("
+NumpadPgDn::Send "{Raw}\csc("

;0. / Insert Del----------------------------------------------------------------------------------------------------

NumpadIns::Send "{Raw}Omicron = "
+NumpadIns::
{
	IB := InputBox("Enter Variable to Solve For", "Fysh AHK UI", "w300 h100")
	if (IB = "Cancel" || IB = "") {
    		MsgBox("Operation cancelled.")
	} else {
		IB2 := InputBox("Enter Equation", "Fysh AHK UI", "w300 h100")
        if(interrupt()=1){
    		Send("{Raw}" IB.Value "_ = solve(" IB2.Value "," IB.Value ")[0]")
        }
	}
}

NumpadDel::Send "{Raw}#$\Omega$"
+NumpadDel::Send "{Raw}*u.Ohm"
