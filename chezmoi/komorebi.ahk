#SingleInstance Force
#Include %A_ScriptDir%\komorebic.lib.ahk ; Generate with 'komorebic ahk-library'
#Include %A_ScriptDir%\komorebi.generated.ahk ; Application configuration rules. Generated with 'komorebic ahk-app-specific-configuration'

; Variables
; 

workspaceCount := 6
SysGet, monitorCount, MonitorCount

;
; Options
;

WatchConfiguration("enable")
FocusFollowsMouse("disable", "windows")
MouseFollowsFocus("disable")
ActiveWindowBorder("enable")
ActiveWindowBorderColour(250, 179, 135) ; Catppuccin Mocha Peach

Loop, %monitorCount% {
  monitorIndex := A_Index - 1
  EnsureWorkspaces(monitorIndex, workspaceCount)
  Loop, %workspaceCount% {
    workspaceIndex := A_Index - 1
    ContainerPadding(monitorIndex, workspaceIndex, 3)
    WorkspacePadding(monitorIndex, workspaceIndex, 3)
  }
}

CompleteConfiguration()

;
; Keybindings
;

Loop, %workspaceCount% {
  focusWorkspace := Func("FocusWorkspace").Bind(A_Index-1)
  moveToWorkspace := Func("MoveToWorkspace").Bind(A_Index-1)

  ; Switch to workspace,  Alt + 1~9
  Hotkey, !%A_Index%, % focusWorkspace, On
  ; Move window to workspace, Alt + Shift + 1~9
  Hotkey, !+%A_Index%, % moveToWorkspace, On
}

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

;
; Non-komorebi keybindings
;

; Close application; Alt + Q
!q:: WinClose, A
