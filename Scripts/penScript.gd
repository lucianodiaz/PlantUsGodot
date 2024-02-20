extends Node2D
@export var particle:GPUParticles2D
@export var _animationPlayer:AnimationPlayer

var _enterLastTween = false
var _isBaseClicked = false
var _isCoverClicked = false

@export var _cant_seeds = 10

@export var _type_seeds:seeds_type.seedType

# Called when the node enters the scene tree for the first time.
func _ready():
	if !_animationPlayer.is_playing():
		_animationPlayer.play("enter")

func _idleAnimation():
	pass
	#_animationPlayer.play("idle")

func shakePencil():
	_animationPlayer.play("shake")

func _on_pencil_base_input_event(viewport, event, shape_idx):
	if(!_isCoverClicked):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_isBaseClicked = true
			shakePencil()
	elif _isCoverClicked:
		if !_enterLastTween:
			if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				_enterLastTween = true
				if !_animationPlayer.is_playing():
					_animationPlayer.play("rotate")

	
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
	var global:PlayerInfoScript = get_node("/root/PlayerInfoScript")
	global._addSeeds(_cant_seeds,_type_seeds)
	
	global._changeLevel(global.Levels.POTSEL)
	
