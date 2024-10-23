#Requires AutoHotkey v2.0

^!F12::
{
	MsgBox("Num Reset")
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
	Send "{Ctrl down}c{Ctrl up}"
	sleep(100)
	SendInput "{Backspace}"
	sleep(100)
	Send "{Ctrl down}v{Ctrl up}"
	sleep(400)
	Send "{LWin down}3{LWin up}"
	sleep(1111)
	Send "{Ctrl down}t{Ctrl up}"
	sleep(100)
	Send "{Ctrl down}l{Ctrl up}"
	sleep(100)
	Send "{Ctrl down}v{Ctrl up}"
	sleep(100)
	Send "{Enter}"
	return
}
;^NumpadMult::^Backspace
;NumpadSub::Delete
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
    ; Store current clipboard content as a binary object
    originalClipboard := A_Clipboard

    ; Get the result from the InputBox
    result := InputBox("Solution Header Autoformat", "Problem Solution Title")

    title_sol := result.Value

    if (title_sol = "")
        Return

    title_pre := "Solution,"
    margin := (StrLen(title_sol) + StrLen(title_pre) + 1) * 11 - 25

    ; Set the formatted text to the clipboard using A_Clipboard
    A_Clipboard := "## <span style='font-size: large; font-weight: bold;'>" title_pre " " title_sol "</span><hr style='position: relative; top: -29.5px; margin-left: " margin "px; border-width: 3px; color: #084000; border-color: #084000; border-style: solid;' />"

    ; Wait until the clipboard contains the new content
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
