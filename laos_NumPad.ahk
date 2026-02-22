#Requires AutoHotkey v2.0

; Adds PG break
NumpadDiv:: {
    Send("{Raw}<div style=`"break-after:page`"></div>")
    Send("{Enter}{Enter}")
}

; Highlighted Item Search
NumpadMult:: {
    Send("^c")
    if !ClipWait(2)         ; wait up to 2s for the copy
        return
    clp := A_Clipboard
    clp := StrReplace(clp, A_Space, "+")
    Run("C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe https://duck.com/?q=" clp)
}

; Pink Box Sizes (Ctrl, L and R Alt)
^NumpadSub:: {
    Send("{Raw}<div style='position: relative; width: 100%; min-height: 0px;'><div style='position: absolute;top: -10px; left: -5px; width: 100%; background-color: rgba(255, 182, 193, 0.2);  z-index: -1; border-style: solid; border-color: rgba(255, 182, 193, 1); height: 40px;'></div></div>")
    Send("`n")
}

<!NumpadSub:: { ; Left Alt
    Send("{Raw}<div style='position: relative; width: 100%; min-height: 0px;'><div style='position: absolute;top: -10px; left: -5px; width: 100%; background-color: rgba(255, 182, 193, 0.2);  z-index: -1; border-style: solid; border-color: rgba(255, 182, 193, 1); height: 55px;'></div></div>")
    Send("`n")
}

>!NumpadSub:: { ; Right Alt
    Send("{Raw}<div style='position: relative; width: 100%; min-height: 0px;'><div style='position: absolute;top: -10px; left: -5px; width: 100%; background-color: rgba(255, 182, 193, 0.2);  z-index: -1; border-style: solid; border-color: rgba(255, 182, 193, 1); height: 90px;'></div></div>")
    Send("`n")
}

; ----------------------- 7 8 9 -----------------------

; therefore +Delta ^delta
NumpadHome::        Send("{Raw}\therefore")
+NumpadHome::       Send("{Raw}Delta")
^NumpadHome::       Send("{Raw}\delta")

; theta
NumpadUp::          Send("{Raw}\theta")

; Py Symbol(^ic function) Maker for 2100
NumpadPgUp:: {
    ib := InputBox("Enter Symbolic Variable", "Fysh AHK UI", "w300 h100")
    if (ib.Result != "OK") {
        if (interrupt() = 1)
            Send("{Raw}t = Symbol('t')")
        return
    }
    varName := ib.Value
    if (varName = "") {
        if (interrupt() = 1)
            Send("{Raw}t = Symbol('t')")
    } else {
        if (interrupt() = 1)
            Send("{Raw}" varName " = Symbol('" varName "')")
    }
}

^NumpadPgUp:: {  ; Lambdify
    ib := InputBox("Enter Symbolic Function Name", "Fysh AHK UI", "w300 h100")
    if (ib.Result != "OK" || ib.Value = "")
        return
    fn := ib.Value

    ib2 := InputBox("Enter Initial Condition Desired", "Fysh AHK UI", "w300 h100")
    if (ib2.Result != "OK")
        return

    if (interrupt() = 1) {
        Send("{Raw}" fn "_num = lambdify(t," fn ",'numpy')")
        Send("{Enter}")
        Send("{Raw}" fn "_num(" ib2.Value ")")
    }
}

; ----------------------- 4 5 6 -----------------------

; \cdot +bullet
NumpadLeft::        Send("{Raw}\cdot")
+NumpadLeft::       Send("*` ")

; Win Tab, Header Autoformat: ^Solution !Notes 
NumpadClear::       Send("{F14}")
^NumpadClear:: {
    originalClipboard := A_Clipboard
    res := InputBox("Solution Header Autoformat", "Problem Solution Title")
    if (res.Result != "OK" || res.Value = "")
        return

    title_sol := res.Value
    title_pre := "Solution,"
    margin    := (StrLen(title_sol) + StrLen(title_pre) + 1) * 10 - 10

    A_Clipboard :=
        "## <span style='font-size: large; font-weight: bold;'>" title_pre " " title_sol "</span>" .
        "<hr style='position: relative; top: -29.5px; margin-left: " margin "px; border-width: 3px; " .
        "color: #084000; border-color: #084000; border-style: solid;' />"
    ClipWait(1)

    if (interrupt() = 1)
        Send("^v")

    Sleep 300
    A_Clipboard := originalClipboard
    ClipWait(1)
}
!NumpadClear:: {
    originalClipboard := A_Clipboard
    res := InputBox("Notes Header Autoformat", "Problem Solution Title")
    if (res.Result != "OK" || res.Value = "")
        return

    title_sol := res.Value
    title_pre := "NOTE:    "
    margin    := (StrLen(title_sol) + StrLen(title_pre) + 1) * 10 - 10

    A_Clipboard :=
        "### <span style='font-size: large; font-weight: bold;'>" title_pre " " title_sol "</span>" .
        "<hr style='position: relative; top: -29.5px; margin-left: " margin "px; border-width: 3px; color: rgb(255, 106, 0); border-color: rgb(255, 106, 0); border-style: solid;' />" .
        "`r`n`r`n`r`n`r`n" .
        "### <span style='font-size: large; font-weight: bold;'>:)</span>" .
        "<hr style='position: relative; top: -29.5px; margin-left: 60px; border-width: 3px; color: rgb(255, 106, 0); border-color: rgb(255, 106, 0); border-style: solid;' />"
    ClipWait(1)

    if (interrupt() = 1)
        Send("^v")

    Sleep 300
    A_Clipboard := originalClipboard
    ClipWait(1)
}

; R^r ightarrow
NumpadRight::       Send("{Raw}\Rightarrow")
^NumpadRight::      Send("{Raw}\rightarrow")

; ----------------------- 1 2 3 -----------------------

; Fraction, +Fraction Helper
NumpadEnd::         Send("{Raw}\frac{")
+NumpadEnd:: {
    ib  := InputBox("Enter Numerator",   "Fysh AHK UI", "w300 h100")
    if (ib.Result != "OK" || ib.Value = "")
        return
    ib2 := InputBox("Enter Denominator", "Fysh AHK UI", "w300 h100")
    if (ib2.Result != "OK" || ib2.Value = "")
        return
    if (interrupt() = 1)
        Send("{Raw}\frac{" ib.Value "}{" ib2.Value "} ")
}

; Cos
NumpadDown::        Send("{Raw}\cos(")
; Sin
NumpadPgDn::        Send("{Raw}\sin(")
; Sec
+NumpadDown::       Send("{Raw}\sec(")
; Csc
+NumpadPgDn::       Send("{Raw}\csc(")

; ----------------------- 0 . Del -----------------------

; Math Omicron, +Eqn Solver
NumpadIns::         Send("{Raw}Omicron = ")

+NumpadIns:: {
    ib  := InputBox("Enter Variable to Solve For", "Fysh AHK UI", "w300 h100")
    if (ib.Result != "OK" || ib.Value = "")
        return
    ib2 := InputBox("Enter Equation", "Fysh AHK UI", "w300 h100")
    if (ib2.Result != "OK" || ib2.Value = "")
        return
    if (interrupt() = 1)
        Send("{Raw}" ib.Value "_ = solve(" ib2.Value "," ib.Value ")[0]")
}

; Math Omega, +Ohm
NumpadDel::         Send("{Raw}#$\Omega$")
+NumpadDel::        Send("{Raw}*u.Ohm")