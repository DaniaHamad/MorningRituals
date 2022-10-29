extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var mainmenuButton = $MainMenuButton

var checkCounter=0
var speach = ["A healthy body comes with a healthy mind! Carla has been eating healthy and exercising every day, her mind is more focused and clearer, her body is strong and healthy when at work she would finish the job fast and efficiently which leads to her always being the employee of the month!",
"While she was running, she ran into a girl named Sara, they quickly became friends and running buddies! Carla and Sara would often visit each other and cook healthy food together. Carla has never been this happy in a long time.",
"The End – Healthy",]
var cgs

func _ready():
	textLeft.set_text(speach,checkCounter)
	checkCounter+=1

func _on_MainMenuButton_pressed():
	RouteBuilder.resetRoute()
	get_tree().change_scene("res://Game/Scenes/Mainmenu.tscn")


func _on_NextButton_pressed():
	if !textLeft.set_text(speach,checkCounter):
		yield(get_tree().create_timer(.5),"timeout")
		mainmenuButton.show()
		
	else:
		checkCounter+=1
