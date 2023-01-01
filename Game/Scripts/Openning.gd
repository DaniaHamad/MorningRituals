extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var decisions = $Decisions

var speech = []

var cgs =[]

var checkCount=0

func _ready():
	var speechDatafile= File.new()
	speechDatafile.open ( "res://Data/"+name+"Speech.json" , File.READ )
	var speechDatajson= JSON.parse ( speechDatafile.get_as_text())
	
	var speechData=speechDatajson.result
	speechDatafile.close()
	speech = speechData["speech"]
	cgs = speechData ["cgs"]
	cg.texture = load("res://Assets/"+cgs[0])
	textLeft.set_text(speech,checkCount)
	checkCount+=1


func _on_NextButton_pressed():
	if !textLeft.set_text(speech,checkCount):
		decisions.show()
		textLeft.hide()
	else:
		cg.texture = load("res://Assets/"+cgs[checkCount])
		checkCount+=1


func _on_Breakfast_pressed(decision):
	RouteBuilder.route=decision
	RouteBuilder.breakfast=decision
	get_tree().change_scene("res://Game/Scenes/Breakfast.tscn")
