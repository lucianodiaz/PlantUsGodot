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
@export var dialogue:DialogueMessage
@export var lightControl:Lights
@export var shopListUI:ShopList

@export var zoomMax = 1.3
@export var zoomMin = 1.0
@export var zoomVelocity = 0.4

var srcPot:String = "res://Scenes/Game/Pots/med/pot_green.tscn"
var canPutPot:bool = true
var initialCameraPosition

var canMovePlant:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	info.visible = false
	initialCameraPosition = camera.position
	shopListUI.connect("on_selected_pot",_on_shop_list_on_selected_pot)
	pass

func _process(delta):
	if Input.is_action_just_pressed("tap"):
		if selection && !uiSelection:
			hideInfoStat()

func setLightEnvironment(isOpen:bool):
	if isOpen:
		lightControl._setLight()
	else:
		lightControl._setDark()
	

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
	plant.change_pot_request.connect(message_plant_need_to_grow)

func message_plant_need_to_grow():
	dialogue._showDialog()

func on_changeFlowerPot(newFlowerPot:Flowerpot):
	if(!canMovePlant):
		currentFlowerpot = newFlowerPot
		if !currentFlowerpot.getPlant(): return
		animationPlayer.play("IN")
		info.onPotSelected(currentFlowerpot)
		actions.visible = true
		selection = true
		zoom_object()
	else:
		if newFlowerPot != currentFlowerpot:
			if newFlowerPot.getPlant() == null:
				#if currentFlowerpot.getPlant().statesPlant <= newFlowerPot.maxAllowedPlantSize:
				currentFlowerpot.getPlant().set_pot_owner(newFlowerPot)
				var spawnPointNode = newFlowerPot.get_node("spawnPoint")
				currentFlowerpot.getPlant().position = spawnPointNode.position #Vector2(0,plantInstance.position.y-OFFSET_Y)
				currentFlowerpot.remove_child(currentFlowerpot.getPlant())
				newFlowerPot.add_child(currentFlowerpot.getPlant(),false,Node.INTERNAL_MODE_FRONT)
				newFlowerPot.insertPlant(currentFlowerpot.getPlant())
				currentFlowerpot.removePlant()
				
				currentFlowerpot = newFlowerPot
				canMovePlant = false
	canMovePlant = false

func waterAction():
	if currentFlowerpot == null:return
	currentFlowerpot._plantInstance.giveWater()

func loveAction():
	if currentFlowerpot == null:return
	currentFlowerpot._plantInstance.giveLove()

func rakeAction():
	if currentFlowerpot == null or currentFlowerpot.getPlant() == null : return
	canMovePlant = true
	zoomOut_object()


func updateInfoStat():
	if(is_instance_valid(currentFlowerpot) && currentFlowerpot.getPlant()):
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
	if !currentFlowerpot.getPlant() : return
	var target_position = to_global(currentFlowerpot.position)
	var viewport_center = get_viewport_rect().size / 2
	var zoom_offset = viewport_center - target_position
	var tween_position:Tween = get_tree().create_tween()
	var offset = 150
	var final_pos = Vector2(target_position.x,(target_position.y + zoom_offset.y)+offset)
	
	tween_position.tween_property(camera, "position",final_pos, zoomVelocity).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween_position.start()
	
	var tween_zoom:Tween = get_tree().create_tween()
	tween_zoom.tween_property(camera, "zoom", Vector2(zoomMax,zoomMax), zoomVelocity).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween_zoom.start()
	await(tween_zoom.finished)


func _on_ui_on_menu_pressed():
	shopListUI.visible = !shopListUI.visible


func _on_shop_list_on_selected_pot(src):
	shopListUI.visible = false
	canPutPot = true
	srcPot = src
