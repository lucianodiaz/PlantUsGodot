extends Node2D

@onready var global = get_node("/root/PlayerInfoScript")

var potSprite:Sprite2D
var middlePosition:Vector2
var _isAnimating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	potSprite = get_node("Control/flowerpot")
	var texture = load(global.getCurrentPot())
	potSprite.changeTexture(texture)
	middlePosition = potSprite.position



func onFinishMove():
	var texture = load(global.getCurrentPot())
	potSprite.changeTexture(texture)

	

func moveRightToLeft():
	onFinishMove()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	var rightMarker = get_node("Control/rightMarker")
	potSprite.position = rightMarker.position
	tween.tween_property(potSprite,"position",middlePosition,0.2)
	tween.is_queued_for_deletion()
	_isAnimating = false

func moveLeftToRight():
	onFinishMove()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	var leftMarker = get_node("Control/leftMarker")
	potSprite.position = leftMarker.position
	tween.tween_property(potSprite,"position",middlePosition,0.2)
	tween.is_queued_for_deletion()
	_isAnimating = false


func _on_left_button_down():
	if _isAnimating : return
	global._prevPot()
	_isAnimating = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	var leftM = get_node("Control/leftMarker")
	tween.tween_property(potSprite,"position",leftM.position,0.2)
	tween.tween_callback(moveRightToLeft)
	pass # Replace with function body.


func _on_right_button_down():
	if _isAnimating : return
	global._nextPot()
	_isAnimating = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	var rightM = get_node("Control/rightMarker")
	tween.tween_property(potSprite,"position",rightM.position,0.2)
	tween.tween_callback(moveLeftToRight)
	pass # Replace with function body.
