extends Control

var speech: Array = []
var cgs: Array = []
var decision = ""

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


@onready var cg: AnimatedSprite2D = %CG
@onready var ui: VBoxContainer = %UI
@onready var dialogue: RichTextLabel = %Dialogue
@onready var bgm_button: TextureButton = %BGMButton
@onready var sound_button: TextureButton = %SoundButton
@onready var back_button: TextureButton = %BackButton
@onready var next_button: TextureButton = %NextButton
@onready var main_menu_button: Button = %MainMenuButton
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var decisions: Control = %Decisions


func read_file(chapter: String, section: String):
	var speech_data_file= FileAccess.open("res://game/data/" + chapter + "_speech.json",FileAccess.READ)
	var json = JSON.new()
	json.parse ( speech_data_file.get_as_text())
	var speech_data=json.get_data()
	speech_data_file.close()
	speech += speech_data[section]["speech"]
	cgs += speech_data[section]["cgs"]
	decision = speech_data["decision"]


func _ready():
	bgm_button.set_pressed_no_signal(SoundManager.bgm_state)
	sound_button.set_pressed_no_signal(SoundManager.sound_state)
	ui.show()
	decisions.hide()
	back_button.show()
	next_button.show()
	main_menu_button.hide()
	read_file(chapters[0],"Opening")
	scene_controller()


func set_text(animate: bool = true) -> bool:
	if index < speech.size() and index >=0:
		if animate:
			dialogue.typewriter_effect(speech[index])
		else:
			dialogue.text = speech[index]
			dialogue.visible_characters = -1
		return true
	return false


func set_cg():
	if index < cgs.size() and index >=0:
		animation_player.play(cgs[index])


func scene_controller(animate_text: bool = true):
	var setted: bool = set_text(animate_text)
	set_cg()
	
	back_button.disabled = not index
	
	ui.visible = setted or decision == "end"
	decisions.visible = not setted and not (decision.is_empty() or decision == "end")
	
	if decisions.visible:
		chapter_index+=1
		for child in decisions.get_children():
			child.visible = child.name.to_lower() == chapters[chapter_index]
			if child.visible:
				child.get_child(0).grab_focus()
	if not setted and decision.is_empty():
		RouteBuilder.conclude_route()
		chapter_index =chapters.find(RouteBuilder.route_conclusion)
		read_file(RouteBuilder.route_conclusion, RouteBuilder.route)
		scene_controller()
	elif not setted and decision == "end":
		back_button.hide()
		next_button.hide()
		main_menu_button.show()


func _on_next_button_pressed():
	SoundManager.play_button_click()
	if dialogue.is_typing:
		dialogue.skip_effect()
	else:
		index = clampi(index + 1, 0, speech.size())
		scene_controller()


func _on_back_button_pressed():
	SoundManager.play_button_click()
	index = clampi(index - 1, 0, speech.size() - 1)
	scene_controller(false)


func _on_decision_pressed(decisionPicked, chapter):
	RouteBuilder.route = RouteBuilder.route + decisionPicked
	read_file(chapter, decisionPicked)
	scene_controller()


func _on_main_menu_button_pressed():
	RouteBuilder.resetRoute()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://game/scenes/main_menu.tscn")


func _on_music_button_pressed():
	SoundManager.bgm_state = !SoundManager.bgm_state
	bgm_button.set_pressed_no_signal(SoundManager.bgm_state)
	SoundManager.bgm_mute()


func _on_sound_button_pressed():
	SoundManager.sound_state = !SoundManager.sound_state
	sound_button.set_pressed_no_signal(SoundManager.sound_state)
	SoundManager.sound_mute()

func set_bgm(bgm_path: String):
	SoundManager.set_bgm("res://assets/bgm/" + bgm_path)
