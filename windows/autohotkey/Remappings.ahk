#Requires AutoHotkey >=2.0

<+<#f23::Send "{Blind}{LShift Up}{LWin Up}{RControl Down}"
<+<#f23 Up::Send "{RControl Up}" 

*CapsLock::
{
    Send "{Blind}{Ctrl down}"
}

*CapsLock up::
{
    Send "{Blind}{Ctrl up}"
    if (A_PriorKey == "CapsLock")
        Send "{Esc}"
}

Esc::CapsLock

!h::Send "{Left}"
!j::Send "{Down}"
!k::Send "{Up}"
!l::Send "{Right}"
![::Send("^{Left}")
!]::Send("^{Right}")

^!h::
{
    ; Release Ctrl so Alt+F4 works
    Send "{Ctrl up}"
    Send "!{F4}"        ; Alt+F4
    ; Re-press Ctrl if CapsLock is still acting as Ctrl
    if (GetKeyState("CapsLock", "P"))
        Send "{Ctrl down}"
}


^!u::Run "C:\Users\Sunit\AppData\Local\Programs\Microsoft VS Code\Code.exe"
^!i::Run "C:\Users\Sunit\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe"
^!o::Run "explorer"
^!p::Run "wt"

!Space::Send "^{Esc}"
