extends Node2D
@export var particle:GPUParticles2D
@export var _timesShake = 3
@export var _pencilRotation = 160
var _enterLastTween = false
var _isBaseClicked = false
var _isCoverClicked = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shakePencil():
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	for n in _timesShake:
		tween.tween_property($pencilBase,"rotation",deg_to_rad(15),0.2)
		tween.tween_property($pencilBase,"rotation",deg_to_rad(-15),0.2)
	tween.tween_property($pencilBase,"rotation",deg_to_rad(0),0.2)
	tween.is_queued_for_deletion()

func _on_pencil_base_input_event(viewport, event, shape_idx):
	
	if(!_isCoverClicked):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_isBaseClicked = true
			print("make sound of seeds and shake pencil")
			shakePencil()
	elif _isCoverClicked:
		if !_enterLastTween:
			if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				print("rotate pencil only when cover is get out")
				_enterLastTween = true
				rotatePencil()

func rotatePencil():
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($pencilBase,"rotation",deg_to_rad(_pencilRotation),0.4)
	tween.is_queued_for_deletion()
	tween.tween_callback(startSeeds)
	
func startSeeds():
	particle.emitting = true
	var timer:Timer = get_node("Timer")
	timer.set_one_shot(true)
	timer.start()
	

func _on_cover_pencil_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if (_isBaseClicked):
			_isCoverClicked = true
			print("remove cover")


func _on_timer_timeout():
	print("Change Level")
	var global = get_node("/root/PlayerInfoScript")
	global._changeLevel(1)
#	print(get_tree().root.get_child(0)._changeLevel(1))
	
