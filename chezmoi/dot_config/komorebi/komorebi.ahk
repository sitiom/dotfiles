#Requires AutoHotkey v2.0
#SingleInstance Force
#Include komorebic.lib.ahk ; Generate with 'komorebic ahk-library'

;
; Variables
;

workspaceCount := 6
monitorCount := MonitorGetCount()

;
; Options
;

Loop monitorCount {
  monitorIndex := A_Index - 1
  EnsureWorkspaces(monitorIndex, workspaceCount)
}

;
; Keybindings
;

; Change the focused window, Alt + Vim direction keys
!h:: Focus("left")
!j:: Focus("down")
!k:: Focus("up")
!l:: Focus("right")

; Move the focused window in a given direction, Alt + Shift + Vim direction keys
!+h:: Move("left")
!+j:: Move("down")
!+k:: Move("up")
!+l:: Move("right")

; Resize the focused window in a given direction, Ctrl + Win + Alt + Vim direction keys
^#!h:: {
  Resize("left", "increase")
  Resize("right", "decrease")
}
^#!j:: {
  Resize("down", "increase")
  Resize("up", "decrease")
}
^#!k:: {
  Resize("up", "increase")
  Resize("down", "decrease")
}
^#!l:: {
  Resize("right", "increase")
  Resize("left", "decrease")
}

; Stack the focused window in a given direction, Alt + Shift + direction keys
!+Left:: Stack("left")
!+Down:: Stack("down")
!+Up:: Stack("up")
!+Right:: Stack("right")
!]:: CycleStack("next")
![:: CycleStack("previous")

; Unstack the focused window, Alt + Shift + D
!+d:: Unstack()
; Promote the focused window to the top of the tree, Alt + Shift + Enter
!+Enter:: Promote()
; Manage the focused window
!=:: Manage()
; Unmanage the focused window
!-:: Unmanage()
; Switch to an equal-width, max-height column layout on the main workspace, Alt + Shift + C
!+c:: ChangeLayout("columns")
; Switch to the default bsp tiling layout on the main workspace, Alt + Shift + T
!+t:: ChangeLayout("bsp")
; Toggle the Monocle layout for the focused window, Alt + Shift + F
!+f:: ToggleMonocle()
; Toggle native maximize for the focused window, Alt + Shift + =
!+=:: ToggleMaximize()
; Flip horizontally, Alt + X
!x:: FlipLayout("horizontal")
; Flip vertically, Alt + Y
!y:: FlipLayout("vertical")
; Force a retile if things get janky, Alt + Shift + R
!+r:: Retile()
; Float the focused window, Alt + T
!t:: ToggleFloat()
; Reload ~/komorebi.ahk, Alt + O
!o:: ReloadConfiguration()
; Pause responding to any window events or komorebic commands, Alt + P
!p:: TogglePause()

Loop workspaceCount {
  ; Switch to workspace,  Alt + 1~9
  Hotkey "!" A_Index, (key) => FocusWorkspace(Integer(SubStr(key, 2)) - 1), "On"
  ; Move window to workspace, Alt + Shift + 1~9
  Hotkey "!+" A_Index, (key) => MoveToWorkspace(Integer(SubStr(key, 3)) - 1), "On"
}

;
; Non-komorebi keybindings
;

; Close application; Alt + Q
!q:: WinClose "A"