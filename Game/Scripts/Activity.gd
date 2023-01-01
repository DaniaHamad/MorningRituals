extends Control

onready var cg = $CG
onready var textLeft = $TextLeft

var checkCount=0
var speech=[]
var cgs =[]

func _ready():
	var speechDatafile= File.new()
	speechDatafile.open ( "res://Data/"+name+"Speech.json" , File.READ )
	var speechDatajson= JSON.parse ( speechDatafile.get_as_text())
	
	var speechData=speechDatajson.result
	speechDatafile.close()
	speech = speechData[RouteBuilder.activity]["speech"]
	cgs = speechData [RouteBuilder.activity]["cgs"]
	cg.texture = load("res://Assets/"+cgs[0])
	textLeft.set_text(speech,checkCount)
	checkCount+=1



func _on_NextButton_pressed():
	if !textLeft.set_text(speech,checkCount):
		match RouteBuilder.route:
			"HealthyRunning":
				get_tree().change_scene("res://Game/Scenes/Healthy.tscn")
			"HealthyChill","HealthySleep":
				get_tree().change_scene("res://Game/Scenes/Functional.tscn")
				
			"HealthyAlcohol","UnhealthyAlcohol","UnhealthyRunning","UnhealthySleep","SkipChill","SkipSleep","SkipAlcohol","AlcoholRunning","AlcoholChill","AlcoholSleep":
				get_tree().change_scene("res://Game/Scenes/NonFunctional.tscn")
			"UnhealthyChill","AlcoholAlcohol","SkipRunning":
				get_tree().change_scene("res://Game/Scenes/Unhealthy.tscn")
	else:
		checkCount+=1
