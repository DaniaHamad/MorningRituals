extends Control


func _ready():
	Music.set_music("res://Music/MainMenu_ticking_time.mp3")

func _on_Button_pressed():
	Music.play_button_click()
	get_tree().change_scene("res://Game/Scenes/Openning.tscn")

