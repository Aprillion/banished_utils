; Improved camera / main map control for the game Cities: Skylines (http://www.citiesskylines.com) in fullscreen mode.
; This is only a temporary workaround, until a mod is available.
; * drag terrain with right mouse button (like on google maps)
; * zoom towards screen edges with mouse wheel

;#IfWinActive Banished
#IfWinActive Cities: Skylines
#SingleInstance Force
CoordMode Mouse, Screen

; following values need tweaking according to your resolution, minimum sleep interval supported by your processor, ...
sleep_time := 15 ; ms
x_moved_during_sleep := 120 ; px
y_moved_during_sleep := 100 ; px

global a_status := "up"
global d_status := "up"
global w_status := "up"
global s_status := "up"

a_down() {
    if (a_status = "up") {
        a_status := "down"
        d_up()
        SendInput {a down}
    }
}
a_up() {
    if (a_status = "down") {
        a_status := "up"
        SendInput {a up}    
    }
}
d_down() {
    if (d_status = "up") {
        d_status := "down"
        a_up()
        SendInput {d down}
    }
}
d_up() {
    if (d_status = "down") {
        d_status := "up"
        SendInput {d up}
    }
}
w_down() {
    if (w_status = "up") {
        w_status := "down"
        s_up()
        SendInput {w down}
    }
}
w_up() {
    if (w_status = "down") {
        w_status := "up"
        SendInput {w up}
    }
}
s_down() {
    if (s_status = "up") {
        s_status := "down"
        w_up()
        SendInput {s down}
    }
}
s_up() {
    if (s_status = "down") {
        s_status := "up"
        SendInput {s up}
    }
}


; start a loop when dragging is started, holding down WASD keys until the terrain moves enough
; to keep the object under mouse at the same position (more or less)
~RButton::
    is_dragged := 1
    x_moved := 0
    y_moved := 0
    MouseGetPos x0, y0
    Loop
    {
        if not is_dragged
            break
        Sleep %sleep_time%
        MouseGetPos x1, y1
        x := x1 - x0 + x_moved
        y := y1 - y0 + y_moved
        if (Abs(x) > sleep_time and Abs(y) > sleep_time) {
            diag_correction := 0.7
        } else {
            diag_correction := 1
        }
        ; aTooltip % "x" . x . "y" . y . " x_moved" . x_moved . "y_moved" . y_moved
        if (x < -x_moved_during_sleep) {
            d_down()
            x_moved += x_moved_during_sleep * diag_correction
        } else if (x > x_moved_during_sleep) {
            a_down()
            x_moved -= x_moved_during_sleep * diag_correction
        } else {
            d_up()
            a_up()
        }
        if (y < -y_moved_during_sleep) {
            s_down()
            y_moved += y_moved_during_sleep * diag_correction
        } else if (y > y_moved_during_sleep) {
            w_down()
            y_moved -= y_moved_during_sleep * diag_correction
        } else {
            s_up()
            w_up()
        }
    }
    SetTimer, stop, -1
    Sleep 100
Return

; stop the loop when right mouse button is released
~RButton Up::
    is_dragged := 0
Return


; while zooming near edges, hold down appropriate WASD keys to zoom in that direction / zoom out in opposite direction 
; to keep the object under mouse at the same position (more or less)
zoom := 5

~WheelUp::
    zoom += 1
    if (not is_dragged) {
        MouseGetPos x, y
        x_percent := x / (A_ScreenWidth - 1)
        y_percent := y / (A_ScreenHeight - 1)
        if x_percent < 0.3
            a_down()
        if x_percent > 0.7
            d_down()
        if y_percent < 0.3
            w_down()
        if y_percent > 0.6  ; because menu is at the bottom of the screen
            s_down()
        ; TODO: variable sleep based on distance from center, separate x and y
        SetTimer, stop, -200
    }
    if zoom > 8
        zoom := 8
    Sleep 100
Return

~WheelDown::
    zoom -= 1
    if zoom > 0
    {
        if (not is_dragged) {
            MouseGetPos x, y
            x_percent := x / (A_ScreenWidth - 1)
            y_percent := y / (A_ScreenHeight - 1)
            if x_percent < 0.3
                d_down()
            if x_percent > 0.7
                a_down()
            if y_percent < 0.3
                s_down()
            if y_percent > 0.6
                w_down()
            SetTimer, stop, -100
        }
    } else {
        zoom := 0
    }
    Sleep 100
Return

stop:
    w_up()
    s_up()
    a_up()
    d_up()
Return
