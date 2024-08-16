extends Node

@onready var bgm = $BGM
@onready var button_sfx = $ButtonSFX

var music_state=false
var sound_state=false

var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Sound")


func set_music(path):
		bgm.stream= load(path)
		bgm.play()

func play_button_click():
	button_sfx.play()

func mute():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))

func sound_mute():
	AudioServer.set_bus_mute(sfx_bus, not AudioServer.is_bus_mute(sfx_bus))
