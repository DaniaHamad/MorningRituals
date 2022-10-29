extends Node

onready var bgm = $BGM
onready var buttonSFX = $ButtonSFX

var musicState=false
var soundState=false

var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Sound")


func set_music(path):
		bgm.stream= load(path)
		bgm.play()

func play_button_click():
	buttonSFX.play()

func mute():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))

func sound_mute():
	AudioServer.set_bus_mute(sfx_bus, not AudioServer.is_bus_mute(sfx_bus))
