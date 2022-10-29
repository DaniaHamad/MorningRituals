extends Control

onready var cg = $CG
onready var textLeft = $TextLeft

var runningSpeach=["Carla then wears her sport outfit and slips into running shoes and off she goes, running inside a nearby park for a lab or two, it helps clear her mind every day.",
]
var chillSpeach=["Carla is too young to be that stressed, she utilizes the morning by checking her social media; and watching TV shows and news while eating some snacks.",
]
var sleepSpeach=["Carla always goes back to sleep because sleeping is the best feeling in the world, sleeping extra hours helps her focus on her job.",]
var alcoholSpeach=["Carla needs something to help her reduce her stress level before going to work, which is a glass of wine. She likes wine very much.",
]


var checkCounter=0
var speach
var cgs

func _ready():
	cg.texture=load("res://Assets/activity"+RouteBuilder.activity+".png")
	match RouteBuilder.activity:
		"Running":
			speach = runningSpeach

		"Chill":
			speach = chillSpeach

		"Sleep":
			speach = sleepSpeach
		"Alcohol":
			speach = alcoholSpeach

		
	textLeft.set_text(speach,checkCounter)
	checkCounter+=1



func _on_NextButton_pressed():
	if !textLeft.set_text(speach,checkCounter):
		match RouteBuilder.route:
			"HealthyRunning":
				get_tree().change_scene("res://Game/Scenes/HealthyEnd.tscn")
			"HealthyChill","HealthySleep","HealthyAlcohol","UnhealthyRunning","UnhealthySleep","SkipChill","SkipSleep","AlcoholRunning":
				get_tree().change_scene("res://Game/Scenes/Functional.tscn")
				
			"UnhealthyAlcohol","SkipAlcohol","AlcoholChill","AlcoholSleep":
				get_tree().change_scene("res://Game/Scenes/NonFunctional.tscn")
			"UnhealthyChill","AlcoholAlcohol","SkipRunning":
				get_tree().change_scene("res://Game/Scenes/UnhealthyEnd.tscn")
	else:
		checkCounter+=1
