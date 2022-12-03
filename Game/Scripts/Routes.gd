extends Control

onready var cg = $CG
onready var textLeft = $TextLeft
onready var decisions = $Decisions
onready var breakfastHealthy = $BreakfastHealthy
onready var breakfastUnhealthy = $BreafastUnhealthy
onready var breakfastAlcohol = $BreakfastAlcohol

var healthySpeech =["Carla decided to always start her day with a healthy breakfast, she would always make sure that her breakfast contains carbohydrates, vitamins, protein, healthy fats, and fiber.\nAfter eating her breakfast, she always:",
]

var unhealthySpeech=["Carla doesn’t like cooking, so she always eats whatever she can find or doesn’t take much effort to make, like eating sugary food like store-bought cakes, cookies, and donuts; frozen pizza, hotdogs, and burgers; may order takeout and on some occasions.",
"After eating her breakfast, she always:"
]

var skipSpeech =["Carla always skips breakfast, she doesn’t like the feeling of her stomach being full in the morning, also she thinks that not eating will help her lose weight, she feels comfortable not having any bites in the early morning,\nso she always:",
]

var alcoholSpeech=["Carla likes to start her morning with some alcohol rush in her system, she feels that to get through her job while keeping her mind saint.she needs a drink, which is a glass of wine.\nAfter she finishes drinking, she always:",

]
var speech
var checkCount=0
func _ready():
	match RouteBuilder.breakfast:
		"Healthy":
			speech = healthySpeech
			breakfastHealthy.show()
		"Unhealthy":
			speech = unhealthySpeech
			breakfastUnhealthy.show()
		"Skip":
			speech = skipSpeech
		"Alcohol":
			speech = alcoholSpeech
			breakfastAlcohol.show()
		
	textLeft.set_text(speech,checkCount)
	checkCount+=1
	decisions.hide()
	
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
