extends Node

@onready var bgm = $BGM
@onready var button_sfx = $ButtonSFX

var bgm_state=false
var sound_state=false

var bgm_bus = AudioServer.get_bus_index("BGM")
var sfx_bus = AudioServer.get_bus_index("SFX")


func set_bgm(path):
	if bgm.playing and bgm.stream and bgm.stream.resource_path == path:
		return  
	bgm.stream= load(path)
	bgm.play()

func play_button_click():
	button_sfx.play()

func bgm_mute():
	AudioServer.set_bus_mute(bgm_bus, not AudioServer.is_bus_mute(bgm_bus))

func sound_mute():
	AudioServer.set_bus_mute(sfx_bus, not AudioServer.is_bus_mute(sfx_bus))
