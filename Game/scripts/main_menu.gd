extends Control


func _ready():
	SoundManager.set_bgm("res://assets/bgm/office.mp3")

func _on_Button_pressed():
	SoundManager.play_button_click()
	get_tree().change_scene_to_file("res://game/scenes/main_game.tscn")
