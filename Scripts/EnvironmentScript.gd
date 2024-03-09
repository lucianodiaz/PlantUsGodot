extends Node

var flowerPotReference: PackedScene;
var currentSpawnPoint:Area2D
@export var windowEnv:WindowEnviroment
var mainClass:Main
signal create_flowerpot

# Called when the node enters the scene tree for the first time.
func _ready():
	# _createFlowerpot();
	mainClass = get_parent()
	windowEnv.connect("on_touch_window",_on_touch_window)
	pass

func _on_touch_window():
	mainClass.setLightEnvironment(windowEnv.isOpen)

func _createFlowerpot(pos):
	#Load scene Ref
	print(mainClass.srcPot)
	flowerPotReference = load(mainClass.srcPot)
	var flowerpotInstance = flowerPotReference.instantiate()
	
	flowerpotInstance.position = pos
#	flowerpotInstance.position = Vector2(32,32)
	get_parent().add_child(flowerpotInstance)
	emit_signal("create_flowerpot",flowerpotInstance);
	mainClass.srcPot = ""
	mainClass.canPutPot = false


func _on_spawn_area_0_on_click(spawnArea,pos):
	if mainClass.canPutPot:
		currentSpawnPoint = spawnArea
		_createFlowerpot(pos)
