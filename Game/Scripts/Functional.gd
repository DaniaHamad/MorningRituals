extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var mainmenuButton = $MainMenuButton
onready var nextButton = $TextLeft/NextButton

var speechData
var checkCount=0
var speech=[]
var cgs
#"HealthyChill","HealthySleep","HealthyAlcohol","UnhealthyRunning"
#,"UnhealthySleep","SkipChill","SkipSleep","AlcoholRunning":

func _ready():
	var speechDatafile= File.new()
	speechDatafile.open ( "res://Data/Functional/FunctionalSpeech.json" , File.READ )
	var speechDatajson= JSON.parse ( speechDatafile.get_as_text())
	
	speechData=speechDatajson.result
	speechDatafile.close()
	speech=speechData[RouteBuilder.route]
	textLeft.set_text(speech,checkCount)
	checkCount+=1
	

func _on_MainMenuButton_pressed():
	RouteBuilder.resetRoute()
	get_tree().change_scene("res://Game/Scenes/Mainmenu.tscn")


func _on_NextButton_pressed():
	if !textLeft.set_text(speech,checkCount):
		yield(get_tree().create_timer(.5),"timeout")
		mainmenuButton.show()
		nextButton.hide()
		
		
	else:
		checkCount+=1
