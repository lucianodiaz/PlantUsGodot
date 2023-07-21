extends Node

var pots = []
var currentIndex=-1
var currentFlowerpot:Flowerpot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_create_flowerpot(flowerpot):
	currentIndex+=1
	print("created a flowerpot: ",flowerpot)
	pots.push_back(flowerpot)
	currentFlowerpot = pots[currentIndex]
	currentFlowerpot.selectPot.connect(on_changeFlowerPot)


func on_changeFlowerPot(newFlowerPot:Flowerpot):
	currentFlowerpot = newFlowerPot

func _on_button_1_pressed():
	currentFlowerpot.getPlant().giveSun()

func _on_button_2_pressed():
	currentFlowerpot.getPlant().giveWater()


func _on_button_3_pressed():
	currentFlowerpot.getPlant().giveMusic()


func _on_button_4_pressed():
	currentFlowerpot.cleanPot()


func _on_button_5_pressed():
	currentFlowerpot.getPlant().giveLove()




func _on_timer_timeout():
	for i in range(pots.size()-1,-1,-1):
		if(is_instance_valid(pots[i].getPlant())):
			pots[i].getPlant().passTime()
#	for p in pots:
#		if is_instance_valid(p):
#			p.getPlant().passTime()
