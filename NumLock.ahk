#Requires AutoHotkey v2.0

^!F12::
{
	MsgBox("Num Reset")    
	Reload()    
}

;OPERATORS	----------------------------------------------------------------------------------------------------

NumpadDiv::
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
^NumpadDiv::Send "{Raw}<div style=`"break-after:page`"></div>"


NumpadMult::Backspace
^NumpadMult::^Backspace
NumpadSub::Delete
^NumpadSub::^Delete
;NumpadAdd SCREENSHOT - TAKEN

;789		----------------------------------------------------------------------------------------------------

NumpadHome::Send "{Raw}_prime"
+NumpadHome::Send "{Raw}_Delta"
^NumpadHome::Send "{Raw}\delta"

NumpadUp::Send "{Raw}\theta"
+NumpadUp::Send "{Raw} Replace all equation markers of the type \( and \) with standard $ in answers."

NumpadPgUp::
{
	IB := InputBox("Enter Symbolic Variable", "Fysh AHK UI", "w300 h100")
	if (IB.Value = "") {
    		while (!GetKeyState("RALT", "P")) {
        		Sleep(10)  ; Check every 100 milliseconds
    		}
    		Send("{Raw}t = Symbol('t')")
	} else {
    		while (!GetKeyState("RALT", "P")) {
        		Sleep(10)  ; Check every 100 milliseconds
    		}
    		Send("{Raw}" IB.Value " = Symbol('" IB.Value "')")
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
    		while (!GetKeyState("RALT", "P")) {
        		Sleep(10)  ; Check every 100 milliseconds
    		}
    		Send("{Raw}" IB.Value "_num = lambdify(t," IB.Value ",'numpy')")
		Send("{Enter}")
		Send("{Raw}" IB.Value "_num(" IB2.Value ")")
	}
}

;456		----------------------------------------------------------------------------------------------------

NumpadLeft::Send "{Raw}\cdot"
+NumpadLeft::Send "*` "
NumpadClear::Send "{Raw}#V"
+NumpadClear::Send "{Raw}*u.V"
NumpadRight::Send "{Raw}#A"
+NumpadRight::Send "{Raw}*u.A"

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
    		while (!GetKeyState("RALT", "P")) {
        		Sleep(10)  ; Check every 100 milliseconds
    		}
    		Send("{Raw}#$\frac{" IB.Value "}{" IB2.Value "}$ ")
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
    		while (!GetKeyState("RALT", "P")) {
        		Sleep(10)  ; Check every 100 milliseconds
    		}
    		Send("{Raw}" IB.Value "_ = solve(" IB2.Value "," IB.Value ")[0]")
	}
}

NumpadDel::Send "{Raw}#$\Omega$"
+NumpadDel::Send "{Raw}*u.Ohm"