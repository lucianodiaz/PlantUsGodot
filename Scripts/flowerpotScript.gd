class_name Flowerpot

extends Node

const OFFSET_Y = 125
var plantReference: PackedScene;
var _plantInstance;
@onready var global:playerInfoScript = get_node("/root/PlayerInfoScript")
signal plantDead
signal selectPot
# Called when the node enters the scene tree for the first time.
func _ready():
	#_createPlant()
	_setPotSelected()
	pass

func _setPotSelected():
	var potSprite:Sprite2D = get_node("Area2D/Sprite2D")
	var texture = load(global.getCurrentPot())
	potSprite.changeTexture(texture)


func _createPlant():
	#Load scene Ref
	plantReference = preload("res://Scenes/Game/Plant.tscn")
	
	var plantInstance = plantReference.instantiate()
	var spawnPointNode = get_node("spawnPoint")
	plantInstance.position = spawnPointNode.position #Vector2(0,plantInstance.position.y-OFFSET_Y)
	add_child(plantInstance,false,Node.INTERNAL_MODE_FRONT)
	_plantInstance = plantInstance
	
	#add_child(plantInstance)

func getPlant():
	return _plantInstance


func cleanPot():
	_plantInstance.Clear()

func _on_plant_dead():
	_plantInstance.visible = false


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if !_plantInstance:
			_createPlant()
		else:
			emit_signal("selectPot",self)
			_plantInstance._selected()
