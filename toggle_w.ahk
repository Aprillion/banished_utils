#SingleInstance Force

~XButton1::
if (w) {
  SendInput {w up}
  w := 0
} else {
  SendInput {w down}
  w := 1
}
Return

~s::
  SendInput {w up}
~w::
  w := 0
Return
