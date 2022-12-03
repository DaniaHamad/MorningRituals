extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var decisions = $Decisions

var speech = [
"Our main character of the story is Carla,a young lady who has an office job from 9 am to 5 pm, it’s not the most thrilling job but it pays the bills, she would always hear her coworkers talking about their daily routine.",
"One day, she returned home from work, cooked some dinner, and got ready for bed, while she was lying on her back she said: “I need some kind of morning ritual…”",
"Carla decided to wake up at 6 am to decide what kind of food she will eat every morning.\nSo, she decides…"
]

var cgs =["res://Assets/hearingCoworkers.png",
"res://Assets/LayinginBed.png",
"res://Assets/breakfastdecision.png",
]

var checkCount=0

func _ready():
	cg.texture = load(cgs[0])
	textLeft.get_node("Dialogue").text = speech[0]
	decisions.hide()


func _on_NextButton_pressed():
	checkCount+=1
	if textLeft.set_text(speech,checkCount):
		cg.texture = load(cgs[checkCount])
	else:
		decisions.show()
		textLeft.hide()


func _on_Breakfast_pressed(decision):
	RouteBuilder.route=decision
	RouteBuilder.breakfast=decision
	get_tree().change_scene("res://Game/Scenes/Breakfast.tscn")
