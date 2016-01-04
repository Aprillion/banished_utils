#SingleInstance Force

; I found it particularly hard to do a precise jump onto small platforms in some games...
; (pressing W and E at the same time, but not quite the very exact same time,
;  just quick and correct sequence not too short and not too long)
q::
    Send {w down}
    RandSleep(7,37)
    Send {e down}
    RandSleep(340,710)
    Send {w up}
    Send {e up}
Return

; add a bit of randomness just for the fun of it,
; in no way does it prevent MMO game masters from banning
; you for using forbidden macros though!
RandSleep(x,y) {
    Random, rand, %x%, %y%
    Sleep %rand%
}
