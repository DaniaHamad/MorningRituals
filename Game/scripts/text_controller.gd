extends Node

var speech: Array = []
var cgs: Array = []
var decision =""

var chapters: PackedStringArray =[
	"opening",
	"breakfast",
	"activity",
	"healthy",
	"unhealthy",
	"functional",
	"nonfuntional",]

var index: int = 0
var chapter_index: int = 0


@onready var cg = %CG
@onready var dialogue = %Dialogue
@onready var music_button = %MusicButton
@onready var sound_button = %SoundButton
@onready var animation_player = %AnimationPlayer
@onready var decisions = %Decisions
@onready var ui = %UI
@onready var next_button = %NextButton
@onready var back_button = %BackButton
@onready var main_menu_button = %MainMenuButton


func read_file(chapter: String, section: String):
	var speech_data_file= FileAccess.open("res://game/data/" + chapter + "_speech.json",FileAccess.READ)
	var json = JSON.new()
	json.parse ( speech_data_file.get_as_text())
	var speech_data=json.get_data()
	speech_data_file.close()
	speech = speech_data[section]["speech"]
	cgs = speech_data[section]["cgs"]
	decision = speech_data["decision"]
	index = 0
	control_scene()

func _ready():
	music_button.set_pressed_no_signal(Music.music_state)
	sound_button.set_pressed_no_signal(Music.sound_state)
	ui.show()
	decisions.hide()
	back_button.show()
	next_button.show()
	main_menu_button.hide()
	read_file(chapters[0],"Opening")


func set_text() -> bool:
	if index < speech.size() and index >=0:
		dialogue.text = speech[index]
		return true
	return false

func set_cg():
	if index < cgs.size() and index >=0:
		animation_player.play(cgs[index])

func control_scene():
	var setted: bool = set_text()
	set_cg()
	
	back_button.disabled = not index
	
	ui.visible = setted or decision == "end"
	decisions.visible = not setted and not (decision.is_empty() or decision == "end")
	
	if decisions.visible:
		chapter_index+=1
		for child in decisions.get_children():
			child.visible = child.name.to_lower() == chapters[chapter_index]
	if not setted and decision.is_empty():
		RouteBuilder.conclude_route()
		chapter_index =chapters.find(RouteBuilder.route_conclusion)
		read_file(RouteBuilder.route_conclusion, RouteBuilder.route)
	elif not setted and decision == "end":
		back_button.hide()
		next_button.hide()
		main_menu_button.show()


func _on_next_button_pressed():
	Music.play_button_click()
	index = clampi(index + 1, 0, speech.size())
	control_scene()


func _on_back_button_pressed():
	Music.play_button_click()
	index = clampi(index - 1, 0, speech.size() - 1)
	control_scene()


func _on_decision_pressed(decisionPicked, chapter):
	RouteBuilder.route = RouteBuilder.route + decisionPicked
	read_file(chapter, decisionPicked)


func _on_main_menu_button_pressed():
	RouteBuilder.resetRoute()
	get_tree().change_scene_to_file("res://game/scenes/main_menu.tscn")


func _on_music_button_pressed():
	
	Music.music_state = !Music.music_state
	music_button.set_pressed_no_signal(Music.music_state)
	Music.mute()


func _on_sound_button_pressed():
	Music.sound_state = !Music.sound_state
	sound_button.set_pressed_no_signal(Music.sound_state)
	Music.sound_mute()
