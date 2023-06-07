extends Node

const OFFSET_Y = 125
var plantReference: PackedScene;


# Called when the node enters the scene tree for the first time.
func _ready():
	_createPlant()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _createPlant():
	#Load scene Ref
	plantReference = preload("res://Scenes/Game/Plant.tscn")
	
	var plantInstance = plantReference.instantiate()
	var spawnPointNode = get_node("spawnPoint")
	plantInstance.position = spawnPointNode.position #Vector2(0,plantInstance.position.y-OFFSET_Y)
	add_child(plantInstance,false,Node.INTERNAL_MODE_FRONT)
	#add_child(plantInstance)
