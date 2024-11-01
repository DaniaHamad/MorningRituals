extends Node

@onready var bgm: AudioStreamPlayer = $BGM
@onready var button_sfx: AudioStreamPlayer = $ButtonSFX
@onready var typing_sfx: AudioStreamPlayer = $TypingSFX

var bgm_state=false
var sound_state=false

var bgm_bus = AudioServer.get_bus_index("BGM")
var sfx_bus = AudioServer.get_bus_index("SFX")

var typing_sfxs: PackedStringArray =[
	"res://assets/sfx/keyboard/single_key_press_001.mp3",
	"res://assets/sfx/keyboard/single_key_press_002.mp3",
	"res://assets/sfx/keyboard/single_key_press_003.mp3",
	"res://assets/sfx/keyboard/single_key_press_004.mp3",
	"res://assets/sfx/keyboard/single_key_press_005.mp3",
	"res://assets/sfx/keyboard/single_key_press_006.mp3",
	"res://assets/sfx/keyboard/single_key_press_007.mp3"]

func set_bgm(path):
	if bgm.playing and bgm.stream and bgm.stream.resource_path == path:
		return  
	bgm.stream= load(path)
	bgm.play()

func play_button_click():
	button_sfx.play()

func play_typing(play: bool = true):
	if play:
		var random_index = randi() % typing_sfxs.size()
		typing_sfx.stream = load(typing_sfxs[random_index])
		typing_sfx.play()
	else:
		typing_sfx.stop()

func bgm_mute():
	AudioServer.set_bus_mute(bgm_bus, not AudioServer.is_bus_mute(bgm_bus))

func sound_mute():
	AudioServer.set_bus_mute(sfx_bus, not AudioServer.is_bus_mute(sfx_bus))
