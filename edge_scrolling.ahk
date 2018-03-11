; Edge Scrolling - use mouse for movement in games that only support ASDW keyboard movement.
;
; Click mouse button 4 (a.k.a. "back" or XButton1) to enable "Edge Scrolling" mode.
; Move mouse cursor to window edges: top=>W, bottom=>S, left=>A, right=>D.
; Click the button again to disable the mode.
; 
;   AW  W  WD
;   A       D
;   AS  S  SD
;

#SingleInstance Force

; Configurable variables
global stop_with_any_click := 0 ; bool, whether other mouse buttons disable the mode
global reach_distance = 190 ; px, do not move when mouse is close to player (square area)
global sleep_time := 50 ; ms, how often to check mouse position

global running := 0
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
min(a, b) {
  return a <= b ? a : b
}
max(a, b) {
  return a >= b ? a : b
}
remove_tooltip() {
  ToolTip
}
keep_moving() {
  MouseGetPos x, y ; 0,0 = top left
  WinGetActiveStats _, width, height, _, _
  a_bound := max(width / 2 - reach_distance, 0)
  d_bound := min(width / 2 + reach_distance, width - 1)
  s_bound := min(height / 2 + reach_distance, height - 1)
  w_bound := max(height / 2 - reach_distance, 0)
  if (x <= a_bound) {
    a_down()
  } else {
    a_up()
  }
  if (x >= d_bound) {
    d_down()
  } else {
    d_up()
  }
  if (y >= s_bound) {
    s_down()
  } else {
    s_up()
  }
  if (y <= w_bound) {
    w_down()
  } else {
    w_up()
  }
}
start() {
  running := 1
  SetTimer, keep_moving, %sleep_time%
  ToolTip Edge Scrolling: enabled
  SetTimer, remove_tooltip, -1000
}
stop() {
  running := 0
  SetTimer, keep_moving, Off
  w_up()
  s_up()
  a_up()
  d_up()
  ToolTip Edge Scrolling: disabled
  SetTimer, remove_tooltip, -1000
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
  if (stop_with_any_click and running) {
    stop()
  }
Return
