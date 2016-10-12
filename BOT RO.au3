HotKeySet("{HOME}", "stop")
HotKeySet("{PAUSE}", "Pause")
HotKeySet("{F9}", "Twohand")

Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)
Opt("CaretCoordMode", 2)

Global $GameHD
Global $Paused
Global $coord
Global $coord1
Global $sit = 0
Global $blood = 0
Global $fight = 0
Global $loot = 0

Func _PSsixLoadH($gtitle)
	$GameHD = WinGetHandle($gtitle)
	If @error Then
		MsgBox(4096, "Error", "ไม่พบหน้าต่างเกม")
	Else
		Return 1
	EndIf
EndFunc

If _PSsixLoadH("Bluestacks") Then WinActivate($GameHD)

	While 1

		Blood()
		Sit()

		For $i = 0 To 5 Step 1

			Attack()
			Loot()

		Next

		Wing()

	WEnd

Func Blood()
	PixelSearch(670, 422, 670, 422, 0x424242, 10 )	;ตรวจดูเลือด
	If Not @error Then
		$blood = 1
	EndIf
	PixelSearch(686, 422, 688, 422, 0x10EF21, 50 )	;ตรวจดูเลือด
	If Not @error Then
		$blood =0
	EndIf
EndFunc

Func Sit()
	If $blood == 1 and $sit == 0 Then
		WinActivate($GameHD)
		MouseClick("",217, 192,1,10)
		MouseClick("",232, 223,1,10)
		MouseClick("",231, 249,1,10)
		$sit = 1
	EndIf

		;PixelSearch(687, 422, 687, 422, 0x10EF21, 10 )	;ตรวจดูเลือด
	If $blood == 0 and $sit == 1 Then
		WinActivate($GameHD)
		MouseClick("",217, 192,1,10)
		MouseClick("",232, 223,1,10)
		MouseClick("",231, 249,1,10)
		$sit = 0
	EndIf
EndFunc

Func Attack()
	Blood()
	$coord = PixelSearch(1121, 634, 1121, 634, 0x474747, 30 )	;ตีมอน
	If Not @error And $sit == 0 And $blood == 0 Then
		WinActivate($GameHD)
		MouseClick("",$coord[0] ,$coord[1],1,0)
		$fight = 1
		Sleep(1000)
	Else
		$fight = 0
	EndIf
EndFunc

Func Loot()
	$coord1 = PixelSearch(1121, 643, 1121, 643, 0x313131, 10 )	;เก็บของ
	If Not @error And $sit == 0 Then
		WinActivate($GameHD)
		MouseClick("",$coord1[0] ,$coord1[1],1,0)
		$loot = 1
		Sleep(50)
	Else
		$loot = 0
		Sleep(500)
	EndIf
EndFunc

Func Wing()
	If IsArray($coord) Or IsArray($coord1) == 1 Or $sit == 1 Then	;เดินหามอน วิง

	Else
		WinActivate($GameHD)
		MouseClick("", 1145, 217, 1, 0)
		Sleep(1000)
	EndIf
EndFunc

Func Twohand()
    MouseClick("", 1144, 262, 1, 0)
EndFunc

Func Pause()
    $Paused = NOT $Paused
    While $Paused
        ToolTip('pause',0,0)
    WEnd
    ToolTip("")
EndFunc

Func stop()
     ToolTip('Exit', 0, 0)
    Sleep(500)
    Exit
	ToolTip("")
EndFunc
