class_name Flowerpot

extends Node

const OFFSET_Y = 50
var plantReference: PackedScene;
var _plantInstance:Plant
@onready var global:PlayerInfoScript = get_node("/root/PlayerInfoScript")
@export var maxAllowedPlantSize:SizesEnum.Sizes

signal plantDead
signal selectPot
signal createdPlant
# Called when the node enters the scene tree for the first time.
func _ready():
	#_createPlant()
	_setPotSelected()
	pass

func _setPotSelected():
	if global.firstTime:
		var potSprite:Sprite2D = get_node("Area2D/Sprite2D")
		var texture = load(global.getCurrentPot())
		potSprite.changeTexture(texture)
		global.firstTime = false


func _createPlant():
	#Load scene Ref
	plantReference = preload("res://Scenes/Game/Plant.tscn")
	
	var plantInstance = plantReference.instantiate()
	var spawnPointNode = get_node("spawnPoint")
	plantInstance.position = spawnPointNode.position #Vector2(0,plantInstance.position.y-OFFSET_Y)
	add_child(plantInstance,false,Node.INTERNAL_MODE_FRONT)
	_plantInstance = plantInstance
	_plantInstance.plant_created.connect(_on_plant_created)
	_plantInstance.plant_selected.connect(_on_selected_plant)
	_plantInstance.set_pot_owner(self)
	#emit_signal("createdPlant",self)
	#add_child(plantInstance)

func _on_plant_created(_plant):
	emit_signal("createdPlant",self)
	
func _on_selected_plant():
	emit_signal("selectPot",self)
	
func getPlant()-> Plant : 
	return _plantInstance

func insertPlant(p:Plant):
	_plantInstance = p
func removePlant():
	_plantInstance = null
	
func cleanPot():
	_plantInstance.Clear()

func _on_plant_dead():
	if _plantInstance:
		remove_child(_plantInstance)
		_plantInstance.queue_free()
		_plantInstance = null


func _on_area_2d_input_event(viewport, event, shape_idx):
	@warning_ignore("unused_parameter")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if !_plantInstance && global.cantSeeds > 0:
			_createPlant()
			global.cantSeeds -= 1
		else:
			_on_selected_plant()
