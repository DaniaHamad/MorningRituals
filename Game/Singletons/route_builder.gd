extends Node


var route=""
var route_conclusion =""

func resetRoute():
	route=""
	route_conclusion =""

func conclude_route():
	match route:
		"HealthyRunning":
			route_conclusion = "healthy"
		"HealthyChill","HealthySleep":
			route_conclusion = "functional"
		"HealthyAlcohol","UnhealthyAlcohol","UnhealthyRunning","UnhealthySleep","SkipChill","SkipSleep","SkipAlcohol","AlcoholRunning","AlcoholChill","AlcoholSleep":
			route_conclusion = "nonfunctional"
		"UnhealthyChill","AlcoholAlcohol","SkipRunning":
			route_conclusion = "unhealthy"
