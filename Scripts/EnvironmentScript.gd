extends Node

var flowerPotReference: PackedScene;
var currentSpawnPoint:Area2D

signal create_flowerpot

# Called when the node enters the scene tree for the first time.
func _ready():
	# _createFlowerpot();
	pass

func _createFlowerpot(pos):
	#Load scene Ref
	flowerPotReference = preload("res://Scenes/Game/Flowerpot.tscn")
	var flowerpotInstance = flowerPotReference.instantiate()
	
	flowerpotInstance.position = pos
#	flowerpotInstance.position = Vector2(32,32)
	get_parent().add_child(flowerpotInstance)
	emit_signal("create_flowerpot",flowerpotInstance);


func _on_spawn_area_0_on_click(spawnArea,pos):
	currentSpawnPoint = spawnArea
	_createFlowerpot(pos)
