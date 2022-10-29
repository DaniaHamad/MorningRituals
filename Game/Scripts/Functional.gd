extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var mainmenuButton = $MainMenuButton

var checkCounter=0
var speach=[]
var cgs

func _ready():
	textLeft.get_node("Dialogue").text="Functional Human Ending - "+RouteBuilder.route
	

func _on_MainMenuButton_pressed():
	RouteBuilder.resetRoute()
	get_tree().change_scene("res://Game/Scenes/Mainmenu.tscn")


func _on_NextButton_pressed():
	if !textLeft.set_text(speach,checkCounter):
		yield(get_tree().create_timer(.5),"timeout")
		mainmenuButton.show()
		
	else:
		checkCounter+=1
