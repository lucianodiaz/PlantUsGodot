extends Node

var pots:Array[Flowerpot] = []
var currentIndex=-1
var currentFlowerpot:Flowerpot
var selection:bool = false
@export var animationPlayer:AnimationPlayer
@export var nameEditorScene:PackedScene
@export var plantNameEdit:PlantNameEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	$Info.visible = false
	pass

func _process(delta):
	if Input.is_action_just_pressed("tap"):
		if selection:
			hideInfoStat()
			currentFlowerpot = null
	
func _on_create_flowerpot(flowerpot:Flowerpot):
	currentIndex+=1
	print("created a flowerpot: ",flowerpot)
	pots.push_back(flowerpot)
	currentFlowerpot = pots[currentIndex]
	currentFlowerpot.selectPot.connect(on_changeFlowerPot)
	currentFlowerpot.createdPlant.connect(onCreatedPlant)
	currentFlowerpot.plantDead.connect(hideInfoStat)


func onCreatedPlant(pot:Flowerpot):
	var plant:Plant = pot.getPlant()
	plant.on_end_cicle.connect(updateInfoStat)
	plantNameEdit.setPlantReference(plant)
	
func on_changeFlowerPot(newFlowerPot:Flowerpot):
	currentFlowerpot = newFlowerPot
	animationPlayer.play("IN")
	$Info.onPotSelected(currentFlowerpot)
	selection = true

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

func updateInfoStat():
	if(is_instance_valid(currentFlowerpot)):
		$Info.onPotUpdate(currentFlowerpot)

func hideInfoStat():
	$Info.onPotDeselected()
	selection = false

func _on_timer_timeout():
	for i in range(pots.size()-1,-1,-1):
		if(is_instance_valid(pots[i].getPlant())):
			if pots[i].getPlant().getName() != "":
				pots[i].getPlant().passTime()
#	for p in pots:
#		if is_instance_valid(p):
#			p.getPlant().passTime()
