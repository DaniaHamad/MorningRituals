extends Control

onready var dialogue = $Dialogue
onready var musicButton = $MusicButton
onready var soundButton = $SoundButton




func _ready():
	musicButton.set_pressed_no_signal(Music.musicState)
	soundButton.set_pressed_no_signal(Music.soundState)

func set_text(speach,checkCount):
	Music.play_button_click()
	if checkCount< speach.size():
		dialogue.text = speach[checkCount]
		return true
	return false


func _on_pressed_audio(button_pressed):
	match button_pressed:
		"Music":
			Music.musicState = !Music.musicState
			musicButton.set_pressed_no_signal(Music.musicState)
			Music.mute()
		"Sound":
			Music.soundState = !Music.soundState
			soundButton.set_pressed_no_signal(Music.soundState)
			Music.sound_mute()
