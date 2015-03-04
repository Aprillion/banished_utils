; convert right mouse button drag movement into pressing WASD keys
#IfWinActive Banished
#SingleInstance Force
#Persistent
CoordMode Mouse Screen

; these values need tweaking according to your resolution, processor speed, ...
sleep_time = 12 ; ms
x_moved_during_sleep = 12 ; px
y_moved_during_sleep = 11 ; px

; start a loop when dragging is started, holding down WASD keys until there is no difference in position
*~RButton::
    dragged := 1
    x_moved := 0
    y_moved := 0
    MouseGetPos x0, y0
    Loop
    {
        Sleep %sleep_time%
        MouseGetPos x1, y1
        x := x1 - x0 + x_moved
        y := y1 - y0 + y_moved
        ; Tooltip % "x" . x . "y" . y . " x_moved" . x_moved . "y_moved" . y_moved
        if x < -%x_moved_during_sleep%
        {
            SendInput {d down}
            x_moved += x_moved_during_sleep
        } else {
            SendInput {d up}
        }
        if x > %x_moved_during_sleep%
        {
            SendInput {a down}
            x_moved -= x_moved_during_sleep
        } else {
            SendInput {a up}
        }
        if y < -%y_moved_during_sleep%
        {
            SendInput {s down}
            y_moved += y_moved_during_sleep
        } else {
            SendInput {s up}
        }
        if y > %y_moved_during_sleep%
        {
            SendInput {w down}
            y_moved -= y_moved_during_sleep
        } else {
            SendInput {w up}
        }
        if not dragged
            break
    }
    SendInput {a up}
    SendInput {d up}
    SendInput {s up}
    SendInput {w up}
Return

; stop the loop when right mouse button is released
*~RButton Up::
    dragged := 0
Return
