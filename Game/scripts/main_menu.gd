extends Control


func _ready():
	Music.set_music("res://assets/Music/MainMenu_ticking_time.mp3")

func _on_Button_pressed():
	Music.play_button_click()
	get_tree().change_scene_to_file("res://game/scenes/text_controller.tscn")

