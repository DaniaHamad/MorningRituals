extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var decisions = $Decisions
onready var breakfastHealthy = $BreakfastHealthy
onready var breakfastUnhealthy = $BreafastUnhealthy
onready var breakfastAlcohol = $BreakfastAlcohol


var speech =[]
var checkCount=0
func _ready():
	var speechDatafile= File.new()
	speechDatafile.open ( "res://Data/"+name+"Speech.json" , File.READ )
	var speechDatajson= JSON.parse ( speechDatafile.get_as_text())
	
	var speechData=speechDatajson.result
	speechDatafile.close()
	speech = speechData[RouteBuilder.breakfast]["speech"]
	textLeft.set_text(speech,checkCount)
	checkCount+=1
	match RouteBuilder.breakfast:
		"Healthy":
			breakfastHealthy.show()
		"Unhealthy":
			breakfastUnhealthy.show()
		"Alcohol":
			breakfastAlcohol.show()
	
func _on_Activity_pressed(decision):
	RouteBuilder.activity=decision
	RouteBuilder.route+=decision
	get_tree().change_scene("res://Game/Scenes/Activity.tscn")


func _on_NextButton_pressed():
	if !textLeft.set_text(speech,checkCount):
		decisions.show()
		textLeft.hide()
	else:
		checkCount+=1
