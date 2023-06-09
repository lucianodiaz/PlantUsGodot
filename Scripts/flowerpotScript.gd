extends Node

const OFFSET_Y = 125
var plantReference: PackedScene;
var _plantInstance;
signal clicked
signal plantDead
# Called when the node enters the scene tree for the first time.
func _ready():
	_createPlant()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#plantDead.connect(_on_plantDead)
	pass

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

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("clicked",_plantInstance)


func _on_plant_dead():
	_plantInstance.visible = false
