extends Node

var flowerPotReference: PackedScene;


# Called when the node enters the scene tree for the first time.
func _ready():
	_createFlowerpot();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _createFlowerpot():
	#Load scene Ref
	flowerPotReference = preload("res://Scenes/Game/Flowerpot.tscn")
	
	var flowerpotInstance = flowerPotReference.instantiate()
	var spawnPoint = get_node("spawnPoint");
	flowerpotInstance.position = spawnPoint.position
#	flowerpotInstance.position = Vector2(32,32)
	add_child(flowerpotInstance)
