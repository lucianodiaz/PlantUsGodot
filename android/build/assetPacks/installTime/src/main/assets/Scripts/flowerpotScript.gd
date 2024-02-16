class_name Flowerpot

extends Node

const OFFSET_Y = 50
var plantReference: PackedScene;
var _plantInstance:Plant;
@onready var global:playerInfoScript = get_node("/root/PlayerInfoScript")
signal plantDead
signal selectPot
signal createdPlant
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
	_plantInstance.plant_created.connect(_on_plant_created)
	_plantInstance.plant_selected.connect(_on_selected_plant)
	#emit_signal("createdPlant",self)
	#add_child(plantInstance)

func _on_plant_created(_plant):
	emit_signal("createdPlant",self)
	
func _on_selected_plant():
	emit_signal("selectPot",self)
	
func getPlant()-> Plant : 
	return _plantInstance


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
		if !_plantInstance:
			_createPlant()
		else:
			_on_selected_plant()
