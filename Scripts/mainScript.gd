extends Node2D
class_name Main

signal hideUIInfo

var pots:Array[Flowerpot] = []
var currentIndex=-1
var currentFlowerpot:Flowerpot
var selection:bool = false
var uiSelection:bool = false

@export var animationPlayer:AnimationPlayer
@export var nameEditorScene:PackedScene
@export var plantNameEdit:PlantNameEdit
@export var actions:Actions
@export var info:InfoPlant
@export var camera:Camera2D

@export var zoomMax = 1.3
@export var zoomMin = 1.0
@export var zoomVelocity = 0.4

var initialCameraPosition
# Called when the node enters the scene tree for the first time.
func _ready():
	info.visible = false
	initialCameraPosition = camera.position
	pass

func _process(delta):
	if Input.is_action_just_pressed("tap"):
		if selection && !uiSelection:
			hideInfoStat()


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
	info.onPotSelected(currentFlowerpot)
	actions.visible = true
	selection = true
	zoom_object()


func updateInfoStat():
	if(is_instance_valid(currentFlowerpot)):
		info.onPotUpdate(currentFlowerpot)

func hideInfoStat():
	emit_signal("hideUIInfo")
	info.onPotDeselected()
	selection = false
	actions.visible = false
	zoomOut_object()


func _on_timer_timeout():
	for i in range(pots.size()-1,-1,-1):
		if(is_instance_valid(pots[i].getPlant())):
			if pots[i].getPlant().getName() != "":
				pots[i].getPlant().passTime()

func setUISelection(value:bool):
	uiSelection = value


func zoomOut_object():
	var tween2:Tween = get_tree().create_tween()
	tween2.tween_property(camera, "position", initialCameraPosition , zoomVelocity).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", Vector2(zoomMin,zoomMin), zoomVelocity).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await(tween.finished)
	
func zoom_object():
	var target_position = to_global(currentFlowerpot.position)
	var viewport_center = get_viewport_rect().size / 2
	var zoom_offset = viewport_center - target_position
	var tween_position:Tween = get_tree().create_tween()
	
	var final_pos = Vector2(target_position.x,(target_position.y + zoom_offset.y))
	tween_position.tween_property(camera, "position",final_pos, zoomVelocity).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween_position.start()
	
	var tween_zoom:Tween = get_tree().create_tween()
	tween_zoom.tween_property(camera, "zoom", Vector2(zoomMax,zoomMax), zoomVelocity).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween_zoom.start()
	await(tween_zoom.finished)
