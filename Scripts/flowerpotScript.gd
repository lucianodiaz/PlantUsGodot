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

var selected:bool = false
var defaultPosition
var lastPosition
var newPosition
var move = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#_createPlant()
	_setPotSelected()
	defaultPosition = self.position
	lastPosition = self.position
	newPosition = self.position
	pass
	
func _process(delta):
	movePot()
	
func movePot():
	if selected:
		self.position = get_viewport().get_mouse_position()
		newPosition = get_viewport().get_mouse_position()

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
	_plantInstance.plant_selected.connect(_on_selected_plant)
func removePlant():
	_plantInstance.plant_selected.disconnect(_on_selected_plant)
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
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if !_plantInstance && global.cantSeeds > 0:
			_createPlant()
			global.useSeed()
		else:
			if !selected:
				#_on_selected_plant()
				selected = true
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		selected = false
		if !_plantInstance:return
		if move:
			self.position = newPosition
			lastPosition = newPosition
		else:
			var tween:Tween = get_tree().create_tween()
			tween.tween_property(self, "position", lastPosition, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			newPosition = self.position
			tween.play()
			await (tween.finished)
		if _plantInstance.getName() != "":
			_on_selected_plant()


func _on_area_2d_body_entered(body):
	var area:SpawnArea = body as SpawnArea
	if area:
		move = true
		print("is in area")
	else:
		move = false
		print("is not in area")


func _on_area_2d_area_entered(area):
	var a:SpawnArea = area as SpawnArea
	if a:
		move = true
		print("is in area")
	else:
		move = false
		print("is not in area")


func _on_area_2d_area_exited(area):
		move = false
		print("is not in area")
