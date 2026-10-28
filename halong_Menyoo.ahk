; --- Create a menu object once (global) ---
projectMenu := Menu()

; --- Menu Type ---
;assy_path       := "C:\Users\pazj\OneDrive - Caterpillar\Desktop\pn.ini"
tolerances_path := "hole_wizard.ini"
bolt_path       := "bolt_wizard.ini"

bolt_pdf := "C:\repos\corporatecarepackage\3. Templates and Enhancements\bolts.pdf"

;Launch_App2::Menyoo(assy_path)
#h::Menyoo(tolerances_path)
^#h::Menyoo(bolt_path)
+#h::Run(bolt_pdf)

Menyoo(basePath)
{
    global projectMenu

    if !FileExist(basePath)
    {
        MsgBox "INI file not found:`n" basePath
        return
    }

    iniText := FileRead(basePath)

    projectMenu.Delete()

    currentMenu := projectMenu

    Loop Parse, iniText, "`n", "`r"
    {
        line := Trim(A_LoopField)

        if (line = "" || SubStr(line, 1, 1) = ";")
            continue

        ; -------------------------
        ; [Section]
        ; [Section|s]
        ; [Section|ext]
        ; -------------------------
        if RegExMatch(line, "^\[(.+)\]$", &m)
        {
            parts := StrSplit(m[1], "|")

            section := Trim(parts[1])

            mode := (parts.Length >= 2)
                ? StrLower(Trim(parts[2]))
                : "expanded"

            if (mode = "s")
            {
                projectMenu.Add()
                subMenu := Menu()
                projectMenu.Add(section, subMenu)
                currentMenu := subMenu
            }
            else if (mode = "ext")
            {
                subMenu := Menu()
                projectMenu.Add(section, subMenu)
                currentMenu := subMenu
            }
            else
            {
                currentMenu := projectMenu

                header := "[" section "]"

                projectMenu.Add(header, MenuHeader)
                projectMenu.Disable(header)
            }

            continue
        }

        ; -------------------------
        ; CODE=Description
        ; Examples:
        ; 1.8=M1.6
        ; 9.0=5/16
        ; 7X2619=M6x10
        ; -------------------------
        if RegExMatch(line, "^([^=]+)=(.+)$", &m)
        {
            code := Trim(m[1])
            name := Trim(m[2])

            currentMenu.Add(name, CopyToClipboard.Bind(code))
        }
    }

    CoordMode("Mouse", "Screen")
    MouseGetPos(&mx, &my)

    x := Max(mx - 150, 0)
    y := Max(my - 140, 0)

    projectMenu.Show(x, y)
}

CopyToClipboard(selectedItem, *)
{
    A_Clipboard := selectedItem
    Send("^v")
}

MenuHeader(*)
{
    ; intentionally empty
}