#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

enabled := 0

#If (enabled = 1)
$Space::
	Gosub, ToggleMic
	Keywait, Space
	Gosub, ToggleMic
	Sleep, 1000
	Send, {Enter}
return
#If

ToggleMic:

	SoundSet, +1, MASTER, mute, 2			; 2 is the microphone.
	SoundGet, master_mute, , mute, 2		; Change it here too.
	
return


;	Toggle the script on and off.
^!$NumPadMult::

	; Ctrl+Alt+*
	if (enabled = 0)
	{
		enabled := 1
		SoundBeep, 750, 100
	}
	else
	{
		enabled := 0
		SoundBeep, 250, 500
	}
	
return

;	Toggle mic input manually (so the Push-To-Talk key turns it ON instead of OFF).
^$NumPadMult::

	Gosub, ToggleMic
	MsgBox, , Chatbot push-to-talk, Microphone input has been toggled!, 2
	SoundBeep, 750, 100
	
return

;	Clear the Chrome extension's input field so it doesn't complain after too many requests.
$NumPadMult::

	Send, {Control down}
	Send, {PgDn}
	Send, {Control up}
	Sleep, 50
	Send, {F5}
	Sleep, 50
	Send, {Control down}
	Send, {PgUp}
	Send, {Control up}
	
	
return