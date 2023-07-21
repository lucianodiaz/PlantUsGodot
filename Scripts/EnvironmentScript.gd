extends Node

var flowerPotReference: PackedScene;
var currentSpawnPoint

signal create_flowerpot

# Called when the node enters the scene tree for the first time.
func _ready():
	# _createFlowerpot();
	pass

func _createFlowerpot():
	#Load scene Ref
	flowerPotReference = preload("res://Scenes/Game/Flowerpot.tscn")
	
	var flowerpotInstance = flowerPotReference.instantiate()
	flowerpotInstance.position = currentSpawnPoint.position
#	flowerpotInstance.position = Vector2(32,32)
	add_child(flowerpotInstance)
	emit_signal("create_flowerpot",flowerpotInstance);


func _on_spawn_area_0_on_click(spawnArea):
	currentSpawnPoint = spawnArea
	_createFlowerpot()

func _on_spawn_area_1_on_click(spawnArea):
	currentSpawnPoint = spawnArea
	_createFlowerpot()

func _on_spawn_area_2_on_click(spawnArea):
	currentSpawnPoint = spawnArea
	_createFlowerpot()
