; Edge Scrolling - use mouse for movement in games that only support ASDW keyboard movement.
;
; Click mouse button 4 (a.k.a. "back" or XButton1) to enable "Edge Scrolling" mode.
; Move mouse cursor to window edges: top=>W, bottom=>S, left=>A, right=>D.
; Click any (supported by AHK) mouse button to disable the mode.
; 
;   AW  W  WD
;   A       D
;   AS  S  SD
;

#SingleInstance Force

global sleep_time := 100 ; ms
global running := false ; boolean
global a_status := "up"
global d_status := "up"
global w_status := "up"
global s_status := "up"

a_down() {
  if (a_status = "up") {
    a_status := "down"
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
    SendInput {s down}
  }
}
s_up() {
  if (s_status = "down") {
    s_status := "up"
    SendInput {s up}
  }
}
keep_moving() {
  MouseGetPos x, y
  WinGetActiveStats _, w, h, _, _
  x_percent := x / w
  y_percent := y / h
  t := ""
  ; coordinates [0,0] are top left; [1,1] bottom right
  if (x_percent > 0.8) {
    t .= "D"
    d_down()
  } else {
    d_up()
  }
  if (x_percent < 0.2) {
    t .= "A"
    a_down()
  } else {
    a_up()
  }
  if (y_percent > 0.8) {
    t .= "S"
    s_down()
  } else {
    s_up()
  }
  if (y_percent < 0.2) {
    t .= "W"
    w_down()
  } else {
    w_up()
  }
  t := t ? t : "Edge Scrolling enabled (click to turn off)"
  ToolTip %t%
}
start() {
  running := true
  SetTimer, keep_moving, %sleep_time%
}
stop() {
  running := false
  SetTimer, keep_moving, Off
  w_up()
  s_up()
  a_up()
  d_up()
  ToolTip
}

; toggle for mouse button 4 ("back")
~XButton1::
  if (running) {
    stop()
  } else {
    start()
  }
Return

; stop for any mouse button (* => trigger even if modifiers like Ctrl are used)
~*LButton::
~*RButton::
~*MButton::
~*XButton2::
  if (running) {
    stop()
  }
Return
