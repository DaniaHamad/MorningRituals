extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var mainmenuButton = $MainMenuButton
onready var bathroomMirrorReflection = $BathroomMirrorReflection

var checkCounter=0
var alcoholSpeach=[]
var anorexicSpeach=[]
var fatSpeach=[]
var speach=[]
var cgs

func _ready():
	match  RouteBuilder.route:
		"AlcoholAlcohol":
			speach= alcoholSpeach
			bathroomMirrorReflection.texture = load("res://Assets/bathroomMirrorAlcoholic.png")
		"SkipRunning":
			speach = anorexicSpeach
			bathroomMirrorReflection.texture = load("res://Assets/bathroomMirrorAnorexia.png")
		"UnhealthyChill":
			speach = fatSpeach
			bathroomMirrorReflection.texture = load("res://Assets/bathroomMirrorFat.png")
	textLeft.get_node("Dialogue").text="Unhealthy Ending - "+RouteBuilder.route
	



func _on_NextButton_pressed():
	if !textLeft.set_text(speach,checkCounter):
		yield(get_tree().create_timer(.5),"timeout")
		mainmenuButton.show()
		
	else:
		checkCounter+=1


func _on_MainMenuButton_pressed():
	RouteBuilder.resetRoute()
	get_tree().change_scene("res://Game/Scenes/Mainmenu.tscn")
