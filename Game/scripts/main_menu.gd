extends Control

@onready var start: TextureButton = %Start

func _ready():
	SoundManager.set_bgm("res://assets/bgm/waking.ogg")
	start.grab_focus()

func _on_start_pressed() -> void:
	SoundManager.play_button_click()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://game/scenes/main_game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
