#SingleInstance Force

; some games do not have a key binding to toggle auto running
; (especially walking simulators where it's much needed)

; press back mouse button to hold down W, press again to release W
~XButton1::
  if (w) {
    SendInput {w up}
    w := 0
  } else {
    SendInput {w down}
    w := 1
  }
Return

; also relese W when S or W are pressed manually (i.e. stop auto running)
; no need for SendInput {w up} when W itself is pressed,
; but we need to set w := 0 after either S or W are pressed (=> no Return after ~s::)
~s::
  SendInput {w up}
~w::
  w := 0
Return
